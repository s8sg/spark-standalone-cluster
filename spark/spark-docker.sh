#!/bin/sh

# Helper for running Spark in the foreground (to keep docker from tearing down
# the container when the launcher runs

if [ -z "${SPARK_HOME}" ]; then
  echo "SPARK_HOME is not set. If you are running in docker, this should be" \
       "set automatically at build time."
  exit 1
fi

SPARK_CLASS="${SPARK_HOME}"/bin/spark-class
SPARK_ROLE=$1

shift
set -x

case $SPARK_ROLE in
  master)
    SPARK_MASTER_HOST=${SPARK_MASTER_HOST:-0.0.0.0}
    SPARK_MASTER_PORT=${SPARK_MASTER_PORT:-7077}
    SPARK_MASTER_WEBUI_PORT=${SPARK_MASTER_WEBUI_PORT:-8080}

    $SPARK_CLASS org.apache.spark.deploy.master.Master \
      --host "$SPARK_MASTER_HOST" --port "$SPARK_MASTER_PORT" \
      --webui-port "$SPARK_MASTER_WEBUI_PORT" "${@}"
    ;;

  worker)
    SPARK_WORKER_WEBUI_PORT=${SPARK_WORKER_WEBUI_PORT:-8080}
    SPARK_WORKER_CORES=${SPARK_WORKER_CORES:-2}

    $SPARK_CLASS org.apache.spark.deploy.worker.Worker \
      --cores "$SPARK_WORKER_CORES" \
      --webui-port "$SPARK_WORKER_WEBUI_PORT" "${@}"
    ;;

  *)
    echo "Usage: $0 [master|worker] [OPTIONS]..."
    exit 1
    ;;
esac
