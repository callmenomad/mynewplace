import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const DDayCalculatorApp());
}

class DDayCalculatorApp extends StatefulWidget {
  const DDayCalculatorApp({super.key});

  @override
  State<DDayCalculatorApp> createState() => _DDayCalculatorAppState();
}

class _DDayCalculatorAppState extends State<DDayCalculatorApp> {
  String _currentLanguage = 'English';

  void _changeLanguage(String language) {
    setState(() {
      _currentLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'D-Day Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: DDayCalculatorPage(
        onLanguageChanged: _changeLanguage,
        currentLanguage: _currentLanguage,
      ),
    );
  }
}

class DDayCalculatorPage extends StatefulWidget {
  final Function(String) onLanguageChanged;
  final String currentLanguage;

  const DDayCalculatorPage({
    super.key,
    required this.onLanguageChanged,
    required this.currentLanguage,
  });

  @override
  State<DDayCalculatorPage> createState() => _DDayCalculatorPageState();
}

class _DDayCalculatorPageState extends State<DDayCalculatorPage> {
  DateTime? selectedDate;
  final TextEditingController _titleController = TextEditingController();
  final List<DDayEvent> _events = [];

  final Map<String, Locale> _languages = {
    'English': const Locale('en'),
    '한국어': const Locale('ko'),
    '日本語': const Locale('ja'),
    '中文': const Locale('zh'),
    'Español': const Locale('es'),
    'Português': const Locale('pt'),
    'Français': const Locale('fr'),
    'Tiếng Việt': const Locale('vi'),
    'ไทย': const Locale('th'),
    'Tagalog': const Locale('tl'),
    'Bahasa Indonesia': const Locale('id'),
  };

