package main;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Date;
import java.util.Locale;

public class functions {

	public static boolean isValidFormat(String format, String value) {
		Locale locale = Locale.ENGLISH;
		LocalDateTime ldt = null;
		DateTimeFormatter fomatter = DateTimeFormatter.ofPattern(format, locale);

		try {
			ldt = LocalDateTime.parse(value, fomatter);
			String result = ldt.format(fomatter);
			return result.equals(value);
		} catch (DateTimeParseException e) {
			try {
				LocalDate ld = LocalDate.parse(value, fomatter);
				String result = ld.format(fomatter);
				return result.equals(value);
			} catch (DateTimeParseException exp) {
				try {
					LocalTime lt = LocalTime.parse(value, fomatter);
					String result = lt.format(fomatter);
					return result.equals(value);
				} catch (DateTimeParseException e2) {
					// Debugging purposes
					// e2.printStackTrace();
				}
			}
		}

		return false;
	}

	public static Date toDate(String sDate) throws ParseException {

		SimpleDateFormat sdf1 = new SimpleDateFormat("dd-mm-yyyy");
		java.util.Date date = sdf1.parse(sDate);
		java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
		return sqlStartDate;
	}
	
	public static boolean validateEmail(String email){
		
		return false;
	}

}
