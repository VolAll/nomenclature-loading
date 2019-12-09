﻿Перем мМетаНоменклатура;

//======================================================================================================================
// Обработчики формы

Процедура ПередОткрытием(Отказ, СтандартнаяОбработка)
	//{[+](фрагмент ДОБАВЛЕН), Волокитин Александр Сергеевич 02.12.2019 14:47:33
	// не забыть убрать комментарий.
	//Отказ = НЕ КонтрольПрав.ПравоДоступа_Просмотр(ЭтотОбъект);
КонецПроцедуры

Процедура ПриОткрытии()
	Инициализировать();	
КонецПроцедуры

Процедура Инициализировать()
	//{[+](фрагмент ДОБАВЛЕН), Волокитин Александр Сергеевич 02.12.2019 14:47:33
	// не забыть убрать.
	ПерваяСтрока = 2;
	ПутьКФайлу   = "C:\Users\vas\Desktop\Загрузка номенклатуры.xls";
	
	гСограненнаяНастройка = "";
	мМетаНоменклатура = Метаданные.Справочники.Номенклатура;
	КонтрагентСнхронизации = "";
	ПровайдерЗагрузки =  "1C";	
	ПервичнаяНастройка();
	
	ОтборЗагрузка = ЭлементыФормы.СоответствиеКолонок.ОтборСтрок.Загружать;
	ОтборЗагрузка.ВидСравнения = ВидСравнения.Равно;
	ОтборЗагрузка.Значение		= Истина;
	ОтборЗагрузка.Использование= Истина;
	
	// тест
	ОсновныеДействияФормыПрофильПросмотр(Неопределено);	
	ЗагрузитьДанныеДляОбработки();
	
КонецПроцедуры	


//======================================================================================================================
// Обработчики кнопок на странице Профиль

Процедура ПутьКФайлуНачалоВыбора(Элемент, СтандартнаяОбработка)
	
	ДиалогОткрытияФайла=Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	//ДиалогОткрытияФайла.ПолноеИмяФайла= "";	
	ДиалогОткрытияФайла.Фильтр="Excel(*.xl*)|*.xl*";
	ДиалогОткрытияФайла.МножественныйВыбор = Ложь;
	ДиалогОткрытияФайла.Заголовок = "Выберите файл";
	Если ДиалогОткрытияФайла.Выбрать() тогда
		ПутьКФайлу=ДиалогОткрытияФайла.ПолноеИмяФайла;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОсновныеДействияФормыПрофильПросмотр(Кнопка)
	
	ТабДокумент = ЗагрузкаДанныхИзФайла(ПутьКФайлу, ПровайдерЗагрузки);
	Если ТабДокумент <> Неопределено Тогда
		
		ЭлементыФормы.ПредварительныйПросмотр.Очистить();
		
		ЭлементыФормы.ПредварительныйПросмотр.Вывести(ТабДокумент);
		//Костыль Ошибка отображение у платформы 1С:Предприятие 8.3 (8.3.12.1790)
		ЭлементыФормы.ПредварительныйПросмотр.Области[0].Шрифт = Новый Шрифт("Arial", 10);
	КонецЕсли;
	
КонецПроцедуры

Процедура КнопкаСвязатьНажатие(Элемент)
	ТекущийНомерКолонки = ЭлементыФормы.ПредварительныйПросмотр.ТекущаяОбласть.Лево;
	СвязатьРазвязатьКолонки(ТекущийНомерКолонки, Истина);
КонецПроцедуры

Процедура КнопкаОтвязатьНажатие(Элемент)
	ТекущийНомерКолонки = ЭлементыФормы.ПредварительныйПросмотр.ТекущаяОбласть.Лево;
	СвязатьРазвязатьКолонки(ТекущийНомерКолонки, Ложь);
КонецПроцедуры

Процедура ПредварительныйПросмотрВыбор(Элемент, Область, СтандартнаяОбработка)
	ТекущийНомерКолонки = ЭлементыФормы.ПредварительныйПросмотр.ТекущаяОбласть.Лево;
	СвязатьРазвязатьКолонки(ТекущийНомерКолонки, Истина);
