package project;

public class PagingUtil {
	private int total; // ��ü �Խñ� �� (o)
	private int perPage; // �� �������� �Խñ� ���� (o)
	private int nowPage; // ���� ������ ��ȣ (o)
	private int cntPage = 5; // �� ���ο��� �������� ������ ���� (o)
	private int startPage; // ���� ������ ��ȣ
	private int endPage; // ���� ������ ��ȣ
	private int start; // ���� �Խñ� ��ȣ
	private int end; // ���� �Խñ� ��ȣ
	private int lastPage; // �ֱ� ������ ��ȣ
	
	public PagingUtil() {}
	
	public PagingUtil(int nowPage, int total, int perPage) {
		this.nowPage = nowPage;
		this.total = total;
		this.perPage = perPage;
		
		calcStartEnd(nowPage, perPage);
		calcLastPage(total, perPage);
		calcStartEndPage(nowPage, cntPage);
	}

	public void calcStartEnd(int nowPage, int perPage) {
		/*
		 ���� ������ : 1 / �Խñ� ���� ���� : 8
		 �����ȣ : 1*8 = 8
		 ���۹�ȣ : �����ȣ - �Խñ� ���� ���� (5-5 = 0);
		 */
		int end = nowPage * perPage;
		int start = end - perPage;
		
		setEnd(end);
		setStart(start);
	}
	
	// �� 10�� �� �������� 8���� ������ ���� ��ȣ : 2
	public void calcLastPage(int total, int perPage) {
		// ��ü �Խñۿ��� �������� �Խñ� ���� ���� �Ǽ��� �ø�ó���� ���� ��ȯ
		int lastPage = (int)Math.ceil((double)total/perPage);
		
		setLastPage(lastPage);
	}
	
	// ���� ������ : 2 / ���� ������ ��ȣ : 6 / ���� ������ ��ȣ : 10
	public void calcStartEndPage(int nowPage, int cntPage) {
		// ���� �������� 10�� �ڸ��� ���ؿ� +1�� �� �� �� �������� ���� ������ ���� ���ϱ� 
		int endPage = (int)Math.ceil((double)nowPage/cntPage) * cntPage;
		int startPage = endPage - cntPage + 1;
		
		if(endPage > lastPage) {
			endPage = lastPage;
		}
		
		setEndPage(endPage);
		setStartPage(startPage);
	}
		
	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getCntPage() {
		return cntPage;
	}

	public void setCntPage(int cntPage) {
		this.cntPage = cntPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	
	
}
