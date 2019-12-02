﻿
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
	ПерваяСтрока = 1;
	ПутьКФайлу   = "";
	КонтрагентСнхронизации = "";
	ПровайдерЗагрузки =  "1C";	
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
	
	// взять из настроек
	//ПровайдерЗагрузки =  "ADO";
	//ПровайдерЗагрузки =  "1C";
	
	//ЭлементыФормы.ПредварительныйПросмотр.Прочитать(ПутьКФайлу, СпособЧтенияЗначенийТабличногоДокумента.Текст);
	
	
	ТабДокумент = ЗагрузкаДанныхИзФайла(ПутьКФайлу, ПровайдерЗагрузки);
	Если ТабДокумент <> Неопределено Тогда		
		
		ЭлементыФормы.ПредварительныйПросмотр.Вывести(ТабДокумент);
		
		//ШрифтЯчейки = Новый Шрифт("Arial", 10); //, Ложь, Ложь, Ложь,Ложь, 100); //имя,размер,полужирный,наклонный,подчеркивание,зачеркивание, Масштаб		
		
		ЭлементыФормы.ПредварительныйПросмотр.Области[0].Шрифт = Новый Шрифт("Arial", 10);		
		
		//ЭлементыФормы.ПредварительныйПросмотр.Область("R17C1:R17C6").Шрифт = ШрифтЯчейки;		
		//ЭлементыФормы.ПредварительныйПросмотр.Область("R26C1").Шрифт = ШрифтЯчейки;

		
		
	КонецЕсли;	
	
КонецПроцедуры

Процедура КнопкаСвязатьНажатие(Элемент)
	// Вставить содержимое обработчика.
КонецПроцедуры

Процедура КнопкаОтвязатьНажатие(Элемент)
	// Вставить содержимое обработчика.
КонецПроцедуры




//======================================================================================================================
// Обработчики кнопок на странице Доп Настройки

Процедура ОсновныеДействияФормыПрофильДалее(Кнопка)
	// Вставить содержимое обработчика.
КонецПроцедуры







//======================================================================================================================
// Обработчики кнопок на странице Обработка
