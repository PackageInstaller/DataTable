__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_State = readonly({
  State_100291_Desc = {
    Text = "すべての覚醒体が与える狂気が50％増加します。"
  },
  State_100292_Name = {
    Text = "ターン開始"
  },
  State_100293_Desc = {
    Text = "すべての覚醒体が与える狂気が50%減少する。"
  },
  State_100293_Name = {
    Text = "人格の影"
  },
  State_100295_Name = {
    Text = "ダメージ監視"
  },
  State_100296_Desc = {
    Text = "1層ごとに、ターン開始後すべての覚醒体は<Energy:5>の狂気を獲得します。"
  },
  State_100296_Name = {
    Text = "自己の暗黒面"
  },
  State_100297_Desc = {
    Text = "すべての覚醒体による狂気が 50% 増加し、ターン終了時に最大ライフの 20% のシールドを獲得。"
  },
  State_100297_Name = {
    Text = "心の障壁"
  },
  State_100298_Desc = {
    Text = "ターン開始時に現在ライフの10％を失い、[DescArg1]ポイント<PowerIconKeywords:力>を得る。すべての覚醒体による狂気が50％低下する。"
  },
  State_100298_Name = {
    Text = "壁の崩壊"
  },
  State_100299_Desc = {
    Text = "狂気爆発カウント"
  },
  State_100299_Name = {
    Text = "狂気爆発カウント"
  },
  State_100302_Name = {
    Text = "狂気爆発リスニング"
  },
  State_100307_Desc = {
    Text = "唯一装備：装備者が狂気解放を発動した後、1層の「共創」を獲得する。このターン中で次に他の覚醒体が狂気解放を発動する際、「共創」を消費でき、その狂気解放のクリティカル率が<WeaponEffect_Num:[StateArg1]%>増加し、「共創」を消費した覚醒体は装備者の狂気増加<WeaponEffect_Num:[StateArg1]%>の狂気を獲得する。"
  },
  State_100307_WeaponDesc = {
    Text = "装備者が狂気解放を発動後、1層の「共創」を獲得する。このターン中で次の他の覚醒体の狂気解放が「共創」を消費でき、その狂気解放のクリティカル率が<WeaponEffect_Num:[StateArg1]%>増加し、「共創」を消費した覚醒体が<WeaponEffect_Num:[DescArg1]>狂気を獲得する。"
  },
  State_100326_Desc = {
    Text = "1層ごとに、ターン開始後、すべての覚醒体が <Energy:3> 狂気を得る。"
  },
  State_100326_Name = {
    Text = "<DarkEgo:自己の暗面>"
  },
  State_100327_Desc = {
    Text = "すべての覚醒体による狂気が 50% 増加し、ターン終了時に最大ライフの 20% のシールドを獲得。"
  },
  State_100328_Desc = {
    Text = "すべての覚醒体が与える狂気が50％増加します。"
  },
  State_100328_Name = {
    Text = "<TrueConfess:告白>"
  },
  State_100329_Desc = {
    Text = "すべての覚醒体による狂気が 50% 低下し、ターン終了後に「<DarkEgo:自我の暗面>」を 1 層獲得：ターン開始後、すべての覚醒体が狂気を 3 獲得。"
  },
  State_100329_Name = {
    Text = "<ShadowSelf:人格の影>"
  },
  State_100330_Desc = {
    Text = "ターン開始時に現在ライフの10％を失い、[DescArg1]ポイント<PowerIconKeywords:力>を得る。すべての覚醒体による狂気が50％低下する。"
  },
  State_100395_Name = {
    Text = "創造の恩恵の血+"
  },
  State_100396_Name = {
    Text = "創造の恩恵の血"
  },
  State_100527_Desc = {
    Text = "ピックマンが「発見」効果を発動した場合、「ひらめきが湧き上がる！」の選択を追加：「狂想」を1点消費し、すべての効果を選択して1点の「創意」を獲得する。"
  },
  State_100541_Desc = {
    Text = "「創意」が10点に達すると、ピックマンが狂気解放を発動後、すべての「創意」を消費し、すべての覚醒体は15狂気を獲得し、1点の「狂想」を獲得する。「創意」の上限は10点で、次の戦闘に引き継がれる。"
  },
  State_100541_Name = {
    Text = "<Chuangyi:創意>"
  },
  State_100542_Desc = {
    Text = "ピックマンが「発見」効果を発動した場合、「ひらめきが湧き上がる！」の選択を追加：「狂想」を1点消費し、すべての効果を選択して1点の「創意」を獲得する。"
  },
  State_100544_Name = {
    Text = "ナメクジプリン"
  },
  State_100544_WeaponDesc = {
    Text = "装備者が造成するシールドとライフ回復が6％上昇する。装備者の領域マスタリーが50より大きい場合、シールドとライフ回復が追加で6％上昇する。"
  },
  State_100545_Name = {
    Text = "ナメクジプリン"
  },
  State_100545_WeaponDesc = {
    Text = "装備者が造成するシールドとライフ回復が6％上昇する。装備者の領域マスタリーが50より大きい場合、シールドとライフ回復が追加で6％上昇する。"
  },
  State_100558_Desc = {
    Text = "今ターンの次の他の覚醒体の狂気の爆発のクリティカル率が[StateArg1]％上昇し、使用後[DescArg1]点の狂気を獲得する。"
  },
  State_100558_Name = {Text = "共創"},
  State_100559_Desc = {
    Text = "以下の「星辰篇の遺物」を含む：悪童、春の祭り、重鎖、縞瑪瑙、恩恵の血、錆びた鋸、金色の夢、血染めの小石。"
  },
  State_100559_Name = {
    Text = "<Chuanggouzaowu:創造の遺物>"
  },
  State_100562_Desc = {
    Text = "このターンに出す次の[Layer]枚のコマンドカードの計算力消費が2減少します。"
  },
  State_100562_Name = {
    Text = "真実、そして幻想"
  },
  State_100564_Desc = {
    Text = "以下の「刻印」を含む：算力、妙手、狂化、触媒、剛力、鉄壁、衰弱、啓示。"
  },
  State_100564_Name = {
    Text = "<Chuanggoukeyin:創造の刻印>"
  },
  State_100566_WeaponDesc = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_100617_Desc = {
    Text = "回合終了時に1つの触腕上限を得る。"
  },
  State_100617_Name = {
    Text = "崩壊の執念"
  },
  State_100619_Desc = {
    Text = "力の減少を受けた場合、現在の点数の50%が減少する。"
  },
  State_100619_Name = {
    Text = "衰弱耐性"
  },
  State_100621_Desc = {
    Text = "1点ごとにプレイヤーの基礎ダメージが15%減少し、その後の航路を示す。"
  },
  State_100621_Name = {
    Text = "小さな灯火"
  },
  State_100623_Desc = {
    Text = "1点ごとにプレイヤーが与える基礎ダメージが30%減少する。アクティブダメージまたは触腕ダメージを与えた後に、自身の毒を[DescArg1]点除去する。"
  },
  State_100623_Name = {
    Text = "迷航の光"
  },
  State_100639_Desc = {
    Text = "触腕ダメージが一時的に50%減少する。"
  },
  State_100639_Name = {
    Text = "失われた古都"
  },
  State_100644_Desc = {
    Text = "ターゲットの力を恒久的に減少させ、同等の量の力を得る。"
  },
  State_100644_Name = {
    Text = "<TouquKeywords: 永久盗む>"
  },
  State_100647_Desc = {
    Text = "すべてのダメージを無効化する。"
  },
  State_100647_Name = {
    Text = "すべてのダメージを無効化する。"
  },
  State_100694_Desc = {
    Text = "1点ごとにプレイヤーが与える基礎ダメージが30%減少する。アクティブダメージまたは触腕ダメージを与えた後、自身の毒を除去する。"
  },
  State_100694_Name = {
    Text = "迷航の光"
  },
  State_116342_Desc = {
    Text = "<ErosionColorInkKeywords:認知錯乱>カードを使用すると、「画家」が1層の<DecayDye:幻世染料>を獲得する。"
  },
  State_116342_Name = {
    Text = "異象のパレット"
  },
  State_116406_Name = {Text = "上級"},
  State_116407_Name = {Text = "空状態"},
  State_116858_Desc = {
    Text = "このステータスは軟化乗数を使用し、独立した乗数であるかのように装う。__「開発用」"
  },
  State_116858_Name = {
    Text = "特定の状態を持っている場合、受けるダメージが倍になる__「開発用」"
  },
  State_116859_Desc = {
    Text = "次のターン開始時、破綻を得ます。"
  },
  State_116859_Name = {
    Text = "遅延の破綻"
  },
  State_116958_Desc = {
    Text = "カードを使用すると、対応する層数のダメージを受ける。"
  },
  State_116958_Name = {
    Text = "<PVPCardLockColour:カード封鎖>"
  },
  State_117154_Desc = {
    Text = "この効果はチーム内のすべての覚醒体で1回のみ発動し、重複して発動することはできない。"
  },
  State_117154_Name = {
    Text = "<TeamUnique: 唯一装備>"
  },
  State_117212_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「スキル」前とターン終了時、<HPAndShieldMax:ライフとシールドが最も高い>敵に <Damage:[Damage:StateArg1]> スタックの<PVPCorrosionKeywords:罪印>を付与する。"
  },
  State_117212_Name = {
    Text = "歪んだ騎士詩"
  },
  State_117213_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「スキル」とターン終了時、狂気が最も高い敵に[StateArg1]の<PVPfengsuoKeywords:バーストロック>を与える。"
  },
  State_117213_Name = {
    Text = "神子の尊顔"
  },
  State_117346_Desc = {
    Text = "ポリュクスが与えるダメージは[Layer]%の出血を付与する。"
  },
  State_117355_Desc = {
    Text = "ポリュクスが次に使用する指令カードは2回発動する。"
  },
  State_117355_Name = {
    Text = "御子の新約"
  },
  State_117357_Desc = {
    Text = "唯一装備：「交換所」と「灰燼遺跡」で変更した後、装備者が <WeaponEffect_Num:[StateArg1]>狂気を獲得。"
  },
  State_117357_WeaponDesc = {
    Text = "「交換所」と「灰燼遺跡」で変更した後、装備者が <WeaponEffect_Num:[StateArg1]>狂気を獲得。"
  },
  State_117358_Desc = {
    Text = "ポリュクスの与えるダメージは、1点につき1%の出血を付与する。"
  },
  State_117744_Desc = {
    Text = "[Layer] <MaxHPKeywords:最大ライフ>を失い、解除された際に失った最大ライフは返還されず、発動時に[Layer]ポイントの純粋ダメージを受け、永続する。"
  },
  State_117745_Desc = {
    Text = "適用時に等しいスタック数の<MaxHPKeywords:最大ライフ>を失い、解除時に失った最大ライフは返還されず、発動時に等しいスタック数の純粋ダメージを受け、永続。"
  },
  State_117755_Desc = {
    Text = "ターン終了までいかなる行動もできなくなる。"
  },
  State_117755_Name = {Text = "混乱"},
  State_117756_Desc = {
    Text = "ターン終了までいかなる行動もできなくなる。"
  },
  State_117756_Name = {Text = "混乱"},
  State_117776_Desc = {
    Text = "このターン中、指令カード[Layer]枚の最終ダメージとシールドが[StateArg1]％増加する。"
  },
  State_117776_Name = {Text = "神炎"},
  State_117777_Desc = {
    Text = "唯一装備：装備者のカードが与える基礎ダメージとクリティカルダメージが<WeaponEffect_Num:[StateArg1]%>増加。ターン開始時と装備者が狂気解放を発動後、1層の「心の火」を獲得し、装備者がこのターンに指令カードを使用する時に1層の「心の火」を消費し、最終ダメージとシールドを<WeaponEffect_Num:[StateArg2]%>増加する。超次元ターン中は「神の炎」を獲得し、効果が2倍になる。"
  },
  State_117777_WeaponDesc = {
    Text = "備者のカードが与える基礎ダメージとクリティカルダメージが<WeaponEffect_Num:[StateArg1]%>増加。ターン開始時と装備者が狂気解放を発動後、1層の「心の火」を獲得し、装備者がこのターンに指令カードを使用する時に1層の「心の火」を消費し、最終ダメージとシールドを<WeaponEffect_Num:[StateArg2]%>増加する。超次元ターン中は「神の炎」を獲得し、効果が2倍になる。"
  },
  State_117778_Desc = {
    Text = "このターン中、指令カード[Layer]枚の最終ダメージとシールドが[StateArg1]％増加する。"
  },
  State_117779_Desc = {
    Text = "唯一装備：超次元ターン中、装備者は「心の火」を3層獲得する。このターン中、装備者の指令カードを使用する時に「心の火」を1層消費し、最終ダメージとシールドが<WeaponEffect_Num:[StateArg1]%>増加する。"
  },
  State_117779_WeaponDesc = {
    Text = "超次元ターン中、装備者は「心の火」を3層獲得する。このターン中、装備者の指令カードを使用する時に「心の火」を1層消費し、最終ダメージとシールドが<WeaponEffect_Num:[StateArg1]%>増加する。"
  },
  State_117851_Desc = {
    Text = "ポリュクスの指令カードは追加で50％の「苦痛による贖罪」効果を獲得し、[Layer]ターン持続。"
  },
  State_117851_Name = {
    Text = "白夜を照らす光"
  },
  State_117853_Desc = {
    Text = "ポリュクスがこのターンに使用する[Layer]枚の指令カードは、ダメージが[DescArg1]増加し、シールドが[DescArg2]点増加し、10狂気を獲得させる。"
  },
  State_117853_Name = {
    Text = "苦痛による贖罪"
  },
  State_117869_Desc = {
    Text = "狂気解放を発動するたびに、「呼び声」が1点増え、1点につき[DescArg1]点の力を獲得する。最大5点まで。"
  },
  State_117869_Name = {
    Text = "深海の祭司"
  },
  State_117870_Desc = {
    Text = "死亡後、撃破者は失ったライフの10%を回復する。"
  },
  State_117870_Name = {
    Text = "美味しい刺身"
  },
  State_117875_Desc = {
    Text = "後列に空きがある場合、行動後に1点消費し、「美味しい刺身」が付与された「仔群」を1体召喚すうｒ。"
  },
  State_117875_Name = {
    Text = "相互契約：魚群"
  },
  State_117876_Desc = {
    Text = "付与する<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重傷>が50%増加する。"
  },
  State_117876_Name = {
    Text = "虚弱＆脆弱＆重傷の悪化"
  },
  State_117880_Desc = {
    Text = "この戦闘中、次の「群れの力」は追加で1回発動する。"
  },
  State_117880_Name = {
    Text = "魚群が飛び跳ねる追加発動"
  },
  State_117883_Desc = {
    Text = "5点に達すると、すべての覚醒体を即座に封印し、行動予測は「リモリアの栄光!+」に転換する。"
  },
  State_117883_Name = {Text = "呼び声"},
  State_117885_Desc = {
    Text = "力の減少効果を受けた場合、相手にも同量の力の減少効果を付与する。"
  },
  State_117885_Name = {
    Text = "目には目を"
  },
  State_117889_Desc = {
    Text = "自身の最大ライフが10%増加し、他の味方に[DescArg1]点の<PowerIconKeywords:力>を与える。この戦闘中に<FishLeapWords:群れの力>によるライフ増加と力獲得の効果が追加で1回発動する。"
  },
  State_117889_Name = {
    Text = "群れの力"
  },
  State_118112_Desc = {
    Text = "受ける単発ダメージの上限は[DescArg1]点。ライフが50%未満になると除去される。"
  },
  State_118112_Name = {
    Text = "承痛閾値 I"
  },
  State_118113_Desc = {
    Text = "アクティブダメージを受けてライフを失った場合、失ったライフの15%のシールドと失ったライフの5%の<AlertIconKeywords: 一時的な警戒>を獲得する。"
  },
  State_118113_Name = {
    Text = "軟体体質Ⅰ"
  },
  State_118114_Desc = {
    Text = "アクティブダメージを受けてライフを失った場合、失ったライフの35%のシールドと失ったライフの5%の<AlertIconKeywords: 一時的な警戒>を獲得する。"
  },
  State_118114_Name = {
    Text = "軟体体質Ⅲ"
  },
  State_118115_Desc = {
    Text = "前列に空きがある場合、行動後に1点消費して「深海の増殖体」を1体召喚する。"
  },
  State_118115_Name = {
    Text = "相互契約：深海の増殖体"
  },
  State_118116_Desc = {
    Text = "受ける単発ダメージの上限は[DescArg1]点。ライフが50%未満になると除去される。"
  },
  State_118116_Name = {
    Text = "承痛閾値 II"
  },
  State_118117_Desc = {
    Text = "受ける単発ダメージの上限は[DescArg1]点。ライフが50%未満になると除去される。"
  },
  State_118117_Name = {
    Text = "承痛閾値 III"
  },
  State_118118_Desc = {
    Text = "[TentaclePower:DescArg1]<TentacleInjurieIconKeywords:触腕ダメージ>の触腕1本と触腕の上限を5本獲得する。ターン終了後、触腕を1本獲得する。受ける力減少効果が50%減少する。"
  },
  State_118118_Name = {
    Text = "触腕集結"
  },
  State_118119_Desc = {
    Text = "アクティブダメージを受けてライフを失った場合、失ったライフの25%のシールドと失ったライフの5%の<AlertIconKeywords: 一時的な警戒>を獲得する。"
  },
  State_118119_Name = {
    Text = "軟体体質Ⅱ"
  },
  State_118319_Desc = {
    Text = "受ける単発ダメージの上限は[DescArg1]点。ライフが50%未満になると除去される。"
  },
  State_118319_Name = {
    Text = "海淵の盾ダメージ制限"
  },
  State_118320_Name = {
    Text = "一時的な衰弱反制カウント"
  },
  State_118321_Name = {
    Text = "衰弱反制カウント"
  },
  State_118322_Name = {
    Text = "準備召喚マーク"
  },
  State_118323_Desc = {
    Text = "魚群が飛び跳ねたことがある"
  },
  State_118323_Name = {
    Text = "魚群が飛び跳ねる出場マーク"
  },
  State_118324_Desc = {
    Text = "ダメージを1回与えるごとに、1本の一時的な触腕を生成する。"
  },
  State_118324_Name = {
    Text = "神の恩寵"
  },
  State_118325_Desc = {
    Text = "未防がれたダメージを与えるとき、[DescArg1] 枚の窒息をドロー山の一番上にシャッフルする"
  },
  State_118325_Name = {
    Text = "新世界ヘビ頭人震え"
  },
  State_118656_Desc = {
    Text = "カード使用時に[StateArg1]ダメージを受け、1点を除去する。点数が0になった時、弱体化した「海中のもの」を1体孵化させる。ターン終了時に寄生状態が残っている場合、点数に応じてライフが増加した「海中のもの」を1体孵化させる。"
  },
  State_118656_Name = {
    Text = "多重寄生"
  },
  State_118657_Desc = {
    Text = "カード使用時に[StateArg1]ダメージを受け、1点を除去する。点数が0になった時、弱体化した「海中のもの」を1体孵化させる。ターン終了時に寄生状態が残っている場合、点数に応じてライフが増加した「海中のもの」を1体孵化させる。"
  },
  State_118657_Name = {Text = "再寄生"},
  State_118659_Desc = {
    Text = "カード使用時に[StateArg1]ダメージを受け、1点を除去する。点数が0になった時、弱体化した「海中のもの」を1体孵化させる。ターン終了時に寄生状態が残っている場合、点数に応じてライフが増加した「海中のもの」を1体孵化させる。"
  },
  State_118659_Name = {Text = "寄生"},
  State_118663_Name = {
    Text = "新世界ヘビ頭人の意図リスニング"
  },
  State_118669_Name = {
    Text = "新世界ヘビ頭人の初期化"
  },
  State_118670_Desc = {
    Text = "衰弱反制の検出"
  },
  State_118670_Name = {
    Text = "衰弱反制検出"
  },
  State_118671_Desc = {
    Text = "プレイヤーの衰弱行動の検出"
  },
  State_118671_Name = {
    Text = "衰弱反制リスナー"
  },
  State_118672_Name = {
    Text = "新世界ヘビ頭人の意図リスニングクールダウン"
  },
  State_118741_Name = {
    Text = "一時的な触腕を削除する"
  },
  State_118743_Name = {
    Text = "準備召喚の前置位置には召喚マークが必要です"
  },
  State_118759_Name = {
    Text = "モンスターの現在の永久的なタッチアームの数"
  },
  State_118760_Name = {
    Text = "モンスターの永久的なタッチアーム上限"
  },
  State_118762_Name = {
    Text = "初回腐朽のヒント"
  },
  State_118763_Name = {
    Text = "初回神経毒出血ヒント"
  },
  State_118764_Name = {
    Text = "初回呪怨の吹息のヒント"
  },
  State_118766_Name = {
    Text = "ブルーリングタコボスの意図モニタリング"
  },
  State_118769_Name = {
    Text = "シルバーコアランタンヒント"
  },
  State_118771_Name = {
    Text = "初回試みのヒント"
  },
  State_118772_Name = {
    Text = "初回群蛇の裂きヒント"
  },
  State_118935_Name = {
    Text = "モンスター・マーフィーの意図モニタリング"
  },
  State_118938_Desc = {
    Text = "「深海の淑女」が覚醒し、獲得するシールドが大幅に増加する！"
  },
  State_118938_Name = {
    Text = "造られし物"
  },
  State_118943_Desc = {
    Text = "自身のターンに受けるダメージが2倍になる。自身がライフを失った場合、失ったライフと同量の点数を失う。点数が0になると、触腕が永久的に1本減少し、点数をリセットする。最低1本。"
  },
  State_118943_Name = {
    Text = "神母の犠牲"
  },
  State_118973_Name = {
    Text = "隠忍の反逆管理"
  },
  State_119051_Desc = {
    Text = "ターン終了時にトリガーされ、トリガー時に同量のスタック数の純粋ダメージを受け、半分のスタック数を除去する。効果は解除できない。"
  },
  State_119051_Name = {
    Text = "<PVPSacrificeKeyWords:犠牲>"
  },
  State_119052_Desc = {
    Text = "アクティブダメージを受けた後、[Layer]%の犠牲を得ます。"
  },
  State_119052_Name = {
    Text = "誕生の儀"
  },
  State_119053_Desc = {
    Text = "ターン終了時にトリガーされ、トリガー時に[Layer]点の純粋ダメージを受け、半分のスタック数を除去する。効果は解除できない。"
  },
  State_119053_Name = {Text = "献上"},
  State_119058_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：ターン終了時、犠牲が最も少ない敵に [StateArg1] の<PVPSacrificeKeyWords:犠牲>を付与し、[StateArg2] 回繰り返す。味方全体は<PVPCapKeywords:行動力上限>減少効果の影響を受けなくなる。"
  },
  State_119058_Name = {
    Text = "暗闇の中の安眠"
  },
  State_119059_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」後、全ての敵は本回合の主动ダメージを受けた後、ダメージの[StateArg1]%の犠牲を得ます。"
  },
  State_119059_Name = {
    Text = "ブルーリングの毒素"
  },
  State_119060_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」のダメージが[StateArg1]%上昇し、任意の味方が「攻撃」を使用した後、[StateArg3]枚のカードを引く。毎ターン最大[StateArg2]回発動可能(現在[DescArg1]回発動済み)。"
  },
  State_119060_Name = {
    Text = "狂乱が世界の果てまで"
  },
  State_119061_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：全体の味方の「攻撃」のダメージが[StateArg1]%増加する。"
  },
  State_119061_Name = {
    Text = "理性の灯"
  },
  State_119063_Desc = {
    Text = "5点に達すると、行動予測は「リモリアの栄光！」に転換する。"
  },
  State_119063_Name = {Text = "呼び声"},
  State_119075_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_119075_Name = {Text = "未覚醒"},
  State_119076_Desc = {
    Text = "前列に空きがある場合、行動後に1点を消費し、ランダムな「リモリアの覚醒体」を1体召喚する。"
  },
  State_119076_Name = {
    Text = "相互契約：リモリア"
  },
  State_119077_Desc = {
    Text = "「呼び声」が5点に達すると、即座にすべての覚醒体を封印する。"
  },
  State_119077_Name = {
    Text = "ミリアム覚醒！"
  },
  State_119077_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_119080_Desc = {
    Text = "「混沌の記憶」または「未至忘却の黎明」を放出した際、選択された鍵令は追加で1回発動する。"
  },
  State_119080_Name = {
    Text = "忘却から"
  },
  State_119082_Desc = {
    Text = "覚醒体が狂気解放を発動するたびに、その基本の狂気が10ポイント増加する。"
  },
  State_119082_Name = {
    Text = "狂気の衰竭"
  },
  State_119083_Desc = {
    Text = "指令カードを超次元空間から取り出すと、行動力消費-1。"
  },
  State_119083_Name = {
    Text = "彼界の終途"
  },
  State_119084_Desc = {
    Text = "キーオーダーを発動するたびに、必要なシルバーキーエネルギーが100増加する。"
  },
  State_119084_Name = {
    Text = "シルバーキー振動"
  },
  State_119085_Desc = {
    Text = "猩紅炉を使用した後、1つの胚胎を聖純の子に変え、3ターンのクールダウンがあります。"
  },
  State_119085_Name = {
    Text = "猩紅の哺育"
  },
  State_119086_Desc = {
    Text = "繁殖の力がクールダウン中、残り [Layer] 回合。"
  },
  State_119086_Name = {
    Text = "繁殖の力-クールダウン"
  },
  State_119104_Desc = {
    Text = "ターン開始時、[DescArg1]点の「命契」を獲得。"
  },
  State_119104_Name = {
    Text = "海祭の儀"
  },
  State_119105_Desc = {
    Text = "死亡後、すべての「契約」を失う。1点につき最大ライフの1%を回復し、触腕ダメージが1%増加する。"
  },
  State_119106_Name = {
    Text = "モンスター誕妄・マーフィーの意図リスニング"
  },
  State_119107_Name = {
    Text = "神国の秩序管理"
  },
  State_119108_Desc = {
    Text = "ライフを失うと、1点ごとに失ったライフの1%の<SacrificeKeyWord:献上>を獲得する。"
  },
  State_119108_Name = {
    Text = "誕生の儀"
  },
  State_119109_Desc = {
    Text = "<SacrificeKeyWord:献上>以外のダメージを受けると、同量の「神国の秩序」を失い、ダメージの50％の<SacrificeKeyWord:献上>を獲得する。点数が0の場合、1点の「命契」を獲得し、点数数をリセットする。"
  },
  State_119109_Name = {
    Text = "神国の秩序"
  },
  State_119132_Desc = {
    Text = "このターンの「打撃」ダメージが[Layer]%増加します。"
  },
  State_119132_Name = {
    Text = "打撃を強化する"
  },
  State_119134_Name = {
    Text = "初回虚妄の創造者のヒント"
  },
  State_119359_Name = {
    Text = "銀鍵の儀式カウント"
  },
  State_119362_Name = {
    Text = "儀式を行う"
  },
  State_119363_Name = {
    Text = "カードを所有"
  },
  State_119364_Name = {
    Text = "狂気儀式カウント"
  },
  State_119365_Desc = {
    Text = "すべての覚醒体のライフ回復と獲得するシールドが40%増加。"
  },
  State_119365_Name = {
    Text = "冷静沈着"
  },
  State_119366_Desc = {
    Text = "放棄してから再び手に戻った"
  },
  State_119366_Name = {
    Text = "放棄してから再び手に戻った"
  },
  State_119367_Name = {
    Text = "生命儀式カウント"
  },
  State_119368_Desc = {
    Text = "毎ターン開始時、500キーエネルギーを獲得。"
  },
  State_119368_Name = {
    Text = "一目瞭然"
  },
  State_119369_Desc = {
    Text = "すべての覚醒体が獲得する狂気が50%増加。"
  },
  State_119369_Name = {
    Text = "威令徹行"
  },
  State_119370_Name = {Text = "遺物"},
  State_119373_Name = {
    Text = "敵は献祭を施す。"
  },
  State_119567_Name = {
    Text = "儀式完了"
  },
  State_119568_Desc = {
    Text = "受けた打撃ダメージが増加 [Layer] ポイント。"
  },
  State_119568_Name = {
    Text = "打撃を深める"
  },
  State_119583_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打撃」前、「スキル」前、「狂気解放」前に一時的に<StrongEffectKeywords:特効> +[StateArg1]、各効果は毎ターン1回のみ発動できます。"
  },
  State_119583_Name = {
    Text = "再び会う運命"
  },
  State_119589_Name = {
    Text = "超次元cd"
  },
  State_119590_Desc = {
    Text = "チームユニーク：触腕モードへの手動切り替え、猩紅炉の使用、「湮滅」の発動後、装備者の指令カードを1枚ドローし、各効果はそれぞれ3ターンクールダウン。全ての覚醒体が探索で得る同調率を<WeaponEffect_Num:[StateArg1]%>上昇させる。"
  },
  State_119590_WeaponDesc = {
    Text = "触腕姿勢をアクティブに切り替え（現在のクールダウンは[DescArg1]ターン）、猩紅の溶炉を使用（現在のクールダウンは[DescArg2]ターン）、「湮滅」を発動後（現在のクールダウンは[DescArg3]ターン）、装備者の指令カードを1枚引き、それぞれの効果は3ターンのクールダウンがあります。探索を完了すると、すべての覚醒体の同調率が<WeaponEffect_Num:[StateArg1]%>上昇します。"
  },
  State_119591_Name = {
    Text = "深海のcd"
  },
  State_119741_Desc = {
    Text = "すべての覚醒体の力獲得効果が50%減少。"
  },
  State_119741_Name = {
    Text = "聖像の呪い：衰亡の哀しみ"
  },
  State_119742_Desc = {
    Text = "毎ターン開始時、失ったライフの15%を回復する。"
  },
  State_119742_Name = {
    Text = "聖像の祝福：永遠の夢"
  },
  State_119743_Desc = {
    Text = "すべての覚醒体のライフ回復効果が50%減少。"
  },
  State_119743_Name = {
    Text = "聖像の呪い：破滅の恨み"
  },
  State_119744_Desc = {
    Text = "「聖像の呪い：破滅の恨み」を 1ターン無効化する。"
  },
  State_119744_Name = {
    Text = "聖像の呪い無効化：破滅の憎しみ"
  },
  State_119746_Name = {
    Text = "深淵の鍵の失う回数"
  },
  State_119747_Desc = {
    Text = "ダメージを受けない。1ターン持続。"
  },
  State_119747_Name = {
    Text = "銀の鍵が道を照らさんことを"
  },
  State_119748_Desc = {
    Text = "「聖像の呪い：衰亡の哀しみ」を1ターン無効化する。"
  },
  State_119748_Name = {
    Text = "聖像の呪い無効化：衰亡の哀しみ"
  },
  State_119749_Desc = {
    Text = "プレイヤーのターン開始時、点数と同数の手札に1点の<SlowIconKeywords:遅延>を付与する。"
  },
  State_119749_Name = {
    Text = "夢の束縛"
  },
  State_119750_Name = {
    Text = "天の帷幕は、意図を傍受している"
  },
  State_119751_Name = {
    Text = "モジュールが再現され、解放のマークが現れる"
  },
  State_119752_Desc = {
    Text = "毎ターン開始時、最大ライフの5%の<PowerIconKeywords:力>を獲得し、一時的なクリティカル率+25%。"
  },
  State_119752_Name = {
    Text = "聖像の祝福：神威の夢"
  },
  State_119753_Name = {
    Text = "暗い海渊の潮汐を数える"
  },
  State_119754_Desc = {
    Text = "すべての覚醒体が獲得する狂気が50%減少。"
  },
  State_119754_Name = {
    Text = "聖像の呪い：愚者の嘆き"
  },
  State_119755_Name = {
    Text = "死亡カウント"
  },
  State_119756_Desc = {
    Text = "「聖像の呪い：愚者の嘆き」を1ターン無効化する。"
  },
  State_119756_Name = {
    Text = "聖像の呪い無効化：愚者の嘆き"
  },
  State_119757_Desc = {
    Text = "プレイヤーのターン開始時、点数と同数の手札に1点の<SlowIconKeywords:遅延>を付与する。「楽園の帷」がアクティブダメージによって破壊されるたびに1点減少し、破壊した覚醒体を1ターン「完全封印」する。"
  },
  State_119757_Name = {
    Text = "夢の束縛"
  },
  State_119758_Desc = {
    Text = "毎ターン開始時、すべての覚醒体が10狂気を獲得する。"
  },
  State_119758_Name = {
    Text = "聖像の祝福：知恵の夢"
  },
  State_119760_Name = {
    Text = "死亡リスニング"
  },
  State_119789_Desc = {
    Text = "ラウンド開始時に [Layer] ポイントのライフを回復します。"
  },
  State_119789_Name = {
    Text = "泥濘の花"
  },
  State_119837_Desc = {
    Text = "ラモンナがこのターンに使用する次の指令カードは2回発動する。"
  },
  State_119837_Name = {
    Text = "再び手をつなぐ"
  },
  State_119847_Desc = {
    Text = "使用前にカードの行動力を変更する。__「開発用」"
  },
  State_119847_Name = {
    Text = "使用前にカードの行動力を変更する__「開発用」"
  },
  State_119928_Desc = {
    Text = "使用後、追加で効果が[StateArg1]回発動する。<DepleteIconKeywords:除外>。<RippleKeywords:余波>：カードを2枚引く。"
  },
  State_119928_Name = {
    Text = "<Rune_20:深海の反響>"
  },
  State_119958_Desc = {
    Text = "死亡後、即座にランダムな「魚群」を1体召喚し、1点減少する。"
  },
  State_119958_Name = {
    Text = "回遊する魚"
  },
  State_119959_Desc = {
    Text = "死亡後、即座にランダムな「仔群」を1体召喚し、1点減少する。"
  },
  State_119959_Name = {
    Text = "命尽きることなく"
  },
  State_119960_Desc = {
    Text = "与えるアクティブおよび触手ダメージが35%減少し、プレイヤーの現在のライフが50%を超えると解除される。"
  },
  State_120215_Desc = {
    Text = "プレイヤーのターン開始時、「<Abyssallock:夢の束縛>」の点数と同数の手札に1点の<SlowIconKeywords:遅延>を付与する。「楽園の帷」がアクティブダメージで破壊されるたびに1点減少し、破壊した覚醒体を1ターン「完全封印」する。"
  },
  State_120215_Name = {
    Text = "深淵の鎖"
  },
  State_120216_Desc = {
    Text = "プレイヤーのターン開始時、「<Abyssallock:深淵の鎖>」の点数と同数の手札に1点の<SlowIconKeywords:遅延>を付与する。"
  },
  State_120216_Name = {
    Text = "深淵の鎖"
  },
  State_120218_Name = {
    Text = "回合終了時にマーフィーの支援を選択"
  },
  State_120222_Name = {
    Text = "ターン開始時に呪いを反転して選択"
  },
  State_120292_Name = {
    Text = "受け入れられない痛み"
  },
  State_120293_Desc = {
    Text = "ターン終了時、[Layer]のライフを回復する。"
  },
  State_120293_Name = {
    Text = "受け入れられない痛み"
  },
  State_120312_Desc = {
    Text = "死亡後、即座にランダムな「魚王」を1体召喚し、1点減少する。"
  },
  State_120312_Name = {
    Text = "回遊する魚"
  },
  State_120320_Desc = {
    Text = "1点ごとに、「虚妄の王女」が次に付与する「誕生の儀」を20％増加する。最大5点。5点に達すると、「虚妄の王女」が次に与えるダメージの回数が2倍になる。"
  },
  State_120321_Desc = {
    Text = "1スタックごとにアクティブダメージまたは触手ダメージを受けた時に1％ダメージの犠牲を付加し、ターン終了時に除去する。上限75スタック。"
  },
  State_120321_Name = {
    Text = "<DwmofeiKeywords:誕生の儀>"
  },
  State_120322_Desc = {
    Text = "唯一装備：手札上限+2、同じ効果は重複しない。装備者のキーチャージ、狂気解放による最終ダメージとシールドが<WeaponEffect_Num:[StateArg1]%>増加。『静海』の姿勢に切り替えると、装備者は<WeaponEffect_Num:[StateArg2]>狂気を獲得。クールダウン3ターン。『怒涛』の姿勢に切り替えると、すべての敵に<WeaponEffect_Num:[StateArg3]>層の<DwmofeiKeywords:誕生の儀>を付与する。クールダウン3ターン。"
  },
  State_120322_WeaponDesc = {
    Text = "手札上限+2、同じ効果は重複しない。装備者のキーチャージ、狂気解放による最終ダメージとシールドが<WeaponEffect_Num:[StateArg1]%>増加。『静海』の姿勢に切り替えると、装備者は<WeaponEffect_Num:[StateArg2]>狂気を獲得。クールダウン3ターン。『怒涛』の姿勢に切り替えると、すべての敵に<WeaponEffect_Num:[StateArg3]>層の<DwmofeiKeywords:誕生の儀>を付与する。クールダウン3ターン。"
  },
  State_120324_Desc = {
    Text = "アクティブまたは触手ダメージを受けた時、[Layer]% ダメージの犠牲を付加し、ターン終了時に除去される。最大75スタックまで重複可能。"
  },
  State_120324_Name = {
    Text = "誕生の儀"
  },
  State_120351_Desc = {
    Text = "[Layer] ラウンド後に再度「神国·静海」を切り替えることができます。"
  },
  State_120351_Name = {
    Text = "神国・静海の冷却"
  },
  State_120354_Desc = {
    Text = "[Layer] ラウンド後に再度「神国·怒涛」を切り替えることができます。"
  },
  State_120354_Name = {
    Text = "神国・怒涛の冷却"
  },
  State_120362_Desc = {
    Text = "<SacrificeKeyWord:献上>以外のダメージを受けると、ダメージの50%の<SacrificeKeyWord:献上>を獲得。"
  },
  State_120362_Name = {
    Text = "共通のモンスター献祭管理"
  },
  State_120363_Desc = {
    Text = "ターン終了時、[Layer]ダメージを受け、50%の<SacrificeKeyWord:献上>を除去する。"
  },
  State_120363_Name = {
    Text = "<BlueKeyWord:献上>"
  },
  State_120364_Desc = {
    Text = "自身が死亡後、「海踊人近衛」を召喚する。"
  },
  State_120364_Name = {
    Text = "信念は永遠に"
  },
  State_120401_Desc = {
    Text = "このカードの行動力消費-[StateArg5]。使用後にカードを[StateArg4]枚引く。"
  },
  State_120401_Name = {
    Text = "<OrangeQuality:ミサゴの校章>"
  },
  State_120450_Name = {
    Text = "青環タコがプレイヤーのライフを記録しています"
  },
  State_120462_Desc = {
    Text = "戦闘終了後も山札に残るが、使用または消費されると永久に除去される。"
  },
  State_120462_Name = {
    Text = "<DestructionKeywords:消滅>"
  },
  State_120900_Name = {
    Text = "召喚「リモリア覚醒体」のカウントを準備する"
  },
  State_120907_Desc = {
    Text = "触腕の攻撃がブロックされた場合、[DescArg1]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  State_120908_Desc = {
    Text = "触腕の攻撃がブロックされた場合、同量の点数の<IntoxicationIconKeywords:毒>を付与する。"
  },
  State_120910_Desc = {
    Text = "このカードの行動力消費+[StateArg5]。使用後にカードを[StateArg4]枚引く。"
  },
  State_120910_Name = {
    Text = "<OrangeQuality:ミサゴの校章>"
  },
  State_120924_Desc = {
    Text = "次ラウンドが始まる時、加固を得る。"
  },
  State_120924_Name = {
    Text = "遅延強化"
  },
  State_120929_Desc = {
    Text = "カードは保留を獲得。使用後に汚染を除去し、「深海の増殖体」を1体召喚する。召喚できる場所がない場合、1点の「準備召喚：深海の増殖体」を獲得。"
  },
  State_120929_Name = {
    Text = "<SeastriderCurse:海踊人の呪い>"
  },
  State_120930_Desc = {
    Text = "空きがある場合、行動後に1点消費して「深海の増殖体」を1体召喚する。"
  },
  State_120930_Name = {
    Text = "相互契約：深海の増殖体"
  },
  State_120934_Desc = {
    Text = "クリティカルダメージを受けるたびに、3％の<Baojidikang:一時クリティカル耐性>を獲得する。毎ラウンド開始時にカード2枚に「<SeastriderCurse:蹈海者の呪怨>」を付与する。"
  },
  State_120934_Name = {
    Text = "深海の儀礼"
  },
  State_120941_Desc = {
    Text = "敵のスキル効果を強化する。ダメージを受けると1点失う。"
  },
  State_120941_Name = {
    Text = "血の誓い"
  },
  State_121006_Desc = {
    Text = "唯一装備：装備者のキーチャージ、狂気解放の最終ダメージ、シールドが<WeaponEffect_Num:[StateArg1]%>増加する。"
  },
  State_121006_WeaponDesc = {
    Text = "装備者のキーチャージ、狂気解放の最終ダメージ、シールドが<WeaponEffect_Num:[StateArg1]%>増加する。"
  },
  State_121014_Name = {
    Text = "聖胎の加護"
  },
  State_121015_Desc = {
    Text = "ターン開始時にシールドが除去されない。シールドがある場合は50点の<ReinforcePVEKeywords:堅固>を保持し、シールドが破壊された場合は<ReinforcePVEKeywords:堅固>を除去する。"
  },
  State_121015_Name = {
    Text = "聖胎の加護"
  },
  State_121151_Desc = {
    Text = "カードは保時を獲得。使用後に汚染を除去し、「深海の増殖体」を1体召喚する。召喚できる場所がない場合、1点の「準備召喚：深海の増殖体」を獲得。"
  },
  State_121151_Name = {
    Text = "<SeastriderCurse:海踊人の呪い>"
  },
  State_121210_Name = {
    Text = "全ての敵にマイナス<PVPWonderfulEffectKeywords:奇妙效果>を与え、効果が2回発動します"
  },
  State_121211_Name = {
    Text = "2枚のカードを引き、2算力を得ます"
  },
  State_121212_Name = {
    Text = "全ての味方にプラス<PVPWonderfulEffectKeywords:奇妙效果>を与え、効果が2回発動します"
  },
  State_121213_Desc = {
    Text = "すべてのダメージを無効化する。"
  },
  State_121213_Name = {
    Text = "すべてのダメージを無効化する。"
  },
  State_121231_Desc = {
    Text = "「虚妄の王女」が次に付与する「誕生の儀」の効果が、1点につき20%増加する。最大5点。5点に達すると、「虚妄の王女」が次に与えるダメージ回数が2倍になる。"
  },
  State_121365_Desc = {
    Text = "追加で[Layer]%の触腕ダメージを受ける。"
  },
  State_121377_Name = {
    Text = "<RetainIconKeywords:保持>：ターン開始時に500キーエネルギーを獲得"
  },
  State_121378_Name = {
    Text = "<RetainIconKeywords:保持>：すべての覚醒体のライフ回復効果と獲得するシールドが40%増加"
  },
  State_121380_Name = {
    Text = "<RetainIconKeywords:保持>：すべての覚醒体が獲得する狂気が50%増加"
  },
  State_121719_Name = {
    Text = "<RippleKeywords:余波>：カードを1枚引き、[DescArg1]点の一時的な<PowerIconKeywords:力>を獲得"
  },
  State_121734_Desc = {
    Text = "指令カードを1枚使用するたびに、対応する覚醒体の最も行動力消費が少ないカードを1枚捨てる。"
  },
  State_121734_Name = {
    Text = "狂気の奔流"
  },
  State_121735_Desc = {
    Text = "すべての指令カードの行動力消費が1増加。3ターンごとに、ターン終了時「石ころ変化」を1枚手札に追加する。"
  },
  State_121735_Name = {
    Text = "悲泣の奔流"
  },
  State_121736_Desc = {
    Text = "ターン終了時、失ったライフの10%を回復し、自身のデバフとプレイヤーのバフを解除する。"
  },
  State_121736_Name = {
    Text = "降臨の奔流"
  },
  State_121737_Desc = {
    Text = "戦闘開始時に15点の「一時的なバリア」を獲得。ターン終了時に15点の「一時的なバリア」を獲得し、ランダムなカード10枚「一時的な溶解」を付与する。"
  },
  State_121737_Name = {
    Text = "刺骨の奔流"
  },
  State_121738_Desc = {
    Text = "覚醒体が付与する力の効果が75%減少する。ライフを失うたび、[DescArg1]点のシールドと1点の一時的な堅固を獲得する。"
  },
  State_121738_Name = {
    Text = "邪信の奔流"
  },
  State_121739_Desc = {
    Text = "すべての覚醒体の狂気上限が50%増加。毎ターン終了時、すべての覚醒体は10狂気を失い、自身の最大ライフを3%回復。"
  },
  State_121739_Name = {
    Text = "恐怖の奔流"
  },
  State_121740_Desc = {
    Text = "戦闘開始時および毎ターン終了時、一時的な<ResentChainsKeywords:怨恨の鎖>を2層獲得する。"
  },
  State_121740_Name = {
    Text = "怪奇の奔流"
  },
  State_121797_Desc = {
    Text = "与えるすべてのダメージ・回復・シールド効果を10％低下させる。上限2層、解除不可。痴醉を最後に付与した者が死亡すると、付与された者のすべての痴醉が解除される。"
  },
  State_121797_Name = {
    Text = "<PVPLostSoulKeyWords:酔い痴れ>"
  },
  State_121798_Desc = {
    Text = "与えるダメージ・回復・シールド効果が[DescArg1]%低下し、解除不可。上限2スタック。\n<StatusApplier:>をキル後に解除される。"
  },
  State_121798_Name = {Text = "陶酔"},
  State_121799_Name = {
    Text = "第四章リモリア支援カード"
  },
  State_121850_Desc = {
    Text = "触腕ダメージが80%減少"
  },
  State_121850_Name = {
    Text = "ゴリアテ・支援"
  },
  State_121863_Name = {
    Text = "<RippleKeywords:余波>：2枚のカードを引く"
  },
  State_121878_Name = {
    Text = "初めて逆転呪いのストーリーを選択"
  },
  State_122428_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_122428_Name = {Text = "未覚醒"},
  State_122431_Desc = {
    Text = "ムシェットがブロックされなかったダメージを与えた時、2点の<Monster_Fervor:一時的な熱狂>を獲得する。"
  },
  State_122431_Name = {
    Text = "霧境の遺脈"
  },
  State_122441_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に3点の<PVPReciprocalKeywords:カウントダウン>を獲得。"
  },
  State_122441_Name = {
    Text = "カウントダウン"
  },
  State_122442_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時、<Block:[Block:StateArg1]>点のシールドと<Energy:[Energy:StateArg1]>狂気を獲得。ターン終了時、この運命の札の装備を自動解除し、次に「盒中童趣」を装備する際に獲得する狂気とシールドを[StateArg2]増加する。"
  },
  State_122442_Name = {
    Text = "箱の中の童心"
  },
  State_122443_Desc = {
    Text = "ターン開始時、1点を減少。点数が尽きた時、自身のデバフを解除し、100狂気を獲得。その後、3点のカウントダウンを再び獲得。運命の札の変更時、「カウントダウン」状態を失う。"
  },
  State_122443_Name = {
    Text = "<PVPFlowerKeywords:カウントダウン>"
  },
  State_122596_Desc = {
    Text = "カード使用不可。狂気解放を発動できない。"
  },
  State_122636_Desc = {
    Text = "毎ターン、最初に使用する「スキル」のダメージ、治癒、シールドが[StateArg1]%増加する。"
  },
  State_122636_Name = {
    Text = "ルビーのブローチ"
  },
  State_122650_Desc = {
    Text = "遺物<OrangeQuality:マジックグローブ>がこのカードを追加。"
  },
  State_122650_Name = {
    Text = "奇妙なカード"
  },
  State_122654_Name = {
    Text = "毎ターン開始時と行動終了後、空のプレイヤーの山札のリセットを試みる。もし空でない場合はリセットしない。__「開発用」"
  },
  State_122706_Name = {
    Text = "<CardKeyWord:再会の願い>"
  },
  State_122707_Desc = {
    Text = "本ターン内で最後に発射した「スキル」として扱い、行動力消費 -2、2番目のドロー山の一番上に置く。"
  },
  State_122707_Name = {
    Text = "<CardKeyWord:再会の願い>"
  },
  State_123109_Desc = {
    Text = "唯一装備：「交換所」で初めて「刻印」を購入するか、「灰燼遺跡」で初めて割引商品を購入する時、<WeaponEffect_Num:[StateArg1]%>の確率で必要な黒章のコストが0になる。各探索で最大1回有効。"
  },
  State_123109_WeaponDesc = {
    Text = "「交換所」で初めて「刻印」を購入するか、「灰燼遺跡」で初めて割引商品を購入する時、<WeaponEffect_Num:[StateArg1]%>の確率で必要な黒章のコストが0になる。各探索で最大1回有効。"
  },
  State_123177_Desc = {
    Text = "ターン開始時に解除する。10点に達した後にカードを使用すると即座に行動し、「一時的な熱狂」を除去し、行動予測を「人間爆破」に転換する。"
  },
  State_123177_Name = {
    Text = "一時的な熱狂"
  },
  State_123178_Desc = {
    Text = "<Guaiwusiwangdikang: 死亡抵抗>発動時のライフ回復効果が5倍になる。敵がカードを1枚使用するたびに、自身は1点<Monster_Fervor:一時的な熱狂>を獲得する。"
  },
  State_123178_Name = {
    Text = "不機嫌な寝起き"
  },
  State_123243_Desc = {
    Text = "敵を撃破した時、全層数を解除し、同量の狂気を獲得する。"
  },
  State_123243_Name = {Text = "渦流"},
  State_123246_Desc = {
    Text = "敵を撃破した時、すべての層数を解除し、同量の狂気を獲得する。"
  },
  State_123246_Name = {
    Text = "<PVPWaterPowerKeyWords:渦流>"
  },
  State_123294_Desc = {
    Text = "今ターンは「打撃」により[DescArg1]枚のカードを引きました。"
  },
  State_123507_Desc = {
    Text = "唯一装備：探索開始後、「カウントダウン：5」をデッキに1枚加える。使用後、1枚のカードを引き、次の「カウントダウン」を捨て札にシャッフルする。「<DestructionKeywords:破壊>」。「カウントダウン：0」：3枚のカードを引き、3点の行動力を獲得し、<WeaponEffect_Num:[StateArg1]%>の確率で「カウントダウン：5」を捨て札に置く。保持。「<DestructionKeywords:破壊>」。"
  },
  State_123507_WeaponDesc = {
    Text = "探索開始後、「カウントダウン：5」をデッキに1枚加える。使用後、1枚のカードを引き、次の「カウントダウン」を捨て札にシャッフルする。「<DestructionKeywords:破壊>」。「カウントダウン：0」：3枚のカードを引き、3点の行動力を獲得し、<WeaponEffect_Num:[StateArg1]%>の確率で「カウントダウン：5」を捨て札に置く。保持。「<DestructionKeywords:破壊>」。"
  },
  State_123520_Desc = {
    Text = "唯一装備：毎ターン初めてのキーオーダーを使用した後、<WeaponEffect_Num:[StateArg1]>％の確率で装備者の「攻撃」を1枚引く。"
  },
  State_123520_WeaponDesc = {
    Text = "毎ターン初めてのキーオーダーを使用した後、<WeaponEffect_Num:[StateArg1]>％の確率で装備者の「攻撃」を1枚引く。"
  },
  State_123521_Desc = {
    Text = "唯一装備：装備者の「狂気解放」と「追撃」が与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。このターン中に任意の覚醒体の「攻撃」を使用後、装備者の「攻撃」ダメージが装備者の攻撃力の<WeaponEffect_Num:[StateArg2]%>分一時的に増加する。この効果は1ターンにつき最大8回まで有効。"
  },
  State_123521_WeaponDesc = {
    Text = "装備者の「狂気解放」と「追撃」が与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。このターン中に任意の覚醒体の「攻撃」を使用後、装備者の「攻撃」ダメージが装備者の攻撃力の<WeaponEffect_Num:[StateArg2]%>分一時的に増加する。この効果は1ターンにつき最大8回まで有効。"
  },
  State_123810_Desc = {
    Text = "敵の行動予測を「行動不能」に置き換える。"
  },
  State_123810_Name = {
    Text = "<HunmiKeywords:気絶>"
  },
  State_123812_Desc = {
    Text = "ターン終了時、行動力消費が減少します。"
  },
  State_123812_Name = {
    Text = "<PrepareKeywords:予備>"
  },
  State_123994_Desc = {
    Text = "いかなる行動もできない。"
  },
  State_123994_Name = {
    Text = "極上の睡眠"
  },
  State_124010_Desc = {
    Text = "次のターン開始時、[Layer]点の行動力を獲得。"
  },
  State_124010_Name = {
    Text = "遅延行動力"
  },
  State_124024_Desc = {
    Text = "このターンに「攻撃」を[Layer]枚使用すると、「ドラマティックな出会い」を[DescArg1]回発動する。"
  },
  State_124024_Name = {
    Text = "ドラマチックな出会い"
  },
  State_124034_Desc = {
    Text = "すべての覚醒体の「攻撃」のダメージが[StateArg1]増加する。[Layer]ターン持続。"
  },
  State_124034_Name = {
    Text = "シャイニング☆トルネード"
  },
  State_124037_Desc = {
    Text = "ムシェットのダメージ回数+1。すべての覚醒体の「攻撃」のダメージが[StateArg1]増加し、[Layer]ターン持続。"
  },
  State_124037_Name = {
    Text = "シャイニング☆トルネード"
  },
  State_124107_Desc = {
    Text = "「星の芽」が死亡すると、すべてのダメージを無効化し、覚醒する。最大ライフが2倍になり、残りのライフと同量の最大ライフを獲得。覚醒後、すべてのデバフを解除する。"
  },
  State_124107_Name = {Text = "未覚醒"},
  State_124108_Name = {
    Text = "界外の音カウント"
  },
  State_124109_Desc = {
    Text = "自身が獲得する<RetaliateIconKeywords:反撃>は、追加で5%の<PowerIconKeywords:力>ボーナスを獲得する。1ターン内にライフを[DescArg1]失った場合、「歌姫」と位置を交換する。"
  },
  State_124109_Name = {
    Text = "第二のゆりかご"
  },
  State_124111_Desc = {
    Text = "死亡抵抗のライフ回復効果が25%増加する。相手が指令カードを1枚使用するたび、[DescArg1]点の<PowerIconKeywords:力>を<TouquKeywords:奪う>。"
  },
  State_124111_Name = {
    Text = "星のゆりかご"
  },
  State_124112_Desc = {
    Text = "「歌姫」が死亡すると、すべてのダメージを無効化し、覚醒する。最大ライフが2倍になり、残りのライフと同量の最大ライフを獲得する。"
  },
  State_124112_Name = {Text = "未覚醒"},
  State_124113_Desc = {
    Text = "相手のターン終了時に手札を捨てない。ターン終了時に2点の<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>、<HeavyInjuryKeywords:重傷>、<VulnerabilityIconKeywords:易傷>を順に付与する。"
  },
  State_124113_Name = {
    Text = "界外の音"
  },
  State_124115_Desc = {
    Text = "与える<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重傷>および<WeaknessIconKeywords:虚弱>を50％に深める。 さらに[DescArg1]枚の<SlowIconKeywords:遅延>カードを発射した後、「星の芽」と位置を交換する。"
  },
  State_124115_Name = {
    Text = "星の旅人"
  },
  State_124121_Name = {
    Text = "惑星の旅人カウント"
  },
  State_124122_Name = {
    Text = "惑星旅人プレイヤーリスナー"
  },
  State_124190_Desc = {
    Text = "自身が獲得する<RetaliateIconKeywords:反撃>は、追加で5%の<PowerIconKeywords:力>ボーナスを獲得する。"
  },
  State_124190_Name = {
    Text = "第二のゆりかご"
  },
  State_124193_Name = {
    Text = "死亡抵抗のライフ回復効果が25%増加。"
  },
  State_124198_Desc = {
    Text = "与える<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重傷>および<WeaknessIconKeywords:虚弱>を50％に深める。"
  },
  State_124198_Name = {
    Text = "星の旅人"
  },
  State_124277_Desc = {
    Text = "実行プロセスの中間値の可視化。"
  },
  State_124277_Name = {
    Text = "プリント値2"
  },
  State_124278_Desc = {
    Text = "実行プロセスの中間値の可視化。"
  },
  State_124278_Name = {
    Text = "プリント値4"
  },
  State_124279_Desc = {
    Text = "実行プロセスの中間値の可視化。"
  },
  State_124279_Name = {
    Text = "プリント値5"
  },
  State_124280_Desc = {
    Text = "実行プロセスの中間値の可視化。"
  },
  State_124280_Name = {
    Text = "プリント値1"
  },
  State_124282_Desc = {
    Text = "実行プロセスの中間値の可視化。"
  },
  State_124282_Name = {
    Text = "プリント値7"
  },
  State_124283_Desc = {
    Text = "実行プロセスの中間値の可視化。"
  },
  State_124283_Name = {
    Text = "プリント値8"
  },
  State_124284_Desc = {
    Text = "実行プロセスの中間値の可視化。"
  },
  State_124284_Name = {
    Text = "プリント値9"
  },
  State_124285_Desc = {
    Text = "実行プロセスの中間値の可視化。"
  },
  State_124285_Name = {
    Text = "プリント値10"
  },
  State_124286_Desc = {
    Text = "実行プロセスの中間値の可視化。"
  },
  State_124286_Name = {
    Text = "プリント値6"
  },
  State_124287_Desc = {
    Text = "実行プロセスの中間値の可視化。"
  },
  State_124287_Name = {
    Text = "プリント値3"
  },
  State_124736_Desc = {
    Text = "BEAttachPostActionインターフェースのパラメータ3が正しくフィルタリングまたは対応するトリガーをトリガーしているか確認します。"
  },
  State_124736_Name = {
    Text = "リスニングテスト1"
  },
  State_124747_Desc = {
    Text = "BEAttachPostActionインターフェースのパラメータ3が正しくフィルタリングまたは対応するトリガーをトリガーしているか確認します。"
  },
  State_124747_Name = {
    Text = "リスニングテスト2"
  },
  State_124748_Desc = {
    Text = "敵が<BurningKeywords:燃焼>の付与されたカードを使用した時、自身に1点の<MonsterExFlameKeywords:爆炎>を付与し、[DescArg1]点の<PowerIconKeywords:力>が一時的に減少する。"
  },
  State_124748_Name = {
    Text = "不滅の炎"
  },
  State_124752_Desc = {
    Text = "BEAttachPostActionインターフェースのパラメータ3が正しくフィルタリングまたは対応するトリガーをトリガーしているか確認します。"
  },
  State_124752_Name = {
    Text = "リスニングテスト3"
  },
  State_124753_Desc = {
    Text = "BEAttachPostActionインターフェースのパラメータ3が正しくフィルタリングまたは対応するトリガーをトリガーしているか確認します。"
  },
  State_124753_Name = {
    Text = "リスニングテスト4"
  },
  State_124754_Desc = {
    Text = "BEAttachPostActionインターフェースのパラメータ3が正しくフィルタリングまたは対応するトリガーをトリガーしているか確認します。"
  },
  State_124754_Name = {
    Text = "リスニングテスト5"
  },
  State_124765_Desc = {
    Text = "クリティカル率が[Layer]%増加する 。"
  },
  State_124765_Name = {
    Text = "クリティカル率"
  },
  State_124766_Desc = {
    Text = "この戦闘でクリティカル率が[Layer]%増加。"
  },
  State_124766_Name = {
    Text = "クリティカル率"
  },
  State_124766_WeaponDesc = {
    Text = "この戦闘でクリティカル率が[Layer]%増加。"
  },
  State_124767_Desc = {
    Text = "クリティカルダメージが[Layer]%増加。"
  },
  State_124767_Name = {
    Text = "クリティカルダメージ"
  },
  State_124811_Desc = {
    Text = "BEAttachPostActionインターフェースのパラメータ3が正しくフィルタリングまたは対応するトリガーをトリガーしているか確認します。"
  },
  State_124811_Name = {
    Text = "リスニングテスト8"
  },
  State_124812_Desc = {
    Text = "BEAttachPostActionインターフェースのパラメータ3が正しくフィルタリングまたは対応するトリガーをトリガーしているか確認します。"
  },
  State_124812_Name = {
    Text = "リスニングテスト7"
  },
  State_124813_Desc = {
    Text = "BEAttachPostActionインターフェースのパラメータ3が正しくフィルタリングまたは対応するトリガーをトリガーしているか確認します。"
  },
  State_124813_Name = {
    Text = "リスニングテスト6"
  },
  State_124826_Desc = {
    Text = "BEAttachPostActionインターフェースのパラメータ3が正しくフィルタリングまたは対応するトリガーをトリガーしているか確認します。"
  },
  State_124826_Name = {
    Text = "リスニングテスト9"
  },
  State_124843_Desc = {
    Text = "トリガー BSTAfterAttachPostAction と BSTAfterDoActiveDamage.AttachPostAction のリスニングを確認します"
  },
  State_124843_Name = {
    Text = "リスニングテスト9"
  },
  State_124886_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備者のスキルカードを発射した後、[StateArg1]枚のカードを引き、優先的に他の覚醒体のカードを引く。毎ターン1回まで発動。"
  },
  State_124886_Name = {
    Text = "宿命の紡輪"
  },
  State_124887_Desc = {
    Text = "この覚醒体の「織物」ダメージ回数が [Layer] 上昇する。"
  },
  State_124887_Name = {Text = "織る"},
  State_124888_Desc = {
    Text = "カードを発射するたびに敵の手札にあるランダムな「スキル」に変化し、その行動力消費 -2。"
  },
  State_124888_Name = {
    Text = "<CardKeyWord:予言>"
  },
  State_124890_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、自身が下に[StateArg1]枚発射した「スキル」を2回発動させる。"
  },
  State_124890_Name = {
    Text = "永世に紡ぐ網"
  },
  State_124892_Name = {
    Text = "<CardKeyWord:予言>"
  },
  State_124916_Desc = {
    Text = "ターン終了時にすべてのスタック数を除去し、[DescArg1]の純粋ダメージを与える。解除不可。"
  },
  State_124916_Name = {
    Text = "命定の予兆"
  },
  State_124917_Desc = {
    Text = "ターン終了時にすべてのスタック数を除去し、純粋ダメージを与える。解除不可。"
  },
  State_124917_Name = {
    Text = "<PVPDestinedDeathKeyWords:命定の予兆>"
  },
  State_124992_Desc = {
    Text = "次の [DescArg1] 枚の「スキル」を2回発射する。"
  },
  State_124992_Name = {Text = "二連発"},
  State_124993_Desc = {
    Text = "与えるおよび受ける致命アクティブダメージが同量の<PVPDestinedDeathKeyWords:定命の予兆>の付与に変わる。解除不可。"
  },
  State_124993_Name = {
    Text = "運命よ、我が意のままに"
  },
  State_124997_Desc = {
    Text = "与える・受ける致命的なアクティブダメージを、同量の<PVPDestinedDeathKeyWords:定命の予兆>の付与に変更する。解除不可。"
  },
  State_124997_Name = {
    Text = "<PVPEternalDimensionKeyWords:運命よ、我が意のままに>"
  },
  State_125002_Name = {
    Text = "ステータス@一般的にプレイヤーの捨て札フェーズ後のシールド値を監視する"
  },
  State_125003_Name = {
    Text = "シールド値"
  },
  State_125004_Name = {
    Text = "ステータス@一般的にプレイヤーシールドカウントを付与する"
  },
  State_125472_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」後、<HPAndShieldMax:ライフとシールドが最も高い>敵に [StateArg1] 層の<PVPLostSoulKeyWords:酔い痴れ>を付与する。"
  },
  State_125472_Name = {
    Text = "白木蓮の餌"
  },
  State_125486_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：他の味方が「狂気解放」後、手札にある装備者のすべての「スキル」の算力消費を–[StateArg1]する。"
  },
  State_125486_Name = {
    Text = "無駄に眉をひそめる"
  },
  State_125925_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_125925_Name = {Text = "未覚醒"},
  State_125926_Name = {
    Text = "ステータス@モンスター・タヴィ切り替え意図プレイヤーリスナー"
  },
  State_125927_Desc = {
    Text = "指令カードを[DescArg1]枚の指令カードを使用した後、行動予測は「六翼の解放」に転換する。"
  },
  State_125927_Name = {
    Text = "四翼の芽生え"
  },
  State_125928_Desc = {
    Text = "指令カードを使用した後、対応する覚醒体の狂気解放とすべての指令カードを2ターン封印する。"
  },
  State_125928_Name = {
    Text = "時を貫く翼"
  },
  State_125929_Desc = {
    Text = "1ターン内に[DescArg1]ダメージを受けた場合、70点の一時的な<ReinforceColour:堅固>と1点の<ResentChainsKeywords:怨恨の鎖>を獲得する。"
  },
  State_125929_Name = {
    Text = "存在しない存在"
  },
  State_125933_Desc = {
    Text = "指令カードを[DescArg1]枚使用した後、行動予測は「四翼の芽生え」に転換する。"
  },
  State_125933_Name = {
    Text = "双翼の羽ばたき"
  },
  State_125934_Desc = {
    Text = "行動力を消費した後、獲得するキーエネルギーが50%減少する。タヴィがブロックされなかったダメージを与えた後、「<DerivativeCardKeywords_131:真・輪廻パラドックス>」を1枚手札に追加する。"
  },
  State_125934_Name = {
    Text = "銀の鍵の門を超えて"
  },
  State_125935_Name = {Text = "沈黙"},
  State_125935_WeaponDesc = {
    Text = "引いた時、自身に1点の「虚弱」を付与する。使用後、すべての敵に1点の「虚弱」を付与する。売却不可。"
  },
  State_125937_Desc = {
    Text = "指令カードを使用した後、対応する覚醒体の狂気解放とすべての指令カードを2ターン封印する。"
  },
  State_125937_Name = {
    Text = "時を貫く翼"
  },
  State_125964_Desc = {
    Text = "行動力を消費した後、獲得するキーエネルギーが50%減少する。タヴィがブロックされなかったダメージを与えた後、「<DerivativeCardKeywords_131:真・輪廻パラドックス>」を1枚手札に追加する。"
  },
  State_125964_Name = {
    Text = "銀の鍵の門を超えて"
  },
  State_126010_Desc = {
    Text = "唯一装備：装備者が与える毒と毒効果発動が<WeaponEffect_Num:[StateArg1]%>増加する。界域の才能効果で蓄積する<EmbryoFusionIconKeywords:胚胎融合>が<WeaponEffect_Num:[StateArg2]%>増加する。装備者が毎ターン初めて「共振」を発動した時、他の覚醒体は<WeaponEffect_Num:[StateArg3]>狂気を獲得する。"
  },
  State_126010_WeaponDesc = {
    Text = "装備者が与える毒と毒効果発動が<WeaponEffect_Num:[StateArg1]%>増加する。界域の才能効果で蓄積する<EmbryoFusionIconKeywords:胚胎融合>が<WeaponEffect_Num:[StateArg2]%>増加する。装備者が毎ターン初めて「共振」を発動した時、他の覚醒体は<WeaponEffect_Num:[StateArg3]>狂気を獲得する。"
  },
  State_126463_Name = {
    Text = "ステータス@モンスターリッツ誘蛾の炎受傷リスナー"
  },
  State_126464_Desc = {
    Text = "リッツが与えるダメージが[DescArg1]増加する。最大10点。"
  },
  State_126464_Name = {
    Text = "<GreenWord:翠緑の火種>"
  },
  State_126465_Name = {
    Text = "モンスターリッツの意図リスニング"
  },
  State_126466_Desc = {
    Text = "相手のターン終了時に手札を捨てない。行動予測が「緑炎」に転換すると、<MonsterLizVerdantSpark:翠緑の火種>が6点以上ある場合、6点を消費して、行動予測を<Damage:[Damage:DescArg1]>ダメージを[AttackTimes:DescArg2]回与える「死滅の緑炎」にアップグレードする。3点以上ある場合、3点を消費して、行動予測を<Damage:[Damage:DescArg3]>ダメージを[AttackTimes:DescArg4]回与える「腐敗の緑炎」にアップグレードする。"
  },
  State_126466_Name = {
    Text = "不滅の緑炎"
  },
  State_126467_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。「死告の舞い」はデバフを解除する能力を獲得する。"
  },
  State_126467_Name = {Text = "未覚醒"},
  State_126468_Name = {
    Text = "ステータス@モンスターリッツ翡翠の映像管理"
  },
  State_126469_Desc = {
    Text = "ライフを[DescArg1]失うごとに、[DescArg2]点の<MonsterLizVerdantSpark:翠緑の火種>を獲得する。"
  },
  State_126469_Name = {
    Text = "翡翠の映像"
  },
  State_126470_Name = {
    Text = "ステータス@モンスターリッツヒント語カウント"
  },
  State_126479_Desc = {
    Text = "リッツが与えるダメージが増加する。最大10点。"
  },
  State_126479_Name = {
    Text = "<GreenWord:翠緑の火種>"
  },
  State_126540_Desc = {
    Text = "[Layer]回目に発動する「共振」は、効果が2倍になる。"
  },
  State_126540_Name = {
    Text = "夜霧の下の誓い"
  },
  State_126568_Desc = {
    Text = "覚醒体がアクティブダメージを与えるたびに、1本の触腕に命令して対象に[Layer]％の触腕ダメージを与える。"
  },
  State_126568_Name = {
    Text = "怒りの海の狂澜"
  },
  State_126569_Desc = {
    Text = "覚醒体は毎回アクティブダメージを与え、1本の触腕が目標に攻撃をし、50％の触手ダメージを与えます。"
  },
  State_126569_Name = {
    Text = "怒りの海の狂澜"
  },
  State_126643_Desc = {
    Text = "本ステータス MaxLayer=1。出所覚醒体：[DescArg1]"
  },
  State_126643_Name = {Text = "制限1層"},
  State_126644_Desc = {
    Text = "取得後、[Layer]スタック数のデモステータスをクリアし、再度追加します。\nデモステータスの最大スタック数は1です。"
  },
  State_126644_Name = {
    Text = "最大スタック数を突破する"
  },
  State_126645_Desc = {
    Text = "ラモンナが与える基礎ダメージが[DescArg1]％増加する。"
  },
  State_126645_Name = {
    Text = "至高の鍛錬"
  },
  State_126651_Desc = {
    Text = "追撃後のリスナーが[Layer]回満たされました。"
  },
  State_126651_Name = {
    Text = "カウンター"
  },
  State_126652_Desc = {
    Text = "取得後、前列の敵に後置行動を追加させ、その現在の意図を発射する。"
  },
  State_126652_Name = {
    Text = "モンスターを追跡させる"
  },
  State_126653_Desc = {
    Text = "獲得後、位置1の覚醒体に後置行動を追加し、その打撃カードを発射する。"
  },
  State_126653_Name = {
    Text = "覚醒体を追撃させる"
  },
  State_126654_Desc = {
    Text = "指名リスナーが発動したとき、1回カウントをプリントします。"
  },
  State_126654_Name = {
    Text = "指名リスナー"
  },
  State_126655_Desc = {
    Text = "取得後、守秘者に後置アクションを追加させ、スキル@主人公スキル@頭の中の音を発射する。"
  },
  State_126655_Name = {
    Text = "守秘者に追撃させる"
  },
  State_126677_Desc = {
    Text = "このターン、[Layer]枚の「傲慢の刃」が2回発動する。"
  },
  State_126677_Name = {
    Text = "太古の鯨鳴"
  },
  State_126678_WeaponDesc = {
    Text = "くじらとびのすべてのダメージ回数＋1。"
  },
  State_126714_Desc = {
    Text = "アイギスの次の[Layer]枚の「防御」は3回発動する。"
  },
  State_126714_Name = {
    Text = "刻み込まれた涙"
  },
  State_126714_WeaponDesc = {
    Text = "「飛び立つ鯨」のダメージ回数+1．"
  },
  State_126715_WeaponDesc = {
    Text = "「飛び立つ鯨」のダメージ回数+1．"
  },
  State_126776_Desc = {
    Text = "1点ごとに受ける固定毒が5%増加し、与えるダメージが[DescArg1]％減少する。最大[DescArg2]点。"
  },
  State_126776_Name = {
    Text = "<WitherKeywords:陶酔>"
  },
  State_126783_Name = {
    Text = "一時的に廃棄されました"
  },
  State_126784_Desc = {
    Text = "受ける固定毒が[DescArg1]％増加し、与えるダメージが[DescArg2]％減少する。最大[DescArg3]点。"
  },
  State_126784_Name = {Text = "陶酔"},
  State_126785_Desc = {
    Text = "他の覚醒体がX枚の指令カードを使用した後にこのカードを使用すると、後続効果を発動する。自身の指令カードを使用するか、ターン終了後にカウントがリセットされる。"
  },
  State_126789_Desc = {
    Text = "すべての敵に2点の<WitherKeywords:陶酔>を付与する。"
  },
  State_126789_Name = {
    Text = "<WitherKeywords1:心を交わす>"
  },
  State_126790_Desc = {
    Text = "すべての敵から<WitherKeywords:酔い痴れ>を除去する。1点除去するごとに、対象の最大ライフ[DescArg1]％分<FixedDamage:純粋ダメージ>を与え、40％の毒を発動する。"
  },
  State_126790_Name = {
    Text = "<WitherKeywords2:魂を奪う>"
  },
  State_126803_Desc = {
    Text = "次に発射する[DescArg1]枚の指令カードは3ターン後の未来に送られる。"
  },
  State_126803_Name = {
    Text = "運命の紡ぎ車"
  },
  State_126893_Name = {
    Text = "ステータス@運命超次元のみの識別"
  },
  State_126895_Desc = {
    Text = "このカードが与えるダメージ、固定力と触腕ダメージ上昇、固定毒、固定カウンターの最終効果が [DescArg1]％上昇し、与える固定シールド、固定ライフ回復、力減少効果が [DescArg2]％上昇する。「奇点ビーコン」を持つカードは「超次元空間」に複製できなくなる。"
  },
  State_126895_Name = {
    Text = "<SingularityKeywords:特異点ビーコン[DescArg2]>"
  },
  State_126896_Name = {
    Text = "ステータス@超越の光カードの計算力調和スタック数を減少"
  },
  State_126900_Name = {
    Text = "ステータス@運命超次元職業初期化2"
  },
  State_126901_Name = {
    Text = "ステータス@運命超次元職業初期化1"
  },
  State_126903_Name = {
    Text = "ステータス@超次元空間超距マーク"
  },
  State_126927_Desc = {
    Text = "唯一装備：装備者が与える固定の毒と毒効果が<WeaponEffect_Num:[StateArg1]%>増加する。装備者が毎ターン初めて「共鳴」を発動した時、<WeaponEffect_Num:[StateArg2]>狂気を獲得する。"
  },
  State_126927_WeaponDesc = {
    Text = "装備者が与える固定の毒と毒効果が<WeaponEffect_Num:[StateArg1]%>増加する。装備者が毎ターン初めて「共鳴」を発動した時、<WeaponEffect_Num:[StateArg2]>狂気を獲得する。"
  },
  State_126990_Name = {
    Text = "<IntoxicationColour:毒>"
  },
  State_127108_Desc = {
    Text = "すべての敵に5点の<WitherKeywords:陶酔>を付与する。"
  },
  State_127108_Name = {
    Text = "<WitherKeywords3:心を交わす>"
  },
  State_127109_Desc = {
    Text = "すべての敵から<WitherKeywords:酔い痴れ>を除去する。1点除去するごとに、体力の20％分の猩紅炉を蓄積し、対象の最大ライフ[DescArg1]％分<FixedDamage:純粋ダメージ>を与え、40％の毒を発動する。"
  },
  State_127109_Name = {
    Text = "<WitherKeywords4:魂を奪う>"
  },
  State_127176_Desc = {
    Text = "1点ごとに受ける固定毒が5%増加し、与えるダメージが[DescArg1]％減少する。最大[DescArg2]点。"
  },
  State_127176_Name = {
    Text = "<WitherKeywords0:陶酔>"
  },
  State_127264_Desc = {
    Text = "このカードを使用した場合、「覚者」は1点の<MonsterTimeBeacon:ループ>を獲得する。このカードを捨てた場合、「覚者」は<MonsterTimeBeacon:ループ>を1点失う。"
  },
  State_127264_Name = {
    Text = "<MonsterSightUnbound:超越の眼>"
  },
  State_127266_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_127266_Name = {Text = "未覚醒"},
  State_127267_Desc = {
    Text = "ターン終了後、1点の<MonsterTimeBeacon:ループ>を獲得する。"
  },
  State_127267_Name = {
    Text = "エントロピー逆行"
  },
  State_127271_Desc = {
    Text = "「キーオーダー」を発動後、1点の<MonsterTimeBeacon:ループ>を獲得する。"
  },
  State_127271_Name = {
    Text = "メビウスの囚人"
  },
  State_127272_Desc = {
    Text = "最大3点。「覚者」が行動する際に<MonsterTimeBeacon:ループ>を3点持つ場合、<MonsterTimeBeacon:ループ>の効果を発動し、<MonsterTimeBeacon:ループ>をリセットし、デバフを解除する。"
  },
  State_127272_Name = {
    Text = "<WhiteWord:ループ>"
  },
  State_127275_Desc = {
    Text = "1点ごとに受ける固定毒が5%増加し、与えるダメージが[DescArg1]％減少する。最大[DescArg2]点。"
  },
  State_127275_Name = {
    Text = "<WitherKeywords:陶酔>"
  },
  State_127276_Desc = {
    Text = "このカードを使用した場合、「覚者」は1点の<MonsterTimeBeacon:ループ>を獲得する。このカードを捨てた場合、「覚者」は<MonsterTimeBeacon:ループ>を1点失う。"
  },
  State_127276_Name = {
    Text = "<MonsterSightUnbound:超越の眼>"
  },
  State_127312_Desc = {
    Text = "覚醒体の人格の深化が＋12に達すると、「最終法則」が発動し、発動後にいくつかの独特な効果を得ることができます。"
  },
  State_127312_Name = {
    Text = "<UltraPotencyKeywords:最終法則>"
  },
  State_127705_Desc = {
    Text = "カードに細工が施されている！発射後に[Layer]点のダメージを受け、<CardKeyWord:暗中破壊>のスタック数を半減させる。"
  },
  State_127705_Name = {
    Text = "<CardKeyWord:陰の妨害>"
  },
  State_127705_WeaponDesc = {
    Text = "カードを使用すると[StateArg1]ダメージを受ける。"
  },
  State_127708_Desc = {
    Text = "相手が非指令カードを使用した後、すべての味方は[DescArg1]点の一時的な<PowerIconKeywords:力>を獲得する。「古の残り火」がすべて除去された場合は無効になる。"
  },
  State_127708_Name = {
    Text = "混沌の糸"
  },
  State_127709_Name = {
    Text = "黒の糸プレイヤー状態"
  },
  State_127710_Name = {
    Text = "黒の糸がトリガーされた"
  },
  State_128026_Name = {
    Text = "白の糸プレイヤー状態"
  },
  State_128027_Desc = {
    Text = "相手が指令カードを使用した後、すべての味方は[DescArg1]点の一時的な<ReinforcePVEKeywords:堅固>を獲得する。「古の残り火」がすべて除去された場合は無効になる。"
  },
  State_128027_Name = {
    Text = "秩序の糸"
  },
  State_128028_Desc = {
    Text = "カードに細工が施されている！発射後に<FixedDamage:純粋ダメージ>を受け、<BrokenCard:暗中破壊>のスタック数を半減させる。"
  },
  State_128028_Name = {
    Text = "<CardKeyWord:陰の妨害>"
  },
  State_128028_WeaponDesc = {
    Text = "カードを使用すると[StateArg1]ダメージを受ける。"
  },
  State_128029_Name = {
    Text = "白の糸がトリガーされた"
  },
  State_128067_Name = {
    Text = "状態@冷蜘蛛の侍女灰燼リスナー"
  },
  State_128069_Name = {
    Text = "ステータス@冷たい蜘蛛の侍女の纏着命中検出"
  },
  State_128071_Name = {
    Text = "ステータス@冷蛛侍女の前置位置には召喚マークが必要です"
  },
  State_128073_Desc = {
    Text = "行動を終了するたび、[DescArg1]点の<ParcloseIconKeywords:バリア>と[DescArg2]点の<Chapter5_Monster_Fervor1:狂熱>を獲得する。"
  },
  State_128073_Name = {
    Text = "織母の揺りかご"
  },
  State_128082_Desc = {
    Text = "使用後、ハムリンは3狂気を獲得。"
  },
  State_128082_Name = {
    Text = "<XushiBKeywords:高揚楽音>"
  },
  State_128086_Desc = {
    Text = "相手が指令カードを使用した後、[DescArg1]点の<Chapter5_Monster_Fervor1:狂熱>を獲得する。「古の残り火」をすべて除去した場合、後列の味方と位置を交換する。"
  },
  State_128086_Name = {
    Text = "運命の輪"
  },
  State_128087_Name = {
    Text = "ステータス@冷蛛の侍女白の輪廻発動マーク"
  },
  State_128089_Name = {
    Text = "白の輪廻が発動"
  },
  State_128216_Name = {
    Text = "白の輪廻プレイヤー状態"
  },
  State_128245_Desc = {
    Text = "ターン開始後にクリアし、10層に達した後、次にカードを発射すると即座に行動し、<Chapter5_Monster_Fervor2:狂熱>を除去し、意図を<FragileIconKeywords:脆弱>を付与し、<BrokenCard:暗中破壊>の「崩解の糸」をランダムに追加する。"
  },
  State_128245_Name = {
    Text = "一時的な狂熱"
  },
  State_128246_Name = {
    Text = "黒の輪廻プレイヤー状態"
  },
  State_128247_Desc = {
    Text = "死亡後復活し、ダメージ無効で100%のライフを持つ。「運命の狂熱」に意図を切り替える：行動終了後、[DescArg1]点の<PowerIconKeywords:力>と[DescArg2]層の<Chapter5_Monster_Fervor2:狂熱>を獲得します。"
  },
  State_128247_Name = {
    Text = "破繭新生"
  },
  State_128248_Desc = {
    Text = "ターン開始時に解除する。10点に達した後にカードを使用すると即座に行動し、<Chapter5_Monster_Fervor1:狂熱>を除去し、行動予測は<WeaknessIconKeywords:虚弱>を付与し、ランダムな指令カードを封印する「呪縛の網」に転換する。"
  },
  State_128248_Name = {
    Text = "一時的な狂熱"
  },
  State_128250_Name = {
    Text = "黒の輪廻が触発されました"
  },
  State_128251_Desc = {
    Text = "相手が非指令カードを使用した後、自身は[DescArg1]点の<Chapter5_Monster_Fervor2:狂熱>を受ける。「古の残り火」をすべて除去した場合、後列の味方と位置を交換する。"
  },
  State_128251_Name = {
    Text = "淵獄の輪"
  },
  State_128253_Desc = {
    Text = "死亡後復活し、ダメージを無効化しライフが100%になる。行動予測は「運命の狂熱」に転換する。「運命の狂熱」：行動を終了するたび、[DescArg1]点の<ParcloseIconKeywords:バリア>と[DescArg2]点の<Chapter5_Monster_Fervor1:狂熱>を獲得。"
  },
  State_128253_Name = {
    Text = "破繭新生"
  },
  State_128257_Desc = {
    Text = "行動を終了するたび、[DescArg1]点の<PowerIconKeywords:力>と[DescArg2]点の<Chapter5_Monster_Fervor2:狂熱>を獲得する。"
  },
  State_128257_Name = {
    Text = "織母の囁き"
  },
  State_128643_Name = {
    Text = "ステータス@プレイヤー今ターンに発射した症状カウント"
  },
  State_128644_Desc = {
    Text = "ターン開始時に解除する。10点に達した後にカードを使用すると即座に行動し、<Chapter5_Monster_Fervor3:狂熱>を除去し、行動予測をランダムに転換する。"
  },
  State_128644_Name = {
    Text = "一時的な狂熱"
  },
  State_128645_Desc = {
    Text = "行動予測は4種類からランダムに選ばれ、重複しない。「狂気解放」を発動すると、即座に行動予測を転換する。指令カードを使用した後、1点の<Chapter5_Monster_Fervor3:狂熱>を獲得する。"
  },
  State_128645_Name = {
    Text = "万象同調"
  },
  State_128646_Name = {
    Text = "ステータス@錯乱の運命失格重撃カード出し検出"
  },
  State_128648_Desc = {
    Text = "次のターン開始まで、指令カードを1枚使用するたびに[DescArg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  State_128648_Name = {
    Text = "暴怒の繭"
  },
  State_128692_Desc = {
    Text = "アクティブダメージまたは触腕ダメージを受けた時、同量の「古の残り火」を除去し、除去した量の300%のライフを失う。その他のダメージを受けた場合は半分を除去する。「古の残り火」の点数は毎ターンリセットされる。"
  },
  State_128692_Name = {
    Text = "<AshesPastKeyWord:古の残り火>"
  },
  State_128695_Name = {
    Text = "状態@錯乱の運命意図マーク"
  },
  State_129297_Desc = {
    Text = "次の[Layer]回の戦闘開始時、すべての敵のライフを1にする。"
  },
  State_129297_Name = {
    Text = "小さな「N」の協力"
  },
  State_129569_Name = {
    Text = "ステータス@混乱した運命の歓喜劇場触発マーク"
  },
  State_129570_Name = {
    Text = "ステータス@混乱した運命宿命のささやき発動マーク"
  },
  State_129571_Name = {
    Text = "ステータス@ずれた運命の無限虚無発動マーク"
  },
  State_129612_Desc = {
    Text = "行動予測は4種類からランダムに選ばれ、重複しない。「狂気解放」を発動すると、即座に行動予測を転換する。指令カードを使用した後、1点の<Chapter5_Monster_Fervor3:狂熱>を獲得する。"
  },
  State_129612_Name = {
    Text = "万象同調"
  },
  State_129625_Desc = {
    Text = "行動予測は4種類からランダムに選ばれ、重複しない。「狂気解放」を発動すると、即座に行動予測を転換する。指令カードを1枚使用するたびに、1点の<Chapter5_Monster_Fervor3:狂熱>を獲得する。行動予測を転換するたびに、1点の「錯乱する運命」を獲得する。"
  },
  State_129625_Name = {
    Text = "万象同調"
  },
  State_129643_Desc = {
    Text = "行動予測を転換するたびに1点獲得する。10点に達すると、行動予測は転換不可かつ高ダメージとデバフを与える「繭を破りし狂宴」に転換する。"
  },
  State_129643_Name = {
    Text = "錯乱する運命"
  },
  State_129644_Name = {
    Text = "ねじれ融合ロック意図"
  },
  State_129650_Desc = {
    Text = "チームユニーク：装備者が覚醒体「環行・ラモンナ」の場合、他の覚醒体が探索ステージで得る同調率を<WeaponEffect_Num:[StateArg1]%>上昇させるが、自身は同調率を得ない。"
  },
  State_129650_WeaponDesc = {
    Text = "装備者が覚醒体「環行・ラモンナ」である場合、調査完了時に他の覚醒体が獲得する同調率が<WeaponEffect_Num:[StateArg1]%>増加する。ただし、自身は同調率を獲得しない。"
  },
  State_129761_Desc = {
    Text = "インターフェースを変更し、プレイヤーのゲーム内成長強度の返り値を、1層ごとに1%増加させる。"
  },
  State_129761_Name = {
    Text = "局内成長強度修正"
  },
  State_129845_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_129845_Name = {Text = "未覚醒"},
  State_129846_Name = {
    Text = "断糸震鳴カウント"
  },
  State_129848_Desc = {
    Text = "「次元の裂け目」からカードを[DescArg1]枚出すたびに、[DescArg2]点の<BrokenCard:陰の妨害>を付与する。"
  },
  State_129848_Name = {
    Text = "人形劇の開幕"
  },
  State_129849_Desc = {
    Text = "相手が毎ターン初めて使用した指令カードのコピーを「次元の裂け目」に入れ、<DepleteIconKeywords:除外>を付与する。毎ターン初めて「キーオーダー」を発動した後、一番左のカードを取り出し山札の一番上に置く。"
  },
  State_129849_Name = {
    Text = "運命の糸を弄ぶ"
  },
  State_129850_Desc = {
    Text = "「次元の裂け目」の指令カード1枚につき、プレイヤーの手札の上限が1減少する。「次元の裂け目」が上限に達したあとにカードを使用すると、「永劫の網」は即座に行動し、「次元の裂け目」をリセットして行動予測を「運命を超えし哀歌」に転換する。"
  },
  State_129850_Name = {
    Text = "断糸震鳴"
  },
  State_129854_Desc = {
    Text = "「次元の裂け目」の指令カード1枚につき、プレイヤーの手札の上限が1減少する。「次元の裂け目」が上限に達したあとにカードを使用すると、「永劫の網」は即座に行動し、「次元の裂け目」をリセットして行動予測を「運命よ、我が意のままに」に転換する。"
  },
  State_129854_Name = {
    Text = "断糸震鳴"
  },
  State_129864_Desc = {
    Text = "カードを使うたびに1点の「眠気」を解除。ターン開始時に12点の「眠気」を回復。"
  },
  State_129864_Name = {Text = "激怒"},
  State_129865_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_129865_Name = {Text = "未覚醒"},
  State_129872_Desc = {
    Text = "一時的な変数。"
  },
  State_129872_Name = {
    Text = "カウンター1"
  },
  State_129873_Desc = {
    Text = "[Layer]層のカウントステータスを取得します _カウンター1_。"
  },
  State_129873_Name = {
    Text = "パッケージテスト1"
  },
  State_129874_Desc = {
    Text = "一時的な変数。"
  },
  State_129874_Name = {Text = "アンプ1"},
  State_130358_Desc = {
    Text = "次に使用する指令カードは2回効果を発動する。"
  },
  State_130358_Name = {
    Text = "操り人形"
  },
  State_130387_Desc = {
    Text = "「操り人形」が除外された後、以降のターンで最初に使用する指令カードは追加で2回効果を発動する。ボス戦では、すべての覚醒体が50狂気を獲得し、1000キーエネルギーを獲得する。"
  },
  State_130387_Name = {
    Text = "運命の葬儀"
  },
  State_130388_Name = {
    Text = "<RetainIconKeywords:保持>：[DescArg1]キーエネルギーを獲得"
  },
  State_130389_Desc = {
    Text = "使用後、すべての覚醒体は[DescArg1]狂気を獲得"
  },
  State_130389_Name = {
    Text = "使用後、すべての覚醒体は[DescArg1]狂気を獲得"
  },
  State_130390_Desc = {
    Text = "行動力上限と手札の上限が1増加する。"
  },
  State_130390_Name = {
    Text = "過剰な描写"
  },
  State_130391_Desc = {
    Text = "「症状カード」を1枚使用するたび、「操り人形」の行動力消費が1減少する。"
  },
  State_130391_Name = {
    Text = "穢れの余韻"
  },
  State_130490_Desc = {
    Text = "このカードが与えるダメージ、シールド、治療、力、衰弱、触腕ダメージ、固定毒、固定カウンターが独立して1+[Layer]%増加します。"
  },
  State_130490_Name = {
    Text = "奇点ビーコンα"
  },
  State_130498_Desc = {
    Text = "次に使用する指令カードは追加で2回効果を発動する。"
  },
  State_130498_Name = {
    Text = "運命の葬儀"
  },
  State_130500_Desc = {
    Text = "ボス戦中、死亡抵抗+100%。「死亡抵抗」が発動した後、次のターンに「操り人形」は指令カードを強制的に使用せず、手札にある指令カードを1枚選んで使用する。"
  },
  State_130500_Name = {
    Text = "殉教者の回顧"
  },
  State_130501_Desc = {
    Text = "次の指令カードの行動力消費が0になります。"
  },
  State_130501_WeaponDesc = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_130512_Desc = {
    Text = "次に使用する指令カードは2回効果を発動し、行動力消費が2減少する。"
  },
  State_130512_Name = {
    Text = "操り人形"
  },
  State_130517_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時とターン開始時、以下の効果のいずれかをランダムに発動：<Energy:[Energy:StateArg1]>狂気を獲得し自身を<PVPSlowKeywords:鈍足>にする；<Energy:[Energy:StateArg3]>狂気を獲得；<Energy:[Energy:StateArg4]>と[StateArg5]枚の<PVPDerivativeCardKeywords_17:「霊感」>を獲得。"
  },
  State_130517_Name = {
    Text = "ギャンブルの知恵"
  },
  State_131046_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、自身は<Block:[Block:StateArg1]>点のシールドと<DelayKeywords:レイテンシ>：<Energy:[Energy:StateArg2]>狂気を獲得する。"
  },
  State_131046_Name = {
    Text = "遠いエデン"
  },
  State_131047_Desc = {
    Text = "このターン中、[Layer]回目に発動するキーオーダーは、効果が2回発動する。"
  },
  State_131047_Name = {
    Text = "ダブルキーオーダー"
  },
  State_131048_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：各ターン初めて「スキル」を発射した後、<HPAndShieldMin:ライフとシールドが最も低い>敵に <Damage:[Damage:StateArg1]> のダメージを与える。"
  },
  State_131048_Name = {
    Text = "囚われた狂気"
  },
  State_131055_Desc = {
    Text = "ドロー枚数-1。すべての覚醒体が獲得するシールドとライフ回復効果が20%増加。"
  },
  State_131055_Name = {
    Text = "毛並みを整える"
  },
  State_131056_Desc = {
    Text = "ライフを失った後、同量のレイテンシ狂気をシールドに変換する。"
  },
  State_131056_Name = {
    Text = "渦流護身"
  },
  State_131058_Desc = {
    Text = "すべての覚醒体の基礎狂気が10増加する。「狂気解放」を発動後、1点の行動力を獲得する。覚醒体ごとに毎ターン1回のみ発動可能。"
  },
  State_131058_Name = {
    Text = "頬をすり寄せる"
  },
  State_131059_Name = {
    Text = "モスクの必殺技アップグレードマーク"
  },
  State_131061_Desc = {
    Text = "キーエネルギー上限と「キーオーダー」発動時に消費するキーエネルギー+350。毎ターン初めて発動する「キーオーダー」は効果が2回発動する。"
  },
  State_131061_Name = {
    Text = "おやつを与える"
  },
  State_131064_Desc = {
    Text = "「狂気解放」を発動後、1点の行動力を獲得する。覚醒体ごとに毎ターン1回のみ発動可能。"
  },
  State_131064_Name = {
    Text = "頬をすり寄せる"
  },
  State_131069_Desc = {
    Text = "すべての覚醒体が獲得するシールドとライフ回復効果が20%増加。"
  },
  State_131069_Name = {
    Text = "毛並みを整える"
  },
  State_131073_Desc = {
    Text = "唯一装備：戦闘開始時、基本狂気の<WeaponEffect_Num:[StateArg1]%>分の狂気を獲得。装備者の狂気解放の最終ダメージが基本狂気の<WeaponEffect_Num:[StateArg2]%>分増加。「怒涛」姿勢に切り替えると、現在の界域知識の<WeaponEffect_Num:[StateArg3]%>分の一時的な界域知識を獲得。クールダウン3ターン。"
  },
  State_131073_WeaponDesc = {
    Text = "戦闘開始時に[DescArg1]点の狂気を獲得する。装備者の狂気解放の最終ダメージが[DescArg2]％増加する。「怒涛」姿勢に切り替えると、[DescArg3]点の一時的な領域マスタリーを獲得し、3ターンのクールダウン（現在の残り[DescArg4]ターン）。"
  },
  State_131078_Desc = {
    Text = "毎ターン初めて発動する「キーオーダー」は効果が2回発動する。"
  },
  State_131078_Name = {
    Text = "おやつをあげる"
  },
  State_131118_Desc = {
    Text = "ダメージやライフ減少の値は、最大ライフの3%を超えることはない。"
  },
  State_131118_Name = {
    Text = "千糸の繭"
  },
  State_131123_Desc = {
    Text = "ターン開始時に解除する。10点に達した後にカードを使用すると即座に行動し、次の行動予測に転換し、<Chapter5_Monster_Fervor4:狂熱>を除去する。"
  },
  State_131123_Name = {
    Text = "一時的な狂熱"
  },
  State_131127_Desc = {
    Text = "運命の拘束された姿。相手が「指令カード」を1枚使用するたび、1点の「一時的な狂熱」を獲得する。"
  },
  State_131127_Name = {
    Text = "運命の誓約"
  },
  State_131134_Desc = {
    Text = "死亡後、ネフレアは[DescArg1]層の一時的な狂熱を獲得するが、最大HPの3％を失う。"
  },
  State_131134_Name = {
    Text = "淵獄の門"
  },
  State_131186_Desc = {
    Text = "使用後、追加で1回効果を発動し、[DescArg1]ダメージを受ける。"
  },
  State_131186_Name = {
    Text = "<ExclamationPointColour:運命の断片>"
  },
  State_131188_Desc = {
    Text = "使用した「技能」が「次元裂隙」に入り、すべての同名技能に「運命の残片」を付与する。次元裂隙を離れた後に解除される。次元裂隙が満杯の時、「背信の網」ネフレアの行動後に次元裂隙を空にし、次の意図を強力な狂気バーストに変換する。"
  },
  State_131188_Name = {
    Text = "次元の裂け目"
  },
  State_131191_Name = {
    Text = "認知障害"
  },
  State_131242_Desc = {
    Text = "このカードが与えるダメージ、シールド、治療、力、衰弱、触腕ダメージ、固定毒、固定カウンターが独立して1+[Layer]%増加します。"
  },
  State_131242_Name = {
    Text = "奇点ビーコンβ"
  },
  State_131258_Desc = {
    Text = "紡ぎ車を回し、誤った運命を乱す。「キーオーダー」を発動するか「運命の断片」が付与されたカードを使用した後、1点除去する。すべて除去した場合、アラクネが「糸よ、あるべき場所へ」を発動して追撃し、高ダメージを与える。3回発動すると敵の「千糸の繭」を完全に破壊する！"
  },
  State_131258_Name = {
    Text = "乱れた運命の網"
  },
  State_131261_Name = {
    Text = "破滅の劇場"
  },
  State_131351_Desc = {
    Text = "他の覚醒体が狂気解放を発動後、1点を消費し、モスが「渦巻き！流れろ！弾て！」を発動して追撃する。"
  },
  State_131351_Name = {
    Text = "渦巻き充填"
  },
  State_131439_Desc = {
    Text = "次に使用する指令カードは2回効果を発動し、行動力消費が0になる。"
  },
  State_131439_Name = {
    Text = "操り人形"
  },
  State_131637_Desc = {
    Text = "死亡後、直ちにランダムな「淵獄蜘群」または「冷蛛群」を1体召喚し、その「群集効果」を1層低下させる。"
  },
  State_131637_Name = {
    Text = "クラスター効果"
  },
  State_131638_Desc = {
    Text = "死亡後、直ちにランダムな「砕相母体」または「纏糸母体」を1体召喚し、その「群集効果」を1層低下させる。"
  },
  State_131638_Name = {
    Text = "クラスター効果"
  },
  State_131645_Desc = {
    Text = "唯一装備：怒涛モードに切り替えると、現在の界域知識の<WeaponEffect_Num:[StateArg1]%>分の一時的な界域知識を獲得する。クールダウン3ターン。"
  },
  State_131645_WeaponDesc = {
    Text = "「怒涛」モードに切り替えると、[DescArg2]点の一時的な領域マスタリーを獲得し、クールダウンは3ターン（現在の残りは[DescArg1]ターン）。"
  },
  State_131657_Desc = {
    Text = "他の覚醒体が狂気解放を発動後、1点を消費し、モスが「渦巻き！流れろ！弾て！」を発動して追撃する。"
  },
  State_131657_Name = {
    Text = "<WhirlpoolKeywords:渦流き充填>"
  },
  State_131660_Desc = {
    Text = "1層ごとに狂気解放の狂気要求が1ポイント増加します。"
  },
  State_131660_Name = {
    Text = "狂気消費固定値修正"
  },
  State_131675_Desc = {
    Text = "このカードは次回使用時に[StateArg1]%の確率で追加でもう1回発動する。"
  },
  State_131675_Name = {
    Text = "<CardKeyWord:ギャンブル>"
  },
  State_131684_Desc = {
    Text = "次の[Layer]回の「渦巻き！流れろ！弾て！」が2回発動する。"
  },
  State_131684_Name = {
    Text = "モスケン！大！爆！撃！"
  },
  State_131749_Desc = {
    Text = "唯一装備：探索開始後、「豪賭の知恵」を1枚山札に追加する。「豪賭の知恵」：1行動力を消費する。手札のすべての指令カードをランダムに山札に置き、その指令カードは次に出す時に<WeaponEffect_Num:[StateArg1]%>の確率で1回追加で発動し、置いたカードの1枚ごとにすべての覚醒体は2狂気を獲得。<RetainIconKeywords:保持>。<DepleteIconKeywords:除外>。<GuyouKeywords:固有>。"
  },
  State_131749_WeaponDesc = {
    Text = "探索開始後、「豪賭の知恵」を1枚山札に追加する。「豪賭の知恵」：1行動力を消費する。手札のすべての指令カードをランダムに山札に置き、その指令カードは次に出す時に<WeaponEffect_Num:[StateArg1]%>の確率で1回追加で発動し、置いたカードの1枚ごとにすべての覚醒体は2狂気を獲得。<RetainIconKeywords:保持>。<DepleteIconKeywords:除外>。<GuyouKeywords:固有>。"
  },
  State_131769_Name = {
    Text = "ステータス@繁殖血肉職業初期化1"
  },
  State_131779_Desc = {
    Text = "[Layer]回使用した後に捨て札に行き、回数をリセットする。「刻印」は初めて使用した時のみ有効。"
  },
  State_131779_Name = {
    Text = "[Layer]回使用可能"
  },
  State_131789_Desc = {
    Text = "選択肢。tidが[Layer]のカードを1枚手札に追加する。"
  },
  State_131789_Name = {
    Text = "指定されたカードを追加"
  },
  State_131807_Name = {
    Text = "ステータス@繁殖血肉のみの識別"
  },
  State_131824_Name = {
    Text = "ステータス@モンスター・タヴィ切り替え意図プレイヤーリスナー"
  },
  State_131846_Desc = {
    Text = "死亡後、直ちにランダムな「淵獄蜘群」または「冷蛛群」を1体召喚し、その「群集効果」を1層低下させる。"
  },
  State_131846_Name = {
    Text = "クラスター効果"
  },
  State_131908_Desc = {
    Text = "対象のライフ、シールド、狂気を分配しますが、戦闘統計は生成しません。"
  },
  State_131908_Name = {
    Text = "腐敗の饗宴跳び板"
  },
  State_131909_Desc = {
    Text = "このステータスを持っていると、狂気解放を使用できます。"
  },
  State_132366_Desc = {
    Text = "他の覚醒体が打撃カードを使用した後、追撃を行う"
  },
  State_132366_Name = {Text = "追撃"},
  State_132465_Desc = {
    Text = "この覚醒体が与えるダメージ、シールド、治療、力量、衰弱、触腕ダメージ、固定中毒、固定反撃が上昇し、独立乗算 1+[Layer]%。"
  },
  State_132465_Name = {
    Text = "強化捕食α"
  },
  State_132469_Desc = {
    Text = "この覚醒体が与えるダメージ、シールド、治療、力量、衰弱、触腕ダメージ、固定中毒、固定反撃が上昇し、独立乗算 1+[Layer]%。"
  },
  State_132469_Name = {
    Text = "強化捕食β"
  },
  State_132539_Desc = {
    Text = "集合テスト造物"
  },
  State_132539_Name = {
    Text = "集合テスト造物"
  },
  State_132539_WeaponDesc = {Text = "テスト"},
  State_132560_WeaponDesc = {
    Text = "翠火が [Damage:StateArg2] 回のダメージを与えるたびに、【みどりのほのお】を1枚獲得する。"
  },
  State_132564_WeaponDesc = {
    Text = "翠火が [Damage:StateArg2] 回のダメージを与えるたびに、【みどりのほのお】を1枚獲得する。"
  },
  State_132565_WeaponDesc = {
    Text = "翠火が [Damage:StateArg2] 回のダメージを与えるたびに、【みどりのほのお】を1枚獲得する。"
  },
  State_132598_Desc = {
    Text = "このターン中、触腕ダメージを与える時、追加でダメージ値の [Layer]％ の中毒を与える。"
  },
  State_132598_Name = {
    Text = "崩壊の執念"
  },
  State_132609_Desc = {
    Text = "彫刻者がシールドを付与するとき、[StateArg1] の触手ダメージが上昇。"
  },
  State_132609_Name = {
    Text = "忘我の境地"
  },
  State_132609_WeaponDesc = {
    Text = "彫刻者がシールドを付与するとき、[StateArg1] の触手ダメージが上昇。"
  },
  State_132669_Desc = {
    Text = "この覚醒体のカードが与えるダメージ、シールド、治療、力量、衰弱、触腕ダメージ、固定中毒、固定反撃が上昇し、独立乗算 1+[Layer]%。"
  },
  State_132669_Name = {
    Text = "命定超次元α"
  },
  State_132840_Name = {
    Text = "「24」の指令カードの人格効果ボーナスが2倍になる。「24」が狂気解放を発動した後、このターンの人格効果の2倍ボーナスは無効になる。"
  },
  State_132891_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時<StrongEffectKeywords:特効>+[StateArg1]。他の味方が狂気解放を発動した後、<PVPOneMeetingKeywords:一期一会>を付与する。"
  },
  State_132891_Name = {
    Text = "桜花の幻想"
  },
  State_132892_Desc = {
    Text = "·獲得時に他の味方の「一期一会」ステータスを除去し、「桜の下の迷い」を装備している味方の数に等しい強力効果を獲得する（最大 3 層）。\n·「桜の下の迷い」を装備しているキャラクターは「一期一会」を獲得できない。"
  },
  State_133294_Name = {
    Text = "王邸の招待状"
  },
  State_133353_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備後、装備者の「攻撃」「指令カード」「狂気爆発」の説明を認識できなくなるが、各ダメージ・シールド・治癒がランダムに[StateArg1]%〜[StateArg2]%増加する。"
  },
  State_133353_Name = {
    Text = "汚泥の中の童話"
  },
  State_133354_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：この命輪は死亡後も保留される。装備者が死亡した時と死亡ステータス中の後続 [Layer] ターン終了後、他の味方が <Heal:[Heal:StateArg1]> <PVPFeatheredSeedsKeyWords:羽種>とライフを獲得する。"
  },
  State_133354_Name = {
    Text = "花香る世界を願って"
  },
  State_133369_Desc = {
    Text = "次に出す [DescArg1] 枚のタヴィ以外の指令カードが 2 回発動する。"
  },
  State_133369_Name = {
    Text = "シルバーキーの門を越える"
  },
  State_133372_Desc = {
    Text = "現在超次元ターン中であれば、特異点跳躍効果を発動する。「特異点湮滅」もこのターン中、次の特異点跳躍を必ず発動する。"
  },
  State_133372_Name = {
    Text = "<SingularityKeywords:特異点跳躍>"
  },
  State_133391_Desc = {
    Text = "このステータスの点数がターゲットのHPを以上の場合、すべての運命の裁きを除去し、ターゲットを即座に撃破する。"
  },
  State_133391_Name = {
    Text = "<CutKeywords:運命の裁き>"
  },
  State_133395_Desc = {
    Text = "次に使用する指令カード[Layer]枚は「次元転移」を発動する。"
  },
  State_133395_Name = {
    Text = "次元転移"
  },
  State_133717_Desc = {
    Text = "現在の所有者は [Layer]、そのすべての現在および未来のカードに対応する属性が付与される（現在：カード封印）。"
  },
  State_133717_Name = {
    Text = "カード属性伝播"
  },
  State_133774_Desc = {
    Text = "1層ごとにこのカードが与えるダメージ、固定力と触腕ダメージ上昇、固定毒、固定カウンターの最終効果が2％上昇；固定シールド、固定ライフ回復、力減少の最終効果が1％上昇する。奇点ビーコンを持つカードは「次元シャトル」を発動できない。"
  },
  State_133774_Name = {
    Text = "<SingularityKeywords1:特異点ビーコン>"
  },
  State_133775_Desc = {
    Text = "1層ごとにすべての覚醒体カードが与えるダメージ、固定力と触腕ダメージ上昇、固定毒、固定カウンターの最終効果が2％上昇；固定シールド、固定ライフ回復、力減少の最終効果が1％上昇する。"
  },
  State_133775_Name = {
    Text = "<SingularityKeywords2:特異点プリズム>"
  },
  State_133961_Desc = {
    Text = "チームユニーク：探索開始後、「春の便り」を1枚生成してデッキに加える：行動力消費1、<WeaponEffect_Num:[StateArg1]> 点のキーエネルギーを獲得し、発射後永久に「桜満開」に変化する：行動力消費1、<WeaponEffect_Num:[StateArg2]> 点のキーエネルギーを獲得し、発射後永久に「花吹雪」に変化する：行動力消費1、<WeaponEffect_Num:[StateArg3]> 点のキーエネルギーを獲得し、発射後永久に「一期一会」に変化する：行動力消費1、解放済みの3つのランダムなキーオーダーから1つを選んで即時発動し2回効果を発揮する、発射後永久に「春の便り」に変化する。これらのカードはすべて「保留」を持つ。"
  },
  State_133961_WeaponDesc = {
    Text = "探索開始後、「春の便り」を1枚デッキに追加する：行動力消費1、<WeaponEffect_Num:[StateArg1]>点の銀鍵エネルギーを獲得し、使用後永久に「桜満開」に変化する：行動力消費1、<WeaponEffect_Num:[StateArg2]>点の銀鍵エネルギーを獲得し、使用後永久に「花吹雪」に変化する：行動力消費1、<WeaponEffect_Num:[StateArg3]>点の銀鍵エネルギーを獲得し、使用後永久に「一期一会」に変化する：行動力消費1、解放済みの3つのランダムなキーオーダーから1つを選んで即座に発動し、効果を2回発動する。使用後永久に「春の便り」に変化する。これらのカードはすべて「保留」を持つ。"
  },
  State_133994_Desc = {
    Text = "すべての覚醒体指令カードが与えるダメージ、固定力と触腕ダメージ上昇、固定毒、固定カウンターの最終効果が [DescArg1]％上昇し、与える固定シールド、固定ライフ回復、力減少効果が [DescArg2]％上昇する。"
  },
  State_133994_Name = {
    Text = "特異点プリズム"
  },
  State_133998_Desc = {
    Text = "このカードが与えるダメージ、シールド、力の増減が[DescArg2]%増加し、触腕ダメージ、ライフ回復、毒、反撃の最終効果が [DescArg1]%増加する。ターン終了時または使用後に解除される。"
  },
  State_133998_Name = {
    Text = "<TempPowerKeywords1:一時的な強化 [DescArg1]>"
  },
  State_133999_Desc = {
    Text = "1層ごとにこのカードが与えるダメージ、固定力と触腕ダメージ上昇、固定毒、固定カウンターの最終効果が2％上昇；固定シールド、固定ライフ回復、力減少の最終効果が1％上昇し、ターン終了時または発射後に除去される。"
  },
  State_133999_Name = {
    Text = "<TempPowerKeywords:一時的な強化>"
  },
  State_134100_Desc = {
    Text = "この戦闘中に致死ダメージを受けた時、復活し、[Layer] の生命を回復し、すべての覚醒体に [StateArg1] の狂気と [DescArg1] の臨時触腕ダメージを付与する。解除不可。"
  },
  State_134100_Name = {
    Text = "不死の極楽鳥"
  },
  State_134191_Desc = {
    Text = "唯一装備：探索開始後、「私用の昼休み」を1枚山札に追加する。「私用の昼休み」：1行動力を消費する。一時的なクリティカルダメージ+<WeaponEffect_Num:[StateArg1]%>。<RetainIconKeywords:保持>。<DepleteIconKeywords:除外>。"
  },
  State_134191_WeaponDesc = {
    Text = "探索開始後、「私用の昼休み」を1枚山札に追加する。「私用の昼休み」：1行動力を消費する。一時的なクリティカルダメージ+<WeaponEffect_Num:[StateArg1]%>。<RetainIconKeywords:保持>。<DepleteIconKeywords:除外>。"
  },
  State_134195_Desc = {
    Text = "このカードが与える固定中毒、固定反撃、固定運命裁断のスタック数が上昇し、独立乗算 1+[Layer]%。"
  },
  State_134195_Name = {
    Text = "三相の力α1"
  },
  State_134196_Desc = {
    Text = "この覚醒体の指令カードが与える固定中毒、固定反撃、固定運命裁断のスタック数が上昇し、独立乗算 1+[StateArg1]%。"
  },
  State_134196_Name = {
    Text = "三相の力β3"
  },
  State_134197_Desc = {
    Text = "このカードが与える固定中毒、固定反撃、固定運命裁断のスタック数が上昇し、独立乗算 1+[StateArg1]%。"
  },
  State_134197_Name = {
    Text = "三相の力β1"
  },
  State_134198_Desc = {
    Text = "この覚醒体の指令カードが与える固定中毒、固定反撃、固定運命裁断のスタック数が上昇し、独立乗算 1+[Layer]%。"
  },
  State_134198_Name = {
    Text = "三相の力α3"
  },
  State_134199_Desc = {
    Text = "この覚醒体の狂気爆発が与える固定中毒、固定反撃、固定運命裁断のスタック数が上昇し、独立乗算 1+[StateArg1]%。"
  },
  State_134199_Name = {
    Text = "三相の力β2"
  },
  State_134200_Desc = {
    Text = "この覚醒体の狂気爆発が与える固定中毒、固定反撃、固定運命裁断のスタック数が上昇し、独立乗算 1+[Layer]%。"
  },
  State_134200_Name = {
    Text = "三相の力α2"
  },
  State_134227_Desc = {
    Text = "最大[DescArg1]層まで蓄積できる。「狂気解放」使用後に他の覚醒体の指令カードを使用ごとに1層を消費して「無限の糸」の追撃を行う。"
  },
  State_134227_Name = {
    Text = "<SilkKeywords:織命>"
  },
  State_134231_Desc = {
    Text = "唯一装備：装備者が与えるシールドが<WeaponEffect_Num:[StateArg1]%>増加する。装備者が「追撃」を発動時、+<WeaponEffect_Num:[StateArg2]%>の一時強化、毎ターン最大5回まで累積可能。「次元転移」の発動時、装備者は<WeaponEffect_Num:[StateArg3]>狂気を獲得。"
  },
  State_134231_WeaponDesc = {
    Text = "装備者が与えるシールドが<WeaponEffect_Num:[StateArg1]%>増加する。装備者が「追撃」を発動時、+<WeaponEffect_Num:[StateArg2]%>の一時強化、毎ターン最大5回まで累積可能。「次元転移」の発動時、装備者は<WeaponEffect_Num:[StateArg3]>狂気を獲得。"
  },
  State_134237_Desc = {
    Text = "アラクネが運命を紡いで引き出した糸筋、最大[DescArg1]層。狂気爆発で消費して「<DerivativeCardKeywords_144:無尽の糸筋>」追撃を発動できる。「織命」は次の戦闘に引き継がれる。"
  },
  State_134237_Name = {Text = "織命"},
  State_134240_Desc = {
    Text = "次に[Layer]回「永遠の織成」を使用して、追加の「導きの糸」を山札と捨て札に加える。"
  },
  State_134240_Name = {
    Text = "運命の縛糸"
  },
  State_134261_Desc = {
    Text = "次の[Layer]回与えるダメージが2倍になる。"
  },
  State_134261_Name = {
    Text = "私的な休息"
  },
  State_134262_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」後、自身が次に与えるダメージが2倍になる。"
  },
  State_134262_Name = {
    Text = "私的な休息"
  },
  State_134285_Desc = {
    Text = "点数が対象のライフを上回った場合、すべての「運命の裁き」を除去し、即座に対象を撃破する。付与する「運命の裁き」はダメージ強化ボーナスを獲得する。"
  },
  State_134285_Name = {
    Text = "運命の裁き"
  },
  State_134313_Desc = {
    Text = "唯一装備：装備者が与えるシールドが<WeaponEffect_Num:[StateArg1]%>増加する。装備者が「追撃」を発動時、<WeaponEffect_Num:[StateArg2]%>の一時的な強化を増加し、毎ターン最大5回まで累積可能。"
  },
  State_134313_WeaponDesc = {
    Text = "装備者が与えるシールドが<WeaponEffect_Num:[StateArg1]%>増加する。装備者が「追撃」を発動時、<WeaponEffect_Num:[StateArg2]%>の一時的な強化を増加し、毎ターン最大5回まで累積可能。"
  },
  State_134384_Desc = {
    Text = "次に使用する指令カード[Layer]枚は「次元転移」を発動する。"
  },
  State_134384_Name = {
    Text = "次元転移"
  },
  State_134389_Desc = {
    Text = "このカードが与えるダメージ、固定力と触腕ダメージ上昇、固定毒、固定カウンターの最終効果が [DescArg1]％上昇し、与える固定シールド、固定ライフ回復、力減少効果が [DescArg2]％上昇する。「奇点ビーコン」を持つカードは「超次元空間」に複製できなくなる。"
  },
  State_134389_Name = {
    Text = "<SingularityKeywords:特異点ビーコン[DescArg2]>"
  },
  State_134391_Desc = {
    Text = "毎ターン最初に使用する指令カードの一時的な基本のコピーを、超次元空間に置く。超次元ターンではこの効果を発動できない。"
  },
  State_134391_Name = {
    Text = "<SingularityKeywords3:次元転移>"
  },
  State_135232_Name = {
    Text = "<AwakerCard_24Lost:<SingularityKeywords:特異点跳躍>：本ターンの残り時間内に他の覚醒体がコマンドカードを出した後、1層の<SilkKeywords:織命>を消費して「<DerivativeCardKeywords_137:無尽の糸>」追撃を発動>"
  },
  State_135233_Name = {
    Text = "<SingularityKeywords:特異点跳躍>：本ターンの残り時間内に他の覚醒体がコマンドカードを出した後、1層の<SilkKeywords:織命>を消費して「<DerivativeCardKeywords_137:無尽の糸>」追撃を発動"
  },
  State_135919_Name = {
    Text = "<AwakerCard_24Lost:<SingularityKeywords:特異点跳躍>：本ターンの残り時間内に他の覚醒体がコマンドカードを出した後、1層の<SilkKeywords:織命>を消費して「<DerivativeCardKeywords_137:無尽の糸>」追撃を発動>"
  },
  State_135920_Name = {
    Text = "<SingularityKeywords:特異点跳躍>：本ターンの残り時間内に他の覚醒体がコマンドカードを出した後、1層の<SilkKeywords:織命>を消費して「<DerivativeCardKeywords_137:無尽の糸>」追撃を発動"
  },
  State_135921_Desc = {
    Text = "覚醒体が与えるダメージが25%増加する。"
  },
  State_135921_Name = {
    Text = "<CardKeyWord:叱責、恩讐に報いん>"
  },
  State_138824_Desc = {
    Text = "輝ける命が自由を讃え、凱歌を高らかに奏でている。沙耶の狂気解放で消費してその効果を強化できる。このステータスは最大4層まで蓄積可能で、戦闘終了後も保持される。"
  },
  State_138824_Name = {
    Text = "<KaiHuajishu1:羽種>"
  },
  State_139039_Desc = {
    Text = "この覚醒体の今ターン次の狂気解放が与えるダメージ、固定シールド、固定ライフ回復、固定力、力減少、触腕ダメージアップ、固定毒、固定反撃の最終効果が [Layer]％ 上昇する。"
  },
  State_139039_Name = {
    Text = "<BreedingKeywords2:繁殖祭典>"
  },
  State_139687_Desc = {
    Text = "輝ける命が自由を讃え、凱歌を高らかに奏でている。沙耶の狂気解放で消費してその効果を強化できる。このステータスは最大4層まで蓄積可能で、戦闘終了後も保持される。"
  },
  State_139687_Name = {
    Text = "<KaiHuajishu:羽種>"
  },
  State_139688_Desc = {
    Text = "チームユニーク：行動力上限 +1、同種の効果は重複不可。装備者の基礎狂気が10点ごとに、与える固定<Corrosion:侵蝕>効果が <WeaponEffect_Num:[StateArg1]%> 上昇し、与える胎児融合が <WeaponEffect_Num:[Float:StateArg2]％> 上昇する。"
  },
  State_139688_WeaponDesc = {
    Text = "行動力上限 +1、同種の効果は重複不可。装備者の基礎狂気が10点ごとに、与える固定<Corrosion:侵蝕>効果が <WeaponEffect_Num:[StateArg1]%> 上昇し、与える胎児融合が <WeaponEffect_Num:[Float:StateArg2]％> 上昇する。"
  },
  State_139689_Desc = {
    Text = "チームユニーク：「猩紅炉」使用後、装備者は基礎狂気の<WeaponEffect_Num:[StateArg1]%>に相当する狂気を獲得する。3ターンクールダウン。"
  },
  State_139689_WeaponDesc = {
    Text = "「猩紅炉」使用後、装備者は基礎狂気の <WeaponEffect_Num:[StateArg1]%> に相当する狂気を獲得する。3ターンクールダウン。"
  },
  State_139977_Desc = {
    Text = "このラウンドに「打撃」を使用した場合、「打撃」+ [DescArg1]％ ダメージ貫通；使用しなかった場合、ラウンド終了時 +[Layer] バリア。"
  },
  State_139977_Name = {Text = "星獣"},
  State_140063_Desc = {
    Text = "これは次のターンから算力を前借りした「借用書」であり、次のターン開始後に[Layer]算力が差し引かれる。解除不可。"
  },
  State_140063_Name = {
    Text = "借用書持ち"
  },
  State_140068_Desc = {
    Text = "次の[DescArg1]枚の「技能」の算力消費 – [StateArg1]。"
  },
  State_140068_Name = {Text = "悟り"},
  State_140135_Desc = {
    Text = "1スタック毎に、この覚醒体の今ターン次の狂気解放が与えるダメージ、固定シールド、固定ライフ回復、固定力、力減少、触腕ダメージアップ、固定毒、固定反撃の最終効果が1％上昇する。"
  },
  State_140135_Name = {
    Text = "<BreedingKeywords2:繁殖祭典>"
  },
  State_140186_WeaponDesc = {
    Text = "くじらとびのすべてのダメージ回数＋1。"
  },
  State_140454_Desc = {
    Text = "チーム唯一：装備者自身、命輪、密契それぞれの1%の黒印ドロップごとに、戦闘終了後に最大HPの<WeaponEffect_Num:[StateArg1]%>を回復する。毎ラウンド終了時にその回復効果が30%減衰し、複数回は独立して計算される。「灰燼遺跡」で「感応」を発動した後、今回の「灰燼遺跡」のリフレッシュに黒印の消費が不要になる。"
  },
  State_140454_WeaponDesc = {
    Text = "チーム唯一：戦闘終了後、最大HPの<WeaponEffect_Num:[DescArg2]％>を回復（[DescArg1]）。毎ラウンド終了時にその回復効果が30％減少する。「灰燼遺跡」で「感応」を発動した後、今回の「灰燼遺跡」のリフレッシュに黒印の消費が不要になる。"
  },
  State_140456_WeaponDesc = {
    Text = "打出後、それを永久に削除します。"
  },
  State_140458_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：装備時および任意の覚醒体が「キョウキ爆発」を発動した後、自身が <Block:[Block:StateArg1]> シールドを獲得する。"
  },
  State_140458_Name = {
    Text = "群星に捧ぐ"
  },
  State_140489_Desc = {
    Text = "同量の最大ライフを獲得する。点数は覚醒体の初期最大ライフを超えない。"
  },
  State_140489_Name = {Text = "羽の種"},
  State_140490_Desc = {
    Text = "同量の最大ライフを獲得する。点数はその覚醒体の初期最大ライフ[DescArg1]を超えない。"
  },
  State_140490_Name = {Text = "羽の種"},
  State_140495_Desc = {
    Text = "次の「スキル」が消費する行動力 - [Layer] 。"
  },
  State_140495_Name = {Text = "改変"},
  State_140517_Desc = {
    Text = "次の「技能」の行動力消費が [DescArg1] 減少する。"
  },
  State_140517_Name = {Text = "改変"},
  State_140547_Desc = {
    Text = "この効果は胚胎融合を最大+100まで増加させ、胚胎融合向上効果の加算を受けない。"
  },
  State_140547_Name = {
    Text = "胚胎融合倍増"
  },
  State_140645_Desc = {
    Text = "待機エフェクト"
  },
  State_140645_Name = {
    Text = "待機エフェクト"
  },
  State_140647_Name = {
    Text = "認知失調使用監視"
  },
  State_140648_Name = {
    Text = "プレイヤー認知失調所持カウント"
  },
  State_140650_Desc = {
    Text = "毎ターン最初の3回「認知錯乱」付きの指令カードを使用すると、サヤは [Layer] ポイントの狂気を獲得する。"
  },
  State_140650_Name = {
    Text = "認知改造"
  },
  State_140651_Desc = {
    Text = "待機エフェクト"
  },
  State_140651_Name = {
    Text = "待機エフェクト"
  },
  State_140653_Desc = {
    Text = "このカードの行動力消費は10%の確率で-2、25%の確率で-1、30%の確率で変化なし、25%の確率で+1、10%の確率で+2となる。発射または破棄後にこのステータスを除去する"
  },
  State_140653_Name = {
    Text = "<ExclamationPointColour:認知失調>"
  },
  State_140654_Desc = {
    Text = "待機エフェクト"
  },
  State_140654_Name = {
    Text = "待機エフェクト"
  },
  State_140655_Desc = {
    Text = "このカードは融蝕に覆われてテキストを確認できず、行動力消費は10%の確率で-2、25%の確率で-1、30%の確率で変化なし、25%の確率で+1、10%の確率で+2となる。発射または破棄後にこのステータスを除去する。"
  },
  State_140655_Name = {
    Text = "<ErosionColorInkKeywords:認知錯乱>"
  },
  State_140656_Desc = {
    Text = "このカードの行動力消費は10%の確率で-2、25%の確率で-1、30%の確率で変化なし、25%の確率で+1、10%の確率で+2となる。発射または破棄後にこのステータスを除去する"
  },
  State_140656_Name = {
    Text = "<ColorInkKeywords:認知的不協和>"
  },
  State_140657_Desc = {
    Text = "このカードは融蝕に覆われてテキストを確認できず、行動力消費は10%の確率で-2、25%の確率で-1、30%の確率で変化なし、25%の確率で+1、10%の確率で+2となる。発射または破棄後にこのステータスを除去する。"
  },
  State_140657_Name = {
    Text = "<ExclamationPointColour:認知錯乱>"
  },
  State_140658_Name = {
    Text = "プレイヤー認知失調所持監視"
  },
  State_140659_Desc = {
    Text = "待機エフェクト"
  },
  State_140659_Name = {
    Text = "待機エフェクト"
  },
  State_140662_Desc = {
    Text = "毎ターン開始時、「認知錯乱」が付いていない指令カード2枚にランダムで「認知錯乱」を付与する。"
  },
  State_140662_Name = {
    Text = "ライフフォーム再構成治療"
  },
  State_140672_Desc = {
    Text = "今ターン終了まで、与えるダメージ・回復・シールドがそれぞれランダムで15%〜35%低下する。解除不可。"
  },
  State_140672_Name = {
    Text = "<PVPCognitiveDissonanceKeyWords:認知錯乱>"
  },
  State_140673_Desc = {
    Text = "今ターン終了まで、与えるダメージ・回復・シールドがそれぞれランダムで15%〜35%低下する。解除不可。"
  },
  State_140673_Name = {
    Text = "認知錯乱"
  },
  State_140683_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に<MaxHPKeywords:最大ライフ>[StateArg1]を獲得する。ターン終了時に<Heal:[Heal:DescArg1]>のライフを回復し、回復量は装備者のライフが低いほど増加し、最大[StateArg3]%まで上昇する。"
  },
  State_140683_Name = {
    Text = "夢遊の異界"
  },
  State_140724_Name = {Text = "摂食"},
  State_140726_Desc = {
    Text = "このカードが与えるダメージ・力・触腕ダメージ・固定毒・固定反撃・シールド・ライフ回復・力減少の最終効果が[DescArg1]%低下する。"
  },
  State_140726_Name = {
    Text = "<AdaptKeywords1:適応 [DescArg1]>"
  },
  State_140727_Desc = {
    Text = "飢餓が5点に達した時、ターン終了後にすべての飢餓を消費し、行動予測を強攻撃に切り替えて[DescArg1]点の力を獲得する。"
  },
  State_140727_Name = {Text = "飢餓"},
  State_140728_Desc = {
    Text = "毎ターン開始時に飢餓を1層獲得し、ブロックされていないダメージを与えた時、最大ライフの2%([DescArg1])点のシールドを獲得する。適応の最大層数が75に引き上げられる。"
  },
  State_140728_Name = {
    Text = "貯食行動"
  },
  State_140730_Desc = {
    Text = "指令カードを発射した後、所属する覚醒体の各所にあるカードに<AdaptKeywords:適応>を10層付与し、他の覚醒体のカードの<AdaptKeywords:適応>を5層除去する。<AdaptKeywords:適応>1層ごとにカードが与えるダメージ・力・触腕ダメージ・固定毒・固定反撃・シールド・ライフ回復・力減少の最終効果を1%減少させる。最大[DescArg1]層まで重複可能。"
  },
  State_140730_Name = {Text = "擬態"},
  State_140838_Desc = {
    Text = "本ターン中に与えるダメージが [Layer]% 低下する。"
  },
  State_140839_Desc = {
    Text = "本ターン、すべての覚醒体の最終ダメージが [Layer]% アップする。"
  },
  State_140839_Name = {
    Text = "随行猟従"
  },
  State_140856_Desc = {
    Text = "行動不能、ターン終了時に意識干渉を1層除去し、全て除去された後この覚醒体の次の1回の狂気解放は極限解放として扱われる。発動時すでに極限解放であった場合は代わりに基礎狂気を100％返還する。"
  },
  State_140856_Name = {
    Text = "<Yishiganshe:意識干渉>"
  },
  State_140860_Desc = {
    Text = "行動不能、ターン終了時に意識干渉を1層除去し、全て除去された後この覚醒体の次の1回の狂気解放は極限解放として扱われる。発動時すでに極限解放であった場合は代わりに基礎狂気を100％返還する。"
  },
  State_140860_Name = {
    Text = "<Yishiganshe:意識干渉>"
  },
  State_140861_Desc = {
    Text = "次に狂気解放を発動した際、極限解放を発動したものとみなす。すでに極限解放を発動済みの場合は、基礎狂気の100%を返還する。"
  },
  State_140861_Name = {
    Text = "夢遊の異界"
  },
  State_140873_Desc = {
    Text = "1層ごとに、このカードが与えるダメージ・力・触腕ダメージ・固定毒・固定反撃・シールド・ライフ回復・力減少の最終効果を1%減少させる。最大[DescArg1]層。"
  },
  State_140873_Name = {
    Text = "<AdaptKeywords:適応>"
  },
  State_140877_Name = {
    Text = "追加で [DescArg1] 回発動"
  },
  State_141468_Desc = {
    Text = "飢餓が5層に達した時、ターン終了後にすべての飢餓を消費し、意図を強力攻撃に切り替えて力を獲得する。"
  },
  State_141468_Name = {
    Text = "<HungerKeywords:飢餓>"
  },
  State_141504_Desc = {
    Text = "最大3体まで蓄積可能。上限に達した後、次の「生靈の盛筵」でそれを食べてその効果を強化できる。残骸は次の戦闘に引き継がれる。"
  },
  State_141950_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：装備時およびターン終了時、<PVPDiscoveryKeyWords:発見> [StateArg1] 枚の<PVPVoidKeywords:虚無>が付加された「スキル」を手札に加える。"
  },
  State_141950_Name = {
    Text = "上への墜落"
  },
  State_141988_Desc = {
    Text = "本カードが与えるダメージ、シールド、回復、付与する力、衰弱、触腕ダメージ、毒、反撃、運命裁断、固定毒、固定反撃、固定運命裁断の効果が [Layer]% アップする。"
  },
  State_141988_Name = {
    Text = "本カード炫彩"
  },
  State_141989_Desc = {
    Text = "ランダムなカードを生成する。"
  },
  State_141989_Name = {
    Text = "<CardKeyWord:発見>"
  },
  State_141991_Desc = {
    Text = "本覚醒体の狂気解放が与えるダメージ、シールド、回復、付与する力、衰弱、触腕ダメージ、毒、反撃、運命裁断、固定毒、固定反撃、固定運命裁断の効果が [Layer]% アップする。"
  },
  State_141991_Name = {
    Text = "狂気解放炫彩"
  },
  State_141992_Desc = {
    Text = "本覚醒体のカードが与えるダメージ、シールド、回復、付与する力、衰弱、触腕ダメージ、毒、反撃、運命裁断、固定毒、固定反撃、固定運命裁断の効果が [Layer]% アップする。"
  },
  State_141992_Name = {
    Text = "本カード炫彩"
  },
  State_141993_Desc = {
    Text = "本覚醒体の指令カードが与えるダメージ、シールド、回復、付与する力、衰弱、触腕ダメージ、毒、反撃、運命裁断、固定毒、固定反撃、固定運命裁断の効果が [Layer]% アップする。"
  },
  State_141993_Name = {
    Text = "指令カード炫彩"
  },
  State_141994_Desc = {
    Text = "カードを発射した後、狂気解放を使用した後に与えるダメージ、シールドを獲得、回復、力・衰弱・触腕ダメージ・毒・反撃・運命裁断・固定毒・固定反撃・固定運命裁断を付与。"
  },
  State_141994_Name = {
    Text = "カラフルトリガー指令"
  },
  State_142018_Desc = {
    Text = "ターン開始時、<Guaiwucanhai:残骸>を1点獲得する。"
  },
  State_142018_Name = {
    Text = "王邸の招待状"
  },
  State_142057_Desc = {
    Text = "キーオーダーを使用した後、自身の意図を切り替える。戦闘開始後、すべての覚醒体のシルバーキー充電レベルが25%上昇する。"
  },
  State_142057_Name = {
    Text = "悟り因果"
  },
  State_142058_Desc = {
    Text = "与える基礎ダメージ、毒、反撃が[DescArg1]%減少する"
  },
  State_142058_Name = {
    Text = "穢れの翼"
  },
  State_142060_Desc = {
    Text = "敵が指令カードを使用するたびに、自身が1層の一時的な狂熱を獲得する。一時的な狂熱が10層に達した時、次に指令カードを発射した後、自身は即座に行動し、すべての一時的な狂熱を除去する。"
  },
  State_142060_Name = {
    Text = "深淵の回声"
  },
  State_142062_Desc = {
    Text = "毎回0246の初期効果がランダムになる"
  },
  State_142062_Name = {
    Text = "意図ランダム"
  },
  State_142063_Desc = {
    Text = "自身のターン中、受けるダメージが[DescArg1]%減少する。"
  },
  State_142063_Name = {
    Text = "聖潔の翼"
  },
  State_142065_Desc = {
    Text = "ターン開始時に除去される。10層に達した時、次に指令カードを発射した後、自身は即座に行動し、すべての一時的な狂熱を除去する。"
  },
  State_142065_Name = {
    Text = "一時的な狂熱"
  },
  State_142066_Desc = {
    Text = "付与する<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重傷>が50%増加する。"
  },
  State_142066_Name = {
    Text = "本質洞察"
  },
  State_142067_Desc = {
    Text = "与える力、反撃、触腕ダメージが[DescArg1]%減少する"
  },
  State_142067_Name = {
    Text = "呪いの翼"
  },
  State_142072_Desc = {
    Text = "ダメージを受けたりライフを失ったりするたびに、最大ライフの5%を超えることはできません。"
  },
  State_142072_Name = {
    Text = "痛みの閾値"
  },
  State_142091_Desc = {
    Text = "六翼倍増カウント"
  },
  State_142091_Name = {
    Text = "六翼倍増カウント"
  },
  State_142092_Desc = {
    Text = "すべての覚醒体のシルバーキー充電レベルが25%上昇する。"
  },
  State_142092_Name = {
    Text = "悟り因果"
  },
  State_142093_Desc = {
    Text = "六翼倍増消費進捗：[DescArg1]、現在必要な被ダメージ値：[DescArg2]。"
  },
  State_142093_Name = {
    Text = "六翼倍増"
  },
  State_142095_Desc = {
    Text = "六翼倍増識別"
  },
  State_142095_Name = {
    Text = "六翼倍増識別"
  },
  State_142166_Desc = {
    Text = "具体的な効果は共通の「攻撃」ロジックを参照。__「開発用」"
  },
  State_142213_Name = {
    Text = "行動力の上限を減少"
  },
  State_142215_Desc = {
    Text = "次のターン開始時もまだ死亡している場合、復活して[StateArg1]のシールドを獲得し、解除不可。"
  },
  State_142215_Name = {
    Text = "永遠の執念"
  },
  State_142228_Desc = {
    Text = "このカードは命輪「上への墜落」によって生成された。"
  },
  State_142228_Name = {
    Text = "上への墜落"
  },
  State_142229_Desc = {
    Text = "チームユニーク：探索開始後、「夢遊仙境」を 1 枚デッキに加える。「夢遊仙境」：行動力を 2 点消費し、装備者に <WeaponEffect_Num:[StateArg1]> 点の狂気と 3 層の<Yishiganshe:「意識干渉」>を付与する。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。"
  },
  State_142229_Name = {
    Text = "夢遊の異界"
  },
  State_142229_WeaponDesc = {
    Text = "探索開始後、「夢遊仙境」を 1 枚デッキに加える。「夢遊仙境」：行動力を 2 点消費し、装備者に <WeaponEffect_Num:[StateArg1]> 点の狂気と 3 層の<Yishiganshe:「意識干渉」>を付与する。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。"
  },
  State_142452_Desc = {
    Text = "受ける力減少効果が50%縮小される。"
  },
  State_142452_Name = {
    Text = "不滅の存在"
  },
  State_142663_Desc = {
    Text = "次のターン開始時、<DelayKeywords:レイテンシ>：[Layer] 狂気を獲得する。"
  },
  State_142663_Name = {
    Text = "遅延遅延狂気"
  },
  State_142688_Desc = {
    Text = "目標に装備された命輪が無効化され、解除不可。"
  },
  State_142688_Name = {
    Text = "スーパー纏着"
  },
  State_142692_Desc = {
    Text = "新しいアイデアが浮かんできている。"
  },
  State_142692_Name = {
    Text = "ひらめき"
  },
  State_142715_Desc = {
    Text = "この「スキル」のダメージが [DescArg1]% 上昇し、このスキルが消費する行動力 1 点ごとに [StateArg1]% 増加する。"
  },
  State_142715_Name = {
    Text = "琥珀色の死"
  },
  State_142887_Desc = {
    Text = "本ターンに再び「麻痺」を受けると、その全ての「打撃」が「幻影」に変わり、解除不可となり、ターン終了まで持続する。"
  },
  State_142887_Name = {
    Text = "少し痺れてきた"
  },
  State_142954_Desc = {
    Text = "行動力上限の最小値は0で、毎ターン開始時に10未満の場合は1増加する。10に達した後に行動力上限を獲得すると、同量のカードを引くことに変換される。"
  },
  State_142954_Name = {
    Text = "行動力上限"
  },
  State_143002_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143002_Name = {
    Text = "ツァトゥグァSR（仮テキスト）"
  },
  State_143004_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143004_Name = {
    Text = "サトグア専用武器(仮テキスト)"
  },
  State_143005_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143005_Name = {
    Text = "ランティゴスSR(仮テキスト)"
  },
  State_143006_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143006_Name = {
    Text = "ヘキサン専用武器（仮テキスト）"
  },
  State_143007_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：装備時とターン開始時、ランダムな敵に [StateArg1] <PVPCompassKeywords:岐路を示す羅針盤>を付与する。"
  },
  State_143007_Name = {
    Text = "岐路を指す羅針盤"
  },
  State_143008_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143008_Name = {
    Text = "シャタク鳥専用武器（仮テキスト）"
  },
  State_143009_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143009_Name = {
    Text = "アヤヴァゴモン専用武器（仮テキスト）"
  },
  State_143010_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：手札上限+ [StateArg1] 、装備者または味方が死亡した際、そのカードは<PVPDerivativeCardKeywords_2:「幻影」>に変換されず、<PVPDerivativeCardKeywords_30:「魘鬼狩り」>に変換される。"
  },
  State_143010_Name = {
    Text = "生きた囚人籠"
  },
  State_143011_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143011_Name = {
    Text = "ハゲワシSR(仮テキスト)"
  },
  State_143012_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143012_Name = {
    Text = "シャタク鳥SR（仮テキスト）"
  },
  State_143013_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143013_Name = {
    Text = "本源オージルSR（仮テキスト）"
  },
  State_143014_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」前に現在ライフの 25% を失う；「狂気解放」後に全体の敵に [StateArg1] ダメージを与え、同量のライフを吸収する。"
  },
  State_143014_Name = {
    Text = "甘美な欺瞞"
  },
  State_143016_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143016_Name = {
    Text = "ファラオSR（仮テキスト）"
  },
  State_143017_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143017_Name = {
    Text = "ランティゴス専用武器（仮テキスト）"
  },
  State_143018_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143018_Name = {
    Text = "真貌・トゥルーSR(仮テキスト)"
  },
  State_143019_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」後、敵全体に [StateArg1] 層の<PVPBless:祝福>を付与する。"
  },
  State_143019_Name = {
    Text = "穏やかな真実"
  },
  State_143020_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143020_Name = {
    Text = "起源オジール専用武器(仮テキスト)"
  },
  State_143022_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143022_Name = {
    Text = "ハゲワシ専用武器（仮テキスト）"
  },
  State_143023_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_143023_Name = {
    Text = "アヤヴァゴモンSR（仮テキスト）"
  },
  State_143326_Desc = {
    Text = "シルバーキー充電が [DescArg1] 上昇する。"
  },
  State_143326_Name = {
    Text = "悟り因果"
  },
  State_143331_Desc = {
    Text = "次のターン終了前、<StatusApplier:>のダメージの半分を肩代わりする。このステータスはチームユニークで、紐付けられた双方のいずれかが死亡した際に効果が解除され、驱散できない。"
  },
  State_143331_Name = {
    Text = "ダメージ受け入れ"
  },
  State_143333_Desc = {
    Text = "次のターン開始前、<StatusApplier:>がダメージの半分を肩代わりする。このステータスはチームユニークで、紐付けられた双方のいずれかが死亡した際に効果が解除され、驱散できない。"
  },
  State_143333_Name = {
    Text = "ダメージ転移"
  },
  State_143336_Desc = {
    Text = "「囚魘」に1回追加で発動を付与する。「囚魘」を発射する時、1層を消費する。上限は9層で、戦闘終了時に除去されない。"
  },
  State_143336_Name = {
    Text = "<BattueKeywords:囲い猟>"
  },
  State_143340_Desc = {
    Text = "「囚魘」に1回追加で発動を付与する。「囚魘」を発射する時、1層を消費する。上限は9層で、戦闘終了時に除去されない。"
  },
  State_143340_Name = {
    Text = "<BattueKeywords:囲い猟>"
  },
  State_143386_Desc = {
    Text = "<StatusApplier:>のダメージの半分を肩代わりする。驱散できない。"
  },
  State_143386_Name = {
    Text = "ダメージ受け入れ"
  },
  State_143387_Desc = {
    Text = "<StatusApplier:>がダメージの半分を肩代わりする。驱散できない。"
  },
  State_143387_Name = {
    Text = "ダメージ転移"
  },
  State_143406_Name = {
    Text = "このカードは追加で [DescArg1] 回発動する"
  },
  State_143408_Desc = {
    Text = "敵の覚醒体の攻撃を受けた時、攻撃者の [Layer] 狂気に変換する。"
  },
  State_143408_Name = {
    Text = "岐路を指す羅針盤"
  },
  State_143409_Desc = {
    Text = "敵の覚醒体の攻撃を受けた時、スタック数と同量を攻撃者の狂気に変換する。"
  },
  State_143409_Name = {
    Text = "<CardKeyWord:岐路を指す羅針盤>"
  },
  State_143419_Desc = {
    Text = "このカードは<PVPDerivativeCardKeywords_31:「オレッタの宝物」>から来ている。"
  },
  State_143419_Name = {
    Text = "オレッタの宝物"
  },
  State_143426_Desc = {
    Text = "ターン開始後、[Layer] 行動力を消費する。驱散できない。"
  },
  State_143426_Name = {
    Text = "レイテンシ行動力消費"
  },
  State_143441_Desc = {
    Text = "第[StateArg1]ラウンドの操作時に選ばれた覚醒体。"
  },
  State_143441_Name = {
    Text = "テストマーク1"
  },
  State_143442_Desc = {
    Text = "第[StateArg1]ラウンドの操作時に選ばれた覚醒体。"
  },
  State_143442_Name = {
    Text = "テストマーク2"
  },
  State_143444_Desc = {
    Text = "第[StateArg1]ラウンドの操作時に選ばれた覚醒体。"
  },
  State_143444_Name = {
    Text = "テストマーク4"
  },
  State_143445_Desc = {
    Text = "第[StateArg1]ラウンドの操作時に選ばれた覚醒体。"
  },
  State_143445_Name = {
    Text = "テストマーク3"
  },
  State_143499_Name = {
    Text = "アクティブダメージ免疫__「開発用のみ」"
  },
  State_143500_Name = {
    Text = "純粋ダメージ免疫__「開発用のみ」"
  },
  State_143541_Desc = {
    Text = "すべての敵が本ターン中に与えるダメージを [DescArg1]% 低下させ、[DescArg2] 点の力を獲得する。"
  },
  State_143541_Name = {Text = "護衛"},
  State_143542_Desc = {
    Text = "一時的最終ダメージ +[DescArg1]%、すべての敵に最大ライフの [DescArg2]% の侵蝕を与える。"
  },
  State_143542_Name = {Text = "猟取"},
  State_143548_Desc = {
    Text = "シールドを与えてステータスを付与する、モンスター、分岐1。"
  },
  State_143548_Name = {
    Text = "モンスターシールド変換1"
  },
  State_143549_Desc = {
    Text = "シールドを与えてステータスを付与する、覚醒体、分岐2。"
  },
  State_143549_Name = {
    Text = "キャラクターシールド変換2"
  },
  State_143550_Desc = {
    Text = "シールドを与えてステータスを付与する、覚醒体、分岐1。"
  },
  State_143550_Name = {
    Text = "キャラクターシールド変換1"
  },
  State_143551_Desc = {
    Text = "シールドを付与しステータスを追加する、モンスター、分岐2。"
  },
  State_143551_Name = {
    Text = "モンスターシールド変換2"
  },
  State_143552_Desc = {
    Text = "シールドを与えてステータスを付与する、プレイヤー、分岐1。"
  },
  State_143552_Name = {
    Text = "プレイヤーシールド変換1"
  },
  State_143553_Desc = {
    Text = "シールドを与えてステータスを付与する、プレイヤー、分岐2。"
  },
  State_143553_Name = {
    Text = "プレイヤーシールド変換2"
  },
  State_143573_Desc = {
    Text = "囚魘は「略奪の魘鬼」「惑乱の魘鬼」「狩殺の魘鬼」を含むポントスの強化カードで、全部で３種類ある。永続「囚魘」を生成する際に永続「囚魘」が6枚を超えた場合、ランダムな永続「囚魘」を行動力消費 +1 だが1回追加で発動する「双生の魘鬼」にアップグレードする。「双生の魘鬼」はデッキ内で2枚の「囚魘」として扱う。すべての「囚魘」がアップグレード済みの場合、<DestructionKeywords:破壊>を持つ「上位啓示」1枚を手札に加える。"
  },
  State_143573_Name = {Text = "囚魘"},
  State_143578_Desc = {
    Text = "本ターン中、アクティブダメージを受けるたびに、[Layer]枚の<PVPDerivativeCardKeywords_30:「猟魇」>を手札に加える。"
  },
  State_143578_Name = {
    Text = "領主の儀"
  },
  State_143595_Desc = {
    Text = "このカードに<PrepareKeywords:準備> [StateArg1]が付与された。"
  },
  State_143595_Name = {
    Text = "ブラックスワン"
  },
  State_143597_Desc = {
    Text = "チームユニーク：装備者が与える力減少効果が<WeaponEffect_Num:[StateArg1]%>アップ。「怒涛」姿態に切り替えた時、一時的なクリティカルダメージがアップし、アップ量は自身の基礎クリティカルダメージの<WeaponEffect_Num:[StateArg1]%>に等しく、3ターンクールダウン。"
  },
  State_143597_WeaponDesc = {
    Text = "装備者が与える力減少効果が<WeaponEffect_Num:[StateArg1]%>アップ。「怒涛」姿態に切り替えた後、一時的なクリティカルダメージが<WeaponEffect_Num:[DescArg1]%>アップ、3ターンクールダウン。"
  },
  State_143598_Desc = {
    Text = "チームユニーク：装備者が与える力減少効果が<WeaponEffect_Num:[StateArg1]%>アップ、敵を1体キルするごとに装備者の今回の探索のターン終了時に固定回復する狂気が2ポイントアップし、最大<WeaponEffect_Num:[StateArg2]>回まで累積可能。「怒涛」姿態に切り替えた後、一時的なクリティカルダメージがアップし、アップ量は自身の基礎クリティカルダメージの<WeaponEffect_Num:[StateArg1]%>に等しく、3ターンクールダウン。"
  },
  State_143598_WeaponDesc = {
    Text = "装備者が与える力減少効果が<WeaponEffect_Num:[StateArg1]%>アップ、敵を1体キルするごとに装備者の今回の探索のターン終了時に固定回復する狂気が2ポイントアップし、最大<WeaponEffect_Num:[StateArg2]>回まで累積可能。「怒涛」姿態に切り替えた後、一時的なクリティカルダメージが<WeaponEffect_Num:[DescArg1]%>アップ、3ターンクールダウン。"
  },
  State_143683_Desc = {
    Text = "この覚醒体の追撃が封印され使用不可、[Layer] ターン後に封印が解除される。"
  },
  State_143683_Name = {
    Text = "<Seal1:追撃封印>"
  },
  State_144381_Desc = {
    Text = "行動不能、残り [DescArg1] ターン。"
  },
  State_144381_Name = {
    Text = "<Yishiganshe:意識干渉>"
  },
  State_144441_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：味方が死亡した時、自身が <Energy:[Energy:StateArg1]> 狂気を獲得する。味方が復活した時、その味方が <Energy:[Energy:StateArg2]> 狂気を獲得する。狂気獲得効果はターゲットの狂気が満タンでない時のみ発動し、残り [Layer] 回有効、回数が尽きた後この命輪を破壊する。"
  },
  State_144441_Name = {
    Text = "霊魂同調"
  },
  State_144494_Desc = {
    Text = "全部で7種類の効果があり、以下を含む：カードを8枚ドロー、行動力を6点獲得、キーエネルギーを獲得、すべての覚醒体が固定の狂気を獲得、力を獲得、すべての敵の力を一時的に低下、一時的なダメージ強化上昇。"
  },
  State_144494_Name = {
    Text = "<Blessing:ギフト>"
  },
  State_144508_Desc = {
    Text = "「代償」は全部で3種類あり、「逃した好機」、「大仰な言葉」、「秘めた悪意」を含む。\n「逃した好機」：2ターン後に「贈り物」の効果を獲得する。\n「大仰な言葉」：「贈り物」の効果が50％減少する。\n「秘めた悪意」：自身にランダムで1種類の異なる効果を付与する：2ターン虚弱、2ターン脆弱、2ターン重傷、自身の最大ライフ値の1％に相当する毒、2スタックの虚無、手札のランダムな2枚のカードに1スタックの遅延を付与、2枚の一時的な症状カード（戦闘をまたいで引き継がない）を生成してドロー山の頂部に置く。"
  },
  State_144508_Name = {
    Text = "<BlessingNegativeEffect:代償>"
  },
  State_144519_Desc = {
    Text = "テスト用変数。ターン開始後またはカードを発射した後にリフレッシュする。現在[Layer]界精を所持。"
  },
  State_145228_Name = {
    Text = "<WormGrowth:飽食>"
  },
  State_145229_Desc = {
    Text = "あなたも祝福の一部ですよ〜。カラブの狂気解放で消費して増益を獲得できる。このステータスは最大5スタックまで蓄積できる。戦闘終了後も消去されない"
  },
  State_145229_Name = {
    Text = "<SacrificialMark:供物>"
  },
  State_145436_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打撃」ダメージアップ [DescArg1]% 、「打撃」のたびにダメージが追加で [StateArg2]% アップし、最大 [StateArg3]% まで上昇する。"
  },
  State_145436_Name = {
    Text = "不滅の餓骨"
  },
  State_145437_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：装備時に [StateArg2] スタックの<EnergyStorageKeywords:蓄力>を獲得し、「打撃」のダメージアップ [StateArg1]% かつ<PVPPunctureDamagewords:刺突ダメージ>に変更する。"
  },
  State_145437_Name = {
    Text = "天より堕ちる"
  },
  State_145456_Desc = {
    Text = "ターゲット選択時、挑発・潜行・ロックを無視する。複数のターゲットの条件が同等の場合、より前の覚醒体を優先して選択する。"
  },
  State_145456_Name = {
    Text = "ライフとシールドが最低"
  },
  State_145457_Desc = {
    Text = "ターゲット選択時、挑発・潜行・ロックを無視する。複数のターゲットの条件が同等の場合、より前の覚醒体を優先して選択する。"
  },
  State_145457_Name = {
    Text = "ライフとシールドが最高"
  },
  State_145495_Desc = {
    Text = "このカードは双発によって発射された。"
  },
  State_145495_Name = {
    Text = "<CardKeyWord:双発>"
  },
  State_145554_Desc = {
    Text = "チームユニーク：探索開始後、1 枚の<Falltospace1[StateArg3]:「人間界への足跡」>をデッキに加える。「人間界への足跡」：行動力 0 を消費する。全ての敵に装備者の攻撃力 <WeaponEffect_Num:[StateArg1]%> および最大ライフ <WeaponEffect_Num:[Float:StateArg4]%> の固定<Corrosion:侵蝕>ダメージを与え、各所の他の覚醒体の指令カードに<ErosionColorInkKeywords:認知錯乱>を付与し、1 枚の<Falltospace2[StateArg3]:「上への墜落」>をドロー山にシャッフルする。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。"
  },
  State_145554_Name = {
    Text = "上への墜落"
  },
  State_145554_WeaponDesc = {
    Text = "探索開始後、1 枚の<Falltospace1[StateArg3]:「人間界への足跡」>をデッキに加える。「人間界への足跡」：行動力 0 を消費する。全ての敵に装備者の攻撃力 <WeaponEffect_Num:[StateArg1]%> および最大ライフ <WeaponEffect_Num:[Float:StateArg4]%> の固定<Corrosion:侵蝕>ダメージを与え、各所の他の覚醒体の指令カードに<ErosionColorInkKeywords:認知錯乱>を付与し、1 枚の<Falltospace2[StateArg3]:「上への墜落」>をドロー山にシャッフルする。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>"
  },
  State_145572_Desc = {
    Text = "ターン開始ごとに、他の全ての覚醒体が <Damage:[Damage:Layer]> の刺突ダメージを与える。"
  },
  State_145572_Name = {
    Text = "鯨を呑み込む嵐"
  },
  State_145590_Desc = {
    Text = "同じ帰属の同じカードが手札に加えられた時、融合効果が発動しそのカードを消費する。"
  },
  State_145592_Desc = {
    Text = "敵1体をロックし、優先攻撃ターゲットとする。単体ターゲット選択時はロックしたターゲットのみ選択可能となり、挑発と隠匿を無視する。"
  },
  State_145592_Name = {
    Text = "<CardKeyWord:ロック>"
  },
  State_145619_Name = {Text = "重傷"},
  State_145620_Name = {Text = "虚無"},
  State_145621_Desc = {
    Text = "「ギフト」効果が50％減少する。"
  },
  State_145621_Name = {
    Text = "<Bleesing_Exaggerate:大仰な言葉>"
  },
  State_145622_Name = {Text = "鈍化"},
  State_145623_Desc = {
    Text = "自身にランダムで1種類の異なる効果を付与する：2ターン虚弱、2ターン脆弱、2ターン重傷、最大ライフ値の1％に相当する毒を付与、2スタックの虚無、手札のランダムな2枚のカードに1スタックの遅延を付与、2枚の一時的な症状カード（戦闘をまたいで引き継がない）を生成してドロー山の頂部に置く。"
  },
  State_145623_Name = {
    Text = "<Bleesing_Negative:秘めた悪意>"
  },
  State_145625_Name = {
    Text = "2枚の同じ一時的「症状カード」"
  },
  State_145626_Name = {Text = "抑圧"},
  State_145627_Name = {Text = "毒"},
  State_145628_Desc = {
    Text = "2ターン後に「ギフト」効果を獲得する。"
  },
  State_145628_Name = {
    Text = "<Bleesing_Delay:逃した好機>"
  },
  State_145631_Desc = {
    Text = "「打撃」のダメージアップ [StateArg1]% し、<PVPPunctureDamagewords:刺突ダメージ>に変更する。"
  },
  State_145631_Name = {
    Text = "天より堕ちる"
  },
  State_145632_Desc = {
    Text = "このカードは命輪「幸運の時」から来た。"
  },
  State_145632_Name = {
    Text = "幸運の時"
  },
  State_145638_Desc = {
    Text = "このカードの行動力消費が [Layer] 増加する。"
  },
  State_145638_Name = {
    Text = "残忍なる敬意"
  },
  State_145642_Desc = {
    Text = "2 ターン後にすべての覚醒体が [StateArg1] 点の狂気を [Layer] 回獲得する。"
  },
  State_145642_Name = {
    Text = "遅延狂気"
  },
  State_145644_Desc = {
    Text = "2 ターン後に <Posse:[StateArg1]> 点のキーエネルギーを [Layer] 回獲得する。"
  },
  State_145644_Name = {
    Text = "レイテンシ銀の鍵"
  },
  State_145645_Desc = {
    Text = "2 ターン後にすべての敵の<ExhaustionIconKeywords:力>を一時的に [StateArg1] 点低下させる [Layer] 回"
  },
  State_145645_Name = {
    Text = "遅延衰弱"
  },
  State_145646_Desc = {
    Text = "2 ターン後に [StateArg1] 点の行動力を [Layer] 回獲得する。"
  },
  State_145646_Name = {
    Text = "遅延行動力"
  },
  State_145647_Desc = {
    Text = "2 ターン後に [StateArg1] 点の<PowerIconKeywords:力>を [Layer] 回獲得する。"
  },
  State_145647_Name = {
    Text = "レイテンシ力"
  },
  State_145648_Desc = {
    Text = "2 ターン後に [StateArg1] 枚ドローする [Layer] 回。"
  },
  State_145648_Name = {
    Text = "遅延ドロー"
  },
  State_145649_Desc = {
    Text = "2 ターン後に一時的ダメージ強化 [StateArg1]% [Layer] 回。"
  },
  State_145649_Name = {
    Text = "遅延一時的ダメージ強化"
  },
  State_145652_Desc = {
    Text = "このカードの行動力消費-[Layer]。"
  },
  State_145652_Name = {
    Text = "耐え難き自由"
  },
  State_145654_Desc = {
    Text = "テスト。発射後、または手札から離れた後、破壊される。"
  },
  State_145654_Name = {
    Text = "テスト·須臾"
  },
  State_145660_Desc = {
    Text = "味方\n1.<AllyPosAwaker1Name:> [DescArg1]\n2.<AllyPosAwaker2Name:> [DescArg2]\n3.<AllyPosAwaker3Name:> [DescArg3]\n4.<AllyPosAwaker4Name:> [DescArg4]\n敵\n1.<EnemyPosAwaker1Name:> [DescArg5]\n2.<EnemyPosAwaker2Name:> [DescArg6]\n3.<EnemyPosAwaker3Name:> [DescArg7]\n4.<EnemyPosAwaker4Name:> [DescArg8]"
  },
  State_145660_Name = {
    Text = "回溯後のライフ変化"
  },
  State_145693_Desc = {
    Text = "ターン終了後、行動力消費が[Layer]点減少。捨てられた時もこの効果は発動。"
  },
  State_145693_Name = {
    Text = "<PrepareKeypvewordscolour:準備[Layer]>"
  },
  State_145693_WeaponDesc = {
    Text = "捨て札フェイズ時、捨て札に行かず、手札に残る。"
  },
  State_145694_Name = {
    Text = "黒沼との共生"
  },
  State_145698_Desc = {
    Text = "ロックされた<StatusApplier:>を優先して攻撃し、単体ターゲット選択時はロックされたターゲットのみ選択可能で、挑発と隠匿を無視する。"
  },
  State_145698_Name = {Text = "ロック"},
  State_145699_Desc = {
    Text = "·ロックされた<StatusApplier:>を優先して攻撃し、単体ターゲット選択時はロックされたターゲットのみ選択可能で、挑発と隠匿を無視する。\n·自身が死亡した後、<StatusApplier:>が「<PVPDerivativeCardKeywords_32:来い!>」を獲得する。"
  },
  State_145699_Name = {Text = "ロック"},
  State_145709_Desc = {
    Text = "1スタックごとにカラブの体力の10%に等しい最大ライフが上昇し、「飽満」は最大50スタックまで蓄積できる。このステータスを得た時すでに上限に達している場合、超過した1スタックごとに同量の3倍のライフを回復する。非ボスバトル1戦につき最大10スタックの「飽満」を得られる。戦闘終了時に解除されない。"
  },
  State_145709_Name = {
    Text = "<WormGrowth:飽食>"
  },
  State_145710_Desc = {
    Text = "あなたも祝福の一部ですよ〜。カラブの狂気解放で消費して増益を獲得できる。このステータスは最大5スタックまで蓄積できる。戦闘終了後も消去されない"
  },
  State_145710_Name = {
    Text = "<SacrificialMark:供物>"
  },
  State_145901_Desc = {
    Text = "味方\n1.<AllyPosAwaker1Name:> [DescArg1]\n2.<AllyPosAwaker2Name:> [DescArg2]\n3.<AllyPosAwaker3Name:> [DescArg3]\n4.<AllyPosAwaker4Name:> [DescArg4]"
  },
  State_145901_Name = {
    Text = "回溯後のライフ変化"
  },
  State_146041_Desc = {
    Text = "この覚醒体は俗世の喧騒から離れた感覚を覚える。\n·ターン終了まで一切の行動ができず、ダメージを99％軽減し、ターゲットに耐性がない場合は耐性を付与する。\n·効果終了時、全ての味方に <Damage:[Layer]> の純粋ダメージを与える。\n·付与時にターゲットが耐性を持っている場合、即座にたぶらかしを終了し、ターゲットへのダメージが2倍になる。"
  },
  State_146041_Name = {
    Text = "煙に巻く"
  },
  State_146043_Desc = {
    Text = "次のターン開始時、[Layer] 狂気を消費する。"
  },
  State_146043_Name = {
    Text = "レイテンシ狂気消費"
  },
  State_146058_Desc = {
    Text = "テスト用変数。ターン開始後またはカードを発射した後にリフレッシュする。現在[Layer]%の攻撃効果を持つはず。"
  },
  State_146058_Name = {
    Text = "キーオーダー攻撃効果"
  },
  State_146059_Desc = {
    Text = "テスト用変数。ターン開始後またはカードを発射した後にリフレッシュする。現在[Layer]%の防御効果を持つはず。"
  },
  State_146059_Name = {
    Text = "キーオーダー防御効果"
  },
  State_146079_Desc = {
    Text = "このカードが手札を離れた後、手中に戻る。"
  },
  State_146079_Name = {
    Text = "<Recycle:回収>"
  },
  State_146085_Desc = {
    Text = "このターン発射前にカードの行動力を変更する"
  },
  State_146085_Name = {
    Text = "このターン発射前にカードの行動力を変更する"
  },
  State_146085_WeaponDesc = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_146086_Desc = {
    Text = "このターン発射前にカードの行動力を変更する"
  },
  State_146086_Name = {
    Text = "このターン発射前にカードの行動力を変更する"
  },
  State_146086_WeaponDesc = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_146117_Desc = {
    Text = "「<DerivativeCardKeywords_157:剣の骨>」に消費されてバフを獲得できる。このステータスは最大 15 スタックまで蓄積できる。"
  },
  State_146117_Name = {
    Text = "<Shimieluotanhuodong2:戦意>"
  },
  State_146129_Desc = {
    Text = "全ての覚醒体の最終ダメージ +[Layer]%。"
  },
  State_146129_Name = {
    Text = "天の鯨の怒り"
  },
  State_146147_Desc = {
    Text = "「<DerivativeCardKeywords_157:剣の骨>」に消費されてバフを獲得できる。このステータスは最大 15 スタックまで蓄積できる。"
  },
  State_146147_Name = {
    Text = "<Shimieluotanhuodong1:戦意>"
  },
  State_146154_Desc = {
    Text = "この覚醒体を良い気分にさせ、「スキル」が「祝福？」に変化する。変化後、同量のスタック数を消費する。"
  },
  State_146154_Name = {
    Text = "<PVPBlessColour:祝福>"
  },
  State_146155_Desc = {
    Text = "この覚醒体は気分が良い。\n·これから [Layer] 枚の「スキル」が「祝福？」に変化し、変化後は同量のスタック数を消費する。"
  },
  State_146155_Name = {Text = "祝福"},
  State_146155_WeaponDesc = {Text = "いいえ"},
  State_146202_Desc = {
    Text = "この覚醒体に俗世の喧騒から離れた感覚を与える。\n·ターン終了まで一切の行動ができず、ダメージを99％軽減する。ターゲットに耐性がない場合、ターゲットに耐性を付与する。\n·効果終了時、全ての味方に同量スタック数の純粋ダメージを与える。\n·付与時にターゲットが耐性を持っている場合、たぶらかしを即座に終了し、ターゲットへのダメージを2倍にする。"
  },
  State_146202_Name = {
    Text = "<CardKeyWord:たらし込み>"
  },
  State_146352_Desc = {
    Text = "ダメージを受けるたびに 1 回、[StateArg1] スタックの<Shimieluotanhuodong1:戦意>を蓄積する"
  },
  State_146352_Name = {
    Text = "戦意高揚"
  },
  State_146363_Desc = {
    Text = "次のターン開始時、[Layer] ライフを失う。ライフを失う際、同量のこのステータスのスタック数を減少させる。"
  },
  State_146363_Name = {
    Text = "偽りなきもの"
  },
  State_146383_Desc = {
    Text = "ステータス追加後、カードを発射した後、各覚醒体のシルバーキー充電レベルをリフレッシュして表示する。"
  },
  State_146383_Name = {
    Text = "効率入口"
  },
  State_146384_Desc = {
    Text = "P1値 [StateArg1]、P2値 [StateArg2]、P3値 [StateArg3]、P4値 [StateArg4]。"
  },
  State_146384_Name = {Text = "効率値"},
  State_146385_Desc = {
    Text = "ステータス追加後、カードを発射した後、各覚醒体のシルバーキー充電レベルをリフレッシュして表示する。"
  },
  State_146385_Name = {
    Text = "レベル入口"
  },
  State_146386_Desc = {
    Text = "P1値 [StateArg1]、P2値 [StateArg2]、P3値 [StateArg3]、P4値 [StateArg4]。"
  },
  State_146386_Name = {
    Text = "レベル値"
  },
  State_146446_Desc = {
    Text = "覚醒体防御力、P1：[StateArg1]、P2：[StateArg2]、P3：[StateArg3]、P4：[StateArg4]。"
  },
  State_146446_Name = {
    Text = "防御属性一覧"
  },
  State_146448_Desc = {
    Text = "覚醒体攻撃力、P1：力[StateArg1]強度[StateArg2]、P2：力[StateArg3]強度[StateArg4]、P3：力[StateArg5]強度[StateArg6]、P4：力[StateArg7]強度[StateArg8]。"
  },
  State_146448_Name = {
    Text = "攻撃属性一覧"
  },
  State_146452_Desc = {
    Text = "チームユニーク：装備者「打撃」のクリティカルダメージが<WeaponEffect_Num:[StateArg1]%>上昇する。ターン終了時、装備者の次回の狂気解放のクリティカルダメージが上昇し、上昇割合は基礎狂気の<WeaponEffect_Num:[StateArg2]%>に等しく、最大5スタックまで重複可能。"
  },
  State_146452_WeaponDesc = {
    Text = "装備者の「打撃」クリティカルダメージが <WeaponEffect_Num:[StateArg1]%> アップする。ターン終了時、装備者の次回の狂気解放のクリティカルダメージが <WeaponEffect_Num:[DescArg1]%> アップし、最大 5 回まで重複する（現在 [DescArg2]％ 適用中）。"
  },
  State_146456_Desc = {
    Text = "チームユニーク：装備者「打撃」のクリティカルダメージが<WeaponEffect_Num:[StateArg1]%>上昇する。"
  },
  State_146456_WeaponDesc = {
    Text = "装備者の「打撃」クリティカルダメージが <WeaponEffect_Num:[StateArg1]%> アップする。"
  },
  State_146534_Desc = {
    Text = "ステージ開始後、原初混沌の各メカニズムのコンテナを守秘者に追加する。"
  },
  State_146534_Name = {
    Text = "原初混沌初期化"
  },
  State_146535_Desc = {
    Text = "属性コンテナ。"
  },
  State_146535_Name = {
    Text = "原初混沌識別子"
  },
  State_146536_Desc = {
    Text = "メカニズムコンテナ。"
  },
  State_146536_Name = {
    Text = "原初混沌メカニズム"
  },
  State_146644_Desc = {
    Text = "霊知啓発は準備1を得て、各ターン初めて発射した時にキーオーダーを自動解放する。"
  },
  State_146644_Name = {
    Text = "原初の反響"
  },
  State_146645_Desc = {
    Text = "新混沌界域では各ターン初めて霊知啓発を発射した時にキーオーダーを自動解放する。現在使用可能。"
  },
  State_146645_Name = {
    Text = "使用可能フラグ"
  },
  State_146646_Desc = {
    Text = "基礎キーエネルギー上限を2000に変更する。キーエネルギーを得るルールを以下に置き換える：覚醒体が各ターン初めて指令カードを発射した時、シルバーキー充電レベルの3倍＋100のキーエネルギーを得る。"
  },
  State_146646_Name = {
    Text = "新混沌シルバーキールール"
  },
  State_146651_Desc = {
    Text = "この覚醒体の攻撃力属性を[Layer]%上昇させる。"
  },
  State_146651_Name = {
    Text = "混沌·攻撃"
  },
  State_146652_Desc = {
    Text = "戦闘開始後1回のみ、各覚醒体のシルバーキー充電効率をシルバーキー充電レベルの平均値に変更する。"
  },
  State_146652_Name = {
    Text = "原初バランス"
  },
  State_146653_Desc = {
    Text = "この覚醒体の防御属性を [Layer]% 上昇させる。"
  },
  State_146663_Desc = {
    Text = "次の[Layer]枚の蝕滅・ロータンの「打撃」が1回追加で発動する。"
  },
  State_146663_Name = {
    Text = "鯨を呑み込む嵐"
  },
  State_147058_Name = {
    Text = "「密約」36の廻る部屋"
  },
  State_147079_Desc = {
    Text = "このカードは捨てられず、変化もできない。"
  },
  State_147079_Name = {
    Text = "<RetainIconKeywordsColour:強制保留>"
  },
  State_147545_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未設定"
  },
  State_147545_Name = {
    Text = "暮星・ティンクトSR（一時的テキスト）"
  },
  State_147546_Name = {Text = "廃棄"},
  State_147546_WeaponDesc = {
    Text = "界外の音"
  },
  State_147584_Desc = {
    Text = "次に発射する<DerivativeCardKeywords_152:「妖精の恵み」>の<Blessing:恵み>効果が50%上昇する"
  },
  State_147737_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：装備時に [StateArg1] <MaxHPKeywords:最大ライフ>を獲得する。ターン開始時、全体の敵に <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:出血>ダメージを与える、"
  },
  State_147737_Name = {
    Text = "暗闇から暗闇へ"
  },
  State_147764_Name = {
    Text = "ステータス@カラブ活動選択ミスカウント"
  },
  State_147765_Desc = {
    Text = "次のターン開始時に行動力を 2 点失い、ドローが2枚減る。"
  },
  State_147765_Name = {
    Text = "ピストルチョコチョコレート"
  },
  State_147768_Desc = {
    Text = "次のターン開始時に [DescArg1] 枚の上位啓示を獲得する。"
  },
  State_147768_Name = {
    Text = "ピストルチョココイン"
  },
  State_147769_Desc = {
    Text = "本戦闘中「飽食」は現在[Layer]スタック積み重なっている。"
  },
  State_147769_Name = {
    Text = "スタック上限"
  },
  State_147772_Name = {
    Text = "ステータス@カラブ活動・一時的なシルバーキー上限追加"
  },
  State_147773_Name = {
    Text = "ステータス@カラブ活動・一時的なシルバーキー上限追加"
  },
  State_147774_Name = {
    Text = "ステータス@カラブ活動・一時的なシルバーキー上限追加_通常混沌"
  },
  State_147797_Desc = {
    Text = "狂気、<PowerIconKeywords:力>、ライフ、キーエネルギー、行動力、ドローを得るか失う可能性がある。"
  },
  State_147797_Name = {
    Text = "ピストルチョコチョコレート"
  },
  State_147800_Desc = {
    Text = "次のターン開始時に行動力を 2 点失い、ドローが2枚減る。"
  },
  State_147800_Name = {
    Text = "ピストルチョコチョコレート"
  },
  State_147869_Name = {
    Text = "カードを[Layer]枚引く"
  },
  State_147870_Name = {
    Text = "すべての敵に[Layer]ターンの倦怠を付与する"
  },
  State_147871_Name = {
    Text = "[Energy:DescArg1]狂気を獲得する"
  },
  State_147872_Name = {
    Text = "すべての敵に[Layer]ターンの軟化を付与する"
  },
  State_147873_Name = {
    Text = "[Layer]点の行動力を獲得する"
  },
  State_147874_Name = {
    Text = "<Block:[Block:DescArg1]>点のシールドを獲得する"
  },
  State_147962_Desc = {
    Text = "以降、プレイヤーが「<DerivativeCardKeywords_158:身代わり>」を発射する際、<MonsterSinMarkKeywords:罪印>スタック数の50%しか解除されず、さらに指令カード「聖子・白夜」を1枚発射するたびに1スタック<MonsterSinMarkKeywords:罪印>を獲得する。"
  },
  State_147962_Name = {
    Text = "浄化の道"
  },
  State_147967_Desc = {
    Text = "「聖子・白夜」が与えるダメージに [DescArg1]% の<BleedingIconKeywords:出血>を付与する。"
  },
  State_147968_Desc = {
    Text = "上限 3 層。攻撃意図に切り替えた時、「聖子・白夜」が与えるダメージを 25% 上昇させ、1 層消費する。"
  },
  State_147968_Name = {
    Text = "苦痛による贖罪"
  },
  State_147969_Desc = {
    Text = "「聖子・白夜」が「聖心」意図の時、指令カードを 1 枚発射するごとに 2 層の<MonsterPolluxFever:狂熱>を蓄積する。"
  },
  State_147969_Name = {
    Text = "御子の新約"
  },
  State_147971_Desc = {
    Text = "この覚醒体はまだ覚醒していない…倒れそうになるとライフを回復し1スタック<InvincibleUntilRoused:銀芯固化>を獲得する。覚醒後は<InvincibleUntilRoused:銀芯固化>を解除し、真の姿で戦闘を開始する。"
  },
  State_147971_Name = {Text = "未覚醒"},
  State_147972_Desc = {
    Text = "1層ごとに「聖子・白夜」が与えるダメージに 1% の<BleedingIconKeywords:出血>を付与する。"
  },
  State_147974_Desc = {
    Text = "ターン開始後に除去される。10 層に達した後、次にカードを発射した直後に行動し、狂熱を除去して意図を「聖心」に切り替える。"
  },
  State_147974_Name = {
    Text = "一時的な狂熱"
  },
  State_147975_Desc = {
    Text = "戦闘開始時、「<DerivativeCardKeywords_158:身代わり>」を 1 枚手札に加え、ターン終了後、5 層の<MonsterSinMarkKeywords:罪印>を獲得する。"
  },
  State_147975_Name = {
    Text = "灯明者の使徒"
  },
  State_147993_Desc = {
    Text = "上限 3 層。攻撃意図に切り替えた時、「聖子・白夜」が与えるダメージを 25% 上昇させ、1 層消費する。"
  },
  State_147993_Name = {
    Text = "苦痛による贖罪"
  },
  State_148020_Desc = {
    Text = "あらゆるダメージを免疫し、ライフを失わなくなる。覚醒後に除去される。"
  },
  State_148020_Name = {
    Text = "銀芯固化"
  },
  State_148021_Name = {
    Text = "ステータス@モンスター汎用・復活覚醒前免疫除去識別"
  },
  State_148073_Name = {
    Text = "カードを1枚引く"
  },
  State_148074_Desc = {
    Text = "捨て札フェイズ時、捨て札に行かず、手札に残る。"
  },
  State_148074_Name = {
    Text = "<RetainIconKeywords:保持>"
  },
  State_148074_WeaponDesc = {
    Text = "捨て札フェイズ時、捨て札に行かず、手札に残る。"
  },
  State_148076_Name = {
    Text = "浄世の道・カード発射監視"
  },
  State_148116_Desc = {
    Text = "1ターン後に[StateArg1]枚のカードを[Layer]回ドローする。"
  },
  State_148116_Name = {
    Text = "遅延ドロー1"
  },
  State_148381_Desc = {
    Text = "ターン終了まで、自身が与えるダメージに 100%の<BleedingIconKeywords:出血>を付与する。"
  },
  State_148381_Name = {
    Text = "束縛されし怨念"
  },
  State_148383_Desc = {
    Text = "上限3スタック。「憎しみ」を3スタック持っている場合、次に意図が「鮮血の鎖」に切り替わる際、意図を「嗜血のチェインボール」に切り替え「憎しみ」を解除する。"
  },
  State_148383_Name = {
    Text = "「憎しみ」"
  },
  State_148385_Desc = {
    Text = "敵が指令カードを発射するたびに 2 層の<MonsterB05EXFever:一時的な狂熱>を獲得する。"
  },
  State_148385_Name = {
    Text = "不規則形態"
  },
  State_148386_Desc = {
    Text = "ターン終了まで、シールドを獲得できない。"
  },
  State_148386_Name = {
    Text = "呪縛の鎖"
  },
  State_148387_Desc = {
    Text = "この覚醒体はまだ覚醒していない…倒れそうになるとライフを回復し1スタック<InvincibleUntilRoused:銀芯固化>を獲得する。覚醒後は<InvincibleUntilRoused:銀芯固化>を解除し、真の姿で戦闘を開始する。"
  },
  State_148387_Name = {Text = "未覚醒"},
  State_148391_Desc = {
    Text = "ターン終了まで、自身が与えるダメージに 100%の<BleedingIconKeywords:出血>を付与する。"
  },
  State_148391_Name = {
    Text = "呪縛の鎖"
  },
  State_148392_Desc = {
    Text = "ターン開始後に除去される。10 層に達した後、次にカードを発射した直後に行動し、狂熱を除去して意図を「鮮血の鎖」に切り替える。"
  },
  State_148392_Name = {
    Text = "一時的な狂熱"
  },
  State_148394_Desc = {
    Text = "ターン開始時に<ResentChainsKeywords:怨恨の鎖>を1スタック獲得する。意図が「嗜血のチェインボール」に切り替わる時、敵のターン終了まで一切のダメージとライフ損失効果を免疫する。"
  },
  State_148394_Name = {
    Text = "復讐の誓い"
  },
  State_148395_Desc = {
    Text = "一切のダメージ（刺突ダメージを含む）を免疫し、ライフを失うことができない。敵のターン終了後に除去される。"
  },
  State_148395_Name = {
    Text = "ソウルリーパー宣言–嗜血のチェインボール"
  },
  State_148421_Desc = {
    Text = "1 ターン後にすべての敵の<ExhaustionIconKeywords:力>を一時的に [StateArg1] 点低下させる [Layer] 回"
  },
  State_148421_Name = {
    Text = "遅延衰弱1"
  },
  State_148422_Desc = {
    Text = "1ターン後に一時的ダメージ強化[StateArg1]%を[Layer]回得る。"
  },
  State_148422_Name = {
    Text = "遅延一時的ダメージ強化1"
  },
  State_148423_Desc = {
    Text = "1 ターン後に <Posse:[StateArg1]> 点のキーエネルギーを [Layer] 回獲得する。"
  },
  State_148423_Name = {
    Text = "遅延キーエネルギー1"
  },
  State_148426_Desc = {
    Text = "1 ターン後に [StateArg1] 点の行動力を [Layer] 回獲得する。"
  },
  State_148426_Name = {
    Text = "遅延行動力1"
  },
  State_148427_Desc = {
    Text = "1 ターン後にすべての覚醒体が [StateArg1] 点の狂気を [Layer] 回獲得する。"
  },
  State_148427_Name = {
    Text = "遅延狂気1"
  },
  State_148428_Desc = {
    Text = "1 ターン後に [StateArg1] 点の<PowerIconKeywords:力>を [Layer] 回獲得する。"
  },
  State_148428_Name = {Text = "遅延力1"},
  State_148511_Desc = {
    Text = "チームユニーク：探索開始後、1枚の<Backupbody[StateArg3]:「霊魂同調」>をデッキに加える。「霊魂同調」：行動力消費0、発射後1点の行動力を獲得する。<RetainIconKeywords:保留>：装備者の体力 <WeaponEffect_Num:[StateArg1]%> 分の固定ライフ回復量と <WeaponEffect_Num:[StateArg2]> 点の固定狂気をこのカードに蓄積する。このカードが破壊されていない場合、一度の死亡を免疫し、蓄積されたすべてのライフ回復量と狂気を解放し、その後このカードを<DestructionKeywords:破壊>する。"
  },
  State_148511_Name = {
    Text = "霊魂同調"
  },
  State_148511_WeaponDesc = {
    Text = "探索開始後、1枚の<Backupbody[StateArg3]:「霊魂同調」>をデッキに加える。「霊魂同調」：行動力消費0、発射後1点の行動力を獲得する。<RetainIconKeywords:保留>：装備者の体力 <WeaponEffect_Num:[StateArg1]%> 分の固定ライフ回復量と <WeaponEffect_Num:[StateArg2]> 点の固定狂気をこのカードに蓄積する。このカードが破壊されていない場合、一度の死亡を免疫し、蓄積されたすべてのライフ回復量と狂気を解放し、その後このカードを<DestructionKeywords:破壊>する。"
  },
  State_148513_Desc = {
    Text = "相手のターン終了時に手札を捨てない。ターン終了時に2点の<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>、<HeavyInjuryKeywords:重傷>、<VulnerabilityIconKeywords:易傷>を順に付与する。"
  },
  State_148513_Name = {
    Text = "界外の音"
  },
  State_148520_Desc = {
    Text = "ターン終了まで、シールドを獲得できない。"
  },
  State_148520_Name = {
    Text = "束縛されし怨念"
  },
  State_148522_Desc = {
    Text = "チームユニーク：装備者「狂気解放」が与えるシールドと力が<WeaponEffect_Num:[StateArg1]%>上昇する。"
  },
  State_148524_Desc = {
    Text = "チームユニーク：装備者「狂気解放」が与えるシールドと力が<WeaponEffect_Num:[StateArg1]%>上昇する。装備者「防御」が与えるシールドが<WeaponEffect_Num:[StateArg2]%>上昇する。装備者が「防御」を発射した後、装備者の攻撃力の<WeaponEffect_Num:[StateArg3]%>に相当する力を獲得する。"
  },
  State_148540_Desc = {
    Text = "レイテンシ[Layer] ：<AwakerName:[DescArg1]> の行動力が最も高い [StateArg1] 枚の指令カードの行動力消費が [StateArg2] 低下する。"
  },
  State_148540_Name = {
    Text = "予見の鏡 – レイテンシ[Layer]"
  },
  State_148541_Name = {
    Text = "手札の選択した覚醒体カードの「遅延」効果を除去する"
  },
  State_148544_Desc = {
    Text = "レイテンシ[Layer] ：<AwakerName:[DescArg1]> の次の狂気解放で狂気を1ポイント消費するごとに [StateArg1] ポイントのキーエネルギーを獲得する。"
  },
  State_148544_Name = {
    Text = "悪魔の鍵 – レイテンシ[Layer]"
  },
  State_148547_Desc = {
    Text = "<AwakerName:[DescArg1]> の次の狂気解放を極限解放として扱う。すでに極限解放である場合、基礎狂気を100％返還する。"
  },
  State_148547_Name = {
    Text = "永遠の冠"
  },
  State_148548_Desc = {
    Text = "保留：すべての覚醒体は5点の狂気を獲得する。"
  },
  State_148548_Name = {
    Text = "倒影に収める"
  },
  State_148549_Name = {
    Text = "手札にあるすべての「準備」効果を発動する"
  },
  State_148553_Desc = {
    Text = "レイテンシ[Layer] ：<AwakerName:[DescArg1]> が発射する次の [Layer] 枚の指令カードが、失ったライフの [StateArg2]％ に等しいシールドを獲得する。"
  },
  State_148553_Name = {
    Text = "誘惑の果実 – レイテンシ[Layer]"
  },
  State_148554_Desc = {
    Text = "<AwakerName:[DescArg1]> の指令カードが与えるダメージに[Layer]％の出血を付与する。"
  },
  State_148554_Name = {
    Text = "必滅の眼"
  },
  State_148556_Desc = {
    Text = "手札にある時、すべての覚醒体がアクティブダメージを与える際に10％の出血を付与する。"
  },
  State_148556_Name = {
    Text = "悪夢は予定通りに訪れる"
  },
  State_148557_Desc = {
    Text = "<AwakerName:[DescArg1]> が発射する次の [Layer] 枚の指令カードが、失ったライフの [StateArg1]％ に等しいシールドを獲得する。"
  },
  State_148557_Name = {
    Text = "誘惑の果実"
  },
  State_148559_Desc = {
    Text = "<AwakerName:[DescArg1]> の次の狂気解放で狂気を1ポイント消費するごとに [Layer] ポイントのキーエネルギーを獲得する。"
  },
  State_148559_Name = {
    Text = "悪魔の鍵"
  },
  State_148561_Desc = {
    Text = "このカードを発射する時、以下の三つの負面効果からランダムで一つを発動する：効果が50％低下/レイテンシ2回合発動/ランダムで負面効果を1つ獲得。"
  },
  State_148561_Name = {
    Text = "<ExclamationPointColour:歪んだ願い>"
  },
  State_148562_Name = {
    Text = "選択した覚醒体が狂気を10ポイント獲得"
  },
  State_148563_Desc = {
    Text = "レイテンシ[Layer] ：<AwakerName:[DescArg1]> の次の狂気解放で獲得するシールドとライフ回復が [StateArg1]％ 上昇する。"
  },
  State_148563_Name = {
    Text = "公正の羽 – レイテンシ[Layer]"
  },
  State_148566_Desc = {
    Text = "<AwakerName:[DescArg1]> の次の狂気解放が与えるダメージに[Layer]％の運命裁断を付与する。"
  },
  State_148566_Name = {
    Text = "運命の糸"
  },
  State_148569_Desc = {
    Text = "<AwakerName:[DescArg1]> の次の狂気解放で獲得するシールドとライフ回復が [Layer]％ 上昇する。"
  },
  State_148569_Name = {
    Text = "公正の羽"
  },
  State_148571_Desc = {
    Text = "レイテンシ[Layer] ：<AwakerName:[DescArg1]> の指令カードが与えるダメージに[StateArg1]％の出血を付与する。"
  },
  State_148571_Name = {
    Text = "必滅の眼 – レイテンシ[Layer]"
  },
  State_148574_Desc = {
    Text = "レイテンシ[Layer] ：<AwakerName:[DescArg1]> の次の狂気解放が与えるダメージに[StateArg1]％の運命裁断を付与する。"
  },
  State_148574_Name = {
    Text = "運命の糸 – レイテンシ[Layer]"
  },
  State_148575_Name = {
    Text = "選択した覚醒体が狂気を20ポイント獲得"
  },
  State_149089_Name = {
    Text = "ステータス@提灯犬小吞食狂気標識"
  },
  State_149092_Desc = {
    Text = "「<AwakerName:[DescArg1]>」の<Energy:[Energy:DescArg2]>点の狂気を吞み込んだ。死亡後に返還される。"
  },
  State_149092_Name = {Text = "呑食"},
  State_149094_Desc = {
    Text = "チームユニーク：装備者の狂気解放が与える基礎シールドが <WeaponEffect_Num:[StateArg1]%> 上昇する。装備者が<WeaknessIconKeywords:虚弱>を与える指令カードを発射した後、次の装備者の指令カードが与える基礎シールドを <WeaponEffect_Num:[StateArg1]%> 上昇させる。「猩紅炉」使用時に装備者の行動力消費が最も高いスキルカードを1枚ドローし、<EmbryoFusionIconKeywords:胎児融合> +<WeaponEffect_Num: [StateArg1]>、クールダウン3ターン。"
  },
  State_149094_WeaponDesc = {
    Text = "装備者の狂気解放が与える基礎シールドが <WeaponEffect_Num:[StateArg1]%> 上昇する。装備者が<WeaknessIconKeywords:虚弱>を与える指令カードを発射した後、次の装備者の指令カードが与える基礎シールドを <WeaponEffect_Num:[StateArg1]%> 上昇させる。「猩紅炉」使用時に装備者の行動力消費が最も高いスキルカードを1枚ドローし、<EmbryoFusionIconKeywords:胎児融合> +<WeaponEffect_Num: [StateArg1]>、クールダウン3ターン。"
  },
  State_149122_Desc = {
    Text = "死亡後、直ちにランダムな「ハティ猟群」または「スクール猟群」を1体召喚し、その「クラスター効果」を1スタック低下させる。"
  },
  State_149122_Name = {
    Text = "クラスター効果"
  },
  State_149123_Desc = {
    Text = "狂気解放によるダメージを50％軽減する。"
  },
  State_149123_Name = {
    Text = "灯芯化・熔"
  },
  State_149124_Desc = {
    Text = "指令カードによるダメージを50％軽減する。"
  },
  State_149124_Name = {
    Text = "灯芯化・影"
  },
  State_149125_Desc = {
    Text = "「<AwakerName:[DescArg1]>」の指令カードを凍結した。死亡後、その覚醒体の凍結を解除する。"
  },
  State_149125_Name = {Text = "呑食"},
  State_149126_Desc = {
    Text = "死亡後、直ちにランダムな「スクール猟群」を1体召喚し、その「クラスター効果」を1スタック低下させる。"
  },
  State_149126_Name = {
    Text = "クラスター効果"
  },
  State_149128_Name = {
    Text = "ステータス@冰雪提灯犬小凍結カード標識"
  },
  State_149140_Desc = {
    Text = "敵のスキル効果を強化する。ダメージを受けると1点失う。"
  },
  State_149140_Name = {
    Text = "血の誓い"
  },
  State_149143_Desc = {
    Text = "ドローフェイズ終了後、敵の手札に<SlowIconKeywords:遅延>指令カードが[DescArg1]枚あるごとに、自身は[DescArg2]スタックの<BloodOath_New:血の誓い>を獲得する。自身がブロックされなかったダメージを与えた後、手札またはドロー山にある<SlowIconKeywords:遅延>されていない指令カード[DescArg3]枚にランダムで[DescArg4]スタックの<SlowIconKeywords:遅延>を付与する。"
  },
  State_149143_Name = {
    Text = "凝滞の血誓"
  },
  State_149162_Desc = {
    Text = "ガードされていないダメージを与えた時、デスレジスタンスを除去する"
  },
  State_149162_Name = {
    Text = "極東の呪術"
  },
  State_149163_Desc = {
    Text = "最大ライフを同スタック数分低下させる。戦闘終了後に半減する。"
  },
  State_149163_Name = {
    Text = "<BoneHitKeywords:Scathe>"
  },
  State_149164_Desc = {
    Text = "ダメージを与える際にScatheを付与する"
  },
  State_149164_Name = {
    Text = "骨を刺す霜"
  },
  State_149167_Desc = {
    Text = "最大ライフを[Layer]低下させる。戦闘終了後に半減する。"
  },
  State_149167_Name = {
    Text = "<BoneHitKeywords:Scathe>"
  },
  State_149169_Desc = {
    Text = "1スタックごとにカラブの体力の15%に等しい最大ライフが上昇し、「飽満」は最大50スタックまで蓄積できる。このステータスを得た時すでに上限に達している場合、超過した1スタックごとに同量の3倍のライフを回復する。非ボスバトル1戦につき最大10スタックの「飽満」を得られる。戦闘終了時に解除されない。"
  },
  State_149169_Name = {
    Text = "<WormGrowth:飽食>"
  },
  State_149172_Desc = {
    Text = "チームユニーク：装備者が<WeaknessIconKeywords:虚弱>を与える指令カードを発射した後、次の装備者の指令カードが与える基礎シールドを <WeaponEffect_Num:[StateArg1]%> 上昇させる。"
  },
  State_149172_WeaponDesc = {
    Text = "装備者が<WeaknessIconKeywords:虚弱>を与える指令カードを発射した後、次の装備者の指令カードが与える基礎シールドを <WeaponEffect_Num:[StateArg1]%> 上昇させる。"
  },
  State_149187_Desc = {
    Text = "テスト｜固定ダメージを受けた後、固定ダメージによるキル後を監視し、トリガー値と関連者を出力する。"
  },
  State_149187_Name = {
    Text = "固定ダメージテスト"
  },
  State_149188_Desc = {
    Text = "テスト｜固定ダメージによるキル後、トリガー値1、キル実際ダメージ：[Layer]"
  },
  State_149188_Name = {
    Text = "固定ダメージキルトリガー値2テスト"
  },
  State_149189_Desc = {
    Text = "テスト｜固定ダメージによるキル後、関連者2、キルをもたらした元：[Layer]"
  },
  State_149189_Name = {
    Text = "固定ダメージキル関連者2テスト"
  },
  State_149190_Desc = {
    Text = "テスト｜固定ダメージによるキル後、トリガー値1、キル超過ダメージ：[Layer]"
  },
  State_149190_Name = {
    Text = "固定ダメージキルトリガー値3テスト"
  },
  State_149191_Desc = {
    Text = "テスト｜固定ダメージを受けた後、トリガー値1、総ダメージ：[Layer]"
  },
  State_149191_Name = {
    Text = "固定ダメージトリガー値1テスト"
  },
  State_149192_Desc = {
    Text = "テスト｜固定ダメージによるキル後、関連者1、キルされた者：[Layer]"
  },
  State_149192_Name = {
    Text = "固定ダメージキル関連者1テスト"
  },
  State_149193_Desc = {
    Text = "テスト｜固定ダメージを受けた後、関連者2、被撃者：[Layer]"
  },
  State_149193_Name = {
    Text = "固定ダメージ関連者2テスト"
  },
  State_149194_Desc = {
    Text = "テスト｜固定ダメージを受けた後、トリガー値1、総ダメージ：[Layer]"
  },
  State_149194_Name = {
    Text = "固定ダメージトリガー値2テスト"
  },
  State_149195_Desc = {
    Text = "テスト｜固定ダメージによるキル後、トリガー値1、キル総ダメージ：[Layer]"
  },
  State_149195_Name = {
    Text = "固定ダメージキルトリガー値1テスト"
  },
  State_149196_Desc = {
    Text = "テスト｜固定ダメージを受けた後、関連者1、ダメージ元：[Layer]"
  },
  State_149196_Name = {
    Text = "固定ダメージ関連者1テスト"
  },
  State_149227_Desc = {
    Text = "ターン終了時にシールドが消滅しない。シールドを持つ時、受ける狂気解放ダメージが50％上昇し、指令カードから受けるダメージが50％低下する。"
  },
  State_149227_Name = {
    Text = "雪幕隠身"
  },
  State_149228_Desc = {
    Text = "ダメージを与える際に出血を付与する"
  },
  State_149228_Name = {Text = "血穿通"},
  State_149229_Desc = {
    Text = "登場時に最大ライフの25％を失い、失った値の[DescArg1]％分の「フロストシールド」に転化する。"
  },
  State_149229_Name = {
    Text = "フロストシールド転化"
  },
  State_149230_Desc = {
    Text = "指令カードから受けるダメージが50％上昇し、受ける狂気解放ダメージが50％低下する。"
  },
  State_149230_Name = {
    Text = "ステータス@暗色の外衣ダメージ増減"
  },
  State_149232_Desc = {
    Text = "ターン終了時にシールドが消滅しない。シールドを持つ時、指令カードから受けるダメージが50％上昇し、受ける狂気解放ダメージが50％低下する。"
  },
  State_149232_Name = {
    Text = "暗影隠身"
  },
  State_149233_Desc = {
    Text = "受ける狂気解放ダメージが50％上昇し、指令カードから受けるダメージが50％低下する。"
  },
  State_149233_Name = {
    Text = "ステータス@雪色の外衣ダメージ増減"
  },
  State_149234_Desc = {
    Text = "登場時に最大ライフの25％を失い、失った値の[DescArg1]％分の「呪盾」に転化する。"
  },
  State_149234_Name = {
    Text = "呪盾転化"
  },
  State_149235_Desc = {
    Text = "ガードされていないダメージを与えた時、デスレジスタンスを除去する"
  },
  State_149235_Name = {
    Text = "提灯魔術"
  },
  State_149250_Desc = {
    Text = "受ける指令カードダメージ+50%"
  },
  State_149250_Name = {
    Text = "受ける指令カードダメージ+50%"
  },
  State_149251_Desc = {
    Text = "受ける指令カードダメージ-50%"
  },
  State_149251_Name = {
    Text = "受ける指令カードダメージ-50%"
  },
  State_149252_Desc = {
    Text = "受ける狂気解放ダメージ-50%"
  },
  State_149252_Name = {
    Text = "受ける狂気解放ダメージ-50%"
  },
  State_149253_Desc = {
    Text = "受ける狂気解放ダメージ+50%"
  },
  State_149253_Name = {
    Text = "受ける狂気解放ダメージ+50%"
  },
  State_149265_Desc = {
    Text = "死亡後すぐにランダムな「ウェンディゴ」を1体召喚し、その「クラスター効果」を1段階低下させる。"
  },
  State_149265_Name = {
    Text = "クラスター効果"
  },
  State_149268_Desc = {
    Text = "すべてのシールドを失った時、75層の一時的堅固を獲得し1層の「吹雪に没する」を除去して、意図を<BoneHitKeywords:Scathe>を付与する強力な攻撃に置き換える。"
  },
  State_149268_Name = {
    Text = "吹雪に没する"
  },
  State_149269_Desc = {
    Text = "すべてのシールドを失った時、75層の一時的堅固を獲得し1層の「暗影に没する」を除去して、意図を狂気を奪う強力な攻撃に置き換える。"
  },
  State_149269_Name = {
    Text = "暗影に没する"
  },
  State_149270_Desc = {
    Text = "死亡後すぐにランダムな「ウェンディゴ」を1体召喚し、その「クラスター効果」を1段階低下させる。"
  },
  State_149270_Name = {
    Text = "クラスター効果"
  },
  State_149308_Name = {
    Text = "ステータス@提灯祈祷者遅延スタック数記録"
  },
  State_149391_Desc = {
    Text = "この覚醒体はまだ覚醒していない…倒れそうになるとライフを回復し1スタック<InvincibleUntilRoused:銀芯固化>を獲得する。覚醒後は<InvincibleUntilRoused:銀芯固化>を解除し、真の姿で戦闘を開始する。"
  },
  State_149391_Name = {Text = "未覚醒"},
  State_149398_Desc = {
    Text = "「白雪の妖精」のインテントが「粉雪の呪い」に切り替わる際に1層消費し、インテントを「奇跡の祝福」に変化させる。"
  },
  State_149398_Name = {Text = "飽食"},
  State_149399_Desc = {
    Text = "「白雪の妖精」が「完璧なおとぎ話」を使用した後、次の[DescArg1]個のインテントはすべて「粉雪の呪い」になる。毎ターン、[DescArg2]枚の[DescArg3]層の<SlowIconKeywords:遅延>を持つランダムな<Blessing:祝福>をデッキにシャッフルする。"
  },
  State_149399_Name = {
    Text = "魅惑の甘い果実"
  },
  State_149418_Desc = {
    Text = "クリティカルが発生せず、基礎ダメージとして扱われず、最終ダメージ等のボーナスの影響を受けない。"
  },
  State_149418_Name = {
    Text = "<RealDamage:固定ダメージ>"
  },
  State_149419_Name = {
    Text = "<Rune_6:鉄壁>"
  },
  State_149420_Name = {
    Text = "<Rune_3:神技>"
  },
  State_149421_Name = {
    Text = "<Rune_15:爆発>"
  },
  State_149422_Name = {
    Text = "<Rune_4:策謀>"
  },
  State_149423_Name = {
    Text = "<Rune_11:統御>"
  },
  State_149424_Name = {
    Text = "<Rune_12:好血>"
  },
  State_149425_Name = {
    Text = "<Rune_1:易傷>"
  },
  State_149426_Name = {
    Text = "<Rune_14:剛力>"
  },
  State_149427_Name = {
    Text = "<Rune_2:倦怠>"
  },
  State_149428_Name = {
    Text = "<Rune_9:反撃>"
  },
  State_149430_Name = {
    Text = "<Rune_18:衰弱>"
  },
  State_149576_Desc = {
    Text = "「白雪の妖精」のインテントが「粉雪の呪い」に切り替わる際に1層消費し、インテントを「奇跡の祝福」に変化させる。"
  },
  State_149576_Name = {Text = "飽食"},
  State_149618_Desc = {
    Text = "2ターン後、以下の効果を発動する：\n[DescArg1]点の行動力を得る。 \n[DescArg2]点の力を得る。 \n[DescArg3]点のキーエネルギーを得る。 \n[DescArg5]点の狂気を得る。 \n[DescArg6]枚のカードをドローする。\n[DescArg7]点の一時的ダメージ強化を得る。\nすべての敵の力を一時的に[DescArg4]点低下させる。"
  },
  State_149618_Name = {
    Text = "逃した好機2"
  },
  State_149619_Desc = {
    Text = "1ターン後、以下の効果を発動する：\n[DescArg1]点の行動力を得る。 \n[DescArg2]点の力を得る。 \n[DescArg3]点のキーエネルギーを得る。 \n[DescArg5]点の狂気を得る。 \n[DescArg6]枚のカードをドローする。\n[DescArg7]点の一時的ダメージ強化を得る。\nすべての敵の力を一時的に[DescArg4]点低下させる。"
  },
  State_149619_Name = {
    Text = "逃した好機1"
  },
  State_149628_Desc = {
    Text = "ターン終了前に敵がキーエネルギーを1000点以上持っている場合、キーエネルギーを1000点捕食する。"
  },
  State_149628_Name = {
    Text = "シルバーキーの供物"
  },
  State_149629_Desc = {
    Text = "ターン終了前に狂気が最も高い覚醒体が少なくとも 100 点の狂気を持っている場合、その覚醒体の 50 点の狂気を捕食する。"
  },
  State_149629_Name = {
    Text = "供物狂気"
  },
  State_149630_Desc = {
    Text = "ターン終了前に敵がキーエネルギーを1000点以上持っている場合、キーエネルギーを1000点捕食する。"
  },
  State_149630_Name = {
    Text = "シルバーキーの供物"
  },
  State_149631_Desc = {
    Text = "ターン終了前に敵が行動力を3点以上持っている場合、行動力を3点捕食する。"
  },
  State_149631_Name = {
    Text = "行動力の供物"
  },
  State_149632_Desc = {
    Text = "ターン終了前に敵が行動力を3点以上持っている場合、行動力を3点捕食する。"
  },
  State_149632_Name = {
    Text = "行動力の供物"
  },
  State_149633_Desc = {
    Text = "捨て札フェーズ前に敵の手札に指令カードが4枚以上残っている場合、ランダムな指令カードを2枚捕食する。"
  },
  State_149633_Name = {
    Text = "指令カードの供物"
  },
  State_149634_Desc = {
    Text = "捨て札フェーズ前に敵の手札に指令カードが4枚以上残っている場合、ランダムな指令カードを2枚捕食する。"
  },
  State_149634_Name = {
    Text = "指令カードの供物"
  },
  State_149635_Desc = {
    Text = "ターン終了前に狂気が最も高い覚醒体が少なくとも 100 点の狂気を持っている場合、その覚醒体の 50 点の狂気を捕食する。"
  },
  State_149635_Name = {
    Text = "供物狂気"
  },
  State_149652_Desc = {
    Text = "クリティカルが発生できず、対応する覚醒体が与えたダメージとして扱わない。"
  },
  State_149652_Name = {
    Text = "<FixedDamage:純粋ダメージ>"
  },
  State_149660_Desc = {
    Text = "このカードが与えるダメージ・シールド・力の変化を [DescArg2]％ 上昇させ、触腕ダメージ・ライフ回復・固定毒・固定カウンターの最終効果を [DescArg1]% 上昇させる。発射後に除去される。"
  },
  State_149660_Name = {
    Text = "強化 [DescArg1]"
  },
  State_149664_Desc = {
    Text = "1 層ごとにこのカードが与えるダメージ・固定力と触腕ダメージ上昇・固定毒・固定カウンターの最終効果を 2％ 上昇させる；固定シールド・固定ライフ回復・力減少の最終効果を 1％ 上昇させる。発射後に除去される。"
  },
  State_149664_Name = {Text = "強化"},
  State_149719_Name = {
    Text = "PVP純粋ダメージ免疫__「開発用のみ」"
  },
  State_149736_Desc = {
    Text = "次の [Layer] 枚の<AwakerName:[DescArg1]>指令カードが与える基礎シールドが [StateArg1]% 上昇する。"
  },
  State_149736_Name = {
    Text = "甘美な欺瞞"
  },
  State_149744_Desc = {
    Text = "次の[Layer]枚発射した祝福は負面効果を発動しない"
  },
  State_149744_Name = {
    Text = "妖精の加護"
  },
  State_149772_Desc = {
    Text = "アクティブダメージを受けるたびにすべての覚醒体の狂気を3減少させ、1ターンにつき最大5回まで発動する。シールドを破壊した後、「呪盾」ステータスを除去する。"
  },
  State_149772_Name = {Text = "呪盾"},
  State_149773_Desc = {
    Text = "アクティブダメージを受けるたびに手札のランダムなカードに1スタックの一時的「遅延」を付与し、1ターンにつき最大5回まで発動する。シールドを破壊した後、「フロストシールド」ステータスを除去する。"
  },
  State_149773_Name = {
    Text = "フロストシールド"
  },
  State_149782_Desc = {
    Text = "消費：次のターンのドロー後、「万化の果実」を1枚ドロー山にシャッフルする。"
  },
  State_149782_Name = {
    Text = "万化の果実"
  },
  State_149787_Desc = {
    Text = "1スタックごとに、負誓·オジールの指令カードの最終ダメージが[DescArg2]%上昇し、ターン開始時のドロー数が-1され、クリティカルダメージが[DescArg3]%上昇する。上限[DescArg1]スタック、戦闘終了時に消去されない。"
  },
  State_149787_Name = {
    Text = "<KuangNu:暗流>"
  },
  State_149788_Desc = {
    Text = "負誓·オジールの「スキル」を発射する際、1スタックを消費して「防御」を1枚ドローし、次に発射するまでの間保留を獲得する。上限[DescArg1]スタック、戦闘終了時に消去されない。"
  },
  State_149788_Name = {
    Text = "<ShuZui:自罪>"
  },
  State_149789_Desc = {
    Text = "1スタックごとに、負誓·オジールの指令カードの最終ダメージが33%上昇し、ターン開始時のドロー数が-1される。上限[DescArg1]スタック、戦闘終了時に消去されない。"
  },
  State_149789_Name = {
    Text = "<KuangNu:暗流>"
  },
  State_149790_Desc = {
    Text = "1スタックごとに、負誓·オジールの指令カードの最終ダメージが[DescArg2]%上昇し、ターン開始時のドロー数が-1される。上限[DescArg1]スタック、戦闘終了時に消去されない。"
  },
  State_149790_Name = {
    Text = "<KuangNu:暗流>"
  },
  State_149791_Desc = {
    Text = "負誓·オジールの「スキル」を発射する際、1スタックを消費して「防御」を1枚ドローし、次に発射するまでの間保留を獲得する。上限[DescArg1]スタック、戦闘終了時に消去されない。"
  },
  State_149814_Desc = {
    Text = "一時的なダメージ強化 +[Layer]％。"
  },
  State_149814_Name = {
    Text = "一時的ダメージ強化"
  },
  State_149819_Desc = {
    Text = "すべてのダメージを無効化"
  },
  State_149819_Name = {Text = "無効化"},
  State_149892_Desc = {
    Text = "次の [Layer] 枚の<AwakerName:[DescArg1]>指令カードが与える基礎シールドが [StateArg1]% 上昇する。"
  },
  State_149892_Name = {
    Text = "甘美なる真相"
  },
  State_149913_Name = {
    Text = "ステータス@マクロファージワームの宝物特効_ティンクト破損"
  },
  State_149914_Name = {
    Text = "ステータス@マクロファージワーム宝物特効_ウィリアム破損"
  },
  State_149915_Name = {
    Text = "ステータス@マクロファージワーム宝物特効_ウィリアム"
  },
  State_149916_Name = {
    Text = "ステータス@マクロファージワーム宝物特効_カストル破損"
  },
  State_149917_Name = {
    Text = "ステータス@マクロファージワームの宝物特効_ブラッドチェーンヘロット破損"
  },
  State_149918_Name = {
    Text = "ステータス@マクロファージワームのターン開始テスト"
  },
  State_149919_Name = {
    Text = "ステータス@マクロファージワームの宝物特効_ティンクト"
  },
  State_149920_Name = {
    Text = "ステータス@マクロファージワームの宝物特効_アラクネ"
  },
  State_149921_Name = {
    Text = "ステータス@マクロファージワームの宝物特効_アラクネ破損"
  },
  State_149922_Name = {
    Text = "ステータス@マクロファージワーム宝物特効_カストル"
  },
  State_149923_Name = {
    Text = "ステータス@マクロファージワームの宝物特効_ブラッドチェーンヘロット"
  },
  State_149930_Desc = {
    Text = "1スタックごとに、負誓·オジールの指令カードの最終ダメージが50％上昇し、ターン開始時のドロー数が-1される。上限[DescArg1]スタック、戦闘終了時に消去されない。"
  },
  State_149930_Name = {
    Text = "<KuangNu2:暗流>"
  },
  State_149931_Desc = {
    Text = "全7種類の効果があり、以下を含む：力を得る、ドロー、行動力を得る、キーエネルギーを得る、一時的なダメージ強化上昇、すべての覚醒体が狂気を得る、すべての敵の力を一時的に減少させる。"
  },
  State_149931_Name = {
    Text = "<Blessing:ギフト>"
  },
  State_149933_Name = {
    Text = "ステータス@モンスターカラブ供物バブル"
  },
  State_149934_Name = {
    Text = "ステータス@モンスターカラブ供物バブル"
  },
  State_149939_Desc = {
    Text = "ターン終了まで、シールドを獲得できない。"
  },
  State_149939_Name = {
    Text = "呪縛の鎖"
  },
  State_19507_Desc = {
    Text = "次のターン開始まで受けるアクティブ攻撃ダメージと出血の層数が25％増加し、付与時に堅固と相殺される。"
  },
  State_19507_Name = {
    Text = "<PVPVulnerabilityIconColour:軟化>"
  },
  State_19508_Desc = {
    Text = "ターン終了時、このカードを捨てる。"
  },
  State_19508_Name = {
    Text = "<PVPVoidKeyColour:虚無>"
  },
  State_19509_Desc = {
    Text = "一時的にカードの行動力を変更。__「開発用」"
  },
  State_19509_Name = {
    Text = "永久カード行動力消費変更__「開発用」"
  },
  State_19511_Desc = {
    Text = "死亡後、手札を幻影に置き換える__「開発用」"
  },
  State_19511_Name = {
    Text = "死亡手札変換幻影トリガー__「開発用」"
  },
  State_19513_Name = {
    Text = "死闘を付与__「開発用」"
  },
  State_19516_Name = {
    Text = "一時的にカードの行動力を変更__「開発用」"
  },
  State_19517_Desc = {
    Text = "ライフを2%失うごとに、1の狂気を獲得。__「開発用」"
  },
  State_19517_Name = {
    Text = "ダメージを受けると狂気を獲得。__「開発用」"
  },
  State_19519_Desc = {
    Text = "「攻撃」使用後、すべての点数を消費する。1点につき、今回の「攻撃」が与えるダメージが50%上昇する。最大5点まで累積可能。（現在合計[DescArg1]%上昇）"
  },
  State_19521_Desc = {
    Text = "1点につき、この戦闘中に与えるすべてのダメージを1増加させる。解除不可。"
  },
  State_19521_Name = {
    Text = "<PowerColourKeywords:力>"
  },
  State_19522_Name = {
    Text = "一時的にカードの行動力を変更__「開発用」"
  },
  State_19523_Name = {
    Text = "永久カード行動力消費変更__「開発用」"
  },
  State_19524_Desc = {
    Text = "次のターン開始まで、攻撃を受けるたびに攻撃者に[Layer]の純粋ダメージを与える。"
  },
  State_19524_Name = {Text = "反撃"},
  State_19525_Desc = {
    Text = "ターン開始前に覚醒体シールドを除去__「開発用」"
  },
  State_19525_Name = {
    Text = "ターン開始前にキャラクターシールドを除去__「開発用」"
  },
  State_19527_Desc = {
    Text = "スタック毎に「スキル」の本ターンの行動力消費+1、最大3スタック、発射後にスタック数が1より大きい場合はスタック数-1。"
  },
  State_19527_Name = {
    Text = "<SlowColour:鈍化>"
  },
  State_19528_Desc = {
    Text = "強力な効果を持つカード。"
  },
  State_19528_Name = {
    Text = "<SilverKeyColour:キーオーダー>"
  },
  State_19529_Desc = {
    Text = "[Layer] 回発射可能で、他のカードを発射するたびに次回このカードを発射する際の行動力消費 -1。"
  },
  State_19530_Desc = {
    Text = "・相手から優先的に攻撃され、相手が単体対象を選択する際は挑発状態の覚醒体のみ選択できる。\n・挑発を獲得した時、自身の潜行と他の味方の挑発を解除し、同時に敵の潜行を解除する。"
  },
  State_19530_Name = {
    Text = "<TauntColour:挑発>"
  },
  State_19532_Desc = {
    Text = "このターン終了まで、与えるダメージが[DescArg1]%減少し、付与時に強化と相殺される。"
  },
  State_19532_Name = {Text = "倦怠"},
  State_19533_Desc = {
    Text = "このターン終了まで、与えるダメージが50%減少し、付与時に強化と相殺される。"
  },
  State_19533_Name = {
    Text = "<WeaknessColour:倦怠>"
  },
  State_19534_Desc = {
    Text = "次のターン開始まで、受けるアクティブダメージと出血スタック数が[DescArg1]％増加し、付与時に堅固と相殺される。"
  },
  State_19534_Name = {Text = "軟化"},
  State_19535_Desc = {
    Text = "・相手から優先的に攻撃され、相手が単体対象を選択する際は挑発状態の覚醒体のみ選択できる。\n・挑発を獲得した時、自身の潜行と他の味方の挑発を解除し、同時に敵の潜行を解除する。"
  },
  State_19535_Name = {Text = "挑発"},
  State_19536_Desc = {
    Text = "ターン終了時、10狂気を獲得__「開発用」"
  },
  State_19536_Name = {
    Text = "ターン終了時、狂気トリガーを獲得。__「開発用」"
  },
  State_19537_Desc = {
    Text = "このターン終了まで、与えるダメージが[DescArg1]%上昇し、付与時に倦怠と相殺される。"
  },
  State_19537_Name = {Text = "強化"},
  State_19538_Desc = {
    Text = "・第8および第9ターン開始時にそれぞれ1点を獲得\n・死闘1点につき、受けるシールドとライフ回復が50%減少し、同時にバリアの累積可能な点数-1\n・死闘は解除不可、かつ死亡した覚醒体にも有効。"
  },
  State_19538_Name = {Text = "死闘"},
  State_19540_Name = {
    Text = "行動力上限"
  },
  State_19541_Desc = {
    Text = "ターン終了までいかなる行動もできなくなる。"
  },
  State_19541_Name = {Text = "昏睡"},
  State_19544_Desc = {
    Text = "「攻撃」使用後、すべての層数を消費する。1層消費するごとに、今回の「攻撃」が与えるダメージが50％上昇する。最大5層まで累積可能。"
  },
  State_19545_Name = {
    Text = "このカードは「攻撃」と見なされます__「開発用」"
  },
  State_19546_Desc = {
    Text = "使用前にカードの行動力を変更する。__「開発用」"
  },
  State_19546_Name = {
    Text = "使用前にカードの行動力を変更する__「開発用」"
  },
  State_19547_Desc = {
    Text = "ターン終了時に[Layer]の純粋ダメージを与え、永続。"
  },
  State_19547_Name = {Text = "毒"},
  State_19549_Desc = {
    Text = "次のターン開始まで、受けるアクティブダメージが50%減少する。付与時に「軟化」と相殺される。"
  },
  State_19549_Name = {
    Text = "<ReinforceColour:堅固>"
  },
  State_19552_Desc = {
    Text = "現在[Layer]点のシールドを所有。シールドは最大ライフを超えず、1ターン持続。"
  },
  State_19552_Name = {
    Text = "シールド"
  },
  State_19553_Desc = {
    Text = "ドローフェイズ後に後発制人を獲得。__「開発用」"
  },
  State_19553_Name = {
    Text = "後発制人トリガー__「開発用」"
  },
  State_19554_Name = {
    Text = "空状態__「開発用」"
  },
  State_19555_Desc = {
    Text = "·本ターン「スキル」の行動力消費+[Layer]、最大3スタック。\n·「スキル」を発射後にスタック数が1より大きい場合、スタック数-1。"
  },
  State_19555_Name = {Text = "鈍化"},
  State_19556_Desc = {
    Text = "ターン終了時、このカードの行動力消費–[Layer]。"
  },
  State_19556_Name = {
    Text = "<PrepareKeywords:準備 [Layer] >"
  },
  State_19557_Desc = {
    Text = "次のターン開始まで、受けるアクティブダメージが[DescArg1]%減少する。付与時に「軟化」と相殺される。"
  },
  State_19557_Name = {Text = "堅固"},
  State_19558_Name = {
    Text = "復活デッキ追加トリガー__「開発用」"
  },
  State_19560_Desc = {
    Text = "ターン終了まで狂気解放を使用できない。"
  },
  State_19561_Name = {
    Text = "、3回使用可能"
  },
  State_19990_Desc = {
    Text = "次のターン開始時、[Layer]狂気を獲得。"
  },
  State_19990_Name = {
    Text = "遅延狂気"
  },
  State_19992_Desc = {
    Text = "ターン終了まで行動できなくなる。昏睡ダメージを受けた後、対象は耐性を獲得する。耐性を所有している時に再度昏睡ダメージを受けた場合、昏睡効果を相殺し、ダメージは2倍になる。この状態は解除不可。"
  },
  State_19992_Name = {
    Text = "<ComaColour:昏睡>"
  },
  State_19995_Desc = {
    Text = "ターン終了時にスタック数に等しい純粋ダメージを永続的に与える。"
  },
  State_19995_Name = {
    Text = "<IntoxicationColour:毒>"
  },
  State_19996_Desc = {
    Text = "このターン終了まで、与えるダメージが25%上昇し、付与時に倦怠と相殺される。"
  },
  State_19996_Name = {
    Text = "<StrengthenColour:強化>"
  },
  State_19998_Desc = {
    Text = "次のターン開始まで、攻撃を受けるたびに攻撃者に同量のスタック数の純粋ダメージを与える。"
  },
  State_19998_Name = {
    Text = "<RetaliateColour:反撃>"
  },
  State_20012_Desc = {
    Text = "残りの計算力1ポイントにつき、次のターン開始時に1枚のカードを引く；残りの手札1枚につき、次のターン開始時に1の計算力を獲得します。"
  },
  State_20012_Name = {
    Text = "異化賢者の断章"
  },
  State_20012_WeaponDesc = {
    Text = "残りの計算力1ポイントにつき、次のターン開始時に1枚のカードを引く；残りの手札1枚につき、次のターン開始時に1の計算力を獲得します。"
  },
  State_20013_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>+100。毎ターン初めて使用したカードを手札に戻す。超次元ターン開始時、手札上限を5枚増加し、手札をコピーする。"
  },
  State_20013_Name = {
    Text = "状態@時の振り子・鏡"
  },
  State_20014_Name = {
    Text = "時霊振子「迷失」"
  },
  State_20016_Name = {
    Text = "遺物マジックグローブ"
  },
  State_20017_Desc = {
    Text = "次回の跳躍効果は必ず発動する。"
  },
  State_20017_Name = {Text = "跳躍"},
  State_20021_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>+100。毎ターン初めて使用したカードを手札に戻す。超次元ターン開始時、手札上限を5枚増加し、手札をコピーする。"
  },
  State_20021_Name = {
    Text = "状態@時の振り子・鏡"
  },
  State_20023_Desc = {
    Text = "バトル開始後、2つの狂気チャージをデッキに加える。"
  },
  State_20023_Name = {
    Text = "カオス縫合体"
  },
  State_20023_WeaponDesc = {
    Text = "バトル開始後、2つの狂気チャージをデッキに加える。"
  },
  State_20024_Desc = {
    Text = "毎ターン「狂気解放」をリリースすると、[Arg1] ポイズンの「毒感染」カードを1枚獲得します。ターン終了時に手札に3枚の「毒感染」がある場合、中毒をトリガーする「毒発動」を1枚合成できます。"
  },
  State_20024_Name = {
    Text = "状態@遺物異化異種の喉舌"
  },
  State_20026_Desc = {
    Text = "カードは捨て札フェイズに捨て札置き場に入らず、手札に残り後続の効果を発動する。"
  },
  State_20026_Name = {
    Text = "<RetainIconKeywords:保持>"
  },
  State_20026_WeaponDesc = {
    Text = "プレイ後、 カードは捨て札の山に入らず、 このバトルでは再び使用できません。"
  },
  State_20028_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>100増加。カードを1枚使用するたび胚胎融合+10、ライフ25％未満の時+20、毎ターン10回まで。"
  },
  State_20028_Name = {
    Text = "状態@時の振り子・侵食"
  },
  State_20029_Desc = {
    Text = "毎ターン「狂気解放」をリリースすると、[Arg1] ポイズンの「毒感染」カードを1枚獲得します。ターン終了時に手札に3枚の「毒感染」がある場合、中毒をトリガーする「毒発動」を1枚合成できます。"
  },
  State_20029_Name = {
    Text = "状態@遺物異化異種の喉舌"
  },
  State_20035_Name = {
    Text = "状態@時の振り子・不眠"
  },
  State_20038_WeaponDesc = {
    Text = "パーティがカオスと他の職業で構成されている場合、ターン開始時にすべての覚醒体は 20 狂気を獲得する。"
  },
  State_20039_Desc = {
    Text = "捨て札フェイズ時に手札にある場合、カードは消費され、この戦闘中はデッキに現れない。"
  },
  State_20039_Name = {
    Text = "<NothingnessIconKeywords:虚無>"
  },
  State_20039_WeaponDesc = {
    Text = "プレイ後、 カードは捨て札の山に入らず、 このバトルでは再び使用できません。"
  },
  State_20040_Name = {
    Text = "状態@時の振り子・不眠カウント"
  },
  State_20041_Desc = {
    Text = "ターン開始時、敵1体につき行動力を1点獲得し、カードを1枚引く。アクティブダメージで敵を撃破した時、他の敵に2倍の過剰ダメージと同量の出血を与える。__「開発用」"
  },
  State_20041_Name = {
    Text = "異化群衆の歌__「開発用」"
  },
  State_20042_Desc = {
    Text = "デバフ状態の敵に与えるダメージが25%増加し、敵を倒すと倒した者が20狂気を獲得。"
  },
  State_20044_Desc = {
    Text = "与える<WeaknessIconKeywords:虚弱>効果が10％上昇する。3ターンごとにすべての敵に<WeaknessIconKeywords:虚弱>を1層付与する。"
  },
  State_20045_Desc = {
    Text = "次のターン開始時、デッキから任意のカード3枚を手札に追加。"
  },
  State_20045_Name = {
    Text = "時の振り子・舞"
  },
  State_20306_Name = {
    Text = "遺物マジックグローブ"
  },
  State_20419_Desc = {
    Text = "ダメージを 1 回与えるたびに、ターゲットに [Arg1] 層のポイズンを付与。本バトル内でトリガー回数が累計 25 回に達すると、即座に全敵にポイズンを発動。"
  },
  State_20425_Desc = {
    Text = "ターン開始時、[Layer]点の一時的な<PowerIconKeywords:力>とシールドを獲得。"
  },
  State_20425_Name = {
    Text = "渇血饕餮"
  },
  State_20600_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：毎ターン最初の[StateArg2]枚の「スキル」の消費算力が–[StateArg1]。"
  },
  State_20600_Name = {Text = "悟り"},
  State_20601_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」のダメージが[StateArg1]%増加する。攻撃を1回受けるたび、[StateArg2]点の<EnergyStorageKeywords:蓄力>を獲得。"
  },
  State_20602_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は対象を選択でき、[StateArg1]点の<PVPSlowKeywords:遅延>を与える。毎ターン最初の対象に発動する際、効果は2倍になる。"
  },
  State_20602_Name = {
    Text = "忘却の手"
  },
  State_20603_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、自身は<Energy:[Energy:StateArg1]>狂気を獲得。"
  },
  State_20603_Name = {
    Text = "奇体の反噬"
  },
  State_20604_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は自身のライフを<Heal:[Heal:StateArg1]>回復。"
  },
  State_20604_Name = {Text = "吸う"},
  State_20605_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に自身を<ComaKeywords:昏睡>状態にする。「狂気解放」の前にすべての味方のデバフステータスを解除する。"
  },
  State_20605_Name = {
    Text = "貴族の杖"
  },
  State_20606_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は自身に<Energy:[Energy:StateArg1]>狂気を獲得させる。"
  },
  State_20607_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打撃」で<HPAndShieldMax:ライフとシールドが最も高い>敵を攻撃し、さらにダメージの [StateArg1]% の<PVPBleedingKeywords:出血>を追加で与える。"
  },
  State_20607_Name = {
    Text = "切断と危害"
  },
  State_20608_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「スキル」使用時およびターン終了時、自身は<Energy:[Energy:StateArg1]>狂気を獲得。"
  },
  State_20608_Name = {Text = "呟き"},
  State_20609_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ライフを失うことで獲得する狂気が2倍になる。"
  },
  State_20609_Name = {Text = "海の夢"},
  State_20610_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打撃」ダメージアップ [DescArg1]% 、「狂気解放」後に自身の<PVPPowerIconKeywords:力>+ [StateArg2] し「打撃」ダメージが追加で [StateArg3]% アップ、最大 100%。"
  },
  State_20610_Name = {
    Text = "星天の獣"
  },
  State_20611_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「スキル」使用時およびターン終了時、ライフ損失が最も多い味方のライフを<Heal:[Heal:StateArg1]>回復。"
  },
  State_20611_Name = {Text = "希望"},
  State_20612_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、最も狂気が低い味方に<Energy:[Energy:StateArg1]>狂気を獲得させ、ライフ損失が最も多い味方のライフを<Heal:[Heal:StateArg2]>回復。"
  },
  State_20612_Name = {
    Text = "慈悲の育み"
  },
  State_20613_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、他の味方は<Block:[Block:StateArg1]>点のシールドを獲得。"
  },
  State_20613_Name = {
    Text = "存在しない場所"
  },
  State_20614_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、[StateArg1]点の一時的な<PVPRetaliateIconKeywords:反撃>を獲得。"
  },
  State_20614_Name = {Text = "核溶解"},
  State_20615_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：毎ターン初回の「攻撃」は追加で[StateArg1]ダメージを与え、<PVPMethysisKeywords:毒>を付与する。"
  },
  State_20615_Name = {
    Text = "苦しみの呪縛"
  },
  State_20616_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、<Energy:[Energy:StateArg1]>狂気を獲得する。"
  },
  State_20616_Name = {
    Text = "アクートの春"
  },
  State_20617_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、<Block:[Block:StateArg1]>点のシールドを獲得。"
  },
  State_20617_Name = {Text = "追放"},
  State_20618_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の前に、お互いにすべての手札を捨てさせ、捨てた枚数+1枚のカードを引かせる。"
  },
  State_20618_Name = {
    Text = "マジックショー"
  },
  State_20619_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に<Energy:[Energy:StateArg1]>狂気を獲得。味方の覚醒体が「狂気解放」を発動した後、自身は<DelayKeywords:遅延>：<Energy:[Energy:StateArg2]>狂気を獲得する。"
  },
  State_20619_Name = {
    Text = "神王の讃歌"
  },
  State_20620_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：手札上限+[StateArg2]。ターン終了時、手札にあるランダムな「スキル」[StateArg1]枚のコピーを獲得。"
  },
  State_20620_Name = {
    Text = "集会の時"
  },
  State_20621_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の前に、自身に<StrengthenKeywords:強化>と<ReinforceKeywords:堅固>を付与する。"
  },
  State_20621_Name = {
    Text = "痛みを越えて"
  },
  State_20622_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時に自身は<Energy:[Energy:StateArg1]>狂気を獲得し、残りの行動力をすべて消費し、1点の行動力を消費するごとに獲得狂気を[StateArg3]増加させる。"
  },
  State_20622_Name = {
    Text = "秘められた誕生"
  },
  State_20623_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、カードを[StateArg1]枚引く。"
  },
  State_20623_Name = {Text = "湧出"},
  State_20624_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」後、「スキル」を[StateArg1]枚引き、そのコピーを手札に[StateArg2]枚追加する。"
  },
  State_20624_Name = {
    Text = "幸運の時"
  },
  State_20625_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、<DelayKeywords:遅延>：すべての味方のライフを<Heal:[Heal:StateArg1]>回復。"
  },
  State_20625_Name = {
    Text = "暴食寓話"
  },
  State_20626_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」のダメージが[StateArg1]%上昇し、自身を<ReinforceKeywords:堅固>にする。"
  },
  State_20626_Name = {
    Text = "不屈の意志"
  },
  State_20627_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、すべての味方のライフを<Heal:[Heal:StateArg1]>回復。"
  },
  State_20627_Name = {Text = "庇護"},
  State_20628_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、他の味方に<Energy:[Energy:StateArg1]>狂気を付与する。この効果で付与された狂気の余剰は装備者に半分返還される。"
  },
  State_20628_Name = {Text = "職責"},
  State_20629_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」が与えるダメージ、治療、シールド効果が[StateArg1]%増加する。"
  },
  State_20629_Name = {
    Text = "薔薇の名において"
  },
  State_20630_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、<Block:[Block:StateArg1]>点のシールドと<Energy:[Energy:StateArg2]>狂気を獲得。"
  },
  State_20630_Name = {
    Text = "冬の夜の追憶"
  },
  State_20631_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は対象を<PVPVulnerabilityIconKeywords:易傷>にする。装備時とターン終了時に[StateArg1]層の<EnergyStorageKeywords:蓄力>を獲得。"
  },
  State_20631_Name = {Text = "臨界点"},
  State_20632_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：手札上限+[StateArg1]。"
  },
  State_20632_Name = {
    Text = "記憶螺旋"
  },
  State_20633_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：毎ターン初めて敵からアクティブダメージを受けた後、その対象に[StateArg1]点のダメージを与え、<PVPEntanglementKeywords:纏着>を付与する。"
  },
  State_20633_Name = {
    Text = "蒼白の末裔"
  },
  State_20634_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」「スキル」「狂気解放」が与えるダメージ、治癒、シールドが[DescArg1]%増加し、[StateArg2]%の<PVPGrowthKeywords:成長>を獲得する。"
  },
  State_20634_Name = {Text = "落日"},
  State_20635_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の前にすべての味方に<StrengthenKeywords:強化>を付与する。"
  },
  State_20635_Name = {
    Text = "信仰の力"
  },
  State_20636_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、<PVPDerivativeCardKeywords_2:「幻影」>を1枚獲得。手札に<PVPDerivativeCardKeywords_2:「幻影」>が2枚あるごとに、それらを合成して<PVPDerivativeCardKeywords_12:「小さな願い」>を1枚にする。"
  },
  State_20637_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、<PVPDerivativeCardKeywords_11:「不等価交換」>を[StateArg1]枚山札のランダムな位置に追加する。"
  },
  State_20637_Name = {
    Text = "情報は命"
  },
  State_20639_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：ターン終了時、装備者は<HPAndShieldMax:ライフとシールドが最も高い>敵に [StateArg1] ダメージを与え、<PVPMethysisKeywords:毒>を付与する。"
  },
  State_20639_Name = {
    Text = "腐朽の贈り物"
  },
  State_20640_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時およびターン開始時、すべての敵に<Damage:[Damage:StateArg1]>の<PVPBleedingKeywords:出血>ダメージを与える。対象の手札1枚につき、<PVPBleedingKeywords:出血>ダメージが+[StateArg2]。"
  },
  State_20640_Name = {
    Text = "血肉の宴"
  },
  State_20641_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：死亡後、他の味方に[StateArg1]点の<PVPProtectiveKeywords:バリア>を与える。"
  },
  State_20641_Name = {
    Text = "死の分析"
  },
  State_20642_Desc = {
    Text = "<PVPHoldingKeywords:保有>：カードを使用した後、このカードは他のランダムな「運命の札」に変化し、その行動力消費を-1する。"
  },
  State_20642_Name = {
    Text = "魂の誕生"
  },
  State_20643_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」後 [StateArg1] 行動力を獲得、<DelayKeywords:レイテンシ>：[StateArg2] 行動力を消費する。"
  },
  State_20643_Name = {
    Text = "記憶障害"
  },
  State_20644_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に自身に[StateArg2]点のダメージを与え、<PVPEntanglementKeywords:纏着>を付与する。死亡した味方1体につき、<StrongEffectKeywords:特効>+[StateArg1]。"
  },
  State_20644_Name = {
    Text = "至高の秘蔵品"
  },
  State_20645_Name = {
    Text = "旅の荷物"
  },
  State_20646_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」のダメージが[StateArg1]%増加する。「狂気解放」の後、自身のライフを<Heal:[Heal:StateArg2]>回復。"
  },
  State_20646_Name = {
    Text = "捕食者の子守唄"
  },
  State_20647_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、<PVPDerivativeCardKeywords_11:「不平等な交換」>を[StateArg1]枚手札に追加する。"
  },
  State_20647_Name = {
    Text = "暴風雨の中で"
  },
  State_20648_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン開始時、バフの<PVPWonderfulEffectKeywords:不思議な効果>を獲得。敵が毎ターン初めて「キーオーダー」を使用した時、「華麗な光景」を[StateArg1]枚手札に追加する。"
  },
  State_20648_Name = {
    Text = "無声の宴"
  },
  State_20649_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、前のターンに最後に使用した「スキル」を手札に追加し、その行動力消費を-1にする。この効果が複数回発動した場合、さらに前のターンへと遡る。"
  },
  State_20649_Name = {
    Text = "時を遡る時計"
  },
  State_20650_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時、自身を<ComaKeywords:昏睡>させる。「狂気解放」の前にすべての敵のバフ状態を解除する。"
  },
  State_20650_Name = {Text = "錯乱"},
  State_20651_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、カードを[StateArg1]枚引く。"
  },
  State_20651_Name = {Text = "強欲"},
  State_20652_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、すべての敵に[StateArg1]ダメージを与え、<DisarmKeywords:麻痺>を付与する。"
  },
  State_20652_Name = {Text = "懲罰"},
  State_20653_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は対象を選択でき、ターゲットの<Energy:[Energy:StateArg1]>狂気を減少させる。"
  },
  State_20653_Name = {
    Text = "欲望の海"
  },
  State_20654_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：ターン開始時、自身に<PVPSeriousInjuryKeywords:重傷>を与え <Damage:[Damage:StateArg1]> 層の<PVPCorrosionKeywords:罪印>を獲得する。ターン終了時、自身を<ReinforceKeywords:堅固>にする。"
  },
  State_20654_Name = {
    Text = "女王の戒律"
  },
  State_20655_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」のダメージが[StateArg1]%増加し、「攻撃」は対象を選択できる。"
  },
  State_20655_Name = {Text = "寵愛"},
  State_20656_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「スキル」が与えるダメージ、治癒、シールドが[Arg1]%増加する。「スキル」使用後、<PVPProtectiveKeywords:バリア>がない場合、1点の<PVPProtectiveKeywords:バリア>を獲得。"
  },
  State_20656_Name = {
    Text = "詩の結び"
  },
  State_20657_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：毎ターン、相手が[StateArg1]枚目の「スキル」を使用した時、その行動力消費が-[StateArg2]されたコピーを1枚あなたの手札に追加する。"
  },
  State_20657_Name = {Text = "洞察"},
  State_20658_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は対象1体に攻撃するごとに[StateArg1]点の行動力を獲得。"
  },
  State_20658_Name = {
    Text = "縛られた歌"
  },
  State_20659_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：死亡後、次のターン開始時に自身を<PVPResurrectionKeywords:復活>させ、<Heal:[Heal:StateArg1]>ライフと<Block:[Block:StateArg2]> 点のシールドを獲得し、この「運命の札」を破壊する。"
  },
  State_20660_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、すべての味方に<Block:[Block:StateArg1]>点のシールドを獲得させる。"
  },
  State_20660_Name = {
    Text = "心の障壁"
  },
  State_20661_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、すべての敵に<Damage:[Damage:StateArg1]>点の<PVPBleedingKeywords:出血>を与える。"
  },
  State_20661_Name = {
    Text = "迷いの道"
  },
  State_20662_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：ターン終了時、<PVPCapKeywords:算力上限>1ポイントごとに<HPAndShieldMin:HPとシールドが最も低い>敵に [StateArg1] の<PVPBleedingKeywords:出血>を与え、合計 <Damage:[Damage:DescArg1]> の<PVPBleedingKeywords:出血>ダメージを与える。"
  },
  State_20662_Name = {
    Text = "夜に伏す"
  },
  State_20663_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の前に自身のデバフ状態を解除し、[StateArg1]点の<EnergyStorageKeywords:蓄力>を獲得する。"
  },
  State_20663_Name = {
    Text = "鎖を断ち切る日"
  },
  State_20664_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「スキル」は自身を<ReinforceKeywords:堅固>にする。"
  },
  State_20664_Name = {
    Text = "騎士の心"
  },
  State_20665_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：自身がデバフ状態を解除する時、解除可能なデバフ状態がない場合はライフを<Heal:[Heal:StateArg1]>回復。ターン終了時、<DelayKeywords:遅延>：自身のデバフ状態を解除。"
  },
  State_20665_Name = {
    Text = "導きの帆"
  },
  State_20666_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」後に<HPAndShieldMin:ライフとシールドが最も低い>味方に [StateArg1] スタックの<PVPProtectiveKeywords:バリア>を付与する。"
  },
  State_20666_Name = {Text = "親友へ"},
  State_20667_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：毎ターン使用する装備者の最初の「スキル」のダメージが[StateArg1]%増加する。"
  },
  State_20667_Name = {
    Text = "巨人の刃"
  },
  State_20668_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：味方の覚醒体が死亡した時、すべての敵に<Damage:[Damage:StateArg1]>点の<PVPBleedingKeywords:出血>を与える。装備者が死亡した時、追加で<Damage:[Damage:StateArg2]>点の<PVPBleedingKeywords:出血>を与える。"
  },
  State_20668_Name = {
    Text = "珊瑚の女の死"
  },
  State_20669_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時およびターン開始時、自身が<PVPProtectiveKeywords:バリア>を持っていない場合は[StateArg1]層の<PVPProtectiveKeywords:バリア>を獲得し、そうでない場合は手札中の自身の行動力消費が最も高い「スキル」1枚の行動力消費を-1する。"
  },
  State_20669_Name = {
    Text = "神言の石板"
  },
  State_20670_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は<PVPSeriousInjuryKeywords:重傷>を与え、ダメージが[StateArg1]%増加するが、自身はダメージの半分のライフを失う。"
  },
  State_20670_Name = {
    Text = "疼痛の鰭"
  },
  State_20671_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、自身のライフを<Heal:[Heal:StateArg1]>回復。"
  },
  State_20671_Name = {
    Text = "死を超える"
  },
  State_20672_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、手札の中で行動力消費が最も高いカード1枚の、消費行動力を-[StateArg1]する。<PrepareKeywords:準備>。"
  },
  State_20672_Name = {
    Text = "精神集中"
  },
  State_20673_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、自身は<Block:[Block:StateArg1]>点のシールドを獲得し、他の味方に<Energy:[Energy:StateArg2]>狂気を付与する。"
  },
  State_20673_Name = {
    Text = "計算不能な演算"
  },
  State_20696_Name = {
    Text = "状態@巨人の畏怖"
  },
  State_20723_Desc = {
    Text = "攻撃カードのダメージが[Layer]増加。__「開発用」"
  },
  State_20723_Name = {
    Text = "攻撃カード固定ダメージ増加__「開発用」"
  },
  State_20724_Desc = {
    Text = "攻撃カードのダメージが[Layer]減少。__「開発用」"
  },
  State_20724_Name = {
    Text = "攻撃カード固定ダメージ減少__「開発用」"
  },
  State_20749_Desc = {
    Text = "汎用追跡カウント。__「開発用」"
  },
  State_20758_Desc = {
    Text = "次のターン開始時、カードを[Layer]枚引く。"
  },
  State_20758_Name = {
    Text = "遅延ドロー"
  },
  State_20766_Desc = {
    Text = "具体的な効果は共通の「攻撃」ロジックを参照。__「開発用」"
  },
  State_20802_Desc = {
    Text = "このカードは使用できません。__「開発用」"
  },
  State_20802_Name = {
    Text = "使用不可__「開発用」"
  },
  State_20803_Desc = {
    Text = "このカードは行動力消費-1。他のカードを使用した後、このカードは他のランダムな運命の札カードに変化する。"
  },
  State_20803_Name = {
    Text = "<CardKeyWord:魂の誕生>"
  },
  State_20805_Desc = {
    Text = "捨て札フェイズ時、捨て札に行かず、手札に残る。"
  },
  State_20805_Name = {
    Text = "<RetainIconKeywords:保持>"
  },
  State_20806_Desc = {
    Text = "使用すると捨て札に行かず、デッキから除去する。"
  },
  State_20806_Name = {
    Text = "<DepleteIconKeywords:除外>"
  },
  State_20820_Desc = {
    Text = "次のターン開始時に復活し、[Layer]ライフと[Layer]点のシールドを獲得する。"
  },
  State_20820_Name = {
    Text = "遅延復活"
  },
  State_20851_Name = {
    Text = "カードを与える"
  },
  State_20981_Desc = {
    Text = "「深紅の刃」が覚醒し、与えるダメージが大幅に増加する。"
  },
  State_20981_Name = {
    Text = "ユウハシュ覚醒！"
  },
  State_20981_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_20982_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_20982_Name = {Text = "未覚醒"},
  State_20988_Desc = {
    Text = "初期狂気+80。毎ターン、20狂気を獲得。"
  },
  State_20988_Name = {
    Text = "ダフォダイル·初見"
  },
  State_20989_Desc = {
    Text = "初期狂気+80。毎ターン2点の行動力と、20狂気を獲得。"
  },
  State_20989_Name = {
    Text = "トゥルー·初見"
  },
  State_21306_Desc = {
    Text = "毎ターンコンボをリセットする"
  },
  State_21306_Name = {
    Text = "連撃リセット"
  },
  State_21307_Desc = {
    Text = "1層につき攻撃回数+1。ダメージを受けると1層を失い、最低は1層。ターン終了時にすべて失う。"
  },
  State_21307_Name = {Text = "連撃"},
  State_21342_Desc = {
    Text = "次のターン開始時、[Layer]の治癒を獲得。"
  },
  State_21342_Name = {
    Text = "遅延治癒"
  },
  State_21345_Desc = {
    Text = "降神の儀式が始まる前に、死後に復活し、デバフを解除し、ダメージを無効化し、30%のライフを回復。降神の儀式が始まった後は、死後に完全に復活し、デバフと儀式の執念を解放し、二人の眷族を呼び使用する。"
  },
  State_21345_Name = {
    Text = "儀式の執念"
  },
  State_21358_Desc = {
    Text = "このプレイヤーの手札に上限はありません。__「開発用」"
  },
  State_21381_Name = {
    Text = "封印使用回数カウント"
  },
  State_21385_Desc = {
    Text = "ライフを1失うごとに1点減少。点数が0になると行動予測は高ダメージの「狂気解放」に変化し、石化効果が解放。"
  },
  State_21385_Name = {
    Text = "血の狂暴"
  },
  State_21450_Desc = {
    Text = "次のターン開始時、自身のデバフ状態を解除する。"
  },
  State_21450_Name = {
    Text = "遅延浄化"
  },
  State_21488_Desc = {
    Text = "具体的な効果は共通の「攻撃」ロジックを参照。__「開発用」"
  },
  State_21492_Desc = {
    Text = "クリティカル時、ダメージは50%上昇する。"
  },
  State_21492_Name = {
    Text = "<CardKeyWord:クリティカル>"
  },
  State_21546_Desc = {
    Text = "次のターン開始時、[Layer]点のシールドを獲得。"
  },
  State_21546_Name = {
    Text = "遅延シールド"
  },
  State_21547_Desc = {
    Text = "ターン開始時、シールドの半分を保持する。"
  },
  State_21547_Name = {Text = "毅然"},
  State_21548_Desc = {
    Text = "次のターン開始時、強化を獲得。"
  },
  State_21548_Name = {
    Text = "遅延強化"
  },
  State_21580_Desc = {
    Text = "首狩りがあなたの行動を追跡中。カードを1枚引くたびに、首狩りは[StateArg1]点の一時的な力を獲得。"
  },
  State_21580_Name = {
    Text = "痕跡を探す"
  },
  State_21587_Name = {
    Text = "このターン、新しいランダム覚醒体を発見済み"
  },
  State_21590_Name = {
    Text = "新しい覚醒体を探す回数を試す"
  },
  State_21601_Name = {
    Text = "新しい覚醒体を発見"
  },
  State_21616_Desc = {
    Text = "狂気解放を使用した後、1ターンすべての覚醒体を封印する。"
  },
  State_21616_Name = {
    Text = "行道の骸"
  },
  State_21671_Name = {
    Text = "範囲ダメージを与える__「開発用」"
  },
  State_21688_Name = {
    Text = "、1回使用可能"
  },
  State_21689_Name = {
    Text = "、2回使用可能"
  },
  State_21720_Desc = {
    Text = "対象の後ろにいる覚醒体に同じ効果を与える。後ろに覚醒体がいない場合、対象にのみ効果を与える。"
  },
  State_21720_Name = {
    Text = "<CardKeyWord:貫通>"
  },
  State_21726_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備者が毎ターン初めて「スキル」を使用した後に、その行動力消費が-[StateArg1]されたコピーを1枚山札のランダムな位置に追加する。"
  },
  State_21726_Name = {
    Text = "回れ回れ"
  },
  State_21744_Name = {
    Text = "新しい覚醒体を探す回数を試す"
  },
  State_21745_Name = {
    Text = "新しい覚醒体を発見"
  },
  State_21746_Name = {
    Text = "このターン、新しいランダム覚醒体を発見済み"
  },
  State_21747_Desc = {
    Text = "[Layer]名の覚醒体が「狩猟目標」。「狩猟目標」の覚醒体がカードを使用するたび、「暴走する首狩り」の「狩猟の印」を1点増加。"
  },
  State_21747_Name = {
    Text = "狩猟の儀式"
  },
  State_21751_Desc = {
    Text = "「狩猟の印」の半分のカード([DescArg1])を引き、「暴走する首狩り」の「狩猟の印」を1点増加。"
  },
  State_21751_Name = {
    Text = "<CardKeyWord:狩猟目標>"
  },
  State_21754_Desc = {
    Text = "死亡後、「暴走する首狩り」のすべての力を一時的に減少させ、「狩猟の印」の点数を半減する。"
  },
  State_21754_Name = {
    Text = "短い解放"
  },
  State_21765_Desc = {
    Text = "・味方の覚醒体1体に「運命の札」を装備させ、「運命の札」の効果を発揮させることができる。\n・覚醒体1体に「運命の札」を重複して装備した場合、古い「運命の札」は破壊され、新しい「運命の札」を保持する。\n・覚醒体が死亡した後、それが装備している「運命の札」は破壊される。\n・死亡した覚醒体に「運命の札」を装備した場合、その「運命の札」は破壊され、幻視を1枚獲得し、消費した行動力も返還される。"
  },
  State_21765_Name = {
    Text = "<PVPWeaponKeywords:運命の札>"
  },
  State_21785_Name = {
    Text = "戦闘の叫び"
  },
  State_21787_Name = {
    Text = "戦闘セリフ追加"
  },
  State_21826_Name = {
    Text = "ガキ大将の開場ボイス"
  },
  State_21829_Name = {
    Text = "断末魔効果"
  },
  State_21838_Name = {
    Text = "オープニング紹介"
  },
  State_21843_Name = {
    Text = "オープニング状態付与"
  },
  State_21895_Name = {
    Text = "オープニングセリフ"
  },
  State_21905_Desc = {
    Text = "「打撃」で2の行動力を獲得し、ランダムに1枚のカードを捨てる。「防御」で2枚のカードを引き、1の行動力を失う。"
  },
  State_21928_Name = {Text = "ヒント"},
  State_22054_Name = {
    Text = "オープニングセリフ"
  },
  State_22055_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_22055_Name = {Text = "未覚醒"},
  State_22067_Desc = {
    Text = "ターン終了後、1本の触腕が[Layer]回攻撃する。"
  },
  State_22067_Name = {
    Text = "触腕集結"
  },
  State_22074_Desc = {
    Text = "存命中の行動予測は第七ターンで「凝視」に転換し、第八ターン以降は「冒涜」に転換する。"
  },
  State_22134_Desc = {
    Text = "刺突ダメージはターゲットのライフ・シールド・バリアを同時に損傷させる。"
  },
  State_22134_Name = {
    Text = "<CardKeyWord:刺突ダメージ>"
  },
  State_22157_Desc = {
    Text = "ライフが50%([StateArg1])未満になると、「海流」と「潮汐」に分裂する。"
  },
  State_22204_Desc = {
    Text = "ターン開始後、[Layer]％の一時的なクリティカルレートと一時的なクリティカルダメージを獲得する。"
  },
  State_22204_Name = {
    Text = "響き渡る音"
  },
  State_22204_WeaponDesc = {
    Text = "次のターンの開始までライフを失わない場合、次のターンのクリティカルレート＋[StateArg1]％。"
  },
  State_22210_Desc = {
    Text = "行動力消費+100、攻撃使用不可、狂気獲得不可。"
  },
  State_22210_Name = {
    Text = "超絶鈍化"
  },
  State_22238_Name = {
    Text = "プレイヤー死闘__「開発用」"
  },
  State_22239_Name = {
    Text = "プレイヤー死闘を付与__「開発用」"
  },
  State_22249_Desc = {
    Text = "次のターン開始時、ドロー枚数が[Layer]枚減る。"
  },
  State_22249_Name = {
    Text = "不平等な交換"
  },
  State_22300_Desc = {
    Text = "この攻撃カードは使用できません。__「開発用」"
  },
  State_22300_Name = {
    Text = "攻撃カードが無力化され、使用できない__「開発用」"
  },
  State_22303_Desc = {
    Text = "ダメージを受けるごとに手札のランダムなカードに一時的な「鈍化」を付与し、シールドが破られると「フロストシールド」状態が解除。"
  },
  State_22303_Name = {
    Text = "フロストシールド"
  },
  State_22324_Desc = {
    Text = "1層ごとに、このターンの攻撃が1段階増加する"
  },
  State_22324_Name = {
    Text = "怒涛の残響"
  },
  State_22325_Desc = {
    Text = "攻撃を受けるたびに、[StateArg1]点の一時的な力を獲得。"
  },
  State_22325_Name = {
    Text = "巨人の血脈"
  },
  State_22326_Desc = {
    Text = "ロックオンされた！このカードを使用すると、海踊人近衛が1点の「一時的な発狂」を獲得し、このカードの「怒涛の印」は除去される。"
  },
  State_22326_Name = {
    Text = "<CardKeyWord:汚染：怒涛の印>"
  },
  State_22328_Desc = {
    Text = "「怒涛の印」の付与された指令カードが1回使用されるたび、このターンの攻撃回数+1。"
  },
  State_22328_Name = {
    Text = "怒涛の残響"
  },
  State_22334_Desc = {
    Text = "「攻撃」カードを使用するたび、[StateArg1]枚の「傷口」を山札の上に置く。"
  },
  State_22334_Name = {Text = "外傷"},
  State_22404_Desc = {
    Text = "この戦闘中に生成されるシールドが[Layer]点上昇する。"
  },
  State_22404_Name = {Text = "警戒"},
  State_22405_Desc = {
    Text = "この戦闘中に生成されるシールドが増加する。"
  },
  State_22405_Name = {
    Text = "<PVPAlertKeywords:警戒>"
  },
  State_22702_Desc = {
    Text = "毎ターン使用する最初の「カード」は追加効果を発動する。"
  },
  State_22702_Name = {
    Text = "<CardKeyWord:奇襲>"
  },
  State_22706_Name = {
    Text = "奇襲マーク__「開発用」"
  },
  State_22707_Desc = {
    Text = "ターン中にカードを使用すると、プレイヤーに奇襲状態を付与する__「開発用」"
  },
  State_22707_Name = {
    Text = "奇襲トリガー__「開発用」"
  },
  State_22721_Name = {
    Text = "時霊振子「迷失」"
  },
  State_23405_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、現在の反撃の点数に等しい力を獲得し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_23405_Name = {Text = "未覚醒"},
  State_23406_Desc = {
    Text = "「深淵の住人」はターン終了時に[StateArg1]回の反撃を獲得。"
  },
  State_23406_Name = {
    Text = "カエクス覚醒！"
  },
  State_23512_Name = {
    Text = "千変万化を与える"
  },
  State_23514_Name = {
    Text = "千変万化を与える"
  },
  State_23515_Name = {
    Text = "千変万化を与える"
  },
  State_23516_Name = {
    Text = "千変万化を与える"
  },
  State_23517_Name = {
    Text = "プレイヤーにバフを与える"
  },
  State_23518_Desc = {
    Text = "2点の軟化を付与 / 攻撃を1回増加 / 力の減少を付与"
  },
  State_23518_Name = {
    Text = "<CardKeyWord:行動選択>"
  },
  State_23519_Name = {Text = "行動2b"},
  State_23520_Name = {Text = "行動2c"},
  State_23521_Name = {
    Text = "捨てる時に消費し、すべての覚醒体の[StateArg1]狂気を減少させ、5枚の「症状」をプレイヤー山札に入れる"
  },
  State_23522_Name = {
    Text = "捨てる時に消費し、すべての覚醒体の[StateArg1]狂気を減らす"
  },
  State_23524_Name = {Text = "行動3a"},
  State_23525_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_23525_Name = {Text = "未覚醒"},
  State_23526_Name = {Text = "行動2a"},
  State_23527_Name = {Text = "行動3c"},
  State_23528_Name = {Text = "行動3b"},
  State_23529_Desc = {
    Text = "力を増加 / 追加ダメージ / シールドを獲得"
  },
  State_23529_Name = {
    Text = "<CardKeyWord:行動選択>"
  },
  State_23530_Desc = {
    Text = "使用時に「千変万化」の行動選択を2回行う。カードを捨てた場合、すべての覚醒体は20狂気を失い、5枚の「症状」をプレイヤーの山札に追加する。"
  },
  State_23530_Name = {
    Text = "ダフォダイル覚醒！"
  },
  State_23531_Name = {
    Text = "千変万化を与える"
  },
  State_23532_Name = {
    Text = "千変万化を与える"
  },
  State_23533_Desc = {
    Text = "症状カードを追加 / 出血を付与 / 狂気を減少"
  },
  State_23533_Name = {
    Text = "<CardKeyWord:行動選択>"
  },
  State_23534_Name = {Text = "行動1a"},
  State_23535_Name = {Text = "行動1c"},
  State_23536_Name = {Text = "行動1b"},
  State_23612_Desc = {
    Text = "ライフを1失うごとに1点減少。点数が0になると行動予測は高ダメージの「狂気解放」に変化し、石化効果が解放。"
  },
  State_23612_Name = {
    Text = "血の狂暴・終結"
  },
  State_23687_Name = {
    Text = "時霊振子「潮湧」"
  },
  State_23726_Desc = {
    Text = "次のターンまで、覚醒体の死亡を1回防ぐ。最大1点。"
  },
  State_23732_Desc = {
    Text = "次のターン開始前まで、アクティブダメージを1回受けるたびに[Layer]スタックの<PainWord:忍耐>を得る。"
  },
  State_23732_Name = {
    Text = "黒沼禁域"
  },
  State_23736_Name = {
    Text = "このターンのドロー枚数"
  },
  State_23737_Name = {
    Text = "ドロー枚数記録"
  },
  State_23741_Name = {
    Text = "ドロー記録を付与"
  },
  State_23744_Desc = {
    Text = "場に「死者」がいない場合、ターン開始時に1体の「死者」を召喚し、召喚ごとにライフが増加する。"
  },
  State_23744_Name = {
    Text = "死者召喚"
  },
  State_23747_Name = {
    Text = "強化ライフ"
  },
  State_23748_Name = {
    Text = "召喚カウント"
  },
  State_23769_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_23769_Name = {Text = "未覚醒"},
  State_23771_Desc = {
    Text = "「心奪の奇術師」が覚醒した。彼女が「幻影」を使って分身を作ることに注意。覚醒後、相手がカードを1枚使用するたびに、カーシアは1回の「幻影」を獲得。"
  },
  State_23771_Name = {
    Text = "カーシア覚醒！"
  },
  State_23771_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_23782_Desc = {
    Text = "10回の幻影を獲得後、「幻影」回数を消去し、前方に1体の分身を召喚。最大2体の分身が存在可能。分身は召喚時に3回の<ParcloseIconKeywords:バリア>を持つ。"
  },
  State_23786_Name = {
    Text = "状態@覚醒体カーシア念動力操作"
  },
  State_23787_Name = {
    Text = "状態@覚醒体カーシア@念動力操作@ドロー減少"
  },
  State_23788_Desc = {
    Text = "第3ラウンド開始時、「過去の響き——すべての手札を捨て、現在のライフとシールドを前ターン終了時の状態に戻す。保持、消耗。」を1枚手札に追加。"
  },
  State_23791_Name = {
    Text = "オープニングヒント"
  },
  State_23823_Name = {Text = "爆弾1"},
  State_23825_Name = {
    Text = "状態@覚醒体カーシア@全滅"
  },
  State_23827_Desc = {
    Text = "使用した後、[DescArg1]の最大ライフを失い、大魔術師がそのターン1点の「得意満面」を獲得。"
  },
  State_23827_Name = {
    Text = "<CardCheerKeywords:喝采>"
  },
  State_23828_Desc = {
    Text = "大魔術師は今彼女のパフォーマンスを非常に楽しんでいる。「得意満面」1点ごとにスキルの効果が減少し、[DescArg1]点の力が減少する。最大5点。"
  },
  State_23828_Name = {
    Text = "得意満面"
  },
  State_23871_Desc = {
    Text = "最大ライフが増加した時、現在のライフは同時に増加しない。最大ライフが減少した時、現在のライフが新たな最大ライフを超える場合、超過分は除去される。最大ライフは最低でも1。死亡後もリセットされない。"
  },
  State_23871_Name = {
    Text = "<MaxHPColour:最大ライフ>"
  },
  State_23934_Name = {
    Text = "状態@念動力操作手札傍受"
  },
  State_23935_Name = {
    Text = "状態@覚醒体カーシア@念動力操作発動"
  },
  State_2393_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_2393_Name = {Text = "未覚醒"},
  State_2394_Name = {
    Text = "深紅の力・啓霊ボーナス"
  },
  State_2395_Name = {
    Text = "「密約」遠くの宴"
  },
  State_2395_WeaponDesc = {
    Text = "「防御」がシールドを30％アップさせる。装備者のブラックスタンプドロップが15％より大きい場合、「防御」がシールドをさらに30％アップさせる。"
  },
  State_2396_Desc = {
    Text = "クリティカルダメージ20%アップ。シールドを持つ敵に対するダメージは必ずクリティカル。"
  },
  State_2398_Desc = {
    Text = "ダメージを受けると、[Layer]シールドを獲得。ダメージを受けるたびにシールドが増加し、ターン終了時に回復する。"
  },
  State_2398_Name = {
    Text = "次元の壁"
  },
  State_2398_WeaponDesc = {
    Text = "受けた能動的なダメージが[Layer]アップする。毎回ダメージを受けると融食傷口が広がり、ターン開始時に治癒する。"
  },
  State_2399_Desc = {
    Text = "ライフを回復すると、全覚醒体が狂気を3獲得。5回目のライフ回復後、この戦闘中の狂気解放ダメージが[Arg1]増加する。"
  },
  State_2400_Desc = {
    Text = "触腕上限が1増加します。ライフが50％未満の場合、触手ダメージが[StateArg1]ポイントアップします。"
  },
  State_2400_Name = {
    Text = "遺物古の供物"
  },
  State_2400_WeaponDesc = {
    Text = "触腕上限が1増加します。ライフが50％未満の場合、触手ダメージが[StateArg1]ポイントアップします。"
  },
  State_2401_Desc = {
    Text = "ターン開始時、捨て札の一番上のカードを手札に戻す。"
  },
  State_2402_Desc = {
    Text = "ターン開始時、超次元空間にカードが1枚あるごとに、このターン[Arg1]の一時的な力を得る。"
  },
  State_2403_Desc = {
    Text = "この戦闘で獲得するシールドが[Layer]点増加。"
  },
  State_2403_Name = {Text = "警戒"},
  State_2403_WeaponDesc = {
    Text = "この戦闘で獲得するシールドが[Layer]点増加。"
  },
  State_2404_Desc = {
    Text = "拾得時に症状カードを1枚削除。刻印幸運率が50％増加。__「開発用」"
  },
  State_2405_Desc = {
    Text = "一時的にカードの行動力を変更"
  },
  State_2405_Name = {
    Text = "一時的にカードの行動力を変更"
  },
  State_2405_WeaponDesc = {
    Text = "一時的にカードの行動力を変更"
  },
  State_2406_Desc = {
    Text = "最後の 1 pt の計算力を消費したとき、2 pt の計算力を獲得する。各ターン最大 2 回まで発動可能。"
  },
  State_2407_Name = {Text = "観測値"},
  State_2408_Name = {
    Text = "水夫の笛"
  },
  State_2409_Desc = {
    Text = "このターン、【打撃】を1枚使用するごとに計算力消費-1。"
  },
  State_2409_Name = {
    Text = "傲慢の刃"
  },
  State_2409_WeaponDesc = {
    Text = "このターン、【打撃】を1枚使用するごとに計算力消費-1。"
  },
  State_2410_Desc = {
    Text = "1ターン行動不能。一度石化された敵は、再び石化効果を受けない。"
  },
  State_2410_Name = {
    Text = "<PetrifactionIconKeywords:石化>"
  },
  State_2410_WeaponDesc = {
    Text = "モンスターを1ターン、めまい状態にする。"
  },
  State_2411_Desc = {
    Text = "ターン終了時、味方チームに[Layer]回の出血を付与する。"
  },
  State_2411_Name = {Text = "血の灯"},
  State_2411_WeaponDesc = {
    Text = "ターン終了時、味方チームに [Layer] 層の出血を与える。"
  },
  State_2412_Desc = {
    Text = "次のターンのダメージが倍になる。"
  },
  State_2412_Name = {
    Text = "絶望からの生還"
  },
  State_2412_WeaponDesc = {
    Text = "次のターンに与えるダメージが2倍になります。"
  },
  State_2413_Desc = {
    Text = "攻撃と防御で狂気の獲得が[Layer]%減少。"
  },
  State_2413_Name = {Text = "虚無"},
  State_2413_WeaponDesc = {
    Text = "打撃と防御で取得する狂気[StateArg1]％。"
  },
  State_2415_Desc = {
    Text = "前回合にダメージを受けた場合、ターン開始時に 1 ターンの免疫を得る。"
  },
  State_2415_Name = {Text = "適応"},
  State_2415_WeaponDesc = {
    Text = "前回合にダメージを受けた場合、ターン開始時に 1 ターンの免疫を得る。"
  },
  State_2416_Desc = {
    Text = "召喚された敵のライフとダメージが2倍になります。"
  },
  State_2416_Name = {
    Text = "「蝋人形の世界」"
  },
  State_2416_WeaponDesc = {
    Text = "召喚されたモンスターのライフとダメージが2倍になります。"
  },
  State_24174_Desc = {
    Text = "その覚醒体はダメージによってライフが1未満になることはない。"
  },
  State_24174_Name = {
    Text = "死の無効化"
  },
  State_2418_Desc = {
    Text = "[狂気解放]により、自身に 30 狂気を得る。"
  },
  State_2418_Name = {
    Text = "異化の神のヴェール"
  },
  State_2418_WeaponDesc = {
    Text = "[狂気解放]により、自身に 30 狂気を得る。"
  },
  State_2419_Name = {
    Text = "遺物白い鏡面"
  },
  State_2420_Desc = {
    Text = "このターン、【防御】を1枚出すごとに、計算力消費が1減少します。"
  },
  State_2420_Name = {
    Text = "心眼の刃"
  },
  State_2420_WeaponDesc = {
    Text = "このターン、【防御】を1枚出すごとに、計算力消費が1減少します。"
  },
  State_24210_Desc = {
    Text = "本ターン、神王の触腕攻撃の対象が全体敵に変更される"
  },
  State_24210_Name = {
    Text = "神国の腕肢–キーオーダー"
  },
  State_24211_Desc = {
    Text = "・ターン終了後、前列の敵に[DescArg2]ダメージを[DescArg4]回与える。敵を撃破した場合、ダメージが[DescArg3]増加する(最大5回まで、現在[DescArg6]回）。\n・「狂気解放」を発動するたび、このターンに追加で1回攻撃する。\n・「キーオーダー」を発動後、このターンはすべての敵に攻撃する。ボス戦では、「神国の腕肢」が与えるダメージが[DescArg5]増加する。"
  },
  State_24211_Name = {
    Text = "神国の腕肢"
  },
  State_24213_Name = {
    Text = "このカードが手札にある場合、ターン終了時に150キーエネルギーを獲得"
  },
  State_24214_Desc = {
    Text = "・ターン終了後、前列の敵に[DescArg2]ダメージを与える。"
  },
  State_24214_Name = {
    Text = "神国の腕肢"
  },
  State_24215_Desc = {
    Text = "・ターン終了後、前列の敵に[DescArg2]ダメージを与える。敵を撃破した場合、ダメージが[DescArg3]増加する（最大5回まで、現在[DescArg4]回）。"
  },
  State_24215_Name = {
    Text = "神国の腕肢"
  },
  State_24217_Name = {
    Text = "自身の<VulnerabilityIconKeywords:易傷>、<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>を解除。"
  },
  State_24220_Name = {
    Text = "[DescArg1]点のシールドを獲得"
  },
  State_24222_Desc = {
    Text = "・ターン終了後、前列の敵に[DescArg2]ダメージを[DescArg4]回与える。敵を撃破した場合、ダメージが[DescArg3]増加する(最大5回まで、現在[DescArg5]回）。\n・「狂気解放」を発動するたび、このターンに追加で1回攻撃する。\n・「キーオーダー」を発動するたび、このターンはすべての敵に攻撃する。"
  },
  State_24222_Name = {
    Text = "神国の腕肢"
  },
  State_24223_Desc = {
    Text = "・ターン終了後、前列の敵に[DescArg2]ダメージを与える。敵を撃破した場合、ダメージが[DescArg3]増加する（最大5回まで、現在[DescArg4]回）。\n・「キーオーダー」を使用するたび、このターンはすべての敵に攻撃する。"
  },
  State_24223_Name = {
    Text = "神国の腕肢"
  },
  State_24224_Desc = {
    Text = "・ターン終了後、前列の敵に[DescArg4]回[DescArg2]ダメージを与える。敵を撃破した場合、ダメージが[DescArg3]増加する（最大5回まで、現在[DescArg5]回）。\n・覚醒体が「狂気解放」を使用するたび、このターン追加で1回攻撃する。"
  },
  State_24224_Name = {
    Text = "神国の腕肢"
  },
  State_24226_Desc = {
    Text = "・ターン終了後、前列の敵に[DescArg2]ダメージを[DescArg4]回与える。敵を撃破した場合、ダメージが[DescArg3]増加する(最大5回まで、現在[DescArg6]回）。\n・「狂気解放」を発動するたび、このターン追加で1回攻撃する。\n・ボス戦では「キーオーダー」を発動するたび、「神国の腕肢」のダメージが[DescArg5]増加する。"
  },
  State_24226_Name = {
    Text = "神国の腕肢"
  },
  State_24227_Desc = {
    Text = "・ターン終了後、前列の敵に[DescArg2]ダメージを与える。敵を撃破した場合、ダメージが[DescArg3]増加する(最大5回まで、現在[DescArg5]回）。\n・「キーオーダー」を発動後、このターンはすべての敵に攻撃する。ボス戦では「神国の腕肢」が与えるダメージが[DescArg4]増加する。"
  },
  State_24227_Name = {
    Text = "神国の腕肢"
  },
  State_2422_Desc = {
    Text = "打出後、[StateArg1]ptのシールドを獲得する。"
  },
  State_2422_Name = {
    Text = "<Rune_6:鉄壁>"
  },
  State_24245_Desc = {
    Text = "ターン終了時、「ヒドラ」の眷属をすべて復活させる。眷属が死亡するたびに1回減少し、回数が0になると「ヒドラ」は形態を変えて最終戦闘に入る。"
  },
  State_24245_Name = {
    Text = "万蛇使役"
  },
  State_24247_Desc = {
    Text = "受けるダメージが90%減少。ターン開始時に「万蛇操使」回数がない場合、この状態を除去。"
  },
  State_24247_Name = {
    Text = "蛇形の壁障"
  },
  State_2425_Desc = {
    Text = "使用した後、除外される。指令カードの場合、ダメージと防御が2倍になる。"
  },
  State_2426_Desc = {
    Text = "あなたがターン毎に最初に出すカードは1回追加で効果が発動しますが、ターン毎に最大4枚までカードを出すことができます。"
  },
  State_2427_Name = {
    Text = "状態@幻夢のシルバーキー：血淵の心カウント"
  },
  State_2428_Desc = {
    Text = "悪の華の<ParcloseIconKeywords:バリア>の数が[Layer]回増える。"
  },
  State_2428_Name = {
    Text = "怨念のバリア"
  },
  State_2428_WeaponDesc = {
    Text = "悪の華のバリア数が [Layer] 層増える"
  },
  State_24292_Name = {
    Text = "後列前進"
  },
  State_24293_Name = {
    Text = "前列後退"
  },
  State_2429_Desc = {
    Text = "与えるすべてのダメージが[Layer]%減少。"
  },
  State_2429_Name = {
    Text = "一時的なダメージ減少"
  },
  State_2429_WeaponDesc = {
    Text = "与えるすべてのダメージが[Layer]%減少。"
  },
  State_2430_Desc = {
    Text = "戦闘開始時、すべての味方が3点の【蝋質の鎧】を獲得。ターン終了時に、味方に[Arg1]点の出血を付与。"
  },
  State_2430_Name = {
    Text = "「蝋の紳士」"
  },
  State_2430_WeaponDesc = {
    Text = "バトル開始時、全体味方に 3 層の【ロウ質の鎧】効果を獲得。ターン終了時、味方チームに[Arg1]層の出血。"
  },
  State_2431_Desc = {
    Text = "チーム唯一：装備者が与えるシールドとライフ回復が装備者の体質の<WeaponEffect_Num:[StateArg1]%>分増加し、装備者が与える反撃が<WeaponEffect_Num:[StateArg3]%>増加する。「防御」を出した時、装備者の防御力の<WeaponEffect_Num:[StateArg4]%>の<RetaliateIconKeywords:反撃>も獲得する。戦闘開始後、装備者の体質の<WeaponEffect_Num:[StateArg2]%>に相当する<PowerIconKeywords:力量>を獲得する。現在の界域が「深海」の場合、同量の触腕ダメージを追加獲得する。"
  },
  State_2431_WeaponDesc = {
    Text = "装備者が与えるシールドとライフ回復が<WeaponEffect_Num:[DescArg1]>ポイント増加し、装備者が与える反撃が<WeaponEffect_Num:[StateArg3]%>増加する。「防御」を出した時、<WeaponEffect_Num:[Counterattack:DescArg3]>層の<RetaliateIconKeywords:反撃>も獲得する。戦闘開始後、<WeaponEffect_Num:[Power:DescArg2]>ポイントの<PowerIconKeywords:力量>を獲得する。現在の界域が「深海」の場合、同量の触腕ダメージを追加獲得する。"
  },
  State_2432_Desc = {
    Text = "受けるアクティブダメージと触手ダメージが50％上昇し、ターン終了時に1スタック除去する。"
  },
  State_2432_Name = {
    Text = "<VulnerabilityIconKeywords:軟化>"
  },
  State_2432_WeaponDesc = {
    Text = "受けるすべてのダメージが50%増加。"
  },
  State_2433_Desc = {
    Text = "各ターン終了時に[Layer]点の力を獲得する。"
  },
  State_2433_Name = {Text = "怒り"},
  State_2434_Name = {
    Text = "「密約」36の廻る部屋"
  },
  State_2434_WeaponDesc = {
    Text = "装備者のカードを引いたとき、その計算力は 0-3 の間でランダムに変化します。"
  },
  State_2435_Desc = {
    Text = "イベント19＿2"
  },
  State_2435_Name = {
    Text = "イベント19＿2"
  },
  State_2435_WeaponDesc = {
    Text = "イベント19＿2"
  },
  State_2436_Desc = {
    Text = "獲得する力とシールドが50%減少する。[Layer]ターン持続。"
  },
  State_2436_Name = {
    Text = "一時的な呪い"
  },
  State_2436_WeaponDesc = {
    Text = "ターン終了前に、自身に付与されるバフ効果を無効化する。"
  },
  State_2437_Desc = {Text = "――"},
  State_2437_WeaponDesc = {Text = "――"},
  State_2438_Desc = {
    Text = "ステータス@つくりもの銀白差分機カウント"
  },
  State_2438_Name = {
    Text = "ステータス@つくりもの銀白差分機カウント"
  },
  State_2438_WeaponDesc = {
    Text = "ステータス@つくりもの銀白差分機カウント"
  },
  State_2440_Name = {
    Text = "カードを1枚引く"
  },
  State_2441_Name = {
    Text = "1 計算力を獲得"
  },
  State_2442_Name = {
    Text = "すべての敵に1点の<VulnerabilityIconKeywords:易傷>を付与"
  },
  State_2443_Name = {
    Text = "すべての敵に1点の<WeaknessIconKeywords:虚弱>を付与"
  },
  State_2444_Name = {
    Text = "<Energy:[DescArg1]>狂気を獲得"
  },
  State_2445_Name = {
    Text = "他の覚醒体は<Energy:[DescArg1]>狂気を獲得"
  },
  State_2446_Name = {
    Text = "<DerivativeCardKeywords_4:「啓示」>を1枚山札に追加"
  },
  State_2447_Desc = {
    Text = "チーム唯一：装備者の指令カードのクリティカル率とクリティカルダメージ、指令カードが与えるシールド、ライフ回復、狂気と力が<WeaponEffect_Num:[StateArg1]%>増加する。現在の界域が「超次元」の場合、「湮滅」を発動した後<WeaponEffect_Num:[StateArg2]>点の銀鍵エネルギーを獲得する。超次元ターンに入った後、本ターンの次のキーオーダーを2回発動する。"
  },
  State_2447_WeaponDesc = {
    Text = "装備者の指令カードのクリティカル率とクリティカルダメージ、指令カードが与えるシールド、ライフ回復、狂気と力が<WeaponEffect_Num:[StateArg1]%>増加する。現在の界域が「超次元」の場合、「湮滅」を発動した後<WeaponEffect_Num:[StateArg2]>点の銀鍵エネルギーを獲得する。超次元ターンに入った後、本ターンの次のキーオーダーを2回発動する。"
  },
  State_2448_Desc = {
    Text = "捨て札フェイズ時、捨て札に行かず、手札に残る。"
  },
  State_2448_Name = {
    Text = "<CardKeyWord:保持>"
  },
  State_2449_Desc = {
    Text = "実際のダメージを受けた後、[Layer]シールドを獲得。"
  },
  State_2449_Name = {
    Text = "バッファー"
  },
  State_2449_WeaponDesc = {
    Text = "実際のダメージを受けた後、[Layer]のシールドを獲得する。"
  },
  State_2450_Desc = {
    Text = "「攻撃」は必ずクリティカルヒットし、クリティカルダメージが50%増加する。"
  },
  State_2451_Desc = {
    Text = "ターン終了時、他の味方が[Layer]力を獲得。"
  },
  State_2451_Name = {
    Text = "「暁の火」"
  },
  State_2452_Desc = {
    Text = "使用した後、[StateArg1]点の力を獲得する。"
  },
  State_2452_Name = {
    Text = "<Rune_14_High:上位剛力>"
  },
  State_2453_Name = {
    Text = "「密約」光合祭礼"
  },
  State_2453_WeaponDesc = {
    Text = "バトル開始後、装備者のすべてのカードが保持される。"
  },
  State_2454_Desc = {
    Text = "使用すると捨て札に行かず、デッキから除去する。"
  },
  State_2454_Name = {
    Text = "<DepleteIconKeywords:除外>"
  },
  State_2454_WeaponDesc = {
    Text = "使用するとカードは捨て札に行かず、この戦闘では再び使用できない。"
  },
  State_24556_Name = {
    Text = "状態@大魔術師フーディーニ@幸運な観客の喝采追加"
  },
  State_2455_Name = {
    Text = "ステータス@青炎の舞者霊感7"
  },
  State_24560_Desc = {
    Text = "キーオーダーを発動するたび、環行・ラモンナの一時的なクリティカル率と一時的なクリティカルダメージ+25%。"
  },
  State_24560_Name = {
    Text = "クラインの旅人"
  },
  State_24562_Desc = {
    Text = "ターン終了後、1点のネゲントロピーを獲得。"
  },
  State_24562_Name = {
    Text = "ペンローズの流人"
  },
  State_24564_Desc = {
    Text = "3点のネゲントロピーを持つたびに、環行・ラモンナの指令カードを使用すると、すべてのネゲントロピーを消費し、ループ効果を発動。ネゲントロピーは最大3点まで累積可能。"
  },
  State_24564_Name = {
    Text = "ネゲントロピー"
  },
  State_2456_Name = {
    Text = "ステータス@青炎の舞者の霊気15"
  },
  State_2457_Name = {
    Text = "カードを1枚引く"
  },
  State_24584_Name = {
    Text = "状態@Nの分身@囁き1状態切り替え"
  },
  State_2458_Name = {
    Text = "ステータス@アクセサリースカーレットの抱擁効果カウント"
  },
  State_24593_Desc = {
    Text = "0点になると、行動予測は「黒い召喚」に変化する。ターン終了時に1点減少する。最大4点。"
  },
  State_24595_Desc = {
    Text = "死後、「N」の「混沌」を1層減少させる。"
  },
  State_24596_Desc = {
    Text = "「N」の分身の召喚時、「暗黒」1点につき1体の分身を召喚する。"
  },
  State_24596_Name = {Text = "暗黒"},
  State_2460_Desc = {
    Text = "チーム唯一：装備者が与える基礎ダメージ、<IntoxicationIconKeywords:毒>と<RetaliateIconKeywords:反撃>が<WeaponEffect_Num:[StateArg1]%>増加する。クリティカル率とクリティカルダメージが<WeaponEffect_Num:[StateArg2]%>増加する。"
  },
  State_2460_WeaponDesc = {
    Text = "装備者が与える基礎ダメージ、<IntoxicationIconKeywords:毒>と<RetaliateIconKeywords:反撃>が<WeaponEffect_Num:[StateArg1]%>増加する。クリティカル率とクリティカルダメージが<WeaponEffect_Num:[StateArg2]%>増加する。"
  },
  State_2461_Desc = {
    Text = "本場の戦闘で致死ダメージを受けた場合、復活し、[Layer] ポイントのライフを回復し、すべての覚醒体に [StateArg1] ポイントの狂気を獲得させます。解除不可"
  },
  State_2461_Name = {
    Text = "不死の極楽鳥"
  },
  State_2463_Desc = {
    Text = "バトル開始時、胚融合＋20％。覚醒体の狂気が満杯である毎個に、胚融合追加＋20％。"
  },
  State_24640_Desc = {
    Text = "戦闘開始後、胚胎融合＋[Blood:DescArg1]、デスレジスタンスが発動するたびに胚胎融合＋[Blood:DescArg1]。ソレールがダメージを与えるごとに、このターン中に自身が与えるダメージが攻撃力の4％アップする。"
  },
  State_2464_Desc = {
    Text = "カードの計算力が増加"
  },
  State_2464_Name = {
    Text = "永久カード行動力消費増加"
  },
  State_2464_WeaponDesc = {
    Text = "カードの行動力消費増加"
  },
  State_24654_Desc = {
    Text = "ダフォダイルが敵を撃破した場合、チームのクリティカル率がこのステージ中、永続的に5%増加する。最大5回まで。(現在DescArg1]回)"
  },
  State_24654_Name = {
    Text = "貪婪な灰色の霧"
  },
  State_2466_Desc = {
    Text = "次のターン開始まで、攻撃ダメージを1回受けるたびに、触手が攻撃者に1回カウンターし、一時的な触腕ダメージ +[Layer]。"
  },
  State_2466_Name = {
    Text = "〔廃止〕異端の継承"
  },
  State_24678_Name = {
    Text = "状態@Nの分身@囁き2状態切り替え"
  },
  State_24679_Name = {
    Text = "状態@Nの分身3@囁き6状態切り替え"
  },
  State_2467_Desc = {
    Text = "ステータス@序章攻勢の推移"
  },
  State_2467_Name = {
    Text = "ステータス@序章攻勢の推移"
  },
  State_2467_WeaponDesc = {
    Text = "ステータス@序章攻勢の推移"
  },
  State_24680_Name = {
    Text = "状態@Nの分身2@囁き1状態切り替え"
  },
  State_24681_Name = {
    Text = "状態@Nの分身@囁き6状態切り替え"
  },
  State_24682_Name = {
    Text = "状態@Nの分身3@囁き3状態切り替え"
  },
  State_24683_Name = {
    Text = "状態@Nの分身2@囁き2状態切り替え"
  },
  State_24684_Name = {
    Text = "状態@Nの分身@囁き4状態切り替え"
  },
  State_24685_Name = {
    Text = "状態@Nの分身@囁き5状態切り替え"
  },
  State_24686_Name = {
    Text = "状態@Nの分身3@囁き5状態切り替え"
  },
  State_24687_Name = {
    Text = "状態@Nの分身3@囁き2状態切り替え"
  },
  State_24688_Name = {
    Text = "状態@Nの分身2@囁き6状態切り替え"
  },
  State_24689_Name = {
    Text = "状態@Nの分身3@囁き4状態切り替え"
  },
  State_24690_Name = {
    Text = "状態@Nの分身3@囁き1状態切り替え"
  },
  State_24691_Name = {
    Text = "状態@Nの分身2@囁き4状態切り替え"
  },
  State_24692_Name = {
    Text = "状態@Nの分身2@囁き3状態切り替え"
  },
  State_24693_Name = {
    Text = "状態@Nの分身@囁き3状態切り替え"
  },
  State_24694_Name = {
    Text = "状態@Nの分身2@囁き5状態切り替え"
  },
  State_2470_Desc = {
    Text = "獲得時、永久に[Arg1]の警戒を失い、与えるアクティブダメージが追加で1倍の力のボーナスを受ける。"
  },
  State_24719_Desc = {
    Text = "「@2」 が解放の姿で現れ、ライフが元の3倍になる。"
  },
  State_24719_Name = {
    Text = "運命の復活"
  },
  State_24719_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_2471_Desc = {
    Text = "ターン開始時、味方チームの警戒を1下げる。"
  },
  State_2471_Name = {Text = "腐蝕"},
  State_2471_WeaponDesc = {
    Text = "ターン開始時、味方チームの警戒が1減少します。"
  },
  State_24720_Desc = {
    Text = "未知の存在の力が昏き海の下にまだ潜んでいる。撃破される直前に完全に復活し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_24720_Name = {Text = "潜伏"},
  State_2472_Desc = {
    Text = "ダメージ軽減を無視してシールドとライフにダメージを与える。"
  },
  State_2472_Name = {
    Text = "<PunctureDamagewords:刺突ダメージ>"
  },
  State_2472_WeaponDesc = {
    Text = "突き刺しダメージはターゲットのシールド、減傷ブロックを無視し、直接ダメージを引き起こします。"
  },
  State_24730_Desc = {
    Text = "一時的な超次元空間を増やす。上限は10。次回の超次元ターンに入ると、一時的な超次元空間のカードを手札に追加し、一時的な超次元空間が解除される。"
  },
  State_24730_Name = {
    Text = "<CardKeyWord:一時的な超次元空間>"
  },
  State_24737_Desc = {
    Text = "ターン開始時、相手に出血を与える。運命の1層ごとに[StateArg1]の出血を与える"
  },
  State_24737_Name = {Text = "運命"},
  State_24738_Desc = {
    Text = "命運の回が有効時に[StateArg1]の出血を与え、カードを1枚使用するごとに命運の回が1減る"
  },
  State_24738_Name = {Text = "運命"},
  State_24739_Name = {Text = "運命"},
  State_2473_Desc = {
    Text = "[防御]触腕を1本失い、[StateArg1]のライフを返信する。[打撃]ライフを[StateArg2]失い、触腕を1本生成する。"
  },
  State_2473_Name = {
    Text = "遺物長生者の血肉__「開発用」"
  },
  State_2473_WeaponDesc = {
    Text = "[防御]触腕を1本失い、[StateArg1]のライフを返信する。[打撃]ライフを[StateArg2]失い、触腕を1本生成する。"
  },
  State_2474_Desc = {
    Text = "[Layer]％の攻撃力を上昇させる。"
  },
  State_2474_Name = {
    Text = "汎用攻撃力％増加"
  },
  State_2474_WeaponDesc = {
    Text = "[Layer]％の攻撃力を上昇させる。"
  },
  State_2475_Desc = {
    Text = "チーム唯一：装備者が与えるアクティブダメージが装備者の攻撃力の<WeaponEffect_Num:[StateArg3]%>分増加する。装備者の指令カードを1枚出すか捨てるたびに、ランダムな敵に装備者の攻撃力の<WeaponEffect_Num:[StateArg1]%>に相当する<IntoxicationIconKeywords:中毒>を与える。超次元ターン終了後、<WeaponEffect_Num:[StateArg2]%>の確率ですべての敵に100％の中毒を発動する。"
  },
  State_2475_WeaponDesc = {
    Text = "装備者が与えるアクティブダメージが<WeaponEffect_Num:[DescArg2]>点増加する。装備者の指令カードを1枚出すか捨てるたびに、ランダムな敵に<WeaponEffect_Num:[DescArg1]>層の<IntoxicationIconKeywords:中毒>を与える。超次元ターン終了後、<WeaponEffect_Num:[StateArg2]%>の確率ですべての敵に[DescArg3]％の中毒を発動する。"
  },
  State_2476_Name = {
    Text = "ステータス@起源知者霊気1"
  },
  State_2478_Desc = {
    Text = "ナウティルスが付与するシールドの倍率が2倍になります。"
  },
  State_2478_Name = {
    Text = "修繕の達人"
  },
  State_2478_WeaponDesc = {
    Text = "ナウティルスが付与するシールドの倍率が2倍になります。"
  },
  State_2479_Desc = {
    Text = "翠火がダメージを与えるたびに、層数の＋1"
  },
  State_2479_Name = {
    Text = "エメラルドイメージカウント"
  },
  State_2479_WeaponDesc = {
    Text = "翠火がダメージを与えるたびに、層数の＋1"
  },
  State_2480_Desc = {
    Text = "回复时获得 [StateArg1] のカウンター。沈淵者が1枚のカードを出すごとに、ライフを1回復する。"
  },
  State_2480_Name = {
    Text = "変身する体"
  },
  State_2481_Desc = {
    Text = "ステータス@プロローグリセットデッキ0＿2＿3＿1"
  },
  State_2481_Name = {
    Text = "ステータス@プロローグリセットデッキ0＿2＿3＿1"
  },
  State_2481_WeaponDesc = {
    Text = "ステータス@プロローグリセットデッキ0＿2＿3＿1"
  },
  State_2482_Desc = {
    Text = "ライフが50%未満になると、同等のライフを持つ融食三角を1体召喚する"
  },
  State_2482_Name = {Text = "召喚"},
  State_2482_WeaponDesc = {
    Text = "ライフが50%未満になると、同等のライフを持つ融食三角を1体召喚する"
  },
  State_2486_Desc = {
    Text = "ターン開始時、敵1体につき1点の行動力を獲得。アクティブダメージで敵を倒すと、他の敵に過剰ダメージに等しい出血を付与。"
  },
  State_24879_Desc = {
    Text = "千年が過ぎ、万年が過ぎ、彼らは永暗の廃墟で寵愛を待ち続ける。死亡後、「N」の「混沌」が1点減少し、「N」が[DescArg1]点のシールドと[DescArg2]点の力を獲得する。"
  },
  State_24879_Name = {
    Text = "虚妄の分身"
  },
  State_2488_Desc = {
    Text = "「増益カード」/「症状カード」/「状態カード」を使用するたびに、狂気が最も低い覚醒体が10狂気を獲得。"
  },
  State_2489_Desc = {
    Text = "クリティカル率が10%増加する。毎ターン初めてクリティカル発生後、クリティカル率が追加で20%増加し、毎ターン3回目のクリティカル発生後、クリティカルダメージが追加で50%増加する。"
  },
  State_2490_Desc = {
    Text = "1点につき攻撃回数+1。ダメージを受けると1点を失う。ターン終了時にすべて失う。"
  },
  State_2490_Name = {Text = "祈り"},
  State_2491_Desc = {
    Text = "ライフを回復すると同量のシールドを獲得。"
  },
  State_2491_Name = {
    Text = "一時的な硬化"
  },
  State_2492_Desc = {
    Text = "各ターン、初めてのアクティブダメージを無効化する。"
  },
  State_2492_Name = {Text = "確固"},
  State_2492_WeaponDesc = {
    Text = "各ターン初めてのアクティブなダメージに免疫する。"
  },
  State_2493_Desc = {
    Text = "与えるアクティブダメージが[Layer]減少する。"
  },
  State_2493_Name = {
    Text = "力の減少"
  },
  State_2494_Desc = {
    Text = "ステータス@序章狂気0＿1＿4＿1"
  },
  State_2494_Name = {
    Text = "ステータス@序章狂気0＿1＿4＿1"
  },
  State_2494_WeaponDesc = {
    Text = "ステータス@序章狂気0＿1＿4＿1"
  },
  State_2495_Desc = {
    Text = "ステータス@序章狂気0＿1＿4＿2"
  },
  State_2495_Name = {
    Text = "ステータス@序章狂気0＿1＿4＿2"
  },
  State_2495_WeaponDesc = {
    Text = "ステータス@序章狂気0＿1＿4＿2"
  },
  State_24968_Desc = {
    Text = "バトル開始後、胚胎融合 ＋[Blood:DescArg2]、デスレジスタンスが発動するたびに、胚胎融合 ＋[Blood:DescArg2]。ソレールがダメージを与えるたびに、このターン中に自身が与えるダメージが [DescArg1] アップ。"
  },
  State_2496_Desc = {
    Text = "ターン開始時に [Arg1] のライフを回復する。ライフが 50％ より低い場合、回復量が [Arg2] に変更される。"
  },
  State_2496_Name = {
    Text = "恩賜の血"
  },
  State_24976_Desc = {
    Text = "「十三夜のメイド」が覚醒した。特製料理の危険に注意せよ！"
  },
  State_24976_Name = {
    Text = "カレン覚醒！"
  },
  State_24976_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_24977_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_24977_Name = {Text = "未覚醒"},
  State_2497_Desc = {
    Text = "リリーはプレイヤーが各ターン初めて使用する指令カードを模倣する。「攻撃」カードの場合、リリーの攻撃回数+1。「防御」カードの場合、リリーはライフの10%シールドを獲得。その他の指令カードの場合、リリーは「膿」を1体召喚。"
  },
  State_2497_Name = {
    Text = "リリー覚醒！"
  },
  State_2497_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_2498_Name = {
    Text = "「密約」呪いのウサギ"
  },
  State_2498_WeaponDesc = {
    Text = "装備者が造成するシールドとライフ回復が6％上昇する。装備者の領域マスタリーが50より大きい場合、シールドとライフ回復が追加で6％上昇する。"
  },
  State_2499_Name = {
    Text = "停滞の呪い"
  },
  State_2500_Desc = {
    Text = "実際のダメージを与えるたびに、毒を付与する。__「開発用」"
  },
  State_2501_Desc = {
    Text = "チーム唯一：チームのライフ上限が10%増加する。装備者が与える回復とシールドが<WeaponEffect_Num:[StateArg3]%>増加する。装備者の「攻撃」を出した後、<WeaponEffect_Num:[StateArg1]%>の失ったライフを回復する。装備者の「防御」を出した後、<WeaponEffect_Num:[StateArg2]%>の現在ライフ分のシールドを獲得する。この効果は毎ターンそれぞれ最大1回発動する。"
  },
  State_2501_Name = {
    Text = "魂の誕生"
  },
  State_2501_WeaponDesc = {
    Text = "チームのライフ上限が10%増加する。装備者が与える回復とシールドが<WeaponEffect_Num:[StateArg3]%>増加する。装備者の「攻撃」を出した後、[StateArg1]%（<WeaponEffect_Num:[Heal:DescArg1]>）の失ったライフを回復する。装備者の「防御」を出した後、[StateArg1]%（<WeaponEffect_Num:[Block:DescArg2]>）の現在ライフ分のシールドを獲得する。この効果は毎ターンそれぞれ最大1回発動する。"
  },
  State_2502_Desc = {
    Text = "与えるアクティブおよび触手ダメージが 50 ％低下する。"
  },
  State_2502_Name = {
    Text = "寂滅倦怠"
  },
  State_2502_WeaponDesc = {
    Text = "与えるすべてのダメージが50%減少。"
  },
  State_2503_Desc = {
    Text = "チーム唯一：装備者のカードが与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。ターン開始時、<WeaponEffect_Num:[StateArg2]%>の確率で装備者のランダムなカードを1枚手札に生成し、消耗を付与する。現在の界域が「血肉」の場合、装備者に「胚胎」を使用すると、装備者の今ターンの次の打撃カードが与えるダメージのクリティカル率が<WeaponEffect_Num:+[StateArg3]%>増加する。"
  },
  State_2503_WeaponDesc = {
    Text = "装備者のカードが与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。ターン開始時、<WeaponEffect_Num:[StateArg2]%>の確率で装備者のランダムなカードを1枚手札に生成し、消耗を付与する。現在の界域が「血肉」の場合、装備者に「胚胎」を使用すると、装備者の今ターンの次の打撃カードが与えるダメージのクリティカル率が<WeaponEffect_Num:+[StateArg3]%>増加する。"
  },
  State_2504_Desc = {
    Text = "「打撃」で2の行動力を獲得し、ランダムに1枚のカードを捨てる。「防御」で2枚のカードを引き、1の行動力を失う。"
  },
  State_25056_Desc = {
    Text = "行動力を消費するごとに、カレンが[Layer]の一時的な力を獲得"
  },
  State_25056_Name = {Text = "満腹"},
  State_25057_Desc = {
    Text = "行動力を消費するごとに、カレンが[StateArg1]点の一時的な力を獲得し、ターン終了時に1点を除去。"
  },
  State_25057_Name = {Text = "満腹"},
  State_2505_Name = {
    Text = "「密約」四月の賛歌"
  },
  State_2505_WeaponDesc = {
    Text = "バトル開始後、装備者の職業が超次元の場合、攻撃力が25％上昇します。"
  },
  State_2507_Desc = {
    Text = "取得時に最大ライフが100％増加し、ターン開始時に[Arg1]ポイントのライフを失います。"
  },
  State_2509_Name = {
    Text = "状態@汎用界域知識"
  },
  State_2511_Desc = {
    Text = "状態@序章キーエネルギー教習"
  },
  State_2511_Name = {
    Text = "状態@序章キーエネルギー教習"
  },
  State_2511_WeaponDesc = {
    Text = "ステータス@プロローグリセットカードライブラリー0＿1＿2＿2"
  },
  State_2512_Desc = {
    Text = "算力消費が 3 以上のカードを 1 枚使用した時、1 枚のカードを引き、1 点の算力を獲得する。"
  },
  State_2514_Desc = {
    Text = "この戦闘で獲得するシールドが[Layer]点減少。"
  },
  State_2514_Name = {
    Text = "警戒減少"
  },
  State_2514_WeaponDesc = {
    Text = "この戦闘で獲得するシールドが[Layer]点減少。"
  },
  State_2515_Desc = {
    Text = "【打撃】ですべての敵に [StateArg1] 層の毒を付与。"
  },
  State_2515_Name = {
    Text = "遺物神経毒"
  },
  State_25163_Desc = {
    Text = "彼は霧のように捉えどころがない。"
  },
  State_25163_Name = {
    Text = "往日の影"
  },
  State_25165_Desc = {
    Text = "環行・ラモンナの指令カード独自の追加効果であり、3点のネゲントロピーを持つ時に発動する。「ループ」は次の戦闘に引き継がれる。"
  },
  State_25165_Name = {
    Text = "<TimeBeacon:ループ>"
  },
  State_25166_Desc = {
    Text = "3点のネゲントロピーを持つたびに、環行・ラモンナの指令カードを使用すると、すべてのネゲントロピーを消費し、ループ効果を発動。ネゲントロピーは最大3点まで累積可能。"
  },
  State_25166_Name = {
    Text = "<TimeBeacon2:ネゲントロピー>"
  },
  State_2516_Desc = {
    Text = "このカードは能動的に使用できない。"
  },
  State_2516_Name = {
    Text = "使用不可"
  },
  State_2516_WeaponDesc = {
    Text = "カードは出せない。"
  },
  State_25179_Name = {
    Text = "狂気判定"
  },
  State_2517_Desc = {
    Text = "味方チームが狂気解放を発動した後、自身はそのターン、力を失う。1ターンに1回。"
  },
  State_2517_Name = {
    Text = "狂気を恐れる"
  },
  State_25181_Name = {
    Text = "輪回保持効果"
  },
  State_2518_Desc = {
    Text = "ステータス@序章リセットデッキ0＿1＿1＿3"
  },
  State_2518_Name = {
    Text = "ステータス@序章リセットデッキ0＿1＿1＿3"
  },
  State_2518_WeaponDesc = {
    Text = "ステータス@序章リセットデッキ0＿1＿1＿3"
  },
  State_25194_Desc = {
    Text = "死後、「N」に[DescArg1]のシールドと[DescArg2]の永久力を追加する"
  },
  State_2519_Desc = {
    Text = "ステータス@序章リセットデッキ0＿1＿1＿3"
  },
  State_2519_Name = {
    Text = "ステータス@序章リセットデッキ0＿1＿1＿3"
  },
  State_2519_WeaponDesc = {
    Text = "ステータス@序章リセットデッキ0＿1＿1＿3"
  },
  State_25204_Name = {
    Text = "状態@Nの分身2@行動判定"
  },
  State_25205_Name = {
    Text = "状態@Nの分身3@行動判定"
  },
  State_25206_Name = {
    Text = "状態@N@分身Nの判定"
  },
  State_25207_Name = {
    Text = "状態@Nの分身@行動判定"
  },
  State_2520_Desc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿1＿2"
  },
  State_2520_Name = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿1＿2"
  },
  State_2520_WeaponDesc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿1＿2"
  },
  State_2522_Desc = {
    Text = "ヘロットが覚醒した。攻撃力と欲望が高まる。"
  },
  State_2522_Name = {
    Text = "ヘロット覚醒"
  },
  State_2523_Desc = {
    Text = "奇数ターン開始時、このターン中に[Arg1]の力を獲得。偶数ターン開始時、このターン中に[Arg2]の警戒を獲得。"
  },
  State_2524_Desc = {
    Text = "戦闘開始時、1の力を獲得。"
  },
  State_2524_Name = {Text = "威名"},
  State_2525_Desc = {
    Text = "攻撃回数-1、[Layer]の力を獲得。"
  },
  State_2525_Name = {Text = "情欲"},
  State_2527_Name = {
    Text = "深紅の力ボーナス"
  },
  State_2528_Desc = {
    Text = "実際の行動力消費が3のカードを1枚使用すると、1枚引いて2点の行動力を獲得。"
  },
  State_2529_Desc = {
    Text = "このターン内クリティカルダメージが [Layer] ％ 上昇。"
  },
  State_2529_Name = {
    Text = "一時的なクリティカルダメージ"
  },
  State_2529_WeaponDesc = {
    Text = "このターン内クリティカルダメージが [Layer] ％ 上昇。"
  },
  State_2531_Desc = {
    Text = "翠火が [Damage:StateArg2] 回のダメージを与えるたびに、【みどりのほのお】を1枚獲得する。"
  },
  State_2531_Name = {
    Text = "翡翠の映像"
  },
  State_2531_WeaponDesc = {
    Text = "翠火が [Damage:StateArg2] 回のダメージを与えるたびに、【みどりのほのお】を1枚獲得する。"
  },
  State_2532_Name = {
    Text = "「密約」深紅の鼓動"
  },
  State_2534_Desc = {
    Text = "ステータス@序章リセットカードライブラリ0＿1＿3＿3"
  },
  State_2534_Name = {
    Text = "ステータス@序章リセットカードライブラリ0＿1＿3＿3"
  },
  State_2534_WeaponDesc = {
    Text = "ステータス@序章リセットカードライブラリ0＿1＿3＿3"
  },
  State_2535_Desc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿3＿2"
  },
  State_2535_Name = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿3＿2"
  },
  State_2535_WeaponDesc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿3＿2"
  },
  State_2536_Name = {
    Text = "状態@一時的な攻撃カードクリティカルダメージアップ"
  },
  State_2537_Desc = {
    Text = "空想利剣がシールドを付与したとき、[StateArg2] ポイントの一時警戒を獲得する。"
  },
  State_2537_Name = {
    Text = "戦場の卓識"
  },
  State_2537_WeaponDesc = {
    Text = "空想利剣がシールドを付与したとき、[StateArg2] ポイントの一時警戒を獲得する。"
  },
  State_2538_Desc = {
    Text = "発射後[StateArg1]点のカウンターを獲得し、すべての敵にカウンターの[StateArg2]%の<FixedDamage:純粋ダメージ>を与える。"
  },
  State_2538_Name = {
    Text = "<Rune_9_High:上位反撃>"
  },
  State_25391_Desc = {
    Text = "チームの覚醒体1名が「幸運な観客」に選ばれ、その覚醒体の全カードに「喝采」効果を付与。"
  },
  State_25391_Name = {
    Text = "幸運な観客"
  },
  State_25392_Desc = {
    Text = "使用した後、最大ライフの2%を失い、大魔術師がそのターン1点の「得意満面」を獲得。"
  },
  State_25392_Name = {
    Text = "<CardCheerKeywords:喝采>"
  },
  State_25401_Desc = {
    Text = "このカードが手札にあると手札の上限を+1します。"
  },
  State_25401_Name = {
    Text = "手札の上限無視"
  },
  State_25403_Desc = {
    Text = "触手ダメージが50％低下し、1回の触手ダメージを与えるたびに[Layer]ポイントのシールドを獲得する。"
  },
  State_25405_Desc = {
    Text = "このカードはどんな状況でも手札にあります。"
  },
  State_25405_Name = {
    Text = "永久保存"
  },
  State_25406_Desc = {
    Text = "このターン中はタッチアームの形態を変更できません"
  },
  State_25406_Name = {
    Text = "深海の狂気·制限"
  },
  State_25407_Desc = {
    Text = "触手ダメージが25％アップ、ターン終了時に触手の数量が-1。"
  },
  State_25407_Name = {
    Text = "深海狂乱"
  },
  State_25415_Desc = {
    Text = "キーの解放後、[Layer] ポイントのキーを獲得。"
  },
  State_25415_Name = {
    Text = "カオステンポラリー・キーが溢れる"
  },
  State_25417_Name = {Text = "爆弾3"},
  State_25418_Name = {Text = "爆弾2"},
  State_2542_Name = {
    Text = "遺物名無しの肢体カウント"
  },
  State_2543_Name = {
    Text = "状態@ステージ2_14戦闘8バブル1"
  },
  State_2544_Desc = {
    Text = "ステータス@序章モンスターのパッシブ効果"
  },
  State_2544_Name = {
    Text = "ステータス@序章モンスターのパッシブ効果"
  },
  State_2544_WeaponDesc = {
    Text = "ステータス@序章モンスターのパッシブ効果"
  },
  State_2545_Desc = {
    Text = "バトル開始時、胚融合＋20％。覚醒体の狂気が満杯である毎個に、胚融合追加＋20％。"
  },
  State_2547_Desc = {
    Text = "ターン開始時、このターン中に[Arg1]力を持つ「銛」を手札に追加。狂気解放後、手札にあるすべての「銛」の力が[Arg2]増加。"
  },
  State_2548_Desc = {
    Text = "一度の死亡を免疫し、トリガー後に 50 のライフを回復し、そのつくりものを永久に無効化する。"
  },
  State_2548_Name = {
    Text = "遺物身代わり人形"
  },
  State_2548_WeaponDesc = {
    Text = "一度の死亡を免疫し、トリガー後に 50 のライフを回復し、そのつくりものを永久に無効化する。"
  },
  State_2549_Desc = {
    Text = "与えるダメージと触腕ダメージを減少。"
  },
  State_2549_Name = {
    Text = "<ExhaustionIconKeywords: 力減少>"
  },
  State_2549_WeaponDesc = {
    Text = "各層の衰竭により、与えるダメージと触手ダメージが1低下げます。"
  },
  State_2550_Desc = {
    Text = "抽到時に自身を脆弱にする 1 ターン。使用後、すべての敵に弱点を与える 1 ターン。売却不可。"
  },
  State_2550_Name = {
    Text = "状態呪い崩壊"
  },
  State_2550_WeaponDesc = {
    Text = "抽到時に自身を脆弱にする 1 ターン。使用後、すべての敵に弱点を与える 1 ターン。売却不可。"
  },
  State_2552_Desc = {
    Text = "捨て札フェイズ時、捨て札に行かず、手札に残る。"
  },
  State_2552_Name = {
    Text = "<RetainIconKeywords:保持>"
  },
  State_2552_WeaponDesc = {
    Text = "カードは捨てのフェイズにおいて捨て札の山に移動せず、手札のまま残ります。"
  },
  State_2553_Desc = {
    Text = "ターン開始時、1つの計算力を獲得"
  },
  State_2553_Name = {
    Text = "遺物アルカナ行動力"
  },
  State_2553_WeaponDesc = {
    Text = "ターン開始時、1つの計算力を獲得"
  },
  State_2554_Name = {
    Text = "パトニー・モーニング・ポスト"
  },
  State_2556_Desc = {
    Text = "ライフが減少すると、減少値の[Layer]%に相当するシールドを獲得。"
  },
  State_2556_Name = {
    Text = "血のシールド"
  },
  State_2556_WeaponDesc = {
    Text = "HPが減少した後、シールドを獲得し、減少量の[Layer]％に相当する"
  },
  State_2557_Desc = {
    Text = "次のターン開始時に、[Layer]シールドを獲得。"
  },
  State_2557_Name = {
    Text = "苦痛と歓喜のシールド"
  },
  State_2558_Desc = {
    Text = "ライフが50%([StateArg1])未満になると、「干渉型融蝕生物」2体に分裂する。"
  },
  State_2558_WeaponDesc = {
    Text = "ライフが 50%([StateArg1]) を下回ったとき、「II型融食体」にスプリットし、2体に同じ量のライフを持つ。"
  },
  State_2559_Desc = {
    Text = "攻撃を受けるたびに、[Layer]の一時的な力を失う。"
  },
  State_2559_Name = {
    Text = "衝動の代償"
  },
  State_2560_Desc = {
    Text = "次のターンの開始後に [Layer] シールドを獲得します。"
  },
  State_2560_Name = {
    Text = "閉鎖空間での制作"
  },
  State_2560_WeaponDesc = {
    Text = "次のターンの開始後に [Layer] シールドを獲得します。"
  },
  State_2561_Desc = {
    Text = "憂鬱な才能"
  },
  State_2561_Name = {
    Text = "憂鬱な才能"
  },
  State_2561_WeaponDesc = {
    Text = "憂鬱な才能"
  },
  State_2562_Name = {
    Text = "状態@第三章_共鳴1_マーク"
  },
  State_2563_Desc = {
    Text = "10枚目のカードをプレイするたびに、触手ダメージが2上昇し、すべての触手が1回攻撃します。"
  },
  State_2563_Name = {Text = "遺物銛"},
  State_2563_WeaponDesc = {
    Text = "10枚目のカードをプレイするたびに、触手ダメージが2上昇し、すべての触手が1回攻撃します。"
  },
  State_2564_Desc = {
    Text = "獲得するすべてのシールドが[DescArg1]%減少。"
  },
  State_2564_Name = {
    Text = "<FragileColour:抑圧>"
  },
  State_2564_WeaponDesc = {
    Text = "獲得したすべてのシールドが33%減少。"
  },
  State_2565_Name = {
    Text = "「密約」深紅の抱擁"
  },
  State_2565_WeaponDesc = {
    Text = "装備者がダメージを与えたときに 20 点のシルバーキーエネルギーを獲得し、クリティカルダメージを与えた場合は 50 点のシルバーキーエネルギーを獲得する。毎ターン最大 3 回まで発動可能。"
  },
  State_2566_Desc = {
    Text = "1 ターン内に 3 回攻撃を受けた後、1 スタックの一時的<MadnessColour:発狂>を獲得する。"
  },
  State_2566_Name = {
    Text = "「甘美な痛み」"
  },
  State_2567_Desc = {
    Text = "すでに [Layer] 回ダメージを受けており、3 回に達した後「甘い悪鬼」は本ターン内に 1 スタックの<MadnessColour:発狂>を獲得する。"
  },
  State_2567_Name = {
    Text = "「甘美な痛み」回数"
  },
  State_2567_WeaponDesc = {
    Text = "[LAYER] 回ダメージを受け、3 回に達すると「甘い悪鬼」はこのターンで 1 層の狂気を獲得する。"
  },
  State_2569_Desc = {
    Text = "界域推薦ボーナス効果が50%にアップし、ステージ開始時に界域精通が100増加。__「開発用」"
  },
  State_2569_Name = {
    Text = "状態@幻夢のシルバーキー：適性分離__「開発用」"
  },
  State_2570_Desc = {
    Text = "打出後 [StateArg1] 枚のカードを引きます。"
  },
  State_2570_Name = {
    Text = "<Rune_3:神技>"
  },
  State_2571_Desc = {
    Text = "パーティにいる【カオス】職の覚醒体の数によって、全隊の最大ライフ(未完了)、防御、攻撃が50%上昇する"
  },
  State_2571_Name = {
    Text = "カオスボーナス"
  },
  State_2571_WeaponDesc = {
    Text = "パーティにいる【カオス】職の覚醒体の数によって、全隊の最大ライフ(未完了)、防御、攻撃が50%上昇する"
  },
  State_2572_Desc = {
    Text = "使用した後、胚胎融合+[StateArg1]。"
  },
  State_2572_Name = {
    Text = "<Rune_12:好血>"
  },
  State_2573_Desc = {
    Text = "5 層の【導火線】を持つ。カードをプレイすると層数が 1 減少する。層数が 0 になったとき自爆し、攻撃力＊2.5 のダメージを与える。"
  },
  State_2573_Name = {Text = "爆弾"},
  State_2573_WeaponDesc = {
    Text = "5 層の【導火線】を持つ。カードをプレイすると層数が 1 減少する。層数が 0 になったとき自爆し、攻撃力＊2.5 のダメージを与える。"
  },
  State_2574_Desc = {
    Text = "クリティカルダメージ+50%。あるターンに攻撃を行わなかった場合、次のターンは必ずクリティカルになる。__「開発用」"
  },
  State_2574_Name = {
    Text = "状態@幻夢のシルバーキー：輪舞__「開発用」"
  },
  State_2575_Desc = {
    Text = "チーム唯一：戦闘開始時、造物1つにつき装備者の指令カードクリティカル率が[StateArg1]%増加する。装備者が狂気爆発を発動後、4面ダイスを1つ振り、装備者はダイスの出目の<WeaponEffect_Num:[StateArg2]>倍の狂気と一時クリティカルダメージを獲得する。4以上が出た場合、他の覚醒体も半分を獲得する。"
  },
  State_2575_WeaponDesc = {
    Text = "戦闘開始時、造物1つにつき装備者の指令カードクリティカル率が[StateArg1]%増加する。装備者が狂気爆発を発動後、4面ダイスを1つ振り、装備者はダイスの出目の<WeaponEffect_Num:[StateArg2]>倍の狂気と一時クリティカルダメージを獲得する。4以上が出た場合、他の覚醒体も半分を獲得する。"
  },
  State_2576_Desc = {
    Text = "カードが超次元空間に入ると、その算力消費が–1。"
  },
  State_2579_Desc = {
    Text = "このターン内に与えるアクティブダメージの回数が [Layer] 上昇する。"
  },
  State_2579_Name = {
    Text = "<MadnessColour:一時的発狂>"
  },
  State_2580_Desc = {
    Text = "ヘッドハンターメイジのカードが超次元空間に進入または離れるたびに、1の計算力を獲得する。"
  },
  State_2580_Name = {
    Text = "次元の投影"
  },
  State_2581_Desc = {
    Text = "すべての覚醒体のキーチャージが30増加する。「キーオーダー」発動後、<DerivativeCardKeywords_4:「啓示」>を3枚あなたの山札のランダムな位置に追加する。"
  },
  State_2581_Name = {
    Text = "状態@時の振り子・洞察"
  },
  State_2582_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_2582_Name = {
    Text = "状態@試作レーザー砲狂気"
  },
  State_2583_Desc = {
    Text = "毎回能動的なダメージを受けたときに味方チームにカウントを1つ追加する"
  },
  State_2583_Name = {
    Text = "状態@復讐の巨刃斬首一閃カウント"
  },
  State_2583_WeaponDesc = {
    Text = "毎回能動的なダメージを受けたときに味方チームにカウントを1つ追加する"
  },
  State_2584_Desc = {
    Text = "デッキがリセットされるたびに、[Arg1] パワーを獲得する。"
  },
  State_2586_Desc = {
    Text = "獲得するすべてのシールドが25％減少する。ターン終了時に1点を除去。"
  },
  State_2586_Name = {
    Text = "<FragileIconKeywords:抑圧>"
  },
  State_2586_WeaponDesc = {
    Text = "獲得したすべてのシールドが 25 ％ 低下げます。"
  },
  State_2587_Desc = {
    Text = "傷口のダメージが倍増。実際のダメージを与えるたびに[Layer]点のシールドを獲得。"
  },
  State_2587_Name = {
    Text = "「噛天の牙」"
  },
  State_2587_WeaponDesc = {
    Text = "傷のダメージが倍になる。実際にダメージを受けるたびに、[Layer]点のシールドを獲得する。"
  },
  State_2588_Desc = {
    Text = "ターン終了後、[Layer] 点の<FixedDamage:純粋ダメージ>を受け、このステータスを除去する。ライフ回復時、回復量の2倍の出血スタック数を除去する。"
  },
  State_2588_Name = {
    Text = "永久<BleedingColour:出血>"
  },
  State_2588_WeaponDesc = {
    Text = "ターン終了時、[Layer]ポイントのダメージを受け、その状態が解除される。回復毎に層数が半分になる。"
  },
  State_2589_Name = {
    Text = "「密約」歪みの双子黒"
  },
  State_2589_WeaponDesc = {
    Text = "奇数のターン開始後、装備者の「打撃」を手札に加える。ただし、その「打撃」は虚無と消費が付与されている。"
  },
  State_2590_Desc = {
    Text = "移動時に 10 ブラックスタンプを獲得"
  },
  State_2590_Name = {
    Text = "遺物底なし袋"
  },
  State_2590_WeaponDesc = {
    Text = "移動時に 10 ブラックスタンプを獲得"
  },
  State_2592_Desc = {
    Text = "ライフを1点失うごとに1点を除去し、0点になると[DescArg1]のシールドを獲得。"
  },
  State_2592_Name = {
    Text = "次元障壁"
  },
  State_2593_Name = {
    Text = "ステータス@スカーレットの血と砂の賛美歌"
  },
  State_2594_Desc = {
    Text = "実際のダメージを与えるとシールドを獲得"
  },
  State_2594_Name = {
    Text = "「噛天の牙」"
  },
  State_2594_WeaponDesc = {
    Text = "実際のダメージを与えるとシールドを獲得"
  },
  State_2595_Desc = {
    Text = "1回のダメージを与えるたび、[StateArg2]の一時的な力を獲得。"
  },
  State_2595_Name = {
    Text = "知者の女王の剣起動"
  },
  State_2597_Desc = {
    Text = "ターン開始時、[Layer]点のシールドを獲得。"
  },
  State_2597_Name = {
    Text = "遅延シールド"
  },
  State_2597_WeaponDesc = {
    Text = "ターン開始時、[Layer]点のシールドを獲得。"
  },
  State_2600_Desc = {
    Text = "ライフを失うたびに、狂気が最も低い覚醒体が10狂気を獲得。5回ライフを失うたびに、1層バリアを獲得。__「開発用」"
  },
  State_2600_Name = {
    Text = "時霊振子「解析」__「開発用」"
  },
  State_2601_Desc = {
    Text = "偶数ターンのダメージが50％減少し、ダメージが33％アップする。"
  },
  State_2601_Name = {
    Text = "気まぐれ"
  },
  State_2601_WeaponDesc = {
    Text = "偶数ターンのダメージが50％減少し、ダメージが33％アップする。"
  },
  State_2602_Desc = {
    Text = "ロックオンされた！このカードを使用すると、永遠の狂信者が [StateArg1]点の一時的な力を獲得し、このカードの「水底の印」は除去される。"
  },
  State_2602_Name = {
    Text = "<CardKeyWord:汚染：深潜の印>"
  },
  State_2602_WeaponDesc = {
    Text = "カードをプレイすると、深潜者エリートは [StateArg1] 点の一時的な力を獲得します。"
  },
  State_2603_Desc = {
    Text = "手札に「胚胎」が存在する場合、すべての「胚胎」を除外し、「胚胎」1枚につき1回、後続の効果を発動する。"
  },
  State_2603_Name = {
    Text = "<UnlimitedDevouredIconKeywords:無限捕食>"
  },
  State_2604_Desc = {
    Text = "このターン、クリティカル率が[Layer]%増加。"
  },
  State_2604_Name = {
    Text = "一時的なクリティカル率"
  },
  State_2604_WeaponDesc = {
    Text = "このターンのクリティカルレートが [Layer] ％上昇します。"
  },
  State_2605_Desc = {
    Text = "ライフが95%([StateArg1])未満になると、「前衛的な習作」2体に分裂する。"
  },
  State_2605_WeaponDesc = {
    Text = "生命が 30%([StateArg1]) を下回ったとき、「II型融解体ワックス像」にスプリットし、3体の同等の生命を持つ。"
  },
  State_2606_Desc = {
    Text = "ライフが90%([StateArg1])未満になると、「前衛的な習作」2体に分裂する。"
  },
  State_2606_WeaponDesc = {
    Text = "生命が 30%([StateArg1]) を下回ったとき、「II型融解体ワックス像」にスプリットし、3体の同等の生命を持つ。"
  },
  State_2607_Desc = {
    Text = "バトル終了時、5 ライフ回復する。"
  },
  State_2607_Name = {
    Text = "凸月のメイド、啓霊3"
  },
  State_2607_WeaponDesc = {
    Text = "バトル終了時、5 ライフ回復する。"
  },
  State_2609_Desc = {
    Text = "ライフが30%([StateArg1])未満になると、「前衛的な習作」2体に分裂する。"
  },
  State_2609_WeaponDesc = {
    Text = "生命が 30%([StateArg1]) を下回ったとき、「II型融解体ワックス像」にスプリットし、3体の同等の生命を持つ。"
  },
  State_2610_Desc = {
    Text = "ライフが70%([StateArg1])未満になると、「前衛的な習作」2体に分裂する。"
  },
  State_2610_WeaponDesc = {
    Text = "生命が 30%([StateArg1]) を下回ったとき、「II型融解体ワックス像」にスプリットし、3体の同等の生命を持つ。"
  },
  State_2611_Desc = {
    Text = "ライフが50%([StateArg1])未満になると、「前衛的な習作」2体に分裂する。"
  },
  State_2611_WeaponDesc = {
    Text = "生命が 30%([StateArg1]) を下回ったとき、「II型融解体ワックス像」にスプリットし、3体の同等の生命を持つ。"
  },
  State_2612_Desc = {
    Text = "古代者模倣"
  },
  State_2612_Name = {
    Text = "古代者模倣"
  },
  State_2612_WeaponDesc = {
    Text = "古代者模倣"
  },
  State_2614_Desc = {
    Text = "チーム唯一：装備者の指令カードを出した後、<WeaponEffect_Num:[StateArg1]%>の確率でそのカードを捨て札から手札に戻す。この効果は1ターンに1回のみ発動する。"
  },
  State_2614_WeaponDesc = {
    Text = "装備者の指令カードを出した後、<WeaponEffect_Num:[StateArg1]%>の確率でそのカードを捨て札から手札に戻す。この効果は1ターンに1回のみ発動する。"
  },
  State_2617_Desc = {
    Text = "次のターン開始時、追加で[DescArg1]枚のカードを引く。"
  },
  State_2617_Name = {
    Text = "症状：興奮"
  },
  State_2619_Desc = {
    Text = "この戦闘で与えるアクティブダメージが[Layer]減少する。"
  },
  State_2619_Name = {
    Text = "力の減少"
  },
  State_2619_WeaponDesc = {
    Text = "この戦闘で与えるダメージが[Layer]減少する。"
  },
  State_2620_Desc = {
    Text = "遺物錆びた柳葉刀__「開発用」"
  },
  State_2620_Name = {
    Text = "錆びた柳葉刀"
  },
  State_2623_Desc = {
    Text = "ターン開始時に行動力を1獲得。"
  },
  State_2624_Desc = {
    Text = "使用した後、すべての敵から[StateArg1]点の一時的な力を減少させる。"
  },
  State_2624_Name = {
    Text = "<Rune_18:衰弱>"
  },
  State_2625_Desc = {
    Text = "あなたの跳躍効果は2回発動。超次元ターンに入ると、すべての敵が5点の一時的な力を獲得。__「開発用」"
  },
  State_2625_Name = {
    Text = "遺物悪夢の魂灯__「開発用」"
  },
  State_2626_Desc = {
    Text = "触腕の上限が1本減少。ターン終了時に追加ですべての触腕に1回攻撃させる。"
  },
  State_2627_Name = {
    Text = "[StateArg1]キーエネルギーを獲得"
  },
  State_2627_WeaponDesc = {
    Text = "「未完のワックス像」ノードで選択したカードにキーを付与"
  },
  State_2628_Desc = {
    Text = "「未完成の蝋人形」で複製したカードは刻印効果を持つ"
  },
  State_2628_Name = {
    Text = "ステータス@章二_共鳴3"
  },
  State_2628_WeaponDesc = {
    Text = "「未完のワックス像」ノードでコピーされたカードは、刻印効果を得る"
  },
  State_2629_Desc = {
    Text = "「未完成の蝋人形」でコピーできるカードの範囲が増加"
  },
  State_2629_Name = {
    Text = "ステータス@章二_共鳴2"
  },
  State_2629_WeaponDesc = {
    Text = "「未完のワックス像」ノードでコピーされたカードとその本体に「固有」効果を獲得"
  },
  State_2630_Desc = {
    Text = "「未完成の蝋人形」でコピーしたカードとその本体に「保持」効果を付与"
  },
  State_2630_Name = {
    Text = "ステータス@章二_共鳴4"
  },
  State_2630_WeaponDesc = {
    Text = "「未完のワックス像」ノードでコピーされたカードとその本体は「保留」効果を獲得します"
  },
  State_2631_Desc = {
    Text = "「未完成の蝋人形」でカードをもう1枚コピー"
  },
  State_2631_Name = {
    Text = "状態@章二_共鳴6"
  },
  State_2631_WeaponDesc = {
    Text = "「未完のワックス像」ノードでカードを1枚コピーを増やす"
  },
  State_2633_Desc = {
    Text = "アクティブダメージを1回受けるたびに、【緑炎】を1枚手札に加えて「消耗」を付与し、[Layer]ターン持続する。"
  },
  State_2633_Name = {
    Text = "誘蛾の炎"
  },
  State_2633_WeaponDesc = {
    Text = "次のターン開始までの間、攻撃を受けるたびに「緑炎」を1枚手札に追加する。"
  },
  State_2634_Desc = {
    Text = "カード使用時に[StateArg1]ダメージを受け、1点を除去する。点数が0になった時、弱体化した「海中のもの」を1体孵化させる。ターン終了時に寄生状態が残っている場合、点数に応じてライフが増加した「海中のもの」を1体孵化させる。"
  },
  State_2634_Name = {Text = "寄生"},
  State_2635_Desc = {
    Text = "ステータス@序章攻勢の推移标识"
  },
  State_2635_Name = {
    Text = "ステータス@序章攻勢の推移标识"
  },
  State_2635_WeaponDesc = {
    Text = "ステータス@序章攻勢の推移标识"
  },
  State_2636_Name = {
    Text = "ステータス@第四章共鳴@効果発動次ターンのドロー数1"
  },
  State_2637_Desc = {
    Text = "ターン開始時に [StateArg1] 計算力を獲得する。"
  },
  State_2637_Name = {
    Text = "遺物活性注射器__「開発用」"
  },
  State_2637_WeaponDesc = {
    Text = "ターン開始時に [StateArg1] 計算力を獲得する。"
  },
  State_2639_Desc = {
    Text = "戦闘で致命的ダメージを受けた場合、1ライフを保持する可能性がある。発動後、この調査中の死亡抵抗率が半減し、獲得する死亡抵抗も半減する。"
  },
  State_2639_Name = {
    Text = "<DeathResistanceIconKeywords:死亡抵抗>"
  },
  State_2640_Name = {
    Text = "汎用効果重複1回"
  },
  State_2645_Desc = {
    Text = "ステータス@序章モンスターパッシブ1"
  },
  State_2645_Name = {
    Text = "ステータス@序章モンスターパッシブ1"
  },
  State_2645_WeaponDesc = {
    Text = "ステータス@序章モンスターパッシブ1"
  },
  State_2646_Desc = {
    Text = "ステータス@序章（じょしょう）モンスターのパッシブ2"
  },
  State_2646_Name = {
    Text = "ステータス@序章（じょしょう）モンスターのパッシブ2"
  },
  State_2646_WeaponDesc = {
    Text = "ステータス@序章（じょしょう）モンスターのパッシブ2"
  },
  State_2647_Desc = {
    Text = "ステータス@序章モンスターパッシブ3"
  },
  State_2647_Name = {
    Text = "ステータス@序章モンスターパッシブ3"
  },
  State_2647_WeaponDesc = {
    Text = "ステータス@序章モンスターパッシブ3"
  },
  State_2648_Desc = {
    Text = "ステータス@序章モンスターパッシブ4"
  },
  State_2648_Name = {
    Text = "ステータス@序章モンスターパッシブ4"
  },
  State_2648_WeaponDesc = {
    Text = "ステータス@序章モンスターパッシブ4"
  },
  State_2649_Desc = {
    Text = "ステータス@序章モンスター受動 5"
  },
  State_2649_Name = {
    Text = "ステータス@序章モンスター受動 5"
  },
  State_2649_WeaponDesc = {
    Text = "ステータス@序章モンスター受動 5"
  },
  State_2650_Desc = {
    Text = "ステータス@序章モンスター_パッシブ6"
  },
  State_2650_Name = {
    Text = "ステータス@序章モンスター_パッシブ6"
  },
  State_2650_WeaponDesc = {
    Text = "ステータス@序章モンスター_パッシブ6"
  },
  State_2651_Desc = {
    Text = "ステータス@序章モンスターパッシブ7"
  },
  State_2651_Name = {
    Text = "ステータス@序章モンスターパッシブ7"
  },
  State_2651_WeaponDesc = {
    Text = "ステータス@序章モンスターパッシブ7"
  },
  State_2652_Desc = {
    Text = "ステータス@序章モンスターパッシブ8"
  },
  State_2652_Name = {
    Text = "ステータス@序章モンスターパッシブ8"
  },
  State_2652_WeaponDesc = {
    Text = "ステータス@序章モンスターパッシブ8"
  },
  State_2653_Desc = {
    Text = "ステータス@序章モンスターパッシブ9"
  },
  State_2653_Name = {
    Text = "ステータス@序章モンスターパッシブ9"
  },
  State_2653_WeaponDesc = {
    Text = "ステータス@序章モンスターパッシブ9"
  },
  State_2655_Desc = {
    Text = "ブロックされなかったダメージを与えた時、同量のライフを回復。ダメージを与えると解除される。"
  },
  State_2656_Desc = {
    Text = "次のターン開始時に逃げる！！！！！！"
  },
  State_2656_Name = {Text = "逃走"},
  State_2660_Desc = {
    Text = "戦闘開始時、力を獲得。が、受けるダメージが5増加する。__「開発用」"
  },
  State_2661_Desc = {
    Text = "バトル開始時、すべての敵が [Arg1] ポイント分のパワーを失う。"
  },
  State_2662_Name = {
    Text = "状態@第三章_テスト状態"
  },
  State_2663_Desc = {
    Text = "抽到時に自身に弱り状態を1ターン与える。使用後、すべての敵に弱り状態を1ターン与える。売却不可。"
  },
  State_2663_Name = {
    Text = "状態呪い衰弱"
  },
  State_2663_WeaponDesc = {
    Text = "抽到時に自身に弱り状態を1ターン与える。使用後、すべての敵に弱り状態を1ターン与える。売却不可。"
  },
  State_2666_Name = {
    Text = "輪回ダガークリティカル率"
  },
  State_2667_Desc = {
    Text = "攻撃カードのダメージが[Layer]%増加する。"
  },
  State_2667_Name = {
    Text = "攻撃カードダメージ増加"
  },
  State_2667_WeaponDesc = {
    Text = "打撃牌のダメージが [Layer] ％ 上昇します。"
  },
  State_2668_Desc = {
    Text = "[Layer]％の攻撃力を上昇させる。"
  },
  State_2668_Name = {
    Text = "汎用永久攻撃力％増加"
  },
  State_2668_WeaponDesc = {
    Text = "[Layer]％の攻撃力を上昇させる。"
  },
  State_2669_Desc = {
    Text = "この戦闘内でクリティカルダメージが[Layer] %増加。"
  },
  State_2669_Name = {
    Text = "クリティカルダメージ"
  },
  State_2670_Desc = {
    Text = "虚弱を引き起こすと[Arg1]シールドを獲得。易傷を引き起こすと[Arg2]力量を獲得。1ターン内に両方を引き起こすと追加で[Arg1]シールドと[Arg2]力量を獲得。"
  },
  State_2670_Name = {
    Text = "重い額縁"
  },
  State_2671_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_2671_Name = {Text = "未覚醒"},
  State_2672_Desc = {
    Text = "毎ターン開始時、味方チームに【拘束】状態を付与する。"
  },
  State_2672_Name = {Text = "束縛"},
  State_2672_WeaponDesc = {
    Text = "毎ターン開始時、味方チームに【拘束】状態を付与する。"
  },
  State_2674_Desc = {
    Text = "このターンのクリティカルレートが [Layer] ％上昇します。"
  },
  State_2674_Name = {
    Text = "一時的なクリティカル率"
  },
  State_2676_Name = {
    Text = "「密約」深紅の鼓動"
  },
  State_2676_WeaponDesc = {
    Text = "キーの解放後、装備者は15％の臨時クリティカルレートを獲得する。装備者の現在のクリティカルダメージが80％より大きい場合、さらに15％の追加の臨時クリティカルレートを獲得する。"
  },
  State_2677_Desc = {
    Text = "毎ターン最初の3回、能動的な/タッチアームからのダメージが75%減少する。"
  },
  State_2677_Name = {
    Text = "「不滅の残躯」"
  },
  State_2677_WeaponDesc = {
    Text = "毎ターン最初の3回、能動的な/タッチアームからのダメージが75%減少する。"
  },
  State_2679_Name = {
    Text = "状態@第三章_共鳴7_マーク"
  },
  State_2680_Desc = {
    Text = "クリティカル率が20%増加。ターン開始時にライフが25%未満の場合、そのターンは必ずクリティカルヒットする。"
  },
  State_2681_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_2681_Name = {Text = "未覚醒"},
  State_2682_Desc = {
    Text = "シールドと治療効果が50％強力に上昇する。"
  },
  State_2682_Name = {
    Text = "異化花園の守護者"
  },
  State_2682_WeaponDesc = {
    Text = "シールドと治療効果が50％強力に上昇する。"
  },
  State_2683_Desc = {
    Text = "ステータス層数分のカードを引く。"
  },
  State_2683_Name = {Text = "ドロー"},
  State_2684_Desc = {
    Text = "チーム唯一：装備者の「打撃」が<WeaponEffect_Num:[StateArg1]%>の確率で1算力を獲得し、すべての敵の10％の<IntoxicationIconKeywords:毒>を発動する。現在の界域が「深海」の場合、この効果発動時に触腕1本が1回攻撃する。この効果は1ターンに1回のみ発動する。"
  },
  State_2684_WeaponDesc = {
    Text = "装備者の「打撃」が<WeaponEffect_Num:[StateArg1]%>の確率で1算力を獲得し、すべての敵の[DescArg1]％の<IntoxicationIconKeywords:毒>を発動する。現在の界域が「深海」の場合、この効果発動時に触腕1本が1回攻撃する。この効果は毎ターン最大1回発動する。"
  },
  State_2685_Desc = {
    Text = "倦怠、抑圧、軟化状態を無効化、ターン終了後に1点解除。"
  },
  State_2685_Name = {
    Text = "<BlessingIconKeywords:祝福>"
  },
  State_2685_WeaponDesc = {
    Text = "このターン内、自分に与えられるネガティブステータスを無効化する。"
  },
  State_2686_Desc = {
    Text = "戦闘中に与えられる一時的なカード。"
  },
  State_2686_Name = {
    Text = "<CardKeyWord:ステータスカード>"
  },
  State_2687_Desc = {
    Text = "このターン内クリティカルレートが100％上昇する"
  },
  State_2687_Name = {
    Text = "一時的な必中"
  },
  State_2687_WeaponDesc = {
    Text = "このターン内クリティカルレートが100％上昇する"
  },
  State_2688_Desc = {
    Text = "各ターンで3枚目のカードを使用すると「啓示」を捨て札に追加。6枚目のカードを使用すると、捨て札から1枚の「啓示」を手札に追加。"
  },
  State_2689_Desc = {
    Text = "ターン開始時に2枚のカードを引く。超次元カードスロットの容量が2増加する。"
  },
  State_2689_Name = {
    Text = "遺物奇術師の帽子__「開発用」"
  },
  State_2689_WeaponDesc = {
    Text = "ターン開始時に2枚のカードを引く。超次元カードスロットの容量が2増加する。"
  },
  State_2690_Desc = {
    Text = "「美德の騎士」がカードを使用した後、[StateArg1]点の力を獲得。"
  },
  State_2690_Name = {
    Text = "騎士の熱意"
  },
  State_2691_Desc = {
    Text = "チーム唯一：装備者が狂気爆発を発動した後、 <WeaponEffect_Num:[StateArg1]> ポイントの狂気と <WeaponEffect_Num:[StateArg2]> ポイントの銀鍵エネルギーを獲得する。手札4枚ごとに1回繰り返す。現在の界域が「超次元」の場合、装備者のカードが超次元空間に入った後、装備者の攻撃力の <WeaponEffect_Num:[StateArg3]%> に相当する一時的な力を獲得する。毎ターン最大2回まで発動する。"
  },
  State_2691_WeaponDesc = {
    Text = "装備者が狂気爆発を発動した後、 <WeaponEffect_Num:[StateArg1]> ポイントの狂気と <WeaponEffect_Num:[StateArg2]> ポイントの銀鍵エネルギーを獲得する。手札4枚ごとに1回繰り返す。現在の界域が「超次元」の場合、装備者のカードが超次元空間に入った後、 <WeaponEffect_Num:[Power:DescArg1]> ポイントの一時的な力を獲得する。毎ターン最大2回まで発動する。"
  },
  State_2693_Desc = {
    Text = "ステータス@序章狂気0＿1＿2効果"
  },
  State_2693_Name = {
    Text = "ステータス@序章狂気0＿1＿2効果"
  },
  State_2693_WeaponDesc = {
    Text = "ステータス@序章狂気0＿1＿2効果"
  },
  State_2694_Desc = {
    Text = "1つのブラックスタンプを消費するたびに、すべての覚醒体が1狂気を獲得する"
  },
  State_2694_Name = {
    Text = "遺物逆生花状態"
  },
  State_2694_WeaponDesc = {
    Text = "1つのブラックスタンプを消費するたびに、すべての覚醒体が1狂気を獲得する"
  },
  State_2695_Desc = {
    Text = "覚醒体のカードが超次元空間に入ると、対応する覚醒体が15狂気を獲得。"
  },
  State_2696_Desc = {
    Text = "ステータス@序章狂気0＿1＿2発動"
  },
  State_2696_Name = {
    Text = "ステータス@序章狂気0＿1＿2発動"
  },
  State_2696_WeaponDesc = {
    Text = "ステータス@序章狂気0＿1＿2発動"
  },
  State_2698_Name = {
    Text = "次のターン開始時に行動力+1"
  },
  State_2699_Name = {
    Text = "次のターン開始時に行動力+2"
  },
  State_2701_Desc = {
    Text = "深海の淑女がシールドを獲得したとき、[StateArg1] の一時的な触手ダメージが上昇します。"
  },
  State_2701_Name = {
    Text = "造られし物"
  },
  State_2701_WeaponDesc = {
    Text = "深海の淑女がシールドを獲得したとき、[StateArg1] の一時的な触手ダメージが上昇します。"
  },
  State_2702_Desc = {
    Text = "拾得時、100%の死亡抵抗を獲得。死亡抵抗が発動後、戦闘中の各ターン開始時に[Arg1]のライフを回復。"
  },
  State_2703_Desc = {
    Text = "ターン中に最初に使用した覚醒体カードの一時的なコピーが次元の裂け目に入り、危険な時に自分を守るために使える！"
  },
  State_2703_Name = {
    Text = "次元の裂け目"
  },
  State_2705_Desc = {Text = "――"},
  State_2705_Name = {
    Text = "復讐宣言"
  },
  State_2705_WeaponDesc = {Text = "――"},
  State_2706_Desc = {
    Text = "徐々に石ころ変化"
  },
  State_2706_Name = {
    Text = "徐々に石ころ変化"
  },
  State_2706_WeaponDesc = {
    Text = "徐々に石化検知"
  },
  State_2707_Desc = {
    Text = "今ターン内にタッチアームで全敵を攻撃"
  },
  State_2707_Name = {
    Text = "触腕全体攻撃"
  },
  State_2707_WeaponDesc = {
    Text = "今ターン内にタッチアームで全敵を攻撃"
  },
  State_2708_Desc = {
    Text = "触腕上限が1増加します。ライフが50％未満の場合、触手ダメージが[StateArg1]ポイントアップします。"
  },
  State_2708_Name = {
    Text = "異化古の供物"
  },
  State_2708_WeaponDesc = {
    Text = "触腕上限が1増加します。ライフが50％未満の場合、触手ダメージが[StateArg1]ポイントアップします。"
  },
  State_2709_Desc = {
    Text = "遺物錆びた柳葉刀カウント__「開発用」"
  },
  State_2710_Desc = {
    Text = "インプリント"
  },
  State_2710_Name = {
    Text = "インプリント"
  },
  State_2710_WeaponDesc = {
    Text = "インプリント"
  },
  State_2711_Desc = {
    Text = "一時的にカードの行動力を変更"
  },
  State_2711_Name = {
    Text = "一時的にカードの行動力を変更"
  },
  State_2711_WeaponDesc = {
    Text = "一時的にカードの行動力を変更"
  },
  State_2712_Desc = {
    Text = "獲得するシールドを増加させる。"
  },
  State_2712_Name = {
    Text = "<AlertIconKeywords:警戒>"
  },
  State_2712_WeaponDesc = {
    Text = "獲得するシールド増加。"
  },
  State_2713_Desc = {
    Text = "復讐の大剣は毎ターン力を獲得。"
  },
  State_2713_Name = {
    Text = "復讐の大剣覚醒"
  },
  State_2713_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_2715_Desc = {
    Text = "このステージで獲得するシールドが[Layer]点増加。"
  },
  State_2715_Name = {
    Text = "永続の警戒"
  },
  State_2715_WeaponDesc = {
    Text = "このステージで獲得するシールドが[Layer]点増加。"
  },
  State_2718_Desc = {
    Text = "チーム唯一：ターン終了時、装備者は<WeaponEffect_Num:[StateArg1]>狂気を獲得し、装備者のキーチャージと同等のキーエネルギーを獲得する。"
  },
  State_2718_WeaponDesc = {
    Text = "ターン終了時、装備者は<WeaponEffect_Num:[StateArg1]>狂気を獲得し、装備者のキーチャージと同等のキーエネルギーを獲得する。"
  },
  State_2720_Desc = {
    Text = "実ダメージを与えると、狂気が最も高い覚醒体の狂気を10減少させる。"
  },
  State_2720_Name = {Text = "虚無"},
  State_2720_WeaponDesc = {
    Text = "実際のダメージを与えたとき、狂気が最も高い覚醒体の狂気を10減らす。"
  },
  State_2721_Name = {
    Text = "状態@ステージ2_9戦闘5バブル1"
  },
  State_2722_Desc = {
    Text = "使用した後、「霊感」を[StateArg1]枚山札に加えてシャッフルする。「霊感」：算力を1獲得し、1枚ドローする。保留、消耗。"
  },
  State_2722_Name = {
    Text = "<Rune_17_High:上位啓示>"
  },
  State_2723_Desc = {
    Text = "使用後、すべての敵に[StateArg1]点の易傷を付与する。"
  },
  State_2723_Name = {
    Text = "<Rune_1_High:上位易傷>"
  },
  State_2724_Desc = {
    Text = "攻撃回数が1増加。"
  },
  State_2724_Name = {
    Text = "夢の核反撃"
  },
  State_2726_Desc = {
    Text = "使用した後、すべての敵に[StateArg1]層の毒を付与し、すべての敵の毒を[StateArg2]%発動する。"
  },
  State_2726_Name = {
    Text = "<Rune_10_High:上位毒素>"
  },
  State_2727_Desc = {
    Text = "死亡直前に、1のライフを回復し、この状態を解除。"
  },
  State_2727_WeaponDesc = {
    Text = "瀕死状態のとき、1のライフを返信し、そのステータスを解除する。"
  },
  State_2728_Desc = {
    Text = "ターン開始時に他の味方が1体いるごとに1点の<ParcloseIconKeywords:バリア>を獲得。"
  },
  State_2728_Name = {
    Text = "リンク障壁"
  },
  State_2728_WeaponDesc = {
    Text = "ターン開始時に他の味方が1体いるごとに、最大ライフの [Layer]%のシールドを獲得する。"
  },
  State_2729_Desc = {
    Text = "発動時に、対応する覚醒体の1枚のカードを引く。"
  },
  State_2729_Name = {
    Text = "異化空間屈折装置ドロー"
  },
  State_2729_WeaponDesc = {
    Text = "発動時に、対応する覚醒体の1枚のカードを引く。"
  },
  State_2730_Desc = {
    Text = "自身死亡後、ヒドラは「万蛇操使」状態を1点減少させる。"
  },
  State_2732_Desc = {
    Text = "ステータス@序章狂気初期化0＿2＿3"
  },
  State_2732_Name = {
    Text = "ステータス@序章狂気初期化0＿2＿3"
  },
  State_2732_WeaponDesc = {
    Text = "ステータス@序章狂気初期化0＿2＿3"
  },
  State_2734_Name = {
    Text = "次のターン開始時にドロー枚数+1"
  },
  State_2735_Desc = {
    Text = "このカードを使用した後に「次元転送」が発動した場合、または現在が超次元ターンの場合、後続の効果を発動できる。"
  },
  State_2735_Name = {
    Text = "<TransitionIconKeywords:跳躍>"
  },
  State_2735_WeaponDesc = {
    Text = "もし現在が超次元ターンであれば、ワープ効果を発動できます。"
  },
  State_2737_Desc = {
    Text = "デッキがリセットされると、[Layer]の力を獲得。"
  },
  State_2737_Name = {
    Text = "永遠に凝結"
  },
  State_2738_Name = {
    Text = "倦怠効果アップ"
  },
  State_2740_Desc = {
    Text = "「未完成の蝋人形」でコピーしたカードとその本体の行動力消費が-1、症状カードを1枚獲得"
  },
  State_2740_Name = {
    Text = "状態@章二_共鳴5_2"
  },
  State_2740_WeaponDesc = {
    Text = "「未完のワックス像」ノードでコピーされたカードとその本体の計算力消費-1"
  },
  State_2741_Desc = {
    Text = "「未完成の蝋人形」でコピーしたカードとその本体の行動力消費が-1、症状カードを1枚獲得"
  },
  State_2741_Name = {
    Text = "ステータス@章二_共鳴5_1"
  },
  State_2741_WeaponDesc = {
    Text = "「未完のワックス像」ノードでコピーされたカードとその本体の計算力消費-1"
  },
  State_2742_Desc = {
    Text = "ディッパーガイが 1 回ダメージを与えるたびに、[StateArg2] の一時的な力を得て、1 回シールドを得るたびに、[StateArg3] の一時警戒を得る。"
  },
  State_2742_Name = {
    Text = "変数の最適化"
  },
  State_2744_Desc = {
    Text = "覚醒体のカードが超次元空間に入った後、それに15の狂気を獲得する。"
  },
  State_2744_Name = {
    Text = "遺物跳躍装置"
  },
  State_2744_WeaponDesc = {
    Text = "覚醒体のカードが超次元空間に入った後、それに15の狂気を獲得する。"
  },
  State_2746_Desc = {
    Text = "攻撃回数+1、[Layer]の力を失う。"
  },
  State_2746_Name = {Text = "焦燥"},
  State_2747_Desc = {
    Text = "使用した後、他の覚醒体が[StateArg1]狂気を獲得する。"
  },
  State_2747_Name = {
    Text = "<Rune_16:触媒>"
  },
  State_2748_Desc = {
    Text = "ステータス@提灯の儀式"
  },
  State_2748_Name = {
    Text = "ステータス@提灯の儀式"
  },
  State_2748_WeaponDesc = {
    Text = "ステータス@提灯の儀式"
  },
  State_2749_Desc = {
    Text = "このターン内に触手ダメージを与え、ターゲットに[Layer]層のポイズンを付与する。"
  },
  State_2749_Name = {
    Text = "深淵の暗流"
  },
  State_2750_Desc = {
    Text = "私と共に大海に沈みましょう……"
  },
  State_2750_Name = {
    Text = "ニムフィーア覚醒"
  },
  State_2752_Desc = {
    Text = "スイレンがダメージを与える時、[StateArg2] 狂気を獲得する。"
  },
  State_2752_Name = {
    Text = "苦海に沈む"
  },
  State_2752_WeaponDesc = {
    Text = "スイレンがダメージを与える時、[StateArg2] 狂気を獲得する。"
  },
  State_2753_Desc = {
    Text = "ターン開始時にライフが[Arg1]以上の場合、[Arg1]のライフを失い、そのターン内に[Arg2]の力と[Arg3]の警戒を獲得。"
  },
  State_2754_Name = {
    Text = "状態@一時的な攻撃カードクリティカル率アップ"
  },
  State_2757_Desc = {
    Text = "次のターン開始時、追加で[DescArg1]点の行動力を獲得。"
  },
  State_2757_Name = {
    Text = "症状：疑心"
  },
  State_2758_Desc = {
    Text = "君のすべてのライフ回復効果が[Arg1]増加し、超過回復したライフは同量のシールドに変換される。"
  },
  State_2758_Name = {
    Text = "蝶の標本"
  },
  State_2760_Desc = {
    Text = "每当1つの覚醒体が1回呑み込むと、他の覚醒体は10の狂気を獲得する。"
  },
  State_2762_Desc = {
    Text = "使用した後、追加で[StateArg1]回発動する。[StateArg2]点の黒印を獲得する。消耗、固有。"
  },
  State_2762_Name = {
    Text = "<Rune_7_High:上位回声>"
  },
  State_2762_WeaponDesc = {
    Text = "打出后追加効果 [StateArg1] 回、消費。"
  },
  State_2763_Desc = {
    Text = "眠れる主が 1 計算力を消費するたびに、[StateArg1] 触手ダメージを上昇します。"
  },
  State_2763_Name = {
    Text = "不朽の威厳"
  },
  State_2763_WeaponDesc = {
    Text = "眠れる主が 1 計算力を消費するたびに、[StateArg1] 触手ダメージを上昇します。"
  },
  State_2764_Desc = {
    Text = "ガードされなかったダメージを与えた時、[StateArg1]点の出血を付与する。"
  },
  State_2764_Name = {
    Text = "悪意の出血"
  },
  State_2765_Name = {
    Text = "状態@ジョージ@死亡時治癒"
  },
  State_2767_Name = {
    Text = "ステータス@ブラックスタンプとシルバーキー充電効率"
  },
  State_2769_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_2769_Name = {Text = "未覚醒"},
  State_2771_Desc = {
    Text = "敵の力__「開発用」"
  },
  State_2771_Name = {
    Text = "敵の力__「開発用」"
  },
  State_2772_Name = {
    Text = "状態@ステージ2_5戦闘3バブル1"
  },
  State_2773_Desc = {
    Text = "戦闘開始時に、1枚の「美しい瞬間 – 手札のすべての覚醒体カードを」攻撃「に変換し、ターン終了まで維持。保持、除外」を手札に追加。"
  },
  State_2775_Desc = {
    Text = "ドロー枚数に戻る"
  },
  State_2775_Name = {
    Text = "ドロー枚数リセット"
  },
  State_2776_Name = {
    Text = "石の目停滞呪詛強化"
  },
  State_2777_Name = {
    Text = "状態@第三章_空状態"
  },
  State_2778_Desc = {
    Text = "戦闘開始時に[Arg1]シールドを獲得。この戦闘中に「防御」を7回使用すると、即座に[Arg2]シールドを獲得。"
  },
  State_2778_Name = {
    Text = "パトニー・モーニング・ポスト"
  },
  State_2779_Desc = {
    Text = "ライフが50%([StateArg1])未満になると、「干渉型融蝕生物」3体に分裂する。"
  },
  State_2779_WeaponDesc = {
    Text = "ライフが 50%([StateArg1]) を下回ったとき、「II型融食体」にスプリットし、2体に同じ量のライフを持つ。"
  },
  State_2780_Desc = {
    Text = "打出後獲得 [StateArg1] 点計算力。"
  },
  State_2780_Name = {
    Text = "<Rune_4:策謀>"
  },
  State_2781_Desc = {
    Text = "[Layer]枚のカードを使用するたび、バリアがなければ<ParcloseIconKeywords:バリア>を追加。"
  },
  State_2781_Name = {
    Text = "チャージバリア"
  },
  State_2781_WeaponDesc = {
    Text = "味方のチームが [Layer] 枚のカードを出すたびに、モンスターは1層のバリアをリフレッシュする"
  },
  State_2784_Desc = {
    Text = "超次元ターンでなくても、毎ターン1回跳躍効果を発動できる。超次元空間の容量が2増加。"
  },
  State_2785_Desc = {
    Text = "チーム唯一：装備者がカードを出した後、装備者は1ポイントの狂気を獲得する。戦闘開始時、装備者の攻撃力の<WeaponEffect_Num:[StateArg1]%>に相当する<PowerIconKeywords:力量>を獲得する。現在の界域が「深海」の場合、<WeaponEffect_Num:[StateArg2]%>の<CardKeyWord:触腕ダメージ>を追加獲得する。以降の各ターン開始後、装備者の攻撃力の<WeaponEffect_Num:[StateArg3]%>に相当する<PowerIconKeywords:力量>を獲得する。現在の界域が「深海」の場合、<WeaponEffect_Num:[StateArg4]%>の<CardKeyWord:触腕ダメージ>を追加獲得する。"
  },
  State_2785_WeaponDesc = {
    Text = "装備者がカードを出した後、装備者は1ポイントの狂気を獲得する。戦闘開始時、<WeaponEffect_Num:[Power:DescArg1]>ポイントの<PowerIconKeywords:力量>を獲得する。現在の界域が「深海」の場合、<WeaponEffect_Num:[DescArg2]>ポイントの<CardKeyWord:触腕ダメージ>を追加獲得する。以降の各ターン開始後、<WeaponEffect_Num:[Power:DescArg3]>ポイントの<PowerIconKeywords:力量>を獲得する。現在の界域が「深海」の場合、<WeaponEffect_Num:[DescArg4]>ポイントの<CardKeyWord:触腕ダメージ>を追加獲得する。"
  },
  State_2786_Name = {
    Text = "遺物血染めの小石カウント"
  },
  State_2787_Desc = {
    Text = "ライフを回復し、「虚無終結」を1枚捨て札に追加する。永続、消滅。"
  },
  State_2787_Name = {
    Text = "<CardKeyWord:真理探求>"
  },
  State_2787_WeaponDesc = {
    Text = "ライフを回復し、1枚の【虚無終結】を捨て札の山に加える。永続、破壊。"
  },
  State_2788_Desc = {
    Text = "ターン開始時に [StateArg1] 枚 の カードを引く。"
  },
  State_2788_Name = {
    Text = "遺物予言者のランプ1__「開発用」"
  },
  State_2788_WeaponDesc = {
    Text = "ターン開始時に [StateArg1] 枚 の カードを引く。"
  },
  State_2789_Desc = {
    Text = "カードはジェンキンに細工された！発射後に[Layer]点の<FixedDamage:純粋ダメージ>を受ける。"
  },
  State_2789_Name = {
    Text = "<CardKeyWord:使用後、[Layer] ダメージを受ける>"
  },
  State_2789_WeaponDesc = {
    Text = "カードをプレイした後、[StateArg1] 点のダメージを受けます。"
  },
  State_2790_Desc = {
    Text = "ターン終了時に [StateArg1] 枚の手札を持ち越すことができます。"
  },
  State_2790_Name = {
    Text = "遺物予言者のランプ2__「開発用」"
  },
  State_2790_WeaponDesc = {
    Text = "ターン終了時に [StateArg1] 枚の手札を持ち越すことができます。"
  },
  State_2792_Desc = {
    Text = "戦闘開始時、すべての味方に3点の【蝋質の鎧】を付与。ターン開始時、1枚の「痙攣」を味方の山札に追加する。"
  },
  State_2792_Name = {
    Text = "「蝋の淑女」"
  },
  State_2792_WeaponDesc = {
    Text = "バトル開始時、味方全員が 3 層の【ロウ質の鎧】を獲得する。ターン開始時、自分のチームのドロー山に「けいれん」を1枚追加する。"
  },
  State_2793_Desc = {
    Text = "ステータス@石の目死の淵での抵抗"
  },
  State_2793_Name = {
    Text = "ステータス@石の目死の淵での抵抗"
  },
  State_2793_WeaponDesc = {
    Text = "ステータス@石の目死の淵での抵抗"
  },
  State_2796_Desc = {
    Text = "ライフを失うたびに、すべての敵に[Arg1]回の毒を付与。毎ターン毒値+[Arg2]"
  },
  State_2797_Desc = {
    Text = "ターン開始時、このターン中に[Arg1]警戒を獲得する「日傘」を1枚手札に追加。カードを6枚使用すると、手札のすべての「日傘」の警戒が[Arg2]増加する。"
  },
  State_2798_Desc = {
    Text = "仁愛の主祭がシールドを付与した時、1枚のランダムな手札の計算力消費が-1になる（それを打つまで）。"
  },
  State_2798_Name = {
    Text = "父の慈悲"
  },
  State_2798_WeaponDesc = {
    Text = "仁愛の主祭がシールドを付与した時、1枚のランダムな手札の計算力消費が-1になる（それを打つまで）。"
  },
  State_2799_Desc = {
    Text = "揺蕩うクラゲがアクティブダメージを与えた時、[StateArg1]本の触手がそのターゲットを攻撃する。"
  },
  State_2799_Name = {
    Text = "自己増殖"
  },
  State_2799_WeaponDesc = {
    Text = "海月がダメージを与えるとき、[StateArg1] 本のタッチアームでそのターゲットを攻撃する。"
  },
  State_2800_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_2800_Name = {
    Text = "状態@試作小刀クリティカルダメージ"
  },
  State_2801_Desc = {
    Text = "ダメージを受けたとき、深層融食の層数が上昇"
  },
  State_2801_Name = {
    Text = "ダメージを受けると融蝕深度の点数が増加する__「開発用」"
  },
  State_2801_WeaponDesc = {
    Text = "ダメージを受けたとき、深層融食の層数が上昇"
  },
  State_2802_Desc = {
    Text = "ターン開始時、一時的な力を増加"
  },
  State_2802_Name = {
    Text = "一時的な力を追加"
  },
  State_2804_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_2804_Name = {
    Text = "状態@試作レーザー砲クリティカルダメージ"
  },
  State_2805_Desc = {
    Text = "ターン終了時、他の味方が力を獲得__「開発用」"
  },
  State_2805_Name = {
    Text = "「暁の火」"
  },
  State_2807_Desc = {
    Text = "ターン開始時、このターン中に[Arg1]警戒を獲得する「日傘」を1枚手札に追加。カードを6枚使用すると、手札のすべての「日傘」の警戒が[Arg2]増加する。"
  },
  State_2808_Desc = {
    Text = "ターン終了時に 1 個の胚融合度が生成される。手札に胎児がある場合、15 のライフを回復する。"
  },
  State_2808_Name = {
    Text = "異化止血鉗子"
  },
  State_2808_WeaponDesc = {
    Text = "ターン終了時に 1 個の胚融合度が生成される。手札に胎児がある場合、15 のライフを回復する。"
  },
  State_2809_Desc = {
    Text = "拾取時、永久に [Arg1] のパワーを失う。ダメージを与えるたびに、[Arg2] ポイントのライフを返信し、ターンごとに最大 6 回まで発動可能。"
  },
  State_2809_Name = {
    Text = "ヤツメウナギの口づけ"
  },
  State_2810_Desc = {
    Text = "ターン終了時、最大ライフ値の[Layer]%を回復。"
  },
  State_2810_Name = {
    Text = "自己治癒"
  },
  State_2810_WeaponDesc = {
    Text = "モンスターのターン終了時、最大ライフの[Layer]％を回復する"
  },
  State_2811_Desc = {
    Text = "症状カードを引く時、[Arg1]の力を獲得。呪いの刻印や呪われた遺物が1つあるごとに、クリティカル率とクリティカルダメージが10％増加する。"
  },
  State_2812_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_2812_Name = {Text = "未覚醒"},
  State_2813_Desc = {
    Text = "ターン開始時に行動力を失う"
  },
  State_2813_Name = {
    Text = "計算ミス！"
  },
  State_2814_Desc = {
    Text = "戦闘勝利時に得た刻印が強力で危険な呪いの刻印に変わります。"
  },
  State_2817_Desc = {
    Text = "1点につき受けるダメージを[StateArg1]減少する。クリティカルを受けるたびに1点減少。"
  },
  State_2817_Name = {
    Text = "蝋質の鎧"
  },
  State_2817_WeaponDesc = {
    Text = "異常状態に免疫、クリティカル被弾後に移除。"
  },
  State_2818_Desc = {
    Text = "融蝕トライアングル小と融蝕トライアングル小Bに分裂する。"
  },
  State_2818_WeaponDesc = {
    Text = "スプリットが融食三角小と融食三角小Bに分かれる。"
  },
  State_2820_Desc = {
    Text = "使用した後、[StateArg1]点の一時的な力を獲得し、この刻印カードにも力のボーナスが適用される。"
  },
  State_2820_Name = {
    Text = "<Rune_15:爆発>"
  },
  State_2821_Name = {
    Text = "一時的な軟化無効化"
  },
  State_2823_Desc = {
    Text = "チームユニーク：戦闘開始時に前列の敵に 2 層の<VulnerabilityIconKeywords:易傷>を付与する。ターン開始時、易傷状態の敵は装備者の攻撃力の <WeaponEffect_Num:[StateArg1]%> 分の一時的な<PowerIconKeywords:力>を失う。現在の界域が「血肉」の場合、装備者が「狂気解放」を発動した後、胚胎融合 +<WeaponEffect_Num:[Blood:StateArg2]>。"
  },
  State_2823_WeaponDesc = {
    Text = "戦闘開始時、前列の敵に 2 層の<VulnerabilityIconKeywords:易傷>を付与する。ターン開始時、易傷状態の敵は <WeaponEffect_Num:[Power:DescArg1]> 点の一時的な<PowerIconKeywords:力>を失う。現在の界域が「血肉」の場合、装備者が「狂気解放」を発動した後、胚胎融合 +<WeaponEffect_Num:[Blood:StateArg2]>。"
  },
  State_2825_Desc = {
    Text = "敵超次元スロット上限"
  },
  State_2825_Name = {
    Text = "敵超次元スロット上限"
  },
  State_2825_WeaponDesc = {
    Text = "モンスター超次元カードスロット上限"
  },
  State_2826_Desc = {
    Text = "連続2回、前のカードより行動力消費が低いカードを使用すると、現在狂気が最も低い覚醒体が50狂気を獲得。"
  },
  State_2826_Name = {
    Text = "遺物アルカナ遺物"
  },
  State_2827_Desc = {
    Text = "ダメージ回数とダメージが増加。"
  },
  State_2827_Name = {
    Text = "<CardKeyWord:アップグレード>"
  },
  State_2829_Desc = {
    Text = "実際のダメージを与えると、[Layer]力を獲得。"
  },
  State_2829_Name = {
    Text = "「混乱人格」"
  },
  State_2830_Desc = {
    Text = "パーティーに【深海】職の覚醒体が1名いるごとに、全隊の最大ライフ(未完了)、防御、攻撃が50%上昇"
  },
  State_2830_Name = {
    Text = "深海ボーナス"
  },
  State_2830_WeaponDesc = {
    Text = "パーティーに【深海】職の覚醒体が1名いるごとに、全隊の最大ライフ(未完了)、防御、攻撃が50%上昇"
  },
  State_2832_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_2832_Name = {
    Text = "状態@試作レーザー砲死亡抵抗"
  },
  State_2833_Desc = {
    Text = "ターン開始時に1枚のカードを引く。あなたが1枚のカードを引くたびに、そのカードの計算力消費がランダムで変化する(0-4)。"
  },
  State_2835_Desc = {
    Text = "<DevouredIconKeywords:捕食>を1回行うたびに、すべての敵から[Arg1]の一時的な力を奪う。"
  },
  State_2836_Name = {
    Text = "状態@呪い盲従"
  },
  State_2837_Name = {
    Text = "状態@呪い盲従"
  },
  State_2838_Name = {
    Text = "状態@呪い盲従"
  },
  State_2840_Desc = {
    Text = "ターン終了後、[Layer] 点の<FixedDamage:純粋ダメージ>を受け、[DescArg1]% のスタック数を除去する。ライフ回復時、回復量の2倍の出血スタック数を除去する。"
  },
  State_2840_Name = {
    Text = "<BleedingColour:出血>"
  },
  State_2840_WeaponDesc = {
    Text = "ターン終了時、[Layer]ポイントのダメージを受け、その状態が解除される。回復毎に層数が半分になる。"
  },
  State_2842_Desc = {
    Text = "発射後[StateArg1]点のカウンターを獲得し、すべての敵にカウンターの[StateArg2]%の<FixedDamage:純粋ダメージ>を与える。"
  },
  State_2842_Name = {
    Text = "<Rune_9:反撃>"
  },
  State_2843_Desc = {
    Text = "味方チームがカードを1枚使用するたびに[StateArg1]回のシールドを獲得。1ターン持続。"
  },
  State_2843_Name = {
    Text = "羽が舞う"
  },
  State_2843_WeaponDesc = {
    Text = "味方のチームが 1 枚のカードを出すたびに、[StateArg1] 層のシールドを獲得する。1 ターン持続。"
  },
  State_2844_Desc = {
    Text = "各戦闘で初めてライフを失った時、1回分のダメージを免疫するバリアを獲得する。"
  },
  State_2845_Name = {
    Text = "「密約」墓地の囁き"
  },
  State_2845_WeaponDesc = {
    Text = "ステージ開始時にデスレジスタンスが 25% 上昇する。デスレジスタンスが発動した後、装備者が 50 ポイントの狂気を得る。"
  },
  State_2846_Desc = {
    Text = "死亡を1回無効化し、発動後[Arg1]のライフを回復、その後この造物を永久に無効にする。"
  },
  State_2846_Name = {
    Text = "身代わり人形"
  },
  State_2847_Desc = {
    Text = "「狩猟目標」の覚醒体がカードを1枚使用するたび「狩猟の印」を1層追加し、「狩猟の印」の層数の半分のカードを引く。"
  },
  State_2847_Name = {
    Text = "狩猟の儀式"
  },
  State_2849_Desc = {
    Text = "毎回ライフを失うと、[Arg1] ポイントのパワーを得る。最大で 10 層までスタックする。スタックが最大になった時、失ったライフの 25％ を返信する。"
  },
  State_2849_Name = {
    Text = "無上の栄誉"
  },
  State_2853_Desc = {
    Text = "遺物安楽椅子カウント__「開発用」"
  },
  State_2854_Desc = {
    Text = "死後、覚醒体に狂気を提供しません。"
  },
  State_2854_Name = {Text = "利己的"},
  State_2854_WeaponDesc = {
    Text = "死亡後、覚醒体に狂気を提供しない。"
  },
  State_2855_Desc = {
    Text = "打撃カードのダメージが[StateArg1]％増加。[Layer] ターン持続。"
  },
  State_2855_Name = {
    Text = "絶望からの生還·打撃"
  },
  State_2855_WeaponDesc = {
    Text = "このターン、あなたのストライクカードのダメージが [Layer]％ アップします。"
  },
  State_2856_Desc = {
    Text = "チーム唯一：装備者が与えるシールドが<WeaponEffect_Num:[StateArg1]％>増加し、シールドを与えた時、味方全員が<WeaponEffect_Num:[StateArg3]％>の一時クリティカル率と装備者の銀鍵チャージの<WeaponEffect_Num:[StateArg4]%>分の銀鍵エネルギーを獲得する。毎ターン最大2回まで発動。現在界域が「深海」の場合、触腕が1本攻撃するたびに、装備者は1点の狂気を獲得する。毎ターン最大<WeaponEffect_Num:[StateArg2]>点まで獲得。"
  },
  State_2856_WeaponDesc = {
    Text = "装備者が与えるシールドが<WeaponEffect_Num:[StateArg1]％>増加し、シールドを与えた時、味方全員が<WeaponEffect_Num:[StateArg3]％>の一時クリティカル率と装備者の銀鍵チャージの<WeaponEffect_Num:[StateArg4]%>分の銀鍵エネルギーを獲得する。毎ターン最大2回まで発動。現在界域が「深海」の場合、触腕が1本攻撃するたびに、装備者は1点の狂気を獲得する。毎ターン最大<WeaponEffect_Num:[StateArg2]>点まで獲得。"
  },
  State_2857_Desc = {
    Text = "毎ターン開始時、すべての覚醒体が10の狂気を獲得。最大ライフが50％減少。"
  },
  State_2858_Name = {
    Text = "打出時追加で2層のバリアを獲得"
  },
  State_2859_Desc = {
    Text = "戦闘開始後、このカードは手札に固定される。"
  },
  State_2860_Desc = {
    Text = "抽到时自身の最大ライフが10％減少する。使用後、すべての覚醒体のこのターンのクリティカルダメージが100％アップする。売却不可。"
  },
  State_2860_Name = {
    Text = "状態呪い融蝕"
  },
  State_2860_WeaponDesc = {
    Text = "抽到时自身の最大ライフが10％減少する。使用後、すべての覚醒体のこのターンのクリティカルダメージが100％アップする。売却不可。"
  },
  State_2861_Name = {
    Text = "(残り:[Layer])"
  },
  State_2862_Desc = {
    Text = "ターン終了時、追加で毒ダメージを1回受ける"
  },
  State_2862_Name = {
    Text = "体力の低下"
  },
  State_2863_Desc = {
    Text = "進化レベル"
  },
  State_2863_Name = {
    Text = "進化レベル"
  },
  State_2863_WeaponDesc = {
    Text = "進化レベル"
  },
  State_2864_Desc = {
    Text = "「24」 が覚醒した。最後の「助けて」を使ってチャンスを見つけろ！"
  },
  State_2864_Name = {
    Text = "「24」 覚醒！"
  },
  State_2864_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_2866_Desc = {
    Text = "チームユニーク：手札上限 +2、ターン終了時に装備者の <WeaponEffect_Num:[StateArg1]%> キーチャージ分のキーエネルギーを獲得する。キーオーダーを発動するたびに、全覚醒体が <WeaponEffect_Num:[StateArg2]> 点の狂気を獲得し、現在の界域が「血肉」の場合、さらに胚胎融合 <WeaponEffect_Num:+[Blood:StateArg3]> 。"
  },
  State_2866_WeaponDesc = {
    Text = "手札上限 +2、ターン終了時に <WeaponEffect_Num:[DescArg1]> 点のキーエネルギーを獲得する。キーオーダーを発動するたびに、すべての覚醒体が <WeaponEffect_Num:[StateArg2]> 点の狂気を獲得し、現在の界域が「血肉」の場合、さらに胚胎融合 <WeaponEffect_Num:+[Blood:StateArg3]> となる。"
  },
  State_2868_Desc = {
    Text = "ターン終了時に手札に残ったカード1枚につき、すべての覚醒体が狂気を2獲得。"
  },
  State_2871_Desc = {
    Text = "ライフが50%([StateArg1])未満になると、同量のライフを持つ融蝕三角構造体を召喚する"
  },
  State_2871_Name = {Text = "召喚"},
  State_2871_WeaponDesc = {
    Text = "ライフが50％以下([StateArg1])になると、同量のライフを持つ融食三角を1体召喚する"
  },
  State_2874_Desc = {
    Text = "覚醒体が首狩りに注視されているとき、そのカードを使用すると追加で2枚引ける。"
  },
  State_2875_Desc = {
    Text = "使用した後、胚胎融合+[StateArg1]。"
  },
  State_2875_Name = {
    Text = "<Rune_12_High:上位好血>"
  },
  State_2875_WeaponDesc = {
    Text = "発射後、胚胎融合+ [Blood:StateArg1]。"
  },
  State_2876_Desc = {
    Text = "戦闘終了後、追加で50の黒章と1枚の症状カードを獲得。__「開発用」"
  },
  State_2877_Desc = {
    Text = "マダム・レッドがダメージを1回与えるたび、[StateArg2]点の一時的な力を獲得。"
  },
  State_2877_Name = {
    Text = "出迎えの特権"
  },
  State_2878_Desc = {
    Text = "ダメージ回数が1増加、ただしダメージが25%減少。"
  },
  State_2878_WeaponDesc = {
    Text = "ダメージ回数が1増加するが、ダメージは25%減少する。"
  },
  State_2879_Name = {
    Text = "ナメクジプリン"
  },
  State_2879_WeaponDesc = {
    Text = "「湮滅」を使用した後、このターンが静海の姿勢である場合、装備者のこのターンのシールドと治療効果が30％アップします。"
  },
  State_2880_Name = {
    Text = "状態@海の使徒霊知啓発7"
  },
  State_2881_Desc = {
    Text = "1枚の「聖礼」を「妄執」に変換するたび、この戦闘中ミリアムの基礎ダメージが15%増加。"
  },
  State_2881_Name = {
    Text = "泡沫に消ゆ"
  },
  State_2883_Desc = {
    Text = "チームユニーク：装備者がアクティブダメージを与えた後、<WeaponEffect_Num:[StateArg1]%> の確率で装備者の指令カードを1枚ドローし、その行動力消費を1低下させる。この効果は1ターンに1回のみ発動する。"
  },
  State_2883_WeaponDesc = {
    Text = "装備者がアクティブダメージを与えた後、<WeaponEffect_Num:[StateArg1]%> の確率で装備者の指令カードを1枚ドローし、その行動力消費を1低下させる。この効果は1ターンに1回のみ発動する。"
  },
  State_2884_Name = {
    Text = "与えるダメージが<PunctureDamagewords:刺突ダメージ>になる。手札にある行動力が最も高いカード1枚の行動力消費を1減少させる"
  },
  State_2885_Name = {
    Text = "状態@ターン開始時ドロー+2"
  },
  State_2887_Desc = {
    Text = "チーム唯一：装備者が狂気爆発を発動後、そのターンのクリティカルダメージが<WeaponEffect_Num:[StateArg1]%>増加し、手札にある装備者のカード全てが<WeaponEffect_Num:[StateArg2]%>の確率でそのターン中の算力消費が1点減少する。"
  },
  State_2887_WeaponDesc = {
    Text = "装備者が狂気爆発を発動後、そのターンのクリティカルダメージが<WeaponEffect_Num:[StateArg1]%>増加し、手札にある装備者のカード全てが<WeaponEffect_Num:[StateArg2]%>の確率でそのターン中の算力消費が1点減少する。"
  },
  State_2888_Desc = {
    Text = "手札に「胚胎」が存在する場合、1枚除外し、後続の効果を発動する。"
  },
  State_2888_Name = {
    Text = "<DevouredIconKeywords:捕食>"
  },
  State_2888_WeaponDesc = {
    Text = "手札の胎児を消費し、強力な呑食効果を発動する。"
  },
  State_2889_Name = {
    Text = "覚醒体を1体選択し、<Energy:[DescArg1]>狂気を獲得させる"
  },
  State_2890_Desc = {
    Text = "戦闘開始時に、味方に1回の抑圧を与える。"
  },
  State_2890_Name = {Text = "鎧砕き"},
  State_2890_WeaponDesc = {
    Text = "バトル開始時、味方チームに 1 層の脆弱を与える。"
  },
  State_2891_Name = {
    Text = "狂気開始時回復増加"
  },
  State_2892_Desc = {
    Text = "ターン終了時、[Layer] ポイントのライフを回復する。"
  },
  State_2892_Name = {
    Text = "遅延されたライフ回復"
  },
  State_2892_WeaponDesc = {
    Text = "ターン終了まで、各キルで [Layer] ポイントのライフを回復する。"
  },
  State_2897_Desc = {
    Text = "真貌顕現時、敵の一時的な力を減少させる。__「開発用」"
  },
  State_2897_Name = {
    Text = "狂気を恐れる"
  },
  State_2899_Desc = {
    Text = "相手の手札が4枚以上の場合、ダメージを受けると[StateArg1]点のシールドを獲得。"
  },
  State_2900_Desc = {
    Text = "この戦闘で与えるダメージが[Layer]増加。"
  },
  State_2900_Name = {Text = "力"},
  State_2900_WeaponDesc = {
    Text = "この戦闘で与えるダメージが[Layer]増加。"
  },
  State_2901_Desc = {
    Text = "[狂気解放]自身に 20 ポイントの狂気を獲得する。"
  },
  State_2901_Name = {
    Text = "遺物無名の神のヴェール"
  },
  State_2901_WeaponDesc = {
    Text = "[狂気解放]自身に 20 ポイントの狂気を獲得する。"
  },
  State_2902_Desc = {
    Text = "「缶の中の脳」のライフ回復稜が2倍になる。"
  },
  State_2902_Name = {
    Text = "霊肉分離"
  },
  State_2902_WeaponDesc = {
    Text = "「缶の中の脳」のライフ回復稜が2倍になる。"
  },
  State_2903_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_2903_Name = {
    Text = "状態@試作小刀クリティカル"
  },
  State_2904_Desc = {
    Text = "実際のダメージを受けるたびに、10のシールドを獲得。"
  },
  State_2904_Name = {
    Text = "バッファー"
  },
  State_2904_WeaponDesc = {
    Text = "実際のダメージを受けた後、10のシールドを獲得する。"
  },
  State_2905_Desc = {
    Text = "チーム唯一：装備者の「狂気解放」が与えるシールドが<WeaponEffect_Num:[StateArg2]%>増加する。装備者が「狂気解放」を発動した後、装備者の防御力の<WeaponEffect_Num:[StateArg1]%>層数分の一時<PowerIconKeywords:力>を獲得する。味方チームが<FragileIconKeywords:脆弱>状態の場合、効果が2倍になる。"
  },
  State_2905_WeaponDesc = {
    Text = "装備者の「狂気解放」が与えるシールドが<WeaponEffect_Num:[StateArg2]%>増加する。装備者が「狂気解放」を発動した後、[Power:DescArg1]の一時<PowerIconKeywords:力>を獲得する。味方チームが<FragileIconKeywords:脆弱>状態の場合、効果が2倍になる。"
  },
  State_2906_Desc = {
    Text = "実際にダメージを与えた後、味方チームから[Layer]点の力を一時的に減少させる。"
  },
  State_2906_Name = {
    Text = "麻痺電撃"
  },
  State_2909_Desc = {
    Text = "[Layer] ポイントの狂気を持っている。狂気が5以上の場合、意図が「歪んだ死体の狂宴」に変化し、狂気が減少すると元に戻る。"
  },
  State_2909_Name = {
    Text = "状態@怪物24歪んだ死体の宴カウント"
  },
  State_2909_WeaponDesc = {
    Text = "[Layer] ポイントの狂気を持っている。狂気が5以上の場合、意図が「歪んだ死体の狂宴」に変化し、狂気が減少すると元に戻る。"
  },
  State_2910_Desc = {
    Text = "チーム唯一：探索開始時に「インスピレーション」1枚と装備者の「打撃」をデッキに加える。装備者の「打撃」の基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加し、使用後<WeaponEffect_Num:[StateArg2]%>の確率でカードを1枚引く。この効果は毎ターン最大1回まで発動。現在の界域が「超次元」かつ超次元ターン中の場合、「打撃」は「インスピレーション」1枚を手札に加える。当ターン最大1回まで発動。"
  },
  State_2910_WeaponDesc = {
    Text = "探索開始時に「インスピレーション」1枚と装備者の「打撃」をデッキに加える。装備者の「打撃」の基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加し、使用後<WeaponEffect_Num:[StateArg2]%>の確率でカードを1枚引く。この効果は毎ターン最大1回まで発動。現在の界域が「超次元」かつ超次元ターン中の場合、「打撃」は「インスピレーション」1枚を手札に加える。当ターン最大1回まで発動。"
  },
  State_2911_Desc = {
    Text = "ステータス@純白の空想世界改カウント"
  },
  State_2911_Name = {
    Text = "状態@純白の空想世界カウント"
  },
  State_2911_WeaponDesc = {
    Text = "ステータス@純白の空想世界改カウント"
  },
  State_2912_Desc = {
    Text = "ロックオンされた！このカードを使用すると、海踊人親衛が [StateArg1]点の一時的な力を獲得し、このカードの「水底の印」は除去される。"
  },
  State_2912_Name = {
    Text = "<CardKeyWord:汚染：深潜の印>"
  },
  State_2912_WeaponDesc = {
    Text = "カードをプレイした後、深潜者親衛が [StateArg1] 点の一時的な力を獲得。"
  },
  State_2913_Desc = {
    Text = "バトル開始時に自身を 3 ターンの脆弱状態にする。"
  },
  State_2913_Name = {
    Text = "遺物奇異な鉤爪2"
  },
  State_2913_WeaponDesc = {
    Text = "バトル開始時に自身を 3 ターンの脆弱状態にする。"
  },
  State_2914_Desc = {
    Text = "ライフが50%未満になると、行動予測は「同量のライフを持つ【融蝕三角構造体】を召喚する」に変化する。"
  },
  State_2914_Name = {Text = "分裂"},
  State_2914_WeaponDesc = {
    Text = "ライフが50%を下回った場合、意図が【融食三角形内】に同じライフを持つ召喚に変化する。"
  },
  State_2915_Desc = {
    Text = "「恨みの連鎖」のダメージ回数が+[Layer]になります。"
  },
  State_2915_Name = {Text = "憎しみ"},
  State_2915_WeaponDesc = {
    Text = "「もやもやとした恨み」のダメージ回数を+[Layer]回数増やします。"
  },
  State_2917_Desc = {
    Text = "ターン終了時、残りの手札1枚につき、次のターン開始時に1点の行動力を獲得する。"
  },
  State_2917_Name = {
    Text = "状態@幻夢のシルバーキー：演算__「開発用」"
  },
  State_2918_Desc = {
    Text = "受けるダメージが99%減少。アクティブダメージを受けると1点解除し、ターン開始時に3回に回復。"
  },
  State_2918_Name = {
    Text = "「不滅の残躯」"
  },
  State_2918_WeaponDesc = {
    Text = "受けたダメージが99%減少。受動ダメージを受けた後、1層削除され、ターン開始時に3層に回復する。"
  },
  State_2919_Desc = {
    Text = "ステータス@翠火エメラルドイメージ前もって"
  },
  State_2919_Name = {
    Text = "ステータス@翠火エメラルドイメージ前もって"
  },
  State_2919_WeaponDesc = {
    Text = "ステータス@翠火エメラルドイメージ前もって"
  },
  State_2922_Desc = {
    Text = "行動力を1消費するごとに、対応する覚醒体が2の狂気を獲得。"
  },
  State_2923_Desc = {
    Text = "ターン終了時、力が[Layer]増加。"
  },
  State_2923_Name = {
    Text = "降神の儀式"
  },
  State_2923_WeaponDesc = {
    Text = "各ターン終了時に[Layer]のパワーを獲得。"
  },
  State_2925_Desc = {
    Text = "翠火がダメージを与えるたびに、層数の＋1"
  },
  State_2925_Name = {
    Text = "エメラルドイメージカウント"
  },
  State_2925_WeaponDesc = {
    Text = "翠火がダメージを与えるたびに、層数の＋1"
  },
  State_2927_Name = {
    Text = "状態@呪い錯乱変化"
  },
  State_2929_Desc = {
    Text = "チームユニーク：装備者がダメージを与えるたびに、<WeaponEffect_Num:[StateArg3]%> の確率で装備者が2%の一時的なクリティカルダメージを獲得する。装備者が狂気解放を発動した後、ランダムな敵に装備者の攻撃力の <WeaponEffect_Num:[StateArg1]%> に等しいアクティブダメージを3回与える。現在の界域が「血肉」の場合、装備者が胚胎を捕食するたびに、胚胎融合 +<WeaponEffect_Num:[Blood:StateArg2]> となる。"
  },
  State_2929_WeaponDesc = {
    Text = "装備者がダメージを与えるたびに、<WeaponEffect_Num:[StateArg3]%> の確率で装備者が2%の一時的なクリティカルダメージを獲得する。装備者が狂気解放を発動した後、ランダムな敵に [DescArg1] 点のアクティブダメージを3回与える。現在の界域が「血肉」の場合、装備者が胚胎を捕食するたびに、胚胎融合 +<WeaponEffect_Num:[Blood:StateArg2]> となる。"
  },
  State_2930_Name = {
    Text = "状態@ジョージ@死亡時力を獲得。"
  },
  State_2931_Desc = {
    Text = "1回の捕食ごとに、すべての敵から4の一時的な力を奪う。"
  },
  State_2931_Name = {
    Text = "異化シルクメノウ"
  },
  State_2933_Name = {
    Text = "「密約」歪みの双子白"
  },
  State_2933_WeaponDesc = {
    Text = "偶数ターン開始後、装備者の「防御」を1枚手札に加える。そのカードには虚無と消費が付加される。"
  },
  State_2934_Desc = {
    Text = "受けるアクティブおよび触手ダメージが [DescArg1] ％上昇する。"
  },
  State_2934_Name = {
    Text = "<VulnerabilityColour:易傷>"
  },
  State_2934_WeaponDesc = {
    Text = "受けるすべてのダメージが50%増加。"
  },
  State_2937_Desc = {
    Text = "3回目のシールド獲得時、同量の反撃を獲得。__「開発用」"
  },
  State_2938_Desc = {
    Text = "ターン開始時にカードを1枚引き、ターン終了時に手札を1枚保持することを選択できる。"
  },
  State_2939_Name = {
    Text = "抑圧無効化"
  },
  State_2940_Desc = {
    Text = "再生力効果アップ。"
  },
  State_2940_Name = {
    Text = "異端の血を受ける漸強"
  },
  State_2941_Desc = {
    Text = "使用した後、すべての敵に[StateArg1]層の毒を付与し、すべての敵の毒を[StateArg2]%発動する。"
  },
  State_2942_Desc = {
    Text = "ターン終了時、他の味方のライフを[Layer]%回復し、持続ダメージを除去する。"
  },
  State_2942_Name = {
    Text = "戦場の救護"
  },
  State_2946_Desc = {
    Text = "狂乱の連撃で非常に高いシールドを獲得。"
  },
  State_2946_Name = {
    Text = "「不動要塞」"
  },
  State_2946_WeaponDesc = {
    Text = "狂気のコンボで非常に高いシールドを獲得。"
  },
  State_2948_Desc = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_2948_Name = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_2948_WeaponDesc = {
    Text = "使用前にカードの行動力を変更"
  },
  State_2949_Name = {
    Text = "運命の札戦闘を放棄する刻印"
  },
  State_2951_Desc = {
    Text = "遺物安楽椅子__「開発用」"
  },
  State_2951_Name = {
    Text = "緘黙の手袋__「開発用」"
  },
  State_2952_Desc = {
    Text = "ターン終了後、[Layer]ライフを回復。ライフを5失うごとに1点を除去する。"
  },
  State_2954_Name = {
    Text = "状態@2-8怪物24@助けて"
  },
  State_2955_Desc = {
    Text = "すべての敵がライフを失う。永続、消滅。"
  },
  State_2955_Name = {
    Text = "<CardKeyWord:虚無終結>"
  },
  State_2955_WeaponDesc = {
    Text = "すべての敵がライフを失う。継続、破棄。"
  },
  State_2956_Desc = {
    Text = "毎回ダメージを受けたとき、すべての覚醒体は [StateArg1] pt の狂気を得る。"
  },
  State_2956_Name = {
    Text = "幻想ビーム__「開発用」"
  },
  State_2956_WeaponDesc = {
    Text = "毎回ダメージを受けたとき、すべての覚醒体は [StateArg1] pt の狂気を得る。"
  },
  State_2957_Desc = {
    Text = "死亡後、自身のライフの1/3の【融蝕三角構造体】を召喚する"
  },
  State_2957_Name = {Text = "融蝕"},
  State_2957_WeaponDesc = {
    Text = "死亡後、その場に自身のライフ値の1/3の【融食三角】を召喚する"
  },
  State_2960_Desc = {
    Text = "偶数ターンで、あなたの計算力が 0 の場合、2 計算力を獲得します。"
  },
  State_2960_Name = {
    Text = "異化古いパズル"
  },
  State_2960_WeaponDesc = {
    Text = "偶数ターンで、あなたの計算力が 0 の場合、2 計算力を獲得します。"
  },
  State_2961_Desc = {
    Text = "チーム唯一：装備者が与える<IntoxicationIconKeywords:毒>の効果が<WeaponEffect_Num:[StateArg1]%>増加する。装備者が狂気爆発を発動する前に、すべての敵に装備者の攻撃力の<WeaponEffect_Num:[StateArg2]%>に相当する毒を付与する。鍵令を使用した後、装備者は<WeaponEffect_Num:[StateArg3]>ポイントの狂気を獲得する。"
  },
  State_2961_WeaponDesc = {
    Text = "装備者が与える<IntoxicationIconKeywords:毒>の効果が<WeaponEffect_Num:[StateArg1]%>増加する。装備者が狂気爆発を発動する前に、すべての敵に<WeaponEffect_Num:[Poison:DescArg1]>層の毒を付与する。鍵令を使用した後、装備者は<WeaponEffect_Num:[StateArg3]>ポイントの狂気を獲得する。"
  },
  State_2962_Desc = {
    Text = "打出後、全ての敵を弱りに [StateArg1] のターン。"
  },
  State_2962_Name = {
    Text = "<Rune_2:倦怠>"
  },
  State_2965_Name = {
    Text = "ステータス@凸月の侍女霊感7"
  },
  State_2967_Desc = {
    Text = "症状カードを使用した時、パンディアのステータスが「イライラ」と「耽溺」の間で変化する。イライラ：与えるアクティブダメージの回数+1、力が減少する。耽溺：与えるアクティブダメージの回数-1、力が増加する。"
  },
  State_2967_Name = {
    Text = "パンディア覚醒！"
  },
  State_2967_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_2968_Name = {
    Text = "状態@ステージ2_14戦闘8バブル4"
  },
  State_2969_Name = {
    Text = "状態@ステージ2_14戦闘8バブル5"
  },
  State_2970_Desc = {
    Text = "原初の子孫"
  },
  State_2970_Name = {
    Text = "原初の子孫"
  },
  State_2970_WeaponDesc = {
    Text = "原初の子孫"
  },
  State_2971_Desc = {
    Text = "ステータス@序章HP半減"
  },
  State_2971_Name = {
    Text = "ステータス@序章HP半減"
  },
  State_2971_WeaponDesc = {
    Text = "ステータス@序章HP半減"
  },
  State_2972_Name = {
    Text = "状態@ステージ2_14戦闘8バブル2"
  },
  State_2973_Name = {
    Text = "状態@ステージ2_14戦闘8バブル3"
  },
  State_2975_Desc = {
    Text = "各戦闘の最初の5回の跳躍効果が追加で1回発動する。"
  },
  State_2976_Desc = {
    Text = "ターン終了時、シールドが0または10の倍数の場合、[Arg1]のシールドを獲得。ライフが10の倍数の場合、[Arg2]の力を獲得。__「開発用」"
  },
  State_2976_Name = {
    Text = "救難信号"
  },
  State_2977_Desc = {
    Text = "奇数ターンで、あなたの手札が 0 枚のとき、2 枚のカードを引き直す"
  },
  State_2977_Name = {
    Text = "異化古いパズル"
  },
  State_2977_WeaponDesc = {
    Text = "奇数ターンで、あなたの手札が 0 枚のとき、2 枚のカードを引き直す"
  },
  State_2978_Desc = {
    Text = "1点のダメージを受けるごとに1回減少。回数が0になると防御モードに切り替わる。"
  },
  State_2978_Name = {
    Text = "カードカウント"
  },
  State_2978_WeaponDesc = {
    Text = "1 ダメージを受けるごとに 1 層減少。層が 0 になると、防御モードに切り替わります。"
  },
  State_2979_Desc = {
    Text = "チーム唯一：装備者が与える毒とシールドが<WeaponEffect_Num:[StateArg3]%>増加する。装備者の「打撃」のクリティカル率とクリティカルダメージが<WeaponEffect_Num:[StateArg1]%>増加し、最大HPの<WeaponEffect_Num:[StateArg2]%>分のシールドを獲得する。シールド効果は毎ターン最大1回まで発動。"
  },
  State_2979_Name = {
    Text = "痛みを越えて"
  },
  State_2979_WeaponDesc = {
    Text = "装備者が与える毒とシールドが<WeaponEffect_Num:[StateArg3]%>増加する。装備者の「打撃」のクリティカル率とクリティカルダメージが<WeaponEffect_Num:[StateArg1]%>増加し、最大HPの[StateArg2]%（[DescArg1]）分のシールドを獲得する。シールド効果は毎ターン最大1回まで発動。"
  },
  State_2983_Desc = {
    Text = "捨て札フェイズにこのカードが手札にある場合、カードは消費され、この戦闘中に再び現れない。"
  },
  State_2983_Name = {
    Text = "<NothingnessIconKeywords:虚無>"
  },
  State_2983_WeaponDesc = {
    Text = "もし捨て札のフェイズでまだ手札に残っている場合、捨て札の山には入れられず、このバトルでは再び使用できません。"
  },
  State_2985_Desc = {
    Text = "ターン終了まで、ダメージを与えるたび、ターン終了時に[Layer]点のライフを回復する。"
  },
  State_2985_Name = {
    Text = "珠玉の卵"
  },
  State_2985_WeaponDesc = {
    Text = "ターン終了まで、ダメージを与えるたびに [Layer] ポイントのライフを回復する。"
  },
  State_2987_Desc = {
    Text = "イベント19＿1"
  },
  State_2987_Name = {
    Text = "イベント19＿1"
  },
  State_2987_WeaponDesc = {
    Text = "イベント19＿1"
  },
  State_2988_Desc = {
    Text = "胎児を呑み込んだとき、捨て札の山から手札スタックに戻り、計算力が0になる。"
  },
  State_2988_Name = {
    Text = "ねっせい"
  },
  State_2988_WeaponDesc = {
    Text = "胎児を呑み込んだとき、捨て札の山から手札スタックに戻り、計算力が0になる。"
  },
  State_2989_Desc = {
    Text = "覚醒体のカードを出した後、そのカードの行動力消費を1減らした一時的なコピーをデッキに追加する。"
  },
  State_2990_Desc = {
    Text = "使用した後、すべての敵から[StateArg1]点の一時的な力を減少させる。"
  },
  State_2990_Name = {
    Text = "<Rune_18_High:上位衰弱>"
  },
  State_2992_Desc = {
    Text = "「空虚」を引いた後、このターン内で全ての覚醒体が取得する狂気を50％低下させる。"
  },
  State_2992_Name = {Text = "虚無"},
  State_2992_WeaponDesc = {
    Text = "「空虚」を引いた後、このターン内で全ての覚醒体が取得する狂気を50％低下させる。"
  },
  State_2993_Name = {
    Text = "遺物怪蛇の抜け殻カウント"
  },
  State_2994_Desc = {
    Text = "触腕満溢時、触手ダメージが上昇 [StateArg1]。"
  },
  State_2994_Name = {
    Text = "庇護の力"
  },
  State_2994_WeaponDesc = {
    Text = "触腕満溢時、触手ダメージが上昇 [StateArg1]。"
  },
  State_2996_Desc = {
    Text = "使用した後、1本の触腕に[StateArg1]回攻撃させる。"
  },
  State_2996_Name = {
    Text = "<Rune_11:統御>"
  },
  State_2997_Desc = {
    Text = "毎ターン3回目のダメージを与えた後、[Arg1] のシールドを獲得。毎ターン6回目のダメージを与えた後、[Arg2] の力を獲得。"
  },
  State_3001_Desc = {
    Text = "攻撃を受けたときに得られる狂気を2点増加。"
  },
  State_3002_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_3002_Name = {
    Text = "状態@試作レーザー砲幸運"
  },
  State_3003_Desc = {
    Text = "使用すると捨て札に行かず、デッキから除去する。"
  },
  State_3003_Name = {
    Text = "<DepleteIconKeywords:除外>"
  },
  State_3003_WeaponDesc = {
    Text = "プレイ後、 カードは捨て札の山に入らず、 このバトルでは再び使用できません。"
  },
  State_3004_Desc = {
    Text = "[Layer] ターンの間、毒状態を無効化。"
  },
  State_3004_Name = {
    Text = "毒無効化"
  },
  State_3008_Desc = {
    Text = "各ターン開始時に手札に残っているカードに1点の「鈍化」を追加。行動力消費が5を超えるカードは「石ころ」に変わる。"
  },
  State_3008_Name = {
    Text = "アイギス覚醒！"
  },
  State_3008_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_3011_Desc = {
    Text = "チーム唯一：装備者の「狂気爆発」のクリティカル率とクリティカルダメージが <WeaponEffect_Num:[StateArg2]%> 増加する。装備者が「狂気爆発」を発動した後、装備者の体質の <WeaponEffect_Num:[StateArg1]%> に相当する<PowerIconKeywords:力>を獲得する。この狂気爆発が<CardKeyWord:捕食>効果を発動した場合、追加で1回分の<PowerIconKeywords:力>を獲得する。"
  },
  State_3011_WeaponDesc = {
    Text = "装備者の「狂気爆発」のクリティカル率とクリティカルダメージが <WeaponEffect_Num:[StateArg2]%> 増加する。装備者が「狂気爆発」を発動した後、 <WeaponEffect_Num:[Power:DescArg1]> ポイントの力を獲得する。この狂気爆発が<CardKeyWord:捕食>効果を発動した場合、追加で1回分の<PowerIconKeywords:力>を獲得する。"
  },
  State_3012_Desc = {
    Text = "無用空状態"
  },
  State_3012_Name = {
    Text = "無用空状態"
  },
  State_3012_WeaponDesc = {
    Text = "無用空状態"
  },
  State_3013_Desc = {
    Text = "渇血患者が胚融合を高めたとき、[ StateArg1 ] 点のパワーを獲得する。"
  },
  State_3013_Name = {
    Text = "血を渇望する者"
  },
  State_3014_Desc = {
    Text = "相手の手札が4枚以上の場合、ダメージを受けると[StateArg1]点のシールドを獲得。"
  },
  State_3015_Desc = {
    Text = "ステータス@ロウ質の鎧 味方 チーム"
  },
  State_3015_Name = {
    Text = "ステータス@ロウ質の鎧 味方 チーム"
  },
  State_3015_WeaponDesc = {
    Text = "ステータス@ロウ質の鎧 味方 チーム"
  },
  State_3016_Desc = {
    Text = "召喚されたモンスターのライフが倍増する。"
  },
  State_3016_Name = {
    Text = "「横流の恥」"
  },
  State_3016_WeaponDesc = {
    Text = "召喚されたモンスターのライフが2倍になる。"
  },
  State_3017_Name = {
    Text = "状態@呪い錯乱"
  },
  State_3018_Desc = {
    Text = "「次元を巡る犬」がライフを1点失うごとに1点を除去し、0点になると、[StateArg1]シールドを獲得し、再び[StateArg2]点の次元障壁を獲得。"
  },
  State_3018_Name = {
    Text = "次元障壁"
  },
  State_3019_Desc = {
    Text = "10 のブラックスタンプを消費するごとに 1％ のライフを回復"
  },
  State_3019_Name = {
    Text = "遺物逆生根状態"
  },
  State_3019_WeaponDesc = {
    Text = "10 のブラックスタンプを消費するごとに 1％ のライフを回復"
  },
  State_3020_Desc = {
    Text = "前のターンにダメージを受けた場合、ターン開始時に1ターンの無効化を獲得。"
  },
  State_3020_Name = {Text = "適応"},
  State_3020_WeaponDesc = {
    Text = "前回合にダメージを受けた場合、ターン開始時に 1 ターンの免疫を得る。"
  },
  State_3021_Desc = {
    Text = "ターン開始時に行動力を1獲得。"
  },
  State_3021_Name = {
    Text = "状態@最大演算力–2"
  },
  State_3023_Desc = {
    Text = "このターンにアクティブダメージを受けるたびに、ダメージの発生源に [Layer] 点の<FixedDamage:純粋ダメージ>を与える。"
  },
  State_3023_Name = {
    Text = "一時的な反撃"
  },
  State_3023_WeaponDesc = {
    Text = "アクティブダメージを受けるたびに、攻撃者に [Layer] 点の<FixedDamage:純粋ダメージ>を与える。"
  },
  State_3024_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_3024_Name = {
    Text = "状態@試作小刀死亡抵抗"
  },
  State_3025_Desc = {
    Text = "カードを1枚使用するたび、そのターンのクリティカル率を10％増加。"
  },
  State_3026_Desc = {
    Text = "戦闘開始後、[StateArg1]枚の一時コピーを山札に加えてシャッフルする。元のカードとミラーカードの両方に保留を付与する。"
  },
  State_3026_Name = {
    Text = "<Rune_8_High:上位鏡像>"
  },
  State_3026_WeaponDesc = {
    Text = "バトル開始後、[StateArg1] 枚の一時的なコピーをドロー山にシャッフルする。"
  },
  State_3027_Desc = {
    Text = "戦闘終了後、追加で50の黒章と1枚の症状カードを獲得。__「開発用」"
  },
  State_3028_Name = {
    Text = "状態@ターン開始時行動力+2"
  },
  State_3029_Desc = {
    Text = "1 ダメージを受けるごとに 1 層減少。層が 0 になると、防御モードに切り替わります。"
  },
  State_3029_Name = {
    Text = "カードカウント"
  },
  State_3029_WeaponDesc = {
    Text = "1 ダメージを受けるごとに 1 層減少。層が 0 になると、防御モードに切り替わります。"
  },
  State_3033_Desc = {
    Text = "10枚のカードを使用するたび、すべてのダメージを防ぐバリアが1枚獲得。既にバリアを持っている場合は、代わりにライフを[Arg1]回復。"
  },
  State_3034_Desc = {
    Text = "チーム唯一：装備者のカードを1枚出すごとに、<WeaponEffect_Num:[StateArg1]>銀鍵エネルギーを獲得する。この効果は1ターンに最大3回発動する。"
  },
  State_3034_WeaponDesc = {
    Text = "装備者のカードを1枚出すごとに、<WeaponEffect_Num:[StateArg1]>銀鍵エネルギーを獲得する。この効果は1ターンに最大3回発動する。"
  },
  State_3035_Desc = {
    Text = "使用した後、1本の触腕に[StateArg1]回攻撃させる。"
  },
  State_3035_Name = {
    Text = "<Rune_11_High:上位統御>"
  },
  State_3035_WeaponDesc = {
    Text = "打出後、1本のタッチアームがすべての敵を [StateArg1] 回攻撃する。"
  },
  State_30364_Desc = {
    Text = "このカードが手札にあると手札の上限を+1します。"
  },
  State_30364_Name = {
    Text = "手札の上限無視"
  },
  State_30369_Desc = {
    Text = "このターン、手札の上限が[Layer]増加。"
  },
  State_30369_Name = {
    Text = "手札の上限"
  },
  State_3036_Desc = {
    Text = "与える抑圧と倦怠効果が33%から50%に変わる。"
  },
  State_3036_Name = {
    Text = "「寂滅の余波」"
  },
  State_3036_WeaponDesc = {
    Text = "与えられる脆弱と弱り効果が 33% から 50% に変更されます。"
  },
  State_3038_Desc = {
    Text = "チーム唯一：キーオーダーを発動した後、装備者が<WeaponEffect_Num:[StateArg1]>狂気を獲得する。"
  },
  State_3038_WeaponDesc = {
    Text = "キーオーダーを発動した後、装備者が<WeaponEffect_Num:[StateArg1]>狂気を獲得する。"
  },
  State_3040_Desc = {
    Text = "各ターン開始時に味方チームに[Layer]回の【束縛】を付与する。"
  },
  State_3040_Name = {Text = "束縛"},
  State_3040_WeaponDesc = {
    Text = "毎ターンの開始時、味方チームに [Layer] 層の【拘束】を追加する。"
  },
  State_3041_Desc = {
    Text = "デッキに永久保存。"
  },
  State_3041_Name = {
    Text = "<CardKeyWord:症状カード>"
  },
  State_3042_Desc = {
    Text = "ダメージを与えるたびに、このターン中に[Arg1]力を獲得し、最大3回までスタックする。スタックが満たされると効果が倍増する。__「開発用」"
  },
  State_3043_Desc = {
    Text = "偶数ターンの被ダメージ50%減、与ダメージ33%増。"
  },
  State_3043_Name = {
    Text = "気まぐれ"
  },
  State_3043_WeaponDesc = {
    Text = "偶数ターンのダメージが50％減少し、ダメージが33％アップする。"
  },
  State_3045_Desc = {
    Text = "リリース狂気解放後、対応する覚醒体は 20 狂気を獲得。"
  },
  State_3045_Name = {
    Text = "無名の神のヴェール"
  },
  State_3046_Desc = {
    Text = "チーム唯一：敵が1体死亡するたびに[StateArg1]黒印を獲得する。装備者が敵を撃破した後、今回のステージ中、装備者のクリティカルダメージが永続的に<WeaponEffect_Num:[StateArg2]%>増加する。最大5層まで重複可能。装備者が跳躍効果を発動するたびに、装備者の今ターンの最終ダメージが<WeaponEffect_Num:[StateArg3]%>増加する。最大3層まで重複可能。"
  },
  State_3046_WeaponDesc = {
    Text = "敵が1体死亡するたびに[StateArg1]黒印を獲得する。装備者が敵を撃破した後、今回のステージ中、装備者のクリティカルダメージが永続的に<WeaponEffect_Num:[StateArg2]%>増加する。最大5層まで重複可能。装備者が跳躍効果を発動するたびに、装備者の今ターンの最終ダメージが<WeaponEffect_Num:[StateArg3]%>増加する。最大3層まで重複可能。"
  },
  State_3047_Desc = {
    Text = "ターン開始時に[Arg1]のシールドを獲得し、1ターン経過するごとにこのシールド値が[Arg2]増加する。"
  },
  State_3047_Name = {
    Text = "守護の手"
  },
  State_3048_Desc = {
    Text = "ロータンの戦意は止まらない。各ターン終了時にロータンは3回の倦怠と軟化を解放する。"
  },
  State_3048_Name = {
    Text = "ロータンの覚醒"
  },
  State_3049_Desc = {
    Text = "ジョージの次の攻撃のダメージ回数を1回増やす。"
  },
  State_3049_WeaponDesc = {
    Text = "ジョージの次の攻撃ダメージを1回増加させる。"
  },
  State_3050_Desc = {
    Text = "戦闘開始時、【痙攣】を1枚山札のランダムな位置に追加する。"
  },
  State_3050_Name = {Text = "恐怖"},
  State_3050_WeaponDesc = {
    Text = "バトル開始時、1 枚の【けいれん】をドロー山にシャッフルして加える。"
  },
  State_3051_Desc = {
    Text = "ガードされなかったダメージを与えた時、「泣き叫ぶ」を1枚山札のランダムな位置に追加する。"
  },
  State_3051_Name = {
    Text = "灼蝋の欲望"
  },
  State_3051_WeaponDesc = {
    Text = "実際のダメージを与えたとき、1枚の泣き叫びをドロー山に混ぜる。"
  },
  State_3054_Name = {
    Text = "状態@呪いショック"
  },
  State_3055_Desc = {
    Text = "戦闘開始時に、味方に1点の抑圧を与える。"
  },
  State_3055_Name = {Text = "貫通"},
  State_3055_WeaponDesc = {
    Text = "バトル開始時、味方チームに 1 層の脆弱を与える。"
  },
  State_3056_Desc = {
    Text = "ターン終了時、1点の倦怠と軟化を除去。"
  },
  State_3056_Name = {Text = "威圧"},
  State_3058_Desc = {
    Text = "触腕1本につき、ターン終了時に[Arg1]シールドを獲得。"
  },
  State_3058_Name = {
    Text = "無名附肢"
  },
  State_3060_Desc = {
    Text = "次のターン開始時に[Layer]シールドを獲得。"
  },
  State_3060_Name = {
    Text = "精神再建"
  },
  State_3060_WeaponDesc = {
    Text = "次のターンの開始時に [Layer] 枚のカードを引く。"
  },
  State_3063_Desc = {
    Text = "ダメージを与えるたびに、[Layer]点の毒を付与する。"
  },
  State_3064_Desc = {
    Text = "カードを使用する前に、その点数に等しいダメージを受ける。ターン終了時に解除される。"
  },
  State_3064_Name = {Text = "束縛"},
  State_3064_WeaponDesc = {
    Text = "カードを出す前に同等の層数のダメージを受けます。ターン終了時に解除されます。"
  },
  State_3065_Name = {
    Text = "状態@遺物古の供物2"
  },
  State_3068_Desc = {
    Text = "ターン終了後、[Layer] 点の<FixedDamage:純粋ダメージ>を受ける。"
  },
  State_3068_Name = {
    Text = "<IntoxicationColour:毒>"
  },
  State_3068_WeaponDesc = {
    Text = "ターン終了後、[Layer] 点の<FixedDamage:純粋ダメージ>を受ける。"
  },
  State_3069_Name = {
    Text = "「密約」機神降臨"
  },
  State_3069_WeaponDesc = {
    Text = "各戦闘の最初のターンに 1 点の追加計算力を獲得。"
  },
  State_3070_Desc = {
    Text = "チーム唯一：装備者の「打撃」は対象の敵から装備者の攻撃力の<WeaponEffect_Num:[StateArg1]％>に等しい一時的な<PowerIconKeywords:力>を減少させる。この効果は1ターンに最大3回発動する。"
  },
  State_3070_WeaponDesc = {
    Text = "装備者の「打撃」は対象の敵の一時的な<PowerIconKeywords:力>を<WeaponEffect_Num:[Power:DescArg1]>点減少させる。この効果は1ターンに最大3回発動する。"
  },
  State_3071_Desc = {
    Text = "チーム唯一：装備者の「防御」を出した後、装備者の攻撃力の<WeaponEffect_Num:[StateArg1]％>に等しい一時的な<PowerIconKeywords:力>を獲得する。"
  },
  State_3071_WeaponDesc = {
    Text = "装備者の「防御」を出した後、<WeaponEffect_Num:[Power:DescArg1]>点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  State_3072_Desc = {
    Text = "チーム唯一：装備者が敵を撃破した後、<WeaponEffect_Num:[StateArg1]>狂気を獲得し、1％のクリティカルダメージを獲得する。探索全体で有効。"
  },
  State_3072_WeaponDesc = {
    Text = "装備者が敵を撃破した後、<WeaponEffect_Num:[StateArg1]>狂気を獲得し、1％のクリティカルダメージを獲得する。探索全体で有効。"
  },
  State_3073_Desc = {
    Text = "チーム唯一：装備者が狂気解放を発動した後、全味方の本ターンのクリティカル率が<WeaponEffect_Num:[StateArg1]％>増加する。"
  },
  State_3073_WeaponDesc = {
    Text = "装備者が狂気解放を発動した後、全味方の本ターンのクリティカル率が<WeaponEffect_Num:[StateArg1]％>増加する。"
  },
  State_3074_Desc = {
    Text = "チーム唯一：症状カードを1枚出した後、装備者は<WeaponEffect_Num:[StateArg1]>点の狂気を獲得する。この効果は1ターンに最大2回発動する。装備者が指令カードを1枚出した後、1点の狂気を獲得する。"
  },
  State_3074_WeaponDesc = {
    Text = "症状カードを1枚出した後、装備者は<WeaponEffect_Num:[StateArg1]>点の狂気を獲得する。この効果は1ターンに最大2回発動する。装備者が指令カードを1枚出した後、1点の狂気を獲得する。"
  },
  State_3075_Desc = {
    Text = "チーム唯一：装備者が狂気解放を発動した後、装備者の防御力の<WeaponEffect_Num:[StateArg1]％>に等しいシールドを獲得する。"
  },
  State_3075_Name = {
    Text = "心の障壁"
  },
  State_3075_WeaponDesc = {
    Text = "装備者が狂気解放を発動した後、<WeaponEffect_Num:[Block:DescArg1]>点のシールドを獲得する。"
  },
  State_3076_Desc = {
    Text = "チームユニーク：装備者がアクティブダメージを与えた後、クリティカル率が <WeaponEffect_Num:[StateArg1]%> 上昇し、クリティカルを与えた後にこの効果で獲得したクリティカル率をリセットする。"
  },
  State_3076_WeaponDesc = {
    Text = "装備者がアクティブダメージを与えた後、クリティカル率が <WeaponEffect_Num:[StateArg1]%> 上昇し、クリティカルを与えた後にこの効果で獲得したクリティカル率をリセットする。"
  },
  State_3078_Desc = {
    Text = "このターンに与えるダメージは必ずクリティカルになる。"
  },
  State_3078_Name = {
    Text = "一時的な必中"
  },
  State_3078_WeaponDesc = {
    Text = "このターンのクリティカル率が100%増加する"
  },
  State_3082_Desc = {
    Text = "狂気解放後、対応する覚醒体のランダムカードを手札に追加。そのカードは消費と虚無を獲得。"
  },
  State_3082_Name = {
    Text = "医者のカバン"
  },
  State_3084_Desc = {
    Text = "使用した後、カードの[StateArg1]枚のコピーを一時的に<DimensionalSpaceIconKeywords:超次元空間>に加える。"
  },
  State_3084_Name = {
    Text = "<Rune_13_High:上位転送>"
  },
  State_3084_WeaponDesc = {
    Text = "打出後消費，しかし [StateArg1] 枚の一時的原始コピーを超次元空間に投入する。"
  },
  State_3087_Desc = {
    Text = "攻撃カードのダメージが[Layer]%増加する。"
  },
  State_3087_Name = {
    Text = "攻撃カードダメージ一時的増加"
  },
  State_3087_WeaponDesc = {
    Text = "打撃牌のダメージが [Layer] ％ 上昇します。"
  },
  State_3088_Desc = {
    Text = "受けるアクティブダメージが[Layer]増加する。ダメージを受けるたびに融蝕の傷口が広がり、融蝕深度が増加する。次のターン開始時に回復する。"
  },
  State_3088_Name = {
    Text = "融蝕深度"
  },
  State_3088_WeaponDesc = {
    Text = "受けた能動的なダメージが[Layer]アップする。毎回ダメージを受けると融食傷口が広がり、ターン開始時に治癒する。"
  },
  State_3092_Name = {
    Text = "ボス戦の場合、すべての覚醒体は30狂気を獲得し、封印状態を解除する"
  },
  State_3093_Name = {
    Text = "ステータス@奇術師の模倣カウント"
  },
  State_3094_Desc = {
    Text = "抽到時に自身を脆弱にする 1 ターン。使用後、すべての敵に弱点を与える 1 ターン。売却不可。"
  },
  State_3094_Name = {
    Text = "状態呪い崩壊"
  },
  State_3094_WeaponDesc = {
    Text = "抽到時に自身を脆弱にする 1 ターン。使用後、すべての敵に弱点を与える 1 ターン。売却不可。"
  },
  State_3095_Desc = {
    Text = "このステージで与えるダメージが [Layer] 増加。"
  },
  State_3095_Name = {
    Text = "永続の力"
  },
  State_3095_WeaponDesc = {
    Text = "このステージで与えるダメージが[Layer]増加。"
  },
  State_3096_Desc = {
    Text = "ロータンを説得するにはまだまだ時間がかかる。"
  },
  State_3096_Name = {
    Text = "ロータンの覚醒"
  },
  State_3098_Desc = {
    Text = "拾取後、カードを1選択し、その計算力消費を永久に1にする。"
  },
  State_3099_Desc = {
    Text = "狂気解放発動後、このターン、[Arg1]力を獲得。"
  },
  State_3100_Desc = {
    Text = "各ターン開始時に死亡抵抗が10％増加。死亡抵抗が100％を超えると界域知識が30増加。"
  },
  State_3104_Desc = {
    Text = "このターン、アクティブダメージを受けるたびに「甘美なる悪鬼」のダメージ回数が1増加。"
  },
  State_3104_Name = {
    Text = "痛みの共有"
  },
  State_3104_WeaponDesc = {
    Text = "このターン内、1回の積極的なダメージを受けるごとに、「甘い悪鬼」のダメージ回数が＋1されます。"
  },
  State_3106_Desc = {
    Text = "ライフが50%([StateArg1])未満になると、「前衛的な習作」2体に分裂する。"
  },
  State_3106_WeaponDesc = {
    Text = "ライフが 50%([StateArg1]) 未満になったとき、「II型融解体ワックス像」にスプリットし、3体の同じライフを持つ。"
  },
  State_3108_Name = {
    Text = "「密約」環状詩篇"
  },
  State_3108_WeaponDesc = {
    Text = "偶数ターン開始後、1点の計算力を獲得します。"
  },
  State_3109_Name = {
    Text = "ステータス@第四章共鳴@計算力減る1"
  },
  State_3109_WeaponDesc = {
    Text = "「天真的回礼」の計算力消費が1減少する"
  },
  State_3110_Name = {
    Text = "ステータス@第四章共鳴@計算力減る1"
  },
  State_3110_WeaponDesc = {
    Text = "「天真的回礼」の計算力消費が1減少する"
  },
  State_3111_Desc = {
    Text = "次のターン開始時に残りのシールドを2倍のライフに変換する。"
  },
  State_3111_Name = {
    Text = "不滅の花"
  },
  State_3112_Desc = {
    Text = "チーム唯一：装備者が与える毒の効果が<WeaponEffect_Num:[StateArg3]%>増加する。装備者が狂気爆発を発動した後、装備者の体質の<WeaponEffect_Num:[StateArg1]%>に相当するライフを回復し、算力が1ポイント残るごとに装備者の体質の<WeaponEffect_Num:[StateArg2]%>のライフを追加回復する。"
  },
  State_3112_Name = {
    Text = "無声の宴"
  },
  State_3112_WeaponDesc = {
    Text = "装備者が与える毒の効果が<WeaponEffect_Num:[StateArg3]%>増加する。装備者が狂気爆発を発動した後、<WeaponEffect_Num:[Heal:DescArg1]>ポイントのライフを回復し、算力が1ポイント残るごとに<WeaponEffect_Num:[Heal:DescArg2]>ポイントのライフを追加回復する。"
  },
  State_3113_Desc = {
    Text = "ステータス@序章狂気0＿1＿4"
  },
  State_3113_Name = {
    Text = "ステータス@序章狂気0＿1＿4"
  },
  State_3113_WeaponDesc = {
    Text = "ステータス@序章狂気0＿1＿4"
  },
  State_3114_Desc = {
    Text = "ステータス@序章狂気0＿1＿2"
  },
  State_3114_Name = {
    Text = "ステータス@序章狂気0＿1＿2"
  },
  State_3114_WeaponDesc = {
    Text = "ステータス@序章狂気0＿1＿2"
  },
  State_3115_Desc = {
    Text = "ステータス@序章狂気0＿1＿2"
  },
  State_3115_Name = {
    Text = "ステータス@序章狂気0＿1＿2"
  },
  State_3115_WeaponDesc = {
    Text = "ステータス@序章狂気0＿1＿2"
  },
  State_3116_Name = {
    Text = "状態@序章狂気0_1_1"
  },
  State_3117_Desc = {
    Text = "チーム唯一：装備者の「攻撃」と「狂気解放」の基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。装備者が「攻撃」を出した後、装備者は5%の一時クリティカル率を獲得する。毎ターン最大3回、3回に達すると15%の一時クリティカルダメージを獲得する。"
  },
  State_3117_WeaponDesc = {
    Text = "装備者の「攻撃」と「狂気解放」の基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。装備者が「攻撃」を出した後、装備者は5%の一時クリティカル率を獲得する。毎ターン最大3回、3回に達すると15%の一時クリティカルダメージを獲得する。"
  },
  State_3118_Desc = {
    Text = "ターン開始時に失ったライフの[Layer]%を回復する。"
  },
  State_3118_Name = {
    Text = "導舵の帆の加護"
  },
  State_3120_Desc = {
    Text = "[防御]獲得 [Arg1] つのカウンター。"
  },
  State_3121_Desc = {
    Text = "敵の行動予測が「攻撃」でない場合、能動的または触腕でダメージを与えた後、ダメージの半分に等しい層数の出血を付与する。"
  },
  State_3123_Desc = {
    Text = "チーム唯一：装備者が与える<RetaliateIconKeywords:反撃>の効果が<WeaponEffect_Num:[StateArg3]%>増加する。攻撃を1回受けるごとに、装備者の攻撃力の<WeaponEffect_Num:[StateArg1]%>に相当する一時的な<PowerIconKeywords:力量>を獲得する。装備者が狂気爆発を使用した後、装備者の攻撃力の<WeaponEffect_Num:[StateArg2]%>に相当する<RetaliateIconKeywords:反撃>を獲得する。"
  },
  State_3123_WeaponDesc = {
    Text = "装備者が与える反撃の効果が<WeaponEffect_Num:[StateArg3]%>増加する。攻撃を1回受けるごとに、<WeaponEffect_Num:[Power:DescArg1]>ポイントの一時的な<PowerIconKeywords:力量>を獲得する。装備者が狂気爆発を使用した後、<WeaponEffect_Num:[Counterattack:DescArg2]>ポイントの反撃を獲得する。"
  },
  State_3124_Desc = {
    Text = "ラッキー探偵が獲得するブラックスタンプが2倍になる。"
  },
  State_3124_Name = {
    Text = "絶好の運"
  },
  State_3124_WeaponDesc = {
    Text = "ラッキー探偵が獲得するブラックスタンプが2倍になる。"
  },
  State_3127_Name = {
    Text = "状態@ステージ2_10戦闘3バブル1"
  },
  State_3128_Desc = {
    Text = "すべての覚醒体が獲得するシールドと与えるライフ回復効果が[StateArg1]%増加する。"
  },
  State_3128_Name = {
    Text = "揺りかご"
  },
  State_3129_Desc = {
    Text = "次のターン開始前にアクティブダメージを受けるたびに、カウンターと触手カウンターを追加で [Layer] 回発動し、50% のダメージを与える。"
  },
  State_3129_Name = {
    Text = "逆鱗の守り"
  },
  State_3130_Desc = {
    Text = "このターンに与えるダメージが[Layer]増加。"
  },
  State_3130_Name = {
    Text = "一時的な力"
  },
  State_3130_WeaponDesc = {
    Text = "このターンに与えるダメージが[Layer]増加。"
  },
  State_3135_Desc = {
    Text = "1層所持するごとに、与える能動ダメージの回数が+1。"
  },
  State_3135_Name = {
    Text = "<MadnessIconKeywords:狂気>"
  },
  State_3136_Name = {Text = "狂気"},
  State_3137_Desc = {
    Text = "戦闘開始時、1本の触腕を獲得。触腕ダメージが永久に[Arg1]向上。"
  },
  State_3138_Name = {
    Text = "「密約」二律背反"
  },
  State_3138_WeaponDesc = {
    Text = "装備者が狂気解放を使用后、味方は装備者の防御力の 100% に基づいて<RetaliateIconKeywords:カウンター>を獲得する。さらに自身の現在の<RetaliateIconKeywords:カウンター>が 10% 向上する。"
  },
  State_3139_Desc = {
    Text = "超次元ターンに入った後、自身の虚弱と脆弱状態を解除し、すべての敵に2ターンの<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  State_3140_Desc = {
    Text = "戦闘開始時、超次元空間が4枚になるまで「幻覚」を超次元空間に置く。"
  },
  State_3143_Desc = {
    Text = "実際にダメージを与えた時、味方チームから[Layer]点の力を一時的に減少させる。"
  },
  State_3143_Name = {Text = "麻痺"},
  State_3144_Name = {
    Text = "味方チームの「毒」と「出血」の点数が半減する。"
  },
  State_3145_Desc = {
    Text = "[Layer]ターンの間、カード使用不可。"
  },
  State_3145_Name = {
    Text = "カード使用不可"
  },
  State_3146_Desc = {
    Text = "海の使徒が1枚のカードを出すと、[StateArg1]本の一時的な触腕が生成され、この触腕は触腕の上限を無視できます。"
  },
  State_3146_Name = {
    Text = "代行権能"
  },
  State_3146_WeaponDesc = {
    Text = "海の使徒が1枚のカードを出すと、[StateArg1]本の一時的な触腕が生成され、この触腕は触腕の上限を無視できます。"
  },
  State_3149_Desc = {
    Text = "次のターン開始時、受けるアクティブおよび触手ダメージが 50 ％上昇する。"
  },
  State_3149_Name = {
    Text = "遅延易傷"
  },
  State_3149_WeaponDesc = {
    Text = "受けたすべてのダメージが 50 ％ 上昇する。"
  },
  State_3150_Desc = {
    Text = "1 ターン内に 3 回攻撃を受けた後、1 スタックの一時的<MadnessColour:発狂>を獲得する。"
  },
  State_3150_Name = {
    Text = "「甘美な痛み」"
  },
  State_3151_Desc = {
    Text = "拾取時永久獲得 [Arg1] 点パワー。"
  },
  State_3152_Name = {
    Text = "状態@「密約」再進化"
  },
  State_3152_WeaponDesc = {
    Text = "装備者のターン終了時に3点の狂気を獲得する。装備者の狂気回復が10より大きい場合、追加で2点の狂気を獲得する。"
  },
  State_3153_Name = {
    Text = "状態@呪い錯乱還元"
  },
  State_3154_Name = {
    Text = "クリティカル率"
  },
  State_3155_Desc = {
    Text = "各ターン、失ったライフの10%を回復する。"
  },
  State_3155_Name = {Text = "医療"},
  State_3155_WeaponDesc = {
    Text = "各ターン 10％ の失われたライフを回復する。"
  },
  State_3156_Desc = {
    Text = "各ターン、最初に受けるダメージが5倍になる。"
  },
  State_3156_Name = {
    Text = "パニック"
  },
  State_3160_Desc = {
    Text = "ターン開始時、このターン中に[Arg1]警戒を獲得する「日傘」を1枚手札に追加。カードを6枚使用すると、手札のすべての「日傘」の警戒が[Arg2]増加する。"
  },
  State_3161_Desc = {
    Text = "相手のドロー枚数が [Layer] 減少するが、すべてのカードが保持される。"
  },
  State_3161_WeaponDesc = {
    Text = "味方チームのドローするカードの数量が減少 [Layer] 、すべてのカードが保持されるようにする"
  },
  State_3163_Desc = {
    Text = "死亡抵抗が発動された後、[Layer] ポイントのライフを返信する。"
  },
  State_3163_Name = {
    Text = "星のゆりかご"
  },
  State_3163_WeaponDesc = {
    Text = "死亡抵抗が発動された後、[Layer] ポイントのライフを返信する。"
  },
  State_3164_Desc = {Text = "――"},
  State_3164_Name = {
    Text = "もやもやとした怨恨とカウント"
  },
  State_3164_WeaponDesc = {Text = "――"},
  State_3165_Name = {
    Text = "ランナー霊感3"
  },
  State_3166_Name = {
    Text = "この戦闘が開始されました"
  },
  State_3168_Desc = {
    Text = "ターン開始時に全モンスターの攻撃回数カウンターを1増やす"
  },
  State_3168_Name = {
    Text = "状態@復讐の巨刃斬首一閃"
  },
  State_3168_WeaponDesc = {
    Text = "ターン開始時に全モンスターの攻撃回数カウンターを1増やす"
  },
  State_3170_Desc = {
    Text = "衝動の代償"
  },
  State_3170_Name = {
    Text = "衝動の代償"
  },
  State_3170_WeaponDesc = {
    Text = "衝動の代償"
  },
  State_3171_Name = {
    Text = "状態@ステージ2_1戦闘3バブル1"
  },
  State_3172_Desc = {
    Text = "ダメージを与えるたびに、一時的な[StateArg1]力を獲得し、最大[StateArg2]回までスタックする。回が満たされると効果が倍増する。__「開発用」"
  },
  State_3172_Name = {
    Text = "遺物血染めの小石__「開発用」"
  },
  State_3174_Desc = {
    Text = "ライフ上限が30％減少する。"
  },
  State_3174_Name = {
    Text = "遺物六分儀2"
  },
  State_3174_WeaponDesc = {
    Text = "ライフ上限が30％減少する。"
  },
  State_3175_Desc = {
    Text = "毎ターンの開始時にすべての覚醒体は 10 の狂気を得る。"
  },
  State_3175_Name = {
    Text = "遺物六分儀1"
  },
  State_3175_WeaponDesc = {
    Text = "毎ターンの開始時にすべての覚醒体は 10 の狂気を得る。"
  },
  State_3176_Desc = {
    Text = "プロローグリセットデッキ0＿1＿1＿1"
  },
  State_3176_Name = {
    Text = "序章デッキリセット0_1_1_1_2"
  },
  State_3176_WeaponDesc = {
    Text = "プロローグリセットデッキ0＿1＿1＿1"
  },
  State_3177_Desc = {
    Text = "「警鐘」が3回に達すると後退し、「替身の蝋人形」を召喚する。ターン開始時に回数をリセットする。"
  },
  State_3177_Name = {Text = "警鐘"},
  State_3177_WeaponDesc = {
    Text = "「警戒」が 3 スタックに達すると後退し、「替身のワックス像」を召喚する。ターン開始時にスタックをクリアする。"
  },
  State_3178_Desc = {
    Text = "カードの行動力消費を増やす。"
  },
  State_3178_Name = {
    Text = "<SlowIconKeywords:鈍化>"
  },
  State_3178_WeaponDesc = {
    Text = "各层の遅延により、カードの計算力消費が 1 ポイント増加します。"
  },
  State_3179_Desc = {
    Text = "バトル開始時に 20 のシールドを獲得する。各ターン開始時にシールドがある場合、そのターンのシールドと治療の強力が 50％ 上昇する。"
  },
  State_3179_Name = {
    Text = "異化花園の守護者"
  },
  State_3179_WeaponDesc = {
    Text = "バトル開始時に 20 のシールドを獲得する。各ターン開始時にシールドがある場合、そのターンのシールドと治療の強力が 50％ 上昇する。"
  },
  State_3180_Desc = {
    Text = "クリティカル率が25%増加。ライフ回復を行った後、追加で1回ライフ回復を行う可能性があり、その確率は回復を行った者のクリティカル率に等しい。__「開発用」"
  },
  State_3180_Name = {
    Text = "状態@幻夢のシルバーキー：クリティカル治癒__「開発用」"
  },
  State_3181_Name = {
    Text = "クリティカル率"
  },
  State_3183_Desc = {
    Text = "このターン内クリティカルダメージが [Layer] ％ 上昇。"
  },
  State_3183_Name = {
    Text = "一時的なクリティカルダメージ"
  },
  State_3185_Desc = {
    Text = "移動時に追加のプレッシャーが増える"
  },
  State_3185_Name = {
    Text = "遺物底なし袋2"
  },
  State_3185_WeaponDesc = {
    Text = "移動時に追加のプレッシャーが増える"
  },
  State_3189_Name = {
    Text = "敵遅延力"
  },
  State_3190_Name = {Text = "遺物鍵"},
  State_3193_Desc = {
    Text = "次のターン開始時に[Layer]シールドを獲得。"
  },
  State_3193_Name = {
    Text = "失われた芸術"
  },
  State_3193_WeaponDesc = {
    Text = "次のターンの開始後に [Layer] シールドを獲得します。"
  },
  State_3196_Desc = {
    Text = "打出後獲得 [StateArg1] 点計算力。"
  },
  State_3196_Name = {
    Text = "<Rune_4_High:上位策謀>"
  },
  State_3196_WeaponDesc = {
    Text = "打出後獲得 [StateArg1] 点計算力。"
  },
  State_3197_Desc = {
    Text = "「攻撃」で[Arg1]点のライフを回復し、自身の出血と毒の点数を半減させる。"
  },
  State_3197_Name = {Text = "止血鉗"},
  State_3200_Desc = {
    Text = "チーム唯一：装備者が与える基礎ダメージとシールドが<WeaponEffect_Num:[StateArg1]%>増加する。探索開始時、装備者の「攻撃」と「防御」を1枚ずつデッキに加える。装備者が「防御」を出した後、装備者の次の「攻撃」のクリティカル率とクリティカルダメージが15%増加する。装備者が「攻撃」を出した後、装備者の次の「防御」のシールドが15%増加する。3回まで累積可能。"
  },
  State_3200_WeaponDesc = {
    Text = "装備者が与える基礎ダメージとシールドが<WeaponEffect_Num:[StateArg1]%>増加する。探索開始時、装備者の「攻撃」と「防御」を1枚ずつデッキに加える。装備者が「防御」を出した後、装備者の次の「攻撃」のクリティカル率とクリティカルダメージが15%増加する。装備者が「攻撃」を出した後、装備者の次の「防御」のシールドが15%増加する。3回まで累積可能。"
  },
  State_3201_Desc = {Text = "――"},
  State_3201_Name = {
    Text = "恨みの連鎖"
  },
  State_3201_WeaponDesc = {Text = "――"},
  State_3203_Desc = {
    Text = "チームユニーク：装備者が与えるシールドが <WeaponEffect_Num:[StateArg3]%> 上昇する。装備者の「防御」はライフが最も高い敵に装備者の防御力の <WeaponEffect_Num:[StateArg1]%> の<IntoxicationIconKeywords:毒>を与える。現在の界域が「血肉」の場合、<IntoxicationIconKeywords:毒>を付与する際に<EmbryoFusionIconKeywords:胚胎融合> + <WeaponEffect_Num:[Blood:StateArg2]>、この効果は 1 ターンに最大 3 回発動する。"
  },
  State_3203_WeaponDesc = {
    Text = "装備者が与えるシールドが <WeaponEffect_Num:[StateArg3]%> 上昇する。装備者の「防御」はライフが最も高い敵に <WeaponEffect_Num:[Poison:DescArg1]> 層の<IntoxicationIconKeywords:毒>を与える。現在の界域が「血肉」の場合、<IntoxicationIconKeywords:毒>を付与する際に<EmbryoFusionIconKeywords:胚胎融合> +<WeaponEffect_Num:[Blood:StateArg2]>、この効果は 1 ターンに最大 3 回発動する。"
  },
  State_3204_Desc = {
    Text = "実際のダメージを与えるとき、[StateArg1] 枚の「傷」をドロー山にシャッフルして戻す。"
  },
  State_3204_Name = {Text = "裂傷"},
  State_3204_WeaponDesc = {
    Text = "抽到時に自身に弱り状態を1ターン与える。使用後、すべての敵に弱り状態を1ターン与える。売却不可。"
  },
  State_3206_Desc = {
    Text = "1枚のカードをプレイするごとに、このターン中のクリティカルレートが[StateArg1]％上昇し、最大[StateArg2]回までスタック可能。スタックが満タンになると効果が2倍になります。"
  },
  State_3206_Name = {
    Text = "遺物メンフィスの儀式鏡__「開発用」"
  },
  State_3206_WeaponDesc = {
    Text = "1枚のカードをプレイするごとに、このターン中のクリティカルレートが[StateArg1]％上昇し、最大[StateArg2]回までスタック可能。スタックが満タンになると効果が2倍になります。"
  },
  State_3207_Desc = {
    Text = "ライフを1点失うごとに1点を除去し、0点になると[DescArg1]のシールドを獲得。"
  },
  State_3207_Name = {
    Text = "次元障壁"
  },
  State_3208_Desc = {
    Text = "石化中、行動不能、ターン終了後に解除。"
  },
  State_3209_Name = {
    Text = "「密約」生命力搾取"
  },
  State_3209_WeaponDesc = {
    Text = "バトル開始後、装備者の職業が血肉の場合、攻撃力が 25％、上昇します。"
  },
  State_3210_Name = {
    Text = "状態@復讐の大剣霊知啓発1"
  },
  State_3211_Desc = {
    Text = "手札の上限+2、ターン終了時に手札を捨てない。ライフを失うたびにランダムで2枚の手札を捨てる。__「開発用」"
  },
  State_3212_Desc = {
    Text = "与えるアクティブダメージと触手ダメージが25％減少し、ターン終了時に1スタック除去する。"
  },
  State_3212_Name = {
    Text = "<WeaknessIconKeywords:倦怠>"
  },
  State_3212_WeaponDesc = {
    Text = "受けたダメージが 25％ 減少します。"
  },
  State_3213_Desc = {
    Text = "シールドと治療の効果が[Layer]％向上する"
  },
  State_3213_Name = {
    Text = "一時的なシールドと治癒力強化"
  },
  State_3213_WeaponDesc = {
    Text = "シールドと治療の効果が[Layer]％向上する"
  },
  State_3215_Name = {
    Text = "時の振り子「隠秘」"
  },
  State_3216_Desc = {
    Text = "バトル終了後、追加で 100 ブラックスタンプを獲得するが、1枚の症状カードを入手する。"
  },
  State_3216_Name = {
    Text = "遺物幸運の指輪"
  },
  State_3216_WeaponDesc = {
    Text = "バトル終了後、追加で 100 ブラックスタンプを獲得するが、1枚の症状カードを入手する。"
  },
  State_3220_Desc = {
    Text = "狂気解放を発動すると、カードを1枚引く。ライフが25%未満の場合、1枚引く。"
  },
  State_3223_Desc = {
    Text = "与える虚弱効果が10％増加。3ターンごとにすべての敵に1回の虚弱を付与する。"
  },
  State_3224_Name = {
    Text = "遺物アルカナ記録行動力"
  },
  State_3225_Name = {
    Text = "首切りの一撃"
  },
  State_3226_Desc = {
    Text = "使用するとカードは捨て札に行かず、この戦闘では再び使用できない。"
  },
  State_3226_Name = {Text = "除外"},
  State_3226_WeaponDesc = {
    Text = "使用するとカードは捨て札に行かず、この戦闘では再び使用できない。"
  },
  State_3227_Desc = {
    Text = "すべての造物の価格が 50％ 下がります。"
  },
  State_3227_Name = {
    Text = "遺物交易勲章__「開発用」"
  },
  State_3227_WeaponDesc = {
    Text = "すべての造物の価格が 50％ 下がります。"
  },
  State_3228_Desc = {
    Text = "ターン開始時、狂気が最も低い覚醒体が25狂気を獲得する"
  },
  State_3228_Name = {
    Text = "遺物アルカナ狂気"
  },
  State_3228_WeaponDesc = {
    Text = "ターン開始時、狂気が最も低い覚醒体が25狂気を獲得する"
  },
  State_3229_Desc = {
    Text = "プロローグリセットデッキ0＿1＿1＿1"
  },
  State_3229_Name = {
    Text = "プロローグリセットデッキ0＿1＿1＿1"
  },
  State_3229_WeaponDesc = {
    Text = "プロローグリセットデッキ0＿1＿1＿1"
  },
  State_3230_Name = {
    Text = "状態@汎用遅延行動力"
  },
  State_3232_Desc = {
    Text = "状態@モンスター超次元スロットトリガー"
  },
  State_3232_Name = {
    Text = "状態@モンスター超次元スロットトリガー"
  },
  State_3232_WeaponDesc = {
    Text = "ステータス@モンスター超次元スロットのトリガー"
  },
  State_3234_Desc = {
    Text = "戦闘開始時、3の力を獲得。が、受けるダメージが5増加する。__「開発用」"
  },
  State_3235_Desc = {
    Text = "戦闘開始時、[Layer]の力を獲得。が、受けるダメージが5増加する。"
  },
  State_3236_Desc = {
    Text = "使用した後、他の覚醒体が[StateArg1]狂気を獲得する。"
  },
  State_3236_Name = {
    Text = "<Rune_16_High:上位触媒>"
  },
  State_3237_Desc = {
    Text = "3ターンごとに3本の触腕を獲得。この触腕は触腕上限を無視し、ターン終了時に除去される。"
  },
  State_3238_Desc = {
    Text = "バトル開始時にモンスターが受けるすべてのダメージがアップするステータスを付与する"
  },
  State_3238_Name = {
    Text = "バトル開始時にモンスターが受けるすべてのダメージがアップするステータスを付与する"
  },
  State_3238_WeaponDesc = {
    Text = "バトル開始時にモンスターが受けるすべてのダメージがアップするステータスを付与する"
  },
  State_3239_Desc = {
    Text = "[Layer]点の攻撃力を上げる。"
  },
  State_3239_Name = {
    Text = "汎用攻撃力増加"
  },
  State_3239_WeaponDesc = {
    Text = "[Layer]点の攻撃力を上げる。"
  },
  State_3242_Name = {
    Text = "<DerivativeCardKeywords_4:「啓示」>を2枚山札に加える"
  },
  State_3243_Desc = {
    Text = "カードの計算力が増加"
  },
  State_3243_Name = {
    Text = "カードの計算力が増加"
  },
  State_3243_WeaponDesc = {
    Text = "カードの行動力消費減少"
  },
  State_3244_Desc = {
    Text = "召喚されたモンスターのライフが倍増する。"
  },
  State_3244_Name = {
    Text = "「横流の恥」"
  },
  State_3244_WeaponDesc = {
    Text = "召喚されたモンスターのライフが2倍になる。"
  },
  State_3245_Desc = {
    Text = "戦闘開始時、味方チームのクリティカル率が30%減少し、クリティカルダメージが30%増加する。"
  },
  State_3245_WeaponDesc = {
    Text = "バトル開始時、味方チームのクリティカルレートが30％低下し、クリティカルダメージが30％アップする。"
  },
  State_3246_Desc = {
    Text = "バトル開始時、普通敵人のライフが30％増加し、バトル勝利後に追加で25ブラックスタンプを提供します。"
  },
  State_3246_Name = {
    Text = "遺物破れた戦旗"
  },
  State_3246_WeaponDesc = {
    Text = "バトル開始時、普通敵人のライフが30％増加し、バトル勝利後に追加で25ブラックスタンプを提供します。"
  },
  State_3247_Desc = {
    Text = "【狂気解放】すべての手札の計算力消費 -1。"
  },
  State_3247_Name = {
    Text = "異化文明の光"
  },
  State_3247_WeaponDesc = {
    Text = "【狂気解放】すべての手札の計算力消費 -1。"
  },
  State_3249_Desc = {
    Text = "他の味方が 1 スタックの<MadnessColour:発狂>を獲得し、自身の死亡後に解除される。"
  },
  State_3249_Name = {Text = "動揺"},
  State_3249_WeaponDesc = {
    Text = "他の味方が 1 層の狂気を獲得し、自身が死亡後に解除する。"
  },
  State_3250_Desc = {
    Text = "戦闘終了後も山札に残るが、使用または消費されると永久に除去される。"
  },
  State_3250_Name = {
    Text = "<DestructionKeywords:消滅>"
  },
  State_3250_WeaponDesc = {
    Text = "打出後、それを永久に削除します。"
  },
  State_3251_Desc = {
    Text = "アクティブまたは触手ダメージを受けた時、ダメージ無効し1スタック減少、ターン開始時に除去される。"
  },
  State_3251_Name = {
    Text = "<ParcloseColour: 一時的なバリア>"
  },
  State_3252_Desc = {
    Text = "スラッグフラワーがシールドを付与すると、最大ライフが[StateArg2]上昇します。"
  },
  State_3252_Name = {
    Text = "粘液の集まり"
  },
  State_3252_WeaponDesc = {
    Text = "スラッグフラワーがシールドを付与すると、最大ライフが[StateArg2]上昇します。"
  },
  State_3253_Desc = {
    Text = "[StateArg1] 点の一時的な警戒を獲得。"
  },
  State_3253_Name = {
    Text = "<CardKeyWord:機械武装-盾>"
  },
  State_3253_WeaponDesc = {
    Text = "獲得[StateArg1]ポイントの一時警戒"
  },
  State_3255_Name = {Text = "反撃"},
  State_3256_Name = {
    Text = "状態@呪い興奮"
  },
  State_3259_Desc = {
    Text = "与えるアクティブダメージの回数が [Layer] 上昇する。"
  },
  State_3259_Name = {
    Text = "<MadnessColour:発狂>"
  },
  State_3260_Desc = {
    Text = "超次元空間が上限に達した時、追加ターンを獲得する。このターンではカードを引かず、超次元空間のカードを手札に加える。"
  },
  State_3260_Name = {
    Text = "<DimensionalSpaceIconKeywords:超次元空間>"
  },
  State_3260_WeaponDesc = {
    Text = "超次元空間が上限に達したとき、追加の超次元ターンを獲得し、すべての超次元空間カードを手札に加える。"
  },
  State_3261_Desc = {
    Text = "召喚された敵のダメージが2倍になります。"
  },
  State_3261_Name = {
    Text = "「蝋人形軍団」"
  },
  State_3261_WeaponDesc = {
    Text = "その召喚したモンスターのダメージが2倍になります。"
  },
  State_3262_Desc = {
    Text = "ステータス＠ワックスコーティング味方チーム"
  },
  State_3262_Name = {
    Text = "ステータス＠ワックスコーティング味方チーム"
  },
  State_3262_WeaponDesc = {
    Text = "ステータス＠ワックスコーティング味方チーム"
  },
  State_3263_Name = {
    Text = "状態@忘失の鸚鵡螺反撃"
  },
  State_3265_Name = {
    Text = "捨てる時にこのカードを除去する"
  },
  State_3266_Desc = {
    Text = "死せる夢の都の強化跳躍"
  },
  State_3266_Name = {
    Text = "状態@死せる夢の都強化跳躍"
  },
  State_3267_Desc = {
    Text = "バトル開始時、5 層の【ロウ質の鎧】を獲得。"
  },
  State_3267_Name = {
    Text = "「蝋の紳士」"
  },
  State_3267_WeaponDesc = {
    Text = "バトル開始時、5 層の【ロウ質の鎧】を獲得。"
  },
  State_3268_Desc = {
    Text = "ターン開始時に1枚のカードを引く。あなたが1枚のカードを引くたびに、そのカードの計算力消費がランダムで変化する(0-4)。"
  },
  State_3268_Name = {
    Text = "遺物万華鏡"
  },
  State_3268_WeaponDesc = {
    Text = "ターン開始時に1枚のカードを引く。あなたが1枚のカードを引くたびに、そのカードの計算力消費がランダムで変化する(0-4)。"
  },
  State_3269_Desc = {
    Text = "毎ターン2回目のシールドを得た後、[Arg1] 回の反撃を獲得。毎ターン4回目のシールドを得た後、すべての敵に1回の反撃ダメージを与える。"
  },
  State_3269_Name = {
    Text = "知無不言"
  },
  State_3270_Name = {
    Text = "状態@第二章共鳴コピー"
  },
  State_3271_Desc = {
    Text = "[打撃]すべての敵に [Arg1] 層 のポイズンを付与する。"
  },
  State_3272_Desc = {
    Text = "ガードされなかったダメージを与えた時、実ダメージの3倍のライフを回復。ダメージを与えると解除される。"
  },
  State_3273_Desc = {
    Text = "チーム唯一：装備者のカードを出した後、装備者の防御力の<WeaponEffect_Num:[StateArg1]%>に相当するシールドを獲得し、触腕1本ごとにシールドが装備者の防御力の<WeaponEffect_Num:[StateArg2]%>分増加する。この効果は1ターンに1回のみ発動する。"
  },
  State_3273_Name = {
    Text = "珊瑚の女の死"
  },
  State_3273_WeaponDesc = {
    Text = "装備者のカードを出した後、<WeaponEffect_Num:[Block:DescArg1]>のシールドを獲得し、触腕1本ごとにシールドが<WeaponEffect_Num:[DescArg2]>増加する。この効果は1ターンに1回のみ発動する。"
  },
  State_3274_Desc = {
    Text = "毎回能動的なダメージを受けたときに味方チームにカウントを1つ追加する"
  },
  State_3274_Name = {
    Text = "状態@復讐の巨刃斬首一閃味方チームカウント"
  },
  State_3274_WeaponDesc = {
    Text = "毎回能動的なダメージを受けたときに味方チームにカウントを1つ追加する"
  },
  State_3277_Desc = {
    Text = "打出後所属覚醒体が[StateArg1]点の狂気を獲得。"
  },
  State_3277_Name = {
    Text = "<Rune_5:発狂>"
  },
  State_3280_Name = {
    Text = "運命の剣"
  },
  State_3281_Desc = {
    Text = "アクティブダメージを増加させる。"
  },
  State_3281_Name = {
    Text = "<PowerIconKeywords:力>"
  },
  State_3281_WeaponDesc = {
    Text = "与えるダメージが増加。"
  },
  State_3282_Desc = {
    Text = "ダメージ回数とダメージが増加。"
  },
  State_3282_Name = {
    Text = "<CardKeyWord:アップグレード>"
  },
  State_3282_WeaponDesc = {
    Text = "ダメージ追加"
  },
  State_3283_Desc = {
    Text = "毎ターン開始時、[StateArg1] のライフを回復する。ライフが 50% より低い場合、回復量が [StateArg2] になる。"
  },
  State_3283_Name = {
    Text = "遺物乳香製剤__「開発用」"
  },
  State_3283_WeaponDesc = {
    Text = "毎ターン開始時、[StateArg1] のライフを回復する。ライフが 50% より低い場合、回復量が [StateArg2] になる。"
  },
  State_3287_Desc = {
    Text = "戦闘開始時、「霊感」2枚をあなたの山札に加える。戦闘に1回勝利するたび、この造物はアップグレードし、最大3回まで。"
  },
  State_3288_Desc = {
    Text = "ステータス@空状態"
  },
  State_3288_Name = {
    Text = "ステータス@空状態"
  },
  State_3288_WeaponDesc = {
    Text = "ステータス@空状態"
  },
  State_3289_Desc = {
    Text = "1点のダメージを受けるごとに1回減少。回数が0になると行動予測は「不滅の花」に変化し、防御寄りのスキルセットを使用する。"
  },
  State_3289_Name = {
    Text = "不滅の花"
  },
  State_3289_WeaponDesc = {
    Text = "1 ダメージを受けるごとに 1 層減少。層が 0 になると、防御モードに切り替わります。"
  },
  State_3290_Desc = {
    Text = "「ミリアム」だった異形は極度の偏執と絶望に陥った。彼女の最後の妄執を打ち砕き、この数千年にわたる狂気を終わらせる。"
  },
  State_3290_Name = {Text = "妄執"},
  State_3291_Desc = {
    Text = "実際のダメージを与えると、味方チームの一時的な力を3失う。__「開発用」"
  },
  State_3291_Name = {Text = "麻痺"},
  State_3292_Desc = {
    Text = "狂気解放をリリースする時、敵が 1 回ダメージを与えるたびに、[Arg1] 層のポイズンを追加"
  },
  State_3293_Desc = {
    Text = "このステージで与えるダメージが[Layer]減少する。"
  },
  State_3293_Name = {
    Text = "力の減少"
  },
  State_3293_WeaponDesc = {
    Text = "このステージで与えるダメージと触腕ダメージが[Layer]減少する。"
  },
  State_3294_Name = {
    Text = "状態@呪い疑心"
  },
  State_3296_Desc = {
    Text = "捨てるか使用する時にそれを除去する。"
  },
  State_3296_Name = {
    Text = "捨てるか使用する時にそれを除去する"
  },
  State_3296_WeaponDesc = {
    Text = "抽到時に自身に弱り状態を1ターン与える。使用後、すべての敵に弱り状態を1ターン与える。売却不可。"
  },
  State_3297_Desc = {
    Text = "ステータス@トゲの女王啓明＿形"
  },
  State_3297_Name = {
    Text = "ステータス@トゲの女王啓明＿形"
  },
  State_3297_WeaponDesc = {
    Text = "ステータス@トゲの女王啓明＿形"
  },
  State_3298_Desc = {
    Text = "このターン内の次の跳躍効果は必ず発動する。"
  },
  State_3298_Name = {
    Text = "跳躍は必ず発動する"
  },
  State_3298_WeaponDesc = {
    Text = "このターン内のワープ効果は条件なしで発動します。"
  },
  State_3301_Name = {
    Text = "星々の酒カウント"
  },
  State_3302_Desc = {
    Text = "永遠の凝結を付与"
  },
  State_3302_Name = {
    Text = "永遠の凝結を付与"
  },
  State_3302_WeaponDesc = {
    Text = "永遠の凝結を付与"
  },
  State_3304_Desc = {
    Text = "ターン終了時に、最後に使用した指令カードの対応覚醒体が15狂気を獲得。「母の像」を持っている場合、他の覚醒体も5狂気を獲得。"
  },
  State_3305_Desc = {
    Text = "使用した後、「霊感」を[StateArg1]枚山札に加えてシャッフルする。「霊感」：算力を1獲得し、1枚ドローする。保留、消耗。"
  },
  State_3305_Name = {
    Text = "<Rune_17:啓示>"
  },
  State_3307_Name = {
    Text = "(残り:[Layer])"
  },
  State_3308_Desc = {
    Text = "ターン開始時、前のターンに残った手札が2枚を超えていた場合、2算力を獲得。__「開発用」"
  },
  State_3309_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_3309_Name = {
    Text = "状態@試作長剣死亡抵抗"
  },
  State_3310_Desc = {
    Text = "移住者がシールドを付与したとき、[Energy:StateArg2] の狂気を得る。"
  },
  State_3310_Name = {
    Text = "自我の封鎖"
  },
  State_3310_WeaponDesc = {
    Text = "移住者がシールドを付与したとき、[Energy:StateArg2] の狂気を得る。"
  },
  State_3312_Desc = {
    Text = "ライフを回復するたびに[Arg1]反撃を獲得。ライフが75％以上の場合、追加で[Arg2]反撃を獲得。"
  },
  State_3313_Desc = {
    Text = "ターン開始時に、このターン中に [Arg1] 点のパワーを獲得する。1枚のカードをプレイするたびに、このターン中に [Arg2] 点のパワーを失う。"
  },
  State_3314_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_3314_Name = {Text = "未覚醒"},
  State_3315_Desc = {
    Text = "毎ターン最初のカードを使用した後、ランダムな2枚の手札がその元のバージョンのコピーに変わり、ターン終了時に元に戻る。__「開発用」"
  },
  State_3315_Name = {
    Text = "遺物惑わし風鈴__「開発用」"
  },
  State_3316_Desc = {
    Text = "ターン終了時にシールドが保持されます。"
  },
  State_3316_Name = {Text = "守護壁"},
  State_3316_WeaponDesc = {
    Text = "ターン終了時にシールドは保持されます。"
  },
  State_3317_Desc = {
    Text = "ターン終了時、すべてのシールドを失う"
  },
  State_3317_Name = {
    Text = "枷：実父"
  },
  State_3318_Name = {
    Text = "ステータス@渇血者へつらう者の抱擁呑み込むマーク"
  },
  State_3323_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_3323_Name = {
    Text = "状態@試作長剣狂気"
  },
  State_3324_Desc = {
    Text = "このターン内クリティカルダメージが [Layer] ％ 上昇。"
  },
  State_3324_Name = {
    Text = "一時的なクリティカルダメージ"
  },
  State_3324_WeaponDesc = {
    Text = "このターン内クリティカルダメージが [Layer] ％ 上昇。"
  },
  State_3325_Desc = {
    Text = "毎回デッキをリセットするときに、今ターン中に [Arg1] 点のパワーを得た「魚叉」2枚と、今ターン中に [Arg2] 点の警戒を得た「日傘」1枚を手札に加える。"
  },
  State_3326_Desc = {
    Text = "各ターン初めてのアクティブなダメージに免疫する。"
  },
  State_3326_Name = {Text = "確固"},
  State_3326_WeaponDesc = {
    Text = "各ターン初めてのアクティブなダメージに免疫する。"
  },
  State_3327_Desc = {
    Text = "モンスターが死亡する前のライフ値。"
  },
  State_3327_Name = {
    Text = "モンスター死亡時のライフ__「開発用」"
  },
  State_3327_WeaponDesc = {
    Text = "モンスターが死亡する前のライフ値。"
  },
  State_3328_Desc = {
    Text = "この戦闘中、致死ダメージを受けた時、一度だけ復活し、ライフを[Layer]回復する。この効果は解除不可。"
  },
  State_3328_Name = {
    Text = "不死の極楽鳥"
  },
  State_3329_Desc = {
    Text = "5枚のカードを使うたび、手札の最左端のカードを複製して入手し、虚無と消耗を付与。"
  },
  State_3330_Desc = {
    Text = "カードの行動力消費が[Layer]増加。カードを使用するとこのデバフは解除。"
  },
  State_3330_Name = {
    Text = "<SlowColour:鈍化 [Layer]>"
  },
  State_3330_WeaponDesc = {
    Text = "カードの計算力消費が[Layer]増加。"
  },
  State_3332_Desc = {
    Text = "アクティブダメージまたは触手ダメージを受けた時、ダメージ無効にして1スタック減少する。"
  },
  State_3332_Name = {
    Text = "<ParcloseColour: バリア>"
  },
  State_3335_Desc = {
    Text = "バトル開始時、すべての敵に1層の弱点を付与する。「停滞呪詛」は追加で敵が受ける弱点効果を25％増加させる。"
  },
  State_3335_Name = {
    Text = "石の目霊感6"
  },
  State_3336_Name = {
    Text = "状態@ジョージ@死亡時治癒"
  },
  State_3337_Desc = {Text = "――"},
  State_3337_Name = {
    Text = "赤い儀式"
  },
  State_3337_WeaponDesc = {Text = "――"},
  State_3339_Desc = {
    Text = "[Layer]点の攻撃力を上げる。"
  },
  State_3339_Name = {
    Text = "一時的な攻撃力向上"
  },
  State_3339_WeaponDesc = {
    Text = "[Layer]点の攻撃力を上げる。"
  },
  State_3340_Desc = {
    Text = "狂気解放を発動すると、この戦闘内で狂気解放のダメージが[Arg1]増加し、最大5回までスタックする。スタックが最大になると、その狂気解放を発動した覚醒体が100の狂気を獲得。"
  },
  State_3341_Desc = {
    Text = "ステータス@プロローグリセットカードライブラリ0＿1＿2＿1"
  },
  State_3341_Name = {
    Text = "ステータス@プロローグリセットカードライブラリ0＿1＿2＿1"
  },
  State_3341_WeaponDesc = {
    Text = "ステータス@プロローグリセットカードライブラリ0＿1＿2＿1"
  },
  State_3342_Desc = {
    Text = "ステータス@プロローグリセットカードライブラリー0＿1＿2＿2"
  },
  State_3342_Name = {
    Text = "ステータス@プロローグリセットカードライブラリー0＿1＿2＿2"
  },
  State_3342_WeaponDesc = {
    Text = "ステータス@プロローグリセットカードライブラリー0＿1＿2＿2"
  },
  State_3343_Desc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿2＿3"
  },
  State_3343_Name = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿2＿3"
  },
  State_3343_WeaponDesc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿2＿3"
  },
  State_3344_Desc = {
    Text = "ステータス@序章リセットカードプール0＿1＿2＿4"
  },
  State_3344_Name = {
    Text = "ステータス@序章リセットカードプール0＿1＿2＿4"
  },
  State_3344_WeaponDesc = {
    Text = "ステータス@序章リセットカードプール0＿1＿2＿4"
  },
  State_3345_Desc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿2＿5"
  },
  State_3345_Name = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿2＿5"
  },
  State_3345_WeaponDesc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿2＿5"
  },
  State_3346_Desc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿2＿5"
  },
  State_3346_Name = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿2＿5"
  },
  State_3346_WeaponDesc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿2＿6"
  },
  State_3347_Desc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿2＿5"
  },
  State_3347_Name = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿2＿5"
  },
  State_3347_WeaponDesc = {
    Text = "ステータス@序章リセットデッキ0＿1＿2＿7"
  },
  State_3348_Desc = {
    Text = "打出後 [StateArg1] 枚のカードを引きます。"
  },
  State_3348_Name = {
    Text = "<Rune_3_High:上位神技>"
  },
  State_3348_WeaponDesc = {
    Text = "打出後 [StateArg1] 枚のカードを引きます。"
  },
  State_3350_Desc = {
    Text = "狂気解放を発動後、現在のライフの10%を失い、このターンすべての敵から[Arg1]の力を奪う。"
  },
  State_3351_Name = {
    Text = "状態@デッキ加入後"
  },
  State_3352_Name = {
    Text = "遺物秘典の星象儀1"
  },
  State_3354_Name = {
    Text = "遺物秘典の星象儀2"
  },
  State_3356_Name = {
    Text = "ターン終了時、窒息毒"
  },
  State_3357_Desc = {
    Text = "次のターン開始時に触腕ダメージ+[Layer]。"
  },
  State_3357_Name = {
    Text = "遅延触腕ダメージ"
  },
  State_3358_Desc = {
    Text = "次のターン開始時に[Layer]シールドを獲得。"
  },
  State_3358_Name = {
    Text = "失われた芸術-シールド"
  },
  State_3359_Desc = {
    Text = "あなたが打ち出す 3 枚目のカードは 2 回の効果が発動します。"
  },
  State_3359_Name = {
    Text = "遺物星々の酒__「開発用」"
  },
  State_3359_WeaponDesc = {
    Text = "あなたが打ち出す 3 枚目のカードは 2 回の効果が発動します。"
  },
  State_3360_Desc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3360_Name = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3360_WeaponDesc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3362_Desc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3362_Name = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3362_WeaponDesc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3364_Desc = {
    Text = "拾取時にカードを1枚選択し、そのカードに2つの3択から1つを選んで強化効果を付与します。(注：千面幻象のカード生成に似ています)"
  },
  State_3365_Desc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3365_Name = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3365_WeaponDesc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3366_Desc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3366_Name = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3366_WeaponDesc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3368_Desc = {
    Text = "捨て札フェイズ前に行動力消費が5を超えると、「石ころ」になる。__「開発用」"
  },
  State_3368_WeaponDesc = {
    Text = "棄牌フェイズ前に手札を石に変える"
  },
  State_3369_Desc = {
    Text = "あなたのすべての呑食効果が無限呑食になります。"
  },
  State_3369_Name = {
    Text = "無限捕食__「開発用」"
  },
  State_3369_WeaponDesc = {
    Text = "あなたのすべての呑食効果が無限呑食になります。"
  },
  State_3370_Desc = {
    Text = "このステージで獲得するシールドが[Layer]点減少。"
  },
  State_3370_Name = {
    Text = "永続の警戒減少"
  },
  State_3370_WeaponDesc = {
    Text = "このステージで獲得するシールドが[Layer]点減少。"
  },
  State_3372_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_3372_Name = {Text = "未覚醒"},
  State_3373_Desc = {
    Text = "実際のダメージを与えるとき、[StateArg1] 枚の「傷」をドロー山にシャッフルして戻す。"
  },
  State_3373_WeaponDesc = {
    Text = "抽到時に自身に弱り状態を1ターン与える。使用後、すべての敵に弱り状態を1ターン与える。売却不可。"
  },
  State_3374_Desc = {
    Text = "ターン終了後、同じ回数の力を獲得。"
  },
  State_3374_Name = {Text = "怒り"},
  State_3376_Desc = {
    Text = "この戦闘内で狂気解放によるダメージが [Layer] 増加。"
  },
  State_3376_Name = {
    Text = "狂気解放ダメージ増加"
  },
  State_3378_Desc = {
    Text = "狂気解放を発動後、次に使用するカードが2回発動する。__「開発用」"
  },
  State_3378_Name = {
    Text = "状態@幻夢のシルバーキー：爆発__「開発用」"
  },
  State_3379_Desc = {
    Text = "ライフが50％未満になると、チェインブレイカーが狂暴になる。"
  },
  State_3379_Name = {
    Text = "復讐の刻"
  },
  State_3379_WeaponDesc = {
    Text = "ライフが50％未満になると、チェインブレイカーが狂暴になる。"
  },
  State_3380_Desc = {
    Text = "戦闘開始時、【惑わし】を1枚山札のランダムな位置に追加する。"
  },
  State_3380_WeaponDesc = {
    Text = "バトル開始時、1枚の【迷惑】をドロー山にシャッフルする。"
  },
  State_3381_Name = {
    Text = "超次元職業初期化"
  },
  State_3382_Desc = {
    Text = "任務を1つ獲得する。任務完了後、報酬を獲得する。【任務イベントプレースホルダー】"
  },
  State_3383_Name = {
    Text = "超次元職業初期化"
  },
  State_3385_Desc = {
    Text = "アクティブダメージと触腕ダメージを33%減らす。"
  },
  State_3385_Name = {Text = "鏡盾"},
  State_3385_WeaponDesc = {
    Text = "受けたアクティブなダメージと触手ダメージが33%減少します。"
  },
  State_3386_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_3386_Name = {
    Text = "状態@試作長剣クリティカル"
  },
  State_3387_Name = {
    Text = "状態@ステージ2_3戦闘3バブル1"
  },
  State_3388_Desc = {
    Text = "使用した後、[StateArg1]点の力を獲得する。"
  },
  State_3388_Name = {
    Text = "<Rune_14:剛力>"
  },
  State_3389_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_3389_Name = {Text = "未覚醒"},
  State_3390_Desc = {
    Text = "戦闘開始時、すべての敵に1ターンの虚弱と易傷を付与。"
  },
  State_3392_Desc = {
    Text = "拾得時に[Arg1]力を獲得。「胚胎」が融合されるたびに、本ターン内に[Arg2]点の力を獲得。"
  },
  State_3393_Desc = {
    Text = "ターン開始時に<EmbryoFusionIconKeywords:胚胎融合>+30％。あなたのすべての捕食効果が無限捕食に変わる。"
  },
  State_3394_Name = {
    Text = "<DerivativeCardKeywords_4:「啓示」>を1枚山札に加える"
  },
  State_3395_Desc = {
    Text = "チーム唯一：装備者の「打撃」の基礎ダメージが25%増加し、「防御」の基礎シールドが25%増加する。装備者の「打撃」を使用した時、装備者の攻撃力の <WeaponEffect_Num:[StateArg1]%> に相当する一時的な<PowerIconKeywords:力>を獲得し、装備者の「防御」を使用した時、装備者の防御力の <WeaponEffect_Num:[StateArg2]%> に相当する一時的な<AlertIconKeywords:警戒>を獲得する。現在の界域が「超次元」の場合、超次元ターン突入時に一時的な<PowerIconKeywords:力>と一時的な<AlertIconKeywords:警戒>を1回獲得する。"
  },
  State_3395_WeaponDesc = {
    Text = "装備者の「打撃」の基礎ダメージが25%増加し、「防御」の基礎シールドが25%増加する。装備者の「打撃」を使用した時、 <WeaponEffect_Num:[Power:DescArg1]> ポイントの一時的な<PowerIconKeywords:力>を獲得し、装備者の「防御」を使用した時、<WeaponEffect_Num:[DescArg2]> ポイントの一時的な<AlertIconKeywords:警戒>を獲得する。現在の界域が「超次元」の場合、超次元ターン突入時に一時的な<PowerIconKeywords:力>と一時的な<AlertIconKeywords:警戒>を1回獲得する。"
  },
  State_3397_Desc = {
    Text = "10枚目のカードを出すたびに、<TentacleInjurieIconKeywords:触腕ダメージ>が[Arg1]向上し、すべての触腕に1回攻撃させる。"
  },
  State_3400_Desc = {
    Text = "エリート敵とボス敵のライフ上限が20％減少しました。"
  },
  State_3401_Desc = {
    Text = "使用した後、追加で[StateArg1]回発動する。[StateArg2]点の黒印を獲得する。消耗、固有。"
  },
  State_3402_Desc = {
    Text = "「つるはし」ルーセンの重撃ダメージが [Layer] %増加。"
  },
  State_3402_Name = {
    Text = "重撃ダメージ増加"
  },
  State_3402_WeaponDesc = {
    Text = "アイアンピッケルルーセン重撃 ダメージアップ [Layer] ％"
  },
  State_3403_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_3403_Name = {Text = "未覚醒"},
  State_3405_Name = {
    Text = "すべての敵から[Power:StateArg1]点の<PowerIconKeywords:力>を一時的に減少させ、1ターンの間、獲得するシールドと<PowerIconKeywords:力>を50%減少させる"
  },
  State_3406_Name = {
    Text = "[StateArg1]点の<PowerIconKeywords:力>を獲得"
  },
  State_3407_Name = {
    Text = "山札からカードを1枚選択して手札に追加し、そのカードの行動力消費-1"
  },
  State_3408_Name = {
    Text = "<Posse:[DescArg1]>キーエネルギーを獲得。この戦闘中「首切りの一撃」と「千変万化」の基礎ダメージが10%増加する"
  },
  State_3409_Name = {
    Text = "覚醒体を1体選択し、<Energy:[DescArg1]>狂気を獲得させる"
  },
  State_3410_Name = {
    Text = "このカードのクリティカル率とクリティカルダメージが50%増加し、刺突ダメージを与える"
  },
  State_3411_Name = {
    Text = "1ターンの間、<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易傷>を無効化する。<Block:[Block:StateArg1]>点のシールドを獲得"
  },
  State_3412_Desc = {
    Text = "デバフを無効化、ターン終了時またはクリティカルを受けた時に1回減少。"
  },
  State_3412_Name = {
    Text = "蝋質の被膜"
  },
  State_3412_WeaponDesc = {
    Text = "各層で受けるダメージが10%減少し、クリティカルを受けるたびに、1層減少する。"
  },
  State_3415_Desc = {
    Text = "拾取時、3つの腐化刻印から1つを選択して獲得します。腐化刻印は普通の刻印よりも強力ですが、プレイ時にカードを消費します。"
  },
  State_3415_Name = {
    Text = "遺物翡翠の拓印"
  },
  State_3415_WeaponDesc = {
    Text = "拾取時、3つの腐化刻印から1つを選択して獲得します。腐化刻印は普通の刻印よりも強力ですが、プレイ時にカードを消費します。"
  },
  State_3416_Desc = {
    Text = "チームユニーク：戦闘開始後、装備者の防御力の <WeaponEffect_Num:[StateArg1]%> 分の反撃を獲得する。<DeathResistanceIconKeywords: デスレジスタンス>発動後、最大合計 2 層の「クレードル」を獲得する：全体の味方が与えるシールドとライフ回復が <WeaponEffect_Num:[StateArg2]%> 上昇し、ターン終了時に 1 層を除去する。現在の界域が「血肉」の場合、<DeathResistanceIconKeywords: デスレジスタンス>発動後に胚胎融合 <WeaponEffect_Num:+[Blood:StateArg3]> 。"
  },
  State_3416_WeaponDesc = {
    Text = "戦闘開始後、<WeaponEffect_Num:[Counterattack:DescArg1]> 層の反撃を獲得する。<DeathResistanceIconKeywords: デスレジスタンス>発動後、最大合計 2 層の「クレードル」を獲得する：全体の味方が与えるシールドとライフ回復が <WeaponEffect_Num:[StateArg2]%> 上昇し、ターン終了時に 1 層を除去する。現在の界域が「血肉」の場合、<DeathResistanceIconKeywords: デスレジスタンス>発動後に胚胎融合 <WeaponEffect_Num:+[Blood:StateArg3]> 。"
  },
  State_3418_Desc = {
    Text = "ターン終了後、一時的な力喪失"
  },
  State_3418_Name = {
    Text = "遅延衰弱"
  },
  State_3419_Desc = {
    Text = "拾得時に高度または呪いの刻印を持つ3枚のカードを表示し、1枚を選んでその対応する刻印を与える。"
  },
  State_3420_Desc = {
    Text = "行動ごとに出血を引き起こし、治療で出血の層数を半分に減らすことができます。"
  },
  State_3420_Name = {Text = "血飛沫"},
  State_3420_WeaponDesc = {
    Text = "行動ごとに出血を引き起こし、治療で出血の層数を半分に減らすことができます。"
  },
  State_3421_Desc = {
    Text = "ターン開始時、このターン中に[Arg1]力を持つ「銛」を手札に追加。狂気解放後、手札にあるすべての「銛」の力が[Arg2]増加。"
  },
  State_3422_Name = {
    Text = "状態@「密約」無垢の啓示録"
  },
  State_3422_WeaponDesc = {
    Text = "キーの解放後、[DescArg1] ライフを回復する。装備者のシルバーキー充電レベルが>20の場合、追加で [DescArg1] ライフを回復する。同種の効果は重複して適用されない。"
  },
  State_3423_Desc = {
    Text = "界域精通100、ダメージに一時的な触腕ダメージを追加。"
  },
  State_3423_Name = {
    Text = "時の振り子「夢魘」"
  },
  State_3424_Desc = {
    Text = "ターン開始時、前のターンにカードを3枚以上使用していた場合、カードを2枚引く。"
  },
  State_3425_Desc = {
    Text = "ライフが50%未満 ([StateArg1]) の時、行動予測は「絶望からの生還」に変化する。「絶望からの生還」：「抑圧」「倦怠」「毒」状態を除去し、味方チームに99点の「倦怠」と「抑圧」を付与。"
  },
  State_3425_Name = {
    Text = "復讐の刻"
  },
  State_3425_WeaponDesc = {
    Text = "ライフが 50%([StateArg1]) 未満の場合、意図を「絶境サバイバル」に変更：脆弱、弱り、およびポイズンを除去し、味方チームに 99 層の弱りと脆弱状態を付与"
  },
  State_3429_Desc = {
    Text = "每次行動に出血を追加、治療で出血効果を除去可能"
  },
  State_3429_Name = {Text = "重傷"},
  State_3429_WeaponDesc = {
    Text = "每次行動に出血を追加、治療で出血効果を除去可能"
  },
  State_3430_Desc = {
    Text = "狂気解放を解放後、[Arg1] 点のカウンターを獲得。このバトル内で6回目にトリガーされた場合、あなたのカウンターが2倍になる。"
  },
  State_3431_Name = {
    Text = "毒無効化"
  },
  State_3432_Desc = {
    Text = "捨てる時にそれを消費する__「開発用」"
  },
  State_3432_Name = {
    Text = "捨て札消費__「開発用」"
  },
  State_3432_WeaponDesc = {
    Text = "抽到時に自身に弱り状態を1ターン与える。使用後、すべての敵に弱り状態を1ターン与える。売却不可。"
  },
  State_3434_Name = {
    Text = "状態@共通軟化修正"
  },
  State_3436_Desc = {
    Text = "[Layer]名の覚醒体が「狩猟目標」になっている。"
  },
  State_3436_Name = {
    Text = "狩猟目標"
  },
  State_3437_Desc = {
    Text = "ステータス@モンスターくじらとびファントム星はつこ＿カオスの獣"
  },
  State_3437_Name = {
    Text = "ステータス@モンスターくじらとびファントム星はつこ＿カオスの獣"
  },
  State_3437_WeaponDesc = {
    Text = "ステータス@モンスターくじらとびファントム星はつこ＿カオスの獣"
  },
  State_3438_Desc = {
    Text = "[StateArg1] 点の一時的な力を獲得。"
  },
  State_3438_Name = {
    Text = "<CardKeyWord:機械武装-剣>"
  },
  State_3439_Desc = {
    Text = "ターン終了時、トルは5点の狂気を獲得する。"
  },
  State_3439_Name = {
    Text = "群星帰位"
  },
  State_3440_Name = {
    Text = "黄金の導き手"
  },
  State_3441_Desc = {
    Text = "奇数ターンでは、あなたの手札が 0 の場合、2 枚引きます；偶数ターンでは、あなたの計算力が 0 の場合、2 の計算力を獲得します。"
  },
  State_3441_Name = {
    Text = "異化古いパズル"
  },
  State_3441_WeaponDesc = {
    Text = "奇数ターンでは、あなたの手札が 0 の場合、2 枚引きます；偶数ターンでは、あなたの計算力が 0 の場合、2 の計算力を獲得します。"
  },
  State_3442_Desc = {
    Text = "拾取時、永久に [Arg1] のパワーを失う。ダメージを与えるたびに、[Arg2] ポイントのライフを返信し、ターンごとに最大 6 回まで発動可能。"
  },
  State_3442_Name = {
    Text = "ヤツメウナギの口づけ"
  },
  State_3444_Desc = {
    Text = "ターン開始時にカードを1枚引く。"
  },
  State_3445_Desc = {
    Text = "[Layer]%の防御力を提升させる。"
  },
  State_3445_Name = {
    Text = "汎用防御力％増加"
  },
  State_3445_WeaponDesc = {
    Text = "[Layer]%の防御力を提升させる。"
  },
  State_3446_Desc = {
    Text = "5 層の【導火線】を持つ。カードをプレイすると層数が 1 減少する。層数が 0 になったとき自爆し、攻撃力＊2.5 のダメージを与える。"
  },
  State_3446_Name = {Text = "爆弾"},
  State_3446_WeaponDesc = {
    Text = "5 層の【導火線】を持つ。カードをプレイすると層数が 1 減少する。層数が 0 になったとき自爆し、攻撃力＊2.5 のダメージを与える。"
  },
  State_3447_Desc = {
    Text = "【導火線】5回数を持つ。カードを使用すると回数が1減少。回数が0になると自爆し、攻撃力×2.5のダメージを与える。"
  },
  State_3447_Name = {Text = "爆弾"},
  State_3447_WeaponDesc = {
    Text = "5 層の【導火線】を持つ。カードをプレイすると層数が 1 減少する。層数が 0 になったとき自爆し、攻撃力＊2.5 のダメージを与える。"
  },
  State_3448_Desc = {
    Text = "毎ターン終了時、すべてのタッチアームを活性化する"
  },
  State_3448_Name = {
    Text = "触腕自動発動"
  },
  State_3448_WeaponDesc = {
    Text = "毎ターン終了時、すべてのタッチアームを活性化する"
  },
  State_3449_Desc = {
    Text = "ステータス@序章狂気状態0＿1＿1発動"
  },
  State_3449_Name = {
    Text = "ステータス@序章狂気状態0＿1＿1発動"
  },
  State_3449_WeaponDesc = {
    Text = "ステータス@序章狂気状態0＿1＿1発動"
  },
  State_3450_Desc = {
    Text = "アクティブダメージまたは触手ダメージを受けた時、ダメージ無効にして1スタック除去する。"
  },
  State_3450_Name = {
    Text = "<ParcloseIconKeywords:バリア>"
  },
  State_3450_WeaponDesc = {
    Text = "受けるダメージが99％減少し、ダメージを受けるたびに1スタック減少する。"
  },
  State_3451_Desc = {
    Text = "死亡時にすべての覚醒体が 10 狂気を得る。"
  },
  State_3451_Name = {
    Text = "ミリウムの銀の鱗__「開発用」"
  },
  State_3451_WeaponDesc = {
    Text = "死亡時にすべての覚醒体が 10 狂気を得る。"
  },
  State_3452_Desc = {
    Text = "カードを使用するたびに[StateArg1]ダメージを受け、1点を除去する。ターン終了時に残っている場合、1点につきライフが10%増加した「海中のもの」を1体孵化させる。"
  },
  State_3452_Name = {
    Text = "深淵の侵食"
  },
  State_3453_Name = {
    Text = "ステータス@復讐の巨剣パワー倍率"
  },
  State_3455_Desc = {
    Text = "ステータス＠序章狂気初期化0＿2＿3効果"
  },
  State_3455_Name = {
    Text = "ステータス＠序章狂気初期化0＿2＿3効果"
  },
  State_3455_WeaponDesc = {
    Text = "ステータス＠序章狂気初期化0＿2＿3効果"
  },
  State_3456_Desc = {
    Text = "【防御】が [StateArg1] 層の反撃を獲得する。"
  },
  State_3456_Name = {
    Text = "遺物イラクサのベスト"
  },
  State_3457_Name = {
    Text = "軟化無効化"
  },
  State_3458_Desc = {
    Text = "【攻撃】および【防御】を使用すると、該当の覚醒体は35狂気を得ますが、行動力消費が+1増えます。"
  },
  State_3459_Desc = {
    Text = "この戦闘内で狂気解放によるダメージが [Layer] 増加。"
  },
  State_3459_Name = {
    Text = "狂気解放ダメージ増加"
  },
  State_3461_Desc = {
    Text = "与える5回目のダメージは必ずクリティカルになる。"
  },
  State_3462_Name = {
    Text = "状態@復讐の大剣パワー倍率3"
  },
  State_3463_Name = {
    Text = "状態@復讐の大剣パワー倍率2"
  },
  State_3464_Desc = {
    Text = "触腕の上限が1本増加。ライフが50％未満の時、触腕ダメージが[Arg1]向上。"
  },
  State_3465_Desc = {
    Text = "このカードは戦闘後も持ち越され、ステージ中有効。"
  },
  State_3465_Name = {
    Text = "<CardKeyWord:永続>"
  },
  State_3465_WeaponDesc = {
    Text = "このカードは戦闘後に持ち出すことができ、ステージ内で有効です。"
  },
  State_3466_Desc = {
    Text = "入手時に覚醒体を1体選択して覚醒させ、その覚醒カードの行動力消費が永久に1減少する。"
  },
  State_34671_Desc = {
    Text = "使用後、手札に戻る。"
  },
  State_34671_Name = {
    Text = "<CardKeyWord:手札に戻す>"
  },
  State_34685_Name = {
    Text = "爆弾2プレイヤー"
  },
  State_34689_Desc = {
    Text = "ライフを1失うたび、1点の<PainWord:忍耐>を獲得する。上限は最大ライフの100％。「忍耐」は次の戦闘に引き継がれる。"
  },
  State_3468_Desc = {
    Text = "ステータス@残次品の怨念"
  },
  State_3468_Name = {
    Text = "ステータス@残次品の怨念"
  },
  State_3468_WeaponDesc = {
    Text = "ステータス@残次品の怨念"
  },
  State_34691_Desc = {
    Text = "ライフを1点失うごとに、<PainWord:忍耐>を1層獲得する。上限は[DescArg1]層。忍耐は次の戦闘に引き継がれる。"
  },
  State_34696_Desc = {
    Text = "このカードは常に手札にあり、手札の上限を+1します。"
  },
  State_34696_Name = {
    Text = "永久保存し、手札の上限を無視"
  },
  State_3469_Desc = {
    Text = "与えるアクティブおよび触手ダメージが [DescArg1] ％低下する。"
  },
  State_3469_Name = {
    Text = "<WeaknessColour:倦怠>"
  },
  State_3469_WeaponDesc = {
    Text = "与えるすべてのダメージが[DescArg1]%減少。"
  },
  State_3470_Desc = {
    Text = "徐々に石ころ変化を付与"
  },
  State_3470_Name = {
    Text = "徐々に石ころ変化を付与"
  },
  State_3470_WeaponDesc = {
    Text = "徐々に石化的効果を適用する"
  },
  State_3471_Desc = {
    Text = "あなたが打つ毎 [StateArg1] 枚目のカードは 2 回効果を発動します。"
  },
  State_3471_Name = {
    Text = "星々の酒カウント"
  },
  State_3471_WeaponDesc = {
    Text = "あなたが打つ毎 [StateArg1] 枚目のカードは 2 回効果を発動します。"
  },
  State_3473_Desc = {
    Text = "ライフが50%より低い場合、「ランタンの司祭」は「神降」を祈り、すべての信者を吸収して狂暴となる。"
  },
  State_3473_Name = {
    Text = "灯芯の烙印"
  },
  State_3473_WeaponDesc = {
    Text = "ライフが50%より低い場合、「ランタンの司祭」は「神降」を祈り、すべての信者を吸収して狂暴となる。"
  },
  State_3475_Desc = {
    Text = "[打撃]と[防御]計算力消費＋1。"
  },
  State_3475_Name = {
    Text = "遺物呪いの石碑"
  },
  State_3475_WeaponDesc = {
    Text = "[打撃]と[防御]計算力消費＋1。"
  },
  State_3476_Desc = {
    Text = "ライフを失うたびに、<EmbryoFusionIconKeywords:胚胎融合>+10％。ライフが50％未満の時、効果が倍増。"
  },
  State_3477_Desc = {
    Text = "攻撃を受けると[Layer]％の最大ライフを回復する。最大ライフの15％を超えるダメージを受けると、「眩暈」となりこの状態は解除される。"
  },
  State_3477_Name = {
    Text = "黒い混沌"
  },
  State_3478_Name = {
    Text = "状態@飾品標準密約"
  },
  State_3479_Desc = {
    Text = "1つのブラックスタンプを消費するたびに、すべての覚醒体が1狂気を獲得する"
  },
  State_3479_Name = {
    Text = "遺物逆生花"
  },
  State_3479_WeaponDesc = {
    Text = "1つのブラックスタンプを消費するたびに、すべての覚醒体が1狂気を獲得する"
  },
  State_3480_Desc = {
    Text = "ターン終了まで、ライフは0にならない。"
  },
  State_3480_Name = {
    Text = "珠玉の卵は死なない"
  },
  State_3480_WeaponDesc = {
    Text = "ターン終了まで、ライフは0にならない。"
  },
  State_3481_Desc = {
    Text = "ステージ開始時、死亡抵抗率と刻印幸運率が倍増する。__「開発用」"
  },
  State_3481_Name = {
    Text = "状態@幻夢のシルバーキー：ダブルラッキー__「開発用」"
  },
  State_3482_Desc = {
    Text = "与えられる弱点効果が 25% 上昇。3 ターン毎にすべての敵に 1 層の弱点を追加する。"
  },
  State_3483_Desc = {
    Text = "每次行動に出血を追加、治療で出血効果を除去可能"
  },
  State_3483_Name = {Text = "重傷"},
  State_3483_WeaponDesc = {
    Text = "每次行動に出血を追加、治療で出血効果を除去可能"
  },
  State_3484_Desc = {
    Text = "実際のダメージを与えると、力を獲得。__「開発用」"
  },
  State_3484_Name = {
    Text = "「混乱人格」"
  },
  State_3485_Desc = {
    Text = "ステータス＠提灯の儀式効果中"
  },
  State_3485_Name = {
    Text = "ステータス＠提灯の儀式効果中"
  },
  State_3485_WeaponDesc = {
    Text = "ステータス＠提灯の儀式効果中"
  },
  State_3486_Name = {
    Text = "運命の剣"
  },
  State_3488_Desc = {
    Text = "カード使用時に[StateArg1]ダメージを受け、1点を除去する。点数が0になった時、弱体化した「海中のもの」を1体孵化させる。ターン終了時に寄生状態が残っている場合、点数に応じてライフが増加した「海中のもの」を1体孵化させる。"
  },
  State_3488_Name = {
    Text = "多重寄生"
  },
  State_3489_Name = {
    Text = "ターン終了時に手札または<DimensionalSpaceIconKeywords:超次元空間>にある場合、「腐敗の緑炎」にアップグレードする"
  },
  State_3489_WeaponDesc = {
    Text = "ターン終了時に手札または超次元空間にある場合、効果が強化される"
  },
  State_3490_Desc = {
    Text = "カード使用時に[StateArg1]ダメージを受け、1点を除去する。点数が0になった時、弱体化した「海中のもの」を1体孵化させる。ターン終了時に寄生状態が残っている場合、点数に応じてライフが増加した「海中のもの」を1体孵化させる。"
  },
  State_3490_Name = {Text = "再寄生"},
  State_3492_Desc = {
    Text = "偶数ターンごとに味方の力が[Layer]減少。"
  },
  State_3492_Name = {
    Text = "力を抜く"
  },
  State_3495_Desc = {
    Text = "行動するたびに[Layer]点の出血を付与する"
  },
  State_3495_Name = {Text = "重傷"},
  State_3495_WeaponDesc = {
    Text = "各行動で[Layer]出血を追加し、治療で出血効果を除去できる"
  },
  State_34964_Desc = {
    Text = "ターン開始後、最大ライフの10%の<PainWord:忍耐>を獲得。"
  },
  State_34964_Name = {
    Text = "忘れない"
  },
  State_3496_Name = {
    Text = "ターン終了時に手札または<DimensionalSpaceIconKeywords:超次元空間>にある場合、「死滅の緑炎」にアップグレードする"
  },
  State_3496_WeaponDesc = {
    Text = "ターン終了時に手札または超次元空間にある場合、効果が強化される"
  },
  State_3497_Desc = {
    Text = "チームが異なる職業の覚醒体で構成されている場合、チームのライフとすべての覚醒体の攻撃と防御が200％向上します"
  },
  State_3497_Name = {
    Text = "ミックスボーナス"
  },
  State_3497_WeaponDesc = {
    Text = "チームが異なる職業の覚醒体で構成されている場合、チームのライフとすべての覚醒体の攻撃と防御が200％向上します"
  },
  State_3499_Desc = {
    Text = "チーム唯一：装備者が生成する狂気が <WeaponEffect_Num:[StateArg1]%> 増加する。装備者が狂気爆発を発動した後、 <WeaponEffect_Num:[StateArg2]> ポイントの銀鍵エネルギーを獲得する。"
  },
  State_3499_WeaponDesc = {
    Text = "装備者が生成する狂気が <WeaponEffect_Num:[StateArg1]%> 増加する。装備者が狂気爆発を発動した後、 <WeaponEffect_Num:[StateArg2]> ポイントの銀鍵エネルギーを獲得する。"
  },
  State_3502_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_3502_Name = {
    Text = "状態@試作小刀狂気"
  },
  State_3504_Desc = {
    Text = "毎ターン開始時、[StateArg1] 枚のカードを引く。"
  },
  State_3504_Name = {
    Text = "遺物方位磁針__「開発用」"
  },
  State_3504_WeaponDesc = {
    Text = "毎ターン開始時、[StateArg1] 枚のカードを引く。"
  },
  State_3507_Name = {
    Text = "装飾品の有機形態"
  },
  State_3507_WeaponDesc = {
    Text = "装備者が狂気解放を使用した後、そのターン内で自身のシールドと治療の強力が2倍になる。"
  },
  State_3508_Name = {
    Text = "「密約」少女の蛹"
  },
  State_3508_WeaponDesc = {
    Text = "バトル開始後、装備者の職業がカオスの場合、攻撃力が 25％ 上昇します。"
  },
  State_3510_Desc = {
    Text = "覚醒体が獲得するシールドが[Layer]点増加。"
  },
  State_3510_Name = {
    Text = "<AlertColour:警戒>"
  },
  State_3511_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_3511_Name = {
    Text = "状態@試作長剣幸運"
  },
  State_35120_Desc = {
    Text = "アクティブダメージを1回受けるたびに、ダメージ源に[StateArg1]スタックの毒を付与し、[Layer]ターン持続する。"
  },
  State_35120_Name = {
    Text = "泥に咲く不滅の花"
  },
  State_3512_Name = {
    Text = "一時的な抑圧無効化"
  },
  State_3514_Desc = {
    Text = "ターン終了時に同スタック数の<FixedDamage:純粋ダメージ>を受け、このステータスを除去する。"
  },
  State_3514_Name = {
    Text = "<BleedingIconKeywords:出血>"
  },
  State_3514_WeaponDesc = {
    Text = "ターン開始時にダメージを受ける。"
  },
  State_35158_Name = {
    Text = "時霊振り子「入迷」"
  },
  State_3515_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_3515_Name = {Text = "未覚醒"},
  State_35161_Name = {
    Text = "時霊振り子「蓄積」"
  },
  State_3516_Name = {
    Text = "状態@憂鬱の呪い"
  },
  State_3518_Desc = {
    Text = "奇術師が 1 枚のカードを出すたびに、[StateArg2] の一時的な力を獲得。"
  },
  State_3518_Name = {
    Text = "公園の序幕"
  },
  State_3519_Desc = {
    Text = "超次元ターンでなくても、毎ターン1回までワープ効果を発動できます。"
  },
  State_3519_Name = {
    Text = "空間屈折装置__「開発用」"
  },
  State_3519_WeaponDesc = {
    Text = "超次元ターンでなくても、毎ターン1回までワープ効果を発動できます。"
  },
  State_3520_Desc = {
    Text = "バトル開始時、覚醒体を1体選択し、その覚醒体に50の狂気ポイントを与えます。"
  },
  State_35228_Name = {
    Text = "時霊振り子「蓄積」"
  },
  State_3522_Name = {
    Text = "遺物銛カウント"
  },
  State_35238_Desc = {
    Text = "チーム唯一：装備者が与えるシールドと中毒が<WeaponEffect_Num:[StateArg1]%>増加する。死亡抵抗が発動するたび、すべての覚醒体が<WeaponEffect_Num:[StateArg2]%>の一時的なクリティカル率とクリティカルダメージを獲得する。"
  },
  State_35238_WeaponDesc = {
    Text = "装備者が与えるシールドと中毒が<WeaponEffect_Num:[StateArg1]%>増加する。死亡抵抗が発動するたび、すべての覚醒体が<WeaponEffect_Num:[StateArg2]%>の一時的なクリティカル率とクリティカルダメージを獲得する。"
  },
  State_3523_Desc = {
    Text = "打出後、全ての敵を弱りに [StateArg1] のターン。"
  },
  State_3523_Name = {
    Text = "<Rune_1_High:上位倦怠>"
  },
  State_3524_Desc = {
    Text = "受けるダメージが[Layer]点増加。"
  },
  State_3524_Name = {
    Text = "融蝕の傷口"
  },
  State_3524_WeaponDesc = {
    Text = "受けたダメージが [Layer] pt増加します。"
  },
  State_3525_Desc = {
    Text = "味方のチームが1枚のカードをプレイするたびに、それに2層の【拘束】を付与する。"
  },
  State_3525_Name = {
    Text = "「東区特別オファー」"
  },
  State_3525_WeaponDesc = {
    Text = "味方のチームが1枚のカードをプレイするたびに、それに2層の【拘束】を付与する。"
  },
  State_35264_Desc = {
    Text = "このターン、カードを使用するたびに「奇術師」が1層の幻影を獲得。"
  },
  State_35264_Name = {
    Text = "幻影転身記録"
  },
  State_35277_Name = {
    Text = "カーシアの魔術防御"
  },
  State_3527_Desc = {
    Text = "ターン終了時に、最初に使用した指令カードの対応覚醒体が15狂気を獲得。「奉献精神」を持っている場合、他の覚醒体も5狂気を獲得。"
  },
  State_3528_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_3528_Name = {
    Text = "状態@試作レーザー砲界域"
  },
  State_3529_Desc = {
    Text = "すべてのダメージを無効化し、ターン開始後に除去される。"
  },
  State_3529_Name = {
    Text = "ダメージを無効化"
  },
  State_3530_Desc = {
    Text = "ステータス@ラッキー探偵肆意豪賭アイコン8"
  },
  State_3530_Name = {
    Text = "ステータス@ラッキー探偵肆意豪賭アイコン8"
  },
  State_3530_WeaponDesc = {
    Text = "ステータス@ラッキー探偵肆意豪賭アイコン8"
  },
  State_3531_Desc = {
    Text = "チーム唯一：戦闘開始時、装備者は<WeaponEffect_Num:[StateArg1]>狂気を獲得。他の覚醒体が狂気爆発を発動するたびに、装備者は<WeaponEffect_Num:[StateArg2]>狂気を獲得する。現在界域が「深海」の場合、装備者が狂気爆発を発動後、攻撃力の<WeaponEffect_Num:[StateArg3]%>に相当する触腕ダメージを獲得する。"
  },
  State_3531_WeaponDesc = {
    Text = "戦闘開始時、装備者は<WeaponEffect_Num:[StateArg1]>狂気を獲得。他の覚醒体が狂気爆発を発動するたびに、装備者は<WeaponEffect_Num:[StateArg2]>狂気を獲得する。現在界域が「深海」の場合、装備者が狂気爆発を発動後、触腕ダメージ<WeaponEffect_Num:+[DescArg1]>。"
  },
  State_3532_Desc = {
    Text = "ターン開始時に [StateArg1] 計算力を獲得する。"
  },
  State_3532_Name = {
    Text = "遺物黒い蝋燭1"
  },
  State_3533_Desc = {
    Text = "必ず初期手札に現れる。"
  },
  State_3533_WeaponDesc = {
    Text = "バトル開始後、このカードは手札に固定されます。"
  },
  State_3535_Desc = {
    Text = "カードの行動力消費が[Layer]増加。ターン終了またはカードを使用すると、このデバフは解除。"
  },
  State_3535_Name = {
    Text = "<SlowColour:一時的な鈍化 [Layer]>"
  },
  State_3535_WeaponDesc = {
    Text = "カードの計算力消費が[Layer]増加。"
  },
  State_3536_Name = {
    Text = "ボス戦で3回使用可能"
  },
  State_3537_Desc = {
    Text = "\"天真的回礼\"を獲得した時、1回刻印を行うことができる"
  },
  State_3537_Name = {
    Text = "ステータス@章一_共鳴4"
  },
  State_3537_WeaponDesc = {
    Text = "\"天真的回礼\"を獲得した時、1回刻印を行うことができる"
  },
  State_3538_Desc = {
    Text = "「天真的回礼」を使用して狂気を上昇させる"
  },
  State_3538_Name = {
    Text = "ステータス@章一_共鳴1"
  },
  State_3538_WeaponDesc = {
    Text = "「天真的回礼」を使用して狂気を上昇させる"
  },
  State_3539_Desc = {
    Text = "「天真的回礼」の計算力消費が1減少する"
  },
  State_3539_Name = {
    Text = "ステータス@章一_共鳴3"
  },
  State_3539_WeaponDesc = {
    Text = "「天真的回礼」の計算力消費が1減少する"
  },
  State_3540_Desc = {
    Text = "「純粋な贈り物」はターゲットを指定できます"
  },
  State_3540_Name = {
    Text = "ステータス@章一_共鳴2"
  },
  State_3540_WeaponDesc = {
    Text = "「純粋な贈り物」はターゲットを指定できます"
  },
  State_3541_Desc = {
    Text = "クムはあなたたちの罠にかかった。"
  },
  State_3541_Name = {
    Text = "罠にかかる"
  },
  State_3542_Desc = {
    Text = "バトル開始時、カードデッキに 1 つ刻印があるごとに [Arg1] 点のパワーを獲得し、1 つ造物があるごとに、[Arg2] 点のライフを回復する。"
  },
  State_3542_Name = {
    Text = "☆商会勲章☆"
  },
  State_3545_Name = {
    Text = "無限の星彩レジスタンス"
  },
  State_3545_WeaponDesc = {
    Text = "1 枚のカードを出すたびに [StateArg1]% のデスレジスタンスを獲得する。デスレジスタンスを獲得したとき、[StateArg2] のライフを回復する。"
  },
  State_3546_Desc = {
    Text = "味方チームがカードを1枚使用するたびに【束縛】を[Layer]回付与する。"
  },
  State_3546_Name = {
    Text = "「東区特別オファー」"
  },
  State_3546_WeaponDesc = {
    Text = "味方のチームが 1 枚のカードをプレイするたびに、[Layer] 层の【拘束】を適用する。"
  },
  State_3547_Desc = {
    Text = "味方のチームが 1 枚のカードをプレイするたびに、[Layer] 层の【拘束】を適用する。"
  },
  State_3547_Name = {
    Text = "「東区特別オファー」"
  },
  State_3547_WeaponDesc = {
    Text = "味方のチームが 1 枚のカードをプレイするたびに、[Layer] 层の【拘束】を適用する。"
  },
  State_3548_Desc = {
    Text = "抽到時に自身に弱り状態を1ターン与える。使用後、すべての敵に弱り状態を1ターン与える。売却不可。"
  },
  State_3548_Name = {
    Text = "状態呪い衰弱"
  },
  State_3548_WeaponDesc = {
    Text = "抽到時に自身に弱り状態を1ターン与える。使用後、すべての敵に弱り状態を1ターン与える。売却不可。"
  },
  State_3549_Name = {
    Text = "状態「密約」荒野の狼"
  },
  State_3549_WeaponDesc = {
    Text = "装備者が与える基本ダメージが10%アップする。装備者のダメージ強化が20%を超える場合、基本ダメージがさらに10%アップする。"
  },
  State_35503_Name = {
    Text = "時霊振り子「蔓延」"
  },
  State_3551_Desc = {
    Text = "ターン開始時、前のターンの残りの手札が [StateArg1] 枚を超える場合、[StateArg2] 点の計算力を獲得する。"
  },
  State_3551_Name = {
    Text = "遺物銀白の演算器__「開発用」"
  },
  State_3551_WeaponDesc = {
    Text = "ターン開始時、前のターンの残りの手札が [StateArg1] 枚を超える場合、[StateArg2] 点の計算力を獲得する。"
  },
  State_35539_Desc = {
    Text = "受けたダメージが2倍になり、[Layer] ターン続く。"
  },
  State_35539_Name = {
    Text = "行道の骸"
  },
  State_3553_Desc = {
    Text = "クリティカル率が25%増加。ライフ回復を行った後、追加で1回ライフ回復を行う可能性があり、その確率は回復を行った者のクリティカル率に等しい。__「開発用」"
  },
  State_3553_Name = {
    Text = "状態@幻夢のシルバーキー：クリティカル治癒__「開発用」"
  },
  State_3554_Desc = {
    Text = "シールドと治療の効果が[Layer]％向上する"
  },
  State_3554_Name = {
    Text = "シールドと治癒力強化"
  },
  State_3554_WeaponDesc = {
    Text = "シールドと治療の効果が[Layer]％向上する"
  },
  State_3555_Desc = {
    Text = "拾得時、100%の死亡抵抗を獲得。死亡抵抗が発動後、戦闘中の各ターン開始時に[Arg1]のライフを回復。"
  },
  State_3556_Desc = {
    Text = "このつくりものを拾うときに1枚のカードを選択し、そのコピーをデッキに加える。"
  },
  State_3558_Desc = {
    Text = "ターン開始時にブラックスタンプが10>の場合、10のブラックスタンプを消費し、そのターンに与えるダメージが2倍になる。"
  },
  State_3559_Desc = {
    Text = "ブロックされなかったダメージを与えた時、1点の脆弱を付与する。"
  },
  State_3559_Name = {Text = "爪"},
  State_3559_WeaponDesc = {
    Text = "実際のダメージを与えるとき、[StateArg1] 枚の「傷」をドロー山にシャッフルして戻す。"
  },
  State_3561_Name = {
    Text = "状態@幻夢のシルバーキー：乱斬カウント"
  },
  State_3562_Desc = {
    Text = "死亡後、他の味方の力が[Layer]点増加する。"
  },
  State_3562_Name = {Text = "死語"},
  State_35635_Name = {
    Text = "状態@覚醒体カーシア念動力操作発動許可"
  },
  State_35636_Name = {
    Text = "状態@覚醒体カーシア念動力操作追加"
  },
  State_3563_Desc = {
    Text = "ガードされなかったダメージを与えた時、[StateArg1] 枚の「傷口」を山札のランダムな位置に追加する。"
  },
  State_3563_Name = {Text = "刃"},
  State_3563_WeaponDesc = {
    Text = "実際のダメージを与えるとき、[StateArg1] 枚の「傷」をドロー山にシャッフルして戻す。"
  },
  State_35645_Desc = {
    Text = "このターンのドロー枚数が[Layer]減少。"
  },
  State_35645_Name = {
    Text = "ドロー減少"
  },
  State_35646_Desc = {
    Text = "このターンのドロー枚数が[Layer]減少。"
  },
  State_35646_Name = {
    Text = "ドロー減少"
  },
  State_3564_Desc = {
    Text = "使用した後、[StateArg1]点の一時的な力を獲得し、この刻印カードにも力のボーナスが適用される。"
  },
  State_3564_Name = {
    Text = "<Rune_15_High:上位爆発>"
  },
  State_3565_Desc = {
    Text = "彫刻者がシールドを付与するとき、[StateArg1] の触手ダメージが上昇。"
  },
  State_3565_Name = {
    Text = "忘我の境地"
  },
  State_3565_WeaponDesc = {
    Text = "彫刻者がシールドを付与するとき、[StateArg1] の触手ダメージが上昇。"
  },
  State_3566_Desc = {
    Text = "ターン開始時に一時的な力を3獲得。【狂気爆発】でこの一時的な力が倍増し、最大2回までスタック。"
  },
  State_3566_Name = {
    Text = "遺物怪蛇の抜け殻__「開発用」"
  },
  State_3567_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_3567_Name = {
    Text = "状態@試作レーザー砲クリティカル"
  },
  State_35684_Desc = {
    Text = "味方チームが狂気解放を発動した後、自身はそのターン、力を失う。1ターンに1回。"
  },
  State_35684_Name = {
    Text = "狂気を恐れる"
  },
  State_35685_Desc = {
    Text = "真貌顕現時、敵の一時的な力を減少させる。__「開発用」"
  },
  State_35685_Name = {
    Text = "狂気を恐れる"
  },
  State_3568_Desc = {
    Text = "ラモナがダメージを与えたとき、[StateArg1] の 計算力を獲得する。"
  },
  State_3568_WeaponDesc = {
    Text = "ラモナがダメージを与えたとき、[StateArg1] の 計算力を獲得する。"
  },
  State_3570_Name = {
    Text = "次のターン開始時にドロー枚数+2"
  },
  State_3571_Name = {
    Text = "一時的な倦怠無効化"
  },
  State_3572_Desc = {
    Text = "召喚された敵のダメージが2倍になります。"
  },
  State_3572_WeaponDesc = {
    Text = "その召喚したモンスターのダメージが2倍になります。"
  },
  State_3573_Desc = {
    Text = "各ターン初めて受けるダメージが5倍になる。"
  },
  State_3573_Name = {Text = "傲慢"},
  State_3573_WeaponDesc = {
    Text = "毎ターンで初めて受けるダメージが2倍になる。"
  },
  State_3574_Desc = {
    Text = "同じ覚醒体のカードを連続で使用するたびに、その覚醒体が10狂気を獲得する。__「開発用」"
  },
  State_35768_Name = {
    Text = "300キーエネルギーを獲得"
  },
  State_35769_Name = {
    Text = "1点の行動力を獲得"
  },
  State_35770_Name = {
    Text = "自身の<IntoxicationIconKeywords:毒>、封印、<SlowIconKeywords:鈍化>の状態を解除"
  },
  State_35771_Name = {
    Text = "最大ライフの[DescArg1]%分(<Block:[DescArg2]>)のシールドを獲得。"
  },
  State_35772_Name = {
    Text = "ボス戦で追加で[StateArg1]回使用可能"
  },
  State_35774_Desc = {
    Text = "死亡する前に一度シレストの援助を呼び、すべてのライフ、狂気、キーエネルギーを回復する。"
  },
  State_35774_Name = {
    Text = "理想郷の帳"
  },
  State_3577_Name = {
    Text = "狂気自動回復増加"
  },
  State_35809_Desc = {
    Text = "与えるダメージが[StateArg1]%減少する。[Layer] ターン持続。"
  },
  State_35809_Name = {
    Text = "虚偽の継承者"
  },
  State_35809_WeaponDesc = {
    Text = "ステータス@深海の淑女の紅茶とケーキ"
  },
  State_3580_Desc = {
    Text = "[Layer]ターンの間、触腕ダメージが<PunctureDamagewords:刺突ダメージ>になる。"
  },
  State_3580_Name = {
    Text = "刺突触腕"
  },
  State_35811_Desc = {
    Text = "アクティブまたは触腕ダメージを受けた時、そのダメージの半分の<SacrificeKeyWord:犠牲>を獲得し、[Layer] ターン持続する。"
  },
  State_35811_Name = {
    Text = "虚偽の継承者"
  },
  State_35819_Desc = {
    Text = "ターン終了時、マーフィーは5狂気を獲得。キーオーダー発動時、最大ライフの2%の<SacrificeKeyWord:献上>を解除。"
  },
  State_35819_Name = {
    Text = "紅茶とケーキ"
  },
  State_3581_Desc = {
    Text = "ステータス@マダム・レッドの権欲の輪舞カウント"
  },
  State_3581_Name = {
    Text = "ステータス@マダム・レッドの権欲の輪舞カウント"
  },
  State_3582_Desc = {
    Text = "超次元ターンでなくても、毎ターン1回ワープ効果を発動できる。発動時に対応する覚醒体のカードを1枚引く。"
  },
  State_3582_Name = {
    Text = "異化空間屈折装置"
  },
  State_3582_WeaponDesc = {
    Text = "超次元ターンでなくても、毎ターン1回ワープ効果を発動できる。発動時に対応する覚醒体のカードを1枚引く。"
  },
  State_3584_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_3584_Name = {
    Text = "状態@試作小刀界域"
  },
  State_35858_Desc = {
    Text = "ターン終了時、マーフィーは狂気5獲得。キーオーダー発動時、マーフィーの攻撃力3%の触腕ダメージを獲得。"
  },
  State_35858_Name = {
    Text = "紅茶とケーキ"
  },
  State_3585_Desc = {
    Text = "ライフが50%([StateArg1])未満になると、「提灯教牧師」は「神降」を祈り、すべての信者を吸収して狂暴化する。"
  },
  State_3585_Name = {
    Text = "灯芯の烙印"
  },
  State_3585_WeaponDesc = {
    Text = "ライフが 50%([StateArg1]) 以下のとき、「ランタンの司祭」は「神降」を祈り、すべての教衆を吸収して狂暴化する。"
  },
  State_3588_Name = {
    Text = "遺物アルカナ遺物行動力"
  },
  State_3589_Desc = {
    Text = "アクティブダメージまたは触手ダメージを受けた時、ダメージ無効にして1スタック減少する。"
  },
  State_3589_Name = {
    Text = "<ParcloseColour: バリア>"
  },
  State_3591_Desc = {
    Text = "チームユニーク：装備者が与える<RetaliateIconKeywords:カウンター>を<WeaponEffect_Num:[StateArg1]%>上昇させる。「防御」は装備者の防御の<WeaponEffect_Num:[StateArg2]%>に相当する一時的なカウンターを得る。ボスバトルでは、代わりに3倍の一時的なカウンターを得る。デスレジスタンス発動後、全ての敵に[StateArg3]％の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  State_3591_Name = {
    Text = "夜に伏す"
  },
  State_3591_WeaponDesc = {
    Text = "装備者が与える<RetaliateIconKeywords:カウンター>を<WeaponEffect_Num:[StateArg1]%>上昇させる。「防御」を発射した後、<WeaponEffect_Num:[Counterattack:DescArg1]>スタックの一時的なカウンターを得る。ボスバトルでは、代わりに3倍の一時的なカウンターを得る。デスレジスタンス発動後、全ての敵に[StateArg3]％の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  State_3592_Desc = {
    Text = "触腕が与えるダメージを増加させる。"
  },
  State_3592_Name = {
    Text = "<TentacleInjurieIconKeywords:触腕ダメージ>"
  },
  State_3592_WeaponDesc = {
    Text = "触腕によるダメージを増やす。"
  },
  State_3593_Desc = {
    Text = "チーム唯一：装備者が与える<IntoxicationIconKeywords:中毒>が<WeaponEffect_Num:[StateArg1]%>増加する。「打撃」で対象の敵に攻撃力の<WeaponEffect_Num:[StateArg2]%>に相当する<IntoxicationIconKeywords:中毒>を与える。この効果は毎ターン最大3回まで発動。"
  },
  State_3593_WeaponDesc = {
    Text = "装備者が与える<IntoxicationIconKeywords:中毒>が<WeaponEffect_Num:[StateArg1]%>増加する。「打撃」で対象の敵に<WeaponEffect_Num:[Poison:DescArg1]>層の<IntoxicationIconKeywords:中毒>を与える。この効果は毎ターン最大3回まで発動。"
  },
  State_3596_Name = {
    Text = "残留するシルバーコア"
  },
  State_35970_Desc = {
    Text = "死亡後、プレイヤーに1ターンの<VulnerabilityIconKeywords:軟化>を付与する。"
  },
  State_35970_Name = {Text = "早逝"},
  State_35971_Desc = {
    Text = "登場時、最大ライフの50%に相当するシールドを獲得。"
  },
  State_35971_Name = {Text = "卵殻"},
  State_3597_Name = {
    Text = "残留するシルバーコア"
  },
  State_3598_Name = {
    Text = "残留するシルバーコア"
  },
  State_3599_Desc = {
    Text = "実際の行動力消費が4以上のカードを1枚使用すると、他の手札の行動力消費が1減る__「開発用」"
  },
  State_36006_Desc = {
    Text = "死後、その場に「睡夢の子」を生成する。"
  },
  State_3600_Name = {
    Text = "残留するシルバーコア"
  },
  State_36013_Desc = {
    Text = "このステータスは<SacrificeKeyWord:献上>ともみなす。次のターン開始時に [Layer] 点の<SacrificeKeyWord:献上>を獲得。"
  },
  State_36013_Name = {
    Text = "<BlueKeyWord:延遅献上>"
  },
  State_36014_Desc = {
    Text = "ターン終了時、[Layer]点のダメージを受け、<SacrificeKeyWord:献上>の50%を減少する。"
  },
  State_36014_Name = {
    Text = "<BlueKeyWord:献上>"
  },
  State_3601_Name = {
    Text = "状態@幻夢のシルバーキー：輪舞カウント"
  },
  State_36022_Desc = {
    Text = "<SacrificeKeyWord:献上>以外のダメージを受けると、ダメージの50%の<SacrificeKeyWord:献上>を獲得。"
  },
  State_36022_Name = {Text = "参拝"},
  State_36023_Desc = {
    Text = "死亡後、もし他の味方が存在する場合、「水の子」を生成する。"
  },
  State_36024_Desc = {
    Text = "死亡後、もし他の味方が存在する場合、「睡夢の子」を生成する。"
  },
  State_3603_Name = {
    Text = "ボス戦中2回使用可能、かつ初回使用後に手札に戻る"
  },
  State_3604_Desc = {
    Text = "チームが異なる職業の覚醒体で構成されている場合、チームのライフとすべての覚醒体の攻撃と防御が200％向上します"
  },
  State_3604_Name = {
    Text = "状態@ミックスボーナス"
  },
  State_3604_WeaponDesc = {
    Text = "チームが異なる職業の覚醒体で構成されている場合、チームのライフとすべての覚醒体の攻撃と防御が200％向上します"
  },
  State_3607_Desc = {
    Text = "覚醒体固有の能力。同じ「霊知覚醒」の効果は重複しない。"
  },
  State_3607_Name = {
    Text = "<ExaltIconKeywords:霊知覚醒>"
  },
  State_3607_WeaponDesc = {
    Text = "霊知覚醒を発動後、覚醒体はこの戦闘中に特殊な能力アップを獲得できます。ただし、重複して発動された霊知覚醒は効果が累積しません。"
  },
  State_3608_Name = {
    Text = "すべての味方が[StateArg1]狂気を獲得"
  },
  State_36092_Desc = {
    Text = "死亡後、もし他の味方が存在する場合、その場に「水の子」を生成する。"
  },
  State_36093_Desc = {
    Text = "ライフを1点失うごとに1点減少する。0点になった時、敵のターン終了後、「水の子」を1体召喚し、再度[DescArg1]点の「水の宿主」を獲得する。最大4体の「水の子」が存在できる。"
  },
  State_36093_Name = {
    Text = "水の宿主"
  },
  State_36094_Desc = {
    Text = "ライフを1点失うごとに1層減少する。層数が0になった時、「霊覚の子」を1体召喚し、再度、[DescArg1]層の「珊瑚寄主」を獲得する。最大4体まで存在できる。"
  },
  State_36094_Name = {
    Text = "霊覚の宿主"
  },
  State_3609_Name = {
    Text = "ボス戦中2回使用可能、かつ初回使用後に手札に戻る。再ドローしたカードはこのターンの行動力消費が1減少する。"
  },
  State_36111_Desc = {
    Text = "死亡後、1枚の「珊瑚寄生」をプレイヤーの手札に追加する。"
  },
  State_36111_Name = {
    Text = "珊瑚寄生"
  },
  State_3611_Desc = {
    Text = "ステータス@序章モンスターパッシブ12"
  },
  State_3611_Name = {
    Text = "ステータス@序章モンスターパッシブ12"
  },
  State_3611_WeaponDesc = {
    Text = "ステータス@序章モンスターパッシブ12"
  },
  State_36124_Desc = {
    Text = "ターン終了後、[Layer]点のダメージを受け、「献上」点数を50%減少させる。"
  },
  State_36124_Name = {
    Text = "<BlueKeyWord:献上>"
  },
  State_3612_Desc = {
    Text = "ステータス@序章モンスターパッシブ13"
  },
  State_3612_Name = {
    Text = "ステータス@序章モンスターパッシブ13"
  },
  State_3612_WeaponDesc = {
    Text = "ステータス@序章モンスターパッシブ13"
  },
  State_36136_Name = {
    Text = "手札にある間、他のカードを1枚発射するたびに [StateArg1] 点の<FixedDamage:純粋ダメージ>を受ける。"
  },
  State_3613_Desc = {
    Text = "ステータス@序章モンスターパッシブ10"
  },
  State_3613_Name = {
    Text = "ステータス@序章モンスターパッシブ10"
  },
  State_3613_WeaponDesc = {
    Text = "ステータス@序章モンスターパッシブ10"
  },
  State_3614_Desc = {
    Text = "ステータス@序章モンスターパッシブ11"
  },
  State_3614_Name = {
    Text = "ステータス@序章モンスターパッシブ11"
  },
  State_3614_WeaponDesc = {
    Text = "ステータス@序章モンスターパッシブ11"
  },
  State_36152_Desc = {
    Text = "ターン終了時にその点数に等しいダメージを受け、その後<SacrificeKeyWord:献上>の50%を除去する。「献上」は次の戦闘に引き継がれる。"
  },
  State_36152_Name = {
    Text = "<SacrificeKeyWord:献上>"
  },
  State_3615_Desc = {
    Text = "ステータス@序章モンスターパッシブ16"
  },
  State_3615_Name = {
    Text = "ステータス@序章モンスターパッシブ16"
  },
  State_3615_WeaponDesc = {
    Text = "ステータス@序章モンスターパッシブ16"
  },
  State_3616_Desc = {
    Text = "ステータス@序章モンスターパッシブ14"
  },
  State_3616_Name = {
    Text = "ステータス@序章モンスターパッシブ14"
  },
  State_3616_WeaponDesc = {
    Text = "ステータス@序章モンスターパッシブ14"
  },
  State_36173_Name = {
    Text = "ボス戦で[DescArg1]回使用可能"
  },
  State_36174_Name = {
    Text = "(残り[Layer]回)"
  },
  State_3617_Desc = {
    Text = "ステータス@序章モンスターパッシブ15"
  },
  State_3617_Name = {
    Text = "ステータス@序章モンスターパッシブ15"
  },
  State_3617_WeaponDesc = {
    Text = "ステータス@序章モンスターパッシブ15"
  },
  State_36182_Name = {
    Text = "最大ライフの[DescArg1]%分(<Block:[DescArg2]>)のシールドを獲得し、同量のライフを回復する。シールドは失われたライフに応じて増加"
  },
  State_3618_Desc = {
    Text = "実際のダメージを受けたときにシールドを獲得する。"
  },
  State_3618_Name = {
    Text = "バッファー"
  },
  State_3618_WeaponDesc = {
    Text = "実際のダメージを受けたときにシールドを獲得する。"
  },
  State_36196_Desc = {
    Text = "ロータンの「攻撃」のダメージが30%増加。"
  },
  State_36196_Name = {
    Text = "自由の剣風"
  },
  State_3619_Desc = {
    Text = "ステータス@青炎の舞者打撃防御"
  },
  State_3619_Name = {
    Text = "ステータス@青炎の舞者打撃防御"
  },
  State_3619_WeaponDesc = {
    Text = "ステータス@青炎の舞者打撃防御"
  },
  State_3620_Desc = {
    Text = "症状カードを獲得するたびに、最大ライフが [Arg1] ポイント上昇します。"
  },
  State_3621_Desc = {
    Text = "元初の信者が1枚のカードを出すたびに、[StateArg1]枚のカードを引き、すべての敵に5％のポイズンを与える。"
  },
  State_3621_Name = {
    Text = "崩壊の執念"
  },
  State_3621_WeaponDesc = {
    Text = "元初の信者が1枚のカードをプレイするたびに、[StateArg1]枚のカードを引く"
  },
  State_3622_Desc = {
    Text = "「暴走する首狩り」と「死者」のスキル効果を強化。毎ターン開始時、[StateArg1]点の一時的な力を獲得。「狩猟の印」1点につき[StateArg1]点増加する。"
  },
  State_3622_Name = {
    Text = "狩猟の印"
  },
  State_36242_Desc = {
    Text = "戦闘開始後、[StateArg1]点のシールドを獲得。ライフを失うと、「聖なる赤子」が目覚めて泣き始める。"
  },
  State_36242_Name = {Text = "熟睡"},
  State_3624_Desc = {
    Text = "ステータス@知者攻勢の推移パワー低下"
  },
  State_3624_Name = {
    Text = "ステータス@知者攻勢の推移パワー低下"
  },
  State_3625_Desc = {
    Text = "シールドを持っていると、与えるダメージが [Arg1] 増加。シールドが現在のライフより高い場合、 [Arg2] のダメージが増加する。"
  },
  State_36263_Desc = {
    Text = "ダメージを受けず、「誕生の種」の解放を準備する。"
  },
  State_36263_Name = {Text = "無効化"},
  State_3628_Name = {
    Text = "状態@使用後防御破壊"
  },
  State_3629_Name = {
    Text = "カードを2枚引く"
  },
  State_3630_Name = {
    Text = "すべての敵に2層点の<VulnerabilityIconKeywords:易傷>を付与"
  },
  State_36315_Desc = {
    Text = "ターン終了時、[Layer]点の力を獲得。"
  },
  State_36315_Name = {Text = "恩寵"},
  State_3631_Name = {
    Text = "2点の行動力を獲得"
  },
  State_3632_Name = {
    Text = "<Energy:[DescArg1]>狂気を獲得"
  },
  State_36332_Desc = {
    Text = "毎ターン開始時、選択を行う。「神母の権能」を1点回復するか、「神母の権能」を消費してマーフィーの能力による助力を1回発動する。"
  },
  State_36332_Name = {
    Text = "神母の権能"
  },
  State_36334_Desc = {
    Text = "ターン終了時に1本の触腕を獲得。"
  },
  State_36334_Name = {
    Text = "ルルイエの呼び声"
  },
  State_3633_Name = {
    Text = "すべての敵に2点の<WeaknessIconKeywords:虚弱>を付与"
  },
  State_36346_Desc = {
    Text = "ライフが0になると、ライフを1にし、ダメージを受けなくなり、「誕生の種」を準備する。"
  },
  State_36346_Name = {
    Text = "誕生の種"
  },
  State_3634_Name = {
    Text = "<DerivativeCardKeywords_4:「啓示」>を2枚山札に追加"
  },
  State_3635_Name = {
    Text = "他の覚醒体は<Energy:[DescArg1]>狂気を獲得"
  },
  State_36360_Desc = {
    Text = "ターン開始後、[DescArg1]％の確率で1層の触手集合を獲得。100％を超える場合は複数層を獲得できます。"
  },
  State_36360_Name = {
    Text = "深海航路"
  },
  State_36361_Desc = {
    Text = "登場時、他の味方が [Layer]点の力を獲得。"
  },
  State_36361_Name = {
    Text = "降神の異変"
  },
  State_3636_Desc = {
    Text = "状態@遺物惑わし風鈴発効__「開発用」"
  },
  State_3636_Name = {
    Text = "状態@遺物惑わし風鈴発効__「開発用」"
  },
  State_3637_Desc = {
    Text = "ライフが25％未満で死んでいない場合、即座に [Arg1] のライフを回復。3回発動後、永久に無効になる。"
  },
  State_3637_Name = {
    Text = "☆非常食☆"
  },
  State_3638_Desc = {
    Text = "アクティブダメージまたは触手ダメージを受けた時、ダメージ無効にして1スタック減少する。"
  },
  State_3638_Name = {
    Text = "<ParcloseColour: バリア>"
  },
  State_3638_WeaponDesc = {
    Text = "受けるダメージが99％減少し、ダメージを1回受けるたびに1スタック減少する。"
  },
  State_3639_Desc = {
    Text = "ラモナがダメージを与えたとき、[StateArg1] の 計算力を獲得する。"
  },
  State_3639_WeaponDesc = {
    Text = "ラモナがダメージを与えたとき、[StateArg1] の 計算力を獲得する。"
  },
  State_3641_Desc = {
    Text = "「未完成の蝋人形」で選択したカードの行動力が-1"
  },
  State_3641_Name = {
    Text = "状態@章二_共鳴_基本効果"
  },
  State_3641_WeaponDesc = {
    Text = "「未完のワックス像」ノードでカードのレベル＋１"
  },
  State_3642_Desc = {
    Text = "ライフを失うたびに、[Arg1] 層のカウンターを獲得する。単一のターン内で 3 回目のトリガーの場合、すべての敵に 1 回のカウンターダメージを与える。"
  },
  State_3642_Name = {
    Text = "旧友の懐中時計"
  },
  State_3646_Desc = {
    Text = "ライフは1未満にならず、致命的ダメージを受けると、行動予測は「絶望からの生還」に変化する。【絶望からの生還】：最大ライフの100%を回復し、力を倍増し、後続のスキルを強化する。"
  },
  State_3646_Name = {
    Text = "絶望からの生還"
  },
  State_3647_Name = {
    Text = "遺物アルカナ記録カウント"
  },
  State_3648_Desc = {
    Text = "チーム唯一：装備者のライフ回復効果が <WeaponEffect_Num:[StateArg2]%> 増加する。ターン開始時、前ターンに失ったライフの <WeaponEffect_Num:[StateArg1]%> に相当する一時的な<PowerIconKeywords:力>とシールドを獲得する。"
  },
  State_3648_WeaponDesc = {
    Text = "装備者のライフ回復効果が <WeaponEffect_Num:[StateArg2]%> 増加する。ターン開始時、前ターンに失ったライフの <WeaponEffect_Num:[StateArg1]%> に相当する一時的な<PowerIconKeywords:力>とシールドを獲得する。"
  },
  State_3649_Desc = {
    Text = "チームに【超次元】職業の覚醒体が1名いるごとに、全チームの最大ライフ（未完了）、防御、攻撃が50%上昇します"
  },
  State_3649_Name = {
    Text = "超次元ボーナス"
  },
  State_3649_WeaponDesc = {
    Text = "チームに【超次元】職業の覚醒体が1名いるごとに、全チームの最大ライフ（未完了）、防御、攻撃が50%上昇します"
  },
  State_3651_Desc = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_3651_Name = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_3651_WeaponDesc = {
    Text = "使用前にカードの行動力を変更"
  },
  State_3652_Desc = {
    Text = "ターン開始時、前のターンで [StateArg1] 枚以上のカードをプレイした場合、[StateArg2] 枚のカードを引く。"
  },
  State_3652_Name = {
    Text = "遺物マジックグローブ"
  },
  State_3652_WeaponDesc = {
    Text = "ターン開始時、前のターンで [StateArg1] 枚以上のカードをプレイした場合、[StateArg2] 枚のカードを引く。"
  },
  State_3653_Name = {
    Text = "遺物破れた戦旗2"
  },
  State_3654_Desc = {
    Text = "ターン開始後、[Layer]% の一時的なクリティカルレートを獲得する。"
  },
  State_3654_Name = {
    Text = "響き渡る音"
  },
  State_3654_WeaponDesc = {
    Text = "次のターンの開始までライフを失わない場合、次のターンのクリティカルレート＋[StateArg1]％。"
  },
  State_3656_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_3656_Name = {Text = "未覚醒"},
  State_3658_Desc = {
    Text = "手札の最後の 1 枚をプレイした時、2 枚ドローする。毎ターン最大 2 回まで発動する。"
  },
  State_3659_Name = {
    Text = "状態@攻撃カードクリティカル率クリティカルダメージアップ"
  },
  State_36613_Name = {
    Text = "ステータス@装飾品メカデウスカウント"
  },
  State_3661_Desc = {
    Text = "ダメージを受けたとき、深層融食の層数が上昇"
  },
  State_3661_Name = {
    Text = "ダメージを受けると融蝕深度の点数が増加する__「開発用」"
  },
  State_3661_WeaponDesc = {
    Text = "ダメージを受けたとき、深層融食の層数が上昇"
  },
  State_3662_Desc = {
    Text = "この戦闘内でクリティカルダメージが[Layer] %増加。"
  },
  State_3662_Name = {
    Text = "クリティカルダメージ"
  },
  State_3662_WeaponDesc = {
    Text = "この戦闘内でクリティカルダメージが[Layer] %増加。"
  },
  State_36631_Desc = {
    Text = "狂気解放を発動するたびに、「生出」が1点増え、1点につき[StateArg1]点の力を獲得する、最大5点まで。"
  },
  State_36631_Name = {
    Text = "偽妊娠の宿主"
  },
  State_36635_Desc = {
    Text = "狂気解放を発動するたびに、「生出」が1点増え、1点につき[StateArg1]点の力を獲得する、最大5点まで。"
  },
  State_36635_Name = {
    Text = "リモリアの最終降臨"
  },
  State_36636_Desc = {
    Text = "5点に達すると、「リモリアの栄光！」を発動し、高ダメージを与え、眷族を呼び寄せる。"
  },
  State_36636_Name = {Text = "生出"},
  State_36637_Desc = {
    Text = "5点に達すると、「リモリアのために！」を発動し、高ダメージを与え、眷族を呼び寄せる。"
  },
  State_36637_Name = {Text = "生出"},
  State_3663_Desc = {
    Text = "ターン中に最初にカードを使用した後、対応覚醒体の「攻撃」を1枚手札に追加。"
  },
  State_3664_Desc = {
    Text = "使用後、5狂気を獲得。"
  },
  State_3664_Name = {Text = "追憶"},
  State_3664_WeaponDesc = {
    Text = "使用後、5狂気を獲得。"
  },
  State_3665_Desc = {
    Text = "胚胎融合が上限に達した後、「胚胎」を1枚手札に加える。"
  },
  State_3666_Desc = {
    Text = "クリティカルレートが [Layer] ％ 上昇します。"
  },
  State_3666_Name = {
    Text = "クリティカル率"
  },
  State_3666_WeaponDesc = {
    Text = "クリティカルレートが [Layer] ％ 上昇します。"
  },
  State_36670_Name = {
    Text = "ステータス@アクセサリー再進化カウント"
  },
  State_36670_WeaponDesc = {
    Text = "装備者のターン終了時に3点の狂気を獲得する。装備者の狂気回復が10より大きい場合、追加で2点の狂気を獲得する。"
  },
  State_3667_Desc = {
    Text = "チーム唯一：装備者が与える<RetaliateIconKeywords:反撃>が<WeaponEffect_Num:[StateArg4]%>増加する。装備者がカードを出した後、装備者の防御力の<WeaponEffect_Num:[StateArg1]%>に相当する<RetaliateIconKeywords:反撃>を獲得する。毎ターン最大2回まで。そのカードが超次元空間に入った場合、装備者はさらに<WeaponEffect_Num:[StateArg2]>点の狂気を獲得する。狂気解放を発動した後、すべての敵が装備者の防御力の<WeaponEffect_Num:[StateArg3]%>に相当する一時的な力量を失う。"
  },
  State_3667_WeaponDesc = {
    Text = "装備者が与える<RetaliateIconKeywords:反撃>が<WeaponEffect_Num:[StateArg4]%>増加する。装備者がカードを出した後、<WeaponEffect_Num:[Counterattack:DescArg1]>点の<RetaliateIconKeywords:反撃>を獲得する。毎ターン最大2回まで発動。そのカードが超次元空間に入った場合、装備者はさらに<WeaponEffect_Num:[StateArg2]>点の狂気を獲得する。狂気解放を発動した後、すべての敵の力量が一時的に<WeaponEffect_Num:[Power:DescArg2]>点減少する。"
  },
  State_3668_Desc = {
    Text = "ステータス@異化ガーデンガーディアンアイコン"
  },
  State_3668_Name = {
    Text = "ステータス@異化ガーデンガーディアンアイコン"
  },
  State_3668_WeaponDesc = {
    Text = "ステータス@異化ガーデンガーディアンアイコン"
  },
  State_3669_Desc = {
    Text = "虚弱、脆弱、易傷状態を無効化。この効果は[Layer]ターン持続する。"
  },
  State_3669_Name = {
    Text = "<BlessingColour:祝福>"
  },
  State_3669_WeaponDesc = {
    Text = "[Layer]ターンの間、付与されるデバフを無効化する。"
  },
  State_36710_Name = {
    Text = "三日月の舞"
  },
  State_3673_Desc = {
    Text = "拾取時、2枚のカードを選んで削除し、[StateArg1]のパワーを獲得する。"
  },
  State_3673_Name = {
    Text = "つくりものブラックスターバーンアッシュ"
  },
  State_3674_Desc = {
    Text = "ターン終了時、すべての覚醒体から10狂気を減少する。"
  },
  State_3674_Name = {Text = "寂滅"},
  State_3674_WeaponDesc = {
    Text = "ターン終了時、すべての覚醒体の狂気を 10 減少させる。"
  },
  State_3675_Name = {
    Text = "捨て札の枚数+1枚のカードを引く"
  },
  State_3676_Desc = {
    Text = "相手のターン中、被ダメージが[Layer]%減少する。"
  },
  State_3676_Name = {
    Text = "危険察知"
  },
  State_3676_WeaponDesc = {
    Text = "味方チームのターン時にはモンスターは [Layer] ％のダメージ軽減を獲得する"
  },
  State_3677_Desc = {
    Text = "[Layer]%の防御力を提升させる。"
  },
  State_3677_Name = {
    Text = "一時的な防御力％増加"
  },
  State_3677_WeaponDesc = {
    Text = "[Layer]%の防御力を提升させる。"
  },
  State_36781_Desc = {
    Text = "力が減少する時、力は点数の50%しか減少しない。"
  },
  State_36781_Name = {
    Text = "受肉の渇望の意志"
  },
  State_3678_Name = {
    Text = "状態@事件遺物1"
  },
  State_36797_Desc = {
    Text = "このターンの触腕ダメージが[Layer]減少する。"
  },
  State_36797_Name = {
    Text = "触腕ダメージ減少"
  },
  State_3679_Name = {
    Text = "状態@事件遺物2"
  },
  State_3680_Desc = {
    Text = "ダメージを 1 回与えるたびに、ターゲットに [Arg1] 層のポイズンを付与。本バトル内でトリガー回数が累計 25 回に達すると、即座に全敵にポイズンを発動。"
  },
  State_3681_Desc = {
    Text = "ガードされていないダメージを与えた時、ランダムな2枚の「指令カード」に [DescArg1] 層の<BrokenCard:暗中破壊>を付与する。"
  },
  State_3681_Name = {
    Text = "ジェンキン覚醒！"
  },
  State_3681_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_3682_Desc = {
    Text = "ライフが10%毎に減少すると、すべての覚醒体は10の狂気を獲得する。死亡後、触腕ダメージが加算される。"
  },
  State_3682_Name = {
    Text = "埋もれたシルバーコア__「開発用」"
  },
  State_3682_WeaponDesc = {
    Text = "ライフが10%毎に減少すると、すべての覚醒体は10の狂気を獲得する。死亡後、触腕ダメージが加算される。"
  },
  State_3683_Desc = {
    Text = "チーム唯一：装備者の指令カードによる回復量が<WeaponEffect_Num:[StateArg2]%>増加する。装備者が「狂気爆発」を発動する前に、他の覚醒体が<WeaponEffect_Num:[StateArg1]>ポイントの狂気を獲得する。味方チームが<VulnerabilityIconKeywords:被ダメージ増加>ステータスの場合、効果が2倍になる。"
  },
  State_3683_WeaponDesc = {
    Text = "装備者の指令カードによる回復量が<WeaponEffect_Num:[StateArg2]%>増加する。装備者が狂気爆発を発動する前に、他の覚醒体が<WeaponEffect_Num:[StateArg1]>ポイントの狂気を獲得する。味方チームが<VulnerabilityIconKeywords:被ダメージ増加>ステータスの場合、効果が2倍になる。"
  },
  State_3684_Desc = {
    Text = "1点のダメージを受けるごとに1回減少。回数が0になると行動予測は「不滅の花」に変化し、防御寄りのスキルセットを使用する。"
  },
  State_3684_Name = {
    Text = "不滅の花"
  },
  State_3684_WeaponDesc = {
    Text = "1 ダメージを受けるごとに 1 層減少。層が 0 になると、防御モードに切り替わります。"
  },
  State_3685_Desc = {
    Text = "引いたときに 1 計算力を失い、1 枚のカードを引く。"
  },
  State_3685_Name = {Text = "惑わし"},
  State_3685_WeaponDesc = {
    Text = "引いたときに 1 計算力を失い、1 枚のカードを引く。"
  },
  State_3686_Desc = {
    Text = "引いたときに 1 計算力を失い、1 枚のカードを引く。"
  },
  State_3686_Name = {
    Text = "次元の封印__「開発用」"
  },
  State_3686_WeaponDesc = {
    Text = "引いたときに 1 計算力を失い、1 枚のカードを引く。"
  },
  State_36884_Desc = {
    Text = "本場の戦闘で最後の誓いは、自発的にデスレジスタンスを発動してシールドを得られなくなりました。"
  },
  State_36884_Name = {
    Text = "最期の誓い"
  },
  State_3688_Desc = {
    Text = "連続2回、前のカードよりも計算力消費が高いカードをプレイ時、2計算力を獲得する。"
  },
  State_3688_Name = {
    Text = "遺物アルカナ記録__「開発用」"
  },
  State_3688_WeaponDesc = {
    Text = "連続2回、前のカードよりも計算力消費が高いカードをプレイ時、2計算力を獲得する。"
  },
  State_3689_Desc = {
    Text = "ターン開始時に領域マスタリーが30上昇する。ネガティブステータスにない場合、領域マスタリーの上昇は100になる。"
  },
  State_3692_Desc = {
    Text = "千種類の姿を持つ神秘カード。必要なものを選びなさい！"
  },
  State_3692_Name = {
    Text = "<CardKeyWord:千変万化>"
  },
  State_3692_WeaponDesc = {
    Text = "千種の姿を持つ神秘的なカード。その中から最も必要なものを選択しよう！"
  },
  State_3693_Desc = {
    Text = "クリティカル率が25%増加。ライフ回復を行った後、追加で1回ライフ回復を行う可能性があり、その確率は回復を行った者のクリティカル率に等しい。__「開発用」"
  },
  State_3693_Name = {
    Text = "状態@幻夢のシルバーキー：クリティカル治癒__「開発用」"
  },
  State_3696_Desc = {
    Text = "1回のダメージを与えるたび、このターン内に[Arg1]の警戒を獲得。ターン開始時にシールドが3残っているごとに、このターン内に1の力を獲得。"
  },
  State_3696_Name = {
    Text = "時の振り子「隠秘」"
  },
  State_3697_Desc = {
    Text = "ターン開始時に1枚カードを引く。同じ行動力消費のカードを連続で2回使用すると、追加で1枚カードを引く。"
  },
  State_3698_Desc = {
    Text = "使用した後、カードの[StateArg1]枚のコピーを一時的に<DimensionalSpaceIconKeywords:超次元空間>に加える。"
  },
  State_3698_Name = {
    Text = "<Rune_13:転送>"
  },
  State_3699_Name = {
    Text = "残留するシルバーコア"
  },
  State_3700_Desc = {
    Text = "[Layer]％の攻撃力を上昇させる。"
  },
  State_3700_Name = {
    Text = "一時的な攻撃力％向上"
  },
  State_3700_WeaponDesc = {
    Text = "[Layer]％の攻撃力を上昇させる。"
  },
  State_3702_Desc = {
    Text = "ステータス@共通最大ライフの変更"
  },
  State_3702_Name = {
    Text = "ステータス@共通最大ライフの変更"
  },
  State_3702_WeaponDesc = {
    Text = "ステータス@共通最大ライフの変更"
  },
  State_3703_Name = {
    Text = "ステータス@第四章共鳴@効果発動次のターンのドロー数2"
  },
  State_3704_Desc = {
    Text = "界域知識が30増加。拾得時に遺物を選択し、ランダムな遺物に交換します。"
  },
  State_3705_Name = {
    Text = "海月霊感3"
  },
  State_3707_Desc = {
    Text = "戦闘開始後、[StateArg1]枚の一時コピーを山札に加えてシャッフルする。元のカードとミラーカードの両方に保留を付与する。"
  },
  State_3707_Name = {
    Text = "<Rune_8:鏡像>"
  },
  State_3708_Desc = {
    Text = "偶数ターン終了時、残りの各手札で、次のターン開始時に 1 計算力を獲得する。"
  },
  State_3708_Name = {
    Text = "遺物賢者の断章2"
  },
  State_3708_WeaponDesc = {
    Text = "偶数ターン終了時、残りの各手札で、次のターン開始時に 1 計算力を獲得する。"
  },
  State_3709_Desc = {
    Text = "奇数のターン終了時、残りの計算力が 1 につき、次のターン開始時に 1 枚ドローする。"
  },
  State_3709_Name = {
    Text = "遺物賢者の断章1"
  },
  State_3709_WeaponDesc = {
    Text = "奇数のターン終了時、残りの計算力が 1 につき、次のターン開始時に 1 枚ドローする。"
  },
  State_3711_Desc = {
    Text = "行動するたびに[Layer]出血を引き起こす"
  },
  State_3711_Name = {Text = "血飛沫"},
  State_3711_WeaponDesc = {
    Text = "各行動で [Layer] の出血を引き起こし、治療で出血の層数を半分に減らすことができます。"
  },
  State_3712_Desc = {
    Text = "カードを使用した後に消費し、指令カードが3倍のダメージと防御を発生させる。1ターン持続。"
  },
  State_3714_Desc = {
    Text = "打出後、[StateArg1]ptのシールドを獲得する。"
  },
  State_3714_Name = {
    Text = "<Rune_6:鉄壁>"
  },
  State_3716_Desc = {
    Text = "この戦闘内でクリティカル率が[Layer]％増加。"
  },
  State_3716_Name = {
    Text = "クリティカル率"
  },
  State_3719_Desc = {
    Text = "アクティブダメージを受けた時、触手カウンターでダメージの発生源を攻撃する、[Layer] ターン持続する。"
  },
  State_3719_Name = {
    Text = "異端の継承"
  },
  State_3720_Desc = {
    Text = "[Layer]の防御力を上げる。"
  },
  State_3720_Name = {
    Text = "汎用防御力増加"
  },
  State_3720_WeaponDesc = {
    Text = "[Layer]の防御力を上げる。"
  },
  State_3721_Desc = {
    Text = "使用すると捨て札に行かず、デッキから除去する。"
  },
  State_3721_Name = {Text = "消費"},
  State_3721_WeaponDesc = {
    Text = "プレイ後、 カードは捨て札の山に入らず、 このバトルでは再び使用できません。"
  },
  State_3722_Desc = {
    Text = "ダメージを与えるたびに、一時的に [StateArg1] の触手ダメージが上昇し、最大 5 スタックまで重ね挂け可能。スタックが満タンになったときに 1 本の触手が生成される。"
  },
  State_3722_Name = {
    Text = "遺物祭司の杖"
  },
  State_3722_WeaponDesc = {
    Text = "ダメージを与えるたびに、一時的に [StateArg1] の触手ダメージが上昇し、最大 5 スタックまで重ね挂け可能。スタックが満タンになったときに 1 本の触手が生成される。"
  },
  State_3723_Name = {
    Text = "遺物黒い鏡面"
  },
  State_3724_Desc = {
    Text = "拾取時に他のすべてのつくりものを失い、ランダムに2つのゴールドクリエイションを獲得する。"
  },
  State_3726_Name = {
    Text = "歪んだ死体の宴"
  },
  State_3728_Desc = {
    Text = "バトル開始時、[打撃]を獲得します。"
  },
  State_3728_Name = {
    Text = "くじらとび霊気1"
  },
  State_3728_WeaponDesc = {
    Text = "バトル開始時、[打撃]を獲得します。"
  },
  State_3730_Desc = {
    Text = "ステータス@モンスター甘い悪鬼はちみつ色の悲惨な幻象"
  },
  State_3730_Name = {
    Text = "ステータス@モンスター甘い悪鬼はちみつ色の悲惨な幻象"
  },
  State_3730_WeaponDesc = {
    Text = "ステータス@モンスター甘い悪鬼はちみつ色の悲惨な幻象"
  },
  State_3731_Desc = {
    Text = "味方のチームがショップで買い物をした後、次のバトルでは毎ターン追加で1枚のカードを引き、1点計算力を獲得。"
  },
  State_3732_Desc = {
    Text = "3ターンごとに、一時的なタッチアームを3本獲得する。このタッチアームは触腕上限を無視する。"
  },
  State_3732_Name = {
    Text = "遺物無名の付肢"
  },
  State_3732_WeaponDesc = {
    Text = "3ターンごとに、一時的なタッチアームを3本獲得する。このタッチアームは触腕上限を無視する。"
  },
  State_3733_Desc = {
    Text = "奇数ターン終了時、残りの行動力が次ターンの追加ドローになる。偶数ターン終了時、残りの手札が次ターンの追加行動力になる。"
  },
  State_3735_Name = {
    Text = "味方チームの「毒」の点数が半減する。"
  },
  State_3738_Desc = {
    Text = "ターン終了時に<EmbryoFusionIconKeywords:胚胎融合>+15％。手札に「胚胎」がある場合、[Arg1]ライフを回復。"
  },
  State_3738_Name = {
    Text = "疫病診断書"
  },
  State_3739_Name = {
    Text = "アクセサリーの有機形態効果"
  },
  State_3739_WeaponDesc = {
    Text = "装備者が狂気解放を使用した後、そのターン内で自身のシールドと治療の強力が2倍になる。"
  },
  State_3740_Name = {
    Text = "ステータス@甘い悪鬼クリティカルカウント"
  },
  State_3741_Desc = {
    Text = "第3ラウンド開始時、「過去の響き——すべての手札を捨て、現在のライフとシールドを前ターン終了時の状態に戻す。保持、消耗。」を1枚手札に追加。"
  },
  State_3742_Desc = {
    Text = "使用後、すべての敵に[StateArg1]点の易傷を付与する。"
  },
  State_3742_Name = {
    Text = "<Rune_1:易傷>"
  },
  State_3743_Desc = {
    Text = "6枚目に使用するカードが2回効果を発揮する。__「開発用」"
  },
  State_3743_Name = {
    Text = "遺物星々の酒__「開発用」"
  },
  State_3744_Name = {
    Text = "遺物メンフィスの鏡カウント"
  },
  State_3747_Name = {
    Text = "山札からカードを1枚選択して手札に追加する"
  },
  State_3748_Name = {
    Text = "クリティカル率が[DescArg1]%増加し、クリティカルダメージが[DescArg2]%増加する"
  },
  State_3750_Name = {
    Text = "一時的なクリティカル率+[DescArg1]%。この戦闘中「首切りの一撃」と「千変万化」の基礎ダメージが5%増加"
  },
  State_3751_Name = {
    Text = "[StateArg1]点の<PowerIconKeywords:力>を獲得"
  },
  State_3752_Name = {
    Text = "<Posse:[DescArg1]>キーエネルギーを獲得。<Block:[Block:StateArg1]>点のシールドを獲得"
  },
  State_3753_Desc = {
    Text = "捨て札フェイズ時、捨て札に行かず、手札に残る。"
  },
  State_3753_Name = {
    Text = "<RetainIconKeywords:保持>"
  },
  State_3753_WeaponDesc = {
    Text = "カードは捨てのフェイズにおいて捨て札の山に移動せず、手札のまま残ります。"
  },
  State_3754_Desc = {
    Text = "アクティブダメージを与えた時、本ターン内の触腕ダメージが[Arg1]向上し、最大3回までスタック可能。スタックが最大になると1本の触腕を生成し、ターン終了後に除去される。"
  },
  State_3755_Desc = {
    Text = "チーム唯一：装備者が与えるシールドが<WeaponEffect_Num:[StateArg1]%>増加し、HP回復が<WeaponEffect_Num:[StateArg1]%>増加する。奇数ターン終了時、装備者のクリティカル率+<WeaponEffect_Num:[StateArg2]%>、<WeaponEffect_Num:[StateArg3]>点の狂気を獲得。偶数ターン終了時、装備者のクリティカルダメージ+<WeaponEffect_Num:[StateArg2]%>、<WeaponEffect_Num:[StateArg4]>銀鍵エネルギーを獲得。現在界域が「血肉」の場合、深紅の炉の蓄積上限が<WeaponEffect_Num:[StateArg5]%>増加する。"
  },
  State_3755_WeaponDesc = {
    Text = "装備者が与えるシールドが<WeaponEffect_Num:[StateArg1]%>増加し、HP回復が<WeaponEffect_Num:[StateArg1]%>増加する。奇数ターン終了時、装備者のクリティカル率+<WeaponEffect_Num:[StateArg2]%>、<WeaponEffect_Num:[StateArg3]>点の狂気を獲得。偶数ターン終了時、装備者のクリティカルダメージ+<WeaponEffect_Num:[StateArg2]%>、<WeaponEffect_Num:[StateArg4]>銀鍵エネルギーを獲得。現在界域が「血肉」の場合、深紅の炉の蓄積上限が<WeaponEffect_Num:[StateArg5]%>増加する。"
  },
  State_3757_Desc = {
    Text = "味方のチームが 1 枚のカードを出すたびに、[StateArg1] 層のシールドを獲得する。1 ターン持続。"
  },
  State_3757_Name = {
    Text = "羽が舞う"
  },
  State_3757_WeaponDesc = {
    Text = "味方のチームが 1 枚のカードを出すたびに、[StateArg1] 層のシールドを獲得する。1 ターン持続。"
  },
  State_3759_Name = {
    Text = "機械武装1"
  },
  State_3760_Desc = {
    Text = "もし [StateArg1] 個以上のブラックスタンプを持っている場合、[狂気解放]で [StateArg1] 個のブラックスタンプを失い、すべての敵を 1 ターンの間弱点・弱りにする。"
  },
  State_3760_Name = {
    Text = "遺物不運の儀式鳥"
  },
  State_3760_WeaponDesc = {
    Text = "もし [StateArg1] 個以上のブラックスタンプを持っている場合、[狂気解放]で [StateArg1] 個のブラックスタンプを失い、すべての敵を 1 ターンの間弱点・弱りにする。"
  },
  State_3761_Desc = {
    Text = "味方が1枚の「よろよろ」を引くたび、[Layer]点の力を獲得。"
  },
  State_3761_Name = {
    Text = "提灯の儀式"
  },
  State_3761_WeaponDesc = {
    Text = "我方チームが「よろめく」を1枚引くたびに、[Layer] ptのパワーを獲得する。"
  },
  State_3763_Desc = {
    Text = "ランナーが 1 回ダメージを与えるたびに、今ターンのクリティカルダメージが [StateArg3]% 上昇する。"
  },
  State_3763_Name = {
    Text = "通路折り畳み"
  },
  State_3763_WeaponDesc = {
    Text = "ランナーが 1 回ダメージを与えるたびに、今ターンのクリティカルダメージが [StateArg3]% 上昇する。"
  },
  State_3764_Name = {
    Text = "機械武装2"
  },
  State_3766_Name = {
    Text = "深紅の力の倍率を追加"
  },
  State_3767_Desc = {
    Text = "ターン開始時、ランダムな敵1体に[Arg1]ダメージを与える。この戦闘中に7回「攻撃」を使用すると、ダメージが[Arg2]になる。"
  },
  State_3767_Name = {
    Text = "古びたパズル"
  },
  State_3768_Desc = {
    Text = "受けるアクティブダメージが必ずクリティカルになる。ターン終了後に解除。"
  },
  State_3768_Name = {Text = "破綻"},
  State_3768_WeaponDesc = {
    Text = "受けるアクティブダメージは必ずクリティカルとなり、ターン終了時に解除されます。"
  },
  State_3770_Name = {
    Text = "遺物アルカナ遺物カウント"
  },
  State_3771_Desc = {
    Text = "戦闘開始時、3の行動力を獲得。"
  },
  State_3772_Desc = {
    Text = "復讐の巨剣が 1 回ダメージを与えるたびに、現在の触手ダメージに相当する一時的な力が上昇する。"
  },
  State_3772_Name = {
    Text = "復讐の予行"
  },
  State_3773_Desc = {
    Text = "ターン終了時に同スタック数の<FixedDamage:純粋ダメージ>を受ける。"
  },
  State_3773_Name = {
    Text = "<IntoxicationIconKeywords:毒>"
  },
  State_3773_WeaponDesc = {
    Text = "ターン開始時にダメージを受ける。"
  },
  State_3774_Desc = {
    Text = "毎ターン「狂気解放」をリリースすると、[Arg1] ポイズンの「毒感染」カードを1枚獲得します。ターン終了時に手札に3枚の「毒感染」がある場合、中毒をトリガーする「毒発動」を1枚合成できます。"
  },
  State_3776_Desc = {
    Text = "アクティブダメージを受けるたびに、「警鐘」が1回増加。「警鐘」が3回に達すると後退する。"
  },
  State_3776_Name = {
    Text = "臆病な人形"
  },
  State_3776_WeaponDesc = {
    Text = "積極的なダメージを受けるたびに、「警戒状態」が1層追加されます。「警戒状態」が3層に達すると後退します。"
  },
  State_3777_Desc = {
    Text = "打出後所属覚醒体が[StateArg1]点の狂気を獲得。"
  },
  State_3777_Name = {
    Text = "<Rune_5_High:上位発狂>"
  },
  State_3777_WeaponDesc = {
    Text = "打出後所属覚醒体が[StateArg1]点の狂気を獲得。"
  },
  State_3778_Desc = {
    Text = "デバフ状態の敵に与えるダメージが25%増加し、敵を倒すと倒した者が20狂気を獲得。"
  },
  State_3779_Desc = {
    Text = "触腕上限 -2。ターン終了時にすべての触腕が追加攻撃を1回行う。__「開発用」"
  },
  State_3779_Name = {
    Text = "遺物苦痛の聖腕"
  },
  State_3779_WeaponDesc = {
    Text = "触腕の上限が 2本減少。ターン終了時にすべての触腕を追加で 1 回攻撃させる。"
  },
  State_3781_Desc = {
    Text = "ターン開始時、デッキの上から2枚のカードに「停滞の呪い」をかける。"
  },
  State_3781_Name = {
    Text = "「深淵の呪眼」"
  },
  State_3781_WeaponDesc = {
    Text = "ターン開始時、デッキの上から2枚のカードに「停滞呪詛」を付与する。"
  },
  State_3782_Desc = {
    Text = "チーム唯一：探索開始時、装備者の「防御」を1枚デッキに加える。装備者の「防御」シールドが<WeaponEffect_Num:[StateArg1]%>増加する。"
  },
  State_3782_WeaponDesc = {
    Text = "探索開始時、装備者の「防御」を1枚デッキに加える。装備者の「防御」シールドが<WeaponEffect_Num:[StateArg1]%>増加する。"
  },
  State_3783_Desc = {
    Text = "チーム唯一：装備者の狂気解放の基礎ダメージが<WeaponEffect_Num:[StateArg1]％>増加し、シールドとライフ回復が<WeaponEffect_Num:[StateArg2]％>増加する。"
  },
  State_3783_WeaponDesc = {
    Text = "装備者の狂気解放の基礎ダメージが<WeaponEffect_Num:[StateArg1]％>増加し、シールドとライフ回復が<WeaponEffect_Num:[StateArg2]％>増加する。"
  },
  State_3784_Desc = {
    Text = "チーム唯一：装備者の指令カードの基礎ダメージが<WeaponEffect_Num:[StateArg1]％>増加し、シールドとライフ回復が<WeaponEffect_Num:[StateArg2]％>増加する。"
  },
  State_3784_WeaponDesc = {
    Text = "装備者の指令カードの基礎ダメージが<WeaponEffect_Num:[StateArg1]％>増加し、シールドとライフ回復が<WeaponEffect_Num:[StateArg2]％>増加する。"
  },
  State_3786_Desc = {
    Text = "ロックオンされた！このカードを使用すると、すべての敵が [StateArg1]点の一時的な力を獲得し、このカードの「水底の印」は除去される。"
  },
  State_3786_Name = {
    Text = "<CardKeyWord:汚染：深潜の印>"
  },
  State_3786_WeaponDesc = {
    Text = "カードをプレイした後、深潜者は [StateArg1] 点の一時的な力を獲得します。"
  },
  State_3787_Desc = {
    Text = "チーム唯一：装備者が狂気解放を発動した後、すべての味方が<WeaponEffect_Num:[StateArg1]>狂気を獲得する。"
  },
  State_3787_WeaponDesc = {
    Text = "装備者が狂気解放を発動した後、すべての味方が<WeaponEffect_Num:[StateArg1]>狂気を獲得する。"
  },
  State_3788_Desc = {
    Text = "チーム唯一：探索開始時、装備者の「打撃」を1枚デッキに加える。装備者の「打撃」基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。"
  },
  State_3788_WeaponDesc = {
    Text = "探索開始時、装備者の「打撃」を1枚デッキに加える。装備者の「打撃」基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。"
  },
  State_3790_Desc = {
    Text = "ステータス＠不定性物質カウント"
  },
  State_3790_Name = {
    Text = "ステータス＠不定性物質カウント"
  },
  State_3790_WeaponDesc = {
    Text = "ステータス＠不定性物質カウント"
  },
  State_3791_Desc = {
    Text = "ダメージを与えるたびに [Arg1] 点のシールドを獲得し、ターンごとに最大 5 回まで重ねられる。層が満タンになったら、「インスピレーション」カードを手札に加える。"
  },
  State_3792_Desc = {
    Text = "石化の影響を受けない。"
  },
  State_3792_Name = {
    Text = "石化耐性"
  },
  State_3792_WeaponDesc = {
    Text = "石化の効果を受けなくなり、代わりに3倍のダメージを受ける"
  },
  State_3793_Desc = {
    Text = "このステージでクリティカルダメージが[Layer] %増加。"
  },
  State_3793_Name = {
    Text = "永続のクリティカルダメージ"
  },
  State_3793_WeaponDesc = {
    Text = "このステージでクリティカルダメージが[Layer] %増加。"
  },
  State_3794_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_3794_Name = {
    Text = "状態@試作長剣クリティカルダメージ"
  },
  State_3796_Desc = {
    Text = "ライフが20%毎に減少すると、すべての覚醒体は10の狂気を獲得する。死亡後、触腕ダメージが上昇する"
  },
  State_3796_Name = {
    Text = "析出した銀粒__「開発用」"
  },
  State_3796_WeaponDesc = {
    Text = "ライフが20%毎に減少すると、すべての覚醒体は10の狂気を獲得する。死亡後、触腕ダメージが上昇する"
  },
  State_3797_Desc = {
    Text = "ダメージを受けるたびに、[StateArg1]点の一時的な力を獲得、ターン開始時に解除。"
  },
  State_3797_Name = {
    Text = "鼠の怒り！"
  },
  State_37980_Desc = {
    Text = "この戦闘内で界域知識が [Layer] 増加。"
  },
  State_37980_Name = {
    Text = "界域知識"
  },
  State_3798_Desc = {
    Text = "実際のダメージを与えた後、ライフを回復。"
  },
  State_3798_Name = {
    Text = "吸血の刃"
  },
  State_3798_WeaponDesc = {
    Text = "実際のダメージを与えると、ライフが回復します。"
  },
  State_3799_Desc = {
    Text = "チームに【血肉】職の覚醒体がいるごとに、全隊の最大ライフ（未完了）、防御、攻撃が50%アップします"
  },
  State_3799_Name = {
    Text = "血肉ボーナス"
  },
  State_3799_WeaponDesc = {
    Text = "チームに【血肉】職の覚醒体がいるごとに、全隊の最大ライフ（未完了）、防御、攻撃が50%アップします"
  },
  State_3800_Desc = {
    Text = "すべての敵にダメージを与える。<CardKeyWord:力>がこのダメージに2倍の効果を発揮する。"
  },
  State_3800_Name = {
    Text = "<CardKeyWord:巨刃の威>"
  },
  State_3801_Desc = {
    Text = "ガードされなかったダメージを与えた時、[StateArg1]点の出血を付与する。"
  },
  State_3801_Name = {Text = "出血"},
  State_3802_Desc = {
    Text = "手札にある時、指令カードを1枚使用するたび、その行動力0のコピーに変化する。"
  },
  State_3802_Name = {
    Text = "<CardKeyWord:聖純の子>"
  },
  State_3802_WeaponDesc = {
    Text = "手札にあるとき、1枚を使用するたびに、その計算力が0のコピーになる。"
  },
  State_3803_Desc = {
    Text = "戦闘開始時、行動力消費が1のカードのダメージ、シールド、治癒効果が[Arg1]増加。"
  },
  State_3804_Desc = {
    Text = "異化フィッシュフォーク カウント"
  },
  State_3804_Name = {
    Text = "異化フィッシュフォーク カウント"
  },
  State_3804_WeaponDesc = {
    Text = "異化フィッシュフォーク カウント"
  },
  State_3807_Name = {
    Text = "装飾品の薬入りの夢"
  },
  State_3807_WeaponDesc = {
    Text = "バトル開始後、装備者の1セットのカードを追加でドロー山に混ぜる。"
  },
  State_3808_Desc = {
    Text = "ステータス@共通現在のライフを変える"
  },
  State_3808_Name = {
    Text = "ステータス@共通現在のライフを変える"
  },
  State_3808_WeaponDesc = {
    Text = "ステータス@共通現在のライフを変える"
  },
  State_3810_Desc = {
    Text = "死亡後、他の味方の力が増加する。__「開発用」"
  },
  State_3810_Name = {Text = "死語"},
  State_3811_Desc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3811_Name = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3811_WeaponDesc = {
    Text = "ステータス@プロローグリセットデッキ0＿1＿4＿1"
  },
  State_3813_Name = {
    Text = "倦怠無効化"
  },
  State_3815_Desc = {
    Text = "ターン終了時、すべての覚醒体は[Layer]狂気を失う。"
  },
  State_3815_Name = {
    Text = "<EnergyColour:虚無>"
  },
  State_3815_WeaponDesc = {
    Text = "獲得する狂気が[Layer]%減少。"
  },
  State_3817_Desc = {
    Text = "ターン開始時、相手に[DescArg1]の衰弱を与える。"
  },
  State_3817_Name = {Text = "散逸"},
  State_3817_WeaponDesc = {
    Text = "ターン開始時、味方チームは [DescArg1*Layer*0.01] 層の衰竭を得る"
  },
  State_3818_Name = {
    Text = "状態@才媛剣士霊知啓発1"
  },
  State_3819_Name = {
    Text = "チェインブレイカー霊気1"
  },
  State_3819_WeaponDesc = {
    Text = "古代者模倣"
  },
  State_3821_Desc = {
    Text = "ターン開始時、前のターンに失ったライフの半分のシールドを獲得。"
  },
  State_3821_Name = {
    Text = "苦痛と歓喜"
  },
  State_3821_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_3824_Desc = {
    Text = "チーム唯一：装備者の狂気解放の基礎ダメージが[StateArg1]%増加する。探索開始時、装備者は学者人格状態に入る。装備者が狂気解放を発動した後、学者人格と道化師人格の間で切り替わる。\n学者人格：ターン終了時、装備者は<WeaponEffect_Num:[StateArg2]>点の狂気を獲得する。\n道化師人格：ターン終了時、装備者のクリティカル率とクリティカルダメージが<WeaponEffect_Num:+[StateArg3]%>。"
  },
  State_3824_WeaponDesc = {
    Text = "装備者の狂気解放の基礎ダメージが[StateArg1]%増加する。探索開始時、装備者は学者人格状態に入る。装備者が狂気解放を発動した後、学者人格と道化師人格の間で切り替わる。\n学者人格：ターン終了時、装備者は<WeaponEffect_Num:[StateArg2]>点の狂気を獲得する。\n道化師人格：ターン終了時、装備者のクリティカル率とクリティカルダメージが<WeaponEffect_Num:+[StateArg3]%>。"
  },
  State_3825_Desc = {
    Text = "アクティブダメージを受けた時、ダメージ源に同スタック数の<FixedDamage:純粋ダメージ>を与える。"
  },
  State_3825_Name = {
    Text = "<RetaliateIconKeywords:反撃>"
  },
  State_3825_WeaponDesc = {
    Text = "アクティブダメージを受けるたびに、攻撃者に<FixedDamage:純粋ダメージ>を与える。"
  },
  State_3826_Name = {
    Text = "状態@幻夢のシルバーキー：爆発カウント"
  },
  State_3827_Desc = {
    Text = "チーム唯一：装備者のライフ回復が<WeaponEffect_Num:[StateArg1]%>増加する。狂気爆発を発動した後、次のターン開始時に失ったライフの<WeaponEffect_Num:[StateArg2]%>を回復する。"
  },
  State_3827_WeaponDesc = {
    Text = "装備者のライフ回復が<WeaponEffect_Num:[StateArg1]%>増加する。狂気爆発を発動した後、次のターン開始時に失ったライフの<WeaponEffect_Num:[DescArg1]%>を回復する。"
  },
  State_3830_Name = {
    Text = "追加で1回効果発動"
  },
  State_3831_Name = {
    Text = "遺物逆生根"
  },
  State_3834_Desc = {
    Text = "ダンジョンの蜘蛛が引き起こすポイズンが2倍になる。"
  },
  State_3834_Name = {
    Text = "迷途の旅"
  },
  State_3835_Desc = {
    Text = "このターンのクリティカルダメージが[Layer]%増加。"
  },
  State_3835_Name = {
    Text = "一時的なクリティカルダメージ"
  },
  State_3835_WeaponDesc = {
    Text = "このターンのクリティカルダメージが[Layer]%増加。"
  },
  State_3836_Desc = {
    Text = "テスト123"
  },
  State_3836_Name = {
    Text = "テスト123"
  },
  State_3837_Desc = {
    Text = "チームユニーク：装備者が与える狂気が <WeaponEffect_Num:[StateArg1]%> 上昇し、与える毒が <WeaponEffect_Num:[StateArg2]%> 上昇する。装備者がアクティブダメージを与えた後、全ての覚醒体の一時的なクリティカルダメージが上昇し、その値は装備者の基礎クリティカルダメージの <WeaponEffect_Num:[StateArg3]%> に相当し、1ターンに最大1回まで発動する。現在の領域が「深海」の場合、戦闘開始時に触手上限と触腕数 +1。"
  },
  State_3837_WeaponDesc = {
    Text = "装備者が与える狂気が <WeaponEffect_Num:[StateArg1]%> 上昇し、与える毒が <WeaponEffect_Num:[StateArg2]%> 上昇する。装備者がアクティブダメージを与えた後、全ての覚醒体の一時的なクリティカルダメージ +<WeaponEffect_Num:[DescArg1]%>、1ターンに最大1回まで発動する。現在の領域が「深海」の場合、戦闘開始時に触手上限と触腕数 +1。"
  },
  State_3839_Desc = {
    Text = "戦闘開始時に、デッキに1枚の症状カードがあるごとに[Arg1]力量を獲得。すべての症状カードが虚無を獲得。"
  },
  State_3840_Desc = {
    Text = "ライフが減少するたびに、[StateArg1]の警戒を獲得。"
  },
  State_3840_Name = {Text = "警鐘"},
  State_3842_Desc = {
    Text = "与えるアクティブおよび触手ダメージが [DescArg1] ％低下する。"
  },
  State_3842_WeaponDesc = {
    Text = "すべてのダメージが [DescArg1] ％減少します。"
  },
  State_3843_Desc = {
    Text = "行動するたびに[Layer]点の出血を付与する"
  },
  State_3843_Name = {Text = "重傷"},
  State_3843_WeaponDesc = {
    Text = "各行動で[Layer]出血を追加し、治療で出血効果を除去できる"
  },
  State_3844_Desc = {
    Text = "くじらとびのすべてのダメージ回数＋1。"
  },
  State_3844_Name = {
    Text = "戦欲抑え難し"
  },
  State_3844_WeaponDesc = {
    Text = "くじらとびのすべてのダメージ回数＋1。"
  },
  State_3845_Desc = {
    Text = "カードの行動力消費減少"
  },
  State_3845_Name = {
    Text = "カードの行動力消費減少"
  },
  State_3845_WeaponDesc = {
    Text = "カードの行動力消費減少"
  },
  State_3846_Name = {
    Text = "遺物翡翠の拓印"
  },
  State_3848_Desc = {
    Text = "この戦闘中、ランダムな覚醒体の狂気解放が封印され、使用不可。"
  },
  State_3850_Desc = {
    Text = "毎第 [StateArg1] 枚のカードをプレイした時、[StateArg2] の触腕ダメージを上昇させ、すべての触腕が 1 回攻撃する。"
  },
  State_3850_Name = {Text = "異化銛"},
  State_3850_WeaponDesc = {
    Text = "毎第 [StateArg1] 枚のカードをプレイした時、[StateArg2] の触腕ダメージを上昇させ、すべての触腕が 1 回攻撃する。"
  },
  State_3851_Name = {
    Text = "「密約」劇場猫"
  },
  State_3851_WeaponDesc = {
    Text = "すべてのダメージがアップし、アップ値は装備者の最大ライフの10％に相当する"
  },
  State_3852_Desc = {
    Text = "「噛みつく」のダメージ回数が[Layer]回増加する。"
  },
  State_3852_Name = {
    Text = "漸強の噛みつき"
  },
  State_3852_WeaponDesc = {
    Text = "「噛みつく」のダメージ回数が[Layer]回増加する。"
  },
  State_3853_Desc = {
    Text = "ターン開始時、山札内の指令カードのコピーにランダムに変形し、その行動力消費は3に固定され、ターン終了時に元に戻る。"
  },
  State_3853_Name = {
    Text = "<CardKeyWord:錯乱>"
  },
  State_3853_WeaponDesc = {
    Text = "カードは捨てのフェイズにおいて捨て札の山に移動せず、手札のまま残ります。"
  },
  State_3854_Desc = {
    Text = "カードを2枚引き、首狩りの注意を引く。"
  },
  State_3854_Name = {
    Text = "<CardKeyWord:狩猟目標>"
  },
  State_3855_Name = {Text = "力"},
  State_3856_Desc = {
    Text = "ステータス@序章リセットデッキ0＿1＿3＿1"
  },
  State_3856_Name = {
    Text = "ステータス@序章リセットデッキ0＿1＿3＿1"
  },
  State_3856_WeaponDesc = {
    Text = "ステータス@序章リセットデッキ0＿1＿3＿1"
  },
  State_3859_Desc = {
    Text = "豊穣の息によって狂気が2倍になる。"
  },
  State_3859_Name = {
    Text = "慈母邂逅"
  },
  State_3859_WeaponDesc = {
    Text = "豊穣の息によって狂気が2倍になる。"
  },
  State_3860_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_3860_Name = {
    Text = "状態@試作小刀幸運"
  },
  State_3862_Name = {
    Text = "状態@ステージ2_15戦闘4バブル1"
  },
  State_3863_Desc = {
    Text = "3回の狂気解放ごとに、すべての手札の計算力消費が1低下げる。"
  },
  State_3866_Desc = {
    Text = "このターン中、手札の上限+[Layer]。"
  },
  State_3866_Name = {
    Text = "手札の上限増加"
  },
  State_3867_Name = {
    Text = "超次元ショウギョウカウンター"
  },
  State_3868_Desc = {
    Text = "このターンに獲得するシールドが[Layer]点増加。"
  },
  State_3868_Name = {
    Text = "一時的警戒"
  },
  State_3868_WeaponDesc = {
    Text = "このターンに獲得するシールドが[Layer]点増加。"
  },
  State_3872_Desc = {
    Text = "ダメージを受けると一時的な力を解除する。"
  },
  State_3872_Name = {Text = "破綻"},
  State_38730_Desc = {
    Text = "ターン開始後、[DescArg1]％の確率で1層の触手集合を獲得。100％を超える場合は複数層を獲得できます。"
  },
  State_38730_Name = {
    Text = "深海航路"
  },
  State_38735_Desc = {
    Text = "与えるアクティブダメージが[StateArg1]％減少し、攻撃回数が2倍になり、[Layer]ターン持続する。"
  },
  State_38735_Name = {
    Text = "夢の呟き"
  },
  State_38738_Desc = {
    Text = "上限は10点、次の戦闘に引き継がれる。"
  },
  State_38738_Name = {Text = "夢引き"},
  State_3873_Desc = {
    Text = "この戦闘で界域知識が[Layer]点増加。"
  },
  State_3873_Name = {
    Text = "界域知識"
  },
  State_3874_Name = {
    Text = "状態@風鈴カード復元"
  },
  State_3876_Desc = {
    Text = "偶数ターンごとに味方の力が減少。__「開発用」"
  },
  State_3876_Name = {
    Text = "「死夢の穴」__「開発用」"
  },
  State_3878_Desc = {
    Text = "2のライフを失うごとに、次のターン開始時に[Layer]のシールドを獲得。"
  },
  State_3878_Name = {
    Text = "苦痛と歓喜"
  },
  State_3878_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_3879_Desc = {
    Text = "拾得時、最大ライフが[Arg1]増加。拾得時にライフが25%未満の場合、最大ライフの増加は[Arg2]になる。"
  },
  State_3881_Desc = {
    Text = "ステータス@モンスターのジョージがワックス像のミニモンスターを食べる"
  },
  State_3881_Name = {
    Text = "ステータス@モンスターのジョージがワックス像のミニモンスターを食べる"
  },
  State_3881_WeaponDesc = {
    Text = "ステータス@モンスターのジョージがワックス像のミニモンスターを食べる"
  },
  State_3882_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_3882_Name = {Text = "未覚醒"},
  State_3883_Desc = {
    Text = "このステージでクリティカル率が[Layer] %増加。"
  },
  State_3883_Name = {
    Text = "永続のクリティカル率"
  },
  State_3883_WeaponDesc = {
    Text = "このステージでクリティカル率が[Layer]%増加 。"
  },
  State_3884_Desc = {
    Text = "毎ターン、追加で 1 個の胚融合度が生成される。あなたのすべての呑食効果は無限呑食に変わる。"
  },
  State_3884_Name = {
    Text = "遺物蠢く臍帯__「開発用」"
  },
  State_3884_WeaponDesc = {
    Text = "毎ターン、追加で 1 個の胚融合度が生成される。あなたのすべての呑食効果は無限呑食に変わる。"
  },
  State_3888_Desc = {
    Text = "狂気解放を発動できず、ターン終了時に1点を除去。"
  },
  State_3888_WeaponDesc = {
    Text = "すべての覚醒体の狂気解放は使用できません。"
  },
  State_3890_Name = {
    Text = "捨て札の枚数+[DescArg1]枚のカードを引く"
  },
  State_3893_Desc = {
    Text = "ダメージを与えるとき、[Arg1] のシールドを獲得する。ライフを回復するとき、[Arg2] の一時的な力を獲得する。"
  },
  State_3893_Name = {Text = "我が家"},
  State_3894_Desc = {
    Text = "棄牌フェイズ前に手札を石に変える"
  },
  State_3894_WeaponDesc = {
    Text = "棄牌フェイズ前に手札を石に変える"
  },
  State_3895_Desc = {
    Text = "このターンのクリティカルレートが [Layer] ％上昇します。"
  },
  State_3895_Name = {
    Text = "一時的なクリティカル率"
  },
  State_3895_WeaponDesc = {
    Text = "このターンのクリティカルレートが [Layer] ％上昇します。"
  },
  State_3898_Desc = {
    Text = "次のターン開始時に[Layer]シールドを獲得。"
  },
  State_3898_Name = {
    Text = "苦痛と歓喜のシールド"
  },
  State_3900_Name = {
    Text = "カードが封印され、使用できない。捨てる時に解除される"
  },
  State_3901_Name = {
    Text = "遺物祭司の杖カウント"
  },
  State_3902_Desc = {
    Text = "このターンに与えるアクティブダメージが[Layer]減少。"
  },
  State_3902_Name = {
    Text = "力の減少"
  },
  State_3902_WeaponDesc = {
    Text = "このターンに与えるダメージが[Layer]減少。"
  },
  State_3904_Desc = {
    Text = "ライフを1点失うごとに1点除去され、点数が0になった時、[StateArg1]点のシールドを獲得し、再度[StateArg2]点の血のバリアを獲得する。"
  },
  State_3904_Name = {
    Text = "覚醒-血のバリア"
  },
  State_3905_Desc = {
    Text = "アクティブダメージを受けるたびに、ダメージの発生源に [Layer] 点の<FixedDamage:純粋ダメージ>を与える。"
  },
  State_3905_Name = {Text = "反撃"},
  State_3905_WeaponDesc = {
    Text = "アクティブダメージを受けるたびに、攻撃者に [Layer] 点の<FixedDamage:純粋ダメージ>を与える。"
  },
  State_3906_Name = {
    Text = "残留するシルバーコア"
  },
  State_3907_Name = {
    Text = "残留するシルバーコア"
  },
  State_3908_Desc = {
    Text = "缸の中の脳が回復するとき、[Arg2] 枚のカードを引く。"
  },
  State_3908_Name = {
    Text = "虚実二象"
  },
  State_3908_WeaponDesc = {
    Text = "缸の中の脳が回復するとき、[Arg2] 枚のカードを引く。"
  },
  State_3909_Name = {
    Text = "残留するシルバーコア"
  },
  State_3910_Name = {
    Text = "残留するシルバーコア"
  },
  State_3911_Name = {
    Text = "残留するシルバーコア"
  },
  State_3912_Name = {
    Text = "残留するシルバーコア"
  },
  State_3913_Desc = {
    Text = "チーム唯一：装備者が与えるシールドが<WeaponEffect_Num:[StateArg1]%>増加する。ターン開始時、残りシールドの<WeaponEffect_Num:[StateArg2]%>を保持する。保持されるシールドは最大HP の<WeaponEffect_Num:[StateArg3]%>分のシールドまで。"
  },
  State_3913_WeaponDesc = {
    Text = "装備者が与えるシールドが<WeaponEffect_Num:[StateArg1]%>増加する。ターン開始時、残りシールドの<WeaponEffect_Num:[StateArg2]%>を保持する。保持されるシールドは最大HPの<WeaponEffect_Num:[StateArg3]%>分のシールドまで。"
  },
  State_3914_Desc = {
    Text = "毎ターン2回目の狂気解放を発動した後、すべての覚醒体が10の狂気を獲得。毎ターン3回目の狂気解放を発動した後、すべての覚醒体の狂気クールダウンがリセットされ、10の狂気を獲得。"
  },
  State_3915_Name = {
    Text = "残留するシルバーコア"
  },
  State_3916_Name = {
    Text = "残留するシルバーコア"
  },
  State_3917_Desc = {
    Text = "次のターンに一時的な力を獲得。"
  },
  State_3918_Desc = {
    Text = "各ターンの開始時に、初めて受けるダメージが2倍になる状態を獲得"
  },
  State_3918_Name = {Text = "傲慢"},
  State_3918_WeaponDesc = {
    Text = "各ターンの開始時に、初めて受けるダメージが2倍になる状態を獲得"
  },
  State_3921_Desc = {
    Text = "このターンの捨て札フェイズ時、捨て札に行かず、手札に残る。"
  },
  State_3921_Name = {
    Text = "<RetainIconKeywords:保持>"
  },
  State_3921_WeaponDesc = {
    Text = "カードは捨てのフェイズにおいて捨て札の山に移動せず、手札のまま残ります。"
  },
  State_3923_Desc = {
    Text = "カードの行動力消費減少"
  },
  State_3923_Name = {
    Text = "永久カード行動力消費減少"
  },
  State_3923_WeaponDesc = {
    Text = "カードの行動力消費減少"
  },
  State_3925_Name = {
    Text = "ステータス@第四章共鳴@味方チームのターンの開始時計算力2"
  },
  State_3926_Desc = {
    Text = "「歪んだ死体の宴」で [Layer] のダメージを増加。"
  },
  State_3926_Name = {Text = "歪み"},
  State_3926_WeaponDesc = {
    Text = "「狂躁」ダメージを増やす。"
  },
  State_3927_Desc = {
    Text = "「虚無」を引いた後、このターン内にすべての覚醒体が獲得する狂気が[Layer]%減少する。"
  },
  State_3927_Name = {Text = "虚無"},
  State_3927_WeaponDesc = {
    Text = "「空虚」を引いた後、このターン内で全ての覚醒体が取得する狂気が[Layer]％低下する。"
  },
  State_3928_Desc = {
    Text = "甘い悪鬼がダメージを与えるとき、[StateArg2]のカウンターを得る。"
  },
  State_3928_Name = {Text = "S&M"},
  State_3929_Desc = {
    Text = "獲得した力とシールドが50%減少し、ターン終了時に1回を除去。"
  },
  State_3929_Name = {
    Text = "<CardKeyWord:呪い>"
  },
  State_3929_WeaponDesc = {
    Text = "本ターン内、自分に有利ステータスの付与を免疫する"
  },
  State_3930_Name = {
    Text = "ステータス@第四章共鳴@味方チームのターンの開始時計算力1"
  },
  State_3931_Name = {
    Text = "ステータス@スカーレットの血と砂の賛美歌"
  },
  State_3932_Desc = {
    Text = "カードが「保持」を獲得し、「停滞の呪い」1点につきカードの行動力消費は1増加する。使用後、「停滞の呪い」を解除する。"
  },
  State_3932_Name = {
    Text = "停滞の呪い([Layer])"
  },
  State_3932_WeaponDesc = {
    Text = "カードに保持を付与する。各層の停滞呪詛によりカードのコストが1点上昇し、使用後に停滞呪詛を除去する。"
  },
  State_3933_Desc = {
    Text = "[Layer]の防御力を上げる。"
  },
  State_3933_Name = {
    Text = "一時的な防御力増加"
  },
  State_3933_WeaponDesc = {
    Text = "[Layer]の防御力を上げる。"
  },
  State_3934_Desc = {
    Text = "獲得するすべてのシールドが50%減少。"
  },
  State_3934_Name = {
    Text = "寂滅抑圧"
  },
  State_3934_WeaponDesc = {
    Text = "獲得するすべてのシールドが50％減少。"
  },
  State_3935_Desc = {
    Text = "味方チームがカードを1枚使用するたびに「観測」を1回獲得し、10回に達すると自身が「眩暈」となる。"
  },
  State_3935_Name = {Text = "観測"},
  State_3936_Desc = {
    Text = "装備者が与えるダメージ、シールド、治癒が、一時的に[StateArg1]%増加する。"
  },
  State_3936_Name = {
    Text = "状態@試作長剣界域"
  },
  State_3937_Desc = {
    Text = "茨の女王が反撃を付与するとき、反撃の半分のシールドを獲得。"
  },
  State_3937_Name = {
    Text = "不死者の壁"
  },
  State_3938_Name = {
    Text = "蝋人形生成"
  },
  State_3941_Desc = {
    Text = "胎児を呑み込むとき、捨て札の山から手札スタックに戻る"
  },
  State_3941_Name = {
    Text = "蒼白の旋回"
  },
  State_3941_WeaponDesc = {
    Text = "胎児を呑み込むとき、捨て札の山から手札スタックに戻る"
  },
  State_3942_Name = {
    Text = "「密約」深海航路"
  },
  State_3942_WeaponDesc = {
    Text = "バトル開始後、装備者の職業が深海の場合、攻撃力が 25％ 上昇する。"
  },
  State_3943_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_3943_Name = {Text = "未覚醒"},
  State_3944_Desc = {
    Text = "ターン終了後、すべての覚醒体が5狂気を獲得。残り行動力1点ごとに、すべての覚醒体が追加で3狂気を獲得。"
  },
  State_3945_Desc = {
    Text = "すべての造物の価格が 50％ 下がります。"
  },
  State_39547_Desc = {
    Text = "戦闘終了後、追加で5黒章を獲得する。この効果は黒章ドロップ率ボーナスによって増加する。ワンダがカードを使用するたび、1点の「夢引き」を獲得し、毎ターンに最大2回まで発動。残り[DescArg1]回発動可能。"
  },
  State_39547_Name = {
    Text = "毛皮とヴィーナス"
  },
  State_40483_Name = {
    Text = "破砕の沈戟"
  },
  State_40484_Desc = {
    Text = "ワンダのスキルが「跳躍」効果を発動した時に5点以上持つ場合、5点を消費して追加効果を獲得する。上限は10点。次の戦闘に引き継がれる。"
  },
  State_40484_Name = {
    Text = "<PurpleKeyWord:夢引き>"
  },
  State_41337_Desc = {
    Text = "ターン終了時、[Layer]のライフを回復する。"
  },
  State_41337_Name = {
    Text = "薔薇の勝利-回復"
  },
  State_41340_Desc = {
    Text = "チーム唯一：装備者が与えるシールドと反撃が<WeaponEffect_Num:[StateArg1]%>増加する。攻撃を受けるたび、<WeaponEffect_Num:[StateArg2]%>の確率ですべての覚醒体が1点の狂気を獲得する。"
  },
  State_41340_WeaponDesc = {
    Text = "装備者が与えるシールドと反撃が<WeaponEffect_Num:[StateArg1]%>増加する。攻撃を受けるたび、<WeaponEffect_Num:[StateArg2]%>の確率ですべての覚醒体が1点の狂気を獲得する。"
  },
  State_41342_Name = {
    Text = "変化効果__「開発用」"
  },
  State_41344_Name = {
    Text = "変化効果"
  },
  State_41360_Desc = {
    Text = "5点の<DreamGuide:夢引き>を消費し、ワンダは<Energy:[StateArg1]>狂気を獲得し、永続的な<RetaliateIconKeywords:反撃>の[StateArg2]%の一時的な<RetaliateIconKeywords:反撃>を獲得。"
  },
  State_41360_Name = {
    Text = "深き眠りの反撃"
  },
  State_41361_Desc = {
    Text = "<DreamGuide:夢引き>を10スタック消費し、全ての敵を1ターンの「囁き」状態にする：与えるアクティブダメージが[StateArg3]％減少し、攻撃回数が2倍になる。"
  },
  State_41361_Name = {
    Text = "夢の呟きの反響"
  },
  State_43818_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_43818_Name = {Text = "未覚醒"},
  State_44398_Desc = {
    Text = "ターン中に最初にカードを使用した後、対応覚醒体の「防御」を1枚手札に追加。"
  },
  State_44484_Name = {
    Text = "ボス戦で3回使用可能"
  },
  State_44485_Name = {
    Text = "(残り:[Layer])"
  },
  State_44491_Name = {
    Text = "禁止効果__「開発用」"
  },
  State_44562_Name = {
    Text = "禁止効果"
  },
  State_44575_Desc = {
    Text = "このターン、残りのシールドは次のターンまで保持される。"
  },
  State_44575_Name = {
    Text = "シールド保持"
  },
  State_44653_Desc = {
    Text = "毎ターン開始時、すべての覚醒体が20の狂気を獲得。獲得時、最大ライフが50％減少。"
  },
  State_44665_Desc = {
    Text = "このターン「攻撃」のクリティカル率が[Layer]%増加。"
  },
  State_44665_Name = {
    Text = "攻撃クリティカル率"
  },
  State_44667_Desc = {
    Text = "「打撃」獲得 [DescArg1] ポイントの計算力。現在のポーズが「怒涛」の場合、計算力を獲得せず、代わりに 1 本のタッチアームを [DescArg2] 回攻撃させる。"
  },
  State_44667_Name = {
    Text = "巨人の覇道"
  },
  State_44671_Desc = {
    Text = "毎ターン開始時、すべての覚醒体が25の狂気を獲得。獲得時、最大ライフが3倍になる。"
  },
  State_44672_Name = {
    Text = "祝福・虫群の意識"
  },
  State_44711_Desc = {
    Text = "遺物上限+5、【融痕】中のリフレッシュ回数+1。戦闘終了後、125黒章を獲得する。入手時、最大6枚の「症状」カードを選択して除去する。"
  },
  State_44713_Desc = {
    Text = "戦闘終了後、追加で100の黒章と2枚の症状カードを獲得。__「開発用」"
  },
  State_44730_Desc = {
    Text = "ターン開始時、<Heal:[Heal:StateArg1]>点の深紅の炉回復量を蓄積する。"
  },
  State_44730_Name = {
    Text = "救済の施し"
  },
  State_44731_Desc = {
    Text = "苦により苦を消す。深紅の炉の残りの回復量をすべて消耗し、1点消耗するごとにダメージが3点増加する。ボス戦の場合は、1点消耗するごとにダメージが9点増加する。最大ライフの1％分の深紅の炉を消耗するごとに、最終ダメージが[DescArg1]％増加する。"
  },
  State_44731_Name = {Text = "浄化"},
  State_44732_Desc = {
    Text = "血による救済。ダメージを与えた後、現在のライフの10%を失い、失ったライフと同量の猩紅炉を蓄積する。"
  },
  State_44732_Name = {Text = "献身"},
  State_44739_Desc = {
    Text = "拾取時、永久に [Arg1] のパワーを失う。ダメージを与えるたびに、[Arg2] ポイントのライフを返信し、ターンごとに最大 6 回まで発動可能。"
  },
  State_44739_Name = {
    Text = "罪業·ヤツメウナギの口づけ"
  },
  State_44740_Name = {
    Text = "祝福・ヤツメウナギのキス"
  },
  State_44741_Desc = {
    Text = "拾取時、永久に [Arg1] のパワーを失う。ダメージを与えるたびに、[Arg2] ポイントのライフを返信し、ターンごとに最大 6 回まで発動可能。"
  },
  State_44741_Name = {
    Text = "罪業·ヤツメウナギの口づけ"
  },
  State_44742_Desc = {
    Text = "拾取時、永久に [Arg1] のパワーを失う。ダメージを与えるたびに、[Arg2] ポイントのライフを返信し、ターンごとに最大 6 回まで発動可能。"
  },
  State_44742_Name = {
    Text = "祝福・ヤツメウナギのキス"
  },
  State_44743_WeaponDesc = {
    Text = "バトル開始時に自身を 3 ターンの脆弱状態にする。"
  },
  State_44744_WeaponDesc = {
    Text = "バトル開始時に自身を 3 ターンの脆弱状態にする。"
  },
  State_44750_Desc = {
    Text = "ターン開始時に [StateArg1] 計算力を獲得する。"
  },
  State_44750_Name = {
    Text = "遺物黒い蝋燭1"
  },
  State_44751_Desc = {
    Text = "ターン開始時に [StateArg1] 計算力を獲得する。"
  },
  State_44751_Name = {
    Text = "遺物黒い蝋燭1"
  },
  State_44752_Desc = {
    Text = "「ソフィア」が1のライフを失うたびに1点減少し、0点になると行動予測は「目には目を」に変化し、[StateArg2]シールドを獲得。初回発動時、点数をすべて回復する。"
  },
  State_44752_Name = {
    Text = "埋められた衝動"
  },
  State_44762_Desc = {
    Text = "「防御」を使用すると、1枚の「傷口」を山札のランダムな位置に追加する。"
  },
  State_44762_Name = {
    Text = "引き裂き"
  },
  State_44763_Desc = {
    Text = "すべての覚醒体のクリティカルダメージが半減する。"
  },
  State_44763_Name = {
    Text = "<PurpleKeyWord:盲目>"
  },
  State_44764_Desc = {
    Text = "「攻撃」を使用すると、1枚の「傷口」を山札のランダムな位置に追加する。"
  },
  State_44764_Name = {Text = "外傷"},
  State_44807_Desc = {
    Text = "初めて敗北に直面した時、ライフが回復し行動予測は「鏡の判決」に変化し、自身を強化。二度目の敗北に直面した時、ライフが回復し行動予測は「狂乱の噛みつき」に変化し、非常に高い単発ダメージを与える。"
  },
  State_44807_Name = {
    Text = "埋められた殺意"
  },
  State_44819_Desc = {
    Text = "<ParcloseIconKeywords:バリア>がない場合、1回の一時的な<ParcloseIconKeywords:バリア>を獲得。そうでない場合、10%のクリティカル率とクリティカルダメージを獲得。"
  },
  State_44819_Name = {
    Text = "<CardKeyWord:父なる神の守護>"
  },
  State_44828_Desc = {
    Text = "チームユニーク：ターン終了時、装備者は[StateArg1]点の狂気を得る。アクティブダメージおよび触腕ダメージを受けた時、次のターン開始時にそのダメージの<WeaponEffect_Num:[StateArg2]%>のシールドを得る。現在の領域が肉体の場合、遅延シールドを得る代わりに、ダメージの<WeaponEffect_Num:[StateArg2]%>の回復量を猩紅炉に蓄積する。"
  },
  State_44828_WeaponDesc = {
    Text = "ターン終了時、装備者は <WeaponEffect_Num:[StateArg1]> 点の狂気を得る。アクティブまたは触手ダメージを受けた時、次のターン開始時に <WeaponEffect_Num:[Float:StateArg2]%> ダメージのシールドを得る。現在の領域が肉体の場合、遅延シールドを得る代わりに、<WeaponEffect_Num:[Float:StateArg2]%> ダメージ分の回復量を猩紅炉に蓄積する。"
  },
  State_44889_Name = {
    Text = "ステータス@人面犬BOSS@終焉の鏡1"
  },
  State_44890_Name = {
    Text = "ステータス@人面犬ボス@終焉の鏡2"
  },
  State_44891_Name = {
    Text = "ステータス@人面犬ボス@終焉の鏡3"
  },
  State_44903_Desc = {
    Text = "アクティブまたは触手ダメージを受けた後、[StateArg1]% のダメージを猩紅炉の回復量に変換する、[Layer] ターン持続する。"
  },
  State_44903_Name = {
    Text = "創造主の庇護"
  },
  State_44909_Name = {Text = "除外可"},
  State_45018_Desc = {
    Text = "ターン終了まで「攻撃」を使用できない。"
  },
  State_45018_Name = {Text = "麻痺"},
  State_45025_Desc = {
    Text = "具体的な効果は共通の「攻撃」ロジックを参照。__「開発用」"
  },
  State_45029_Desc = {
    Text = "具体的な効果は共通の「攻撃」ロジックを参照。__「開発用」"
  },
  State_45032_Desc = {
    Text = "次のターン終了時、[Layer]ダメージを受ける。"
  },
  State_45039_Desc = {
    Text = "次のターン開始まで、アクティブダメージまたは触手ダメージを受けるたびに、次のターン開始時に[Layer]％ダメージのシールドを獲得する。"
  },
  State_45039_Name = {
    Text = "神の御業"
  },
  State_45040_Desc = {
    Text = "次のターン開始まで、アクティブダメージまたは触手ダメージを受けるたびに、[Layer]％ダメージの回復量を猩紅炉に蓄積する。"
  },
  State_45040_Name = {
    Text = "奇蹟の夜明け"
  },
  State_45049_Desc = {
    Text = "次の能動的攻撃ダメージによるライフ損失を相殺する。最大3スタックまで積み重ね可能。死闘の各スタックはバリアの積み重ね可能スタック数を-1する。既に獲得したバリアは積み重ね可能スタック数が減少しても減少しない。"
  },
  State_45049_Name = {Text = "バリア"},
  State_45050_Desc = {
    Text = "次の能動的攻撃ダメージによるライフ損失を相殺する。最大3スタックまで積み重ね可能。死闘の各スタックはバリアの積み重ね可能スタック数を-1する。既に獲得したバリアは積み重ね可能スタック数が減少しても減少しない。"
  },
  State_45050_Name = {
    Text = "<ReinforceColour:バリア>"
  },
  State_45064_Name = {
    Text = "無声の宴のカウンター__「開発用」"
  },
  State_45069_Desc = {
    Text = "具体的な効果は共通の「攻撃」ロジックを参照。__「開発用」"
  },
  State_45072_Name = {
    Text = "聖化カウント"
  },
  State_45073_Desc = {
    Text = "カードの行動力消費減少"
  },
  State_45076_Desc = {
    Text = "付与時に、対象のシールドと遅延治癒を解除する。ターン終了まで、受ける治癒とシールド効果が50%減少する。"
  },
  State_45076_Name = {Text = "重傷"},
  State_45137_Desc = {
    Text = "狂気解放後、すべての覚醒体を1ターン封印し、1ターン軟化状態になる。"
  },
  State_45137_Name = {
    Text = "罪悪・行道の骸"
  },
  State_45139_Desc = {
    Text = "狂気解放を使用すると、ランダムで1つのデバフを解除する。"
  },
  State_45139_Name = {
    Text = "祝福・行道の骸"
  },
  State_45148_Desc = {
    Text = "すべての覚醒体のクリティカルダメージが半減する。"
  },
  State_45148_Name = {
    Text = "<PurpleKeyWord:盲目>"
  },
  State_45166_Desc = {
    Text = "ターン終了前まで装備している運命の札は無効になる。"
  },
  State_45166_Name = {Text = "纏着"},
  State_45206_Desc = {
    Text = "信仰による救済。残りのすべての猩紅炉を消費し、消費量の150%のシールドを獲得。このシールドはシールドボーナスやデバフの影響を受けず、シールド上限を無視する。"
  },
  State_45206_Name = {Text = "救済"},
  State_45248_Name = {
    Text = "カウンター__「開発用」"
  },
  State_45328_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、自身は<TauntKeywords:挑発>と<Block:[Block:StateArg1]>点のシールドを獲得。"
  },
  State_45328_Name = {
    Text = "35mmの魔法"
  },
  State_45329_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は対象を選択できる。「攻撃」の前に、対象の持つ解除可能なすべてのバフを、その後ろの覚醒体に<PVPRepelKeywords:後退>する。"
  },
  State_45329_Name = {
    Text = "深海の呼び声"
  },
  State_45331_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時および「攻撃」使用時、手札にある装備者の非派生「スキル」が、順番に装備者の他の「スキル」に変化する。[ShowIfState:<CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]。"
  },
  State_45331_Name = {
    Text = "昔日の花と詩"
  },
  State_45332_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：能動ダメージを1回受けるたび、他の味方に<Energy:[Energy:StateArg1]>狂気を獲得させる。"
  },
  State_45332_Name = {
    Text = "イサラウの眼差し"
  },
  State_45333_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：手札上限+[StateArg1]。「狂気解放」の後、自身は<Energy:[Energy:StateArg2]>狂気を獲得。"
  },
  State_45333_Name = {
    Text = "熱い別れのキス"
  },
  State_45334_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「スキル」はこのターンの次の「攻撃」をランダムな対象に変更し、追加でランダムな対象[StateArg1]体を攻撃する。"
  },
  State_45334_Name = {
    Text = "鏡の中の人"
  },
  State_45345_Desc = {
    Text = "第1段階の生育スキルを何回使用したかを記録する"
  },
  State_45345_Name = {
    Text = "生育標識1"
  },
  State_45346_Desc = {
    Text = "第2段階の生育スキルを何回使用したかを記録する"
  },
  State_45346_Name = {
    Text = "生育標識2"
  },
  State_45354_Desc = {
    Text = "このカードは使用できない。__「開発用」"
  },
  State_45354_Name = {
    Text = "使用不可__「開発用」"
  },
  State_45356_Desc = {
    Text = "ターン終了時、あなたが最後に出した「スキル」カードに変化し、その行動力消費を–2する。使用後、「灰霧の真容」を山札のランダムな位置に追加する。"
  },
  State_45356_Name = {
    Text = "<CardKeyWord:灰霧の正体>"
  },
  State_45364_Desc = {
    Text = "次のターン開始時、その覚醒体は「攻撃」を[Layer]枚獲得する。"
  },
  State_45364_Name = {
    Text = "遅延攻撃"
  },
  State_45385_Desc = {
    Text = "この戦闘中に与えるすべてのダメージが[Layer]減少する。解除不可。その中に[DescArg1]点の一時的な力の減少があり、ターン終了時に除去される。"
  },
  State_45385_Name = {
    Text = "力の減少"
  },
  State_45387_Desc = {
    Text = "この戦闘中に与えるすべてのダメージが[Layer]点上昇する。解除不可。その中に[DescArg1]点の一時的な力があり、ターン終了時に除去される。"
  },
  State_45387_Name = {Text = "力"},
  State_45397_Desc = {
    Text = "ターン開始時、1点のバリアを力に変換する。"
  },
  State_45397_Name = {
    Text = "薔薇の勝利"
  },
  State_45403_Desc = {
    Text = "次のターン開始時、[Layer]点の蓄力を獲得。"
  },
  State_45403_Name = {
    Text = "遅延蓄力"
  },
  State_45407_Desc = {
    Text = "獲得する狂気と遅延狂気が50%減少する。即座にすべての遅延狂気を除去する。"
  },
  State_45407_Name = {Text = "虚無"},
  State_45656_Desc = {
    Text = "母樹が三度目の復活、生育2スキルを発動"
  },
  State_45658_Desc = {
    Text = "母樹が初めて復活し、生育スキルを発動"
  },
  State_45661_Desc = {
    Text = "ライフが0になると、ライフを1にし、ダメージを受けなくなり、「多重融合」を準備する。"
  },
  State_45715_Desc = {
    Text = "触腕ダメージの[StateArg1]%分に等しい一時的な力を獲得する。"
  },
  State_45715_Name = {Text = "簒奪"},
  State_45716_Desc = {
    Text = "触腕ダメージの[StateArg1]%分に等しい一時的な力を獲得する。ゴリアテは25%の一時的なクリティカル率を獲得する。"
  },
  State_45716_Name = {Text = "簒奪"},
  State_45717_Desc = {
    Text = "「巨刃の威」と「斬首一閃」の基礎ダメージがこの戦闘で25%増加。ゴリアテは<Energy:[Energy:StateArg2]> 狂気を獲得。"
  },
  State_45717_Name = {Text = "潜伏"},
  State_45718_Desc = {
    Text = "「巨刃の威」と「斬首一閃」の基礎ダメージがこの戦闘で25%増加。"
  },
  State_45718_Name = {Text = "潜伏"},
  State_46057_Name = {Text = "行動力"},
  State_46079_Desc = {
    Text = "このターン中、対象がアクティブダメージを受けるたび、ライフ損失が最も多い味方のライフを[Layer]回復する。"
  },
  State_46079_Name = {
    Text = "聖血の導き"
  },
  State_46119_Desc = {
    Text = "次に攻撃された時、攻撃者に纏着を付与する。"
  },
  State_46119_Name = {
    Text = "迷宮の罠"
  },
  State_46124_Desc = {
    Text = "ターン終了までいかなる行動もできなくなる。"
  },
  State_46138_Desc = {
    Text = "相手が最後に出した「スキル」に変化し、その行動力消費を-1する。"
  },
  State_46138_Name = {
    Text = "<CardKeyWord:星彩擬態>"
  },
  State_46139_Desc = {
    Text = "アクティブ攻撃を受けるたび、自身は[Layer]点の蓄力を獲得し、攻撃者に[Layer]点の遅延を与える。"
  },
  State_46139_Name = {
    Text = "異常重力"
  },
  State_46155_Desc = {
    Text = "自身の「スキル」使用後、[StateArg1]点の蓄力を獲得し、点数–1。ターン終了時にすべての点数を消費し、1点につきライフを[StateArg2]回復。"
  },
  State_46155_Name = {
    Text = "異端の血"
  },
  State_46243_Name = {
    Text = "洞察カウンター__「開発用」"
  },
  State_46255_Desc = {
    Text = "具体的な効果は共通の「攻撃」ロジックを参照。__「開発用」"
  },
  State_46256_Desc = {
    Text = "具体的な効果は共通の「攻撃」ロジックを参照。__「開発用」"
  },
  State_46322_Desc = {
    Text = "ターン開始時、30の胚胎融合を獲得。"
  },
  State_46322_Name = {
    Text = "ユウハシュの試遊"
  },
  State_46323_Desc = {
    Text = "超次元ターン開始後、100狂気を獲得。ターン開始後、7点の力を獲得。"
  },
  State_46323_Name = {
    Text = "リッツの試遊"
  },
  State_46324_Desc = {
    Text = "毎ターン「インスピレーション」を1枚獲得。"
  },
  State_46324_Name = {
    Text = "ジェンキンの試遊"
  },
  State_46329_Desc = {
    Text = "戦闘開始後、600点の銀鍵エネルギーを獲得し、ロータンは50狂気を獲得し、ロータンが狂気爆発を発動した後、追加で44狂気を獲得する。"
  },
  State_46329_Name = {
    Text = "試遊増益"
  },
  State_46330_Desc = {
    Text = "ターン開始時、30の胚胎融合と10狂気、[DescArg1]点の力を獲得し、3枚の「攻撃」を山札に追加。"
  },
  State_46330_Name = {
    Text = "ヘロットの試遊"
  },
  State_46333_Name = {
    Text = "レーアの試遊"
  },
  State_46334_Desc = {
    Text = "第4ターン開始後、100狂気を獲得。"
  },
  State_46334_Name = {
    Text = "ファロスの試遊"
  },
  State_46336_Desc = {
    Text = "ターン開始時、30の胚胎融合と10狂気を獲得。"
  },
  State_46336_Name = {
    Text = "アグリッパの試遊"
  },
  State_46337_Desc = {
    Text = "ターン開始時に狂気を10獲得。"
  },
  State_46337_Name = {
    Text = "カエクスの試遊"
  },
  State_46338_Desc = {
    Text = "ターン開始時、30の胚胎融合と10狂気を獲得。"
  },
  State_46338_Name = {
    Text = "ファイントの試遊"
  },
  State_46427_Desc = {
    Text = "具体的な効果は共通の「攻撃」ロジックを参照。__「開発用」"
  },
  State_46428_Desc = {
    Text = "具体的な効果は共通の「攻撃」ロジックを参照。__「開発用」"
  },
  State_46429_Desc = {
    Text = "具体的な効果は共通の「攻撃」ロジックを参照。__「開発用」"
  },
  State_46441_Desc = {
    Text = "スパイクダメージ以外のダメージを無効化し、ターン開始後に除去される。"
  },
  State_46441_Name = {
    Text = "ダメージを無効化"
  },
  State_46442_Name = {
    Text = "カードの攻撃対象タイプを変更禁止__「開発用」"
  },
  State_46500_Desc = {
    Text = "具体的な効果は共通の「攻撃」ロジックを参照。__「開発用」"
  },
  State_46505_Desc = {
    Text = "このターン中、アクティブダメージを受けるたびに、[Layer] 狂気を獲得する。"
  },
  State_46505_Name = {
    Text = "痛くないよ"
  },
  State_46508_Desc = {
    Text = "昏睡を受けた時、耐性を獲得する。耐性を所有している時に再度昏睡ダメージを受けた場合、昏睡効果を相殺し、ダメージは2倍になる。この状態は解除不可。"
  },
  State_46508_Name = {Text = "耐性"},
  State_46511_Desc = {
    Text = "この覚醒体の「千面重畳」ダメージが [Layer] 上昇する。"
  },
  State_46511_Name = {
    Text = "千面重畳"
  },
  State_46512_Desc = {
    Text = "ターン終了まで、その覚醒体がカードを使用すると[Layer]ダメージを受ける。"
  },
  State_46512_Name = {
    Text = "カード封鎖"
  },
  State_46513_Desc = {
    Text = "次の「詩」を強化し、追加効果を獲得。解除不可。"
  },
  State_46513_Name = {
    Text = "哀慟濃墨"
  },
  State_46536_Desc = {
    Text = "状態パラメータ1が0の場合、カードを引く。そうでない場合はテキストのみ表示。"
  },
  State_46536_Name = {Text = "ドロー"},
  State_46538_Desc = {
    Text = "探索開始時、[StateArg1]狂気を獲得。"
  },
  State_46538_Name = {
    Text = "狂気の予兆"
  },
  State_47072_Desc = {
    Text = "このターン、「攻撃」のクリティカル率が[Layer]%増加。"
  },
  State_47072_Name = {
    Text = "攻撃クリティカル"
  },
  State_47089_Name = {
    Text = "テスト効果__「開発用」"
  },
  State_47096_Desc = {
    Text = "「啓示」を1枚使用するたび、ダフォダイルは[StateArg1]狂気を獲得し、[StateArg2]点の力を獲得する。毎ターン最大5回まで発動。（残り[DescArg1]回）"
  },
  State_47096_Name = {
    Text = "原質沈殿"
  },
  State_47189_Name = {
    Text = "躁狂人格に切り替える。血肉·うつ病：<EmbryoFusionIconKeywords:胚胎融合> +[Blood:StateArg5]、[StateArg6] 点の猩紅炉回復量を蓄積する"
  },
  State_47192_Name = {
    Text = "抑鬱人格：他の覚醒体に[DescArg1]狂気を獲得させる。躁狂人格：追加で[DescArg2]倍の狂気を獲得。"
  },
  State_47199_Name = {
    Text = "抑鬱人格に切り替える。血肉・躁狂：ダメージは[DescArg1]倍の<PowerIconKeywords:力>ボーナスを受け、ターゲットにダメージの200%分の<BleedingIconKeywords:出血>を付与し、[StateArg7]点の<PowerIconKeywords:力>を獲得する。"
  },
  State_47204_Name = {
    Text = "躁狂人格に切り替える。混沌・抑鬱：<Posse:[StateArg1]>キーエネルギーを獲得し、次のキーオーダーの効果は2回発動する。"
  },
  State_47206_Name = {
    Text = "躁狂人格に切り替える。深海・抑鬱：対象に2点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。触腕を1本獲得し、<TentacleInjurieIconKeywords:触腕ダメージ>+[StateArg3]。"
  },
  State_47209_Name = {
    Text = "うつ病の人格に切り替える。超次元·躁狂：与えたダメージの15%の<RetaliateIconKeywords:カウンター>を得て、他の敵に同量の<FixedDamage:純粋ダメージ>を与える。このターン「啓示」を1枚発射するたびに、そのダメージをこのターン内に[StateArg9]点上昇させ、最大[StateArg10]点まで上昇できる"
  },
  State_47211_Name = {
    Text = "抑鬱人格：手札にある行動力が最も高いカード[DescArg1]枚の行動力消費を1減少させ、一時的な<RetainIconKeywords:保持>を獲得する。躁狂人格：追加でダメージを[DescArg2]回与える。"
  },
  State_47212_Name = {
    Text = "抑鬱と躁狂の人格を切り替え、現在の界域と人格に応じて追加効果を発動する。"
  },
  State_47216_Name = {
    Text = "抑鬱人格に切り替える。深海・躁狂：このダメージは[StateArg4]%の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得し、すべての敵に30%の<IntoxicationIconKeywords:毒>を付与する。"
  },
  State_47217_Name = {
    Text = "抑鬱人格に切り替える。混沌・躁狂：ダメージを3回与える。「24」が与えるすべてのダメージが[StateArg2]増加する。"
  },
  State_47218_Name = {
    Text = "躁狂人格に切り替える。超次元・抑鬱：「啓示」を2枚手札に追加。対象から<PowerIconKeywords:力>を一時的に[Power:StateArg8]減少させる。"
  },
  State_47222_Name = {
    Text = "抑鬱人格：手札にある行動力が最も高いカード[DescArg1]枚の行動力消費を1減少させ、一時的な<RetainIconKeywords:保持>を獲得する。<AwakerCard_24Lost:躁狂人格：追加でダメージを[DescArg2]回与える。>"
  },
  State_47224_Name = {
    Text = "抑鬱人格：他の覚醒体に[DescArg1] 倍の狂気を獲得させる。<AwakerCard_24Lost:躁狂人格：追加で[DescArg2]倍の狂気を獲得。>"
  },
  State_47228_Name = {
    Text = "<AwakerCard_24Lost:抑鬱人格：他の覚醒体に[DescArg1]倍の狂気を獲得させる。>躁狂人格：追加で[DescArg2]倍の狂気を獲得。"
  },
  State_47229_Name = {
    Text = "<AwakerCard_24Lost:抑鬱人格：手札にある行動力が最も高いカード[DescArg1]枚の行動力消費を1減少させ、一時的な<RetainIconKeywords:保持>を獲得する。>躁狂人格：追加でダメージを[DescArg2]回与える。"
  },
  State_47451_Name = {
    Text = "ライカーのキーオーダーは運命の札効果を無効にする__「開発用」"
  },
  State_47485_Name = {
    Text = "抑鬱人格：手札にある行動力が最も高いカード[DescArg1]枚の行動力消費を2減少させ、一時的な<RetainIconKeywords:保持>を獲得する。躁狂人格：追加でダメージを[DescArg2]回与える。"
  },
  State_47486_Name = {
    Text = "抑鬱人格：手札にある行動力が最も高いカード[DescArg1]枚の行動力消費を2減少させ、一時的な<RetainIconKeywords:保持>を獲得する。<AwakerCard_24Lost:躁狂人格：追加でダメージを[DescArg2]回与える。>"
  },
  State_47488_Name = {
    Text = "抑鬱人格：追加で<Energy: [DescArg1]>狂気を獲得。躁狂人格：追加でシールドを[DescArg2]回獲得。"
  },
  State_47489_Name = {
    Text = "<AwakerCard_24Lost:抑鬱人格：手札にある行動力が最も高いカード[DescArg1]枚の行動力消費を2減少させ、一時的な<RetainIconKeywords:保持>を獲得する。>躁狂人格：追加でダメージを[DescArg2]回与える。"
  },
  State_47492_Name = {
    Text = "抑鬱人格：追加で<Energy: [DescArg1]>狂気を獲得。<AwakerCard_24Lost:躁狂人格：追加でダメージを[DescArg2]回与える。>"
  },
  State_47493_Name = {
    Text = "抑鬱人格：追加で<Energy: [DescArg1]>狂気を獲得。躁狂人格：追加でダメージを[DescArg2]回与える。"
  },
  State_47494_Name = {
    Text = "抑鬱人格：他の覚醒体に[DescArg1]倍の狂気を獲得させる。すべての敵に[DescArg3]点の<WeaknessIconKeywords:虚弱>を付与する。躁狂人格：追加で[DescArg2] 倍の狂気を獲得。すべての敵に[DescArg3]点の<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  State_47495_Name = {
    Text = "抑鬱人格：他の覚醒体に[DescArg1]倍の狂気を獲得させる。すべての敵に[DescArg3]点の<WeaknessIconKeywords:虚弱>を付与する。<AwakerCard_24Lost:躁狂人格：追加で[DescArg2]倍の狂気を獲得。すべての敵に[DescArg3]点の易傷を付与する。>"
  },
  State_47496_Name = {
    Text = "<AwakerCard_24Lost:抑鬱人格：他の覚醒体に[DescArg1]倍の狂気を獲得させる。すべての敵に[DescArg3]点の虚弱を付与する。>躁狂人格：追加で[DescArg2]倍の狂気を獲得。すべての敵に[DescArg3]点の<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  State_47498_Name = {
    Text = "<AwakerCard_24Lost:抑鬱人格：追加で[DescArg1]狂気を獲得。>躁狂人格：追加でダメージを[DescArg2]回与える。"
  },
  State_47499_Name = {
    Text = "<AwakerCard_24Lost:抑鬱人格：追加で[DescArg1]狂気を獲得。>躁狂人格：追加でシールドを[DescArg2]回獲得。"
  },
  State_47500_Name = {
    Text = "抑鬱人格：追加で<Energy: [DescArg1] >狂気を獲得。<AwakerCard_24Lost:躁狂人格：追加でシールドを[DescArg2]回獲得。>"
  },
  State_47517_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、他の覚醒体のカードを[StateArg1]枚捨てさせ、捨て札に成功した場合[StateArg2]枚のカードを引く。"
  },
  State_47517_Name = {
    Text = "銀ダラの決意"
  },
  State_47518_Name = {
    Text = "銀ダラの決意のカウンター__「開発用」"
  },
  State_47528_Desc = {
    Text = "このターン、「攻撃」+[DescArg1]%ダメージ<PVPPenetrateKeywords:貫通>。"
  },
  State_47530_Desc = {
    Text = "このターン中に最後に使用した「スキル」として扱う。"
  },
  State_47530_Name = {
    Text = "<CardKeyWord:模擬演繹>"
  },
  State_47557_Desc = {
    Text = "チームユニーク：探索開始後、装備者は銀タラ魚人パーソナリティ状態に入る。装備者が狂気解放を発動した後、銀タラ魚人パーソナリティとネコパーソナリティの間で切り替わる。\n銀タラ魚人パーソナリティ：装備者がアクティブダメージを与えた後、<WeaponEffect_Num:[StateArg1]> のキーエネルギーを獲得する。ネコパーソナリティ：装備者がアクティブダメージを与えた後、装備者の一時的なクリティカルダメージ <WeaponEffect_Num:+[StateArg2]%>。この2つの効果は1ターンに最大5回まで発動する機会を共有する。"
  },
  State_47557_WeaponDesc = {
    Text = "探索開始後、装備者は銀タラ魚人パーソナリティ状態に入る。装備者が狂気解放を発動した後、銀タラ魚人パーソナリティとネコパーソナリティの間で切り替わる。\n銀タラ魚人パーソナリティ：装備者がアクティブダメージを与えた後、<WeaponEffect_Num:[StateArg1]> のキーエネルギーを獲得する。ネコパーソナリティ：装備者がアクティブダメージを与えた後、装備者の一時的なクリティカルダメージ <WeaponEffect_Num:+[StateArg2]%>。この2つの効果は1ターンに最大5回まで発動する機会を共有する。"
  },
  State_47822_Desc = {
    Text = "次のターンに再び「麻痺」を受けると、その全ての「打撃」が「幻影」に変わり、解除不可となり、次のターン終了まで持続する。"
  },
  State_47822_Name = {
    Text = "少し痺れてきた"
  },
  State_47825_Desc = {
    Text = "ターン開始時に対応するスキル効果が発動する。"
  },
  State_47825_Name = {
    Text = "<CardKeyWord:遅延>"
  },
  State_47826_Desc = {
    Text = "·目標が「麻痺」状態の時ダメージが2倍になり、そうでない場合は本ターン中その「打撃」が使用不可になる。\n·連続2ターン「麻痺」状態になると、その全ての「打撃」が「幻影」に変わる。"
  },
  State_47826_Name = {
    Text = "<WeaknessColour:麻痺>"
  },
  State_47827_Desc = {
    Text = "1点につき、この戦闘中に与えるすべてのダメージを1減少させる。解除不可。"
  },
  State_47827_Name = {
    Text = "<WeaknessColour:力の減少>"
  },
  State_47828_Desc = {
    Text = "・付与時に等量のダメージを与える。対象が「纏絡」状態であればダメージが倍になり、そうでなければ対象が装備している命輪をターン終了まで無効にする。"
  },
  State_47828_Name = {
    Text = "<WeaknessColour:纏着>"
  },
  State_47830_Desc = {
    Text = "付与時に、対象のシールドと遅延治癒を解除する。ターン終了まで、受ける治癒とシールド効果が50%減少する。"
  },
  State_47830_Name = {
    Text = "<PVPVulnerabilityIconColour:重傷>"
  },
  State_47831_Desc = {
    Text = "ターン終了まで行動できなくなる。昏睡ダメージを受けた後、対象は耐性を獲得する。耐性を所有している時に再度昏睡ダメージを受けた場合、昏睡効果を相殺し、ダメージは2倍になる。この状態は解除不可。"
  },
  State_47832_Desc = {
    Text = "疫病鼠、帯電鼠、痴呆鼠の3種。"
  },
  State_47832_Name = {
    Text = "<CardKeyWord:鼠カード>"
  },
  State_47833_Desc = {
    Text = "白い鳩のハンカチ、反対向きの魔術ボックス、テレパシーマイクを含みます。"
  },
  State_47833_Name = {
    Text = "<CardKeyWord:驚異のマジック>"
  },
  State_47841_Desc = {
    Text = "この戦闘中、次の [Layer] 回のキーオーダー使用が 2 回有効。"
  },
  State_47841_Name = {
    Text = "ダブルキーオーダー"
  },
  State_47842_Desc = {
    Text = "獲得する狂気と遅延狂気が50%減少する。即座にすべての遅延狂気を除去する。"
  },
  State_47842_Name = {
    Text = "<PVPEmptinessColour:虚無>"
  },
  State_47843_Desc = {
    Text = "覚醒体を死亡状態から復帰させ、そのすべてのカードを山札に戻す。"
  },
  State_47843_Name = {
    Text = "<PVPResurrectionColour:復活>"
  },
  State_47844_Desc = {
    Text = "ランダムでなんらかの効果を発生させる。"
  },
  State_47844_Name = {
    Text = "<PVPWonderfulEffectKeywords:不思議な効果>"
  },
  State_47845_Desc = {
    Text = "カードが手札にある時に効果を発生させる。"
  },
  State_47845_Name = {
    Text = "<CardKeyWord:保有>"
  },
  State_47873_Desc = {
    Text = "次のターン終了時、点数に等しいダメージを与える。"
  },
  State_47887_Name = {
    Text = "現在のチームの界域に応じた効果を獲得。"
  },
  State_47888_Name = {
    Text = "血肉：「24」が行動力を1点消費するたびに<EmbryoFusionIconKeywords:胚胎融合> +[Blood:DescArg1]、[StateArg3] 点の<PowerIconKeywords:力>を獲得する。「24」の狂気解放は追加で300%の力ボーナスを享受する"
  },
  State_47889_Name = {
    Text = "深海：「24」が与えるダメージは[StateArg2]%の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得する。10%の<IntoxicationIconKeywords:毒>を付与する。「24」の狂気解放は50%の<IntoxicationIconKeywords:毒>を付与する。"
  },
  State_47892_Name = {
    Text = "混沌：「24」のクリティカル率とクリティカルダメージ +[StateArg4]%。キーオーダーを使用するたびに、「24」の狂気解放の最終ダメージが [StateArg1]% アップする"
  },
  State_47894_Name = {
    Text = "超次元：「24」のダメージは[StateArg5]%の<RetaliateIconKeywords:反撃>ダメージボーナスを獲得する。ターン終了時、「啓示」を1枚捨て札に追加する。手札の上限+2。"
  },
  State_48009_Desc = {
    Text = "毎ターン初めて使用した時、追加で[StateArg1]回効果が発動する。"
  },
  State_48010_Desc = {
    Text = "合奏マーク"
  },
  State_48010_Name = {
    Text = "合奏マーク"
  },
  State_48011_Desc = {
    Text = "毎ターン初めて使用した時、追加で[StateArg1]回効果が発動する。"
  },
  State_48011_Name = {
    Text = "<Rune_19_High:上位合奏>"
  },
  State_48011_WeaponDesc = {
    Text = "打出后追加効果 [StateArg1] 回、消費。"
  },
  State_48012_Desc = {
    Text = "刻印されたカードが各ターン初めて使用された時、2回効果を発動する。"
  },
  State_48013_Desc = {
    Text = "刻印されたカードが各ターン初めて使用された時、3回効果を発動する。"
  },
  State_48013_Name = {
    Text = "<CardKeyWord:刻印：上位合奏>"
  },
  State_48019_Name = {
    Text = "<CardKeyWord:模擬演繹>"
  },
  State_48020_Name = {
    Text = "<CardKeyWord:魂の誕生>"
  },
  State_48021_Name = {
    Text = "<CardKeyWord:灰霧の正体>"
  },
  State_48078_Name = {
    Text = "<CardKeyWord:星彩擬態>"
  },
  State_48099_Desc = {
    Text = "ターン終了時、「24」が[DescArg1]狂気を獲得。「24」が狂気解放を発動するたび、この効果で獲得する狂気が1増加する。"
  },
  State_48099_Name = {
    Text = "パブロフ行動研究"
  },
  State_48099_WeaponDesc = {
    Text = "装備者のターン終了時に3点の狂気を獲得する。装備者の狂気回復が10より大きい場合、追加で2点の狂気を獲得する。"
  },
  State_48100_Name = {
    Text = "状態@24パブロフ行動研究カウント"
  },
  State_48100_WeaponDesc = {
    Text = "装備者のターン終了時に3点の狂気を獲得する。装備者の狂気回復が10より大きい場合、追加で2点の狂気を獲得する。"
  },
  State_48107_Desc = {
    Text = "毎ターン使用する最初の装備者の「スキル」のダメージが[StateArg1]%上昇する。"
  },
  State_48107_Name = {
    Text = "巨人の刃"
  },
  State_48108_Desc = {
    Text = "装備者が毎ターン初めて「スキル」を使用した後に、その行動力消費が-[StateArg1]されたコピーを1枚山札のランダムな位置に追加する。"
  },
  State_48108_Name = {
    Text = "回れ回れ"
  },
  State_48110_Desc = {
    Text = "「スキル」はこのターンの次の「攻撃」をランダムな対象に変更し、追加でランダムな対象[StateArg1]体を攻撃する。"
  },
  State_48110_Name = {
    Text = "鏡の中の人"
  },
  State_48140_Desc = {
    Text = "探検開始時、「24」は抑鬱人格状態になる。\n<School_1:混沌・抑鬱>：<Posse:[StateArg1]>キーエネルギーを獲得し、次のキーオーダーは2回発動する。\n<School_1:混沌・躁狂>：ダメージを3回与え、「24」の与えるすべてのダメージが[StateArg2]増加する。\n<School_2:深海・抑鬱>：対象に2点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。触腕を1本獲得し、<TentacleInjurieIconKeywords:触腕ダメージ>+[StateArg3]。\n<School_2:深海・躁狂>：[StateArg4]%の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得し、すべての敵にダメージの30%の<IntoxicationIconKeywords:毒>を付与する。\n<School_3:肉体・抑鬱>：<EmbryoFusionIconKeywords:胎児融合>+[Blood:StateArg5]、[StateArg6]点の猩紅炉を蓄積する。\n<School_3:肉体・躁狂>：ダメージは6倍の<PowerIconKeywords:力>ボーナスを受け、対象にダメージの200%の<BleedingIconKeywords:出血>を付与する。[StateArg7]点の<PowerIconKeywords:力>を獲得。\n<School_4:超次元・抑鬱>：「啓示」を2枚手札に追加。対象の<PowerIconKeywords:力>を一時的に[StateArg8]点減少させる。\n<School_4:超次元・躁狂>：ダメージの15%の<RetaliateIconKeywords:カウンター>を獲得し、他の敵に同量の<FixedDamage:純粋ダメージ>を与える。このターンに「啓示」を使用するたび、ダメージが[StateArg9]増加し、最大[StateArg10]点まで増加する。"
  },
  State_48140_Name = {
    Text = "界域と人格効果"
  },
  State_48141_Desc = {
    Text = "<School_1:混沌>：「24」のクリティカル率とクリティカルダメージ +[StateArg4]%。キーオーダーを使用するたびに、「24」の狂気解放の最終ダメージが [StateArg1]% アップ。\n<School_2:深海>：「24」が与えるダメージは [StateArg2]% の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得し、ダメージの10%分の<IntoxicationIconKeywords:毒>を付与する。「24」の狂気解放は敵の<IntoxicationIconKeywords:毒>を50%発動させる。\n<School_3:血肉>：「24」が行動力を1点消費するたびに<EmbryoFusionIconKeywords:胚胎融合> +[Blood:DescArg1]、[StateArg3] 点の<PowerIconKeywords:力>を獲得する。「24」の狂気解放は追加で300%の力ボーナスを享受する\n<School_4:超次元>：「24」が与えるダメージは [StateArg5]% の<RetaliateIconKeywords:反撃>ダメージボーナスを享受し、ターン終了時に捨て札へ「啓示」を1枚シャッフルし、手札上限 +2。"
  },
  State_48141_Name = {
    Text = "界域効果"
  },
  State_48149_Name = {
    Text = "カードの特効を発動できない__「開発用」"
  },
  State_48176_Desc = {
    Text = "この試遊ステージ中、毎ターン1点の行動力を獲得。「24」が行動力を1点消費するたび、30キーエネルギーを獲得。"
  },
  State_48176_Name = {
    Text = "「24」 の試遊"
  },
  State_48198_Desc = {
    Text = "この試遊ステージ中、毎ターン1枚の「啓示」カードを獲得。"
  },
  State_48198_Name = {
    Text = "「24」 の試遊"
  },
  State_48199_Desc = {
    Text = "この試遊ステージ中、毎ターン1点の行動力を獲得。"
  },
  State_48199_Name = {
    Text = "「24」 の試遊"
  },
  State_48589_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し元の2倍となり、真の姿で戦闘を始める。"
  },
  State_48589_Name = {Text = "未覚醒"},
  State_48607_Name = {
    Text = "汎用カードの元の行動力の減少__「開発用」"
  },
  State_48822_Desc = {
    Text = "血肉界域メカニズム、ターン開始時、胚胎融合+50。"
  },
  State_48822_Name = {
    Text = "途切れぬ命"
  },
  State_48923_Desc = {
    Text = "影「24」 が覚醒した。最後の「助けて」を使ってチャンスを見つけよう！"
  },
  State_48923_Name = {
    Text = "影「24」覚醒！"
  },
  State_48923_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_49063_Desc = {
    Text = "ロータンの「攻撃」のダメージが30%増加。"
  },
  State_49063_Name = {
    Text = "高揚した戦意"
  },
  State_49109_Desc = {
    Text = "カードが保持を獲得し、ターン終了時に手札にある場合、その指令カードの除外が付与された未強化コピーを1枚獲得する。"
  },
  State_49109_Name = {
    Text = "<Rune_20_High:出生>"
  },
  State_49109_WeaponDesc = {
    Text = "打出后追加効果 [StateArg1] 回、消費。"
  },
  State_49148_Desc = {
    Text = "死亡後、行動力消費が0でないカード1枚に「変異1」を付与。「変異」：カードステータス。戦闘終了後も保持。1点につき行動力消費を1減少するが、使用後1点につき1枚のランダムな「変異」を手札に追加（手札の上限無視）し、すべての「変異」を除去する。"
  },
  State_49148_Name = {
    Text = "異形の胎児"
  },
  State_49149_Desc = {
    Text = "1点につきカードの行動力消費を1減少。使用後「変異」1点につきランダムな「変異」ステータスカードを1枚手札に追加し、この状態を解除。この状態は戦闘終了後も維持する。"
  },
  State_49149_Name = {
    Text = "<ExclamationPointColour:変異 [Layer]>"
  },
  State_49149_WeaponDesc = {
    Text = "使用すると、永久にデッキに現れない。"
  },
  State_49207_Name = {
    Text = "100のキーエネルギーを獲得"
  },
  State_49225_Desc = {
    Text = "ターン終了後、1本の触腕が[Layer]回攻撃する。"
  },
  State_49225_Name = {
    Text = "<CardKeyWord:触腕集結>"
  },
  State_49226_Desc = {
    Text = "ターン終了後、手札1枚につき、すべての敵に2%の毒を付与し、2狂気を獲得。"
  },
  State_49226_Name = {
    Text = "小さな灯火"
  },
  State_49260_Desc = {
    Text = "ターン終了時に体力の 7.5% のライフを回復する。"
  },
  State_49260_Name = {
    Text = "受け入れられぬ痛み"
  },
  State_49270_Desc = {
    Text = "打撃牌のダメージが [Layer] ％ 上昇します。"
  },
  State_49270_Name = {
    Text = "攻撃カードダメージ増加"
  },
  State_49270_WeaponDesc = {
    Text = "打撃牌のダメージが [Layer] ％ 上昇します。"
  },
  State_49278_Desc = {
    Text = "ターン終了時、失ったライフの5%を回復。ライフが50%([StateArg1])未満の場合、[StateArg2]力を獲得。"
  },
  State_49278_Name = {
    Text = "深紅の祭壇"
  },
  State_49430_Desc = {
    Text = "1点につき受けるダメージが1%減少する。他の味方が死亡すると、この状態を解除。"
  },
  State_49430_Name = {
    Text = "<AberrationColour:隠れる>"
  },
  State_49500_Desc = {
    Text = "1点につき攻撃回数+1。ダメージを受けると1点を失う。ターン終了時にすべて失う。"
  },
  State_49500_Name = {Text = "祈り"},
  State_49524_Desc = {
    Text = "ターン終了時、失ったライフの5%を回復。プレイヤーがステータスカードまたは症状カードを引くたび、「ヌビア」は[StateArg1]点の一時的な力を獲得。"
  },
  State_49524_Name = {
    Text = "血色の福音"
  },
  State_49526_Desc = {
    Text = "死後、即座に[StateArg2]のライフを回復し、1ターンの間ダメージを無効化。行動予測は「穢れの種まき」に変化する。"
  },
  State_49526_Name = {Text = "種まき"},
  State_49542_Desc = {
    Text = "チーム唯一：戦闘開始後、装備者の攻撃力の<WeaponEffect_Num:[StateArg1]%>分の力を獲得する。現在界域が「深海」の場合、さらに装備者の攻撃力の<WeaponEffect_Num:[StateArg2]%>分の触腕ダメージが増加する。"
  },
  State_49542_WeaponDesc = {
    Text = "戦闘開始後、<WeaponEffect_Num:[Power:DescArg1]>点の力を獲得する。現在界域が「深海」の場合、さらに<WeaponEffect_Num:[DescArg2]>点の触腕ダメージを獲得する。"
  },
  State_49546_Desc = {
    Text = "常に2名の護衛と共に出現。自身が死亡すると彼らも死亡する。"
  },
  State_49546_Name = {
    Text = "陣形を組む"
  },
  State_49547_Desc = {
    Text = "死亡後、アラン隊長に [StateArg1] の力と50%最大ライフのシールドを付与。"
  },
  State_49547_Name = {Text = "忠誠"},
  State_49558_Desc = {
    Text = "各ターン、力が[StateArg1]点増加する。"
  },
  State_49558_Name = {
    Text = "砂の祈り"
  },
  State_49582_Desc = {
    Text = "この戦闘中、毎ターン残ったシールドは除去されず、保持される。"
  },
  State_49582_Name = {
    Text = "シールド永久保持"
  },
  State_49583_Desc = {
    Text = "ターン終了時、[StateArg1]点のシールドを獲得。警戒ボーナスを受ける。"
  },
  State_49583_Name = {
    Text = "アランの盾"
  },
  State_49595_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_49595_Name = {Text = "未覚醒"},
  State_49596_Desc = {
    Text = "「虚構の刃」 が覚醒した。彼女はシールドと力を獲得。"
  },
  State_49596_Name = {
    Text = "アルバ覚醒！"
  },
  State_49596_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_49597_Name = {
    Text = "このターン、既に麻痺済み__「開発用」"
  },
  State_49600_Desc = {
    Text = "すべての敵を2ターン虚弱にする。"
  },
  State_49600_Name = {
    Text = "恐怖の血"
  },
  State_49601_Desc = {
    Text = "すべての敵を2ターン易傷にする。"
  },
  State_49601_Name = {
    Text = "腐敗の血"
  },
  State_49602_Desc = {
    Text = "すべての敵に1点の<VulnerabilityIconKeywords:軟化>を付与。"
  },
  State_49602_Name = {
    Text = "腐敗の血"
  },
  State_49603_Name = {
    Text = "生殖の血"
  },
  State_49604_Name = {
    Text = "生殖の血"
  },
  State_49605_Desc = {
    Text = "すべての敵に1点の<WeaknessIconKeywords:倦怠>を付与。"
  },
  State_49605_Name = {
    Text = "恐怖の血"
  },
  State_49623_Desc = {
    Text = "受けるライフ回復が[DescArg1]%減少。ターン終了時に1点を除去。"
  },
  State_49623_Name = {
    Text = "<BaseDamageColour:重傷>"
  },
  State_49623_WeaponDesc = {
    Text = "与えるすべてのダメージが[DescArg1]%減少。"
  },
  State_49627_Desc = {
    Text = "初期に2点の<ParcloseIconKeywords:バリア>を持つ。死亡時、すべての「ヌビア」が[StateArg1]点の力を獲得。"
  },
  State_49627_Name = {
    Text = "血脈の奔流"
  },
  State_49628_Desc = {
    Text = "死亡時、すべての「ヌビア」が[StateArg1]点の力を獲得。"
  },
  State_49628_Name = {
    Text = "血脈リンク"
  },
  State_49638_Desc = {
    Text = "黒山羊シリーズのモンスターかどうかを識別するステータス"
  },
  State_49833_Desc = {
    Text = "ターン終了時、すべての敵に1ターン「盲目」状態を付与。自分のシールドが破壊された場合、「盲目化」状態が解放される。"
  },
  State_49833_Name = {
    Text = "砂塵の壁"
  },
  State_49844_Desc = {
    Text = "チーム唯一：ターン終了後に<WeaponEffect_Num:[StateArg1]>点の銀鍵エネルギーを獲得する。死亡抵抗が発動した後、<WeaponEffect_Num:[StateArg2]>点の銀鍵エネルギーを獲得する。応急霊知体を使用した後、算力上限が3増加し、毎ターンのドロー数が3増加する。"
  },
  State_49844_WeaponDesc = {
    Text = "ターン終了後に<WeaponEffect_Num:[StateArg1]>点の銀鍵エネルギーを獲得する。死亡抵抗が発動した後、<WeaponEffect_Num:[StateArg2]>点の銀鍵エネルギーを獲得する。応急霊知体を使用した後、算力上限が3増加し、毎ターンのドロー数が3増加する。"
  },
  State_49877_Desc = {
    Text = "カードの行動力消費を減少。使用後「変異」1点ごとにランダムな「変異」ステータスカードを1枚手札に追加し、この状態を解除。この状態は戦闘終了後も維持する。"
  },
  State_49877_Name = {
    Text = "<AberrationKeywords:変異>"
  },
  State_49877_WeaponDesc = {
    Text = "各层の遅延により、カードの計算力消費が 1 ポイント増加します。"
  },
  State_49954_Desc = {
    Text = "すべての覚醒体のクリティカルダメージが半減。"
  },
  State_49954_Name = {
    Text = "<BlindingKeywords:盲目>"
  },
  State_49954_WeaponDesc = {
    Text = "各层の遅延により、カードの計算力消費が 1 ポイント増加します。"
  },
  State_49957_Desc = {
    Text = "アクティブダメージを受けた時、攻撃した覚醒体の狂気解放と全カードを1ターン封印し、<ResentChainsKeywords:怨恨の鎖>を1スタック除去する。ターン終了時にクリアする。"
  },
  State_49957_Name = {
    Text = "<ResentChainsKeywords:怨恨の鎖>"
  },
  State_49957_WeaponDesc = {
    Text = "各层の遅延により、カードの計算力消費が 1 ポイント増加します。"
  },
  State_49958_Desc = {
    Text = "アクティブおよび触手ダメージを受けた時、覚醒体への攻撃の狂気解放とすべてのカードを1ターン封印し、<ResentChainsKeywords:怨恨の鎖>を1スタック除去する。"
  },
  State_49958_Name = {
    Text = "<ResentChainsKeywords1:怨恨の鎖>"
  },
  State_49959_Desc = {
    Text = "各ターン開始時に1回の<ResentChainsKeywords:怨恨の鎖>を獲得。"
  },
  State_49959_Name = {
    Text = "多次元の鎖"
  },
  State_50010_Desc = {
    Text = "受けるライフ回復が25%減少する。ターン終了時に1点を除去。"
  },
  State_50010_Name = {
    Text = "<HeavyInjuryKeywords:重傷>"
  },
  State_50021_Desc = {
    Text = "チームユニーク：装備者が狂気解放を発動した後、装備者の攻撃力の <WeaponEffect_Num:[StateArg1]%> に等しい<PowerIconKeywords:力>を獲得する。現在の界域が「血肉」の場合、狂気解放を発動した後、胚胎融合 <WeaponEffect_Num:+[Blood:StateArg2]> となる。"
  },
  State_50021_WeaponDesc = {
    Text = "装備者が狂気解放を発動した後、<WeaponEffect_Num:[Power:DescArg1]> 点の<PowerIconKeywords:力>を獲得する。現在の界域が「血肉」の場合、狂気解放を発動した後、胚胎融合 <WeaponEffect_Num:+[Blood:StateArg2]> となる。"
  },
  State_50302_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：致死ダメージを1回抵抗し、この「運命の札」を破壊する。[StateArg1]層の<PVPProtectiveKeywords:バリア>を獲得。発動時に生存している味方が自身のみの場合、次のターン開始時にランダムな「キーオーダー」を[StateArg2]枚獲得する。"
  },
  State_50302_Name = {
    Text = "極夜と暁"
  },
  State_50323_Desc = {
    Text = "次のターン開始前、ランダムな「キーオーダー」を[Layer]枚獲得。"
  },
  State_50323_Name = {
    Text = "遅延キーオーダー"
  },
  State_50333_Desc = {
    Text = "ターン終了時、すべての覚醒体の狂気が減少する。"
  },
  State_50333_Name = {
    Text = "<EmptinessKeywords:虚無>"
  },
  State_50333_WeaponDesc = {
    Text = "各层の遅延により、カードの計算力消費が 1 ポイント増加します。"
  },
  State_50352_Name = {
    Text = "タイスの試遊"
  },
  State_50353_Name = {
    Text = "タイスの試遊"
  },
  State_50358_Desc = {
    Text = "1点につき受けるダメージが1%減少する。他の味方が死亡すると、この状態を解除。"
  },
  State_50358_Name = {
    Text = "<ConcealmentKeywords:隠匿>"
  },
  State_50375_Desc = {
    Text = "これらの効果には以下が含まれる：自身が10狂気を獲得、他の味方が5狂気を獲得、すべての敵に1点の軟化を付与、すべての敵に1点の倦怠を付与、カードを1枚引く、200キーエネルギーを獲得。"
  },
  State_50375_Name = {
    Text = "<MysterybuffKeywords:不思議なバフ>"
  },
  State_50389_Desc = {
    Text = "ターン開始時、手札に1枚の「ライカーのラッキーサイコロ」を加える。"
  },
  State_50389_Name = {
    Text = "ライカーの支援"
  },
  State_50390_Desc = {
    Text = "ターン開始時、[StateArg1]点の力を獲得。"
  },
  State_50390_Name = {
    Text = "戦地の知恵"
  },
  State_50491_Name = {
    Text = "時霊振り子「均衡」"
  },
  State_50735_Desc = {
    Text = "初めて敗北に直面した時、ライフが回復し行動予測は「哀しみを裂く」に変化し、非常に高い単発ダメージを与える。"
  },
  State_50735_Name = {
    Text = "無意味な毅然"
  },
  State_50854_Desc = {
    Text = "戦闘開始時、[StateArg1]点の<RetaliateIconKeywords:反撃>を獲得。ターン終了後に[StateArg2]点のシールドを獲得し、毎ターンこのシールドが[StateArg3]点増加する。"
  },
  State_50854_Name = {
    Text = "強靭な樹皮"
  },
  State_50861_Desc = {
    Text = "ダメージを受けずに、「無数の子孫の母」を解放。"
  },
  State_50861_Name = {Text = "派生"},
  State_50862_Desc = {
    Text = "ダメージを受けずに、「繁殖」を解放。"
  },
  State_50863_Desc = {
    Text = "ダメージを受けずに、「狂野樹液」を解放。"
  },
  State_50863_Name = {Text = "無効化"},
  State_50864_Desc = {
    Text = "ダメージを受けずに、「樹液」を解放。"
  },
  State_50864_Name = {Text = "無効化"},
  State_50891_Desc = {
    Text = "ダメージを受けずに、「多重融合」を解放。"
  },
  State_50891_Name = {Text = "捕食"},
  State_51016_Desc = {
    Text = "受ける毒効果が1000%になる。"
  },
  State_51016_Name = {Text = "枯れ木"},
  State_51017_Desc = {
    Text = "受ける毒効果が500%になる。"
  },
  State_51017_Name = {Text = "枯れ木"},
  State_51607_Desc = {
    Text = "すべてのダメージを無効化し、ターン開始後に除去される。"
  },
  State_51607_Name = {
    Text = "ダメージを無効化"
  },
  State_51695_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_51695_Name = {Text = "未覚醒"},
  State_51696_Desc = {
    Text = "「海の使徒」 が覚醒した。狂気解放に対する反抗力が強い。"
  },
  State_51696_Name = {
    Text = "ミリアム覚醒！"
  },
  State_51696_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_51739_Desc = {
    Text = "ターン終了時にランダムで1枚の「神国幻影」を獲得。解放不可。"
  },
  State_51739_Name = {
    Text = "信仰の終焉"
  },
  State_51740_Desc = {
    Text = "戦闘開始時に、1枚の「妄執」を手札に追加。"
  },
  State_51740_Name = {
    Text = "不滅の信仰"
  },
  State_51741_Desc = {
    Text = "ターン開始時に[Layer]点のシールドを獲得。解除不可。"
  },
  State_51741_Name = {
    Text = "自己の堅持"
  },
  State_51742_Desc = {
    Text = "ターン開始時に[Layer]点の触腕ダメージと力を獲得。解除不可。"
  },
  State_51742_Name = {
    Text = "啓示への献身"
  },
  State_51743_Desc = {
    Text = "このターン、触腕が攻撃するたび、触腕モードに応じて以下の効果を獲得する：潮流：すべての覚醒体が<Energy:[Energy:StateArg1]>狂気を獲得；静海：すべての敵に[StateArg2]点の<IntoxicationIconKeywords:毒>を付与；怒涛：一時的な<TentacleInjurieIconKeywords:触腕ダメージ>が+[StateArg3]増加。"
  },
  State_51743_Name = {
    Text = "母神の祝祷"
  },
  State_51745_Desc = {
    Text = "海の使徒が1枚のカードを出すと、[StateArg1]本の一時的な触腕が生成され、この触腕は触腕の上限を無視できます。"
  },
  State_51745_Name = {
    Text = "代行権能"
  },
  State_51745_WeaponDesc = {
    Text = "海の使徒が1枚のカードを出すと、[StateArg1]本の一時的な触腕が生成され、この触腕は触腕の上限を無視できます。"
  },
  State_51811_Name = {
    Text = "舵帆の治癒効果__「開発用」"
  },
  State_51813_Desc = {
    Text = "ターン終了後、行動力消費が[Layer]点減少。捨てられた時もこの効果は発動。"
  },
  State_51813_Name = {
    Text = "<PrepareKeypvewordscolour:準備[Layer]>"
  },
  State_51820_Desc = {
    Text = "「生出」追加効果：5点で即座に「水の子」を1体召喚、最大2体まで存在可能。"
  },
  State_51820_Name = {
    Text = "ミリアム覚醒"
  },
  State_51822_Desc = {
    Text = "狂気解放を発動するたびに、「生出」が1点増え、1点につき[StateArg1]点の力を獲得する、最大5点まで。"
  },
  State_51822_Name = {
    Text = "リモリアの最終降臨"
  },
  State_52068_Desc = {
    Text = "手札にある最大3枚の「聖礼」を「執妄」に変換し、変換した枚数に応じた追加効果を獲得。"
  },
  State_52068_Name = {
    Text = "<CardKeyWord:祭儀>"
  },
  State_52087_Desc = {
    Text = "「不死の極楽鳥」は [Layer] ターン後、再度復活可能なステータスを付与できます。"
  },
  State_52087_Name = {
    Text = "復活クールダウン"
  },
  State_52116_Desc = {
    Text = "ターン終了まで、その覚醒体が狂気解放を使用すると[Layer]ダメージを受ける。"
  },
  State_52116_Name = {
    Text = "狂気封印"
  },
  State_52369_Desc = {
    Text = "[DescArg1] 枚の症状カードを使用すると、トゥルーの支援カード「王権」を獲得。「王権」：大ダメージを与え、対象に1ターン「昏睡」を付与。"
  },
  State_52369_Name = {
    Text = "神国は必ず再臨する"
  },
  State_53115_Desc = {
    Text = "このターン、ミリアムの次の<O07CardKeyWord:祭儀>効果が50%増加。"
  },
  State_53115_Name = {
    Text = "深淵への祈祷"
  },
  State_53144_Desc = {
    Text = "毎ターン開始時、<Block:[Block:StateArg1]>点のシールドを獲得。"
  },
  State_53144_Name = {
    Text = "<CardKeyWord:自己の堅持>"
  },
  State_53145_Desc = {
    Text = "毎ターン開始時、[StateArg2]点の<PowerIconKeywords:力>と<TentacleInjurieIconKeywords:触腕ダメージ>を獲得。"
  },
  State_53145_Name = {
    Text = "<CardKeyWord:啓示への献身>"
  },
  State_53673_Desc = {
    Text = "腺体分裂の数は最大10枚。"
  },
  State_53673_Name = {
    Text = "腺体分裂の制限"
  },
  State_53674_Desc = {
    Text = "手札上限 +2。ターン開始時、ミリアムは20狂気を獲得。"
  },
  State_53674_Name = {
    Text = "ミリアムの試遊"
  },
  State_53755_Desc = {
    Text = "すべての覚醒体が与える<PowerIconKeywords:力>、<RetaliateIconKeywords:反撃>、<IntoxicationIconKeywords:毒>が[DescArg1]%増加。「華やかな章」で獲得する<PowerIconKeywords:力>が増加。"
  },
  State_53755_Name = {
    Text = "神秘の詩篇・惧"
  },
  State_53756_Desc = {
    Text = "すべての覚醒体が獲得する狂気が[DescArg1]%増加。ターン終了時に行動力と指令カードを次のターンに持ち越すことができる。「華やかな章」で獲得する狂気が増加。"
  },
  State_53756_Name = {
    Text = "幻夢の詩篇・喜"
  },
  State_53758_Desc = {
    Text = "すべての覚醒体が与える最終ダメージが[DescArg1]%増加し、「華やかな章」で獲得するクリティカル率とクリティカルダメージが増加。"
  },
  State_53758_Name = {
    Text = "狂想の詩篇・怒"
  },
  State_53759_Desc = {
    Text = "すべての覚醒体が与えるシールドとライフ回復、<PowerIconKeywords:力>の減少効果が[DescArg1]%増加。「華やかな章」のライフ回復効果が増加。"
  },
  State_53759_Name = {
    Text = "哀悼の詩篇・哀"
  },
  State_53772_Name = {
    Text = "アクセサリー二律背反"
  },
  State_53772_WeaponDesc = {
    Text = "装備者が狂気解放を使用后、味方は装備者の防御力の 100% に基づいて<RetaliateIconKeywords:カウンター>を獲得する。さらに自身の現在の<RetaliateIconKeywords:カウンター>が 10% 向上する。"
  },
  State_53870_Name = {
    Text = "「密約」36の廻る部屋"
  },
  State_53870_WeaponDesc = {
    Text = "装備者のカードを引いたとき、その計算力は 0-3 の間でランダムに変化します。"
  },
  State_53981_Name = {
    Text = "アクセサリー薬入りの夢のブラックスタンプ修正"
  },
  State_53981_WeaponDesc = {
    Text = "バトル開始後、装備者の1セットのカードを追加でドロー山に混ぜる。"
  },
  State_54002_Name = {
    Text = "ステータス@アクセサリー薬入りの夢フィルター・マーク"
  },
  State_54002_WeaponDesc = {
    Text = "装備者が狂気解放を使用后、味方は装備者の防御力の 100% に基づいて<RetaliateIconKeywords:カウンター>を獲得する。さらに自身の現在の<RetaliateIconKeywords:カウンター>が 10% 向上する。"
  },
  State_54011_Name = {
    Text = "ステータス：アクセサリー「薬入りの夢」コピー1使用可能"
  },
  State_54011_WeaponDesc = {
    Text = "装備者が狂気解放を使用后、味方は装備者の防御力の 100% に基づいて<RetaliateIconKeywords:カウンター>を獲得する。さらに自身の現在の<RetaliateIconKeywords:カウンター>が 10% 向上する。"
  },
  State_54012_Name = {
    Text = "ステータス@アクセサリー薬入りの夢コピー2使用可"
  },
  State_54012_WeaponDesc = {
    Text = "装備者が狂気解放を使用后、味方は装備者の防御力の 100% に基づいて<RetaliateIconKeywords:カウンター>を獲得する。さらに自身の現在の<RetaliateIconKeywords:カウンター>が 10% 向上する。"
  },
  State_54013_Desc = {
    Text = "このターンに界域知識が[Layer]点増加。"
  },
  State_54013_Name = {
    Text = "一時的な界域知識"
  },
  State_54014_Desc = {
    Text = "界域知識が[Layer]点増加。"
  },
  State_54014_Name = {
    Text = "界域知識"
  },
  State_54043_WeaponDesc = {
    Text = "装備者が狂気解放を使用した後、そのターン内で自身のシールドと治療の強力が2倍になる。"
  },
  State_54044_Desc = {
    Text = "2倍のダメージを与え、さらに環行ラモンナのキーチャージと同等の 600% のキーエネルギーを獲得するが、発射後<DepleteIconKeywords:消費>される。"
  },
  State_54044_Name = {
    Text = "未来の讃歌"
  },
  State_54045_Desc = {
    Text = "3点の行動力を獲得。"
  },
  State_54045_Name = {
    Text = "輪廻の庭"
  },
  State_54046_Desc = {
    Text = "ターン開始時、ライフを[StateArg1]回復する。[Layer]ターン持続。"
  },
  State_54046_Name = {
    Text = "理性、真理と現実"
  },
  State_54071_Desc = {
    Text = "オジールが与えるアクティブダメージの回数 +1、[Layer] ターン持続する。"
  },
  State_54071_Name = {
    Text = "七つの技、継承した美徳"
  },
  State_54121_Desc = {
    Text = "この戦闘中「混沌の獣」が与える基礎ダメージが[Layer]％増加。"
  },
  State_54121_Name = {
    Text = "混沌の獣"
  },
  State_54138_Desc = {
    Text = "ソレルが [Layer] 枚のコマンドカードをプレイした効果が 2 回発動する。"
  },
  State_54138_Name = {
    Text = "権欲の輪舞"
  },
  State_54384_Desc = {
    Text = "ニムフィーアの<IntoxicationIconKeywords:毒>ダメージを50%増加させ、[Layer] ターン持続する。"
  },
  State_54384_Name = {
    Text = "自我の葬儀"
  },
  State_54416_Desc = {
    Text = "「極限解放」を解放した覚醒体は狂気を2回まで溜めることができ、狂気が2回目に溜まった時に「狂気解放」を「極限解放」にアップグレードできる。「極限解放」は元の効果に加えて、強力な効果が付与される。通常の「狂気解放」を発動した場合、残りの狂気の50%を追加で消費する。"
  },
  State_54416_Name = {
    Text = "<OverLimitUtlSkillKeywords:極限解放>"
  },
  State_54416_WeaponDesc = {
    Text = "手札の胎児を消費し、強力な呑食効果を発動する。"
  },
  State_54561_Desc = {
    Text = "チーム唯一：装備者が与えるダメージ数値が装備者の攻撃力の<WeaponEffect_Num:[StateArg1]%>分増加する。現在界域が「血肉」の場合、装備者が捕食効果を発動するたび、さらに装備者が与えるダメージ数値が装備者の攻撃力の3%分増加する。"
  },
  State_54561_WeaponDesc = {
    Text = "装備者が与えるダメージが[DescArg1]点増加する。現在界域が「血肉」の場合、装備者が捕食効果を発動するたび、さらに装備者が与えるダメージが[DescArg2]点増加する。"
  },
  State_54568_Name = {
    Text = "星が終わるまで"
  },
  State_54597_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：敵の覚醒体が死亡した後、[StateArg1]点の<StrongEffectKeywords:特効>を獲得し、その算力消費が最も高く<PVPVoidKeywords:虚無>が付与された「スキル」を手札に追加する。"
  },
  State_54597_Name = {
    Text = "百万の寵愛の眼"
  },
  State_54704_Desc = {
    Text = "「24」 の次の指令カードは、効果が3回発動する。"
  },
  State_54704_Name = {
    Text = "歪んだ死体の宴"
  },
  State_54798_Desc = {
    Text = "すべての覚醒体が獲得するシールドとライフ回復、<PowerIconKeywords:力>の減少効果が[StateArg1]%増加し、「華やかな章」のライフ回復効果が増加。"
  },
  State_54799_Desc = {
    Text = "すべての覚醒体が付与する<PowerIconKeywords:力>、<RetaliateIconKeywords:反撃>、<IntoxicationIconKeywords:毒>が[StateArg1]%増加し、「華やかな章」で獲得する<PowerIconKeywords:力>が増加。"
  },
  State_54800_Desc = {
    Text = "すべての覚醒体が与える最終ダメージが[StateArg1]%上昇し、華やかな篇章のクリティカル率とクリティカルダメージが上昇する。"
  },
  State_55108_Desc = {
    Text = "ターン開始時、手札にある「緑炎」または「腐食の緑炎」を「死滅の緑炎」にアップグレードする。[Layer] ターン持続。"
  },
  State_55108_Name = {
    Text = "死兆の到来"
  },
  State_55108_WeaponDesc = {
    Text = "ターン終了時に手札または超次元空間にある場合、効果が強化される"
  },
  State_55113_Desc = {
    Text = "毎ターン初めてオルラの詩篇を使用した後、10狂気を獲得。"
  },
  State_55113_Name = {
    Text = "花と詩の再会"
  },
  State_55465_Name = {
    Text = "[Layer]点の隠喩「怒」を消費し、追加でダメージを[DescArg1]回を与える"
  },
  State_55466_Name = {
    Text = "[Layer]点の隠喩「哀」を消費し、ライフを<Heal:[Heal:DescArg1]>回復"
  },
  State_55467_Name = {
    Text = "[Layer]点の隠喩「惧」を消費し、追加で[Power:DescArg1]点の<PowerIconKeywords:力>を獲得"
  },
  State_55469_Name = {
    Text = "[Layer]点の隠喩「喜」を消費し、追加で<Energy:[Energy:DescArg1]>狂気を獲得"
  },
  State_55470_Name = {
    Text = "首切りの一撃"
  },
  State_55485_Desc = {
    Text = "カシアが次に出す[Layer]枚のカードは自身の攻撃力の10％の力量を獲得する。"
  },
  State_55485_Name = {
    Text = "思い切り笑う"
  },
  State_55486_Name = {
    Text = "「死せる夢の都」の極限解放で夢引きの消費を免除"
  },
  State_55487_Desc = {
    Text = "エリカの「打撃」が追加で 2 回のダメージを与え、「防御」が追加で 2 回のシールドを得る、[Layer] ターン続く。"
  },
  State_55487_Name = {
    Text = "多重計算"
  },
  State_55489_Name = {
    Text = "時空折躍"
  },
  State_55806_Name = {
    Text = "<PoetryKeywords:詩>：すべての敵にデバフの<PVPWonderfulEffectKeywords:不思議な効果>を与えるか、すべての味方にバフの<PVPWonderfulEffectKeywords:不思議な効果>を与えるか、またはカードを1枚引き、1点の行動力を獲得する。最後の詩は2回発動する"
  },
  State_55807_Name = {
    Text = "カードを1枚引き、1点の行動力を獲得する。"
  },
  State_55808_Name = {
    Text = "<PoetryKeywords:詩>：すべての味方にバフの<PVPWonderfulEffectKeywords:不思議な効果>を与えるか、またはカードを1枚引き、1点の行動力を獲得する。最後の詩は2回発動する"
  },
  State_55809_Name = {
    Text = "すべての敵にデバフの<PVPWonderfulEffectKeywords:不思議な効果>を与える"
  },
  State_55811_Desc = {
    Text = "リストから1つを選んで有効にする。"
  },
  State_55811_Name = {
    Text = "<ComaColour:選択>"
  },
  State_55813_Name = {
    Text = "<PoetryKeywords:詩>：すべての敵にデバフの<PVPWonderfulEffectKeywords:不思議な効果>を与えるか、またはカードを1枚引き、1点の行動力を獲得する。最後の詩は2回発動する"
  },
  State_55814_Name = {
    Text = "<PoetryKeywords:詩>：すべての敵にデバフの<PVPWonderfulEffectKeywords:不思議な効果>を与えるか、またはすべての味方にバフの<PVPWonderfulEffectKeywords:不思議な効果>を与える。最後の詩は2回発動する"
  },
  State_55816_Name = {
    Text = "すべての味方にバフの<PVPWonderfulEffectKeywords:不思議な効果>を与える"
  },
  State_55824_Desc = {
    Text = "選択肢から1つを選んで有効にし、選んだ選択肢を除去。残りの選択肢がある場合、このカードを相手の手札に追加する。"
  },
  State_55824_Name = {
    Text = "<ComaColour:献詩>"
  },
  State_55836_Desc = {
    Text = "ターン終了後、手札にあるオルラの指令カードの行動力消費が1減少する。"
  },
  State_55836_Name = {
    Text = "墨染めの詩"
  },
  State_55839_Desc = {
    Text = "拾取時に他のすべてのつくりものを失い、ランダムに2つのゴールドクリエイションを獲得する。"
  },
  State_55866_Desc = {
    Text = "チーム唯一：戦闘開始時、装備者の指令カードを1枚ドローし、<WeaponEffect_Num:[StateArg1]％>の確率でその算力消費を1低下させる。死亡抵抗が発動するたびに、この効果を1回再発動する。"
  },
  State_55866_WeaponDesc = {
    Text = "戦闘開始時、装備者の指令カードを1枚ドローし、<WeaponEffect_Num:[StateArg1]％>の確率でその算力消費を1低下させる。死亡抵抗が発動するたびに、この効果を1回再発動する。"
  },
  State_55992_Desc = {
    Text = "行動力が不足している場合、カードに「除外」と印を付与する。"
  },
  State_55992_Name = {Text = "灰燼"},
  State_55993_Name = {
    Text = "灰烬の印"
  },
  State_56018_Desc = {
    Text = "この戦闘中、最大ライフが[Layer]%増加。"
  },
  State_56018_Name = {
    Text = "ミューズの加護・命"
  },
  State_56020_Desc = {
    Text = "この戦闘中、与えるダメージが[Layer]%増加。"
  },
  State_56020_Name = {
    Text = "ミューズの加護・力"
  },
  State_56030_Desc = {
    Text = "このターン、覚醒体のシールドと治癒が[Layer]%アップ。"
  },
  State_56031_Desc = {
    Text = "このターン、ダメージを与えるたびに一時的なクリティカル率が[Layer]%増加。"
  },
  State_56031_Name = {Text = "蝶"},
  State_56034_Desc = {
    Text = "各「隠喩」の上限は3点。「隠喩」ごとに異なる詩篇の効果を強化：\n<D06CardKeyWordnu:狂想の詩篇>：すべての「怒」を消費し、1点につき追加でダメージを2回与える。\n<D06CardKeyWordai:哀悼の詩篇>：すべての「哀」を消費し、1点につきライフを回復。\n<D06CardKeyWordxi:幻夢の詩篇>：すべての「喜」を消費し、1点につき10狂気を獲得。\n<D06CardKeyWordju:神秘の詩篇>：すべての「惧」を消費し、1点につき<PowerIconKeywords:力>を獲得。"
  },
  State_56034_Name = {Text = "隠喩"},
  State_56208_Desc = {
    Text = "雨の賛歌：<Heal:[DescArg1]> ポイントのライフを回復する。\n風の賛歌：[DescArg2] ポイントの<PowerIconKeywords:力>を獲得する。\n花の賛歌：全ての覚醒体が [DescArg3] ポイントの狂気を獲得する。\n月の賛歌：一時的なクリティカルレートが [DescArg4]％ 上昇する。"
  },
  State_56208_Name = {Text = "詩片"},
  State_56330_Desc = {
    Text = "[DescArg1]点のシールドを獲得する。このターン中に「狂気解放」を3回発動した場合、このカードは追加で1回効果が発動する。"
  },
  State_56330_Name = {
    Text = "詳細なイメージ"
  },
  State_56331_Desc = {
    Text = "山札と捨て札から指令カードを1枚選択して手札に追加し、その行動力消費-2。"
  },
  State_56331_Name = {
    Text = "詳細なイメージ"
  },
  State_56332_Desc = {
    Text = "[DescArg1]点の一時的な<PowerIconKeywords:力>を獲得する。使用後、このターン中にダメージを1回与えるたび、一時的なクリティカル率+3%。"
  },
  State_56332_Name = {
    Text = "詳細なイメージ"
  },
  State_56333_Desc = {
    Text = "失ったライフの10%を回復する。現在のライフが25%未満の場合、このカードは追加で1回効果が発動する。"
  },
  State_56333_Name = {
    Text = "詳細なイメージ"
  },
  State_56334_Desc = {
    Text = "次のキーオーダーは効果が2回発動する。"
  },
  State_56334_Name = {
    Text = "詳細なイメージ"
  },
  State_56335_Desc = {
    Text = "自身の最大ライフの150%に等しい<FixedDamage:純粋ダメージ>を与える。このダメージは10倍の<PowerIconKeywords:力>ボーナスを受ける。"
  },
  State_56335_Name = {
    Text = "詳細なイメージ"
  },
  State_56336_Desc = {
    Text = "カードを5枚引く。"
  },
  State_56336_Name = {
    Text = "詳細なイメージ"
  },
  State_56337_Desc = {
    Text = "[DescArg1]点の一時的な<AlertIconKeywords:警戒>を獲得する。使用後、このターン中のすべての覚醒体が与えるシールドと回復が[DescArg2]%増加する。"
  },
  State_56337_Name = {
    Text = "詳細なイメージ"
  },
  State_56338_Desc = {
    Text = "3点の行動力を獲得する。"
  },
  State_56338_Name = {
    Text = "詳細なイメージ"
  },
  State_56339_Desc = {
    Text = "ランダムなデバフ状態を1つ解除する。このカードは追加で3回効果が発動し、除外される。"
  },
  State_56339_Name = {
    Text = "詳細なイメージ"
  },
  State_56340_Desc = {
    Text = "すべての敵に3点の<VulnerabilityIconKeywords:軟化>を付与する。敵が死亡するたび、このカードを山札から手札に追加。"
  },
  State_56340_Name = {
    Text = "詳細なイメージ"
  },
  State_56341_Desc = {
    Text = "界域知識+25点、一時的な界域知識+125点。"
  },
  State_56341_Name = {
    Text = "詳細なイメージ"
  },
  State_56342_Desc = {
    Text = "すべての覚醒体が15狂気を獲得する。"
  },
  State_56342_Name = {
    Text = "詳細なイメージ"
  },
  State_56343_Desc = {
    Text = "すべての敵に3点の<WeaknessIconKeywords:倦怠>を付与する。<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>が付与されたランダムな「イメージ」を1枚捨て札に追加。"
  },
  State_56343_Name = {
    Text = "詳細なイメージ"
  },
  State_56372_Desc = {
    Text = "死亡時、プレイヤーに最後に付与された1つのデバフ状態を解除する。"
  },
  State_56372_Name = {Text = "花と詩"},
  State_56400_Desc = {
    Text = "「攻撃」使用時、手札にある装備者の非派生「スキル」が、順番に装備者の他の「スキル」に変化する。[ShowIfState: <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]。"
  },
  State_56400_Name = {
    Text = "昔日の花と詩"
  },
  State_56402_Desc = {
    Text = "隠喩<D06CardKeyWordnu:「怒」>[DescArg2]点：「狂想の詩篇」の「跳躍」効果発動時に、追加でダメージを与える。\n隠喩<D06CardKeyWordai:「哀」>[DescArg3] 回：「哀悼の詩篇」の「跳躍」効果発動時に、追加でライフを回復。\n隠喩<D06CardKeyWordxi:「喜」>[DescArg1] 回：「幻夢の詩篇」の「跳躍」効果発動時に、追加で覚醒体に狂気を獲得させる。\n隠喩<D06CardKeyWordju:「惧」>[DescArg4] 回：「神秘の詩篇」の「跳躍」効果発動時に、追加で力を獲得。"
  },
  State_56402_Name = {Text = "隠喩"},
  State_57166_Desc = {
    Text = "覚醒体が与えるダメージが25%増加する。"
  },
  State_57170_Desc = {
    Text = "手札の上限＋2，ターン終了時に手札から1枚を選択して持ち越し、そのカードの計算力消費を-1にする。効果は3ターン続く。"
  },
  State_57170_Name = {
    Text = "迷航の光"
  },
  State_57316_Desc = {
    Text = "各ターン開始時、「胚胎」1枚を<EmbryoFusionIconKeywords:聖純の子>に変換する。「胚胎」がない場合、胚胎融合 +[Blood:DescArg1]。胚胎融合アップ効果の影響を受けない。持続 [Layer] ターン。"
  },
  State_57316_Name = {
    Text = "聖骸の伝承"
  },
  State_57317_Desc = {
    Text = "この運命の札がデッキにある時、手札のスキルの変化が見える。"
  },
  State_57317_Name = {
    Text = "<PVPFlowerKeywords:昔日の花と詩>"
  },
  State_57324_Desc = {
    Text = "この覚醒体が「昔日の花と詩」を発動した場合、このカードは<CardKeyWord:<SkillName1:>>に変化する。"
  },
  State_57324_Name = {
    Text = "昔日の花と詩"
  },
  State_57325_Desc = {
    Text = "この覚醒体が「昔日の花と詩」を発動した場合、このカードは<CardKeyWord:<SkillName2:>>に変化する。"
  },
  State_57325_Name = {
    Text = "昔日の花と詩"
  },
  State_57326_Desc = {
    Text = "この覚醒体が「昔日の花と詩」を発動した場合、このカードは<CardKeyWord:<SkillName3:>>に変化する。"
  },
  State_57326_Name = {
    Text = "昔日の花と詩"
  },
  State_57335_Name = {
    Text = "このカードのダメージは [DescArg1] 倍の力ボーナスを獲得"
  },
  State_57356_Name = {
    Text = "状態@沈淵者カウンター計算"
  },
  State_57368_Name = {
    Text = "ステータス＠沈淵者カウンタートラップ"
  },
  State_57413_Name = {
    Text = "シールド1点につき、このカードのダメージが[DescArg1]増加する"
  },
  State_57417_Desc = {
    Text = "デスレジスタンスが発動するたびに、100％のカウンターの<FixedDamage:純粋ダメージ>を与え、本バトル中、デスレジスタンスが発動するたびに、<FixedDamage:純粋ダメージ>が25％アップする。"
  },
  State_57417_Name = {
    Text = "愛の揺籃"
  },
  State_57566_Name = {
    Text = "絶望からの生還"
  },
  State_57587_Desc = {
    Text = "「腺体分裂」を使用した時、カードを1枚引く。残り[Layer]回。"
  },
  State_57587_Name = {
    Text = "クラゲ集合！"
  },
  State_57665_Name = {
    Text = "神母の庇護"
  },
  State_57728_Desc = {
    Text = "ユウハシのダメージ回数が 1 上昇します。"
  },
  State_57728_Name = {
    Text = "ブラッドサージの贈り物"
  },
  State_57751_Desc = {
    Text = "チーム唯一：装備者が生成するシールドが<WeaponEffect_Num:[StateArg1]％>増加する。キーオーダー発動後、全ての覚醒体が<WeaponEffect_Num:[StateArg2]％>の一時クリティカル率とクリティカルダメージを獲得するが、最大HPの3％の献祭が付与される。現在の界域が「深海」の場合、キーオーダー発動後さらに触腕ダメージが装備者の攻撃力の<WeaponEffect_Num:[StateArg3]％>分増加する。"
  },
  State_57751_WeaponDesc = {
    Text = "装備者が生成するシールドが<WeaponEffect_Num:[StateArg1]％>増加する。キーオーダー発動後、全ての覚醒体が<WeaponEffect_Num:[StateArg2]％>の一時クリティカル率とクリティカルダメージを獲得するが、[DescArg1]ポイントの献祭が付与される。現在の界域が「深海」の場合、キーオーダー発動後さらに触腕ダメージが[DescArg2]ポイント増加する。"
  },
  State_57753_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に[StateArg1]層の<PVPSleepKeywords:極上の睡眠>を獲得。"
  },
  State_57753_Name = {
    Text = "氷河の眠り"
  },
  State_57766_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：毎ターン最初の「狂気解放」の後、一時的に<StrongEffectKeywords:特効>+[StateArg1]。"
  },
  State_57766_Name = {
    Text = "羊飼いの杖"
  },
  State_57767_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、<Energy:[Energy:Arg1]>狂気を消費して<PVPDerivativeCardKeywords_12:「小さな願い」>に変換する。変換に失敗した場合、<Energy:[Energy:Arg2]>狂気を獲得する。"
  },
  State_57767_Name = {
    Text = "永劫の演奏"
  },
  State_57768_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「スキル」のダメージが[StateArg1]%増加する。「狂気解放」の後、自身の失ったライフの[StateArg2]%を回復する。"
  },
  State_57768_Name = {
    Text = "雪山が溶けるまで"
  },
  State_57769_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備者のスキルカードを初めて使用した後、装備者のスキルカードを1枚引く。毎ターン1回まで発動。"
  },
  State_57769_Name = {
    Text = "真理の門"
  },
  State_57770_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「スキル」が与えるダメージ・回復・シールド効果が [StateArg1]〜[StateArg2]%（現在 [Layer] %）アップ、<PhantomKeywords:幻影>。"
  },
  State_57770_Name = {
    Text = "運命のルーレット"
  },
  State_57814_Name = {
    Text = "このマークがある時、運命の札を交換中であることを示す。一部のロジックはこのマークを認識する必要がある。__「開発用」"
  },
  State_57817_Desc = {
    Text = "行動不能。ターン終了時に1点減少。点数を使い切ると、<StrongEffectKeywords:特効>+5。解除不可。運命の札を交換した場合「極上の睡眠」状態を失う。"
  },
  State_57817_Name = {
    Text = "極上の睡眠"
  },
  State_57854_Desc = {
    Text = "ターン開始時、[StateArg1]点のシールドと[StateArg2]点の触腕ダメージを獲得し、一時的な触腕を2本生成する。[Layer] ターン持続。"
  },
  State_57854_Name = {
    Text = "自由の誓い"
  },
  State_57854_WeaponDesc = {
    Text = "ステータス@深海の淑女の紅茶とケーキ"
  },
  State_57864_Name = {
    Text = "更新ダメージボーナス__「開発用」"
  },
  State_57942_Desc = {
    Text = "現在の融合度[Layer]%。融合度が100%に達すると、敵は強制的に次の段階に入り、より強力な段階移行スキルを発動します。"
  },
  State_57952_Desc = {
    Text = "力が減少する時、力は点数の50%しか減少しない。"
  },
  State_57952_Name = {Text = "深淵"},
  State_57953_Desc = {
    Text = "ターン終了時、1本の触腕を生成する。覚醒後、この状態を解除。"
  },
  State_57953_Name = {Text = "熟睡"},
  State_57955_Desc = {
    Text = "シロが与えるダメージが[StateArg1]％アップし、[Layer]ターン続く。"
  },
  State_57955_Name = {
    Text = "絶境サバイバル·ダメージ"
  },
  State_57968_Desc = {
    Text = "ジュリエットの影響で、毎ターン終了時に双子の融合度が10%増加し、1枚の「変異」を山札に追加する。"
  },
  State_57968_Name = {
    Text = "「ジュリエットの詠唱」"
  },
  State_57970_Name = {
    Text = "神母の庇護"
  },
  State_57976_Desc = {
    Text = "「暗の子」が強制融合を行うと、「忘却の始まり」に対して自身の現在のライフの3倍の<FixedDamage:純粋ダメージ>を与える。"
  },
  State_57976_Name = {Text = "犠牲"},
  State_58051_Desc = {
    Text = "クリティカルダメージ +[Layer]%。"
  },
  State_58051_Name = {
    Text = "クリティカルダメージ"
  },
  State_58052_Desc = {
    Text = "探索中に1黒章を消費するたび、「オールイン」の基礎ダメージが0.5%増加。(現在[DescArg1]%)"
  },
  State_58052_Name = {
    Text = "確実な儲け話"
  },
  State_58061_Name = {
    Text = "遺失物調査"
  },
  State_58063_Desc = {
    Text = "覚醒体によるダメージが25%増加、[Layer]ターン持続。"
  },
  State_58063_Name = {
    Text = "永遠を超越する凝視"
  },
  State_58144_Desc = {
    Text = "このステージのクリティカル率増加[Layer]%。"
  },
  State_58144_Name = {
    Text = "永続のクリティカル率"
  },
  State_58144_WeaponDesc = {
    Text = "本次関卡クリティカルレート上昇 [Layer] ％ 。"
  },
  State_58259_Desc = {
    Text = "チーム唯一：装備者のクリティカル率が<WeaponEffect_Num:[StateArg1]％>増加する。装備者が敵を撃破後、<WeaponEffect_Num:[StateArg2]>ポイントの黒印を獲得する。探索中最大3回まで発動可能。3回発動後、今回の探索中装備者のクリティカル率が永続的に<WeaponEffect_Num:[StateArg3]％>増加する。"
  },
  State_58259_WeaponDesc = {
    Text = "装備者のクリティカル率が<WeaponEffect_Num:[StateArg1]％>増加する。装備者が敵を撃破後、<WeaponEffect_Num:[DescArg2]>ポイントの黒印を獲得する。探索中最大3回まで発動可能（[DescArg1]/3）。3回発動後、今回の探索中装備者のクリティカル率が永続的に<WeaponEffect_Num:[StateArg3]％>増加する。"
  },
  State_58297_Desc = {
    Text = "ライカーが敵を倒すと[DescArg3]の黒章を獲得し、毎回の探索で最大5回まで有効。（[DescArg1]/5）\n戦闘で50/125/250の黒章を獲得すると、遺物の上限が1増加し、戦闘終了時に「混沌の遺志」を選択して遺物リストに追加する。（すでに[DescArg2]の黒章を獲得）"
  },
  State_58297_Name = {
    Text = "勝者総取り"
  },
  State_58447_Desc = {
    Text = "以下の3つの遺物を含む：\n「幸運のコート」：すべての覚醒体のクリティカル率が10%増加。ライカーとサイコロのランダム結果には最低値が出ない。\n<TentacleInjurieIconKeywords:アップグレード>: クリティカル率が15%に増加し、ランダム結果の最大値が1上がる。\n「イカサマダイス」：「キーオーダー」を発動するたび「<C05_yansheng1:イカサマダイス>」を1枚手札に追加。\n<TentacleInjurieIconKeywords:アップグレード>: 「<C05_yansheng2:輝くイカサマダイス>」を1枚手札に追加。\n「大口ボタン」：ターン開始時およびライカーやサイコロのランダム効果発動時に、50キーエネルギーと2%のクリティカルダメージを獲得し、最大で30%のクリティカルダメージを獲得。\n<TentacleInjurieIconKeywords:アップグレード>: 100キーエネルギーと4%のクリティカルダメージを獲得し、最大で50%のクリティカルダメージを獲得。"
  },
  State_58447_Name = {
    Text = "<CardKeyWord:混沌の遺志>"
  },
  State_58490_Desc = {
    Text = "眠気がすべて解除されると、すべての覚醒体とカードが封印され、「眠れる主」の行動予測は「王権の威」に変化する。"
  },
  State_58490_Name = {Text = "眠気"},
  State_58491_Desc = {
    Text = "カードを使うたびに1点の「眠気」を解除。ターン開始時に12点の「眠気」を回復。"
  },
  State_58491_Name = {Text = "激怒"},
  State_58492_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_58492_Name = {Text = "未覚醒"},
  State_58493_Desc = {
    Text = "カードを使うたびに1点の「眠気」を解除。ターン開始時に12点の「眠気」を回復。"
  },
  State_58493_Name = {Text = "激怒"},
  State_58947_Desc = {
    Text = "このステージ中、クリティカル率が[Layer]%増加する。"
  },
  State_59078_Name = {
    Text = "1回使用可能"
  },
  State_59079_Name = {
    Text = "2回使用可能"
  },
  State_59080_Name = {
    Text = "3回使用可能"
  },
  State_59117_Desc = {
    Text = "クリティカルダメージ +[Layer]%。"
  },
  State_59117_Name = {
    Text = "クリティカルダメージ"
  },
  State_59160_Desc = {
    Text = "与えるすべてのダメージ、治癒、シールド効果が10％増加する。解除不可。"
  },
  State_59160_Name = {
    Text = "<CardKeyWord:特効>"
  },
  State_59161_Desc = {
    Text = "与えるダメージ、治療、シールド効果が[DescArg1]％増加する。解除不可。"
  },
  State_59161_Name = {Text = "特効"},
  State_59169_Desc = {
    Text = "このカードの基本行動力消費は行動力上限を超えません。__「開発用」"
  },
  State_59169_Name = {
    Text = "均衡__「開発用」"
  },
  State_59173_Name = {
    Text = "このマークがある時、連続攻撃中であることを示し、再度連続攻撃は発動しない。__「開発用」"
  },
  State_59208_Desc = {
    Text = "与えるすべてのダメージ、治癒、シールド効果が10％減少する。解除不可。"
  },
  State_59208_Name = {
    Text = "<WeaknessColour:特効減少>"
  },
  State_59209_Desc = {
    Text = "与えるダメージ、治療、シールド効果が[DescArg1]%低下する。解除不可。"
  },
  State_59209_Name = {
    Text = "特効減少"
  },
  State_59423_Desc = {
    Text = "ライカーが敵を倒すと5つの黒章を獲得し、1%の黒章が落ちるたびに獲得量が1%増加。毎回の探索で最大5回まで有効。\n戦闘で50/125/250の黒章を獲得すると、遺物の上限が1増加し、戦闘終了時に「混沌の遺志」を選択して遺物リストに追加する。"
  },
  State_59423_Name = {
    Text = "勝者総取り"
  },
  State_59424_Desc = {
    Text = "探索中に黒章を1消費するたび、「オールイン」の基礎ダメージが0.5%増加。"
  },
  State_59424_Name = {
    Text = "確実な儲け話"
  },
  State_59439_Desc = {
    Text = "このステータスは軟化乗数を使用し、独立した乗数であるかのように装う。__「開発用」"
  },
  State_59439_Name = {
    Text = "特定の状態を持っている場合、受けるダメージが倍になる__「開発用」"
  },
  State_59519_Name = {
    Text = "山札か捨て札の山にある指令カードを1枚選択して手札に追加し、その行動力消費を0にする。"
  },
  State_59520_Desc = {
    Text = "使用後、カードを2枚引き、それらの行動力消費を刻印カードの行動力と同じだけ減少させる。各戦闘で1回のみ発動可能。"
  },
  State_59520_Name = {
    Text = "<WhiteQuality:知識の理>"
  },
  State_59521_Name = {
    Text = "現在のライフの10%を失う([DescArg1])"
  },
  State_59522_Desc = {
    Text = "使用後、この覚醒体以外の手札をすべて捨て、ランダムな非覚醒体カードを5枚獲得する。各戦闘で1回のみ発動可能。"
  },
  State_59522_Name = {
    Text = "<WhiteQuality:歓喜の理>"
  },
  State_59525_Name = {
    Text = "指令カードに対応する覚醒体が50狂気を獲得"
  },
  State_59526_Desc = {
    Text = "使用後、<RetainIconKeywords:保持>と<DepleteIconKeywords:除外>が付与された未強化コピーを3枚獲得する。各戦闘で1回のみ発動可能。"
  },
  State_59526_Name = {
    Text = "<WhiteQuality:繁殖の理>"
  },
  State_59534_Name = {
    Text = "このマークがある時、このカードは幻影を発動しない。__「開発用」"
  },
  State_59560_Name = {
    Text = "三大神子の刻印を受けたカードを1枚手札に追加"
  },
  State_59671_Desc = {
    Text = "このターン、すべての覚醒体の最終ダメージが15%増加。"
  },
  State_59671_Name = {
    Text = "超弦懐中時計"
  },
  State_59673_Name = {
    Text = "小さなオルゴール"
  },
  State_59678_Desc = {
    Text = "拾取時に他のすべてのつくりものを失い、ランダムに2つのゴールドクリエイションを獲得する。"
  },
  State_59878_Desc = {
    Text = "ターン終了時、追加で1層の「混沌」を減少させ、[StateArg1]<PowerIconKeywords:力量>を獲得。後続で召喚される「N」の分身のライフが200％増加し、死亡しても「N」の「混沌」層数を減少させず、<PowerIconKeywords:力量>を得ない。"
  },
  State_59878_Name = {
    Text = "混沌到来"
  },
  State_59991_Name = {
    Text = "このカードの使用時、最大5点の<EnergyStorageKeywords:蓄力>を消費する"
  },
  State_59993_Name = {
    Text = "失ったライフの10%を回復する([DescArg1])"
  },
  State_60000_Desc = {
    Text = "アクティブダメージを受けるたびに、一時的な<MadnessIconKeywords:発狂>を1スタック得る。"
  },
  State_60000_Name = {
    Text = "怒りを積む"
  },
  State_60028_Desc = {
    Text = "プレイヤーのターン開始時、ランダムに1枚の手札の行動力消費がこのターン中に3に変わる。このキャラクターの死亡時、この効果は無効となり、撃破した覚醒体のすべてのカードの行動力消費がこのターン1減少する。"
  },
  State_60028_Name = {
    Text = "錯乱の檻"
  },
  State_60044_Name = {
    Text = "[Layer]回使用後に除外"
  },
  State_60083_Desc = {
    Text = "このターンに受けるダメージが [Layer] ％低下する。"
  },
  State_60083_Name = {
    Text = "<ReinforceColour:堅固>"
  },
  State_60083_WeaponDesc = {
    Text = "与えるすべてのダメージが[DescArg1]%減少。"
  },
  State_60085_Desc = {
    Text = "戦闘開始時とターン開始時に一時的な堅固を獲得。プレイヤーのライフが高いほど多くの点数を獲得。最大50回。"
  },
  State_60085_Name = {
    Text = "究極の繭化"
  },
  State_60085_WeaponDesc = {
    Text = "すべてのダメージが [DescArg1] ％減少します。"
  },
  State_60086_Desc = {
    Text = "戦闘開始時とターン開始時に一時的な堅固を獲得。プレイヤーのライフが高いほど多くの点数を獲得。最大25回。"
  },
  State_60086_Name = {Text = "繭化"},
  State_60086_WeaponDesc = {
    Text = "すべてのダメージが [DescArg1] ％減少します。"
  },
  State_60087_Desc = {
    Text = "付与する重傷効果が、受けるライフ回復を[Layer]%減少させる効果に変わる。"
  },
  State_60087_Name = {
    Text = "<Rune_14_High:重傷化>"
  },
  State_60087_WeaponDesc = {
    Text = "与えるすべてのダメージが[DescArg1]%減少。"
  },
  State_60088_Desc = {
    Text = "1スタックごとに受ける全ダメージを1％減少させる。"
  },
  State_60088_Name = {
    Text = "<ReinforcePVEKeywords:堅固>"
  },
  State_60088_WeaponDesc = {
    Text = "獲得したすべてのシールドが 25 ％ 低下げます。"
  },
  State_60089_Desc = {
    Text = "受けるすべてのダメージが [Layer] ％低下する。"
  },
  State_60089_Name = {
    Text = "<ReinforceColour:堅固>"
  },
  State_60089_WeaponDesc = {
    Text = "与えるすべてのダメージが[DescArg1]%減少。"
  },
  State_60106_Desc = {
    Text = "ターン開始時、ランダムに1枚の手札の行動力消費が3に変わり、ターン終了時に元に戻る。"
  },
  State_60106_Name = {
    Text = "錯乱の檻"
  },
  State_60112_Desc = {
    Text = "このターン、指令カードを使用するたびにすべての覚醒体が1狂気を獲得。"
  },
  State_60112_Name = {Text = "協奏曲"},
  State_60115_Desc = {
    Text = "このターン、狂気解放を発動後、双子融合度が3%減少。"
  },
  State_60115_Name = {Text = "鎮魂歌"},
  State_60118_Desc = {
    Text = "このターン、与えるダメージ、毒、反撃が[Layer]%増加。"
  },
  State_60128_Desc = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_60128_WeaponDesc = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_60129_Desc = {
    Text = "次に使用する [Layer] 枚の非派生指令カードの行動力消費が-2。"
  },
  State_60129_Name = {
    Text = "下行音階"
  },
  State_60130_Desc = {
    Text = "次に使用する [Layer] 枚の非派生指令カードの行動力消費が+2、2回有効。"
  },
  State_60130_Name = {
    Text = "上行音階"
  },
  State_60148_Desc = {
    Text = "ターン終了時、状態に応じた効果を獲得。「放」：1点の一時的な<MadnessIconKeywords:発狂>。「収」：50点の一時的な<ReinforcePVEKeywords:堅固>。"
  },
  State_60148_Name = {
    Text = "変数の最適化"
  },
  State_60150_Desc = {
    Text = "プレイヤーがキーオーダーを使用するのを感知すると、即座に「放」と「収」の形態を切り替える。「放」に切り替えると、即座に[StateArg1]の一時的な「力」を獲得。「収」に切り替えると、即座に[StateArg2]の「シールド」を獲得。"
  },
  State_60150_Name = {
    Text = "機能感知"
  },
  State_60151_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_60151_Name = {Text = "未覚醒"},
  State_60154_Desc = {
    Text = "現在の形態-収。機械武装は「シールド」と「警戒」を獲得し、行動予測は防御が中心となる。"
  },
  State_60154_Name = {
    Text = "機械武装-収"
  },
  State_60155_Desc = {
    Text = "現在の形態-放。機械武装は「力」を獲得し、行動予測は攻撃が中心となる。"
  },
  State_60155_Name = {
    Text = "機械武装-放"
  },
  State_60167_Desc = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_60167_WeaponDesc = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_60184_Desc = {
    Text = "カードを使用するたび、「双生の矛盾」の行動予測は変化する。"
  },
  State_60187_Desc = {
    Text = "プレイヤーに与える倦怠、抑圧、重傷ステータスはすべて50%。"
  },
  State_60187_Name = {
    Text = "終わりは始まり"
  },
  State_60201_Name = {
    Text = "敵遅延力"
  },
  State_60263_Desc = {
    Text = "与える脆弱効果が、獲得するシールドを[Layer]％減少させる効果に変わる。"
  },
  State_60263_Name = {
    Text = "<Rune_14_High:抑圧化>"
  },
  State_60264_Desc = {
    Text = "付与する出血効果は、ターン終了時に自動的に50%のみ除去される。"
  },
  State_60264_Name = {
    Text = "<Rune_14_High:溶血>"
  },
  State_60265_Desc = {
    Text = "出血効果はターン終了時に50％のみ自動で除去される。__「開発用」"
  },
  State_60265_Name = {
    Text = "<BleedingColour: 溶血>__「開発用」"
  },
  State_60279_Name = {
    Text = "ターン終了後、このカードは除外される"
  },
  State_60284_Desc = {
    Text = "戦闘開始時とターン開始時に一時的な堅固を獲得。プレイヤーのライフが低いほど多くの点数を獲得。最大50回。"
  },
  State_60284_Name = {
    Text = "不破剣陣"
  },
  State_60284_WeaponDesc = {
    Text = "すべてのダメージが [DescArg1] ％減少します。"
  },
  State_60297_Desc = {
    Text = "「@2」 が解放の姿で現れ、ライフが元の3倍になる。そして毎ターン守秘者に質問を投げかけ、「タヴィに答える」カードを手札に追加。"
  },
  State_60297_Name = {
    Text = "真理の問答"
  },
  State_60297_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_60298_Desc = {
    Text = "未知の存在の力が昏き海の下にまだ潜んでいる。撃破される直前に完全に復活し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_60298_Name = {Text = "潜伏"},
  State_60312_Desc = {
    Text = "毎ターンライフの10%のダメージを受けると、[Layer]点の一時的な「堅固」を獲得。"
  },
  State_60312_Name = {
    Text = "融蝕の霧の盾"
  },
  State_60315_Desc = {
    Text = "このターン、狂気解放を発動後、失ったライフの5%([DescArg1])を回復。"
  },
  State_60315_Name = {Text = "鎮魂歌"},
  State_60336_Name = {
    Text = "使用後、1点の行動力を獲得し、カードを1枚引く。このカードは除外される。"
  },
  State_60339_Name = {
    Text = "このターンに使用後、1点の行動力を獲得し、カードを1枚引く。このカードは除外される。"
  },
  State_60367_Desc = {
    Text = "プレイヤーのターン開始時、ランダムに1枚の手札の行動力消費がこのターン中に3に変わる。このキャラクターの死亡時、この効果は無効となり、撃破した覚醒体のすべてのカードの行動力消費がこのターン1減少する。"
  },
  State_60367_Name = {
    Text = "錯乱の檻"
  },
  State_60386_Desc = {
    Text = "効果には以下が含まれる：ダメージの150%の出血を付与、ダメージの75%の毒を付与、1点の倦怠を付与、1点の軟化を付与、[DescArg1]点の力を一時的に減少させる。"
  },
  State_60386_Name = {
    Text = "<MysterydebuffKeywords:不思議なデバフ>"
  },
  State_60404_Desc = {
    Text = "1回のダメージを受けるごとに、2点の一時的な堅固を獲得。"
  },
  State_60404_Name = {
    Text = "終焉の変容"
  },
  State_60408_Desc = {
    Text = "ライフが33%に減るたび（あと [DescArg1] ）、そのターンはこれ以上ダメージを受けない。「鬼面の噛みつき」を発動。"
  },
  State_60408_Name = {
    Text = "鬼面の噛みつき"
  },
  State_60409_Desc = {
    Text = "ライフが66%に減るたび（あと [DescArg1] ）、そのターンはこれ以上ダメージを受けない。「終焉の変容」を発動。"
  },
  State_60409_Name = {
    Text = "終焉の鏡"
  },
  State_60429_Name = {
    Text = "状態@覚醒体ハムリン@原初の奏響"
  },
  State_60430_Desc = {
    Text = "使用時、実際の行動力消費と行動が一致するカードを除外し、すべての敵から[DescArg1]点の力を一時的に減少させる。"
  },
  State_60430_Name = {
    Text = "音符の律令"
  },
  State_60431_Name = {
    Text = "状態@覚醒体ハムリン@上行音階"
  },
  State_60432_Name = {
    Text = "状態@覚醒体ハムリン@魂の序曲"
  },
  State_60433_Name = {
    Text = "状態@覚醒体ハムリン@下行音階"
  },
  State_60434_Name = {
    Text = "状態@覚醒体ハムリン@追憶の輪舞曲"
  },
  State_60435_Name = {
    Text = "状態@覚醒体ハムリン@魂の序曲カウント"
  },
  State_60436_Desc = {
    Text = "ガードされなかったダメージを与えた時、[StateArg1] 枚の「傷口」を山札のランダムな位置に追加する。"
  },
  State_60436_Name = {
    Text = "魂の序曲"
  },
  State_60438_Name = {
    Text = "状態@覚醒体ハムリン@上行音階リスニング"
  },
  State_60439_Name = {
    Text = "状態@覚醒体ハムリン@下行音階リスニング"
  },
  State_60440_Name = {
    Text = "状態@覚醒体ハムリン@魂の序曲リスニング"
  },
  State_60441_Name = {
    Text = "状態@覚醒体ハムリン@追憶の輪舞曲リスニング"
  },
  State_60442_Name = {
    Text = "状態@覚醒体ハムリン@原初の奏響リスニング"
  },
  State_60486_Desc = {
    Text = "戦闘開始時、すべての覚醒体の狂気が半減する。"
  },
  State_60486_Name = {
    Text = "母神の吸収"
  },
  State_60487_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、最大ライフが200%増加し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_60487_Name = {Text = "未覚醒"},
  State_60490_Desc = {
    Text = "死亡後、すべての覚醒体が30狂気を得る。"
  },
  State_60490_Name = {
    Text = "生の欲望"
  },
  State_60491_Desc = {
    Text = "すべての覚醒体が与える狂気が50%減少する。"
  },
  State_60491_Name = {
    Text = "母樹の儀式"
  },
  State_60493_Desc = {
    Text = "ライフが累計[Layer]減少するごとに、擬態覚醒体を1体召喚する。戦場に2体いる場合、すべての擬態覚醒体の最大ライフが50%増加する。"
  },
  State_60493_Name = {
    Text = "母なる存在"
  },
  State_60500_Desc = {
    Text = "擬態覚醒体が存在する場合、自身が「隠れる」50点を獲得。"
  },
  State_60500_Name = {
    Text = "林に隠れる"
  },
  State_60511_Desc = {
    Text = "必ず初期手札に現れる。"
  },
  State_60511_WeaponDesc = {
    Text = "プレイ後、 カードは捨て札の山に入らず、 このバトルでは再び使用できません。"
  },
  State_60522_Desc = {
    Text = "与える抑圧と重傷効果が50%に増加する。"
  },
  State_60522_Name = {Text = "破滅"},
  State_60523_Desc = {
    Text = "1点につき攻撃回数+1。ダメージを受けると1点を失う。ターン終了時にすべて失う。"
  },
  State_60523_Name = {Text = "祈り"},
  State_60524_Desc = {
    Text = "戦闘開始時とターン開始時に[Layer]点の「堅固」を獲得。最大50回。"
  },
  State_60524_Name = {Text = "聖化"},
  State_60524_WeaponDesc = {
    Text = "すべてのダメージが [DescArg1] ％減少します。"
  },
  State_60527_Desc = {
    Text = "使用した後、除外されるが、敵の力を一時的に減少させる。"
  },
  State_60527_Name = {
    Text = "<CardKeyWord:メロディーヘブン>"
  },
  State_60543_Desc = {
    Text = "ターン終了時、10点の「血の誓い」を獲得。「血の誓い」はダメージを受けると1点解除。"
  },
  State_60543_Name = {
    Text = "灯心の火"
  },
  State_60554_Name = {
    Text = "<HuihuanbKeywords:循環楽音>"
  },
  State_60558_Name = {
    Text = "<HuihuanbKeywords:循環楽音>"
  },
  State_60562_Desc = {
    Text = "使用後、効果が2回発動し、「高揚楽音」に変化する"
  },
  State_60562_Name = {
    Text = "<HuihuanaKeywords:循環楽音>"
  },
  State_60564_Desc = {
    Text = "初めて敗北に直面した時、ライフが回復し行動予測は「終焉進化」に変化し、力と堅固を獲得。二度目の敗北に直面した時、ライフが回復し行動予測は「鬼面の噛みつき」に変化し、非常に高い単発ダメージを与える。"
  },
  State_60564_Name = {
    Text = "影の悪鬼"
  },
  State_60567_Desc = {
    Text = "使用後、ハムリンは3狂気を獲得。"
  },
  State_60567_Name = {
    Text = "<XushiAKeywords:高揚楽音>"
  },
  State_60568_Name = {
    Text = "<XushiAKeywords:高揚楽音>"
  },
  State_60569_Name = {
    Text = "<XushiBKeywords:高揚楽音>"
  },
  State_60570_Desc = {
    Text = "使用後、ハムリンは3狂気を獲得。"
  },
  State_60570_Name = {
    Text = "<XushiBKeywords:高揚楽音>"
  },
  State_60571_Name = {
    Text = "<HuihuanaKeywords:循環楽音>"
  },
  State_60576_Desc = {
    Text = "プレイヤーのターン開始時、ランダムに1枚の手札の行動力消費がこのターン中に3に変わる。このキャラクターの死亡時、この効果は無効となり、撃破した覚醒体のすべてのカードの行動力消費がこのターン1減少する。"
  },
  State_60576_Name = {
    Text = "錯乱の檻"
  },
  State_60578_Desc = {
    Text = "致命的なダメージを受けた時、ライフが50%回復し、1ターンの間ダメージを無効化し、行動予測は「羽化」に変化する。"
  },
  State_60578_Name = {Text = "羽化"},
  State_60592_Desc = {
    Text = "チームユニーク：探索開始時、「シルバーキーの暁光」を1枚ドロー山にシャッフルし<DestructionKeywords:破壊>を付与する。キーオーダー解放後、装備者のクリティカルダメージが <WeaponEffect_Num:[StateArg1]%> 上昇する。装備者がアクティブダメージを与えた時、装備者のキーチャージの <WeaponEffect_Num:[StateArg2]%> に相当するキーエネルギーと <WeaponEffect_Num:[StateArg3]%> の一時的なクリティカルレートを獲得し、1ターンに最大5回まで発動する。"
  },
  State_60592_WeaponDesc = {
    Text = "探索開始時、「シルバーキーの暁光」を1枚ドロー山にシャッフルし<DestructionKeywords:破壊>を付与する。キーオーダー解放後、装備者のクリティカルダメージが <WeaponEffect_Num:[StateArg1]%> 上昇する。装備者がアクティブダメージを与えた時、<WeaponEffect_Num:[DescArg1]> 点のキーエネルギーと <WeaponEffect_Num:[StateArg3]%> の一時的なクリティカルレートを獲得し、1ターンに最大5回まで発動する。"
  },
  State_60594_Desc = {
    Text = "チーム唯一：ターン終了後、装備者が5ポイントの狂気を獲得する。装備者が狂気爆発を発動後、このターンに出す次の装備者の指令カードのクリティカル率、クリティカルダメージ、シールド、HP回復が<WeaponEffect_Num:[StateArg1]％>増加する。"
  },
  State_60594_WeaponDesc = {
    Text = "ターン終了後、装備者が5ポイントの狂気を獲得する。装備者が狂気爆発を発動後、このターンに出す次の装備者の指令カードのクリティカル率、クリティカルダメージ、シールド、HP回復が<WeaponEffect_Num:[StateArg1]％>増加する。"
  },
  State_60898_Desc = {
    Text = "アクティブおよび触手ダメージを受けた時、覚醒体への攻撃の狂気解放とすべてのカードを1ターン封印し、<ResentChainsKeywords:怨恨の鎖>を1スタック除去する。"
  },
  State_60898_Name = {
    Text = "<ResentChainsKeywords1:怨恨の鎖>"
  },
  State_60925_Desc = {
    Text = "ターン終了時、失ったライフの5%を回復。プレイヤーが症状またはステータスカードを引くたびに、すべての味方が[Layer]点の力を獲得。"
  },
  State_60925_Name = {
    Text = "血の提灯"
  },
  State_60926_Desc = {
    Text = "ターン終了時、ライフが50%未満の場合、[Layer]点の力と[StateArg1]点のバリアを獲得。"
  },
  State_60926_Name = {
    Text = "提灯聖壇"
  },
  State_60953_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の前に、すべての敵に[StateArg1]層の<PVPSlowKeywords:遅緩>を与える。"
  },
  State_60953_Name = {
    Text = "永遠の鎮魂歌"
  },
  State_60962_Desc = {
    Text = "この戦闘中、最大ライフが[Layer]%増加。"
  },
  State_60962_Name = {
    Text = "ライフ増加"
  },
  State_60964_Desc = {
    Text = "この戦闘中、与えるダメージが[Layer]%増加。"
  },
  State_60964_Name = {
    Text = "ダメージ増加"
  },
  State_61038_Name = {
    Text = "ハムリンの試遊"
  },
  State_61050_Desc = {
    Text = "「楽音」効果が発動または「調和する響き」を使用した後、ハムリンのクリティカル率とクリティカルダメージが1%増加する(現在[DescArg1]%増加）。この効果が10回発動すると、この戦闘における「魂の序曲」と「元初の奏響」のダメージ回数が1回増加する。最大2回まで。"
  },
  State_61050_Name = {
    Text = "月下の狂想曲"
  },
  State_61051_Desc = {
    Text = "「楽音」効果が発動または「調和する響き」を使用した後、ハムリンのクリティカル率とクリティカルダメージが1%増加。10回発動するたび、この戦闘における「魂の序曲」と「元初の奏響」のダメージ回数が1回増加する。最大で2回まで。"
  },
  State_61051_Name = {
    Text = "月下の狂想曲"
  },
  State_61056_Desc = {
    Text = "初回ターンで100点の一時的な力を獲得する。"
  },
  State_61084_Desc = {
    Text = "本ターンに使用する次の[Layer]枚のカード：行動力消費が3以上なら2点の行動力を獲得。そうでなければカードを2枚引く。"
  },
  State_61084_Name = {
    Text = "第四楽章"
  },
  State_61085_Desc = {
    Text = "行動力消費-2。使用後、効果が2回発動し、「高揚楽音」に変化する"
  },
  State_61085_Name = {
    Text = "<HuihuanbKeywords:循環楽音>"
  },
  State_61089_Desc = {
    Text = "次に使用する指令カードが2回発動する。"
  },
  State_61089_Name = {
    Text = "指揮者のタクト"
  },
  State_61145_Name = {
    Text = "<BleedingColour:出血>"
  },
  State_61174_Desc = {
    Text = "シールドを得られない。"
  },
  State_61174_Name = {
    Text = "残党の葬送"
  },
  State_61180_Desc = {
    Text = "血ノ鎖・ヘロットの基礎ダメージは本戦闘中に[DescArg1]%増加。"
  },
  State_61180_Name = {
    Text = "復讐の刃"
  },
  State_61185_Desc = {
    Text = "敵のスキル効果を強化する。ダメージを受けると1点失う。"
  },
  State_61185_Name = {
    Text = "血の誓い"
  },
  State_62213_Desc = {
    Text = "与える虚弱効果が、与えるアクティブおよび触手ダメージを [Layer]% 低下させる効果に変わる。"
  },
  State_62213_Name = {
    Text = "<Rune_14_High:倦怠化>"
  },
  State_62309_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に[StateArg1]点の<StrongEffectKeywords:特効>を獲得。ライフを失うたび、現在のライフが[StateArg2]%未満の場合、<ReinforceKeywords:堅固>と<StrengthenKeywords:強化>を獲得。"
  },
  State_62309_Name = {
    Text = "深紅に沈む"
  },
  State_62317_Desc = {
    Text = "すべてのダメージを無効化し、ターン開始後に除去される。"
  },
  State_62317_Name = {
    Text = "ダメージ完全無効化"
  },
  State_62336_Desc = {
    Text = "3枚のカードを使用するたび（あと[Layer]枚）、1枚のカードを引き、手札の1枚の指令カードをランダムに凍結。"
  },
  State_62336_Name = {
    Text = "凛冬の寒気"
  },
  State_62337_Desc = {
    Text = "カードを3枚使用するたび（あと[Layer]枚）、カードを1枚引き、手札の指令カード1枚をランダムに凍結。"
  },
  State_62337_Name = {
    Text = "凛冬の寒気"
  },
  State_62338_Desc = {
    Text = "このカードは発動できず、ターン終了時に破棄されない。持ち主の覚醒体は5狂気を獲得。狂気解放を発動後、凍結を解除する。"
  },
  State_62338_Name = {
    Text = "<CardKeyWord:凍結>"
  },
  State_65332_Desc = {
    Text = "死亡後、すべての覚醒体が30狂気を得る。"
  },
  State_65332_Name = {Text = "消散"},
  State_65342_Desc = {
    Text = "撃破されると復活し、最大ライフが追加で100%増加、「凍てつく冷気」を発動する。"
  },
  State_65342_Name = {Text = "静寂"},
  State_65346_Desc = {
    Text = "死亡後、手札にある指令カード2枚を凍結する。"
  },
  State_65346_Name = {Text = "霜降り"},
  State_65358_Desc = {
    Text = "チーム唯一：装備者が与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。装備者が狂気解放を発動する前、臨時手札上限+1、装備者の指令カードを1枚ドローする。現在の界域が「血肉」の場合、装備者が捕食を発動した時、臨時クリティカルダメージが<WeaponEffect_Num:[StateArg1]%>増加する。毎ターン最大1回発動。"
  },
  State_65358_WeaponDesc = {
    Text = "装備者が与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。装備者が狂気解放を発動する前、臨時手札上限+1、装備者の指令カードを1枚ドローする。現在の界域が「血肉」の場合、装備者が捕食を発動した時、臨時クリティカルダメージが<WeaponEffect_Num:[StateArg1]%>増加する。毎ターン最大1回発動。"
  },
  State_65360_Desc = {
    Text = "チーム唯一：装備者が与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。戦闘開始時、装備者は25層の「氷雪」を獲得する。装備者がカードを使用した後、2点の狂気を獲得し1層を除去する。「氷雪」が完全に除去された後、装備者のクリティカル率が<WeaponEffect_Num:[StateArg2]%>増加する。"
  },
  State_65360_WeaponDesc = {
    Text = "装備者が与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。戦闘開始時、装備者は25層の「氷雪」を獲得する。装備者がカードを使用した後、2点の狂気を獲得し1層を除去する。「氷雪」が完全に除去された後、装備者のクリティカル率が<WeaponEffect_Num:[StateArg2]%>増加する（現在残り[DescArg1]層の氷雪）"
  },
  State_65362_Desc = {
    Text = "アクティブダメージを[StateArg1]回受けるたび(残り[Layer]回）、ランダムな指令カードを1枚凍結する。"
  },
  State_65362_Name = {Text = "霜返し"},
  State_65463_Name = {
    Text = "黒章を5獲得"
  },
  State_65490_Desc = {
    Text = "ターン終了時、[StateArg1]点のフロストシールドと[StateArg2]点の力を獲得。"
  },
  State_65490_Name = {
    Text = "絶対零度"
  },
  State_65497_Name = {
    Text = "血ノ鎖・ヘロットの試遊"
  },
  State_65553_Desc = {
    Text = "ターン終了時、残りの手札の数に応じて力を獲得。1枚につき[Layer]点。"
  },
  State_65553_Name = {Text = "氷の刃"},
  State_65557_Desc = {
    Text = "致命的なダメージを受けた時、行動予測は「真・深淵からの注視」に変化し、80点の一時的な「堅固」を獲得し、すべてのライフを回復し、自身のデバフとプレイヤーのバフを解除。ターン終了時、自身の20点の「堅固」を解除。"
  },
  State_65557_Name = {
    Text = "悠久の混沌"
  },
  State_65558_Desc = {
    Text = "致命的なダメージを受けた時、行動予測は「深淵からの注視」に変化し、80点の一時的な「堅固」を獲得し、すべてのライフを回復。[DescArg1]回発動可能。発動回数が尽きた後、致命的なダメージを受けるとライフが1残り、行動予測は「無数の世界の目」に変化する。ターン終了時、自身の20点の「堅固」を解除。"
  },
  State_65559_Desc = {
    Text = "全滅後、トオワボは再び現れる。"
  },
  State_65559_Name = {
    Text = "悠久の欠片"
  },
  State_65564_Name = {
    Text = "\n<D05EX_Relic:調査隊員たちのヘロットへの疑念は深まる一方だ。敵が迫る前に、混乱した隊員に対処する必要がある>"
  },
  State_65565_Name = {
    Text = "\n<D05EX_Relic:調査隊員の疑念を無視して進む。>"
  },
  State_65566_Name = {
    Text = "\n<D05EX_Relic:調査団員に状況を説明する。>"
  },
  State_65567_Name = {
    Text = "\n<D05EX_Relic:ヘロットを拘束し、調査隊員を保護する。>"
  },
  State_65568_Name = {
    Text = "\n<D05EX_Relic:ヘロットを拘束し、覚醒体の力で調査隊員を守り抜く。>"
  },
  State_65585_Desc = {
    Text = "使用後、手札に戻る。ターン終了まで刻印無効。"
  },
  State_65585_Name = {
    Text = "<CardKeyWord:残響>"
  },
  State_66305_Desc = {
    Text = "ターン終了時、一時的な<ResentChainsKeywords:怨恨の鎖>を1層獲得する。"
  },
  State_66305_Name = {
    Text = "古今を貫く鎖"
  },
  State_66306_Desc = {
    Text = "アクティブおよび触手ダメージを受けた時、覚醒体への攻撃の狂気解放とすべてのカードを1ターン封印し、<ResentChainsKeywords:怨恨の鎖>を1スタック除去する。"
  },
  State_66306_Name = {
    Text = "<ResentChainsKeywords1:怨恨の鎖>"
  },
  State_66308_Desc = {
    Text = "致命的なダメージを受けた後、ライフを1に固定。"
  },
  State_66308_Name = {
    Text = "悠久の混沌"
  },
  State_66311_Desc = {
    Text = "覚醒体たちの記憶が君の脳の端から溢れ出し、脳内に根付き、成長する。何度切り断こうとも、何度融蝕しようとも、彼らは決して離れなかった。"
  },
  State_66311_Name = {
    Text = "破砕された記憶"
  },
  State_66313_Desc = {
    Text = "1枚の指令カードを使用するごとに、該当覚醒体の行動力消費が最も少ないカードを1枚捨てます。"
  },
  State_66313_Name = {
    Text = "至高の意志の威圧"
  },
  State_66314_Desc = {
    Text = "すべてのダメージを無効化する。"
  },
  State_66314_Name = {
    Text = "ダメージ完全無効化"
  },
  State_66317_Desc = {
    Text = "「覚醒体たちの記憶があなたの脳の端から溢れ出し、あなたの脳に根付き、育つ。あなたがそれらを何度斬り捨てても、融蝕がそれらを何度ひっくり返しても、彼らは一度も離れたことはない。毎回のターン開始時に 1点の行動力上限と 2 枚の手札の上限を回復」"
  },
  State_66317_Name = {
    Text = "記憶の破片"
  },
  State_66325_Desc = {
    Text = "「覚醒体たちの記憶があなたの脳の端から溢れ出し、あなたの脳に根付き、育つ。あなたがそれらを何度斬り捨てても、融蝕がそれらを何度ひっくり返しても、彼らは一度も離れたことはない。毎回のターン開始時に 1点の行動力上限と 2 枚の手札の上限を回復」"
  },
  State_66325_Name = {
    Text = "記憶の破片"
  },
  State_66358_Desc = {
    Text = "探索中に初めて死亡抵抗を発動した時、<DerivativeCardKeywords_39:「過去の響き」>を手札に追加。"
  },
  State_66358_Name = {
    Text = "存在しない存在"
  },
  State_66359_Desc = {
    Text = "ランダムに複数の選択肢を生成し、その中から選択する。"
  },
  State_66359_Name = {
    Text = "<FaxianKeywords:発見>"
  },
  State_66360_Desc = {
    Text = "この戦闘内でクリティカル率が[Layer]％増加。"
  },
  State_66360_Name = {
    Text = "クリティカル率"
  },
  State_66362_Desc = {
    Text = "この戦闘内でクリティカルダメージが[Layer] %増加。"
  },
  State_66362_Name = {
    Text = "クリティカルダメージ"
  },
  State_66409_Name = {
    Text = "代行者の裁き"
  },
  State_66410_Desc = {
    Text = "「[DescArg1] を下したタヴィの指令カードが 2 回発動」"
  },
  State_66410_Name = {
    Text = "万物は一つに"
  },
  State_66414_Desc = {
    Text = "手札にある場合、山札の一番上のカードが指令カードであれば、そのコピーに変わります。"
  },
  State_66414_Name = {
    Text = "万物の理を知る"
  },
  State_66454_Desc = {
    Text = "スキルカードの行動力消費が「隠匿」の点数分、減少する。最大5点まで累積可能。ダメージを受けるかスキルを使用した後、1点除去される。"
  },
  State_66454_Name = {Text = "隠匿"},
  State_66456_Desc = {
    Text = "スキルカードの行動力消費が「隠匿」の点数分、減少する。最大5点まで累積可能。ダメージを受けるかスキルを使用した後、1点除去される。"
  },
  State_66456_Name = {
    Text = "<YinniColour:隠匿>"
  },
  State_66465_Desc = {
    Text = "狂気解放の使用後、対応する点数のダメージを受ける。"
  },
  State_66465_Name = {
    Text = "<PVPfengsuoColour:狂気封印>"
  },
  State_66522_Desc = {
    Text = "使用するたびに8枚目のカードが2回発動します。"
  },
  State_66522_Name = {
    Text = "星々の酒"
  },
  State_66553_Desc = {
    Text = "「攻撃」と「防御」を使用すると、対応する覚醒体が35狂気を獲得。ただし行動力消費+1。"
  },
  State_66553_Name = {
    Text = "欠けた顔"
  },
  State_66554_Desc = {
    Text = "獲得時、1枚の<DerivativeCardKeywords_1:「影の残響」>を手札に追加。"
  },
  State_66554_Name = {Text = "通信機"},
  State_66555_Desc = {
    Text = "最大行動力が1増加。"
  },
  State_66556_Desc = {
    Text = "同一覚醒体のカードを連続で使う度、その覚醒体は8狂気を獲得。"
  },
  State_66556_Name = {
    Text = "精密タイマー"
  },
  State_66557_Desc = {
    Text = "ライフを失うたびに[DescArg1]の<PowerIconKeywords:力>を獲得、戦闘毎に10回まで。スタック最大時、失ったライフ値の25%を回復。"
  },
  State_66557_Name = {
    Text = "無上の栄誉"
  },
  State_66558_Desc = {
    Text = "3ターンごとにすべての敵に1回<WeaknessIconKeywords:倦怠>を付与。「虚弱」敵にダメージを与えると、一時的に[DescArg1]の<PowerIconKeywords:力>を獲得、1ターンに3回まで。"
  },
  State_66558_Name = {Text = "悪童"},
  State_66559_Desc = {
    Text = "行動力消費が3以上のカードを1枚使用した時、カードを1枚引き、1点の行動力を獲得する。"
  },
  State_66559_Name = {
    Text = "失われた美"
  },
  State_66560_Desc = {
    Text = "「攻撃」は行2点の動力を獲得し、ランダムにカードを1枚捨てる。「防御」はカードを2枚引き、1点の行動力を失う。毎ターン最大3回まで発動する。"
  },
  State_66560_Name = {
    Text = "ハッピーレコード"
  },
  State_66561_Desc = {
    Text = "3ターン毎にすべての敵に1回<VulnerabilityIconKeywords:軟化>を付与。<VulnerabilityIconKeywords:軟化>の敵にダメージを与える度、一時的に[DescArg1]の<PowerIconKeywords:力>を失わせる。各ターンで最大3回発動。"
  },
  State_66561_Name = {
    Text = "春の祭り"
  },
  State_66562_Desc = {
    Text = "4ターンごとにすべての敵の受けるダメージが倍増するが、そのターンに狂気解放を使うと、すべての覚醒体が1ターン封印される。"
  },
  State_66562_Name = {
    Text = "行道の骸"
  },
  State_66563_Desc = {
    Text = "ターン開始時、前のターンにカードを3枚以上使用していた場合、カードを2枚引く。"
  },
  State_66563_Name = {
    Text = "新品の財布"
  },
  State_66564_Desc = {
    Text = "入手時、3点の行動力を獲得。"
  },
  State_66564_Name = {
    Text = "懐中時計の鏡"
  },
  State_66565_Desc = {
    Text = "獲得時、すべての敵に1ターンの<WeaknessIconKeywords:倦怠>と<VulnerabilityIconKeywords:軟化>を付与する。"
  },
  State_66565_Name = {
    Text = "変色拘束服"
  },
  State_66566_Desc = {
    Text = "各ターン開始時に<DeathResistanceIconKeywords:死亡抵抗>が10%増加（このステージで1回死亡抵抗が発動するたびに増加率が半減）。<DeathResistanceIconKeywords:死亡抵抗>が100%を超えると、<ProficientInRealmsIconKeywords:界域知識>100増加。"
  },
  State_66566_Name = {
    Text = "人魚の涙"
  },
  State_66703_Desc = {
    Text = "チーム唯一：キーエネルギー蓄積上限が100%増加する。手札上限+2、他の運命の札が提供する手札上限とは累積しない。装備者のキーチャージが<WeaponEffect_Num:[StateArg1]%>増加する。装備者がカードを使用した後、このターン装備者の指令カードのクリティカル率とクリティカルダメージ、与えるシールド、狂気と力の獲得効果が<WeaponEffect_Num:[StateArg2]%>増加する。最大5層まで累積。"
  },
  State_66703_WeaponDesc = {
    Text = "シルバーキーの蓄積上限が100%増加。手札の上限を2枚増加し、この効果は他の運命の札による効果と重複しない。装備者のキーチャージが<WeaponEffect_Num:[DescArg2]>増加。装備者がカードを使用すると、このターン中、装備者の指令カードのクリティカル率とクリティカルダメージ、シールド、狂気、力が <WeaponEffect_Num:[StateArg2]%>増加、この効果は5回まで発動。（現在 [DescArg1]回）"
  },
  State_66722_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時およびターン開始時、自身が<PVPProtectiveKeywords:バリア>を持っていない場合は[StateArg1]層の<PVPProtectiveKeywords:バリア>を獲得し、そうでない場合は<StrengthenKeywords:強化>を獲得する。"
  },
  State_66722_Name = {
    Text = "隠世の転輪"
  },
  State_66872_Desc = {
    Text = "タヴィによって与えられるダメージ、シールド、ライフ回復量が一時的に[StateArg1]%増加し、[Layer]ターン持続する。"
  },
  State_66872_Name = {
    Text = "無限の輝き"
  },
  State_66884_Desc = {
    Text = "ターン終了時、行動力消費が1点減少。捨てられた時もこの効果は発動。"
  },
  State_66884_Name = {
    Text = "<PrepareKeypvewords:準備1>"
  },
  State_66888_Desc = {
    Text = "チーム唯一：キーオーダーを発動した後、装備者の攻撃力の<WeaponEffect_Num:[StateArg1]%>に相当する<PowerIconKeywords:力量>と防御力の<WeaponEffect_Num:[StateArg2]%>に相当するシールドを獲得する。応急霊知体を使用した後、ターン終了時にすべての覚醒体が<WeaponEffect_Num:[StateArg3]>点の狂気を獲得する。"
  },
  State_66888_Name = {
    Text = "純銀の初心"
  },
  State_66888_WeaponDesc = {
    Text = "キーオーダーを発動した後、<WeaponEffect_Num:[Power:DescArg1]>点の<PowerIconKeywords:力量>と<WeaponEffect_Num:[Block:DescArg2]>点のシールドを獲得する。応急霊知体を使用した後、ターン終了時にすべての覚醒体が<WeaponEffect_Num:[StateArg3]>点の狂気を獲得する。"
  },
  State_66893_Desc = {
    Text = "チーム唯一：戦闘開始後、装備者のキーチャージの<WeaponEffect_Num:[StateArg1]%>分のキーエネルギーを獲得する。各戦闘で初めてキーオーダーを発動した後、この効果を1回繰り返す。"
  },
  State_66893_WeaponDesc = {
    Text = "戦闘開始後、装備者の<WeaponEffect_Num:[StateArg1]%>キーチャージ分のキーエネルギーを獲得する。各戦闘で初めてキーオーダーを発動した後、この効果を1回繰り返す。"
  },
  State_66896_WeaponDesc = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_66900_Desc = {
    Text = "このカードのダメージ、治癒、シールドが[StateArg1]%上昇"
  },
  State_66900_Name = {
    Text = "純銀の初心"
  },
  State_66901_Desc = {
    Text = "与えるダメージ、治療、シールド効果が[DescArg1]%増加する。1ターン持続。"
  },
  State_66901_Name = {
    Text = "一時的な特効"
  },
  State_66902_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：他の味方の覚醒体が死亡した後、<Block:[Block:StateArg1]>点のシールドを獲得し、その行動力消費が最も低い「スキル」を手札に追加する。"
  },
  State_66902_Name = {
    Text = "純銀の初心"
  },
  State_66971_Desc = {
    Text = "ライフが0になった時、ライフは1に戻り、ダメージを受けない。"
  },
  State_66971_Name = {
    Text = "世界断絶"
  },
  State_67234_Desc = {
    Text = "ターン終了時、「天才の脳缶の分体」1体を召喚、持続[Layer]ターン。"
  },
  State_67234_Name = {Text = "分離"},
  State_67235_Desc = {
    Text = "死亡時全ライフ回復、最大ライフ+100%、「魂瘟疫」発動。"
  },
  State_67235_Name = {Text = "未覚醒"},
  State_67237_Desc = {
    Text = "10点に達すると、行動予測が「虚無終結」に変わる。「虚無終結」：相手のライフ上限を1にする。"
  },
  State_67237_Name = {Text = "終末"},
  State_67238_Desc = {
    Text = "ターン終了時、1点の「終末」を獲得。致命的なダメージを受けた場合、この状態を解除して1ターン間ダメージを無効化し、ライフを15%回復、10点の「終末」を獲得する。"
  },
  State_67238_Name = {
    Text = "魂の疫病"
  },
  State_67240_Desc = {
    Text = "「才媛剣士」は25回の一時的な<ReinforcePVEKeywords:堅固>と[Power:StateArg1]点の一時的な<PowerIconKeywords:力>を獲得し、この状態を解除。"
  },
  State_67241_Desc = {
    Text = "死亡時すべてのライフを回復、ライフ上限+100%、リリース「騎士の熱意」"
  },
  State_67241_Name = {Text = "未覚醒"},
  State_67242_Desc = {
    Text = "死亡時全ライフ回復、最大ライフ+100%、「魂肉@1分」発動。"
  },
  State_67242_Name = {Text = "未覚醒"},
  State_67243_Desc = {
    Text = "ターン終了時、「天才の脳缶の分体」1体を召喚。「天才の脳缶の分体」が「知性の分離」を発動すると、プレイヤーの力5%を追加で奪う。"
  },
  State_67243_Name = {
    Text = "霊肉@1分"
  },
  State_67245_Desc = {
    Text = "ターン終了時、[StateArg1]点の<PowerIconKeywords:力>を獲得。"
  },
  State_67245_Name = {
    Text = "騎士の熱意"
  },
  State_67246_Desc = {
    Text = "毎ターン初めてシールドが破壊された時、最大ライフの25%を失い、[Power:DescArg1]点の<PowerIconKeywords:一時的な力>と[Layer]点の一時的な堅固を獲得する。次のターン開始時、再度<Block:[Block:DescArg2]>点のシールドを獲得し、「騎士の信仰」を1回発動するごとに、追加でシールドを1回獲得する。"
  },
  State_67246_Name = {
    Text = "騎士の信仰"
  },
  State_67247_Desc = {
    Text = "毎ターン終了時に敵が補充され、同時に最大2体の敵が存在する。敵が死亡した後、「腐敗した脳」は最大ライフの5%を失う。"
  },
  State_67247_Name = {
    Text = "深淵の門"
  },
  State_67252_Desc = {
    Text = "致命的ダメージを受けた時、後列に移動しライフ1を保ち、その後はいかなるダメージも受けない。<PowerIconKeywords:力>が[DescArg1]増加。自爆ではこの効果は発動しない。"
  },
  State_67252_Name = {
    Text = "霊質分離"
  },
  State_67253_Desc = {
    Text = "[Layer] 枚のカードを使用すると、前方に「天才の脳缶の分体」を1体生成。最大3体まで同時に存在可能。"
  },
  State_67253_Name = {
    Text = "天才の脳缶"
  },
  State_67255_Desc = {
    Text = "死亡時全ライフ回復、最大ライフ+100%、「第一哲学」発動。"
  },
  State_67255_Name = {Text = "未覚醒"},
  State_67256_Desc = {
    Text = "ドローフェイズ終了後、手札からランダムに3枚の指令カードを公開し、1枚を選んで「エコー」の刻印を付与し、他のカードを捨てる。"
  },
  State_67257_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、すべての覚醒体が10の狂気を獲得。が、キーオーダーの消費が永久に10%増加する。"
  },
  State_67257_Name = {
    Text = "次第に断裂するリンク"
  },
  State_67258_Desc = {
    Text = "戦闘開始時、<Block:[Block:DescArg1]>回のシールドを獲得。ターン終了時、シールドは消えない。"
  },
  State_67258_Name = {
    Text = "騎士の決意"
  },
  State_67347_Desc = {
    Text = "手札にある場合、山札の一番上のカードが指令カードであれば、その行動力消費が-1のコピーに変わります。"
  },
  State_67347_Name = {
    Text = "万物の理を知る"
  },
  State_67353_Desc = {
    Text = "死亡後、「腐敗した脳」は最大ライフの5%を失います。"
  },
  State_67353_Name = {Text = "溶解"},
  State_67358_Desc = {
    Text = "プレイヤーが1点の行動力を消費するたび、<Block:[Block:StateArg1]>点のシールドと3点の一時的な堅固を獲得する。"
  },
  State_67358_Name = {
    Text = "不定の壁"
  },
  State_67414_Desc = {
    Text = "直視できない眼差し。逆らえぬ気配。すべての破片が破片でしかない。さあ、運命的な破滅の結末を迎えよ"
  },
  State_67414_Name = {
    Text = "無数の真貌に直面する"
  },
  State_67418_Desc = {
    Text = "使用後、この覚醒体以外の手札をすべて捨て、ランダムな非覚醒体カードを5枚獲得する。各戦闘で1回のみ発動可能。"
  },
  State_67418_Name = {
    Text = "<WhiteQuality:上位歓喜の理>"
  },
  State_67419_Desc = {
    Text = "使用後、<RetainIconKeywords:保持>と<DepleteIconKeywords:除外>が付与された未強化コピーを3枚獲得し、それらの行動力消費-1。各戦闘で1回のみ発動可能。"
  },
  State_67419_Name = {
    Text = "<WhiteQuality:上位繁殖の理>"
  },
  State_67420_Desc = {
    Text = "使用後、カードを4枚引き、それらの行動力消費を刻印カードの行動力と同じだけ減少させる。各戦闘で1回のみ発動可能。"
  },
  State_67420_Name = {
    Text = "<WhiteQuality:上位知識の理>"
  },
  State_67598_Desc = {
    Text = "狂気解放を放った後、対応する覚醒体のランダムなカードを1枚手札に追加する。そのカードは<DepleteIconKeywords:除外>および<NothingnessIconKeywords:虚無>を獲得。戦闘が終了した後、[DescArg1] のライフを回復する。"
  },
  State_67598_Name = {
    Text = "医者のカバン"
  },
  State_67599_Desc = {
    Text = "「攻撃」「防御」以外の指令カードを使用すると、対応する覚醒体が15の狂気を獲得。1ターンに最大5回まで発動可能。毎ターン1回目の発動時には、使用したカードが手札に戻る。"
  },
  State_67599_Name = {
    Text = "時の振り子・投影"
  },
  State_67600_Desc = {
    Text = "最大行動力が4増加。デッキをリセットするたび、4枚の<DerivativeCardKeywords_4:「啓示」>を山札に追加。"
  },
  State_67600_Name = {
    Text = "祝福・黒い蝋燭"
  },
  State_67602_Name = {Text = "廃棄"},
  State_67603_Desc = {
    Text = "デバフ状態の敵に与えるダメージが20%増加し、敵を倒すと倒した者が20狂気を獲得。"
  },
  State_67603_Name = {
    Text = "祭司の杖"
  },
  State_67604_Desc = {
    Text = "前のカードと覚醒体が異なる指令カードを1枚使用するたび、その覚醒体は3狂気を獲得し、「活性」を1点蓄積する。10点蓄積した時、すべての「活性」をクリアし、すべての覚醒体の、行動力消費が1減少し<DepleteIconKeywords:除外>を持つランダムな指令カードをそれぞれ1枚手札に追加する。1ターンに1回のみ有効。"
  },
  State_67604_Name = {
    Text = "時の振り子・衍化"
  },
  State_67605_Desc = {
    Text = "シールドを持っているとき、その遺物は[DescArg1]の一時的な<PowerIconKeywords:力>を獲得する。シールドが現在のライフを上回ると、[DescArg2]の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  State_67605_Name = {
    Text = "鳩の羽扇"
  },
  State_67606_Desc = {
    Text = "ターン開始時、敵1体につき1点の行動力を獲得。アクティブダメージで敵を倒すと、他の敵に過剰ダメージに等しい<BleedingIconKeywords:出血>を付与。"
  },
  State_67606_Name = {
    Text = "群衆の歌"
  },
  State_67607_Desc = {
    Text = "5回の狂気解放を発動するごとに、狂気解放を発動した覚醒体に100の狂気を付与。"
  },
  State_67607_Name = {
    Text = "小さな産着"
  },
  State_67608_Name = {Text = "廃棄"},
  State_67609_Desc = {
    Text = "狂気解放を放った後、現在のライフの8%を失い、すべての敵から [DescArg1] の一時的な<PowerIconKeywords:力>を略奪し、敵が1名だけの場合は [DescArg2] の一時的な<PowerIconKeywords:力>を略奪する。"
  },
  State_67609_Name = {
    Text = "不運の儀式鳥"
  },
  State_67611_Desc = {
    Text = "2ターンごとにすべての敵の受けるダメージが倍増し、そのターンに狂気解放を1回使うと、ランダムで1つのデバフを解除する。"
  },
  State_67611_Name = {
    Text = "祝福・行道の骸"
  },
  State_67612_Desc = {
    Text = "すべての「攻撃」によるクリティカルダメージが20%増加。獲得時に、1枚の<DerivativeCardKeywords_40:「美しい瞬間」>を手札に追加。"
  },
  State_67612_Name = {
    Text = "美しい瞬間β"
  },
  State_67614_Desc = {
    Text = "毎ターン開始時にすべての覚醒体が25の狂気を獲得。獲得時、最大ライフが1.5倍になる。"
  },
  State_67614_Name = {
    Text = "祝福・悪夢の表象β"
  },
  State_67615_Desc = {
    Text = "6枚目の指令カードを使用するたび、それを捨て札から手札に戻す。"
  },
  State_67615_Name = {
    Text = "黄昏の中で"
  },
  State_67616_Name = {Text = "廃棄"},
  State_67618_Desc = {
    Text = "毎ターン開始時、すべての覚醒体が25狂気を獲得。拾得時、最大ライフが1.5倍になる。"
  },
  State_67619_Desc = {
    Text = "手札上限が5増加し、獲得時に手札を上限まで補充する。ターン開始時に追加でカードを1枚引く。ターン終了時、手札のすべての「症状」カードと「ステータス」カードを捨て、その他のカードに「保持」を付与する。"
  },
  State_67619_Name = {
    Text = "祝福・意識の刻印β"
  },
  State_67620_Desc = {
    Text = "各ターンで3枚目のカードを使用すると<DerivativeCardKeywords_4:「啓示」>を捨て札に追加。6枚目のカードを使用すると、捨て札から1枚の<DerivativeCardKeywords_4:「啓示」>を手札に追加。"
  },
  State_67620_Name = {
    Text = "文明の光"
  },
  State_67621_Desc = {
    Text = "狂気解放を放った後、[DescArg1] の一時的な力量を獲得し、すべての敵から[DescArg1] の一時的な<PowerIconKeywords:力>を略奪する。敵が1名だけの場合は、[DescArg2] の一時的な<PowerIconKeywords:力>を略奪する。"
  },
  State_67621_Name = {
    Text = "祝福・不運の儀式鳥"
  },
  State_67622_Desc = {
    Text = "最後の1の行動力を使い果たすと、2点の行動力を獲得。1ターンに最大2回まで発動。"
  },
  State_67622_Name = {
    Text = "銀白の演算器"
  },
  State_67623_Desc = {
    Text = "取得後、恒久的に[DescArg1] <PowerIconKeywords:力>を獲得。ダメージを与えるたびに[DescArg2]のライフを回復し、1ターンに最大6回発動する。"
  },
  State_67623_Name = {
    Text = "祝福・ヤツメウナギのキス"
  },
  State_67624_Name = {Text = "廃棄"},
  State_67625_Desc = {
    Text = "毎ターン初めて指令カードを捨て札に追加すると、そのカードの行動力消費を1減少した一時的なコピーを生成し、山札のランダムな位置に追加する。"
  },
  State_67625_Name = {
    Text = "声を失った蓄音機"
  },
  State_67626_Desc = {
    Text = "最大行動力が1増加。連続して2回、前のカードより行動力消費が高いカードを使用すると、1点の行動力を獲得。"
  },
  State_67626_Name = {
    Text = "アルカナ記録"
  },
  State_67628_Name = {Text = "廃棄"},
  State_67630_Name = {Text = "廃棄"},
  State_67631_Desc = {
    Text = "最大行動力が2増加。デッキをリセットするたび、1枚の<DerivativeCardKeywords_9:「よろよろ」>を山札に追加。"
  },
  State_67631_Name = {
    Text = "黒い蝋燭"
  },
  State_67632_Name = {Text = "廃棄"},
  State_67634_Desc = {
    Text = "ターン終了時に手札に残ったカード1枚につき、すべての覚醒体が狂気を2獲得。"
  },
  State_67634_Name = {
    Text = "不均衡な天秤"
  },
  State_67635_Desc = {
    Text = "獲得時、すべての覚醒体に50の狂気を与え、2枚の<DerivativeCardKeywords_1:「影の残響」>を山札のランダムな位置に追加する。"
  },
  State_67635_Name = {
    Text = "通信機+β"
  },
  State_67636_Desc = {
    Text = "クリティカルダメージ15%アップ。シールドを持つ敵に対するダメージは必ずクリティカル。"
  },
  State_67636_Name = {
    Text = "美学の原理"
  },
  State_67637_Desc = {
    Text = "ターン開始時に2枚カードを引き、2点の行動力を獲得。指令カードや霊知覚醒を引いた時、ランダムにその行動力消費が変わる（0-4）"
  },
  State_67637_Name = {
    Text = "奇術のハット"
  },
  State_67638_Desc = {
    Text = "デバフ状態の敵に対するダメージが50%増加し、敵を倒すと倒した者が100狂気を獲得。"
  },
  State_67638_Name = {
    Text = "祭司の杖+"
  },
  State_67639_Desc = {
    Text = "クリティカル率が50%増加し、クリティカルダメージが100%増加する。"
  },
  State_67639_Name = {
    Text = "祝福・奇異な鉤爪"
  },
  State_67640_Desc = {
    Text = "クリティカル率、クリティカルダメージが100%増加する。ダメージ/触腕ダメージを1回与えるたび、このターンすべての覚醒体のクリティカル率とクリティカルダメージが10%減少する。最大50%減少。与える毒と反撃が10%増加する。最大50%増加。"
  },
  State_67640_Name = {
    Text = "時の振り子・移流"
  },
  State_67641_Desc = {
    Text = "狂気解放を放った後、[DescArg1] の一時的な<PowerIconKeywords:力>を獲得。"
  },
  State_67641_Name = {Text = "重鎖"},
  State_67643_Desc = {
    Text = "アクティブダメージを与える際、[DescArg1] シールドを獲得。ライフを回復する時、[DescArg2] の一時的な<PowerIconKeywords:力>を獲得。"
  },
  State_67643_Name = {Text = "我が家"},
  State_67645_Desc = {
    Text = "クリティカル率が10%増加する。毎ターン初めてクリティカル発生後、クリティカル率が追加で20%増加し、毎ターン3回目のクリティカル発生後、クリティカルダメージが追加で50%増加する。"
  },
  State_67645_Name = {
    Text = "祝祭の祝福"
  },
  State_67646_Desc = {
    Text = "奇数ターン終了時、行動力が残っている場合、次のターン追加でカードを2枚引く。偶数ターン終了時、手札が残っている場合、次のターン追加で2点の行動力を獲得。"
  },
  State_67646_Name = {
    Text = "日月ルーレット"
  },
  State_67647_Desc = {
    Text = "5枚目の指令カードは効果が2回発動し、使用後、手札に戻る。"
  },
  State_67647_Name = {
    Text = "星々の酒+"
  },
  State_67649_Desc = {
    Text = "敵の行動予測を隠す。毎ターン1点の行動力を獲得し、カードを1枚引く。"
  },
  State_67649_Name = {
    Text = "惑わし風鈴"
  },
  State_67650_Desc = {
    Text = "「攻撃」と「防御」で追加50のキーエネルギーを獲得。行動力消費が2以上のカードを使用するたびに、行動力消費が1のカードを1枚引き、その行動力消費を0にする。1ターンに最大3回まで。"
  },
  State_67650_Name = {
    Text = "時の振り子・双生"
  },
  State_67651_Desc = {
    Text = "獲得時、チームの界域知識が元の150%になる。1ターンに5枚目の指令カードを使用すると、すべての覚醒体が20の狂気を獲得。"
  },
  State_67651_Name = {
    Text = "時の振り子・不潔"
  },
  State_67653_Desc = {
    Text = "毎ターン狂気解放を2回発動した後、すべての覚醒体が8の狂気を獲得。3回発動した後、すべての覚醒体が8の狂気を獲得。"
  },
  State_67653_Name = {
    Text = "忘れられし者の血"
  },
  State_67654_Name = {
    Text = "追加で [DescArg1] 回発動"
  },
  State_67656_Desc = {
    Text = "クリティカル率が50%増加し、自身は3ターン<FragileIconKeywords:抑圧>。"
  },
  State_67656_Name = {
    Text = "奇異な鉤爪"
  },
  State_67657_Desc = {
    Text = "ターン開始時にカードを1枚引く。同じ行動力消費のカードを連続で2回使用すると、追加でカードを1枚引くが、1ラウンドにつき最大3回まで。"
  },
  State_67657_Name = {
    Text = "万象霊知の秘儀"
  },
  State_67658_Desc = {
    Text = "行動力消費が3のカードを1枚使用した時、カードを1枚引き、2点の行動力を獲得する。\n行動力消費が4以上のカードを1枚使用した時、他の手札の行動力消費が1減少する。"
  },
  State_67658_Name = {
    Text = "時の振り子・眼"
  },
  State_67659_Desc = {
    Text = "ターン開始時、敵1体につき2点の行動力を獲得。アクティブダメージで敵を倒すと、他の敵に過剰ダメージの2倍の<BleedingIconKeywords:出血>を付与。"
  },
  State_67659_Name = {
    Text = "群衆の歌+"
  },
  State_67660_Desc = {
    Text = "「攻撃」を3回使用するごとに、すべての敵に[DescArg1]ダメージを与え、対応する覚醒体に15の狂気を獲得する。"
  },
  State_67660_Name = {
    Text = "錆びた柳葉刀"
  },
  State_67661_Desc = {
    Text = "行動力を消費するたびに、カードを1枚引く。1ターンに最大5回まで有効。デッキがリセットされるたびに、2点の行動力を獲得する。"
  },
  State_67661_Name = {
    Text = "時の振り子・不眠"
  },
  State_67662_Desc = {
    Text = "非覚醒体のカードを使用するたびに、狂気が最も低い覚醒体が10狂気を獲得。"
  },
  State_67662_Name = {
    Text = "異国の切手帳"
  },
  State_67665_Desc = {
    Text = "最大行動力が2増加する。「攻撃」または「防御」使用後、対応する覚醒体が5狂気を獲得する。「狂気解放」発動後、対応する覚醒体の、除外と虚無が付与された「攻撃」を1枚獲得し、「キーオーダー」発動後、ランダムな覚醒体の、除外と虚無が付与された「防御」を1枚獲得する。"
  },
  State_67665_Name = {
    Text = "時の振り子・羽翼"
  },
  State_67666_Desc = {
    Text = "ダメージを与えるたびに[DescArg1]点の一時的な<PowerIconKeywords:力>を獲得し、最大3回まで重複可能。最大時は効果が倍増する。"
  },
  State_67666_Name = {Text = "縞瑪瑙"},
  State_67667_Desc = {
    Text = "ターン終了後、すべての覚醒体が5狂気を獲得。残り行動力1点ごとに、すべての覚醒体が追加で3狂気を獲得。"
  },
  State_67667_Name = {
    Text = "原型電池"
  },
  State_67668_Desc = {
    Text = "クリティカルダメージ15%アップ。「攻撃」のクリティカル率40%アップ。"
  },
  State_67668_Name = {
    Text = "白いカラスのくちばし"
  },
  State_67669_Name = {Text = "廃棄"},
  State_67670_Desc = {
    Text = "狂気解放を発動すると、カードを1枚引く。ライフが25%未満の場合、1枚引く。"
  },
  State_67670_Name = {
    Text = "知識の読書輪"
  },
  State_67671_Desc = {
    Text = "1回のアクティブダメージを与えるたびに[DescArg1]ライフを回復し、ダメージの対象に[DescArg2]回の<BleedingIconKeywords:出血>を付与する。"
  },
  State_67671_Name = {
    Text = "祝福・虫群の意識"
  },
  State_67672_Desc = {
    Text = "造成的<WeaknessIconKeywords:倦怠>効果が8%向上し、<VulnerabilityIconKeywords:軟化>効果が25%向上する。<WeaknessIconKeywords:倦怠>または<VulnerabilityIconKeywords:軟化>を適用する際、対象から[DescArg1]の<PowerIconKeywords:力>を一時的に奪う。"
  },
  State_67672_Name = {
    Text = "褪せた写真+"
  },
  State_67673_Desc = {
    Text = "ターン開始時にカードを1枚引く。"
  },
  State_67673_Name = {
    Text = "方位磁針"
  },
  State_67674_Desc = {
    Text = "1枚の指令カードを使用するごとに、[DescArg2]% <DeathResistanceIconKeywords:死亡抵抗>を獲得する（今回のレベルで発動するたびに獲得する死亡抵抗は半減する）。あなたの<DeathResistanceIconKeywords:死亡抵抗>が100%以上であれば、[DescArg1]点の一時的な<PowerIconKeywords:力>を獲得するように変更される。"
  },
  State_67674_Name = {
    Text = "怪蛇の抜け殻"
  },
  State_67675_Desc = {
    Text = "ターン終了時、余った行動力があれば次のターン追加でカード2枚を引く。余った手札があれば、次のターン追加で2点の行動力を獲得。"
  },
  State_67675_Name = {
    Text = "日月ルーレット+"
  },
  State_67677_Desc = {
    Text = "<WeaknessIconKeywords:倦怠>を引き起こすと、[DescArg1]点のシールドを獲得。；<VulnerabilityIconKeywords:軟化>を引き起こすと、[DescArg2]点の一時的な<PowerIconKeywords:力>を獲得。1ターン内にこの2つの効果が発動した場合、追加で[DescArg1]点のシールドと[DescArg2]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  State_67677_Name = {
    Text = "重い額縁"
  },
  State_67703_Desc = {
    Text = "ターン開始時に前のターンの残り手札が3枚以上の場合、2点の行動力を獲得。"
  },
  State_67703_Name = {
    Text = "ミサゴの校章"
  },
  State_67704_Desc = {
    Text = "狂気解放を放った後、対応する覚醒体は10の狂気を獲得し、[DescArg1] のシールドを獲得。"
  },
  State_67704_Name = {
    Text = "無名の神のヴェール"
  },
  State_67796_Name = {
    Text = "<TongxiaoKeywords:万物の理を通じて>：使用後復元し、<Energy:[StateArg1]>狂気を獲得。"
  },
  State_67841_WeaponDesc = {
    Text = "プレイ前にカードの計算力を変更"
  },
  State_67844_Desc = {
    Text = "致命的なダメージを受けた後、すべてのライフを回復でき、@1回発動可能、現在[DescArg1]回発動済み。"
  },
  State_67844_Name = {
    Text = "悠久の混沌"
  },
  State_67866_Name = {
    Text = "<BleedingColour:出血>"
  },
  State_68298_Desc = {
    Text = "致命的なダメージを受けた時、行動予測は「深淵からの注視」に変化し、80点の一時的な「堅固」を獲得し、すべてのライフを回復。[DescArg1]回発動可能。ターン終了時、自身の20点の「堅固」を解除。"
  },
  State_68554_Desc = {
    Text = "致命的ダメージを受けた後、すべてのライフを回復し、他の敵が全滅するとこの状態を解除。一度だけ発動可能。現在[DescArg1]回発動済み。"
  },
  State_68554_Name = {
    Text = "悠久の混沌の欠片"
  },
  State_68621_Desc = {
    Text = "戦闘開始時および毎ターン終了時、一時的な<ResentChainsKeywords:怨恨の鎖>を2層獲得する。"
  },
  State_68621_Name = {
    Text = "怪奇の奔流"
  },
  State_68622_Desc = {
    Text = "覚醒体が付与する力の効果が75%減少する。ライフを失うたび、[DescArg1]点のシールドと1点の一時的な堅固を獲得する。"
  },
  State_68622_Name = {
    Text = "邪信の奔流"
  },
  State_68623_Desc = {
    Text = "指令カードを1枚使用するたびに、対応する覚醒体の最も行動力消費が少ないカードを1枚捨てる。"
  },
  State_68623_Name = {
    Text = "狂気の奔流"
  },
  State_68624_Desc = {
    Text = "ターン終了時、失ったライフの10%を回復し、自身のデバフとプレイヤーのバフを解除する。"
  },
  State_68624_Name = {
    Text = "降臨の奔流"
  },
  State_68626_Desc = {
    Text = "すべての覚醒体の狂気上限が50%増加。毎ターン終了時、すべての覚醒体は10狂気を失い、自身の最大ライフを3%回復。"
  },
  State_68626_Name = {
    Text = "恐怖の奔流"
  },
  State_68627_Desc = {
    Text = "戦闘開始時に15点の「一時的なバリア」を獲得。ターン終了時に15点の「一時的なバリア」を獲得し、ランダムなカード10枚「一時的な溶解」を付与する。"
  },
  State_68627_Name = {
    Text = "刺骨の奔流"
  },
  State_68632_Desc = {
    Text = "すべての指令カードの行動力消費が1増加。3ターンごとに、ターン終了時「石ころ変化」を1枚手札に追加する。"
  },
  State_68632_Name = {
    Text = "悲泣の奔流"
  },
  State_68635_Name = {
    Text = "「純銀の芯·恐怖」"
  },
  State_68637_Desc = {
    Text = "ライフを失った時、対応する点数を減少させる。点数が0になった時、プレイヤーに2点の一時的なバリアを獲得させ、自身は[DescArg1]点のシールドと[DescArg2]点の一時的な堅固を獲得し、再度[DescArg3]点の「次元の障壁」を獲得する。"
  },
  State_68637_Name = {
    Text = "次元障壁"
  },
  State_68638_Name = {
    Text = "「純銀の芯·邪信」"
  },
  State_68646_Desc = {
    Text = "基礎ダメージとシールドが200%増加する。使用後にこれを除外する。"
  },
  State_68646_Name = {
    Text = "<RedQuality1:一時的な溶解>"
  },
  State_68647_Name = {
    Text = "「純音の核・狂気」"
  },
  State_68680_Desc = {
    Text = "悠久の欠片の除去"
  },
  State_68680_Name = {
    Text = "悠久の欠片の除去"
  },
  State_68704_Desc = {
    Text = "トオワボの真の降臨まで[DescArg1]ターン……"
  },
  State_68704_Name = {Text = "降臨"},
  State_68829_Desc = {
    Text = "アクティブまたは触手ダメージを受けた時、ダメージ無効し1スタック減少、ターン開始時に除去される。"
  },
  State_68829_Name = {
    Text = "<ParcloseColour: 一時的なバリア>"
  },
  State_68829_WeaponDesc = {
    Text = "受けるダメージが99％減少し、ダメージを1回受けるたびに1スタック減少する。"
  },
  State_70026_Desc = {
    Text = "このカードは「保留」を持ち、発射後すべての覚醒体の一時的なクリティカルレートが[StateArg1]％上昇し、「不死の支配」を除去します。現在の界域が深海である場合、「不死の支配」を除去した後に1の行動力を獲得します。"
  },
  State_70026_Name = {
    Text = "<OrangeQuality:不滅の支配>"
  },
  State_70031_Desc = {
    Text = "チーム唯一：戦闘開始時、ドローパイル内の装備者の行動力消費3以上のすべての指令カードに「不朽支配」効果を付与する：このカードは「保留」を持ち、使用後すべての覚醒体の臨時クリティカル率が<WeaponEffect_Num:[StateArg1]%>増加し、「不朽支配」を除去する。現在の界域が「深海」の場合、「不朽支配」除去後に1点の行動力を獲得する。"
  },
  State_70031_WeaponDesc = {
    Text = "戦闘開始時、ドローパイル内の装備者の行動力消費3以上のすべての指令カードに「不朽支配」効果を付与する：このカードは「保留」を持ち、使用後すべての覚醒体の臨時クリティカル率が<WeaponEffect_Num:[StateArg1]%>増加し、「不朽支配」を除去する。現在の界域が「深海」の場合、「不朽支配」除去後に1点の行動力を獲得する。"
  },
  State_70182_Desc = {
    Text = "獲得するすべてのシールドが[DescArg1]%減少。"
  },
  State_70182_Name = {
    Text = "<FragileColour:抑圧>"
  },
  State_70182_WeaponDesc = {
    Text = "獲得したすべてのシールドが33%減少。"
  },
  State_70277_Desc = {
    Text = "アクティブまたは触手ダメージを受けた後、[StateArg1]% のダメージを猩紅炉の回復量に変換する、[Layer] ターン持続する。"
  },
  State_70277_Name = {
    Text = "創生の祭典"
  },
  State_70287_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、手札にある装備者のすべての「スキル」が与えるダメージ、治療、シールドを[StateArg1]%増加させる。"
  },
  State_70287_Name = {
    Text = "青石の玉座"
  },
  State_70288_Desc = {
    Text = "このカードが与えるダメージ、治癒、シールドが[DescArg1]%上昇する。"
  },
  State_70288_Name = {
    Text = "青石の玉座"
  },
  State_70313_Desc = {
    Text = "ボス戦中、ターン開始時および「溶壊・ドール」が狂気解放を発動後、1層の「<Zhongmowuqiling:終末>」を獲得。「終末」は最大10層まで持て、10層に達すると「虚無終結」を1枚手札に追加。"
  },
  State_70313_Name = {
    Text = "破滅への道"
  },
  State_70318_Desc = {
    Text = "全ての敵に [StateArg1] ターンの<VulnerabilityIconKeywords:易傷>を付与し、1 ターンの「興奮」ステータスを獲得する：ダメージ強化 +[StateArg2]％。"
  },
  State_70318_Name = {Text = "興奮"},
  State_70322_Desc = {
    Text = "終末が10点に達すると、「虚無終結」を1枚手札に追加する。"
  },
  State_70322_Name = {Text = "終末"},
  State_70330_Desc = {
    Text = "1ターンの「興奮」ステータスを獲得する：ダメージ強化 +[Arg2]％。"
  },
  State_70330_Name = {Text = "興奮"},
  State_70346_Desc = {
    Text = "すべての敵に[StateArg1]点の<WeaknessIconKeywords:虚弱> を付与し、このターン中、[Exhaustion:StateArg3]点の <PowerIconKeywords:力>を減少させる。"
  },
  State_70346_Name = {Text = "呪い"},
  State_70347_Desc = {
    Text = "このターン中、すべての敵から[Exhaustion:StateArg3]点の<PowerIconKeywords:力>を減少させる。"
  },
  State_70347_Name = {Text = "呪い"},
  State_70374_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：装備者が各ターン最初の [StateArg1] 回攻撃を受けた際、攻撃者に<PVPEmptinessKeywords:虚無>を与える。"
  },
  State_70374_Name = {
    Text = "虚無に堕ちた人形"
  },
  State_70379_Desc = {
    Text = "攻撃者に<PVPEmptinessKeywords:虚無>を与える。攻撃を受けた後、このステータスを除去する。"
  },
  State_70379_Name = {
    Text = "虚無カウンター"
  },
  State_70443_Desc = {
    Text = "終末が10点に達すると、「虚無終結」を1枚手札に追加する。"
  },
  State_70443_Name = {Text = "終末"},
  State_70539_Name = {
    Text = "魂の疫病"
  },
  State_70589_Desc = {
    Text = "前のカードより行動力消費が低いカードを2回連続で使用すると、すべての敵に40/80の毒を付与し、1ターンに最大で5回発動します。"
  },
  State_70590_Desc = {
    Text = "各ターン初めて直接胚胎を使用した後、そのターン中のアクティブダメージは15/30%のダメージに等しい出血を引き起こします。"
  },
  State_70593_Desc = {
    Text = "非派生指令カードを使用した後、行動力消費を2減少させたそのカードの1/2枚の一時的コピーを山札のランダムな位置に追加する。3ターンのクールタイム。"
  },
  State_70594_Desc = {
    Text = "ターン終了時、もし潮流モードにある場合、32/64の触腕ダメージを獲得し、クールダウンは3ターン。"
  },
  State_70595_Desc = {
    Text = "戦闘開始時にすべての敵に1280の毒を付与し、ボス戦の効果を倍増させる。"
  },
  State_70598_Desc = {
    Text = "カードが1枚超次元空間に入るたび、もしそのカードが超次元空間の他のカードと帰属者と異なる場合、「啓示」を1/2枚手札に加える。"
  },
  State_70600_Desc = {
    Text = "ターン終了時に32点のライフを回復。"
  },
  State_70600_Name = {
    Text = "恩賜の血"
  },
  State_70602_Desc = {
    Text = "シルバーキー覚醒後、4枚のカードを引く。"
  },
  State_70603_Desc = {
    Text = "シルバーキー覚醒後、すべての覚醒体が10の狂気を獲得。"
  },
  State_70605_Desc = {
    Text = "シルバーキー覚醒後、32の力を獲得。"
  },
  State_70607_Desc = {
    Text = "前のカードより行動力消費が高いカードを2回連続で使用すると、24/48の反撃を獲得し、1ターンに最大で5回発動する。"
  },
  State_70609_Desc = {
    Text = "シルバーキー覚醒後、96のシールドを獲得。"
  },
  State_70609_Name = {
    Text = "蝶の標本"
  },
  State_70611_Desc = {
    Text = "シルバーキー覚醒後、すべての覚醒体が与えるダメージの基礎効果が25％/50％増加。"
  },
  State_70614_Name = {
    Text = "レーザー顎骨+"
  },
  State_70617_Desc = {
    Text = "各ターンの最初の5回のダメージが15％/30％増加。"
  },
  State_70618_Desc = {
    Text = "ターン開始時にカードを1枚引く。"
  },
  State_70619_Desc = {
    Text = "「攻撃」が与えるダメージの10％/20％が毒となり、1ターンあたり最大320/640点を与える。"
  },
  State_70620_Desc = {
    Text = "敵の攻撃を受けた際、敵に1回25%/50%のこちらの最大ライフ値の<FixedDamage:純粋ダメージ>を与え、そのダメージは100%/200%のカウンターバフを受ける。各敵は1ターンにつき最大1回発動する。__「開発用」"
  },
  State_70620_Name = {
    Text = "遺落の祭祀刀"
  },
  State_70621_Desc = {
    Text = "シルバーキー覚醒後、192のシールドを獲得。"
  },
  State_70621_Name = {
    Text = "蝶の標本+"
  },
  State_70623_Desc = {
    Text = "毎ターンの開始時にすべての覚醒体は 10 の狂気を得る。"
  },
  State_70624_Desc = {
    Text = "シルバーキー覚醒後、すべての覚醒体が20の狂気を獲得。"
  },
  State_70628_Desc = {
    Text = "ターン開始時2枚のカードを引く。"
  },
  State_70629_Desc = {
    Text = "各ターン初めて捕食を行ったとき、他の覚醒体は10/20の狂気を獲得。"
  },
  State_70635_Desc = {
    Text = "シルバーキー覚醒後、416の反撃を獲得。"
  },
  State_70636_Desc = {
    Text = "ライフを失ったときにライフ損失量の10％/20％の猩紅炉を獲得。"
  },
  State_70637_Desc = {
    Text = "戦闘開始時、触腕の上限+1/2、触腕を1/2獲得。"
  },
  State_70641_Desc = {
    Text = "「黒渦消滅」により、160/320のシールドを獲得。3ターンのクールダウン。"
  },
  State_70641_Name = {
    Text = "超弦懐中時計"
  },
  State_70643_Desc = {
    Text = "ターン開始時に行動力を1獲得。"
  },
  State_70644_Desc = {
    Text = "狂気解放を発動すると、16/32 の一時的な力を獲得。"
  },
  State_70645_Desc = {
    Text = "ターン開始時に2点の行動力を獲得。"
  },
  State_70646_Name = {
    Text = "遺された祭祀刀+"
  },
  State_70647_Desc = {
    Text = "すべての覚醒体が与えるダメージの基礎効果が30％増加。"
  },
  State_70648_Desc = {
    Text = "戦闘開始時にすべての敵に640の毒を付与し、ボス戦の効果を倍増させる。"
  },
  State_70656_Desc = {
    Text = "「攻撃」は1/2回の60％覚醒体攻撃力のダメージを追加で与え、ターンごとに最大3回発動。"
  },
  State_70657_Desc = {
    Text = "戦闘開始時に32の力を獲得。"
  },
  State_70660_Desc = {
    Text = "戦闘開始時に64の力を獲得。"
  },
  State_70661_Desc = {
    Text = "ターン終了時に64点のライフを回復。"
  },
  State_70661_Name = {
    Text = "恩寵の血+"
  },
  State_70662_Desc = {
    Text = "シルバーキー覚醒後、2の行動力を獲得。"
  },
  State_70664_Desc = {
    Text = "シルバーキー覚醒後、16の力を獲得。"
  },
  State_70666_Desc = {
    Text = "戦闘開始後、100/200界域知識を獲得。すべての覚醒体が与える基本毒と低級遺物が与える毒が10％/20％増加。"
  },
  State_70667_Desc = {
    Text = "シルバーキー覚醒後、4の行動力を獲得。"
  },
  State_70670_Desc = {
    Text = "戦闘開始時に320の反撃を獲得し、ボス戦の効果を倍増させる。"
  },
  State_70671_Desc = {
    Text = "超次元のターンに入った後、最初に使用する非派生指令カードは追加で1/2回効果を発揮します。"
  },
  State_70678_Desc = {
    Text = "戦闘開始時に640の反撃を獲得し、ボス戦の効果を倍増させる。"
  },
  State_70681_Desc = {
    Text = "すべての覚醒体が与えるダメージの基礎効果が60％増加。"
  },
  State_70682_Desc = {
    Text = "手札が2枚以下のとき、1/2枚のカードを引き、1ターンに最大2回まで発動。"
  },
  State_70683_Desc = {
    Text = "「黒渦消滅」により、狂気が最も少ない覚醒体に50/100の狂気を獲得。3ターンのクールダウン。"
  },
  State_70684_Desc = {
    Text = "ターン開始時、もしライフが25％未満であれば、72/144の一時的な力を獲得。"
  },
  State_70685_Desc = {
    Text = "シルバーキー覚醒後、すべての敵に416の毒を付与する。"
  },
  State_70686_Desc = {
    Text = "狂気解放を発動した後、すべての敵に味方の最大ライフの15%/30%の<FixedDamage:純粋ダメージ>を1回与え、10%/20%の毒を発動する。"
  },
  State_70687_Name = {
    Text = "超限懐中時計+"
  },
  State_70689_Desc = {
    Text = "シルバーキー覚醒後、すべての敵に832の毒を付与する。"
  },
  State_70690_Desc = {
    Text = "戦闘開始後、100/200界域知識を獲得。すべての覚醒体が与える基本反撃と低級遺物が与える反撃が10％/20％増加。"
  },
  State_70691_Desc = {
    Text = "ダメージを与えるたびに4/8の一時的な力を得られ、各ターンで最大15回発動可能。"
  },
  State_70693_Desc = {
    Text = "胚胎融合は自動的に獲得量が100％/200％増加。"
  },
  State_70694_Desc = {
    Text = "シルバーキー覚醒後、2枚のカードを引く。"
  },
  State_70695_Desc = {
    Text = "各ターン開始時に、すべての覚醒体は5の狂気を獲得。"
  },
  State_70696_Desc = {
    Text = "シルバーキー覚醒後、208の反撃を獲得。"
  },
  State_70698_Desc = {
    Text = "防御は200/400の一時的な反撃を獲得。毎ターン最大3回発動可能。"
  },
  State_70804_Name = {
    Text = "生死の時限"
  },
  State_70805_Desc = {
    Text = "戦闘開始後、すべての敵に1/2点の虚弱を付与し、ボスには効果が2倍。すべての覚醒体が与えるダメージの基礎効果が15％/30％増加。"
  },
  State_70806_Name = {
    Text = "守護の手+"
  },
  State_70808_Desc = {
    Text = "静海モードを使用して、すべての敵に64/128の衰弱を付与し、3ターンのクールダウン。"
  },
  State_70809_Desc = {
    Text = "ターン開始時、もしライフが25％未満であれば、100/200シールドを獲得。"
  },
  State_70809_Name = {
    Text = "守護の手"
  },
  State_70810_Desc = {
    Text = "怒涛モードを使用して、すべての触腕で敵に攻撃を即座に1/2回行い、3ターンのクールダウン。"
  },
  State_70812_Desc = {
    Text = "戦闘開始後、すべての敵に1/2点の易傷を付与し、ボスには効果が2倍。すべての覚醒体が与えるダメージの基礎効果が15％/30％増加。"
  },
  State_70832_Desc = {
    Text = "チーム唯一：戦闘開始時、装備者は自身の狂気回復の<WeaponEffect_Num:[StateArg1]%>に等しい狂気を獲得する。装備者が各戦闘で初めて狂気解放を発動した後、この効果を1回繰り返す。"
  },
  State_70832_WeaponDesc = {
    Text = "戦闘開始時、装備者は、装備者の狂気増加の<WeaponEffect_Num:[StateArg1]%>に等しい狂気（<WeaponEffect_Num:[DescArg1]>）を獲得。装備者がこの戦闘で初めて狂気解放を使用した後、この効果をもう一度繰り返す。"
  },
  State_70835_Desc = {
    Text = "チーム唯一：装備者が与える狂気、毒、ライフ回復量が<WeaponEffect_Num:[StateArg1]%>増加。装備者が狂気解放を発動した後、今回消費した狂気の<WeaponEffect_Num:[StateArg2]%>の狂気を獲得。"
  },
  State_70835_WeaponDesc = {
    Text = "装備者が与える狂気、毒、ライフ回復量が<WeaponEffect_Num:[StateArg1]%>増加。装備者が狂気解放を発動すると、消費した狂気<WeaponEffect_Num:[StateArg2]%>の狂気を獲得。"
  },
  State_70989_Desc = {
    Text = "1ターンに4回狂気解放を放出した後、3/6の行動力を獲得し、クールダウンは3ターン。"
  },
  State_71001_Desc = {
    Text = "1ターン内に異なる覚醒体に所属する4枚の指令カードを出した後、すべての覚醒体は20/40の狂気を獲得し、クールダウンは3ターン。"
  },
  State_71153_Desc = {
    Text = "ターン開始時にカエクスは15の狂気を獲得。カエクスがシールドを獲得すると、シールド量の50％のライフを回復。"
  },
  State_71154_Desc = {
    Text = "ターン開始時にアイギスは15狂気を獲得。アイギスが易傷状態の敵にダメージを与えると、敵の一時的な力を最大5回まで10ずつ奪います。"
  },
  State_71155_Desc = {
    Text = "ターン開始時レーアは15狂気を獲得。ライフを失うたびに8点の力を獲得。各戦闘で最大10回まで重複可能。10回重複後、「苦痛と歓喜」の行動力消費が1になり、ダメージ回数が1増える。"
  },
  State_71156_Desc = {
    Text = "ターン開始時、アグリッパは15狂気を獲得。「耐え難い施し」はアグリッパのこのターンの行動力消費を1減少させ、1ターンに1回のみ有効。"
  },
  State_71157_Desc = {
    Text = "ターン開始時サンは15狂気を獲得。戦闘開始時にサンの全ての指令カードに保持、準備1、24点のシールド獲得を付与。"
  },
  State_71157_Name = {
    Text = "次元映像·サン"
  },
  State_71158_Desc = {
    Text = "ターン開始時ドールは15狂気を獲得。戦闘開始後にドールの「等価交換」の行動力消費を0にし、使用した後、次のターンに追加で2枚のカードを引く。"
  },
  State_71159_Desc = {
    Text = "ターン開始時ファロスは15狂気を獲得。1回触腕ダメージを与えるたび、ファロスのこの戦闘での毒が1％増加し、最大100％まで。"
  },
  State_71160_Desc = {
    Text = "ターン開始時「24」は15狂気を獲得。ターン開始時「24」が「抑鬱人格」にいると、追加で25狂気を獲得し、「躁狂人格」にいると「24」の一時的クリティカル率と一時的クリティカルダメージが35%増加。"
  },
  State_71161_Desc = {
    Text = "ターン開始時ファイントは15狂気を獲得。死亡抵抗が発動するたびにファイントがこの探索中に得たシールド、反撃、ライフ回復が20％増加し、最大5回まで有効。"
  },
  State_71162_Desc = {
    Text = "ターン開始時にゴリアテは15狂気を獲得。ゴリアテが1ターン内に3回ダメージを与えると、この戦闘中にゴリアテが与えるダメージに追加の力のボーナスを1倍受けます。3ターンのクールダウン。"
  },
  State_71163_Desc = {
    Text = "ターン開始時、血ノ鎖・ヘロットは15狂気を獲得。血ノ鎖・ヘロットのアクティブダメージに20％の出血を追加し、敵を倒すと、他の敵に過剰ダメージに等しい出血を付与。"
  },
  State_71164_Desc = {
    Text = "ターン開始時にオレッタは15の狂気を獲得。「腺体分裂」のダメージ回数が1増加し、オレッタの「防御」を使用すると「腺体分裂」を1枚手札に追加。"
  },
  State_71166_Desc = {
    Text = "ターン開始時、リリーは15狂気を獲得。リリーの忍耐上限が100%増加し、「泥に咲く不滅の花」または「返しの一撃」を発動すると、「忍耐」層数の8%のライフを回復する。"
  },
  State_71167_Desc = {
    Text = "ターン開始時ロータンは15狂気を獲得。各ターン初めてロータンの「防御」を発動した後、「虚無」と「除外」が付与された「傲慢の刃」を2枚手札に追加。"
  },
  State_71168_Desc = {
    Text = "ターン開始時パンディアは15狂気を獲得。ターン開始時に64の反撃を獲得。毎に4の非一時的な反撃に対して「パンディア」指令カードが与えるダメージが1増加。"
  },
  State_71169_Desc = {
    Text = "ターン開始時にヘロットは15の狂気を獲得。1枚カードを捨てるたびに、「ヘロット」は5の狂気を獲得。"
  },
  State_71170_Desc = {
    Text = "ターン開始時にタヴィは15の狂気を獲得。もし1ラウンド内でタヴィの指令カードを6枚使用した場合、「シルバーキーの暁光」を1枚手札に置き、クールダウン3ラウンド。"
  },
  State_71171_Desc = {
    Text = "ターン開始時ミリアムは15の狂気を獲得し、1枚の「聖礼」を手札に追加。"
  },
  State_71172_Desc = {
    Text = "ターン開始時、溶融・ドールは15狂気を獲得。溶融・ドールが狂気解放を発動すると、20狂気を消費するごとに他の覚醒体は1狂気を獲得。"
  },
  State_71173_Desc = {
    Text = "ターン開始時サルバドルは15狂気を獲得。猩紅炉を蓄積するたびにその蓄積量の5％の力を獲得。サルバドルの「攻撃」と「苦痛の解消」は別に力の1倍のボーナスを獲得。"
  },
  State_71175_Desc = {
    Text = "ターン開始時ノティラは15狂気を獲得。ノティラの「狂気解放」を発動後、現在のシールドの50%に等しい反撃を獲得。各ターン最大1回発動。"
  },
  State_71177_Desc = {
    Text = "ターン開始時リッツは15狂気を獲得。「死告の舞い」に捨てられたカードは追加で1回効果を発揮し、3ターンクールダウン。"
  },
  State_71178_Desc = {
    Text = "ターン開始時にラモンナは15 狂気を獲得。ラモンナの指令カードを3枚目に使用するたび、その指令カードが追加で1回効果を発揮します。"
  },
  State_71179_Desc = {
    Text = "ターン開始時にユウハシュは15の狂気を獲得。ユウハシュの狂気消費が10減少し、狂気解放を放つたびに狂気消費がさらに5減少し、各ターンで2回狂気解放を放つことができる。"
  },
  State_71180_Desc = {
    Text = "ターン開始時、アルバは15狂気を獲得する。前のターンにアルバが「防御」を2枚使用していた場合、除外された「心眼の刃」を1枚手札に加える。もし「攻撃」を2枚使用していた場合、除外された「戦闘体勢」を1枚手札に加える。"
  },
  State_71181_Desc = {
    Text = "ターン開始時ソレールは15狂気を獲得。ソレールが1回ダメージを与えるたびに胚胎融合+10、毎ターン最大10回まで有効。10回有効後、ソレールのこの戦闘のクリティカルダメージ+20％。"
  },
  State_71182_Desc = {
    Text = "ターン開始時にハムリンは15の狂気を獲得。「魂の序曲」の行動力消費が1減少し、基礎ダメージの回数が1増加。"
  },
  State_71183_Desc = {
    Text = "ターン開始時タイスは15狂気を獲得。タイスが1回のターン内に2枚の指令カードを使用した後、「聖純の子」を1枚獲得し、72の一時的な力を獲得。3回冷却。"
  },
  State_71187_Desc = {
    Text = "ターン開始時、シレストは15狂気を獲得。ターン終了前に手札にシレストの指令カードが1枚あるごとに1本の触腕が敵を攻撃し、8点のライフを回復する。"
  },
  State_71188_Desc = {
    Text = "ターン開始時にマーフィーは15の狂気を獲得。マーフィーの「攻撃」と「防御」は「献上」の25％を一時的な触腕ダメージに変換するが、1ラウンドにつき1回のみ有効。"
  },
  State_71189_Desc = {
    Text = "ターン開始時にニムフィーアは15の狂気を獲得。ニムフィーアの「攻撃」を使用すると、この戦闘でのニムフィーアが与える毒が20%増加し、ニムフィーアの「防御」を使用するとすべての敵に50%の毒を発動。各ターン最大各1回だけ有効。"
  },
  State_71190_Desc = {
    Text = "ターン開始時にオジールは15の狂気を獲得。各ターン初めてオジールの「刺突の槍」または「攻撃」を使用すると、そのラウンド内でオジールの与えるシールドと力が50%増加。"
  },
  State_71191_Desc = {
    Text = "ターン開始時ライカーは15狂気を獲得。各ターン初めてのサイコロの結果は常に6になる。"
  },
  State_71192_Desc = {
    Text = "ターン開始時、環行・ラモンナは15狂気を獲得。各ターン初めて「ループ」発動時、500点のキーエネルギーと1層の「ネゲントロピー」を獲得。"
  },
  State_71193_Desc = {
    Text = "ターン開始時にトゥルーは15の狂気を獲得。トゥルーの狂気消費が10減少し、狂気解放を放つとすぐに2本の一時的な触腕が生成。"
  },
  State_71194_Desc = {
    Text = "ターン開始時カレンは15狂気を獲得。「静観」を使用すると消費した行動力の倍を返還し、クールダウン3ターン。"
  },
  State_71271_Desc = {
    Text = "ターン開始時にオルラは15の狂気を獲得。戦闘開始時、すべての感情のメタファーを各1層獲得。「メタファー」効果は50％増加。"
  },
  State_71272_Desc = {
    Text = "ターン開始時、ジェンキンは15狂気を得て、最終ダメージ+5%。「ブラウン出撃！」の基礎ダメージとダメージ成長が200%増加。"
  },
  State_71273_Desc = {
    Text = "ターン開始時ダフォダイルは15狂気と1枚の「啓示」を獲得。「異質の潮汐」を発動するたびに、獲得する力がこの探索中に永久に25%増加し、最大300%まで。"
  },
  State_71274_Desc = {
    Text = "ターン開始時ティンクトは15狂気を獲得。ティンクトの指令カードが跳躍を引き起こした後、手札に戻り、毎ターン最大で3回効果を発揮する。"
  },
  State_71275_Desc = {
    Text = "ターン開始時ワンダは15狂気を得て1層「夢引き」を獲得。現在が超次元ターンの場合は追加で1枚の一時的な「脊椎針の鎖」と「迷途の守」を手札に追加。"
  },
  State_71276_Desc = {
    Text = "ターン開始時にエリカは15 狂気を獲得。エリカが1ターン内に3枚の指令カードを使用した後、「啓示」を1枚獲得し、この戦闘中の「電磁爆破」の力と警戒のボーナスが1倍増加。"
  },
  State_71277_Desc = {
    Text = "ターン開始時、カーシアは15狂気を獲得。1枚カードを引くごとにカーシアは1狂気を獲得。カーシアが狂気解放を発動すると、すべての敵は32点の力を失う。"
  },
  State_71278_Desc = {
    Text = "ターン開始時ウインクルは15狂気を獲得。他の覚醒体が狂気解放を放つたびにウインクルは5の狂気を獲得し、手札の「精神再建」の行動力消費が1減る。"
  },
  State_71279_Desc = {
    Text = "ダメージ強化 +[StateArg1]％、[Layer] ターン持続。"
  },
  State_71279_Name = {Text = "興奮"},
  State_71503_Name = {
    Text = "「終末形態」：追加でカードを3枚引き、3点の行動力を獲得。すべての敵に[DescArg1]%の<IntoxicationIconKeywords:毒>を付与。「溶融・ドール」の狂気上限が50増加。最大3回。"
  },
  State_71581_Name = {
    Text = "霊塑適性"
  },
  State_71589_Name = {
    Text = "1本のタッチアームを刺激して敵を攻撃し、8ポイント回復する。"
  },
  State_71605_Name = {
    Text = "[StateArg1]点のシールドを得る"
  },
  State_71650_Desc = {
    Text = "死亡後、復活して異なる数の分身を召喚するが、復活後は、堅固も無敵も獲得しない。[Layer]回発動可能。"
  },
  State_71650_Name = {
    Text = "千の次元の獣"
  },
  State_71651_Desc = {
    Text = "ライフを失うたび、[StateArg1]点の一時的な力を失う。[Layer]回発動可能、毎ターン発動回数はリセットされる。"
  },
  State_71651_Name = {
    Text = "紳士のシルクハット"
  },
  State_71707_Desc = {
    Text = "アクティブダメージを1回受けるたびに、ライフを[StateArg1]点回復し、[Layer]ターン持続する。"
  },
  State_71707_Name = {
    Text = "カエクス・支援"
  },
  State_71708_Desc = {
    Text = "ターン終了時、手札に1枚のカードがあるごとに、すべての覚醒体が[DescArg1]狂気を獲得。"
  },
  State_71708_Name = {
    Text = "カーシア・支援"
  },
  State_71709_Desc = {
    Text = "ターン終了時、35狂気を獲得。[Layer]ターン持続。"
  },
  State_71709_Name = {
    Text = "ウインクル・支援"
  },
  State_71711_Desc = {
    Text = "覚醒体によるダメージが25%増加、[Layer]ターン持続。"
  },
  State_71711_Name = {
    Text = "ジェンキン・支援"
  },
  State_71712_Desc = {
    Text = "アクティブダメージを与えた時、触手1本が1回攻撃し、[Layer]ターン持続する。"
  },
  State_71712_Name = {
    Text = "オレッタ・支援"
  },
  State_71712_WeaponDesc = {
    Text = "海月がダメージを与えるとき、[StateArg1] 本のタッチアームでそのターゲットを攻撃する。"
  },
  State_71713_Desc = {
    Text = "「呑み込む」を行うたびに、「打撃」を 2 枚の引き、その計算力消費を 1 減少させ、[Layer] ターン持続する。"
  },
  State_71713_Name = {
    Text = "シロ・サポート"
  },
  State_71740_Desc = {
    Text = "次のターン開始時に[Layer]シールドを獲得。"
  },
  State_71740_Name = {
    Text = "レーア・支援のシールド"
  },
  State_71741_Desc = {
    Text = "次のターン開始時に、今ターンの損失に等しいライフのシールドを獲得し、持続[Layer]ターン。"
  },
  State_71741_Name = {
    Text = "レーア・支援"
  },
  State_71741_WeaponDesc = {
    Text = "次のターンの開始時に、前ターンで失ったライフと同じ量のシールドを獲得する。"
  },
  State_71742_Desc = {
    Text = "ストライクカードのダメージが [Layer]％アップします。"
  },
  State_71742_Name = {
    Text = "シロ・サポート"
  },
  State_71742_WeaponDesc = {
    Text = "このターン、あなたのストライクカードのダメージが [Layer]％ アップします。"
  },
  State_71837_Desc = {
    Text = "次のターン開始時、軟化を獲得。"
  },
  State_71837_Name = {
    Text = "遅延軟化"
  },
  State_71839_Desc = {
    Text = "「目覚め」を使用する時、[Layer]点の行動力を獲得する。現在の界域が「深海」の場合、追加で[Layer]本の一時的な触腕を生成する。"
  },
  State_71839_Name = {
    Text = "星辰の加護"
  },
  State_71856_Desc = {
    Text = "ライフを失うたび、[StateArg1]点の一時的な力を失う。[Layer]回発動可能、毎ターン発動回数はリセットされる。"
  },
  State_71856_Name = {
    Text = "紳士のシルクハット"
  },
  State_72018_WeaponDesc = {
    Text = "1つのダメージを受けたとき、全員の覚醒体に1ポイントの狂気を追加する。"
  },
  State_72033_Desc = {Text = "――"},
  State_72033_WeaponDesc = {Text = "――"},
  State_72034_Desc = {Text = "――"},
  State_72034_WeaponDesc = {Text = "――"},
  State_72036_Name = {
    Text = "カオス職業初期化"
  },
  State_72102_Desc = {
    Text = "クラシックな「忘却前夜」のプレイ体験。"
  },
  State_72137_Name = {
    Text = "行動力充実"
  },
  State_72206_Name = {
    Text = "研究進捗「[DescArg1] / 15」"
  },
  State_72208_Name = {
    Text = "研究進捗「[DescArg1] / 2」"
  },
  State_72212_Name = {
    Text = "研究進捗「[DescArg1] / 10」"
  },
  State_72213_Name = {
    Text = "研究進捗「[DescArg1] / 30」"
  },
  State_72220_Name = {
    Text = "研究進捗「[DescArg1] / 5」"
  },
  State_73518_Desc = {
    Text = "与えるダメージが100%増加する。ライフを失った後にこの状態を解除し、最大ライフの50%のシールドを獲得。"
  },
  State_73518_Name = {
    Text = "「暗殺者」"
  },
  State_73520_Desc = {
    Text = "死亡時、1点のライフを保持し、すべてのダメージを無効化し、行動予測は「連結解除」に変化する。"
  },
  State_73520_Name = {
    Text = "「連結者」"
  },
  State_73533_Desc = {
    Text = "プレイヤーターン終了時に手札を捨てなくなる。戦闘開始時、プレイヤーの手札上限を8に変更する。"
  },
  State_73533_Name = {
    Text = "巣群感応"
  },
  State_73535_Desc = {
    Text = "自身のターン中、受けるダメージが75％減少。力が減少される時、50%の力の層数のみ減少する。"
  },
  State_73535_Name = {
    Text = "自体保護"
  },
  State_73566_Desc = {
    Text = "非指令カードを1枚使用するたび、[Power:StateArg1]点の<PowerIconKeywords:力>と<Block:[Block:StateArg2]>点のシールドを獲得。"
  },
  State_73566_Name = {
    Text = "「通信者」"
  },
  State_73567_Desc = {
    Text = "非指令カードを1枚使用するたび、[Power:StateArg1]点の<PowerIconKeywords:力>と<Block:[Block:StateArg2]>点のシールドを獲得。"
  },
  State_73567_Name = {
    Text = "「通信者」"
  },
  State_73570_Desc = {
    Text = "非指令カードを1枚使用するたび、[Power:StateArg1]点の<PowerIconKeywords:力>と<Block:[Block:StateArg2]>点のシールドを獲得。"
  },
  State_73570_Name = {
    Text = "「通信者」"
  },
  State_73573_Desc = {
    Text = "非指令カードを1枚使用するたび、[Power:StateArg1]点の<PowerIconKeywords:力>と<Block:[Block:StateArg2]>点のシールドを獲得。"
  },
  State_73573_Name = {
    Text = "「通信者」"
  },
  State_73649_Desc = {
    Text = "チームのダメージ強化が[Layer]%増加する。"
  },
  State_73649_Name = {
    Text = "虚無に堕ちた人形"
  },
  State_73655_Name = {
    Text = "有機形態マーク"
  },
  State_73664_Name = {
    Text = "アクセサリーの有機形態効果"
  },
  State_73664_WeaponDesc = {
    Text = "装備者が狂気解放を使用した後、そのターン内で自身のシールドと治療の強力が2倍になる。"
  },
  State_74012_Desc = {
    Text = "すべての敵に最大ライフの[StateArg1]%の<FixedDamage:純粋ダメージ>(最低[DescArg1])を与える。使用後「メルトダウン・ドル」の特定スキルが「終末形態」に変わる。"
  },
  State_74012_Name = {
    Text = "虚無終結"
  },
  State_74013_Desc = {
    Text = "すべての敵に最大ライフの[StateArg1]%の<FixedDamage:純粋ダメージ>を与える。このダメージは自身の最大ライフの500%を下回らない。使用後「メルトダウン・ドル」の特定スキルが「終末形態」に変わる。"
  },
  State_74013_Name = {
    Text = "虚無終結"
  },
  State_74014_Desc = {
    Text = "すべての敵に最大ライフの[StateArg1]%の<FixedDamage:純粋ダメージ>を与える。このダメージは自身の最大ライフの500%を下回らない。失われたライフの30%を回復。使用後「メルトダウン・ドル」の特定スキルが「終末形態」に変わる。"
  },
  State_74014_Name = {
    Text = "虚無終結"
  },
  State_74015_Desc = {
    Text = "すべての敵に最大ライフの[StateArg1]%の<FixedDamage:純粋ダメージ>(最低[DescArg1])を与える。ライフを<Heal:[Heal:DescArg2]>回復。使用後「メルトダウン・ドル」の特定スキルが「終末形態」に変わる。"
  },
  State_74015_Name = {
    Text = "虚無終結"
  },
  State_74019_Desc = {
    Text = "すべての覚醒体が付与する毒、反撃、基礎ダメージが[Layer]%増加。"
  },
  State_74019_Name = {
    Text = "狂乱感染"
  },
  State_74142_Desc = {
    Text = "探索開始後、体力、攻撃、防御が[StateArg1]％増加する"
  },
  State_74142_Name = {
    Text = "霊塑適性"
  },
  State_74219_Name = {
    Text = "使用後、手札に戻る"
  },
  State_74273_Desc = {
    Text = "血ノ鎖・ヘロットが与えるアクティブダメージの際、[StateArg1]%の出血が追加され、[Layer]ターン継続する。"
  },
  State_74273_Name = {
    Text = "呪縛の鎖"
  },
  State_74771_Desc = {
    Text = "「狂気解放」を1回発動させるのに必要な狂気の療。"
  },
  State_74771_Name = {
    Text = "狂気上限"
  },
  State_74788_Desc = {
    Text = "\n・存在のパラドックス：探索開始時、死亡抵抗の75%を最大ライフ値ボーナスに変換し、最大300%の死亡抵抗を変換、最大10%の最大ライフを向上。死亡抵抗が発動するたびに「シルバーキーの微光」を1枚手札に追加。\n・無底の傷：ボス戦で、我々の受けるライフ回復量がライフ上限の100%に達するたび、後続のライフ回復効果を25%減少させ、しかし現在の死亡抵抗総量を25%上げ、最大3回発動可能。\n・プリズムレンズ：ターン開始時、反撃がライフ上限の750%を超えた場合、超過部分の層数を半分にし、永久反撃は最大2250%のライフ上限まで積み上げ可能；敵が毒によってライフ上限の1000%を超えた場合、超過部分の層数を半分にし、毒は最大3000%のライフ上限まで積み上げ可能。覚醒体は反撃により獲得するダメージボーナス量が70%減少するが、すべての毒と反撃を10%増加させる。敵のターン開始時、霊知覚醒が1つ発動されるごとに、現在の永久反撃の25％の一時反撃を獲得し、すべての敵の25％の毒を発動する。\n・運命の光錐：通常モンスターの「凝視」発動ターン数が6ターンに変わる。すべての戦闘に15ターンの制限があるが、15ターン開始時に「光錐界限」を1枚手札に追加：シルバーキーエネルギーとすべての覚醒体の狂気を最大値まで充填する。"
  },
  State_74788_Name = {
    Text = "（一時廃止）"
  },
  State_74791_Desc = {
    Text = "\n·計算力調和：1ターン内に発射した指令カードが10枚に達した後、指令カードを1枚発射するごとに「算力調和」を1スタック獲得する。「算力調和」により、本ターン内で指令カードを発射するたびに行動力消費+1となり、その消費した追加行動力1点ごとに100%の覚醒体キーチャージのキーエネルギーに変換される（重複可能）。超次元空間発動後、算力調和効果をリセットする。\n·計算力満杯：カードを発射した後、そのカードの本ターン内の行動力消費低下効果を除去する。戦闘中の現在の行動力が12を超えた場合、超過した行動力1点ごとに自動的に300%のチーム平均キーチャージのキーエネルギーに変換される。\n·狂気調和：狂気の割合上昇効果が半減する。覚醒体が狂気解放を発動するたびに、その基礎狂気+10。ターン終了時、狂気解放を発動しなかった覚醒体1体ごとに、200%のチーム平均キーチャージのキーエネルギーを獲得する。"
  },
  State_74791_Name = {
    Text = "キーエネルギー調和"
  },
  State_74809_Name = {
    Text = "「終末形態」：追加でカードを3枚引き、3点の行動力を獲得。すべての敵に[DescArg1]%の<IntoxicationIconKeywords:毒>を付与。「溶融・ドール」の狂気上限が50増加。最大3回。"
  },
  State_74826_Name = {
    Text = "ランダムに [DescArg1] 点の<FixedDamage:純粋ダメージ>を [DescArg2] 回与える（このダメージは1倍の力ボーナスを受ける）"
  },
  State_74827_Name = {
    Text = "このターン、すべての覚醒体のクリティカルとクリティカルダメージが[DescArg1]%増加する"
  },
  State_74828_Name = {
    Text = "すべての敵に[DescArg1]点の毒を付与する"
  },
  State_74829_Name = {
    Text = "全体の敵に失ったライフの [DescArg1]% に等しい<FixedDamage:純粋ダメージ>を与える"
  },
  State_74830_Name = {
    Text = "[DescArg1]点の力を獲得"
  },
  State_74831_Name = {
    Text = "すべての覚醒体が[DescArg1]狂気を獲得する"
  },
  State_74847_Desc = {
    Text = "チーム唯一：装備者が毎ターン使用する最初の指令カードの基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。その指令カードが超次元空間に入った場合、装備者は<WeaponEffect_Num:[StateArg2]>点の狂気を獲得する。"
  },
  State_74847_WeaponDesc = {
    Text = "装備者が毎ターン使用する最初の指令カードの基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。その指令カードが超次元空間に入った場合、装備者は<WeaponEffect_Num:[StateArg2]>点の狂気を獲得する。"
  },
  State_74879_Name = {
    Text = "[DescArg1]点の行動力を獲得"
  },
  State_74881_Name = {
    Text = "覚醒体を1体選択し、[DescArg1]狂気を獲得させる"
  },
  State_74882_Name = {
    Text = "[DescArg1]点の界域知識を獲得"
  },
  State_74883_Name = {
    Text = "次に使用する[DescArg1]枚の指令カードは、追加で[DescArg2]キーエネルギーを獲得する"
  },
  State_74884_Name = {
    Text = "このターンに与える毒、反撃、出血が[DescArg1]%増加する"
  },
  State_74885_Name = {
    Text = "すべての覚醒体が[DescArg1]狂気を獲得する"
  },
  State_74887_Name = {
    Text = "[DescArg1]点のシールドを獲得"
  },
  State_74888_Name = {
    Text = "[DescArg1]点の死亡抵抗を獲得"
  },
  State_74889_Name = {
    Text = "[DescArg1]点の反撃を獲得"
  },
  State_74890_Name = {
    Text = "すべての敵から[DescArg1]点の一時的な力を奪う"
  },
  State_74891_Name = {
    Text = "ランダムに [DescArg1] 点の<FixedDamage:純粋ダメージ>を [DescArg2] 回与える（このダメージは1倍の力ボーナスを受ける）"
  },
  State_74910_Desc = {
    Text = "チームユニーク：装備者が覚醒体「ラモナ」の場合、探索ステージで得る同調率を<WeaponEffect_Num:[StateArg1]%>上昇させる。"
  },
  State_74910_WeaponDesc = {
    Text = "装備者が覚醒体「ラモンナ」である場合、ステージをクリアした時に獲得する同調率が<WeaponEffect_Num:[StateArg1]%>増加する。"
  },
  State_74932_Desc = {
    Text = "「攻撃」「防御」「スキル」を使用すると、「禁忌の取引」の対応する効果が強化される。"
  },
  State_74932_Name = {
    Text = "禁忌の取引"
  },
  State_74947_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：ターン開始時、<HPAndShieldMin:ライフとシールドが最も低い>敵に [StateArg1] スタック数の行動封鎖を付与する。装備者がキルした後、即座にこの効果を一度発動する。"
  },
  State_74947_Name = {
    Text = "魔女のつば広帽子"
  },
  State_74948_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、最も狂気が高い敵に[StateArg1]狂気を失わせ、<PVPEmptinessKeywords:虚無>を付与する。"
  },
  State_74948_Name = {
    Text = "催眠ペンデュラム"
  },
  State_76236_Desc = {
    Text = "\n·シルバーキー覚醒：キーエネルギーが満タンの時、「シルバーキー覚醒」を追加選択して、指定した覚醒体の霊知啓発カードを手札に加え「保留」を付与できる。本戦闘中有効。「シルバーキー覚醒」は1ターンに1回のみ発動可能で、「キーオーダー」とは独立してクールダウンする。\n·シルバーキー超過：「シルバーキー覚醒」使用時、霊知啓発が解放済みの覚醒体が1体いるごとに、追加でキーエネルギーを1000点消費する。この効果によりキーエネルギーがマイナスになる場合がある。\n·アーカイブ刻印：守秘者がキーオーダーを1つ持つごとに、「物象研究の深度」と「霊識研究深度」を1％上昇させる（最大50％まで）。すべてのR命輪の効果は、装備者の次元影像遺物が出現する可能性を100%上昇させるものに変更される。"
  },
  State_76236_Name = {
    Text = "燦然たるシルバーグロー"
  },
  State_76277_Desc = {
    Text = "チーム唯一：ボス戦開始後、最大50黒章を消費し、1点の黒章を消費するごとに<WeaponEffect_Num:[StateArg1]%><DeathResistanceIconKeywords: 死亡抵抗>を獲得する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76277_WeaponDesc = {
    Text = "ボス戦開始後、最大50黒章を消費し、1点の黒章を消費するごとに<WeaponEffect_Num:[StateArg1]%><DeathResistanceIconKeywords: 死亡抵抗>を獲得する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76278_Desc = {
    Text = "唯一装備：新しいマスを1つ進むたび、失ったライフの<WeaponEffect_Num:[StateArg1]%>を回復する。復活の魂魄を使用した後、すべての覚醒体のクリティカル率とクリティカルダメージが100%増加する。星辰編では、効果が「装備者の次元影像遺物の出現率が100％増加する」に変更される。"
  },
  State_76278_WeaponDesc = {
    Text = "新しいマスを1つ進むたび、失ったライフの[StateArg1]%を回復する（[DescArg1]）。復活の魂魄を使用した後、すべての覚醒体のクリティカル率とクリティカルダメージが100%増加する。星辰編では、効果が「装備者の次元影像遺物の出現率が100％増加する」に変更される。"
  },
  State_76279_Desc = {
    Text = "チーム唯一：融痕で覚醒体を覚醒させる価格が<WeaponEffect_Num:[StateArg1]>点の黒章低下する。装備者の霊知覚醒が固有を獲得する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76279_WeaponDesc = {
    Text = "融痕で覚醒体を覚醒させる価格が<WeaponEffect_Num:[StateArg1]>点の黒章低下する。装備者の霊知覚醒が固有を獲得する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76280_Desc = {
    Text = "チーム唯一：休憩所の回復量が<WeaponEffect_Num:[StateArg1]%>増加する。ライフ回復を選択した後、2枚の「インスピレーション」をデッキに加える。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76280_WeaponDesc = {
    Text = "休憩所の回復量が<WeaponEffect_Num:[StateArg1]%>増加する。ライフ回復を選択した後、「インスピレーション」2枚をデッキに加える。星辰篇では、効果が「装備者の次元映像造物の出現確率が100％増加する」に変更される。"
  },
  State_76281_Desc = {
    Text = "チーム唯一：戦闘終了後、狂気が最も低い覚醒体が<WeaponEffect_Num:[StateArg1]>点の狂気を獲得する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76281_WeaponDesc = {
    Text = "戦闘終了後、狂気が最も低い覚醒体が<WeaponEffect_Num:[Energy:StateArg1]>点の狂気を獲得する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76282_Desc = {
    Text = "チーム唯一：融痕更新回数+1、更新価格が<WeaponEffect_Num:[StateArg1]>点の黒章減少する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76282_WeaponDesc = {
    Text = "融痕更新回数+1、更新価格が<WeaponEffect_Num:[StateArg1]>点の黒章減少する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76283_Desc = {
    Text = "チーム唯一：融痕造物枠が3つになり、そのうち1つは呪い造物となる。呪い造物を購入すると<WeaponEffect_Num:[StateArg1]>の黒印を獲得する。星辰篇では、効果が「装備者の次元映像造物の出現確率を100％増加させる」に変更される。"
  },
  State_76283_WeaponDesc = {
    Text = "融痕造物欄が3個になり、そのうち1つが呪い造物となる。呪い造物を購入後、<WeaponEffect_Num:[StateArg1]>点の黒章を獲得する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76284_Desc = {
    Text = "チーム唯一：ステージ開始後、すべての覚醒体が<WeaponEffect_Num:[StateArg1]>点の狂気を獲得する。ボス戦開始後、カードを2枚引く。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76284_WeaponDesc = {
    Text = "ステージ開始後、すべての覚醒体が<WeaponEffect_Num:[Energy:StateArg1]>点の狂気を獲得する。ボス戦開始後、カードを2枚引く。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76285_Desc = {
    Text = "チーム唯一：ステージ開始後、<WeaponEffect_Num:[StateArg1]>点の銀鍵エネルギーを獲得する。ボス戦開始後、2点の演算力を獲得する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76285_WeaponDesc = {
    Text = "ステージ開始後、<WeaponEffect_Num:[StateArg1]>点の銀鍵エネルギーを獲得する。ボス戦開始後、2点の演算力を獲得する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76286_Desc = {
    Text = "チーム唯一：休憩所で選択肢が一つ追加される：最大3枚の症状を消除し、<WeaponEffect_Num:[StateArg1]>点の黒章を獲得する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76286_WeaponDesc = {
    Text = "休憩所で選択肢が一つ追加される：最大3枚の症状を消除し、<WeaponEffect_Num:[StateArg1]>点の黒章を獲得する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76287_Desc = {
    Text = "チーム唯一：通常戦闘終了後に選択可能な刻印の数が4個になり、装備者カードの刻印が<WeaponEffect_Num:[StateArg1]%>の確率で高級刻印にアップグレードされる。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76287_WeaponDesc = {
    Text = "通常戦闘終了後に選択可能な刻印の数が4個になり、装備者カードの刻印が<WeaponEffect_Num:[StateArg1]%>の確率で高級刻印にアップグレードされる。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76288_Desc = {
    Text = "チーム唯一：戦闘終了後、<WeaponEffect_Num:[StateArg1]>キーエネルギーを獲得する。星辰篇では、効果が「装備者の次元映像造物の出現確率が100％増加する」に変更される。"
  },
  State_76288_WeaponDesc = {
    Text = "戦闘終了後、<WeaponEffect_Num:[StateArg1]>キーエネルギーを獲得する。星辰篇では、効果が「装備者の次元映像造物の出現確率が100％増加する」に変更される。"
  },
  State_76289_Desc = {
    Text = "チーム唯一：探索中視野+1、マップの視野が全開放された後<WeaponEffect_Num:[StateArg1]>黒印を獲得する。ボス戦開始時、すべての敵を1ターン<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:被ダメージ増加>にする。星辰篇では、効果が「装備者の次元映像造物の出現確率が100％増加する」に変更される。"
  },
  State_76289_WeaponDesc = {
    Text = "探索中視野+1、マップの視野が全開放された後<WeaponEffect_Num:[StateArg1]>黒印を獲得する。ボス戦開始時、すべての敵を1ターン<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:被ダメージ増加>にする。星辰篇では、効果が「装備者の次元映像造物の出現確率が100％増加する」に変更される。"
  },
  State_76290_Desc = {
    Text = "チーム唯一：通常戦闘終了後、刻印を放棄してライフ上限を<WeaponEffect_Num:[StateArg1]%>増加させることができる。この効果は最大2回まで発動する。星辰篇では、効果が「装備者の次元映像造物の出現確率を100％増加させる」に変更される。"
  },
  State_76290_WeaponDesc = {
    Text = "通常戦闘終了後、刻印を放棄してライフ上限を<WeaponEffect_Num:[DescArg1]>増加させることができる。この効果は最大2回まで発動する。星辰篇では、効果が「装備者の次元映像造物の出現確率を100％増加させる」に変更される。"
  },
  State_76291_Desc = {
    Text = "チーム唯一：ステージ開始後、<WeaponEffect_Num:[StateArg1]>黒印を獲得する。造物上限+2。星辰篇では、効果が「装備者の次元映像造物の出現確率が100％増加する」に変更される。"
  },
  State_76291_WeaponDesc = {
    Text = "ステージ開始後、<WeaponEffect_Num:[StateArg1]>黒印を獲得する。造物上限+2。星辰篇では、効果が「装備者の次元映像造物の出現確率が100％増加する」に変更される。"
  },
  State_76292_Desc = {
    Text = "チーム唯一：融痕のカード売却で症状カードを売却できるようになる。症状カードを売却した後、<WeaponEffect_Num:[StateArg1]>点の黒章を獲得する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76292_WeaponDesc = {
    Text = "融痕のカード売却で症状カードを売却できるようになる。症状カードを売却した後、<WeaponEffect_Num:[StateArg1]>点の黒章を獲得する。星辰篇では、効果が「装備者の次元映像造物が出現する可能性を100％上昇させる」に変更される。"
  },
  State_76321_Name = {
    Text = "レインボーレンズ"
  },
  State_76323_Name = {
    Text = "狂気調和"
  },
  State_76324_Name = {
    Text = "行動力調和"
  },
  State_76325_Desc = {
    Text = "[DescArg1] 枚の指令カードを使用後、「行動力調和」状態に入る。"
  },
  State_76325_Name = {
    Text = "行動力調和"
  },
  State_76326_Name = {
    Text = "存在のパラドックス"
  },
  State_76328_Name = {
    Text = "運命の光錐"
  },
  State_76337_Name = {
    Text = "底なしの創痕"
  },
  State_76338_Desc = {
    Text = "プレイヤーの治癒効果が[Layer]%減少。"
  },
  State_76338_Name = {
    Text = "底なしの創痕"
  },
  State_76430_Name = {
    Text = "次元イメージ・リリ"
  },
  State_76433_Name = {
    Text = "行動力調和"
  },
  State_76434_Desc = {
    Text = "指令カードを使用するたび、「行動力調和」によって追加で行動力を消費した場合、追加で覚醒体のキーチャージの100%分のキーエネルギーを獲得する。累積可能。"
  },
  State_76434_Name = {
    Text = "行動力調和"
  },
  State_76435_Name = {
    Text = "レインボーレンズ"
  },
  State_76528_Name = {
    Text = "このカードは「攻撃」として扱う。"
  },
  State_76529_Desc = {
    Text = "獲得時、1枚の覚醒体のカードを選び、その行動力消費を1減少し、使用後に1枚のカードを引き、「攻撃」として扱う。"
  },
  State_76533_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時およびターン終了時、相手のランダムな手札[StateArg1]枚に[StateArg2]点の<PVPAcheKeywords:隠された痛み>を付与する。"
  },
  State_76533_Name = {
    Text = "隠された痛み"
  },
  State_76553_Desc = {
    Text = "このカードの行動力消費-[StateArg1]。"
  },
  State_76553_Name = {
    Text = "百万の寵愛の眼"
  },
  State_77686_Name = {
    Text = "半機械形態"
  },
  State_77688_Desc = {
    Text = "第5ターン開始時または撃破されそうな時、死亡を無効化し、行動予測を「機械昇華」に転換する。"
  },
  State_77688_Name = {
    Text = "肉体脆弱"
  },
  State_77690_Desc = {
    Text = "「半機械形態」へ切り替えた後、「終末」1点ごとに追加で10%の最大ライフを獲得。「半機械形態」では、「終末」点数が増加するにつれて「溶壊・ドール」がより脅威的なスキルを解放する。"
  },
  State_77690_Name = {Text = "終末"},
  State_77692_Desc = {
    Text = "ターン終了時、融蝕の怪物を2体召喚する。最大2体まで同時に存在可能。召喚された融蝕の怪物が撃破されると、「溶融・ドール」は最大ライフの5%を失う。"
  },
  State_77692_Name = {
    Text = "深淵の門"
  },
  State_77693_Desc = {
    Text = "撃破されると「溶融・ドール」は最大ライフの5%を失う。"
  },
  State_77693_Name = {Text = "溶解"},
  State_78102_Desc = {
    Text = "与えるダメージが15%減少し、受けるダメージが30%増加する。戦闘終了まで持続。"
  },
  State_78102_Name = {
    Text = "システムダウン"
  },
  State_78694_Desc = {
    Text = "戦闘開始時、[Arg1]点の力を獲得する。ターン開始時、[Arg2]点の永続の力ごとに[Arg3]点の一時的な力を獲得し、最大[Arg4]点まで一時的な力を獲得し、ターン終了時、この遺物によって獲得した一時的な力の半分のシールドを失う。"
  },
  State_78696_Desc = {
    Text = "シルバーキー覚醒を使用した後、対応する覚醒体の [Arg1] 枚の「スキル」を消費し、「除外」が付与されたコピーを [Arg2] 枚山札のランダムな位置に追加する。__「開発用」"
  },
  State_78697_Desc = {
    Text = "ターン開始時、[Arg2] 層の毒が付与され、超次元空間で空きが1つあるごとに[Arg1]点の力を獲得。__「開発用」"
  },
  State_78698_Desc = {
    Text = "行動力上限 -[Arg1]。行動力消費が [Arg2] 以上のカードを1枚使用するごとに1点の行動力を獲得することができ、1ターンにつき最大 [Arg3] 回まで発動。__「開発用」"
  },
  State_78699_Desc = {
    Text = "ドロー後に追加で[Arg1]枚のカードを引きますが、[Arg2]枚の手札を選んで捨てます。__「開発用」"
  },
  State_78700_Desc = {
    Text = "すべての覚醒体の基礎ダメージが[Arg1]%増加し、山札をリセットするたび追加で[Arg2]%増加するが、「よろよろ」を1枚手札に追加し、増加値は最大[Arg3]%。"
  },
  State_78701_Desc = {
    Text = "ターン開始時に永久触腕が [Arg1] 条超えた場合、[Arg2] 条触腕を失い、[Arg3] 条の一時的な触腕を獲得。そうでなければ[Arg4] 条の一時的な触腕を獲得。__「開発用」"
  },
  State_78702_Desc = {
    Text = "シルバーキー覚醒後、追加で[Arg1]キーエネルギーを消費し、獲得した霊知覚醒カードの行動力消費を0にし、使用後、対応する覚醒体に追加で[Arg2]狂気を獲得させる。"
  },
  State_78703_Desc = {
    Text = "戦闘開始時にすべての敵に[Arg1]点の毒を与える。ターン開始前に敵の[Arg2]%の毒を除去し、[Arg3]%の除去量の出血を敵に付与する。__「開発用」"
  },
  State_78710_Desc = {
    Text = "指令カードを1枚出すごとに、対応する覚醒体がそのターンの最終ダメージを[Arg1]%増加させるが、[Arg2]狂気を失う。1ターンに最大[Arg3]回まで発動可能。__「開発用」"
  },
  State_78712_Desc = {
    Text = "ターン開始時に胚胎融合度+ [Arg1]、あなたの胚はターン終了時に捨てられます。__「開発用」"
  },
  State_78713_Desc = {
    Text = "ターン開始時、[Arg1]点の反撃を獲得する。1ターン内に狂気解放を[Arg2]回発動した後、自身の永続反撃を[Arg3]%解除し、解除した量の[Arg4]%の一時的反撃を獲得し、クールダウン[Arg5]ターン。"
  },
  State_78781_Desc = {
    Text = "対象の力を一時的に減少させ、同量の一時的な力を獲得。"
  },
  State_78781_Name = {
    Text = "<TouquKeywords: 奪う>"
  },
  State_79405_Desc = {
    Text = "打出後「清明の憶い」が 1 上昇し、10 に達すると 1 ターン固定され、3 枚の「インスピレーション」を獲得します。次のターン開始時に 5 にリセットされます。"
  },
  State_79405_Name = {
    Text = "真実の過去"
  },
  State_79406_Desc = {
    Text = "使用後「清明の憶え」が 1 下がり、0 になったとき 1 ターンロックし、すべての覚醒体に 30 pt の狂気を獲得させる。次のターン開始時に 5 にリセットされる。"
  },
  State_79406_Name = {
    Text = "華やかな夢"
  },
  State_80052_Desc = {Text = "テスト"},
  State_80052_Name = {
    Text = "テスト123"
  },
  State_80052_WeaponDesc = {Text = "テスト"},
  State_80161_Desc = {
    Text = "唯一装備：装備者の「狂気解放」が与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加し、キーチャージが <WeaponEffect_Num:[StateArg2]%>増加する。超次元ターン開始後、すべての覚醒体が<WeaponEffect_Num:[StateArg4]>狂気を獲得する。「湮滅」発動後、装備者は<WeaponEffect_Num:[StateArg3]>狂気を獲得する。"
  },
  State_80161_WeaponDesc = {
    Text = "装備者の「狂気解放」による基礎ダメージが<WeaponEffect_Num:[StateArg1]%>上昇し、キーチャージが<WeaponEffect_Num:[DescArg1]>上昇する。超次元ターンに入ると、すべての覚醒体が<WeaponEffect_Num:[StateArg4]>点の狂気を獲得する。「湮滅」を発動した後、装備者は<WeaponEffect_Num:[StateArg3]>点の狂気を獲得する。"
  },
  State_80174_Desc = {
    Text = "唯一装備：装備者のキーチャージが<WeaponEffect_Num:[StateArg1]%>増加する。最初の戦闘開始後、すべての敵に1点の虚弱と負傷を与える。"
  },
  State_80174_WeaponDesc = {
    Text = "装備者のキーチャージが <WeaponEffect_Num:[DescArg1]>増加する。最初の戦闘開始後、すべての敵に1点の虚弱と負傷を与える。"
  },
  State_80207_Desc = {
    Text = "このカードを使用した後に「次元転送」が発動した場合、後続の効果を発動できる。超次元空間から取り出した時、そのカードの行動力消費–1。"
  },
  State_80207_Name = {
    Text = "<WormholeKeywords:超距離>"
  },
  State_80328_Desc = {
    Text = "彼女の感情、認識、あらゆるものが巣の意志と永遠に結びついている。最大15点まで累積可能。クレメンタインの狂気解放「生命再構築治療」によってデバフ効果に変換される。"
  },
  State_80331_Desc = {
    Text = "巣群の侵蝕の下、あなたの弱点が露わになる。このターンに受けるアクティブおよび触手ダメージが [DescArg1]％ 上昇する。"
  },
  State_80331_Name = {
    Text = "<D13Colour:心的外傷>"
  },
  State_80332_Desc = {
    Text = "彼女の感情、認識、あらゆるものが巣の意志と永遠に結びついている。最大10点まで累積可能。クレメンタインの狂気解放「生命再構築治療」によってデバフ効果に変換される。"
  },
  State_80335_Desc = {
    Text = "巣群の侵蝕の下、あなたの弱点が露わになる。このターンに受けるアクティブおよび触手ダメージが [DescArg1]％ 上昇する。"
  },
  State_80335_Name = {
    Text = "<D13Colour:心的外傷>"
  },
  State_80336_Desc = {
    Text = "巣群の侵蝕の下、あなたの恐怖は隠しきれない。このターンに与えるアクティブおよび触手ダメージが [DescArg1]％ 減少する。"
  },
  State_80336_Name = {
    Text = "<D13Colour:恐怖の固着>"
  },
  State_80338_Desc = {
    Text = "巣群の侵蝕の下、あなたの恐怖は隠しきれない。このターンに与えるアクティブおよび触手ダメージが [DescArg1]％ 減少する。"
  },
  State_80338_Name = {
    Text = "<D13Colour:恐怖の固着>"
  },
  State_80575_Desc = {
    Text = "アクティブダメージまたは触手ダメージを受けた後、同量の「古の残り火」を除去し、除去した量の300%のライフを失う。その他のダメージを受けた場合、半分を除去する。「古の残り火」の点数は毎ターンリセットされる。"
  },
  State_80575_Name = {
    Text = "古の残り火"
  },
  State_80644_Name = {
    Text = "状態@超越の光中"
  },
  State_80773_Desc = {
    Text = "力減少効果を受けた時、力のスタック数が50%しか減少しない。自身のターン中、受けるアクティブおよび触手ダメージ以外のダメージが100％上昇する。"
  },
  State_80773_Name = {
    Text = "異次元抗体"
  },
  State_80774_Desc = {
    Text = "アクティブダメージまたは触腕ダメージを受けた時、同量の「古の残り火」を除去し、除去した量の300%のライフを失う。その他のダメージを受けた場合は、半分を除去する。「古の残り火」の点数は毎ターンリセットされる。「古の残り火」がすべて除去された後、50点の「堅固」を獲得する。"
  },
  State_80774_Name = {
    Text = "古の残り火"
  },
  State_80777_Desc = {
    Text = "戦闘開始時、すべての覚醒体のクリティカル率が10%減少する。死亡後、他の味方が[DescArg1]点の力と[DescArg2]点の「古の残り火」を獲得。"
  },
  State_80777_Name = {
    Text = "巣の共感・伝承"
  },
  State_80778_Desc = {
    Text = "死亡後、他の味方が 1 スタックの一時的<MadnessIconKeywords:発狂>を獲得する。"
  },
  State_80778_Name = {
    Text = "巣の共感・融合"
  },
  State_80782_Desc = {
    Text = "この戦闘中、すべての覚醒体のクリティカル率が[Layer]%減少。"
  },
  State_80782_Name = {
    Text = "クリティカル率減少"
  },
  State_80783_Desc = {
    Text = "ターン終了時、1スタックの<MadnessIconKeywords:発狂>を獲得する。"
  },
  State_80783_Name = {
    Text = "同族の絆"
  },
  State_80784_Desc = {
    Text = "ライフが50%未満になると、後列に「最初の変異体」を召喚する。戦闘ごとに1回のみ発動する。"
  },
  State_80784_Name = {
    Text = "巣の共感・分裂"
  },
  State_80785_Desc = {
    Text = "力が降低される時、力のスタック数が50％しか降低されない。プレイヤーが狂気解放を放す度に、1スタックの一時的<MadnessIconKeywords:発狂>を獲得する。"
  },
  State_80785_Name = {
    Text = "巣の共感・異次元"
  },
  State_80788_Desc = {
    Text = "力が降低される時、力のスタック数が25％しか降低されない。プレイヤーが狂気解放を放す度に、1スタックの一時的<MadnessIconKeywords:発狂>を獲得する。"
  },
  State_80788_Name = {
    Text = "巣の共感・異次元"
  },
  State_80789_Desc = {
    Text = "受けるアクティブおよび触手ダメージが100％上昇し、1ターン持続する。"
  },
  State_80789_Name = {Text = "潜伏"},
  State_80790_Desc = {
    Text = "点数が多いほど、変異を遂げた後の姿は完全体へと近づく……"
  },
  State_80790_Name = {
    Text = "宇宙のエーテル"
  },
  State_80792_Desc = {
    Text = "プレイヤーが狂気解放を発動するたびに、1 スタックの一時的<MadnessIconKeywords:発狂>を獲得する。"
  },
  State_80792_Name = {
    Text = "巣の共感・異次元"
  },
  State_80794_Desc = {
    Text = "カード使用不可、ターン終了後も手札に残る。"
  },
  State_80794_Name = {
    Text = "<Boundkeywords:呪縛>"
  },
  State_80807_Desc = {
    Text = "5ターン目が開始または撃破されそうになった場合、他の敵をすべて排除し、行動予測を「変異の瞬間」に転換する。"
  },
  State_80807_Name = {
    Text = "変異の瞬間"
  },
  State_80809_Desc = {
    Text = "ターン終了時、手札にある虚無を持つカードは捨てられる。"
  },
  State_80809_Name = {
    Text = "<PVPVoidKeyColour:虚無>"
  },
  State_80810_Desc = {
    Text = "アクティブダメージまたは触手ダメージを受けた後、同量の「古の残り火」を除去し、除去した量の300%のライフを失う。その他のダメージを受けた場合、半分を除去する。「古の残り火」の点数は毎ターンリセットされる。"
  },
  State_80810_Name = {
    Text = "古の残り火"
  },
  State_80827_Desc = {
    Text = "合計15枚のカードを使用するたび、現在の行動予測を「外傷猛撃」に転換する。（残り[Layer]枚)"
  },
  State_80827_Name = {
    Text = "怒りの懲罰"
  },
  State_81022_WeaponDesc = {
    Text = "1つのダメージを受けたとき、全員の覚醒体に1ポイントの狂気を追加する。"
  },
  State_81027_Desc = {
    Text = "このカードの所持者は「虫族」となる。行動力消費-1。使用後に「除外」される。"
  },
  State_81027_Name = {
    Text = "命の儀式"
  },
  State_81054_Desc = {
    Text = "巣群の侵蝕の下、あなたの恐怖は逃げ場を失う。1スタックごとに今ターン与えるアクティブダメージと触手ダメージが3％減少し、最大15スタックまで蓄積する。"
  },
  State_81054_Name = {
    Text = "<D13AFKeyWordQ1:恐怖の固着>"
  },
  State_81055_Desc = {
    Text = "巣群の侵蝕の下、あなたの恐怖は逃げ場を失う。1スタックごとに今ターン受けるアクティブダメージと触手ダメージが3％上昇し、最大10スタックまで蓄積する。"
  },
  State_81055_Name = {
    Text = "<D13AFKeyWord2:心的外傷>"
  },
  State_81056_Desc = {
    Text = "巣群の侵蝕の下、あなたの恐怖は逃げ場を失う。1スタックごとに今ターン受けるアクティブダメージと触手ダメージが3％上昇し、最大15スタックまで蓄積する。"
  },
  State_81056_Name = {
    Text = "<D13AFKeyWordQ2:心的外傷>"
  },
  State_81057_Desc = {
    Text = "巣群の侵蝕の下、あなたの恐怖は逃げ場を失う。1スタックごとに今ターン与えるアクティブダメージと触手ダメージが3％減少し、最大10スタックまで蓄積する。"
  },
  State_81057_Name = {
    Text = "<D13AFKeyWord1:恐怖の固着>"
  },
  State_81058_Desc = {
    Text = "彼女の感情、認識、あらゆるものが巣の意志と永遠に結びついている。クレメンタインの狂気解放「生命再構築治療」を発動した時、デバフ効果に変換される。最大15点まで累積可能。"
  },
  State_81059_Desc = {
    Text = "彼女の感情、認識、あらゆるものが巣の意志と永遠に結びついている。クレメンタインの狂気解放「生命再構築治療」を発動した時、デバフ効果に変換される。最大10点まで累積可能。"
  },
  State_81073_Desc = {
    Text = "致命的ダメージを受けた場合、即座にすべてのライフを回復し、80%の一時的な堅固を獲得し、後列に「最初の変異体」を1体召喚する。2回まで発動可能。"
  },
  State_81073_Name = {
    Text = "巣の共感・分裂"
  },
  State_81278_Desc = {
    Text = "毎ターン初めてキーの解放後、すべての覚醒体は10狂気を獲得するが、キーの解放消費が永久に10%増加する。"
  },
  State_81278_Name = {
    Text = "シルバーキー・サプレッション"
  },
  State_81312_Desc = {
    Text = "致命的ダメージを受けた後、すべてのライフを回復し、50点の一時的な堅固を獲得する。[Layer]回触発可能。"
  },
  State_81312_Name = {
    Text = "宇宙の輪廻"
  },
  State_81331_Desc = {
    Text = "ターン開始時に、覚醒体を1体選択し、そのすべてのカードと狂気解放を3ターン封印する。"
  },
  State_81331_Name = {
    Text = "意識幽閉"
  },
  State_81340_Desc = {
    Text = "このカードは封印されているため使用不可。[Layer]ターン後に解除される。"
  },
  State_81340_Name = {
    Text = "<Seal1:カード封印>"
  },
  State_81341_Desc = {
    Text = "この覚醒体の狂気爆発は封印されているため使用不可。[Layer]ターン後に解除される。"
  },
  State_81341_Name = {
    Text = "<Seal1:狂気の封印>"
  },
  State_81354_Desc = {
    Text = "使用後、[DescArg1]ダメージを受ける。ターン終了時に手札に残っている場合、これを除外する。"
  },
  State_81354_Name = {
    Text = "<BurningKeywords:燃焼>"
  },
  State_81356_Desc = {
    Text = "カードを燃焼させ、使用すると[DescArg1]ダメージを受ける。ターン終了時に手元に残っている場合、除外される。"
  },
  State_81356_Name = {
    Text = "<BurningKeywords:燃焼>"
  },
  State_81356_WeaponDesc = {
    Text = "各层の遅延により、カードの計算力消費が 1 ポイント増加します。"
  },
  State_83587_Desc = {
    Text = "「荒波の出航」の効果を強化する。上限は10点。"
  },
  State_83587_Name = {
    Text = "「出航」"
  },
  State_83589_Desc = {
    Text = "「休息の寄港」の効果を強化する。上限は10点。"
  },
  State_83589_Name = {
    Text = "「停泊」"
  },
  State_83593_Desc = {
    Text = "このターンにすべての覚醒体が与える最終ダメージが増加する"
  },
  State_83593_Name = {
    Text = "最終ダメージ"
  },
  State_83596_Desc = {
    Text = "手札の上限+1。ターン開始時、デッキに「航海士の選択」がない場合、これを手札に追加する。ボスが最大ライフの10%を失うたび、1点の「出航」を獲得する。自身が最大ライフの10%を失うたび、1点の「停泊」を獲得する。"
  },
  State_83596_Name = {
    Text = "エラスムスの導き -「出航」"
  },
  State_83607_Desc = {
    Text = "ボス累積損失10%の生命マーク"
  },
  State_83607_Name = {
    Text = "状態@ボス累積損失10%の生命マーカー"
  },
  State_83609_Desc = {
    Text = "プレイヤー累積損失10%の生命マーカー"
  },
  State_83609_Name = {
    Text = "状態@プレイヤー累積損失10%の生命マーカー"
  },
  State_83614_Desc = {
    Text = "プレイヤー10%の生命値"
  },
  State_83614_Name = {
    Text = "状態@プレイヤー10%の生命値"
  },
  State_83615_Desc = {
    Text = "ライフを[Layer]失うと、1点の「出航」を獲得。"
  },
  State_83615_Name = {
    Text = "「出航」獲得数"
  },
  State_83616_Desc = {
    Text = "ライフを[Layer]失うと、1点の「停泊」を獲得。"
  },
  State_83616_Name = {
    Text = "「停泊」獲得数"
  },
  State_83617_Desc = {
    Text = "ボス 10%のHP"
  },
  State_83617_Name = {
    Text = "状態@ボス10%の生命値"
  },
  State_83618_Desc = {
    Text = "テスト時の現在の生命は[Layer]ポイント"
  },
  State_83618_Name = {
    Text = "敵の現在の生命カウント"
  },
  State_83619_Desc = {
    Text = "テスト時の最大生命は[Layer]ポイント"
  },
  State_83619_Name = {
    Text = "敵の最大生命カウント"
  },
  State_83620_Desc = {
    Text = "現在のパラメータ4の値を100倍すると、[Layer] ポイントになります。"
  },
  State_83620_Name = {
    Text = "パラメータープリント"
  },
  State_83621_Desc = {
    Text = "ボスの10%のHP損失の計算中間値"
  },
  State_83621_Name = {
    Text = "状態@ボス10%の生命損失カウント中間値"
  },
  State_83622_Desc = {
    Text = "プレイヤー10%の生命損失カウント中間値"
  },
  State_83622_Name = {
    Text = "状態@プレイヤー10%の生命損失カウント中間値"
  },
  State_83627_Desc = {
    Text = "ライフを[Layer]失うと、1点の「出航」を獲得。"
  },
  State_83627_Name = {
    Text = "「出航」獲得数"
  },
  State_83807_Name = {
    Text = "遠き海に沈む"
  },
  State_83808_Desc = {
    Text = "このカードが捨てられた時、「余波」効果を発動する。"
  },
  State_83811_Desc = {
    Text = "追加で[Layer]%の触腕ダメージを受ける。"
  },
  State_83812_Desc = {
    Text = "追加で[Layer]%の触腕ダメージを受ける。"
  },
  State_83814_Desc = {
    Text = "ボス 10%のHP"
  },
  State_83814_Name = {
    Text = "ボスの10%のHP"
  },
  State_84140_Desc = {
    Text = "この戦闘は「喧騒の海」により、[Layer]枚の「腺体分裂」を消費しました。"
  },
  State_84140_Name = {
    Text = "賑やかな海"
  },
  State_84184_Name = {
    Text = "このスキルは追加で[Layer]%の力ボーナスを獲得"
  },
  State_84255_Desc = {
    Text = "唯一装備：戦闘開始時、裝備者の防御力の<WeaponEffect_Num:[StateArg1]%>に等しいシールドを獲得する。死亡抵抗を発動した後、次のターン開始時に同じ効果が発動する。"
  },
  State_84255_Name = {
    Text = "海上の航行者"
  },
  State_84255_WeaponDesc = {
    Text = "戦闘開始時、<WeaponEffect_Num:[Block:DescArg1]>点のシールドを獲得する。死亡抵抗を発動した後、次のターン開始時に同じ効果が発動する。"
  },
  State_84257_Desc = {
    Text = "唯一装備：裝備者の「狂気解放」で獲得するシールドが<WeaponEffect_Num:[StateArg1]%>増加する。「狂気解放」を発動した後、すべての覚醒体のクリティカルダメージが一時的に<WeaponEffect_Num:[StateArg2]%>増加し、触腕1本につき1%増加する。探索ごとに初めて死亡抵抗を発動した後、次のターン開始時に最大ライフの<WeaponEffect_Num:[StateArg3]%>を回復する。"
  },
  State_84257_WeaponDesc = {
    Text = "裝備者の「狂気解放」で獲得するシールドが<WeaponEffect_Num:[StateArg1]%>増加する。「狂気解放」を発動した後、すべての覚醒体のクリティカルダメージが一時的に<WeaponEffect_Num:[StateArg2]%>増加し、触腕1本につき1%増加する。探索ごとに初めて死亡抵抗を発動した後、次のターン開始時に最大ライフの<WeaponEffect_Num:[StateArg3]%>を回復する。"
  },
  State_84272_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、ライフが最も減少している味方のライフを<Heal:[Heal:StateArg1]>回復。"
  },
  State_84272_Name = {
    Text = "海上の導き手"
  },
  State_84273_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時およびターン開始時、自身が<PVPProtectiveKeywords:バリア>を持っていない場合は[StateArg1]点の<PVPProtectiveKeywords:バリア>を獲得し、そうでない場合は<Energy:[Energy:StateArg2]>狂気を獲得する。"
  },
  State_84273_Name = {
    Text = "聖火の導き"
  },
  State_84364_Desc = {
    Text = "クリティカルダメージ+[Layer]%。"
  },
  State_84364_Name = {
    Text = "クリティカルダメージ"
  },
  State_84368_Desc = {
    Text = "クールダウン残り[Layer]ターン。"
  },
  State_84368_Name = {
    Text = "遠き海に沈む"
  },
  State_84375_Desc = {
    Text = "ターン開始時、[Layer]ポイントのシールドを得る。"
  },
  State_84375_Name = {
    Text = "海上の航行者"
  },
  State_84376_Desc = {
    Text = "ターン開始時、[Layer]ポイントの生命を治療する。"
  },
  State_84376_Name = {
    Text = "聖なる炎の導き"
  },
  State_84399_Desc = {
    Text = "ターン終了時に受けるダメージが5%増加し、自身に2点のバリアを付与する。"
  },
  State_84399_Name = {
    Text = "遠き海に沈む"
  },
  State_84400_Desc = {
    Text = "ターン開始時、バリアが<ReinforcePVEKeywords:堅固>に変化する。"
  },
  State_84400_Name = {
    Text = "「航行」"
  },
  State_84402_Desc = {
    Text = "受けるすべてのダメージが[Layer]%増加する。"
  },
  State_84402_Name = {
    Text = "力の消耗"
  },
  State_89340_Desc = {
    Text = "追加で[Layer]%の触腕ダメージを受ける。"
  },
  State_89340_Name = {
    Text = "タッチアーム弱点"
  },
  State_89422_Desc = {
    Text = "すべての覚醒体が獲得する狂気が100%増加し、毎ターン「狂気解放」を2回発動可能。。"
  },
  State_89422_Name = {
    Text = "「不屈の心」"
  },
  State_89447_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：手札上限+[StateArg2]。「狂気解放」後、[StateArg1]算力を獲得。"
  },
  State_89447_Name = {
    Text = "耐え難き自由"
  },
  State_89448_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、ライフとシールドが最も低い味方に<PVPDerivativeCardKeywords_16:「黒羽」>を[StateArg1]枚付与する。"
  },
  State_89448_Name = {
    Text = "孤高の羽"
  },
  State_89554_Name = {
    Text = "運命の光錐"
  },
  State_89555_Desc = {
    Text = "チームユニーク：装備者が狂気解放を発動した後、狂気解放の基礎ダメージを<WeaponEffect_Num:[StateArg1]%>上昇させ、シールドとライフ回復を<WeaponEffect_Num:[StateArg2]%>上昇させ、最大5回まで重複する。装備者が探索で得る同調率を<WeaponEffect_Num:[StateArg3]%>上昇させる。"
  },
  State_89555_WeaponDesc = {
    Text = "装備者が「狂気解放」を発動した後、「狂気解放」が与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加し、獲得するシールドと与えるライフ回復効果が<WeaponEffect_Num:[StateArg2]%>増加し、最大5回まで累積可能。探索完了後、装備者の獲得する同調率が<WeaponEffect_Num:[StateArg3]%>増加する。"
  },
  State_89557_Name = {
    Text = "プリズムレンズ"
  },
  State_89559_Desc = {
    Text = "\n·存在パラドックス：探索開始時、デスレジスタンスの 75％ が最大ライフボーナスに変換され、最大 300％ のデスレジスタンスを変換でき、最大ライフを最大 10％ 上昇させる。デスレジスタンスが発動するたびに追加で「シルバーキーの微光」1 枚を手札に加える。\n·無底の創痕：ボスバトル中、味方が受けるライフ回復量がライフ上限の 100% に達するたびに、以降受けるライフ回復効果が 25% 低下するが、現在のデスレジスタンス総量が 25% 上昇する。最大 3 回まで発動する。\n·プリズムレンズ：ターン開始時、カウンターがライフ上限の 2000％ を超えた場合、超過分のスタック数を半減し、永久カウンターはライフ上限の 6000％ まで最大スタック可能になる；敵の毒がライフ上限の 3000％ を超えた場合、超過分のスタック数を半減し、毒はライフ上限の 9000％ まで最大スタック可能になる。覚醒体がカウンターから得るダメージボーナス量が 70% 低下するが、与える全ての毒とカウンターが 10% アップする。覚醒体を 1 体覚醒させるたびに：ターン終了後、現在の永久カウンターの 25% の一時的カウンターを獲得し、敵のターン終了時に全ての敵の毒 25% を追加で発動する。\n·運命の光錐：通常モンスターが「凝視」を発動するターン数が 6 ターンになる。第 15 ターン開始時、「光錐の境界」1 枚を手札に加える：キーエネルギーと全ての覚醒体の狂気を最大値まで充填する。"
  },
  State_89559_Name = {
    Text = "時空歪曲"
  },
  State_89567_Desc = {
    Text = "このカードの行動力消費-[StateArg1]。"
  },
  State_89567_Name = {
    Text = "滅土からの再生"
  },
  State_89568_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備者が死亡した後、自身の行動力消費が-[StateArg1]されたすべての「スキル」を山札のランダムな位置に追加し、所有者を残りライフが最も高い味方に変更する。"
  },
  State_89568_Name = {
    Text = "滅土からの再生"
  },
  State_89571_Name = {
    Text = "「燃える劇場」"
  },
  State_89572_Desc = {
    Text = "ターン開始時、相手のデッキにあるランダムなカード[DescArg1]枚に<BurningKeywords:燃焼>を付与し、[DescArg2]点の一時的な力を獲得する。2ターンごとに、「燃焼」を付与するカードが1枚増加し、獲得する一時的な力が[DescArg3]点増加する。"
  },
  State_89572_Name = {
    Text = "「燃える劇場」"
  },
  State_89626_Desc = {
    Text = "シルバーキー覚醒後、「シルバーキーの微光」を1枚手札に追加する。すべての覚醒体が霊知覚醒した後、毎ターン開始時にランダムな覚醒体1体の支援を発現する。"
  },
  State_89631_Desc = {
    Text = "追加「跳躍」[Layer]回"
  },
  State_89634_Desc = {
    Text = "知恵の覚醒4"
  },
  State_89634_Name = {
    Text = "知恵の覚醒4"
  },
  State_89637_Desc = {
    Text = "毎ターン初めて使用する指令カードは、追加で1回効果を発動する。「湮滅」使用時、触腕を1本獲得。触腕姿勢を「怒涛」に切り替えた後、このターンに使用する2枚の指令カードは「跳躍」効果が必ず発動し、超次元空間に置かれる。クールダウン3ターン。"
  },
  State_89640_Desc = {
    Text = "界域知識が200点増加。猩紅炉を消費した場合、消費量の15%の触腕ダメージを獲得する。触腕が攻撃するたび、[Arg3]点の猩紅炉を蓄積する。"
  },
  State_89642_Desc = {
    Text = "手札の上限+2。「狂気解放」を発動後、一時的な最終ダメージが10%増加する。カードが超次元空間に置かれた後、手札にある「胎児」1枚を「聖純の子」に変換する。「胎児」を1枚獲得するたび、超次元空間にあるランダムなカードの行動力消費が1減少する。"
  },
  State_89669_Desc = {
    Text = "銀钥觉醒4"
  },
  State_89669_Name = {
    Text = "銀钥觉醒4"
  },
  State_89759_Desc = {
    Text = "「キーオーダー」を発動後、ラモンナは50%の一時的なクリティカル率を獲得する。"
  },
  State_89759_Name = {
    Text = "貴重な絆"
  },
  State_90023_Name = {
    Text = "定数表設定用のステータスで、一時的に廃止されました。"
  },
  State_90059_Desc = {
    Text = "このターンにアクティブダメージまたは触腕ダメージを受けた場合、同量の侵蝕を除去し、除去した量の300%のライフを失う。それ以外のダメージを受けた場合は、ダメージの50%の侵蝕を除去する。"
  },
  State_90059_Name = {Text = "侵蝕"},
  State_90094_Name = {Text = "黒い羽"},
  State_90218_Desc = {
    Text = "唯一装備：手札の上限+2、同じ効果は重複しない。装備者が獲得するシールドと与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加し、超次元ターン開始後、<WeaponEffect_Num:[StateArg2]>狂気を獲得する。「湮滅」使用後、すべての覚醒体の一時的なクリティカルダメージが<WeaponEffect_Num:[StateArg3]%>増加し、クールダウン3ターン。"
  },
  State_90218_WeaponDesc = {
    Text = "手札の上限+2、同じ効果は重複しない。装備者が獲得するシールドと与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加し、超次元ターン開始後、<WeaponEffect_Num:[StateArg2]>狂気を獲得する。「湮滅」使用後、すべての覚醒体の一時的なクリティカルダメージが<WeaponEffect_Num:[StateArg3]%>増加し、クールダウン3ターン。"
  },
  State_90221_Desc = {
    Text = "唯一装備：装備者の獲得するシールドが <WeaponEffect_Num:[StateArg1]%>増加し、ターン終了時、装備者の防御力の<WeaponEffect_Num:[StateArg2]%>分のシールドを獲得する。毎ターン防御力が2％増加する。"
  },
  State_90221_Name = {
    Text = "孤高の羽"
  },
  State_90221_WeaponDesc = {
    Text = "装備者の獲得するシールドが <WeaponEffect_Num:[StateArg1]%>増加し、ターン終了時、<WeaponEffect_Num:[Block:DescArg1]>点のシールドを獲得する。"
  },
  State_90294_Desc = {
    Text = "このターンにアクティブダメージまたは触腕ダメージを受けた場合、同量の侵蝕を除去し、除去した量の300%のライフを失う。それ以外のダメージを受けた場合は、ダメージの50%の侵蝕を除去する。"
  },
  State_90294_Name = {
    Text = "<Corrosion:侵蝕>"
  },
  State_90591_Name = {
    Text = "「啓示」を[Layer]枚手札に追加"
  },
  State_90594_Name = {
    Text = "と[Layer]点点の一時的な警戒"
  },
  State_90599_Name = {
    Text = "すべての覚醒体は[Layer]狂気を獲得"
  },
  State_90600_Name = {
    Text = "[Layer]キーエネルギーを獲得"
  },
  State_90601_Name = {
    Text = "(残りの<harmonyKeyWord:「ブレンド」回数　[DescArg1]回>)"
  },
  State_90603_Name = {
    Text = "[Layer] 点の一時的な力を獲得"
  },
  State_90604_Name = {
    Text = "ライフを[Layer]回復。失ったライフに応じて増加する。"
  },
  State_90696_Desc = {
    Text = "使用する前に「調味料」を1つ加え、その効果を発動する。ボス戦では「調合」の回数が1回増加する。"
  },
  State_90696_Name = {
    Text = "<harmonyKeyWord:調合>"
  },
  State_91106_Desc = {
    Text = "1点ごとに、与えるアクティブダメージと触腕ダメージに、ダメージの10%の<BleedingIconKeywords:出血>を付与する。"
  },
  State_91106_Name = {Text = "狂熱"},
  State_91165_Name = {
    Text = "蒼白の卵"
  },
  State_91235_Desc = {
    Text = "ライフを失う際に同量のスタック数を減少させ、伤势が0になると、すべての覚醒体が10の狂気を獲得し、伤势のスタック数をリセットする。"
  },
  State_91235_Name = {Text = "負傷"},
  State_91236_Name = {
    Text = "ローマイベントによるボス生命カウント"
  },
  State_91329_Desc = {
    Text = "このカードの行動力消費-[StateArg1]。"
  },
  State_91329_Name = {Text = "珍味"},
  State_91521_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、<PVPDerivativeCardKeywords_17:「霊感」>を[StateArg1]枚手札に追加する。"
  },
  State_91521_Name = {
    Text = "パートナーの特訓"
  },
  State_91522_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時およびターン終了時、後列の敵に<Damage:[Damage:StateArg1]>ダメージを与える。"
  },
  State_91522_Name = {
    Text = "入学の日"
  },
  State_91676_Desc = {
    Text = "具体的な効果は共通の「攻撃」ロジックを参照。__「開発用」"
  },
  State_91706_Desc = {
    Text = "次のターン開始時、点数と同量の行動力を獲得する。"
  },
  State_91706_Name = {
    Text = "<CardKeyWord:保持行動力>"
  },
  State_91717_Desc = {
    Text = "最大3体まで蓄積可能。上限に達した後、次の「生靈の盛筵」でそれを食べてその効果を強化できる。残骸は次の戦闘に引き継がれる。"
  },
  State_91759_Desc = {
    Text = "黒羽は「御子・黒羽」の能力を強化する。"
  },
  State_91759_Name = {Text = "黒羽"},
  State_91761_Desc = {
    Text = "「御子・黒羽」は破壊されなかったシールドの50％を次のターンまで保持し、ターン終了後に1点の<Guaiwuheiyu:黒羽>を獲得する。"
  },
  State_91761_Name = {
    Text = "飛翔の願い"
  },
  State_91797_Desc = {
    Text = "このカードを使用後および捨てられた後、前列の敵に同量のシールドを付与する。"
  },
  State_91797_Name = {
    Text = "<PVPredKeyword:隠された痛み>"
  },
  State_91799_Desc = {
    Text = "このカードを使用後、前列の敵に[Layer]点のシールドを付与する。"
  },
  State_91799_Name = {
    Text = "<PVPredKeyword:覆い隠された苦痛 [Layer] >"
  },
  State_91809_Desc = {
    Text = "このカードの行動力消費-[Layer]。"
  },
  State_91809_Name = {
    Text = "精神集中"
  },
  State_91819_Desc = {
    Text = "戦闘の現在のターン数に応じて対応する変化を得る。"
  },
  State_91819_Name = {
    Text = "<CardKeyWord:成長>"
  },
  State_91827_Desc = {
    Text = "「攻撃」は対象を選択でき、「攻撃」の前に、対象のすべてのバフ状態を後ろの覚醒体に撃退する。"
  },
  State_91827_Name = {
    Text = "<CardKeyWord:深海の呼び声>"
  },
  State_94410_Name = {
    Text = "毎ターン開始時と行動終了後、空のプレイヤーの山札のリセットを試みる。もし空でない場合はリセットしない。__「開発用」"
  },
  State_94411_Name = {
    Text = "毎ターン開始時と行動終了後、空のプレイヤーの山札のリセットを試みる。もし空でない場合はリセットしない。__「開発用」"
  },
  State_94426_Name = {
    Text = "パッシブシールド__「開発用」"
  },
  State_94540_Desc = {
    Text = "対象の後ろに他の覚醒体がいない場合、対象のバフ状態を解除する。"
  },
  State_94540_Name = {
    Text = "<CardKeyWord:バフ解除>"
  },
  State_94600_Desc = {
    Text = "致命的なダメージを受けた後、1点を除去し、最大ライフの5%を回復する。このターン中、死亡抵抗が発動するたび回復量が1%増加する。"
  },
  State_94603_Name = {
    Text = "グールの印"
  },
  State_94608_Name = {
    Text = "死亡抵抗の発動回数"
  },
  State_94623_Desc = {
    Text = "1点ごとに、与えるアクティブダメージと触腕ダメージに、ダメージの10%の<BleedingIconKeywords:出血>を付与する。"
  },
  State_94623_Name = {
    Text = "<Kuangre:狂熱>"
  },
  State_94657_Desc = {
    Text = "敵を撃殺または復活効果を発動すると、対応する効果が発動する"
  },
  State_94657_Name = {
    Text = "<KillKeywords:撃破>"
  },
  State_94692_Desc = {
    Text = "致命的なダメージを受けた後、1点を除去し、最大ライフの5%を回復する。このターン中、死亡抵抗が発動するたび回復量が1%増加する。"
  },
  State_94693_Desc = {
    Text = "ターン開始時に他の味方がいる場合、ライフを[DescArg1]失い、ライフが最も高い味方に1点の<Guaiwusiwangdikang: 死亡抵抗>と[DescArg2]点の<PowerIconKeywords:力>を与える。"
  },
  State_94693_Name = {
    Text = "グールの分食"
  },
  State_94708_Desc = {
    Text = "ターン開始時に他の味方がいる場合、ライフを[DescArg1]を失い、ライフが最も高い味方に1点の<Guaiwusiwangdikang: 死亡抵抗>と[DescArg2]点の<Duren:毒刃>を与える。"
  },
  State_94708_Name = {
    Text = "深海の分食"
  },
  State_94730_Desc = {
    Text = "ブロックされなかったアクティブダメージを与えた場合、[Layer]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  State_94993_Desc = {
    Text = "毎ターン、驚天怒涛の回数をリセットします。"
  },
  State_94993_Name = {
    Text = "驚天動地の回数リセット"
  },
  State_94994_Desc = {
    Text = "毎層攻撃回数が1増加し、クリティカルダメージを受けると1層失われ、最小1層となり、ターン終了時にすべて失います。"
  },
  State_94994_Name = {
    Text = "驚天動地の回数"
  },
  State_94995_Desc = {
    Text = "クリティカルダメージを受けるたびに、3%の<Baojidikang:一時的クリティカル抵抗>を獲得します。ダメージを与えるたびに、ランダムカード1枚に「深潜印記」を付加します。"
  },
  State_94995_Name = {
    Text = "深海の儀礼"
  },
  State_94996_Desc = {
    Text = "攻撃を受けた時、同量の一時的な力を獲得する。"
  },
  State_94997_Desc = {
    Text = "クリティカルダメージを受けるたびに、5%の<Baojidikang:一時的クリティカル抵抗>を獲得します。ダメージを与えるたびに、ランダムカード1枚に「深潜印記」を付加します。"
  },
  State_94997_Name = {
    Text = "深海の儀礼"
  },
  State_94998_Desc = {
    Text = "<Guaiwusiwangdikang: 死亡抵抗>が発動した時、山札または手札のランダムなカード1枚に<SlowIconKeywords: 遅延>を付与する。"
  },
  State_94998_Name = {
    Text = "絶望の化身"
  },
  State_94999_Desc = {
    Text = "毎ターン、噬天巨浪の回数をリセットします。"
  },
  State_94999_Name = {
    Text = "天を噛む大浪の回数リセット"
  },
  State_95000_Desc = {
    Text = "デバフ無効"
  },
  State_95000_Name = {
    Text = "デバフ無効"
  },
  State_95001_Desc = {
    Text = "毎層攻撃回数が1増加し、クリティカルダメージを受けると1層失われ、最小1層となり、ターン終了時にすべて失います。"
  },
  State_95001_Name = {
    Text = "天を噛む大浪の回数"
  },
  State_95002_Desc = {
    Text = "このターンにクリティカルヒットを受ける確率が[Layer]%減少する。"
  },
  State_95002_Name = {
    Text = "一時的なクリティカル抵抗"
  },
  State_95002_WeaponDesc = {
    Text = "このターンにクリティカルヒットを受ける確率が[Layer]%減少する。"
  },
  State_95035_Desc = {
    Text = "ブロックされなかったアクティブダメージを与えた場合、1点につき<IntoxicationIconKeywords:毒>を1点付与する。"
  },
  State_95038_Desc = {
    Text = "攻撃を受けた時、同量の一時的な力を獲得する。"
  },
  State_95040_Desc = {
    Text = "記録は失われた生命を示している"
  },
  State_95040_Name = {
    Text = "記録は失われた生命を示している"
  },
  State_95932_Name = {
    Text = "グールの吸収：待機"
  },
  State_95937_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、自身の「スキル」を優先してカードを[StateArg1]枚引く。さらにその行動力消費を-[StateArg2]する。"
  },
  State_95937_Name = {Text = "珍味"},
  State_95938_Desc = {
    Text = "カードを1枚除外するごとに1点増加。上限10点。"
  },
  State_95938_Name = {Text = "満腹"},
  State_95943_Desc = {
    Text = "受けるダメージが一時的に30%減少する。"
  },
  State_95943_Name = {Text = "干渉"},
  State_95944_Desc = {
    Text = "唯一装備：装備者が与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。敵を1体撃破するたび、この探索中のクリティカル率が2％増加し、「狂気解放」が与えるダメージの基礎効果が<WeaponEffect_Num:[StateArg2]%>増加し、最大10回まで累積可能。現在の界域が「血肉」の場合、装備者に「胚胎」を直接使用すると、追加で<WeaponEffect_Num:[StateArg4]>狂気を獲得し、クールダウン3ターン。"
  },
  State_95944_WeaponDesc = {
    Text = "装備者が与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。敵を1体撃破するたび、この探索中のクリティカル率が2％増加し、「狂気解放」が与えるダメージの基礎効果が<WeaponEffect_Num:[StateArg2]%>増加し、最大10回まで累積可能。現在の界域が「血肉」の場合、装備者に「胚胎」を直接使用すると、追加で<WeaponEffect_Num:[StateArg4]>狂気を獲得し、クールダウン3ターン。"
  },
  State_95948_Name = {
    Text = "グールの吸収"
  },
  State_95949_Desc = {
    Text = "使用後、ドゥルセインは<Guaiwucanhai:残骸>を半分失う。"
  },
  State_95949_Name = {Text = "奇襲"},
  State_95953_Desc = {
    Text = "死亡抵抗発動時のライフ回復効果が5倍になる。"
  },
  State_95953_Name = {
    Text = "冥夢の帷"
  },
  State_95954_Name = {
    Text = "グールの吸収：覚醒版"
  },
  State_95960_Desc = {
    Text = "「残骸」の点数に応じて、「残骸回収」の効果が増加する。"
  },
  State_95962_Name = {
    Text = "撃破数__「開発用」"
  },
  State_95964_Desc = {
    Text = "唯一装備：装備者が与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。現在の界域が「血肉」の場合、装備者が敵を撃破した時、攻撃力の<WeaponEffect_Num:[StateArg2]%>分の猩紅炉を蓄積する。"
  },
  State_95964_WeaponDesc = {
    Text = "装備者が与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。現在の界域が「血肉」の場合、装備者が敵を撃破した時、<WeaponEffect_Num:[DescArg1]>点の猩紅炉を蓄積する。"
  },
  State_95966_Desc = {
    Text = "次のターン開始時、その覚醒体のカードを[Layer]枚引く。"
  },
  State_95966_Name = {
    Text = "残忍なる敬意"
  },
  State_95967_Desc = {
    Text = "「残骸」の点数に応じて、「残骸回収」の効果が増加する。"
  },
  State_95968_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に[StateArg1]点の<StrongEffectKeywords:特効>を獲得。敵を撃破した時の超過ダメージを後ろの覚醒体に与える。"
  },
  State_95968_Name = {
    Text = "安息の口づけ"
  },
  State_96167_Desc = {
    Text = "覚醒体が撃破された後、他の味方が[StateArg1]点の<StrongEffectKeywords:特効>を獲得する。解除不可。"
  },
  State_96167_Name = {
    Text = "黒星の燃え殻"
  },
  State_96183_Desc = {
    Text = "ターン終了時に他の味方がいない場合、行動予測を自爆に切り替える。"
  },
  State_96183_Name = {
    Text = "グールの自爆"
  },
  State_96193_Name = {
    Text = "食事前の作法"
  },
  State_96330_Desc = {
    Text = "自身がライフを1%失うごとに、ドゥルセインの指令カードが与える基礎ダメージ、シールド、狂気が1%増加する。"
  },
  State_96330_Name = {
    Text = "亡者の囁き"
  },
  State_96352_Name = {
    Text = "最初の死体食いのカウント"
  },
  State_96354_Name = {
    Text = "初始最大生命"
  },
  State_96355_Desc = {
    Text = "クリティカルヒットを受ける確率が[Layer]%減少する。"
  },
  State_96355_Name = {
    Text = "クリティカル耐性"
  },
  State_96355_WeaponDesc = {
    Text = "この戦闘でクリティカルヒットを受ける確率が[Layer]%減少する。"
  },
  State_96356_Desc = {
    Text = "[DescArg1]ポイントの生命を失うごとに[DescArg2]層<ReinforcePVEKeywords:加固>を得る。最大[DescArg3]層。<Guaiwusiwangdikang:死の抵抗>が発動すると、自身の最大生命が[DescArg4]%増加する。"
  },
  State_96356_Name = {
    Text = "イレーナの庇護"
  },
  State_96357_Desc = {
    Text = "ターン終了時、同じ数の層のパワーを獲得する。"
  },
  State_96358_Desc = {
    Text = "クリティカルヒットを受ける確率が [Layer] % 減少する。"
  },
  State_96358_Name = {
    Text = "<Baojidikang:クリティカル耐性>"
  },
  State_96412_Name = {
    Text = "饕餮の監視"
  },
  State_96416_Desc = {
    Text = "クリティカルヒットを受ける確率が[Layer]%減少する。"
  },
  State_96416_Name = {
    Text = "クリティカル耐性"
  },
  State_96603_Name = {
    Text = "このターンに使用しなかった場合、次のターンの開始時に「ブレンド」効果を1回発動"
  },
  State_96610_Name = {
    Text = "初回の死亡抵抗"
  },
  State_96613_Name = {
    Text = "巨大波の監視"
  },
  State_96650_Desc = {
    Text = "1点ごとに、覚醒体のクリティカル率が[DescArg1]%増加する。"
  },
  State_96650_Name = {
    Text = "<ExclamationPointColour:深暗の炎>"
  },
  State_96719_Desc = {
    Text = "このターン中、<BurningKeywords:燃焼>が付与されたカードを使用すると、<Heat:深暗の炎>を1点消費して2回発動し、ターン終了時に<Heat:深暗の炎>を解除する。"
  },
  State_96719_Name = {
    Text = "果てなき爆炎"
  },
  State_96731_Desc = {
    Text = "このターン中、<BurningKeywords:燃焼>が付与されたカードを使用すると、<Heat:深暗の炎>を1点消費して2回発動し、ターン終了時に<Heat:深暗の炎>を解除する。"
  },
  State_96731_Name = {
    Text = "<Overload:果てなき爆炎>"
  },
  State_96732_Desc = {
    Text = "1点ごとに、覚醒体のクリティカル率が[DescArg1]%増加する。"
  },
  State_96732_Name = {
    Text = "<Heat:深暗の炎>"
  },
  State_96740_Desc = {
    Text = "受けるアクティブダメージと出血の点数が50%増加し、ダメージを受けるか、ターン開始時に除去される。"
  },
  State_96740_Name = {
    Text = "<CardKeyWord:弱点>"
  },
  State_96741_Desc = {
    Text = "使用後、残りの行動力が[StateArg1]より多い場合、追加で[StateArg1]の行動力を消費し、後続の効果を発動する。__「開発用」"
  },
  State_96741_Name = {
    Text = "<CardKeyWord:行動力オーバーロード>__「開発用」"
  },
  State_96742_Name = {
    Text = "行動力オーバーロード発動マーク__「開発用」"
  },
  State_96743_Desc = {
    Text = "使用後、残りの行動力が行動力オーバーロードに必要な行動力より多い場合、追加で行動力を消費し、後続の効果を発動する。"
  },
  State_96743_Name = {
    Text = "<CardKeyWord:行動力オーバーロード>"
  },
  State_96744_Desc = {
    Text = "受けるアクティブダメージと出血の点数が50%増加し、ダメージを受けるか、ターン開始時に除去される。"
  },
  State_96744_Name = {Text = "隙"},
  State_96774_Desc = {
    Text = "クリティカルダメージを受けるたび、3%の一時的なクリティカル耐性獲得する。"
  },
  State_96774_Name = {
    Text = "深海の怨霊"
  },
  State_96780_Desc = {
    Text = "カードは保持を獲得。使用するもしくは捨てた場合に汚染を除去し、「深海の増殖体」を1体召喚する。最大2体。召喚する場所がない場合、即座に「腐潮の傀儡」が[DescArg1]点の力と[DescArg2]点のライフを獲得する。"
  },
  State_96780_Name = {
    Text = "<Kuangluan:汚染：海踊人の狂乱>"
  },
  State_96783_Desc = {
    Text = "毎ターン2枚のカードに「<Kuangluan:蹈海者狂乱>」を付与します。"
  },
  State_96783_Name = {
    Text = "海踊人の祭儀"
  },
  State_96784_Desc = {
    Text = "「腐潮の傀儡」から受ける攻撃を軽減できる。最大5点。"
  },
  State_96808_Desc = {
    Text = "ライフを[DescArg1]失うごとに、15点の「<ReinforcePVEKeywords:堅固>」を獲得する。最大75点。撃破されそうになると点数をリセットし、1点の「<Chaos:混乱>」を獲得する。「骨血の再構成」を発動していない場合、致命的なダメージを受けた後、行動予測を「骨血の再構成」に転換し、すべてのダメージを無効化する。"
  },
  State_96808_Name = {
    Text = "「キメラの傀儡」"
  },
  State_96809_Name = {
    Text = "融合の傀儡カウント"
  },
  State_96810_Desc = {
    Text = "与えるダメージが25%減少。"
  },
  State_96810_Name = {
    Text = "冥夢の帷"
  },
  State_96813_Name = {
    Text = "再編成マーカー"
  },
  State_97114_Desc = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」で[StateArg1]算力を獲得し、「スキル」のダメージが[StateArg2]%増加する。"
  },
  State_97114_Name = {
    Text = "迫り来る太陽"
  },
  State_97118_Name = {
    Text = "融合の傀儡破壊"
  },
  State_97119_Desc = {
    Text = "カードは保持を獲得。使用するもしくは捨てた場合に汚染が除去し、「深海の増殖体」を1体召喚する。最大2体。召喚する場所がない場合、即座に「腐潮の傀儡」が[DescArg1]点の力と[DescArg2]点のライフを獲得する。"
  },
  State_97119_Name = {
    Text = "<Kuangluan:汚染：海踊人の狂乱>"
  },
  State_97120_Desc = {
    Text = "魔法陣の守りによって、すべての敵が与えるダメージが25%減少する。"
  },
  State_97120_Name = {
    Text = "冥夢の帷"
  },
  State_97131_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「スキル」が消費する行動力 1 につきダメージアップ [StateArg1]%。キル後「狂気解放」のダメージアップ [StateArg2]%、現在のボーナス [DescArg1]%。"
  },
  State_97131_Name = {
    Text = "琥珀色の死"
  },
  State_97134_Desc = {
    Text = "与える最終ダメージが50%増加。"
  },
  State_97134_Name = {
    Text = "セリネの詠唱"
  },
  State_97135_Desc = {
    Text = "与える最終ダメージが25%増加。"
  },
  State_97135_Name = {
    Text = "セリネの囁き"
  },
  State_97136_Desc = {
    Text = "与える最終ダメージが100%増加。"
  },
  State_97136_Name = {
    Text = "セリネの高い歌"
  },
  State_97137_Desc = {
    Text = "捨てた後に手札に戻る。"
  },
  State_97137_Name = {
    Text = "捨てた後に手札に戻る"
  },
  State_97137_WeaponDesc = {
    Text = "抽到時に自身に弱り状態を1ターン与える。使用後、すべての敵に弱り状態を1ターン与える。売却不可。"
  },
  State_97219_Desc = {
    Text = "ワンダが次に使用する[Layer]枚のカードは追加で1回効果を発動する。"
  },
  State_97219_Name = {
    Text = "茨の女王"
  },
  State_97251_Desc = {
    Text = "・相手の優先攻撃対象にならず、相手が単体対象を選択する際、潜行状態の覚醒体は選択できない。\n・潜行を獲得した時、自身の挑発と他の味方の潜行を解除する。他に味方がいない時、または敵が挑発を獲得した時、潜行を解除する。"
  },
  State_97252_Desc = {
    Text = "・相手の優先攻撃対象にならず、相手が単体対象を選択する際、潜行状態の覚醒体は選択できない。\n・潜行を獲得した時、自身の挑発と他の味方の潜行を解除する。他に味方がいない時、または敵が挑発を獲得した時、潜行を解除する。"
  },
  State_97339_Name = {
    Text = "ミサゴ大学優勝杯"
  },
  State_97742_Desc = {
    Text = "アクティブダメージを受けるたびに、ダメージの発生源に [Layer] 点の<FixedDamage:純粋ダメージ>を与える。"
  },
  State_97742_Name = {Text = "反撃"},
  State_97743_Desc = {
    Text = "アクティブダメージアップ [Layer] 点。"
  },
  State_97743_Name = {
    Text = "<PowerColourKeywords:パワー>"
  },
  State_97744_Desc = {
    Text = "受けるすべてのダメージが [Layer] ％低下する。"
  },
  State_97744_Name = {
    Text = "<ReinforceColour:堅固>"
  },
  State_97744_WeaponDesc = {
    Text = "与えるすべてのダメージが[DescArg1]%減少。"
  },
  State_97938_Desc = {
    Text = "最終ダメージが[DescArg1]%増加。"
  },
  State_97938_Name = {
    Text = "ミサゴ大学優勝杯"
  },
  State_97939_Desc = {
    Text = "与える最終ダメージが50%増加。"
  },
  State_97939_Name = {
    Text = "ミサゴ大学優勝杯"
  },
  State_97941_Desc = {
    Text = "基礎ダメージが100%増加。"
  },
  State_97941_Name = {
    Text = "ミサゴ大学優勝杯"
  },
  State_97942_Desc = {
    Text = "「狂気解放」を発動後、35狂気を獲得。"
  },
  State_97942_Name = {
    Text = "ミサゴ大学優勝杯"
  },
  State_97943_Name = {
    Text = "計算力保持カウント"
  },
  State_98055_Desc = {
    Text = "ターン終了時、触腕を1本獲得。覚醒後、この状態を解除する。"
  },
  State_98055_Name = {Text = "熟睡"},
  State_98060_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、ライフを回復し、真の姿で戦闘を始める。"
  },
  State_98060_Name = {Text = "未覚醒"},
  State_98068_Desc = {
    Text = "「爆炎」が10点ある場合、1点の行動力を獲得し、すべての「ギガフレア」を「テラフレア」にアップグレードする。"
  },
  State_98139_Desc = {
    Text = "相手のターン開始後、手札にあるランダムなカード1枚に<BurningKeywords:燃焼>を付与する。"
  },
  State_98139_Name = {
    Text = "業火再燃"
  },
  State_98140_Desc = {
    Text = "<MonsterExFlameKeywords:爆炎>が10点に達すると、行動予測は高ダメージの「テラフレア」に転換する！"
  },
  State_98147_Desc = {
    Text = "敵が<BurningKeywords:燃焼>の付与されたカードを使用した時、自身に1点の<MonsterExFlameKeywords:爆炎>を付与し、[DescArg1]点の<PowerIconKeywords:力>が一時的に減少する。"
  },
  State_98147_Name = {
    Text = "不滅の炎"
  },
  State_98148_Desc = {
    Text = "この覚醒体はまだ未覚醒だ…撃破される直前に覚醒し、残りの手札をすべて捨てて<BurningKeywords:燃焼>を付与し、ライフを回復して真の姿で戦闘を始める。"
  },
  State_98148_Name = {Text = "未覚醒"},
  State_98302_Desc = {
    Text = "唯一装備：装備者が与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加し、力の獲得量が<WeaponEffect_Num:[StateArg2]%>増加する。装備者の指令カードを使用した後、装備者の攻撃力<WeaponEffect_Num:[StateArg3]%>の分の一時的な力を獲得し、毎ターン最大5回まで累積可能。"
  },
  State_98302_WeaponDesc = {
    Text = "装備者が与える基本ダメージが増加 <WeaponEffect_Num:[StateArg1]%>、与える力が増加 <WeaponEffect_Num:[StateArg2]%>。装備者の指令カードを使用した後、 <WeaponEffect_Num:[Power:DescArg1]> ポイントの一時的な力を得る。この効果は1ターンに最大5回発動可能（現在発動した回数は [DescArg2]/5 回）。"
  },
  State_98323_Desc = {
    Text = "カードが捨てられた後、再び手札に戻る。"
  },
  State_98323_Name = {
    Text = "放棄してから再び手に戻った"
  },
  State_98341_Desc = {
    Text = "他の原色と混ぜ合わせることで、新しい色を作り出すことができる。"
  },
  State_98341_Name = {
    Text = "<Yellow:原色・黄>"
  },
  State_98344_Desc = {
    Text = "他の原色と混ぜ合わせることで、新しい色を作り出すことができる。"
  },
  State_98344_Name = {
    Text = "<Red:原色・赤>"
  },
  State_98345_Desc = {
    Text = "他の原色と混ぜ合わせることで、新しい色を作り出すことができる。"
  },
  State_98345_Name = {
    Text = "<Blue:原色・青>"
  },
  State_98366_Desc = {
    Text = "ターン開始時、キーエネルギーが[Arg1]以上ある場合、[Arg1]キーエネルギーを消費し、<DerivativeCardKeywords_115:「上位啓示」>を1枚手札に追加する。"
  },
  State_98435_Desc = {
    Text = "赤と青を混ぜ合わせた色。アクティブダメージを与えるたび、<Block: [DescArg1]>点のシールドを獲得。"
  },
  State_98435_Name = {
    Text = "<PurpleKeyWord:異象・紫>"
  },
  State_98436_Desc = {
    Text = "赤と黄色を混ぜ合わせた色。狂気解放を発動後、対応する覚醒体は<Energy:15>狂気を獲得。"
  },
  State_98436_Name = {
    Text = "<ExclamationPointColour:異象・橙>"
  },
  State_98437_Desc = {
    Text = "与える最終ダメージが10%増加する。"
  },
  State_98437_Name = {
    Text = "<Red:原色・赤>"
  },
  State_98438_Desc = {
    Text = "黄と青を混ぜ合わせた色。「防御」を使用後、ライフを<Heal:[DescArg1]>回復する。"
  },
  State_98438_Name = {
    Text = "<GreenWord:異象・緑>"
  },
  State_98439_Desc = {
    Text = "黄と青を混ぜ合わせた色。「防御」を使用後、ライフを<Heal:[DescArg1]>回復する。"
  },
  State_98439_Name = {
    Text = "<GreenWord:異象・緑>"
  },
  State_98440_Desc = {
    Text = "赤と青を混ぜ合わせた色。アクティブダメージを与えるたび、<Block: [DescArg1]>点のシールドを獲得。"
  },
  State_98440_Name = {
    Text = "<PurpleKeyWord:異象・紫>"
  },
  State_98441_Desc = {
    Text = "赤と黄色を混ぜ合わせた色。狂気解放を発動後、対応する覚醒体は<Energy:15>狂気を獲得。"
  },
  State_98441_Name = {
    Text = "<ExclamationPointColour:異象・橙>"
  },
  State_98444_Desc = {
    Text = "唯一装備：装備者の与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。装備者の指令カードを5枚使用した後、装備者のクリティカル率が一時的に<WeaponEffect_Num:[StateArg2]%>獲得する。この効果は1ターンに1回のみ発動する。"
  },
  State_98444_WeaponDesc = {
    Text = "唯一装備：装備者の与える基礎ダメージが<WeaponEffect_Num:[StateArg1]%>増加する。装備者の指令カードを5枚使用した後、装備者のクリティカル率が一時的に<WeaponEffect_Num:[StateArg2]%>獲得する。この効果は1ターンに1回のみ発動する。（現在、[DescArg1]/5枚使済み）"
  },
  State_98466_Name = {
    Text = "<HuoyanKeywords1:火焔1>"
  },
  State_98468_Name = {
    Text = "<HuoyanKeywords3:火焔3>"
  },
  State_98470_Name = {
    Text = "<HuoyanKeywords2:火焔2>"
  },
  State_98474_Desc = {
    Text = "混ぜ合わせることで、他の色を作り出すことができる。赤、黄、青がある。"
  },
  State_98484_Name = {
    Text = "苦海に沈む"
  },
  State_98485_Desc = {
    Text = "このカードが与えるシールド、狂気が[DescArg2]％増加し、最終ダメージ、力が[DescArg1]％増加し、「保持」を獲得する。使用後、すべての「活焔」を消費し、手札にある他のキャティグラの指令カード1枚に、1層の「活焔」を伝導する。"
  },
  State_98485_Name = {
    Text = "<HuoyanKeywords2:火焔2>"
  },
  State_98486_Desc = {
    Text = "このカードが与えるシールド、狂気が[DescArg2]％増加し、最終ダメージ、力が[DescArg1]％増加し、「保持」を獲得する。使用後、すべての「活焔」を消費し、手札にある他のキャティグラの指令カード1枚に、1層の「活焔」を伝導する。"
  },
  State_98486_Name = {
    Text = "<HuoyanKeywords3:火焔3>"
  },
  State_98487_Desc = {
    Text = "このカードが与えるシールド、狂気が[DescArg2]％増加し、最終ダメージ、力が[DescArg1]％増加し、「保持」を獲得する。使用後、すべての「活焔」を消費し、手札にある他のキャティグラの指令カード1枚に、1層の「活焔」を伝導する。"
  },
  State_98487_Name = {
    Text = "<HuoyanKeywords1:火焔1>"
  },
  State_98488_Desc = {
    Text = "「火焔」1点ごとに、カードが与える最終ダメージ、シールド、狂気、力が30%増加する。最大3点まで累積可能。「火焔」が付与されたカードは「保持」を獲得し、使用後、すべての「火焔」を消費して、手札にある他のキャティグラの指令カードに1枚に、1点の「火焔」を付与する。"
  },
  State_98488_Name = {
    Text = "<HuoyanKeywords:火焔>"
  },
  State_98492_Desc = {
    Text = "探索開始後、体力、攻撃力、防御力が[StateArg1]%増加する"
  },
  State_98492_Name = {
    Text = "霊塑適性"
  },
  State_98495_Desc = {
    Text = "探索開始後、体力、攻撃、防御が[StateArg1]%増加する"
  },
  State_98495_Name = {
    Text = "霊塑適性"
  },
  State_98507_Desc = {
    Text = "探索開始後、体力、攻撃、防御が[StateArg1]%増加する"
  },
  State_98507_Name = {
    Text = "霊塑適性"
  },
  State_98511_Name = {
    Text = "派生カードを取得"
  },
  State_98551_Desc = {
    Text = "戦闘開始時、界域知識+[Arg1]。奇数ターン開始時にカードを1枚引き、偶数ターン開始時に1点の行動力を獲得する。"
  },
  State_98553_Desc = {
    Text = "「胚胎」を1枚獲得するたびに、[Arg1]点の猩紅炉を蓄積する。毎ターンで最大3回まで発動可能。"
  },
  State_98555_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得。毎ターンで初めて毒を付与した後、カードを[Arg2]枚引く。"
  },
  State_98556_Desc = {
    Text = "すべての覚醒体のライフ回復とシールドの基礎効果が[Arg1]%増加する。"
  },
  State_98557_Desc = {
    Text = "「胚胎」を1枚獲得するたびに、[Arg1]点の猩紅炉を蓄積する。毎ターンで最大3回まで発動可能。"
  },
  State_98559_Desc = {
    Text = "カードを1枚引くか捨てるたびに、[Arg1]点の一時的な力を獲得する。最大[Arg2]点。"
  },
  State_98560_Desc = {
    Text = "すべての覚醒体が与える基礎ダメージが[Arg1]%増加する。「狂気解放」を発動する前に、対応する覚醒体の基礎ダメージが一時的に [Arg2]% 増加する。"
  },
  State_98561_Desc = {
    Text = "ターン開始時にライフが50%未満の場合、一時的なダメージ強化+[Arg1]%。ライフが25%未満の場合、追加でカードを[Arg2]枚引き、[Arg2]点の行動力を獲得する。"
  },
  State_98562_Desc = {
    Text = "アクティブダメージまたは触腕ダメージを与えた後、そのターンに対象が受ける触腕ダメージが[Arg1]%増加する。毎ターン最大20回まで発動可能。"
  },
  State_98563_Desc = {
    Text = "戦闘開始時、[Arg1]点の力を獲得。「除外」の付与されたカードを1枚使用するたびに、[Arg2]点の一時的な力を獲得し、最大[Arg3]回まで発動可能。"
  },
  State_98564_Desc = {
    Text = "「狂気解放」を発動した後、 [Arg1]キーエネルギーを獲得する。毎ターン最大3回まで発動可能。"
  },
  State_98565_Desc = {
    Text = "カードが超次元空間に置かれるたびに、山札から対応する覚醒体の指令カードを[Arg1]枚引く。ドローできない場合は、代わりに同量の行動力を獲得する。毎ターン最大2回まで発動可能。"
  },
  State_98567_Desc = {
    Text = "ターン終了時、手札にある指令カードに対応する覚醒体は[Arg1]狂気を獲得。"
  },
  State_98568_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得。アクティブダメージを与えた後、すべての敵に[Arg2]点の毒を付与し、毎ターン最大5回まで発動可能。"
  },
  State_98569_Desc = {
    Text = "毎ターン初めて「キーオーダー」を使用した後、すべての敵に[Arg1]点の毒を付与し、[Arg2]点の反撃を獲得する。"
  },
  State_98571_Desc = {
    Text = "シルバーキー覚醒後、ライフを[Arg1]回復し、[Arg2]キーエネルギーを獲得。"
  },
  State_98571_Name = {
    Text = "旅行用の日傘"
  },
  State_98572_Desc = {
    Text = "毎ターン2回目の「キーオーダー」を発動した後、[Arg1]キーエネルギーを獲得し、すべての覚醒体が[Arg2]狂気を獲得する。"
  },
  State_98575_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得。アクティブダメージを与えた後、すべての敵に[Arg2]点の毒を付与し、毎ターン最大5回まで発動可能。"
  },
  State_98576_Desc = {
    Text = "戦闘開始時、すべての敵に[Arg1]点の虚弱と易傷を与える。「湮滅」を発動した後もこの効果が発動し、クールダウン3ターン。"
  },
  State_98577_Desc = {
    Text = "すべての覚醒体が与える基礎ダメージが[Arg1]%増加する。「狂気解放」を発動する前に、対応する覚醒体の基礎ダメージが一時的に [Arg2]% 増加する。"
  },
  State_98579_Desc = {
    Text = "ターン開始時にライフが50%未満の場合、一時的なダメージ強化+[Arg1]%。ライフが25%未満の場合、追加でカードを[Arg2]枚引き、[Arg2]点の行動力を獲得する。"
  },
  State_98581_Desc = {
    Text = "すべての覚醒体が毎ターン初めて使用する「指令カード」は[Arg1]キーエネルギーを獲得する。"
  },
  State_98582_Desc = {
    Text = "「狂気解放」を5回発動するたびに、次に使用する[Arg1]枚の非派生指令カードは追加で1回効果を発動する。"
  },
  State_98583_Desc = {
    Text = "すべての覚醒体が毎ターン初めて使用する「指令カード」は[Arg1]キーエネルギーを獲得する。"
  },
  State_98586_Desc = {
    Text = "ターン開始時、「狂気解放」の発動に必要な狂気を持たないすべての覚醒体が[Arg1]狂気を獲得する。"
  },
  State_98587_Desc = {
    Text = "カードを1枚引くか捨てるたびに、[Arg1]点の一時的な力を獲得する。最大[Arg2]点。"
  },
  State_98588_Desc = {
    Text = "ターン終了時、手札にある指令カードに対応する覚醒体は[Arg1]狂気を獲得。"
  },
  State_98589_Desc = {
    Text = "戦闘開始時、すべての敵から[Arg1]点の力を一時的に減少させる。「猩紅炉」を使用した時もこの效果が発動し、クールダウン3ターン。"
  },
  State_98590_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得。毎ターンで初めて毒を付与した後、カードを[Arg2]枚引く。"
  },
  State_98591_Desc = {
    Text = "毎ターン初めて「キーオーダー」を使用した後、すべての敵に[Arg1]点の毒を付与し、[Arg2]点の反撃を獲得する。"
  },
  State_98596_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、消費したキーエネルギーの[Arg1]%を返還する。"
  },
  State_98597_Desc = {
    Text = "シルバーキー覚醒後、ライフを[Arg1]回復し、[Arg2]キーエネルギーを獲得。"
  },
  State_98597_Name = {
    Text = "旅行用の日傘+"
  },
  State_98598_Desc = {
    Text = "戦闘開始時、[Arg1]点の力を獲得。「除外」の付与されたカードを1枚使用するたびに、[Arg2]点の一時的な力を獲得し、最大[Arg3]回まで発動可能。"
  },
  State_98600_Desc = {
    Text = "戦闘開始時、すべての敵から[Arg1]点の力を一時的に減少させる。「猩紅炉」を使用した時もこの效果が発動し、クールダウン3ターン。"
  },
  State_98602_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。毎ターン初めて反撃を獲得した後、1/2の行動力を獲得する。"
  },
  State_98603_Desc = {
    Text = "戦闘開始時にダメージ強化 +[Arg1]％を獲得する。主動または触手ダメージを受けた後、[Arg2]のカウンターを獲得し、1ターンに最大3回発動する。"
  },
  State_98604_Desc = {
    Text = "戦闘開始時にダメージ強化 +[Arg1]％を獲得する。主動または触手ダメージを受けた後、[Arg2]のカウンターを獲得し、1ターンに最大3回発動する。"
  },
  State_98606_Desc = {
    Text = "カードが超次元空間に置かれるたびに、山札から対応する覚醒体の指令カードを[Arg1]枚引く。ドローできない場合は、代わりに同量の行動力を獲得する。毎ターン最大2回まで発動可能。"
  },
  State_98607_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、すべての触腕に敵を[Arg1]回攻撃させ、50%のダメージを与える。"
  },
  State_98608_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。異なる覚醒体の指令カードを1枚使用するたび、追加で15/30%の一時的なダメージ強化を獲得する。"
  },
  State_98610_Desc = {
    Text = "シルバーキー覚醒後、手札の中で行動力が最も高いカード2/4枚に次回使用するまで「保持」と「準備」を付与し、100/200キーエネルギーを獲得する。"
  },
  State_98611_Desc = {
    Text = "戦闘開始時、界域知識+[Arg1]。奇数ターン開始時にカードを1枚引き、偶数ターン開始時に1点の行動力を獲得する。"
  },
  State_98612_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、一時的なダメージ強化+[Arg1]%。ライフが低いほど効果が高くなる。"
  },
  State_98613_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。異なる覚醒体の指令カードを1枚使用するたび、追加で15/30%の一時的なダメージ強化を獲得する。"
  },
  State_98614_Desc = {
    Text = "「狂気解放」を5回発動するたびに、次に使用する[Arg1]枚の非派生指令カードは追加で1回効果を発動する。"
  },
  State_98615_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、消費したキーエネルギーの[Arg1]%を返還する。"
  },
  State_98616_Desc = {
    Text = "すべての覚醒体のライフ回復とシールドの基礎効果が[Arg1]%増加する。"
  },
  State_98617_Desc = {
    Text = "アクティブダメージまたは触腕ダメージを与えた後、そのターンに対象が受ける触腕ダメージが[Arg1]%増加する。毎ターン最大20回まで発動可能。"
  },
  State_98619_Desc = {
    Text = "ターン終了後、キーエネルギーが上限に達している場合、[Arg1]キーエネルギーを消費し、「シルバーキーの微光」を1枚手札に追加する。"
  },
  State_98621_Desc = {
    Text = "ターン終了後、キーエネルギーが上限に達している場合、[Arg1]キーエネルギーを消費し、「シルバーキーの微光」を1枚手札に追加する。"
  },
  State_98623_Desc = {
    Text = "ターン開始時、「狂気解放」の発動に必要な狂気を持たないすべての覚醒体が[Arg1]狂気を獲得する。"
  },
  State_98624_Desc = {
    Text = "戦闘開始時と死亡抵抗を発動した後、[Arg1]キーエネルギーを獲得。"
  },
  State_98625_Desc = {
    Text = "戦闘開始時、すべての敵に[Arg1]点の虚弱と易傷を与える。「湮滅」を発動した後もこの効果が発動し、クールダウン3ターン。"
  },
  State_98626_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、一時的なダメージ強化+[Arg1]%。ライフが低いほど効果が高くなる。"
  },
  State_98627_Desc = {
    Text = "「狂気解放」を発動した後、 [Arg1]キーエネルギーを獲得する。毎ターン最大3回まで発動可能。"
  },
  State_98628_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、すべての触腕に敵を[Arg1]回攻撃させ、50%のダメージを与える。"
  },
  State_98629_Desc = {
    Text = "毎ターン2回目の「キーオーダー」を発動した後、[Arg1]キーエネルギーを獲得し、すべての覚醒体が[Arg2]狂気を獲得する。"
  },
  State_98630_Desc = {
    Text = "戦闘開始時と死亡抵抗を発動した後、[Arg1]キーエネルギーを獲得。"
  },
  State_98632_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。毎ターン初めて反撃を獲得した後、1/2の行動力を獲得する。"
  },
  State_98686_Desc = {
    Text = "次に使用する[Layer]枚の非派生指令カードは追加で1回効果を発動する。"
  },
  State_98686_Name = {
    Text = "非派生指令カードが二重発動"
  },
  State_98739_Desc = {
    Text = "行動予測を「蒼白の旋回」に転換した場合、点数に応じてダメージ回数が増加する。ターン終了後に解除する。3点に達すると、即座に行動予測を「蒼白の旋回」に転換する。"
  },
  State_98739_Name = {
    Text = "蜘蛛女のキス"
  },
  State_98742_Desc = {
    Text = "付与する毒が100%増加し、毎ターン終了後に<Block:[Block:DescArg1]>点のシールドを獲得する。"
  },
  State_98742_Name = {
    Text = "迷途の旅"
  },
  State_98743_Desc = {
    Text = "このターンに[DescArg1]ダメージを受けた場合、75点の一時的な堅固を獲得し、行動予測を「耐え難い施し」に転換し、石化効果を解除し、1点の「蜘蛛女のキス」を獲得する。"
  },
  State_98752_Desc = {
    Text = "カードを燃焼させ、使用すると最大ライフの5%のダメージを受ける。ターン終了時に手札に残っている場合、除外される。"
  },
  State_98752_Name = {
    Text = "<BurningKeywords2:燃焼>"
  },
  State_98752_WeaponDesc = {
    Text = "各层の遅延により、カードの計算力消費が 1 ポイント増加します。"
  },
  State_98887_Name = {
    Text = "救いの灯"
  },
  State_98889_Desc = {
    Text = "毎ターン初めて<DepleteIconKeywords:除外>を持つ指令カードを使用した後、それを捨て札に置く。"
  },
  State_98889_Name = {
    Text = "救いの灯"
  },
  State_98912_Desc = {
    Text = "1点ごとに、すべての覚醒体が獲得するシールドとライフ回復が10$減少する。"
  },
  State_98912_Name = {
    Text = "<LostWay:迷宮>"
  },
  State_98913_Desc = {
    Text = "1点ごとに、すべての覚醒体が獲得するシールドとライフ回復が10$減少する。"
  },
  State_98913_Name = {Text = "迷宮"},
  State_99007_Desc = {
    Text = "使用すると捨て札に行かず、デッキから除去する。"
  },
  State_99007_Name = {
    Text = "<DepleteIconKeywords:除外>"
  },
  State_99007_WeaponDesc = {
    Text = "使用するとカードは捨て札に行かず、この戦闘では再び使用できない。"
  },
  State_99053_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：他の味方は毎ターン最初の「狂気解放」で[StateArg1]枚のカードを引きます。"
  },
  State_99053_Name = {
    Text = "渇望の筆"
  },
  State_99055_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気爆発」後、ランダムに [StateArg1] 枚の装備者の「スキル」を手札に加え、その演算力消費を 0 にする。"
  },
  State_99055_Name = {
    Text = "写実主義の逆説"
  },
  State_99056_Desc = {
    Text = "唯一装備：「キーオーダー」を発動した後、装備者のクリティカル率が一時的に <WeaponEffect_Num:[StateArg1]%>増加する。"
  },
  State_99056_WeaponDesc = {
    Text = "「キーオーダー」を発動した後、装備者のクリティカル率が一時的に <WeaponEffect_Num:[StateArg1]%>増加する。"
  },
  State_99134_Desc = {
    Text = "「画家」が作画に使用する染料。スキル効果を強化する。上限は10点。"
  },
  State_99134_Name = {
    Text = "幻の染料"
  },
  State_99237_Name = {
    Text = "ステータスアクセサリー飛昇"
  },
  State_99237_WeaponDesc = {
    Text = "装備者が与える基本ダメージが10%アップする。装備者のダメージ強化が20%を超える場合、基本ダメージがさらに10%アップする。"
  },
  State_99238_Name = {
    Text = "ステータスアクセサリー腐植質"
  },
  State_99238_WeaponDesc = {
    Text = "装備者が与える基本ダメージが10%アップする。装備者のダメージ強化が20%を超える場合、基本ダメージがさらに10%アップする。"
  },
  State_99239_Name = {
    Text = "ステータスアクセサリースティックス"
  },
  State_99239_WeaponDesc = {
    Text = "装備者が与える基本ダメージが10%アップする。装備者のダメージ強化が20%を超える場合、基本ダメージがさらに10%アップする。"
  },
  State_99258_Desc = {
    Text = "チームユニーク：毎ターン2回目のキーオーダーを発動した後、<WeaponEffect_Num:[StateArg1]>％の確率で装備者の指令カードを1枚引く。毎ターン3枚目の装備者の指令カードを発射した後、<WeaponEffect_Num:[StateArg2]>のキーエネルギーを獲得する。"
  },
  State_99258_WeaponDesc = {
    Text = "毎ターン2回目のキーオーダーを発動した後、<WeaponEffect_Num:[StateArg1]%>の確率で装備者の指令カードを1枚引く。毎ターン3枚目の装備者の指令カードを発射した後、<WeaponEffect_Num:[StateArg2]>ポイントのキーエネルギーを獲得する。"
  },
  State_99294_Desc = {
    Text = "すべての覚醒体が獲得する狂気が[StateArg1]%増加し、ターン終了時の行動力と指令カードは次のターンに持ち越すことができる。「華やかな章」で獲得する狂気が増加。"
  },
  State_99295_Desc = {
    Text = "すべての覚醒体が獲得する狂気が[StateArg1]%増加し、ターン終了時の行動力と指令カードは次のターンに持ち越すことができる。「華やかな章」で獲得する狂気が増加。"
  },
  State_99336_Desc = {
    Text = "「画家」が作画に使用する染料。スキル効果を強化する。上限は10点。"
  },
  State_99336_Name = {
    Text = "<DecayDye:幻の染料>"
  },
  State_99533_Name = {
    Text = "装飾品の少女のさなぎ"
  },
  State_99533_WeaponDesc = {
    Text = "バトル開始後、装備者の職業がカオスの場合、攻撃力が 25％ 上昇します。"
  },
  State_99534_Name = {
    Text = "ナメクジプリン"
  },
  State_99534_WeaponDesc = {
    Text = "装備者が造成するシールドとライフ回復が6％上昇する。装備者の領域マスタリーが50より大きい場合、シールドとライフ回復が追加で6％上昇する。"
  },
  State_99640_Desc = {
    Text = "「創意」が10点に達すると、ピックマンが狂気解放を発動後、すべての「創意」を消費し、すべての覚醒体は15狂気を獲得し、1点の「狂想」を獲得する。「創意」の上限は10点で、次の戦闘に引き継がれる。"
  },
  State_99640_Name = {Text = "創意"},
  State_99723_Desc = {
    Text = "唯一装備：装備者が与える狂気と力の獲得量が <WeaponEffect_Num:[StateArg1]%>増加する。狂気解放を発動した後、このターン中、他の覚醒体の狂気解放の最終ダメージ、シールド、ライフ回復効果が<WeaponEffect_Num:[StateArg2]%>増加する。今回の狂気解放で「捕食」効果を発動した時、装備者は <WeaponEffect_Num:[StateArg3]>狂気を獲得。"
  },
  State_99723_WeaponDesc = {
    Text = "装備者が与える狂気と力の獲得量が <WeaponEffect_Num:[StateArg1]%>増加する。狂気解放を発動した後、このターン中、他の覚醒体の狂気解放の最終ダメージ、シールド、ライフ回復効果が<WeaponEffect_Num:[StateArg2]%>増加する。今回の狂気解放で「捕食」効果を発動した時、装備者は <WeaponEffect_Num:[StateArg3]>狂気を獲得。"
  }
})
return Text_State