  final Map<String, Map<String, String>> _translations = {
          'English': {
        'appTitle': 'D-DAY CALCULATOR',
        'addNewDday': 'Add New D-Day',
        'title': 'Title',
        'selectDate': 'Select Date',
        'create': 'Create',
        'addDdayEvent': 'Add a D-Day event!',
        'anniversaries': 'Anniversaries',
        'delete': 'Delete',
        'switchToInput': 'Switch to Input',
        'cancel': 'Cancel',
        'ok': 'OK',
        'dateFormat': 'Date Format',
        'invalidDate': 'Invalid date format',
        'done': 'Done',
      },
          '한국어': {
        'appTitle': '디데이 계산기',
        'addNewDday': '새 디데이 추가',
        'title': '제목',
        'selectDate': '날짜 선택',
        'create': '생성',
        'addDdayEvent': '디데이를 추가해보세요!',
        'anniversaries': '기념일',
        'delete': '삭제',
        'switchToInput': '입력으로 전환',
        'cancel': '취소',
        'ok': '확인',
        'dateFormat': '날짜 형식',
        'invalidDate': '잘못된 날짜 형식',
        'done': '완료',
      },
          '日本語': {
        'appTitle': 'D-DAY計算機',
        'addNewDday': '新しいD-DAYを追加',
        'title': 'タイトル',
        'selectDate': '日付を選択',
        'create': '作成',
        'addDdayEvent': 'D-DAYイベントを追加してください！',
        'anniversaries': '記念日',
        'delete': '削除',
        'switchToInput': '入力に切り替え',
        'cancel': 'キャンセル',
        'ok': 'OK',
        'dateFormat': '日付形式',
        'invalidDate': '無効な日付形式',
        'done': '完了',
      },
          '中文': {
        'appTitle': 'D日计算器',
        'addNewDday': '添加新的D日',
        'title': '标题',
        'selectDate': '选择日期',
        'create': '创建',
        'addDdayEvent': '添加一个D日事件！',
        'anniversaries': '纪念日',
        'delete': '删除',
        'switchToInput': '切换到输入',
        'cancel': '取消',
        'ok': '确定',
        'dateFormat': '日期格式',
        'invalidDate': '无效的日期格式',
        'done': '完成',
      },
          'Español': {
        'appTitle': 'CALCULADORA D-DAY',
        'addNewDday': 'Agregar Nuevo D-Day',
        'title': 'Título',
        'selectDate': 'Seleccionar Fecha',
        'create': 'Crear',
        'addDdayEvent': '¡Agrega un evento D-Day!',
        'anniversaries': 'Aniversarios',
        'delete': 'Eliminar',
        'switchToInput': 'Cambiar a entrada',
        'cancel': 'Cancelar',
        'ok': 'Aceptar',
        'dateFormat': 'Formato de fecha',
        'invalidDate': 'Formato de fecha inválido',
        'done': 'Hecho',
      },
          'Português': {
        'appTitle': 'CALCULADORA D-DAY',
        'addNewDday': 'Adicionar Novo D-Day',
        'title': 'Título',
        'selectDate': 'Selecionar Data',
        'create': 'Criar',
        'addDdayEvent': 'Adicione um evento D-Day!',
        'anniversaries': 'Aniversários',
        'delete': 'Excluir',
        'switchToInput': 'Alternar para entrada',
        'cancel': 'Cancelar',
        'ok': 'OK',
        'dateFormat': 'Formato de data',
        'invalidDate': 'Formato de data inválido',
        'done': 'Feito',
      },
          'Français': {
        'appTitle': 'CALCULATRICE D-DAY',
        'addNewDday': 'Ajouter un Nouveau D-Day',
        'title': 'Titre',
        'selectDate': 'Sélectionner la Date',
        'create': 'Créer',
        'addDdayEvent': 'Ajoutez un événement D-Day !',
        'anniversaries': 'Anniversaires',
        'delete': 'Supprimer',
        'switchToInput': 'Basculer vers l\'entrée',
        'cancel': 'Annuler',
        'ok': 'OK',
        'dateFormat': 'Format de date',
        'invalidDate': 'Format de date invalide',
        'done': 'Terminé',
      },
    'Tiếng Việt': {
      'appTitle': 'MÁY TÍNH D-DAY',
      'addNewDday': 'Thêm D-Day Mới',
      'title': 'Tiêu đề',
      'selectDate': 'Chọn Ngày',
      'create': 'Tạo',
      'addDdayEvent': 'Thêm một sự kiện D-Day!',
      'anniversaries': 'Kỷ niệm',
      'delete': 'Xóa',
      'switchToInput': 'Chuyển sang nhập',
      'cancel': 'Hủy',
      'ok': 'OK',
      'dateFormat': 'Định dạng ngày',
      'invalidDate': 'Định dạng ngày không hợp lệ',
      'done': 'Xong',
    },
    'ไทย': {
      'appTitle': 'เครื่องคำนวณ D-DAY',
      'addNewDday': 'เพิ่ม D-Day ใหม่',
      'title': 'หัวข้อ',
      'selectDate': 'เลือกวันที่',
      'create': 'สร้าง',
      'addDdayEvent': 'เพิ่มเหตุการณ์ D-Day!',
      'anniversaries': 'วันครบรอบ',
      'delete': 'ลบ',
      'switchToInput': 'เปลี่ยนเป็นการป้อนข้อมูล',
      'cancel': 'ยกเลิก',
      'ok': 'ตกลง',
      'dateFormat': 'รูปแบบวันที่',
      'invalidDate': 'รูปแบบวันที่ไม่ถูกต้อง',
      'done': 'เสร็จแล้ว',
    },
    'Tagalog': {
      'appTitle': 'D-DAY CALCULATOR',
      'addNewDday': 'Magdagdag ng Bagong D-Day',
      'title': 'Pamagat',
      'selectDate': 'Pumili ng Petsa',
      'create': 'Gumawa',
      'addDdayEvent': 'Magdagdag ng D-Day event!',
      'anniversaries': 'Mga Anibersaryo',
      'delete': 'Tanggalin',
      'switchToInput': 'I-switch sa pag-input',
      'cancel': 'Kanselahin',
      'ok': 'OK',
      'dateFormat': 'Format ng Petsa',
      'invalidDate': 'Hindi wastong format ng petsa',
      'done': 'Tapos na',
    },
    'Bahasa Indonesia': {
      'appTitle': 'KALKULATOR D-DAY',
      'addNewDday': 'Tambah D-Day Baru',
      'title': 'Judul',
      'selectDate': 'Pilih Tanggal',
      'create': 'Buat',
      'addDdayEvent': 'Tambahkan acara D-Day!',
      'anniversaries': 'Hari Jadi',
      'delete': 'Hapus',
      'switchToInput': 'Beralih ke input',
      'cancel': 'Batal',
      'ok': 'OK',
      'dateFormat': 'Format Tanggal',
      'invalidDate': 'Format tanggal tidak valid',
      'done': 'Selesai',
    },
  };

