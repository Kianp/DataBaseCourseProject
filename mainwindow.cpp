#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this) ;

    QSqlDatabase db = QSqlDatabase::addDatabase("QODBC3");
    db.setDatabaseName("DRIVER={SQL SERVER};SERVER=KIAN\\KIAN;DATABASE=ringolastic;Trusted_Connection=True;");
    db.setConnectOptions() ;

    if(!db.open()) {
        qDebug()<<"ERROR: "<<QSqlError(db.lastError()).text();
    }
    else {
        qDebug() << db.tables() ;

        TireModel = new QSqlTableModel(this , db ) ;
        TireModel->setTable("Tires");
        TireModel->select() ;
        ui->tiresTable->setModel(TireModel);

        CarModel = new QSqlTableModel(this , db) ;
        CarModel->setTable("Cars");
        CarModel->select() ;
        ui->carsTable->setModel(CarModel);

        WheelModel = new QSqlTableModel(this , db ) ;
        WheelModel->setTable("Wheels");
        WheelModel->select() ;
        ui->wheelsTable->setModel(WheelModel);

    }
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_InsertCar_clicked()
{
    QSqlQuery q ;
    q.prepare("insert into Cars Values(:Brand , :Model , :Year)") ;
    q.bindValue(":Brand" , ui->BrandFieldCar->text());
    q.bindValue(":Model" , ui->ModelFieldCar->text());
    q.bindValue(":Year" , ui->yearFiledCar->value());

    q.exec() ;
    CarModel->select() ;
    CarModel->submitAll() ;

//    QSqlRecord rec(CarModel->record()) ;
//    rec.setValue(0 , ui->BrandFieldCar->text());
//    rec.setValue(1 , ui->ModelFieldCar->text());
//    rec.setValue(2 , ui->yearFiledCar->value());
//    CarModel->insertRecord( -1 , rec) ;


}

void MainWindow::on_InsertWheel_clicked()
{
    QSqlQuery q ;
    q.prepare("insert into Wheels ( Name , Country , SdutCount , PitchCircleDiametre , RimWidth , RimSize , Model , Brand , Price ) Values(:Name , :Country , :SdutCount , :PitchCircleDiametre, :RimWidth , :RimSize,  :Model , :Brand , :Price) ")  ;
    q.bindValue(":Name" , ui->NameFieldWheel->text() );
    q.bindValue(":PitchCircleDiametre" , ui->PitchCircleDiametreFiledWheel->value() );
    q.bindValue(":RimWidth" , ui->rimWidthFiledWheel->value() );
    q.bindValue(":RimSize" , ui->rimSizeFiledWheel->value() );
    q.bindValue(":SdutCount" , ui->studCountFiledWheel->value() ) ;
    q.bindValue(":Country" , ui->CountryFieldWheel->text() ) ;
    q.bindValue(":Model" , ui->ModelFieldWheel->text() );
    q.bindValue(":Brand" , ui->BrandFieldWheel->text() );
    q.bindValue(":Price" , ui->PriceFieldWheel->value() );

    q.exec() ;
    WheelModel->select() ;
    WheelModel->submitAll() ;
}