КонецПроцедуры

Процедура ОсновныеДействияФормыПрофильДалее(Кнопка)
	ЭтаФорма.Панель.ТекущаяСтраница = ЭтаФорма.Панель.Страницы.ДопНастройки; 
КонецПроцедуры

Процедура ВостановитьНастройкиНажатие(Элемент)
	СтруктураНастройки = Новый Структура;
	СтруктураНастройки.Вставить("Пользователь", МТИ.ПолучитьЗначениеКонстанты("ПользовательЭлектронныйЗаказчик"));
	СтруктураНастройки.Вставить("ИмяОбъекта", Строка(ЭтотОбъект));
	СтруктураНастройки.Вставить("НаименованиеНастройки", Неопределено);
	
	Результат = УниверсальныеМеханизмы.ВосстановлениеНастроек(СтруктураНастройки);
	Если Результат <> Неопределено Тогда
		
		ПрописатьСтруктуруНастроек(Результат.СохраненнаяНастройка);
		
	КонецЕсли;

КонецПроцедуры

Процедура СохранитьНастройкиНажатие(Элемент)
	
	СохраненнаяНастройка = ПолучитьСтруктуруНастроек();
	
	СтруктураНастройки = Новый Структура;
	СтруктураНастройки.Вставить("Пользователь", МТИ.ПолучитьЗначениеКонстанты("ПользовательЭлектронныйЗаказчик"));
	СтруктураНастройки.Вставить("ИмяОбъекта", Строка(ЭтотОбъект));
	СтруктураНастройки.Вставить("НаименованиеНастройки", Неопределено);
	СтруктураНастройки.Вставить("СохраненнаяНастройка", СохраненнаяНастройка);
	СтруктураНастройки.Вставить("ИспользоватьПриОткрытии", Ложь);
	СтруктураНастройки.Вставить("СохранятьАвтоматически", Ложь);
	
	Результат = УниверсальныеМеханизмы.СохранениеНастроек(СтруктураНастройки);

КонецПроцедуры



Функция ПолучитьСтруктуруНастроек()
	
	ИменаИсключения =  Новый Соответствие();
	ИменаИсключения.Вставить("НаименованиеНастройки");
	
	СтруктураСохранения = Новый Структура;
	
	КолРеквизитов  = ЭтотОбъект.Метаданные().Реквизиты;
	Для каждого ЭлРеквизит Из КолРеквизитов Цикл
		
		Если ИменаИсключения.Получить(ЭлРеквизит.Имя) = Неопределено Тогда
			СтруктураСохранения.Вставить(ЭлРеквизит.Имя, ЭтотОбъект[ЭлРеквизит.Имя]);
		КонецЕсли;
		
	КонецЦикла;
	
	СтруктураСохранения.Вставить("НастройкиПоиска", ЗначениеВСтрокуВнутр(НастройкиПоиска.Выгрузить() ) );	
	
	Возврат СтруктураСохранения;
	
КонецФункции

Процедура ПрописатьСтруктуруНастроек(СохраненнаяНастройка)
	
	КолРеквизитов  = ЭтотОбъект.Метаданные().Реквизиты;
	
	Для каждого ЭлРеквизит Из КолРеквизитов  Цикл
		
		СохраненнаяНастройка.Свойство(ЭлРеквизит.Имя, ЭтотОбъект[ЭлРеквизит.Имя]);
		
	КонецЦикла;		

	СтрНастройкиПоиска = "";
	Если СохраненнаяНастройка.Свойство("НастройкиПоиска", СтрНастройкиПоиска) Тогда
		
		мТаблица = ЗначениеИзСтрокиВнутр(СтрНастройкиПоиска);
		Если ТипЗнч(мТаблица) = Тип("ТаблицаЗначений") Тогда
			НастройкиПоиска.Загрузить(мТаблица);
		КонецЕсли;	
		
	КонецЕсли;	
	
КонецПроцедуры







