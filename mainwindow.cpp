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



void MainWindow::on_InsertWheel_clicked()
{
    QSqlQuery q ;
    q.prepare("insert into Wheels ( Name , Country , SdutCount , PitchCircleDiametre , RimWidth , RimSize , Model , Brand , Price ) Values(:Name , :Country , :SdutCount , :PitchCircleDiametre, :RimWidth , :RimSize,  :Model , :Brand , :Price) ")  ;
    q.bindValue(":Name" , ui->NameFieldWheel->text() );
    q.bindValue(":PitchCircleDiametre" , ui->PitchCircleDiametreFiledWheel->value() ) ;
    q.bindValue(":RimWidth" , ui->rimWidthFiledWheel->value() ) ;
    q.bindValue(":RimSize" , ui->rimSizeFiledWheel->value() ) ;
    q.bindValue(":SdutCount" , ui->studCountFiledWheel->value() ) ;
    q.bindValue(":Country" , ui->CountryFieldWheel->text() ) ;
    q.bindValue(":Model" , ui->ModelFieldWheel->text() ) ;
    q.bindValue(":Brand" , ui->BrandFieldWheel->text() ) ;
    q.bindValue(":Price" , ui->PriceFieldWheel->value() ) ;

    q.exec() ;
    WheelModel->select() ;
    WheelModel->submitAll() ;
}





void MainWindow::on_AffectedRowDeleteCar_valueChanged(int arg1)
{
    ui->carsTable->selectRow(arg1);
}


/* ---------------------------- CAR SLOTS ----------------------------------- */


void MainWindow::on_InsertCar_clicked()
{
    QSqlQuery q ;
    q.prepare("insert into Cars Values(:Brand , :Model , :Year)") ;
    q.bindValue(":Brand" , ui->BrandFieldCar->text() ) ;
    q.bindValue(":Model" , ui->ModelFieldCar->text() ) ;
    q.bindValue(":Year" , ui->yearFiledCar->value()  ) ;
    q.exec() ;
    CarModel->select() ;
    CarModel->submitAll() ;
}


void MainWindow::on_AffectedRowUpdateCar_valueChanged(int arg1)
{
//    QSqlRecord r ;
//    r = CarModel->record(arg1) ;
//    ui->ModelFieldCar_Update->setText();
//    Should also map vaues into fileds to ease Update

    ui->carsTable->selectRow(arg1) ;
}

void MainWindow::on_UpdateCar_clicked()
{
    QSqlQuery q ;
    q.prepare("UPDATE Cars Set Brand=:Brand, Model=:Model, Year=:Year Where Id=:Id") ;
    q.bindValue(0 , ui->BrandFieldCar_Update->text() );
    q.bindValue(1 , ui->ModelFieldCar_Update->text() );
    q.bindValue(2 , QString::number(ui->yearFiledCar_Update->value()) );
    q.bindValue(3 , CarModel->record(ui->AffectedRowUpdateCar->value()).value("Id"));
    q.exec() ;

    CarModel->select() ;
    CarModel->submitAll() ;
}


void MainWindow::on_DeleteCar_clicked()
{
    QSqlQuery q ;
    q.prepare("DELETE from Cars Where Id=:Id") ;
    q.bindValue(0 , CarModel->record(ui->AffectedRowDeleteCar->value()).value("Id")) ;

    q.exec() ;

    CarModel->select() ;
    CarModel->submitAll() ;
}






/* ------------------------------ NAVIGATION SLOTS --------------------------------- */

void MainWindow::on_ToUpdateCare_clicked()
{
    ui->stackedWidgetCar->setCurrentIndex(1);
}

void MainWindow::on_toInsertCar_clicked()
{
    ui->stackedWidgetCar->setCurrentIndex(0);
}

void MainWindow::on_ToDeleteCar_clicked()
{
    ui->stackedWidgetCar->setCurrentIndex(2);
}

void MainWindow::on_pushButton_clicked()
{
    ui->stackedWidgetCar->setCurrentIndex(1);
}
