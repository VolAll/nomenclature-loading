﻿Перем гСохраненнаяНастройка Экспорт;

////////////////////////////////////////////////////////////////////////////////
//
// Процедура ЗагрузкаДанныхИзФайла(ПутьКФайлу, ПровайдерЗагрузки);
//
// Описание:
//
//
// Параметры (название, тип, дифференцированное значение)
//
Функция ЗагрузкаДанныхИзФайла(СтрПутьКФайлу, ПровайдерЗагрузки) Экспорт
	
	ТабличныйДокумент = Неопределено;
	
	СообщениеОшибки = "";	
	Если Не ПроверитьСкопироватьФайл(СтрПутьКФайлу, СообщениеОшибки) Тогда
		Сообщить(СообщениеОшибки, СтатусСообщения.Важное);
		Возврат ТабличныйДокумент;
	КонецЕсли;
			
	Если ПровайдерЗагрузки = "ADO"  Тогда
		
	ИначеЕсли ПровайдерЗагрузки = "1C"  Тогда
		
		ТабличныйДокумент = Новый ТабличныйДокумент;
		ТабличныйДокумент.Прочитать(СтрПутьКФайлу, СпособЧтенияЗначенийТабличногоДокумента.Текст);	
		
		Возврат ТабличныйДокумент;
		
	Иначе // Простой Excel	
		
	КонецЕсли; 	
    
КонецФункции

Функция ПроверитьСкопироватьФайл(СтрПутьКФайлу, СообщениеОшибки)
	
	Если НЕ ЗначениеЗаполнено(СтрПутьКФайлу) Тогда
		СообщениеОшибки = "Не указан путь до файла";
		Возврат Ложь;
	КонецЕсли;
	
	ФайлНаДиске = Новый Файл(СтрПутьКФайлу);
	Если ФайлНаДиске.Существует() Тогда
		
		//{[+](фрагмент ДОБАВЛЕН), Волокитин Александр Сергеевич 02.12.2019 14:19:26
		// Для работы в терминале ускоряем работу
		// скопируем с клиента в терминал.
		Если Найти(СтрПутьКФайлу,"\\tsclient") > 0 Тогда
		
			//если файл находится на удаленном компе - скопируем во временную папку локально
			Расширение = РаботаСФайлами.ПолучитьРасширениеФайла(СтрПутьКФайлу);
			//ИмяФайлаДляЗагрузки = КаталогВременныхФайлов()+"\"+Строка(Новый УникальныйИдентификатор())+"."+Расширение;
			// при закрытии 1с все временные файлы стираются.
			ИмяФайлаДляЗагрузки = ПолучитьИмяВременногоФайла(Расширение);
			КопироватьФайл(СтрПутьКФайлу, ИмяФайлаДляЗагрузки);
			СтрПутьКФайлу = ИмяФайлаДляЗагрузки;
			
		КонецЕсли;
		
		Возврат Истина;
		
	Иначе
		СообщениеОшибки = "Файл не найден по пути:" + СтрПутьКФайлу;
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции


Функция ПреобразоватьВЧисло(ЧислоИсх) Экспорт
	Если ЗначениеЗаполнено(ЧислоИсх) Тогда
		Попытка
			Знч = Число(ЧислоИсх);
		Исключение
			Знч = 0;
		КонецПопытки;
		Возврат(Знч);
	Иначе
		Возврат 0;
	КонецЕсли;	
КонецФункции

// Выводит сообщение об ошибке и выставляет параметр Отказ в "Истина". 
// В случае работы на клиенте или на сервере выводит в окно сообщений,
// в случае внешнего соединения вызывает исключение.
//
// Параметры:
//  ТекстСообщения - строка, текст сообщения.
//  Отказ          - булево, признак отказа (необязательный).
//
Процедура мСообщитьОбОшибке(ТекстСообщения, Отказ = Ложь, Заголовок = "") Экспорт

	НачалоСлужебногоСообщения    = Найти(ТекстСообщения, "{");
	ОкончаниеСлужебногоСообщения = Найти(ТекстСообщения, "}:");
	Если ОкончаниеСлужебногоСообщения > 0 И НачалоСлужебногоСообщения > 0 Тогда
		ТекстСообщения = Лев(ТекстСообщения, (НачалоСлужебногоСообщения - 1)) +
		                 Сред(ТекстСообщения, (ОкончаниеСлужебногоСообщения + 2));
	КонецЕсли;
	
	Отказ = Истина;
	
	Если ЗначениеЗаполнено(Заголовок) Тогда
		Сообщить(Заголовок);
		Заголовок = "";
	КонецЕсли;
	
	Сообщить(ТекстСообщения, СтатусСообщения.Важное);
	
КонецПроцедуры // ОбщегоНазначения.СообщитьОбОшибке()