Процедура СвязатьРазвязатьКолонки(ТекущийНомерКолонки, ДействиеСвязать)
	
	мТекСтрокаКолонки = ЭлементыФормы.СоответствиеКолонок.ТекущаяСтрока;
	Если ДействиеСвязать Тогда
		// нужно проверить а не связанно ли в других колонках текущая.
		мТекСтрокаКолонки.НомерКолонки = ТекущийНомерКолонки;
	Иначе 
		мТекСтрокаКолонки.НомерКолонки = 0;
	КонецЕсли;
	
КонецПроцедуры




//======================================================================================================================
// Обработчики кнопок на странице Доп Настройки


Процедура КоманднаяПанель2ЗаполнитьОсновныеРеквизиты(Кнопка)
	
	ПервичнаяНастройка();	
	
КонецПроцедуры

Процедура НастройкиПоискаПриИзмененииФлажка(Элемент, Колонка)
	
КонецПроцедуры

Процедура ОсновныеДействияФормы1ОсновныеДействияФормыВыполнить(Кнопка)
	ЭтаФорма.Панель.ТекущаяСтраница = ЭтаФорма.Панель.Страницы.Обработка; 
	ЗагрузитьДанныеДляОбработки();
КонецПроцедуры






Процедура ПервичнаяНастройка(ПолныйСостав = Ложь)
		
	НастройкиПоиска.Очистить();
	
	РекНоменклатура = мМетаНоменклатура.Реквизиты;
	
	СписокРеквизитИспользования = ПолучитьЗаготовкиНастроек(ПолныйСостав);
	
	Для каждого Реквизит Из РекНоменклатура Цикл
		
		ТекНастройка = СписокРеквизитИспользования.Найти(Реквизит.Имя, "Наименование");
		
		Если ТекНастройка <> Неопределено Тогда
			
			СтрокаНастройкиПоиска = НастройкиПоиска.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаНастройкиПоиска,	ТекНастройка);
			
		КонецЕсли;
		
	КонецЦикла;

КонецПроцедуры

Функция ПолучитьЗаготовкиНастроек(ПолныйСостав)
	// СоздадимТаблицуНастроек для хранения начальных данных.
	// для редактирования данных в любых ситуациях
	
	ТаблицаНачальныхДанных = НастройкиПоиска.Выгрузить(); 	
	ТаблицаНачальныхДанных.Очистить();		 
	
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"Артикул","Справочники.Номенклатура.НайтиПоРеквизиту(""Артикул"", ДанныеЯчейки)", Ложь, Ложь);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"НаименованиеПолное",			"", Истина, Истина);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"НоменклатурнаяГруппа",		"", Истина);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"НомерГТД",					"", Ложь);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ОсновнойПоставщик",			"", Ложь);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ОтветственныйМенеджерЗаПокупки","",Ложь);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"СтавкаНДС",					"", Истина, ,Перечисления.СтавкиНДС.НДС20);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"СтранаПроисхождения",			"", Ложь, Ложь,  Справочники.КлассификаторСтранМира.Россия);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ЦеноваяГруппа",				"", Истина);
	
	//ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ДополнительноеОписаниеНоменклатуры","", Истина);
	
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"БазоваяЕдиницаИзмерения",		"", Истина, , Справочники.КлассификаторЕдиницИзмерения.НайтиПоКоду(""));
	
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"АртикулПроизводителя",		"", Истина);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"Дубликат",					"", Истина, Истина);
	
	//ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"КатегорияПродаж","", Ложь);
	
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"НомерПоКаталогу",				"", Истина, Истина);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"КоличествоВУпаковке",			"", Ложь);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"Сертификат",					"", Ложь);
	//ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"АльтернативнаяГруппа","", Истина);
	//ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ПоисковыеТеги","", Истина);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"КратностьОтгрузки",			"", Ложь);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ПроизводительПоКаталогу",		"", Истина);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"Бренд",						"Справочники.Бренды.НайтиПоНаименованию(ДанныеЯчейки)", Истина, Истина); 
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"АртикулБренда",				"", Истина, Истина);
	
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"Производитель",				"", Истина);
	//ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"КодТНВЭД","", Истина);
	
	// подумать как к
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"Код",							"Справочники.Номенклатура.НайтиПоКоду(ДанныеЯчейки)", Ложь);
	ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"Наименование",				"", Ложь);
	
	
	
	Если ПолныйСостав Тогда
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"СтатьяЗатрат",					"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"Весовой", 						"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ВестиПартионныйУчетПоСериям", 	"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ВестиУчетПоСериям", 				"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ВестиУчетПоХарактеристикам", 		"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ЕдиницаДляОтчетов", 				"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ЕдиницаХраненияОстатков", 		"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"Комментарий", 					"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"Набор", 							"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ОсновноеИзображение", 			"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"Услуга",							"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"НоменклатурнаяГруппаЗатрат",		"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ВестиСерийныеНомера", 			"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"Комплект", 						"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ЕдиницаИзмеренияМест", 			"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"АлкогольнаяПродукция", 			"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ОбъемДАЛ", 						"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"АртикулДляПодбора", 				"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"КодИ", 							"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"КодЭЗ", 							"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ОсновнойШтрихКод", 				"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ПозицияДляГруппировки", 			"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"КатегорияНоменклатуры", 			"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ВесовойКоэффициентВхождения", 	"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ВидАлкогольнойПродукцииЕГАИС", 	"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"Крепость", 						"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ИмпортнаяАлкогольнаяПродукция", 	"", Ложь);
		ДобавитьСтрокуНачальныеДанные(ТаблицаНачальныхДанных,"ПроизводительИмпортерАлкогольнойПродукции", "", Ложь);
	КонецЕсли;	
	
	Возврат ТаблицаНачальныхДанных;
	