  // Language-specific date formats
  final Map<String, Map<String, dynamic>> _dateFormats = {
    'English': {
      'weekdays': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      'months': [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ],
      'format': 'MM/dd/yyyy',
    },
    '한국어': {
      'weekdays': ['월', '화', '수', '목', '금', '토', '일'],
      'months': [
        '1월',
        '2월',
        '3월',
        '4월',
        '5월',
        '6월',
        '7월',
        '8월',
        '9월',
        '10월',
        '11월',
        '12월',
      ],
      'format': 'yyyy. M. d.',
    },
    '日本語': {
      'weekdays': ['月', '火', '水', '木', '金', '土', '日'],
      'months': [
        '1月',
        '2月',
        '3月',
        '4月',
        '5月',
        '6月',
        '7月',
        '8月',
        '9月',
        '10月',
        '11月',
        '12月',
      ],
      'format': 'yyyy年M月d日',
    },
    '中文': {
      'weekdays': ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
      'months': [
        '1月',
        '2月',
        '3月',
        '4月',
        '5月',
        '6月',
        '7月',
        '8月',
        '9月',
        '10月',
        '11月',
        '12月',
      ],
      'format': 'yyyy年M月d日',
    },
    'Español': {
      'weekdays': ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'],
      'months': [
        'Enero',
        'Febrero',
        'Marzo',
        'Abril',
        'Mayo',
        'Junio',
        'Julio',
        'Agosto',
        'Septiembre',
        'Octubre',
        'Noviembre',
        'Diciembre',
      ],
      'format': 'dd/MM/yyyy',
    },
    'Português': {
      'weekdays': ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'],
      'months': [
        'Janeiro',
        'Fevereiro',
        'Março',
        'Abril',
        'Maio',
        'Junho',
        'Julho',
        'Agosto',
        'Setembro',
        'Outubro',
        'Novembro',
        'Dezembro',
      ],
      'format': 'dd/MM/yyyy',
    },
    'Français': {
      'weekdays': ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
      'months': [
        'Janvier',
        'Février',
        'Mars',
        'Avril',
        'Mai',
        'Juin',
        'Juillet',
        'Août',
        'Septembre',
        'Octobre',
        'Novembre',
        'Décembre',
      ],
      'format': 'dd/MM/yyyy',
    },
    'Tiếng Việt': {
      'weekdays': ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'],
      'months': [
        'Tháng 1',
        'Tháng 2',
        'Tháng 3',
        'Tháng 4',
        'Tháng 5',
        'Tháng 6',
        'Tháng 7',
        'Tháng 8',
        'Tháng 9',
        'Tháng 10',
        'Tháng 11',
        'Tháng 12',
      ],
      'format': 'dd/MM/yyyy',
    },
    'ไทย': {
      'weekdays': ['จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.', 'อา.'],
      'months': [
        'มกราคม',
        'กุมภาพันธ์',
        'มีนาคม',
        'เมษายน',
        'พฤษภาคม',
        'มิถุนายน',
        'กรกฎาคม',
        'สิงหาคม',
        'กันยายน',
        'ตุลาคม',
        'พฤศจิกายน',
        'ธันวาคม',
      ],
      'format': 'd MMMM yyyy',
    },
    'Tagalog': {
      'weekdays': ['Lun', 'Mar', 'Miy', 'Huw', 'Biy', 'Sab', 'Ling'],
      'months': [
        'Enero',
        'Pebrero',
        'Marso',
        'Abril',
        'Mayo',
        'Hunyo',
        'Hulyo',
        'Agosto',
        'Setyembre',
        'Oktubre',
        'Nobyembre',
        'Disyembre',
      ],
      'format': 'MM/dd/yyyy',
    },
    'Bahasa Indonesia': {
      'weekdays': ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'],
      'months': [
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember',
      ],
      'format': 'dd/MM/yyyy',
    },
  };

  String _t(String key) {
    return _translations[widget.currentLanguage]?[key] ?? key;
  }

