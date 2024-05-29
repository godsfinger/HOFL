#include <QApplication>
#include <QWidget>
#include <QLabel>
#include <QVBoxLayout>

class HOFLWindow : public QWidget {
public:
    HOFLWindow(QWidget *parent = 0) : QWidget(parent) {
        QLabel *label = new QLabel("Hello! I'm HOFL, your helpful holographic AGI for Linux.\nHow can I assist you today?", this);
        QVBoxLayout *layout = new QVBoxLayout(this);
        layout->addWidget(label);
        setLayout(layout);
        setWindowTitle("HOFL - Helpful Overlay For Linux");
        resize(400, 200);
    }
};

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);
    HOFLWindow window;
    window.show();
    return app.exec();
}
