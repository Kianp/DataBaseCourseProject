#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QtSql/QSqlDatabase>
#include <QSqlError>
#include <QDebug>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlTableModel>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    QSqlTableModel* TireModel ;
    QSqlTableModel* CarModel ;
    QSqlTableModel* WheelModel ;
    ~MainWindow();

private slots:
    void on_InsertCar_clicked();
    void on_InsertWheel_clicked();
    void on_ToUpdateCare_clicked();
    void on_toInsertCar_clicked();
    void on_ToDeleteCar_clicked();
    void on_pushButton_clicked();
    void on_AffectedRowDeleteCar_valueChanged(int arg1);
    void on_UpdateCar_clicked();
    void on_AffectedRowUpdateCar_valueChanged(int arg1);

    void on_DeleteCar_clicked();

private:
    Ui::MainWindow *ui;
};

#endif // MAINWINDOW_H
