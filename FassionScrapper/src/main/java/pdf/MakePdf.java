package pdf;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;


import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;

public class MakePdf{	
	Calendar today = Calendar.getInstance();

	public void makePdf(List<String> list, String path) throws DocumentException, IOException {
		Document document = new Document(PageSize.A4,50,50,50,50);//페이지사이즈,좌우상하 마진
		//File file = new File(path);
		//File[] filelist = file.listFiles();
		String date = toString(today);
		PdfWriter.getInstance(document, new FileOutputStream("d:/Hello_top_"+date+".PDF"));
		document.open();
		
		/*BaseFont basefont = BaseFont.createFont("C:/Windows/Fonts/HANBatangB.TTF",BaseFont.IDENTITY_H,BaseFont.EMBEDDED);
		Paragraph title = new Paragraph("MY SCRAPBOOK",new Font(basefont,23,Font.BOLD));
		title.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(title);*/
		/*for(File f : filelist){
			String name = path+f.getName();
			Image img = Image.getInstance(name);
			img.scaleToFit(500, 500);
			img.setAlignment(Image.ALIGN_CENTER); 
			document.add(img);					
			document.newPage();
		}*/
	
		for(String f : list){
			String name = f;		
			Image img = Image.getInstance(path+"/"+name+".png");
			img.scaleToFit(500, 500);
			img.setAlignment(Image.ALIGN_CENTER); 
			document.add(img);					
			document.newPage();
		}					

	       // document.newPage();
			document.close();		
	}
	
	
	 public static String toString(Calendar date){  
		  return date.get(Calendar.YEAR)+""
				  +(date.get(Calendar.MONTH)+1)+""
				  +(date.get(Calendar.DATE))+""
				  +(date.get(Calendar.HOUR))+""
				  +(date.get(Calendar.MINUTE));
		  }



}
