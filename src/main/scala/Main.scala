import org.apache.spark.sql.SparkSession

object Main {
  def main(args: Array[String]): Unit = {
    // ปิด log verbose
    import org.apache.log4j.{Level, Logger}
    Logger.getLogger("org").setLevel(Level.ERROR)
    Logger.getLogger("akka").setLevel(Level.ERROR)

    val spark = SparkSession.builder()
      .appName("DataIngestionMaster")
      .getOrCreate()

    spark.sparkContext.setLogLevel("ERROR")

    val df = spark.read
      .option("header", "true")
      .option("inferSchema", "true")
      .csv("/opt/spark/data/AAPL.csv")

    println("\n=== AAPL Stock Data ===")
    df.show()

    spark.stop()
  }
}