КонецФункции

Процедура ДобавитьСтрокуНачальныеДанные(мТаблицаНачальныхДанных, мНаименование, мНастройкиПоиска = "", мИспользоватьРеадактирование = Ложь, мЗагружать = Ложь, мЗначениеПоУмолчанию = Неопределено)
	
	НоваяСтрока =  мТаблицаНачальныхДанных.Добавить();
	
	НоваяСтрока.Наименование    			= мНаименование;
	НоваяСтрока.НастройкиПоиска 			= мНастройкиПоиска;
	НоваяСтрока.ИспользоватьРеадактирование = мИспользоватьРеадактирование;	
	НоваяСтрока.Загружать 					= мЗагружать;
	Если ЗначениеЗаполнено(мЗначениеПоУмолчанию) Тогда
		НоваяСтрока.ЗначениеПоУмолчанию 		= мЗначениеПоУмолчанию;
	Иначе 
		// установить тип данных для значения... в элементеФормы.
		//ТипДанныхКолонки = ПолучитьТипРеквизита(мНаименование);
		//НоваяСтрока.ЗначениеПоУмолчанию = ТипДанныхКолонки; 
		
	КонецЕсли;
	
	
КонецПроцедуры	




//======================================================================================================================
// Обработчики кнопок на странице Обработка

Процедура ЗагрузитьДанныеДляОбработки()
	
	
	СоздатьКолонкиВТЧДанные();
	
	ТабличныйДокумент = ЭлементыФормы.ПредварительныйПросмотр;
	
	Если НастройкиПоиска.НайтиСтроки(Новый Структура("Загружать", Истина)).Количество() = 0 Тогда
		Предупреждение("Не отмечено колонок для загрузки!");
		Возврат;
	КонецЕсли;
	
	КоличествоЭлементов = ТабличныйДокумент.ВысотаТаблицы - ПерваяСтрока + 1;
	Если КоличествоЭлементов <= 0 Тогда
		Предупреждение("Нет данных для конвертации.");
		Возврат;
	КонецЕсли;
		
		
	Данные.Очистить();
	
	Для К = ПерваяСтрока По ТабличныйДокумент.ВысотаТаблицы Цикл	
		
		ДобавитьИЗаполненияСтрокуДанных(ТабличныйДокумент, К);
		
	КонецЦикла;	
	
КонецПроцедуры 

