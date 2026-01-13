Name:           count-files
Version:        2.0
Release:        1%{?dist}
Summary:        Recursive file counter with config and man page

License:        MIT
URL:            https://github.com/USERNAME/LabNew
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch
Requires:       bash
Requires:       coreutils
Requires:       findutils
Requires:       awk

%description
A Bash script that recursively counts files in a specified directory.
Version 2.0 includes support for a configuration file, verbose mode, 
and a man page.

%prep
%setup -q

%install
# Створення директорій
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_sysconfdir}
mkdir -p %{buildroot}%{_mandir}/man1

# Встановлення файлів
install -m 755 count_files.sh %{buildroot}%{_bindir}/count_files
install -m 644 count_files.conf %{buildroot}%{_sysconfdir}/count_files.conf
install -m 644 count_files.1 %{buildroot}%{_mandir}/man1/count_files.1

%pre
echo "Підготовка до встановлення пакета count-files..."

%post
echo "Пакет count-files успішно встановлено."
echo "Конфігураційний файл доступний за шляхом: /etc/count_files.conf"
echo "Для перегляду документації використовуйте: man count_files"

%files
%{_bindir}/count_files
%config(noreplace) %{_sysconfdir}/count_files.conf
%{_mandir}/man1/count_files.1*

%changelog
* Tue Jan 13 2026 Student KN-231 <yevheniilysenok@gmail.com> - 2.0-1
- Version 2.0: Added config file, verbose mode, man page, and RPM scripts
* Tue Jan 13 2026 Student KN-231 <yevheniilysenok@gmail.com> - 1.0-1
- Initial package release
