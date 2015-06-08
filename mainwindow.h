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

private:
    Ui::MainWindow *ui;
};

#endif // MAINWINDOW_H
