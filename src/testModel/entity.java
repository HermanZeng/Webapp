package testModel;

public class entity {
	private int date;
	private int month;
	public int getDate() {
		return date;
	}
	public void setDate(int date) {
		this.date = date;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public void printDate(){
		System.out.println(month + " " + date);
	}
}
