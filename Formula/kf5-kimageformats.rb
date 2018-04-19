class Kf5Kimageformats < Formula
  desc "Image format plugins for Qt5"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.45/kimageformats-5.45.0.tar.xz"
  sha256 "d79feea60a3b0e9f73347b7b65361c3304a533edcd389efc4b5c9b222fcdac4d"

  head "git://anongit.kde.org/kimageformats.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-karchive" => :optional
  depends_on "qt"
  depends_on "openexr"
  depends_on "jasper"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
     EOS
  end
end