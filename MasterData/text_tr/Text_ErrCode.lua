__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "Komut mevcut değil"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "Etkinlik sona erdi."
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "Giriş günü yetersiz, ödüller alınamıyor"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "Etkinliğe katılım koşulları karşılanmadı"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "Bu etkinlik mevcut değil"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "Bu etkinlik hâlâ geliştirme aşamasında"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "Bu etkinlik henüz başlamadı"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "Etkinlik görevi tamamlanmadı"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "Demo etkinliği: tamamlanmamış aşamalar için ödüller alınamaz"
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "Deneme etkinliği: Bu seviye bulunamadı"
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "Bu Koruyucu, bu etkinlik için zaten bir kez Destek sağladı"
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "Bu etkinlik, karşılıklı takip edilen Koruyucuların savaş desteği sağlamasını gerektirir"
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "\"Çok fazla Sık Kullanılan Destek eklediniz. Lütfen listeyi düzenleyin.\""
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "Beceri yükseltme koşulları karşılanmadı"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "Uyandıran’ın Yüceltme seviyesi yetersiz"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "Uyandıran henüz Alınabilir değil"
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "Uyandırma Ustası zaten kullanıldı"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "Tekrar engellenemez"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "Bu oyuncu tarafından kara listeye alındın ve işlem yapamazsın"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "Bu kullanıcı tarafından kara listeye alındınız; onu takip edemez veya beğenemezsiniz"
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "Bu kullanıcıyı kara listeye aldınız; onu beğenemez veya takip edemezsiniz"
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "Kara liste sınırına ulaşıldı"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "Savaş Oluşturma Başarısız"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "Geçiş Belgesi seviyesi satın almak için para birimi yetersiz"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "Operasyon başarısız"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "Geçiş Belgesi satın alma ayrıcalığı fiyatı yapılandırılmamış"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "Geçiş Belgesi ayrıcalık Seviyesi en üstte, tekrar satın alınamaz"
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "Ödülü almak için ayrıcalık seviyesi yetersiz"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "Ödül mevcut değil"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "Ödül Alındı"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "Gümüş Çekirdek Özü yetersiz"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "Yetersiz kupon satın alma denemesi"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "Kalıntılar güçlendirmeyi desteklemiyor"
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "Bu Kart en yüksek Seviyeye ulaştı ve Güçlendirme yapılamaz"
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "Bu kart güçlendirilemez"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "Yorumunuz engellenmiş kelimeler içeriyor."
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "Zaten yorum yaptınız."
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "Bunu zaten sildiniz."
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "Bunu zaten beğendiniz."
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "Beğenme işlemi çok hızlı."
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "Yorum çok uzun."
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "Bu yorum silindi."
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "Yorum zaman aşımına uğradı. Lütfen tekrar deneyin."
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Özel kart yükseltme denemesi kalmadı"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "Bu senaryo meydan okuması için hikâye bulunamadı"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "Senaryo meydan okumaları için hikâye görevleri bulunamadı"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "Hayali Dalış güncelleniyor. Lütfen daha sonra tekrar dene."
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "Meydan okuma Tamamlandı. Ödüller tekrar alınamaz."
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "Meydan okuma tamamlanmadı. Ödüller alınamaz."
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "Bölüm ödülleri gereken puana ulaşmadı"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "Bölüm ödülleri alındı"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "Mevcut düğüm bulunamadı"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "Karakter adı zaten alınmış"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "İstemci veri girişi hatası"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "Mevcut düğüm bulunamadı. Kapatılamıyor."
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "Yapılandırma verisi hatası"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "Ödüller talep edilemiyor"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "Ödül koşulları henüz yerine getirilmedi"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "Alınabilir seviye görevi verisi yok"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "Bu örneğin görevi için puan yok"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "Konu puanı için modül bulunamadı"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "Şimdiye dek hiçbir görev bulunamadı"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "Bu konu için birim verisi bulunamadı"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "Birim gönderildi. Yeniden göndermeye gerek yok."
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "Görevdeki alt görevler tamamlanmamış"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "Görev tamamlandı"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "Birim altındaki Görevler tamamen Tamamlandı değil, gönderilemez"
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "Yeni Koruyucuların kaydı şu anda duraklatıldı"
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "Karakter bulunamadı. Lütfen bir karakter oluştur."
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "Özel komut kullanım sınırına ulaşıldı"
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "Kalıntı güçlendirildi"
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "Menofin yeterli, doldurmaya gerek yok"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "Şu anda Kurban sunulamaz."
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "Aksesuar mevcut değil"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "Etkinlik alanında hata"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "Etkinlik için seçilen kart mevcut değil"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "Etkinlik için çok fazla kart seçildi"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "Etkinlik için seçilen Kalıntı mevcut değil"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "Etkinlik için çok fazla Kalıntı seçildi"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "Örnek yapılandırma tablosunda hatalı Etkinlik türü girişi"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "Etkinlik verisi hatası"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "Savaş ganimeti kartları için kalan yenileme yok"
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "Savaş ganimeti Kalıntıları için kalan yenileme yok"
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "Etkinlik tamamlandı"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "Örnekte böyle bir etkinlik yok"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "Yetersiz Gümüş. Satın alma yapılamıyor."
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "Bu düğümde etkinlik bulunamadı"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "Etkinlik rastgele havuzunda veri yok"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "Kavşak işlevi kilitli"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "Kamp zaten bir işlev seçti, başka bir seçim yapılamaz"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "Kamp işlevinin kalan kullanımı yok"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Etkinlik mağazası için kalan yenileme yok"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "Etkinlik mağazasında kart kaldırma girişimleri Tüketme edildi"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "Etkinlik için seçilen Kart sayısı yetersiz"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "Etkinlik için seçilen Kalıntılar yetersiz"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "Belirtilen özel Kart bilgisi bulunamıyor"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "Yükseltme Yolunda yapılandırılmış bir karakter kimliği yok"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "Belirlenen özel kart kilidi açılmamış"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "Geçiş yapmak için özel kartı değiştir"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "Özel kart değiştirilemedi"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "Geçiş yapmak için özel kartı yükselt"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "Bu özel kart için UUID bulunamıyor"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "Yardımcı Uyanan artık geçersiz. Lütfen yardım listesini yenileyip yeni bir yardımcı Uyanan seçin."
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "Sentez eşyasının kilidi açılmamış"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "Eşyayı üretmek için para birimi yetersiz"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "Gerekli eşyayı üretmek için malzeme yetersiz"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "Bina zaten mevcut, tekrar inşa edilemez"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "Konum zaten bir Uyandıran tarafından işgal edilmiş, girilemez"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "Bina en yüksek seviyeye ulaştı"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "Bina mevcut değil"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "Binaları Yükseltme/kurma koşulları yetersiz"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "Yükseltme/inşa için yeterli eşya yok"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "Mevcut düğümde alınabilir ödül yok."
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "Meydan okuma denemesi kalmadı"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "Mevcut HP’n çok düşük ve şimdi bir Zayıflık Durumu içindesin"
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "Keşif seviyesi 2’ye ulaştığında açılır"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "Bir keşfi tamamladıktan sonra anında yeniden keşfe çıkabilirsin."
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "Örnek hata"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "Örnek bulunamadı"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "Düğüm kilitli"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "Düğüm tamamlandı"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "Düğüm tamamlanmadı"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "Düğümler bitişik değil"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "Mağaza yenilemeleri yetersiz"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "Oyuncu seviyesi yetersiz"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "Açıklama yasadışı karakterler içeriyor. Lütfen yeniden girin."
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "Rakip şu anda meşgul"
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "Geçersiz indeks değeri"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "Zaten onların davetçisisin."
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "Davetçi Zaten Mevcut"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "Örnek durum hatası, lütfen yeniden giriş yap"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "Envanter dolu"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "Günlük satın alma sınırına ulaştınız"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "Eşya kuşanıldı"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "Eşya kilitli"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "Eşya kilitli değil"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "Eşya en yüksek kademeye ulaştı"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "Eşya yetersiz"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "Eşya bulunamadı"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "Eşya uyumsuz"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "Eşya kullanılamaz"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "Yinelenen eşya"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "Kader Çarkı veya Müfreze henüz Alınabilir değil"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "Eşya kullanım miktarı hatalı"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "Eşya kullanılamaz"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "Önceki tetikleyici düğüm bulunamadı"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "Şu anda toplanan enerji portalı etkinleştirmek için yetersiz. {s1} enerji puanı gerekiyor"
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "Maksimum seviye erişildi"
  },
  ErrCode_ERR_LOCKED_Desc = {Text = "Kilitli"},
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "Senaryo bölgesi henüz açılmadı"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "Hikâye süpürme henüz açılmadı"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "Seçilen senaryo henüz açılmadı"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "Seçilen hikâye hattının kilidi henüz açılmadı"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "Giriş sunucusu hatası"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "Ek alınmış"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "Posta mevcut değil"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "Maç başarısız oldu"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "Maksimum Uyandırma sayısına ulaşıldı!"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "Belirtilen Altın Zindanı’na meydan okunamıyor"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "Konuşlandırmak için bir Uyandırma seç"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "Belirlenen Altın zindanı Kilitli - lütfen belirtilen Soruşturma zindanını Tamamlandı"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "İsim değiştirme süresi henüz dolmadı, lütfen Nöbet"
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "İsim geçersiz karakterler içeriyor, lütfen tekrar girin"
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "İsim uzunluğu geçersiz, 2-4 karakter olmalıdır"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "Girdi dizisi çok uzun"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "Girilen karakter çok kısa"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "Yetersiz puan"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "Eşya sahip değil"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "Hareket edilemiyor"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "Özellik kilitli"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "Ödül koşulları karşılanmadı. Talep edilemiyor."
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "Profil güncelleniyor, lütfen daha sonra tekrar kontrol edin"
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "Devam eden bir Dostluk Maçı yok"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "Boşta Ahit yok"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "NPC veri hatası"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "NPC zaten tetiklendi"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "NPC mevcut değil"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "Rakip şu anda çevrimdışı"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "Oyuncu seviyesi yetersiz"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "Süpürme için yeterli hikâye Yıldızlar’ı yok"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "Herhangi bir hikâye diyalog etkinliği bulunamadı"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "Hikâye meydan okumaları için yetersiz satın alma denemesi"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "Ödül Alındı"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "Böyle bir ödül yok"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "Rün yerleştirme başarısız oldu"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "PVP koleksiyonu elde edilmedi"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "Traphase takım konuşlandırması için yetersiz Müfreze"
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "Traphase takım konuşlandırması için yetersiz WoD"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "Sıralı Seçim Modu gereksinimleri karşılanmadı"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "Meydan okuma bekleme süresinde"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "Meydan okuma denemesi kalmadı"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "Meydan okunacak rakip yok"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "Konuşlandırmak için bir Uyandırma seç"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "İki oyuncudan biri iki zafer kazandı. Ek rauntlara izin verilmiyor."
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "Rakip oyundan ayrıldı"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "Şifre Modu geçersiz veya süresi dolmuş"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "2000 sıra dışındaki sıralama bilgileri şu an görüntülenemiyor."
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "Şarj ayarlarında böyle bir yapılandırma yok"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "Ücretsiz doldurmayı zaten aldınız, tekrar şarj edemezsiniz"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "Eşya Yenileme sınırına ulaşıldı"
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "Birbirinizi karşılıklı takip etmelisiniz"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "Kalıntılar dolu"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "İstek çok sık gönderildi. Lütfen daha sonra tekrar deneyin."
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "Elit güçlendirme için malzeme yetersiz"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "Uyandırıcıyı Yükseltme için para birimi yetersiz"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "Karakter verisi hatası"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "Uyandıran’ın Varış oranı en üst düzeyde, daha fazla artırılamaz"
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "Uyandırma Ustası seviyesi yetersiz"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "Uyandıran en yüksek Seviyeye ulaştı ve Yükseltme yapılamaz"
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "Yetersiz Para Birimi"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "Uyandıran en yüksek Yüceltme seviyesine ulaştı."
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "İlerlemek için maksimum seviyeye eriş"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "Uyanışçı verisi bulunamadı"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "Uyandırıcının hiçbir Becerisi yok"
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "Yuvalara dair bilgi yok"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "Uyandıran’ın potansiyeli en yüksek Seviyeye ulaştı"
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "Uyandıran’ın potansiyelini Yükseltme için yetersiz Eşya"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "Uyandırıcı Becerileri henüz kilitlenmemiş"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "Beceri en yüksek seviyeye ulaştı"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "Yeterli beceri yükseltme eşyası yok"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "Beceri yükseltmesi için para birimi yetersiz"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "Maksimum seviye erişildi"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Daha fazla el ile yükseltme yuvası yok"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "Zaten ilerletildi; tekrar ilerletilemez"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "Uyandıran Yükseltme tüketimi için yetersiz Eşya"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "Uyandırıcıyı Yükseltme için para birimi yetersiz"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "Diyar koşulları karşılamıyor"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "Diyar Kulesi'nde konuşlandırılan Uyandırıcılar Diyar gereksinimlerini karşılamıyor"
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "Girdiğiniz seviye şu anda alınabilir değil"
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "Diyar Kulesi'nde aynı Uyandırıcılar konuşlandırılamaz"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "Gümüş yetersiz"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "Kampüs bakımı sürüyor. Lütfen Tamamlandı olmasını bekleyin."
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "Hizmet başlatılmadı"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "Zaten satın alındı"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "Şu anda sezilemiyor"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "Eşyanın süresi dolmuş, kullanılamaz"
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "Satıştaki eşya tükendi"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "Mağaza verisi alınabilir değil"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "Bu türde bir mağaza yok"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "Satışta böyle bir eşya yok"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "Mağazada bu eşya bulunmuyor"
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Yenileme denemesi kalmadı"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "Bu eşya mağazada alınabilir değil"
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "Şu anki düğüm bir Mağaza düğümü değil ve Yenileme yapılamaz."
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "Oyuncu mevcut değil."
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "Kökenin Bakışı'nın tüm avatarları yenildi"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "Bu Aşama türü için günlük meydan okuma sınırına ulaşıldı"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "Çok sık tıklanıyor. Lütfen biraz sonra tekrar deneyin."
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "Uyandırma işlevi etkin değil"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "Etkinleştirme koşulları karşılanmadı"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "Rezonans zaten etkin. Yeniden etkinleştirmeye gerek yok."
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "Başlangıç Rezonansı sıfırlanamaz"
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "Yetersiz Rezonans malzemesi"
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "Rezonans noktası azami seviyeye ulaştı"
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "Örnekte hiçbir Rezonans bulunamadı"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "Rezonans verisi bulunamadı"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "Rezonans seviyesiyle ilgili veri bulunamadı"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "Sıfırlama denemesi kalmadı"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "Uyandıran üretim Etkileri Kilitli açıldı; tekrar Kilit açmaya gerek yok."
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "Ödül Alındı"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "Vekâlet verilen görev tamamlandı ve geri çağrılamaz"
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "Atama koşulları yetersiz"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "Görev tamamlandı"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "Görev bulunamadı"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "Görev tamamlanmadı, ödül alınamaz"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "Takım adı yalnızca Çince veya İngilizce karakterler içerebilir"
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "Takım adı uzunluğu 8 karakteri aşamaz"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "Takımda 4 Uyandırma Ustası gerekli"
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "Takım yapılandırması bulunamadı"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "Takımın Uyandırıcısı Kader Çarkı'nı ayarlamamış"
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "Takımda Uyanışçılar ile bir Diyar Çatışması var, lütfen düzenleme yapın"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "Kader Çarkı mevcut değil"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "Yetersiz Kupon"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "Giriş jetonu hatası"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "Mevcut tetikleyici düğüm bulunamadı"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "Aksesuar kaydedilmemiş, nitelikler değiştirilemiyor"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "Önce takipten çık, sonra engelle"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "Bugünkü bu oynanışta Uyandırıcılar, Kader Çarkı veya Müfreze zaten kullanıldı"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "Yan görev kilidi açılamadı: yan görev zaten alınabilir"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "Yan görev kilidi açılamadı: yan görev etkinleştirilmemiş"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "Yan görev kilidi açılamadı: kilit açma için gereken eşyalar yok"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "Yan görev kilidi açılamadı: yan görevin kilidi zaten açık"
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "Sürüm uyuşmazlığı, lütfen güncelle. Güncellediysen, kampüs bakımının bitmesini bekle."
  },
  ErrCode_FAILED_Desc = {
    Text = "Başarısızlık"
  },
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "Bu karakter zaten mevcut; yenisini oluşturman gerekmez"
  },
  ErrCode_SUCCESS_Desc = {
    Text = "Başarılı"
  }
})
return Text_ErrCode