//======================================================================================================================
// ТабличныйДокумент - документ откуда будут подгружатся данные 
// НомерСтроки - номер стоки ТабличныйДокумента которая будет анализироваться
// СтрокаДанных - стока таблицы Данные куда будут заносится значение ил Табличного документа
//
Процедура ДобавитьИЗаполненияСтрокуДанных(ТабличныйДокумент, НомерСтроки)
	
	// Все данные по стороке
	ТекстыЯчеек = Новый Массив;
	ТекстыЯчеек.Добавить(Неопределено);
	Для СчетчикЯчейки = 1 По ТабличныйДокумент.ШиринаТаблицы Цикл
		ТекстыЯчеек.Добавить(СокрЛП(ТабличныйДокумент.Область(НомерСтроки, СчетчикЯчейки).Текст));
	КонецЦикла;
	
	
	Результат 	 = "";
	ДанныеЯчейки = "";
	Запрос = Новый Запрос();	
	
	// странно но добавляем строку в ТЧ Данные.
	СтрокаДанных = Данные.Добавить();

		
	Для каждого СтрокаСопоставления Из НастройкиПоиска Цикл
		
		
		Если СтрокаСопоставления.Загружать
			И СтрокаСопоставления.НомерКолонки > 0 Тогда
			
						
			Результат 	 = ТекстыЯчеек[СтрокаСопоставления.НомерКолонки];
			ДанныеЯчейки = Результат;
			
			Запрос.УстановитьПараметр("ДанныеЯчейки", ДанныеЯчейки);
			
			Если СокрЛП(СтрокаСопоставления.НастройкиПоиска) = "" Тогда
				
				Если ЗначениеЗаполнено(СтрокаСопоставления.ЗначениеПоУмолчанию)  Тогда
					СтрокаДанных[СтрокаСопоставления.Наименование] = СтрокаСопоставления.ЗначениеПоУмолчанию;
				Иначе
					СтрокаДанных[СтрокаСопоставления.Наименование] = Результат;
				КонецЕсли;
				
			Иначе
				
				Попытка
					РезВычисления = Вычислить(СтрокаСопоставления.НастройкиПоиска);
				Исключение
				    Сообщить(ОписаниеОшибки());
				КонецПопытки;
				
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры






Процедура СоздатьКолонкиВТЧДанные()
	
	Данные.Колонки.Очистить();
	
	Для каждого СтрокаНастройки Из НастройкиПоиска Цикл
		Если СтрокаНастройки.ИспользоватьРеадактирование Тогда
			ТипДанныхКолонки = ПолучитьТипРеквизита(СтрокаНастройки.Наименование);
			ШиринаКолонки = ПолучитьШиринуКолонки(ТипДанныхКолонки);
			Данные.Колонки.Добавить(СтрокаНастройки.Наименование, ТипДанныхКолонки,СтрокаНастройки.Наименование,ШиринаКолонки)
		КонецЕсли;	
	КонецЦикла;
	
	ЭлементыФормы.Данные.СоздатьКолонки();
	
КонецПроцедуры //СоздатьКолонкиДанные

Функция ПолучитьТипРеквизита(НаименованиеРеквизита)
	
	Попытка
		Результат = мМетаНоменклатура.Реквизиты.Найти(НаименованиеРеквизита).Тип;
	Исключение
	    Результат = Новый ОписаниеТипов("Строка",,,,Новый КвалификаторыСтроки(25)); 
	КонецПопытки;	
	
	Возврат Результат;	
КонецФункции

Функция ПолучитьШиринуКолонки(ТипДанныхКолонки)
	
	Если гСограненнаяНастройка = "" Тогда
		// Без расчета  по максимальной дринны экрана.
		Если ТипДанныхКолонки.СодержитТип(Тип("Строка")) Тогда
			Если ТипДанныхКолонки.КвалификаторыСтроки.Длина = 0 Тогда
				Результат = 100;
			Иначе 	
				Результат = Мин(ТипДанныхКолонки.КвалификаторыСтроки.Длина, 80);
			КонецЕсли;
		ИначеЕсли ТипДанныхКолонки.СодержитТип(Тип("Число")) Тогда
			Результат = 70;
		Иначе
			Результат = 30;
		КонецЕсли;
	Иначе 
		// попытаемся востановить из сохраненных настроек
		
	КонецЕсли;
	
	
	
	Возврат Результат;
КонецФункции






