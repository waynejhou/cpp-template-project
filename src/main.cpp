#include <iostream>
#include <gtkmm.h>
#include "model/sample.h"

using namespace std;

int main(int argc, char **argv)
{
    Sample sampleModel = Sample();
    sampleModel.doSomething();
    auto app = Gtk::Application::create(argc, argv);

    Gtk::Window window;
    window.set_default_size(600, 400);

    Gtk::Box box;
    Gtk::Button btn("Do Something");
    btn.signal_clicked().connect(
        [&sampleModel]() {
            sampleModel.doSomething2();
        });
    window.add(btn);
    btn.show();
    return app->run(window);
}