Aquí tienes el archivo .bat para crear la estructura de carpetas y archivos que especificaste:
Batch
@echo off

:: Crear carpetas
mkdir lib
mkdir lib\core
mkdir lib\core\errors
mkdir lib\core\usecases
mkdir lib\features
mkdir lib\features\user_management
mkdir lib\features\user_management\data
mkdir lib\features\user_management\data\datasources
mkdir lib\features\user_management\data\models
mkdir lib\features\user_management\data\repositories
mkdir lib\features\user_management\domain
mkdir lib\features\user_management\domain\entities
mkdir lib\features\user_management\domain\repositories
mkdir lib\features\user_management\domain\usecases
mkdir lib\features\user_management\presentation
mkdir lib\features\user_management\presentation\providers
mkdir lib\features\user_management\presentation\pages
mkdir lib\features\user_management\presentation\widgets

:: Crear archivos
type nul > lib\core\errors\failures.dart
type nul > lib\core\usecases\usecase.dart
type nul > lib\features\user_management\data\datasources\user_remote_datasource.dart
type nul > lib\features\user_management\data\models\user_model.dart
type nul > lib\features\user_management\data\repositories\user_repository_impl.dart
type nul > lib\features\user_management\domain\entities\user.dart
type nul > lib\features\user_management\domain\repositories\user_repository.dart
type nul > lib\features\user_management\domain\usecases\get_users.dart
type nul > lib\features\user_management\domain\usecases\create_user.dart
type nul > lib\features\user_management\domain\usecases\update_user.dart
type nul > lib\features\user_management\presentation\providers\user_provider.dart
type nul > lib\features\user_management\presentation\pages\user_list_page.dart
type nul > lib\features\user_management\presentation\widgets\user_card.dart

echo Estructura creada con éxito.
pause