  String _getCapitalizedSelectDate() {
    String selectDateText = _t('selectDate');
    
    // 한국어, 일본어, 중국어는 그대로 유지
    if (widget.currentLanguage == '한국어' || 
        widget.currentLanguage == '日本語' || 
        widget.currentLanguage == '中文') {
      return selectDateText;
    }
    
    // 다른 언어들은 첫 글자를 대문자로 변경
    if (selectDateText.isNotEmpty) {
      return selectDateText[0].toUpperCase() + selectDateText.substring(1);
    }
    
    return selectDateText;
  }

  String _formatDate(DateTime date) {
    final dateFormat = _dateFormats[widget.currentLanguage];
    if (dateFormat == null) {
      // Fallback to English format
      final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      final months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      final weekday = weekdays[date.weekday - 1];
      final month = months[date.month - 1];
      return '$month ${date.day}, ${date.year} ($weekday)';
    }

    final weekdays = dateFormat['weekdays'] as List<String>;
    final months = dateFormat['months'] as List<String>;
    final format = dateFormat['format'] as String;

    final weekday = weekdays[date.weekday - 1];
    final month = months[date.month - 1];

    // Custom formatting based on language
    switch (widget.currentLanguage) {
      case '한국어':
        return '${date.year}. ${date.month}. ${date.day}.($weekday)';
      case '日本語':
        return '${date.year}年${date.month}月${date.day}日($weekday)';
      case '中文':
        return '${date.year}年${date.month}月${date.day}日($weekday)';
      case 'Español':
        return '${date.day} de $month de ${date.year} ($weekday)';
      case 'Português':
        return '${date.day} de $month de ${date.year} ($weekday)';
      case 'Français':
        return '${date.day} $month ${date.year} ($weekday)';
      case 'Tiếng Việt':
        return '${date.day}/${date.month}/${date.year} ($weekday)';
      case 'ไทย':
        return '${date.day} $month ${date.year} ($weekday)';
      case 'Tagalog':
        return '${date.month}/${date.day}/${date.year} ($weekday)';
      case 'Bahasa Indonesia':
        return '${date.day} $month ${date.year} ($weekday)';
      default:
        return '$month ${date.day}, ${date.year} ($weekday)';
    }
  }

  String _formatDateForDisplay(DateTime date) {
    switch (widget.currentLanguage) {
      case '한국어':
        return '${date.year}년 ${date.month}월 ${date.day}일';
      case '日本語':
        return '${date.year}年${date.month}月${date.day}日';
      case '中文':
        return '${date.year}年${date.month}月${date.day}日';
      case 'Español':
        return '${date.day} de ${_getMonthName(date.month)} de ${date.year}';
      case 'Français':
        return '${date.day} ${_getMonthName(date.month)} ${date.year}';
      case 'Português':
        return '${date.day} de ${_getMonthName(date.month)} de ${date.year}';
      case 'Tiếng Việt':
        return '${date.day} tháng ${date.month} năm ${date.year}';
      case 'Bahasa Indonesia':
        return '${date.day} ${_getMonthName(date.month)} ${date.year}';
      case 'ไทย':
        return '${date.day} ${_getMonthName(date.month)} ${date.year + 543}'; // Buddhist calendar
      case 'Tagalog':
        return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
      default:
        return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
    }
  }

  String _getMonthName(int month) {
    switch (widget.currentLanguage) {
      case '한국어':
        return ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'][month - 1];
      case '日本語':
        return ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'][month - 1];
      case '中文':
        return ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'][month - 1];
      case 'Español':
        return ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'][month - 1];
      case 'Français':
        return ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'][month - 1];
      case 'Português':
        return ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'][month - 1];
      case 'Tiếng Việt':
        return ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'][month - 1];
      case 'Bahasa Indonesia':
        return ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'][month - 1];
      case 'ไทย':
        return ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'][month - 1];
      case 'Tagalog':
        return ['Enero', 'Pebrero', 'Marso', 'Abril', 'Mayo', 'Hunyo', 'Hulyo', 'Agosto', 'Setyembre', 'Oktubre', 'Nobyembre', 'Disyembre'][month - 1];
      default:
        return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][month - 1];
    }
  }

  Locale _getLocale() {
    return _languages[widget.currentLanguage] ?? const Locale('en');
  }

  void _showDateInputDialog() {
    final TextEditingController dateController = TextEditingController(
      text: selectedDate != null ? _formatDateForDisplay(selectedDate!) : '',
    );
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_t('selectDate')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${_t('dateFormat')}: ${_getDateFormat()} (${_getInputExamples()})',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: dateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  hintText: _getDateFormat(),
                  labelText: _t('selectDate'),
                  border: const OutlineInputBorder(),
                ),
                onSubmitted: (String value) {
                  _parseAndSetDate(value);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(_t('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(_t('ok')),
              onPressed: () {
                _parseAndSetDate(dateController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _parseAndSetDate(String value) {
    try {
      // Try multiple date formats based on language
      DateTime? parsedDate = _parseDateWithMultipleFormats(value);
      
      if (parsedDate != null) {
        setState(() {
          selectedDate = parsedDate;
        });
      } else {
        throw Exception('Invalid date format');
      }
    } catch (e) {
      // Show error message or handle invalid date format
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_t('invalidDate')}: ${_getDateFormat()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  DateTime? _parseDateWithMultipleFormats(String value) {
    // Remove any non-digit characters
    String cleanValue = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (cleanValue.isEmpty) return null;
    
    // Get the expected format for current language
    String expectedFormat = _getDateFormat();
    
    // Try different parsing strategies based on language
    switch (widget.currentLanguage) {
      case 'English':
      case 'Tagalog':
        return _parseUSFormat(cleanValue);
      case '한국어':
        return _parseKoreanFormat(cleanValue);
      case '日本語':
        return _parseJapaneseFormat(cleanValue);
      case '中文':
        return _parseChineseFormat(cleanValue);
      case 'Español':
      case 'Português':
      case 'Français':
      case 'Tiếng Việt':
      case 'Bahasa Indonesia':
        return _parseEuropeanFormat(cleanValue);
      case 'ไทย':
        return _parseThaiFormat(cleanValue);
      default:
        return _parseUSFormat(cleanValue);
    }
  }

  DateTime? _parseUSFormat(String value) {
    // MM/DD/YYYY or MMDDYYYY or MMDDYY
    if (value.length == 6) {
      // MMDDYY format
      int month = int.parse(value.substring(0, 2));
      int day = int.parse(value.substring(2, 4));
      int year = 2000 + int.parse(value.substring(4, 6));
      return DateTime(year, month, day);
    } else if (value.length == 8) {
      // MMDDYYYY format
      int month = int.parse(value.substring(0, 2));
      int day = int.parse(value.substring(2, 4));
      int year = int.parse(value.substring(4, 8));
      return DateTime(year, month, day);
    }
    return null;
  }

  DateTime? _parseEuropeanFormat(String value) {
    // DD/MM/YYYY or DDMMYYYY or DDMMYY
    if (value.length == 6) {
      // DDMMYY format
      int day = int.parse(value.substring(0, 2));
      int month = int.parse(value.substring(2, 4));
      int year = 2000 + int.parse(value.substring(4, 6));
      return DateTime(year, month, day);
    } else if (value.length == 8) {
      // DDMMYYYY format
      int day = int.parse(value.substring(0, 2));
      int month = int.parse(value.substring(2, 4));
      int year = int.parse(value.substring(4, 8));
      return DateTime(year, month, day);
    }
    return null;
  }

  DateTime? _parseKoreanFormat(String value) {
    // YYYYMMDD or YYMMDD
    if (value.length == 6) {
      // YYMMDD format
      int year = 2000 + int.parse(value.substring(0, 2));
      int month = int.parse(value.substring(2, 4));
      int day = int.parse(value.substring(4, 6));
      return DateTime(year, month, day);
    } else if (value.length == 8) {
      // YYYYMMDD format
      int year = int.parse(value.substring(0, 4));
      int month = int.parse(value.substring(4, 6));
      int day = int.parse(value.substring(6, 8));
      return DateTime(year, month, day);
    }
    return null;
  }

  DateTime? _parseJapaneseFormat(String value) {
    // Same as Korean format
    return _parseKoreanFormat(value);
  }

  DateTime? _parseChineseFormat(String value) {
    // Same as Korean format
    return _parseKoreanFormat(value);
  }

  DateTime? _parseThaiFormat(String value) {
    // Try European format first, then US format
    DateTime? result = _parseEuropeanFormat(value);
    if (result == null) {
      result = _parseUSFormat(value);
    }
    return result;
  }

  String _getDateFormat() {
    final dateFormat = _dateFormats[widget.currentLanguage];
    return dateFormat?['format'] as String? ?? 'MM/dd/yyyy';
  }

  String _getInputExamples() {
    switch (widget.currentLanguage) {
      case 'English':
      case 'Tagalog':
        return 'e.g.: 022425, 02242025';
      case '한국어':
        return '예: 250224, 20250224';
      case '日本語':
        return '例: 250224, 20250224';
      case '中文':
        return '例如: 250224, 20250224';
      case 'Español':
        return 'ej.: 240225, 24022025';
      case 'Português':
        return 'ex.: 240225, 24022025';
      case 'Français':
        return 'ex.: 240225, 24022025';
      case 'Tiếng Việt':
        return 'vd.: 240225, 24022025';
      case 'Bahasa Indonesia':
        return 'mis.: 240225, 24022025';
      case 'ไทย':
        return 'เช่น: 240225, 24022025 หรือ 022425, 02242025';
      default:
        return 'e.g.: 022425, 02242025';
    }
  }



  @override
  void initState() {
    super.initState();
    _titleController.text = 'D-Day';
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _addEvent() {
    if (selectedDate != null && _titleController.text.isNotEmpty) {
      setState(() {
        _events.add(
          DDayEvent(title: _titleController.text, targetDate: selectedDate!),
        );
        _titleController.text = 'D-Day';
        selectedDate = null;
      });
    }
  }

  void _removeEvent(int index) {
    setState(() {
      _events.removeAt(index);
    });
  }

  List<AnniversaryEvent> _generateAnniversaries(DateTime baseDate) {
    final List<AnniversaryEvent> anniversaries = [];

    // D+100, 200, 300
    for (int days in [100, 200, 300]) {
      anniversaries.add(
        AnniversaryEvent(
          title: 'D+$days',
          targetDate: baseDate.add(Duration(days: days)),
          type: AnniversaryType.days,
          value: days,
        ),
      );
    }

    // 1st Anniversary to 10th Anniversary
    for (int years in List.generate(10, (index) => index + 1)) {
      String suffix;
      if (years == 1) {
        suffix = 'st';
      } else if (years == 2) {
        suffix = 'nd';
      } else if (years == 3) {
        suffix = 'rd';
      } else {
        suffix = 'th';
      }

      anniversaries.add(
        AnniversaryEvent(
          title: '${years}$suffix Anniversary',
          targetDate: DateTime(
            baseDate.year + years,
            baseDate.month,
            baseDate.day,
          ),
          type: AnniversaryType.years,
          value: years,
        ),
      );
    }

    // Ascending order (closest date first)
    anniversaries.sort((a, b) => a.targetDate.compareTo(b.targetDate));

    return anniversaries;
  }

  Future<DateTime?> _showCustomDatePicker() async {
    DateTime currentDate = selectedDate ?? DateTime.now();
    int selectedDay = currentDate.day;
    int selectedMonth = currentDate.month;
    int selectedYear = currentDate.year;
    
    return showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                // Header with Cancel and Done buttons
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBackground.resolveFrom(context),
                    border: Border(
                      bottom: BorderSide(
                        color: CupertinoColors.separator.resolveFrom(context),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: Text(_t('cancel')),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getCapitalizedSelectDate(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      CupertinoButton(
                        child: Text(_t('done')),
                        onPressed: () {
                          Navigator.of(context).pop(
                            DateTime(selectedYear, selectedMonth, selectedDay),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Custom Date Picker with language-specific order
                Expanded(
                  child: _buildDatePickerRow(
                    selectedDay: selectedDay,
                    selectedMonth: selectedMonth,
                    selectedYear: selectedYear,
                    onDayChanged: (int day) => selectedDay = day,
                    onMonthChanged: (int month) => selectedMonth = month,
                    onYearChanged: (int year) => selectedYear = year,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDatePickerRow({
    required int selectedDay,
    required int selectedMonth,
    required int selectedYear,
    required Function(int) onDayChanged,
    required Function(int) onMonthChanged,
    required Function(int) onYearChanged,
  }) {
    // Determine picker order based on language
    List<Widget> pickers = [];
    
    switch (widget.currentLanguage) {
      case '한국어':
      case '日本語':
      case '中文':
        // Year → Month → Day (Asian format)
        pickers = [
          _buildYearPicker(selectedYear, onYearChanged),
          _buildMonthPicker(selectedMonth, onMonthChanged),
          _buildDayPicker(selectedDay, onDayChanged),
        ];
        break;
      case 'English':
      case 'Tagalog':
        // Month → Day → Year (US format)
        pickers = [
          _buildMonthPicker(selectedMonth, onMonthChanged),
          _buildDayPicker(selectedDay, onDayChanged),
          _buildYearPicker(selectedYear, onYearChanged),
        ];
        break;
      default:
        // Day → Month → Year (European format)
        pickers = [
          _buildDayPicker(selectedDay, onDayChanged),
          _buildMonthPicker(selectedMonth, onMonthChanged),
          _buildYearPicker(selectedYear, onYearChanged),
        ];
        break;
    }
    
    return Row(children: pickers);
  }

  Widget _buildDayPicker(int selectedDay, Function(int) onChanged) {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 40,
        scrollController: FixedExtentScrollController(
          initialItem: selectedDay - 1,
        ),
        onSelectedItemChanged: (int index) {
          onChanged(index + 1);
        },
        children: List.generate(31, (index) {
          return Center(
            child: Text(
              '${index + 1}',
              style: const TextStyle(fontSize: 18),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMonthPicker(int selectedMonth, Function(int) onChanged) {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 40,
        scrollController: FixedExtentScrollController(
          initialItem: selectedMonth - 1,
        ),
        onSelectedItemChanged: (int index) {
          onChanged(index + 1);
        },
        children: _getMonthNames().map((month) => Center(
          child: Text(
            month,
            style: const TextStyle(fontSize: 18),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildYearPicker(int selectedYear, Function(int) onChanged) {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 40,
        scrollController: FixedExtentScrollController(
          initialItem: selectedYear - 1900,
        ),
        onSelectedItemChanged: (int index) {
          onChanged(1900 + index);
        },
        children: List.generate(301, (index) {
          return Center(
            child: Text(
              '${1900 + index}',
              style: const TextStyle(fontSize: 18),
            ),
          );
        }),
      ),
    );
  }

  List<String> _getMonthNames() {
    switch (widget.currentLanguage) {
      case '한국어':
        return ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
      case '日本語':
        return ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
      case '中文':
        return ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
      case 'Español':
        return ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
      case 'Français':
        return ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
      case 'Português':
        return ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];
      case 'Tiếng Việt':
        return ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'];
      case 'Bahasa Indonesia':
        return ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
      case 'ไทย':
        return ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'];
      case 'Tagalog':
        return ['Enero', 'Pebrero', 'Marso', 'Abril', 'Mayo', 'Hunyo', 'Hulyo', 'Agosto', 'Setyembre', 'Oktubre', 'Nobyembre', 'Disyembre'];
      default:
        return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _t('appTitle'),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'HYHeadlineM',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 2,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language, color: Colors.white),
            onSelected: (String language) {
              widget.onLanguageChanged(language);
            },
            itemBuilder: (BuildContext context) {
              return _languages.keys.map((String language) {
                return PopupMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Form
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _t('addNewDday'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: _titleController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: _t('title'),
                          labelStyle: const TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final date = await _showCustomDatePicker();
                                if (date != null) {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Stack(
                                  children: [
                                    // Calendar icon positioned on the left
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: const Icon(Icons.calendar_month),
                                    ),
                                    // Text centered in the container
                                    Center(
                                      child: Text(
                                        selectedDate != null
                                            ? _formatDateForDisplay(selectedDate!)
                                            : _t('selectDate'),
                                        style: TextStyle(
                                          color: selectedDate != null
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              _showDateInputDialog();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            ),
                            child: Text(_t('switchToInput')),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: ElevatedButton.icon(
                        onPressed: _addEvent,
                        icon: const Icon(Icons.add),
                        label: Text(_t('create')),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // D-Day List
            Expanded(
              child: _events.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.event_note,
                            size: 64,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _t('addDdayEvent'),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Stack(
                      children: [
                        CustomScrollView(
                          slivers: _events
                              .asMap()
                              .entries
                              .expand((entry) {
                            final index = entry.key;
                            final event = entry.value;
                            final days = event.getDaysFromNow();
                            final isPast = days < 0;
                            final isToday = days == 0;

                            // Generate anniversary list
                            final anniversaries = _generateAnniversaries(
                              event.targetDate,
                            );

                            return [
                              // Sticky Header
                              SliverPersistentHeader(
                                pinned: true,
                                delegate: _SliverAppBarDelegate(
                                  minHeight: 80,
                                  maxHeight: 80,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: SizedBox(
                                        width: 400,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: isToday
                                                    ? Colors.orange
                                                    : isPast
                                                        ? Colors.blue
                                                        : Colors.green,
                                                child: Icon(
                                                  isToday
                                                      ? Icons.today
                                                      : Icons.event_available,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      event.title,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      _formatDate(event.targetDate),
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isToday
                                                      ? Colors.orange
                                                      : isPast
                                                          ? Colors.blue
                                                          : Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Text(
                                                  isToday
                                                      ? 'D-DAY'
                                                      : isPast
                                                          ? 'D+${days.abs()}'
                                                          : 'D-${days}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () => _removeEvent(index),
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Anniversary Content
                              SliverToBoxAdapter(
                                child: Center(
                                  child: SizedBox(
                                    width: 400,
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(color: Colors.grey[50]),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            _t('anniversaries'),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Column(
                                            children: anniversaries.map((anniversary) {
                                              final anniversaryDays = anniversary
                                                  .getDaysFromNow();
                                              final isAnniversaryPast =
                                                  anniversaryDays < 0;
                                              final isAnniversaryToday =
                                                  anniversaryDays == 0;

                                              return Container(
                                                width: double.infinity,
                                                margin: const EdgeInsets.only(
                                                  bottom: 4,
                                                ),
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 12,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(
                                                    8,
                                                  ),
                                                  border: Border.all(
                                                    color: isAnniversaryToday
                                                        ? Colors.orange
                                                        : isAnniversaryPast
                                                            ? Colors.blue
                                                            : Colors.green,
                                                    width: 1.5,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.withOpacity(
                                                        0.2,
                                                      ),
                                                      spreadRadius: 1,
                                                      blurRadius: 3,
                                                      offset: const Offset(0, 1),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          anniversary.title,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                            color: isAnniversaryToday
                                                                ? Colors.orange
                                                                : isAnniversaryPast
                                                                    ? Colors.blue[700]
                                                                    : Colors.green[700],
                                                          ),
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          _formatDate(
                                                            anniversary.targetDate,
                                                          ),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey[600],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: isAnniversaryToday
                                                            ? Colors.orange
                                                            : isAnniversaryPast
                                                                ? Colors.blue[100]
                                                                : Colors.green[100],
                                                        borderRadius:
                                                            BorderRadius.circular(16),
                                                      ),
                                                      child: Text(
                                                        isAnniversaryToday
                                                            ? "D-DAY"
                                                            : isAnniversaryPast
                                                                ? "D+${anniversaryDays.abs()}"
                                                                : "D-${anniversaryDays}",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: isAnniversaryToday
                                                              ? Colors.white
                                                              : isAnniversaryPast
                                                                  ? Colors.blue[700]
                                                                  : Colors.green[700],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Add minimal spacing between D-Day items
                              SliverToBoxAdapter(
                                child: Container(
                                  height: 8,
                                  color: Colors.transparent,
                                ),
                              ),
                            ];
                          }).toList(),
                        ),
                        // Floating scroll down button
                        if (_events.length > 1)
                          Positioned(
                            bottom: 20,
                            right: 20,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: const Duration(seconds: 2),
                              builder: (context, value, child) {
                                return Transform.translate(
                                  offset: Offset(0, 5 * (value - 0.5)),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class DDayEvent {
  final String title;
  final DateTime targetDate;

  DDayEvent({required this.title, required this.targetDate});

  int getDaysFromNow() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    return target.difference(today).inDays;
  }
}

enum AnniversaryType { days, years }

class AnniversaryEvent {
  final String title;
  final DateTime targetDate;
  final AnniversaryType type;
  final int value;

  AnniversaryEvent({
    required this.title,
    required this.targetDate,
    required this.type,
    required this.value,
  });

  int getDaysFromNow() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    return target.difference(today).inDays;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
