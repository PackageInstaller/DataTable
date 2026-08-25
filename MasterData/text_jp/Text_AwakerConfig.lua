__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_AwakerConfig = readonly({
  AwakerConfig_125346_AwakerIntroduction = {
    Text = "·優雅で妖艶な東方の「神」。彼女が扇を退けた時、衆生は皆その致命的な魅力に酔いしれる。\n·情欲から生まれる歓びは蝕骨の毒のように纏わりつき、彼女が交わす情の誓いの中で融解と静寂へと向かうことを甘受させる。\n·今回のステージでは、レベル50、スキルレベル5、啓霊3のシュー·ラモーナで出撃。ターン開始時に「高級インスピレーション」1枚と「胚胎」1枚を手札に加え、すべての敵に「痴酔」を1層付与する。"
  },
  AwakerConfig_125346_Gender = {Text = "女性"},
  AwakerConfig_125346_Introduction = {
    Text = "人を酔わせる魅力で敵の闘志を瓦解させ、全身に浸透する蝕骨の毒素は、その沈溺の瞬間に轟然と迸る。"
  },
  AwakerConfig_125346_SummonSlogan = {
    Text = "戦慄するほどの美しさを見つめよ。彼女は貴方を「愛」している、彼の方は永遠に、永遠に貴方に「寄り添う」だろう。"
  },
  AwakerConfig_125346_VoiceActor = {
    Text = "田中理恵"
  },
  AwakerConfig_130226_AwakerIntroduction = {
    Text = "・すべてが血肉に侵蝕され、日常が歪み乱れるとき、嘶く雑音の中で、タンポポはこの荒野に舞い降りた。\n・手を伸ばして、彼女の手を取って。愛は表象を突き破り、あなたとあなたの愛する人を、再び繋ぎ止める。\n・「沙耶の歌」は味方一人を選んで大量のカードをコピーし山札に加えます。<DevouredIconKeywords:捕食>の発動や「生体擬態」が生成した「羽種」の消費によりコピーしたカードを強化でき、「血脂爛漫」はこれらのカードを素早く手札に引き込み、敵に大量の「侵蝕」を付与します。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発3の沙耶とロータンが出撃します。戦闘開始時、沙耶は200点の狂気、4層の「羽種」、500点の力を獲得します。ターン開始時、「胚胎」1枚を手札に加え、カードを3枚引き、行動力を3点獲得し、すべての覚醒体は50の狂気を獲得します。"
  },
  AwakerConfig_130226_Gender = {Text = "女性"},
  AwakerConfig_130226_Introduction = {
    Text = "遥かな星々の間の障壁を越えて、愛だけが唯一の、永遠の命題。"
  },
  AwakerConfig_130226_SummonSlogan = {
    Text = "すべてのタンポポが風に散ったとき、愛の名のもとに、わたしたちはまた巡り会う。"
  },
  AwakerConfig_130226_VoiceActor = {Text = "川村緑"},
  AwakerConfig_130384_Gender = {Text = "女性"},
  AwakerConfig_130384_Name = {
    Text = "ツァトゥグア"
  },
  AwakerConfig_130384_Title = {
    Text = "ツァトゥグア"
  },
  AwakerConfig_130901_AwakerIntroduction = {
    Text = "·友情を求める明るい少女は、仲間の狂気解放から鼓舞を受け、攻撃を放って仲間と協力して敵を追撃します。\n·彼女の細い体に似合わない恐ろしい大砲は、渇望するようにエネルギーを捕食し、拘束が解除された時に発生する渦流は周囲のすべてを瞬時に平らにします。\n·今回のステージでは、レベル50、スキルレベル5、霊知啓発3のモスクとラモンナ、オジールが出撃し、バトル開始時に200ポイントの触腕ダメージを獲得し、ターン開始時に3枚のカードを引き、3ポイントの行動力を獲得します。モスク以外の覚醒体は50ポイントの狂気を獲得します。"
  },
  AwakerConfig_130901_Gender = {Text = "女性"},
  AwakerConfig_130901_Introduction = {
    Text = "明るく率直な野性的少女。手にした重火器に渦流エネルギーを集束させ、甚大な破壊をもたらす。"
  },
  AwakerConfig_130901_Name = {Text = "モス"},
  AwakerConfig_130901_SummonSlogan = {
    Text = "拘束、導引、解放、破壊。渦は彼女の導きに従い、すべての悪人を深淵に沈める。"
  },
  AwakerConfig_130901_Title = {Text = "モス"},
  AwakerConfig_130901_VoiceActor = {
    Text = "松元菜々海"
  },
  AwakerConfig_130901_Weight = {
    Text = "身体構成が特殊なため、計測不能"
  },
  AwakerConfig_132340_Gender = {Text = "男性"},
  AwakerConfig_132340_Introduction = {
    Text = "奇妙な使命を持つ電子幽霊。その真の姿を目にした者はごくわずか。"
  },
  AwakerConfig_132340_Name = {
    Text = "赭の壱型"
  },
  AwakerConfig_132340_Title = {
    Text = "禁忌実験体"
  },
  AwakerConfig_132374_Gender = {Text = "男性"},
  AwakerConfig_132374_Introduction = {
    Text = "奇妙な使命を持つ電子幽霊。その真の姿を目にした者はごくわずか。"
  },
  AwakerConfig_132374_Name = {
    Text = "蒼の壱型"
  },
  AwakerConfig_132374_Title = {
    Text = "禁忌実験体"
  },
  AwakerConfig_132375_Gender = {Text = "男性"},
  AwakerConfig_132375_Introduction = {
    Text = "奇妙な使命を持つ電子幽霊。その真の姿を目にした者はごくわずか。"
  },
  AwakerConfig_132375_Name = {
    Text = "緋の壱型"
  },
  AwakerConfig_132375_Title = {
    Text = "禁忌実験体"
  },
  AwakerConfig_132376_Gender = {Text = "男性"},
  AwakerConfig_132376_Introduction = {
    Text = "奇妙な使命を持つ電子幽霊。その真の姿を目にした者はごくわずか。"
  },
  AwakerConfig_132376_Name = {
    Text = "赤の壱型"
  },
  AwakerConfig_132376_Title = {
    Text = "禁忌実験体"
  },
  AwakerConfig_141302_AwakerIntroduction = {
    Text = "·失われざる地の統御者にして領主、その眼に映るものは全て、永遠に従う民へと変わる。\n·哨笛が鳴り響けば、巣から溢れ出す「囚魘」は彼の使い勝手の良い狩猟道具。力を奪い尽くされた敵は、取り囲まれながら深淵へと落ちていき、かくして永遠の国に新たな一員が加わる。\n·本ステージでは、レベル50、スキルレベル5、霊知啓発3のポントスを出撃させ、戦闘開始時に触腕ダメージ100を獲得し、ポントスは狂気75・「包囲狩猟」3層を獲得する。ターン開始時、カードを3枚引き、全ての覚醒体が狂気20を獲得する。"
  },
  AwakerConfig_141302_Gender = {Text = "男性"},
  AwakerConfig_141302_Introduction = {
    Text = "深淵は彼にすべてを留め置く力を与えた。もはや何者も、絶望的な分離に彼を直面させることはできない。"
  },
  AwakerConfig_141302_Name = {
    Text = "ポントス"
  },
  AwakerConfig_141302_SummonSlogan = {
    Text = "海の果てに、終わりなき狂宴がある。"
  },
  AwakerConfig_141302_Title = {
    Text = "ポントス"
  },
  AwakerConfig_141302_VoiceActor = {
    Text = "諏訪部順一"
  },
  AwakerConfig_141302_Weight = {
    Text = "測定不能"
  },
  AwakerConfig_143941_Gender = {Text = "女性"},
  AwakerConfig_143941_Name = {Text = "太歳"},
  AwakerConfig_143941_Title = {Text = "太歳"},
  AwakerConfig_145363_AwakerIntroduction = {
    Text = "·戦いのために生まれた戦士であり、強大な敵であるほど彼女の興奮をかき立てる。合璧沉鲸の巨剣を持ち、彼女は全てを捕食し、全てを征服する。\n·今回のステージでは、レベル50、スキルレベル5、霊知啓発3の蝕滅・ロータンとラモンナ、オジールを連れて出撃する。\n·この戦闘中、守秘者の最大ライフが2倍になる。ターン開始時に「啓示」を1枚手札に加え、全ての覚醒体が20点の狂気を獲得する。"
  },
  AwakerConfig_145363_Gender = {Text = "女性"},
  AwakerConfig_145363_Height = {Text = "168cm"},
  AwakerConfig_145363_Introduction = {
    Text = "戦いのために生まれた戦士、強大な敵であるほど彼女の興奮をかき立てる。合璧沉鲸の巨剣を手に、彼女は一切を捕食し、一切を征服する。"
  },
  AwakerConfig_145363_Name = {
    Text = "蝕滅・ロータン"
  },
  AwakerConfig_145363_SummonSlogan = {
    Text = "前進、それが嵐の唯一の方向。 そして彼女は、生まれながらにして嵐そのものだった。"
  },
  AwakerConfig_145363_Title = {
    Text = "蝕滅・ロータン"
  },
  AwakerConfig_145363_VoiceActor = {
    Text = "宮園美海"
  },
  AwakerConfig_147397_Characteristic = {
    Text = "カード強化 力量奪取"
  },
  AwakerConfig_147397_Gender = {Text = "女性"},
  AwakerConfig_147397_Height = {Text = "163cm"},
  AwakerConfig_147397_Name = {
    Text = "暮星・ティンクト"
  },
  AwakerConfig_147397_Title = {
    Text = "暮星・ティンクト"
  },
  AwakerConfig_147397_VoiceActor = {
    Text = "岡本美歌"
  },
  AwakerConfig_147397_Weight = {Text = "50kg"},
  AwakerConfig_15560_AwakerIntroduction = {
    Text = "・霊知覚醒と指令カードを通じて素早く<RetaliateIconKeywords:反撃>を蓄積でき、与えるダメージが高いほど、獲得する<RetaliateIconKeywords:反撃>も多くなる。\n・現在の<RetaliateIconKeywords:反撃>が高いほど、狂気解放が与える範囲ダメージが高くなる。敵が1体のみの場合、狂気解放はさらに追加で1回ダメージを与える。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したパンディアが出撃し、敵は最初のターンに強化を獲得する。"
  },
  AwakerConfig_15560_Characteristic = {
    Text = "敵を反撃    複数ダメージ"
  },
  AwakerConfig_15560_Gender = {Text = "女性"},
  AwakerConfig_15560_Height = {Text = "147cm"},
  AwakerConfig_15560_Introduction = {
    Text = "鞭で相手を打ちつつ大量の反撃を得て、反撃を試みる相手を苦しめる。"
  },
  AwakerConfig_15560_Name = {
    Text = "パンディア"
  },
  AwakerConfig_15560_SummonSlogan = {
    Text = "表面の甘さを盲信しないで。熱情の裏には悪鬼が潜んでいるかもしれない。"
  },
  AwakerConfig_15560_Title = {
    Text = "パンディア"
  },
  AwakerConfig_15560_VoiceActor = {Text = "橘ゆき"},
  AwakerConfig_15560_Weight = {Text = "39kg"},
  AwakerConfig_15562_AwakerIntroduction = {
    Text = "・ターン終了時、「緑炎」が手札または超次元空間にある場合、<DerivativeCardKeywords_19:「腐敗した緑炎」>にアップグレードされる。アップグレード後は、より高いダメージと<IntoxicationIconKeywords:毒>を与えることができる。\n・多段ダメージに直面した際、「誘蛾の炎」で複数の「緑炎」を獲得できる。\n・狂気解放は手札にあるすべてのリッツのカードを行動力消費なしで発動できる。大量の「緑炎」を蓄積すると、超高火力の爆発ダメージを与えることが可能になる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したリッツが出撃し、毎ターン7点の<PowerIconKeywords:力>と15狂気を獲得、超次元ターン開始後にさらに100狂気を獲得する。敵は最初の1ターンの間、強化される。"
  },
  AwakerConfig_15562_Characteristic = {
    Text = "毒爆発  資源循環"
  },
  AwakerConfig_15562_Gender = {Text = "女性"},
  AwakerConfig_15562_Height = {Text = "165cm"},
  AwakerConfig_15562_Introduction = {
    Text = "超次元空間や手札で緑色の炎を育て、狂気解放でそれを一気に放ち敵を焼き尽くす。"
  },
  AwakerConfig_15562_Name = {Text = "リッツ"},
  AwakerConfig_15562_SummonSlogan = {
    Text = "回転するつま先は、彼女の追い求める夢、そしてすべてが崩れた後の憎しみと、絶望から燃え上がる緑炎を支えていた。"
  },
  AwakerConfig_15562_Title = {Text = "リッツ"},
  AwakerConfig_15562_VoiceActor = {
    Text = "青池優花"
  },
  AwakerConfig_15563_AwakerIntroduction = {
    Text = "・カードと狂気解放を使用して、触腕に爆発的な成長をもたらす。\n・触腕発動の能力を利用して、敵に大ダメージを与える。\n・本ステージでは追加の行動力と狂気を獲得できる。"
  },
  AwakerConfig_15563_Characteristic = {
    Text = "触腕爆発    触腕成長"
  },
  AwakerConfig_15563_Gender = {Text = "男性"},
  AwakerConfig_15563_Height = {Text = "251cm"},
  AwakerConfig_15563_Introduction = {
    Text = "王者の威圧で触腕を指揮し敵を制裁し、王の血脈で爆発的な触腕ダメージの潜在能力を迅速に引き出す。"
  },
  AwakerConfig_15563_Name = {
    Text = "トゥルー"
  },
  AwakerConfig_15563_SummonSlogan = {
    Text = "通説に反して、水が嫌い。"
  },
  AwakerConfig_15563_Title = {
    Text = "トゥルー"
  },
  AwakerConfig_15563_VoiceActor = {
    Text = "宮園美海"
  },
  AwakerConfig_15563_Weight = {Text = "32kg"},
  AwakerConfig_15564_AwakerIntroduction = {
    Text = "・「巨刃の威」と「斬首一閃」は高ダメージと多倍の<PowerIconKeywords:力>ボーナスを持ち、単体および範囲の敵に大ダメージを与えることができる。\n・「斬首一閃」は低ライフの敵を攻撃、または撃破した時、行動力消費が返還される。\n・狂気解放は簒奪または蟄伏を選択でき、成長か爆発のタイミングを選ぶことでより多くのダメージを出せる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したゴリアテが出撃する。"
  },
  AwakerConfig_15564_Characteristic = {
    Text = "力爆発    力の吸収"
  },
  AwakerConfig_15564_Gender = {Text = "男性"},
  AwakerConfig_15564_Height = {Text = "285cm"},
  AwakerConfig_15564_Introduction = {
    Text = "巨刃の力をもって重刃を振り回し敵を斬殺する。触腕ダメージと力が彼をさらに強力にする。"
  },
  AwakerConfig_15564_Name = {
    Text = "ゴリアテ"
  },
  AwakerConfig_15564_SummonSlogan = {
    Text = "彼が大剣を振り上げると、必ず血と死がもたらされる。"
  },
  AwakerConfig_15564_Title = {
    Text = "ゴリアテ"
  },
  AwakerConfig_15565_AwakerIntroduction = {
    Text = "・強力な防護と<RetaliateIconKeywords:反撃>を蓄積する能力を持ち、霊知覚醒後、その能力はさらに一段階向上する。\n・現在のシールドが高いほど、狂気解放で獲得するシールドが多くなる。現在の<RetaliateIconKeywords:反撃>が高いほど、狂気解放が与える範囲ダメージが高くなる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したナウティラとドールが出撃し、毎ターン10狂気を獲得、敵は最初のターンに強化を獲得する。"
  },
  AwakerConfig_15565_Characteristic = {
    Text = "防護爆発　捨て札回収"
  },
  AwakerConfig_15565_Gender = {Text = "女性"},
  AwakerConfig_15565_Height = {Text = "157cm"},
  AwakerConfig_15565_Introduction = {
    Text = "頑丈な螺殻で防御を強化し、螺殻の棘で反撃する。"
  },
  AwakerConfig_15565_Name = {
    Text = "ナウティラ"
  },
  AwakerConfig_15565_SummonSlogan = {
    Text = "冒険を続けられる限り、彼女は笑顔で前進できる。"
  },
  AwakerConfig_15565_Title = {
    Text = "ナウティラ"
  },
  AwakerConfig_15565_Weight = {Text = "48kg"},
  AwakerConfig_15566_AwakerIntroduction = {
    Text = "・比較的オールマイティな行動力供給、ライフ回復、触腕ダメージ増加のサポート能力を持つ。\n・狂気解放後、この戦闘中に致死ダメージを受けた時に復活する。各戦闘で最大1回まで発動。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したシレストが出撃し、毎ターン20狂気を獲得し、敵は最初の1ターンの間、強化される。"
  },
  AwakerConfig_15566_Characteristic = {
    Text = "一時的な触腕    死亡無効化"
  },
  AwakerConfig_15566_Gender = {Text = "女性"},
  AwakerConfig_15566_Height = {Text = "165cm"},
  AwakerConfig_15566_Introduction = {
    Text = "航行を庇護し、死の危機から味方を守り、夢の力で味方のライフを回復する。"
  },
  AwakerConfig_15566_Name = {
    Text = "シレスト"
  },
  AwakerConfig_15566_SummonSlogan = {
    Text = "「あの船は、なぜ沈んだの？」"
  },
  AwakerConfig_15566_Title = {
    Text = "シレスト"
  },
  AwakerConfig_15567_AwakerIntroduction = {
    Text = "・鎖を自在に操って敵を攻撃し、ダメージを与えると同時に大量の<BleedingIconKeywords:出血>を付与する。\n・事前に手札を蓄え、タイミングを見計らって狂気解放を発動し強力なバフを獲得、<DevouredIconKeywords:吞噬>効果と組み合わせて自身のすべてのカードの行動力消費を減少させる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動した血ノ鎖・ヘロットが出撃し、初期ライフは40%、ターン終了時に50狂気と100胚胎融合度を獲得する。"
  },
  AwakerConfig_15567_Characteristic = {
    Text = "連環攻撃    攻撃カード強化"
  },
  AwakerConfig_15567_Gender = {Text = "女性"},
  AwakerConfig_15567_Introduction = {
    Text = "独特な連撃で敵に多段ダメージを与え、敵の鮮血で自身を癒す。"
  },
  AwakerConfig_15567_Name = {
    Text = "血ノ鎖・ヘロット"
  },
  AwakerConfig_15567_SummonSlogan = {
    Text = "鎖を断ち切り、彼女は自分を縛ったすべての者に復讐する。"
  },
  AwakerConfig_15567_Title = {
    Text = "血ノ鎖・ヘロット"
  },
  AwakerConfig_15568_Characteristic = {
    Text = "カード検索    複数ダメージ"
  },
  AwakerConfig_15568_Gender = {Text = "女性"},
  AwakerConfig_15568_Height = {Text = "165cm"},
  AwakerConfig_15568_Introduction = {
    Text = "過去の指令から力を得て彼女のものとし、運命の剣で高い単発ダメージを与える。"
  },
  AwakerConfig_15568_Name = {
    Text = "環行・ラモンナ"
  },
  AwakerConfig_15568_Title = {
    Text = "環行・ラモンナ"
  },
  AwakerConfig_15568_VoiceActor = {
    Text = "山本亜衣"
  },
  AwakerConfig_15568_Weight = {Text = "46kg"},
  AwakerConfig_15569_Characteristic = {
    Text = "高範囲攻撃    ダメージ増加"
  },
  AwakerConfig_15569_Gender = {Text = "女性"},
  AwakerConfig_15569_Height = {Text = "170cm"},
  AwakerConfig_15569_Introduction = {
    Text = "連続した「攻撃」で複数ダメージを与え、終焉の巨獣を召喚して敵を飲み込む。"
  },
  AwakerConfig_15569_Name = {
    Text = "ロータン"
  },
  AwakerConfig_15569_SummonSlogan = {
    Text = "星の巨獣いわく：大波を起こせ！敵の悲鳴を聞かせろ！"
  },
  AwakerConfig_15569_Title = {
    Text = "ロータン"
  },
  AwakerConfig_15569_VoiceActor = {
    Text = "宮園美海"
  },
  AwakerConfig_15569_Weight = {Text = "25t"},
  AwakerConfig_15570_Characteristic = {
    Text = "倦怠を解除 ライフ回復"
  },
  AwakerConfig_15570_Gender = {Text = "女性"},
  AwakerConfig_15570_Height = {Text = "158cm"},
  AwakerConfig_15570_Introduction = {
    Text = "完璧な研究成果で他の覚醒体に狂気を提供し、大量のライフを回復する。"
  },
  AwakerConfig_15570_Name = {Text = "ドール"},
  AwakerConfig_15570_SummonSlogan = {
    Text = "彼女が追い求めていたのは、天地の真理だった。"
  },
  AwakerConfig_15570_Title = {Text = "ドール"},
  AwakerConfig_15570_VoiceActor = {
    Text = "魚谷佳代"
  },
  AwakerConfig_15570_Weight = {Text = "40kg"},
  AwakerConfig_15571_AwakerIntroduction = {
    Text = "・強力なライフ回復と、柔軟な行動力供給能力を持つ。\n・「ガマシチュー」と「静観」はいずれも<RetainIconKeywords:保持>を持ち、1ターン保持するごとに異なる成長を獲得する。\n・狂気解放、「ガマシチュー」、「不思議な料理」はすべての敵に<IntoxicationIconKeywords:毒>を付与できる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したカレンが出撃し、敵は最初の攻撃時に強化を獲得する。"
  },
  AwakerConfig_15571_Characteristic = {
    Text = "行動力を補充し、死に抗う"
  },
  AwakerConfig_15571_Gender = {Text = "女性"},
  AwakerConfig_15571_Height = {Text = "155cm"},
  AwakerConfig_15571_Introduction = {
    Text = "チームに大量の行動力を提供し、料理でライフを回復しつつ、暗黒料理で敵を毒殺する。"
  },
  AwakerConfig_15571_Name = {Text = "カレン"},
  AwakerConfig_15571_SummonSlogan = {
    Text = "箒でも武器でも、彼女は優雅に使いこなす。"
  },
  AwakerConfig_15571_Title = {Text = "カレン"},
  AwakerConfig_15571_VoiceActor = {
    Text = "二ノ宮雪乃"
  },
  AwakerConfig_15571_Weight = {Text = "45kg"},
  AwakerConfig_15572_AwakerIntroduction = {
    Text = "・狂気解放は範囲ダメージとカードドローをもたらし、自身の指令カード、状態カードまたは症状カードを多く引くほど、ダメージ回数が増える。\n・「消失マジック」は手札をリシャッフルでき、同時に状態カードまたは症状カードを捨てて狂気を獲得する。\n・「念動力操作」は超次元空間のカードを取り出し、高ダメージと行動力に変換できる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したカーシアが出撃し、ボス敵の初回攻撃時に強化を獲得する。"
  },
  AwakerConfig_15572_Characteristic = {
    Text = "手札補充 一時的な力"
  },
  AwakerConfig_15572_Gender = {Text = "女性"},
  AwakerConfig_15572_Height = {Text = "152cm"},
  AwakerConfig_15572_Introduction = {
    Text = "魔法のように大量のカードを引いたり交換したりし、一時的な力を得てダメージを強化することができる。"
  },
  AwakerConfig_15572_Name = {
    Text = "カーシア"
  },
  AwakerConfig_15572_SummonSlogan = {
    Text = "有形のものを消すなんてなんでもない？彼女のマジックは魂を盗むことができる。"
  },
  AwakerConfig_15572_Title = {
    Text = "カーシア"
  },
  AwakerConfig_15572_VoiceActor = {Text = "七緒凛"},
  AwakerConfig_15572_Weight = {Text = "45kg"},
  AwakerConfig_15573_Characteristic = {
    Text = "複数ダメージ    防御貫通"
  },
  AwakerConfig_15573_Gender = {Text = "女性"},
  AwakerConfig_15573_Height = {Text = "179cm"},
  AwakerConfig_15573_Introduction = {
    Text = "絶え間なく腺体を分裂させて低行動力消費の攻撃を行い、必要時には全腺体を消費して総攻撃を仕掛ける。"
  },
  AwakerConfig_15573_Name = {
    Text = "オレッタ"
  },
  AwakerConfig_15573_SummonSlogan = {
    Text = "「うん？クラゲ？ゼリー？」"
  },
  AwakerConfig_15573_Title = {
    Text = "オレッタ"
  },
  AwakerConfig_15573_VoiceActor = {
    Text = "田村ゆかり"
  },
  AwakerConfig_15573_Weight = {Text = "20kg"},
  AwakerConfig_15574_AwakerIntroduction = {
    Text = "・霊知覚醒はティンクトのすべての指令カードにランダム効果を付与し、ランダムに<WeaknessIconKeywords:脆弱>、<VulnerabilityIconKeywords:易傷>、カードドロー、行動力、狂気の能力を獲得する。\n・狂気解放は手札5枚の行動力消費を1減少させると同時に、ティンクトの「打撃」基礎ダメージを増幅する。\n・力と「打撃」基礎ダメージを蓄積することで、「打撃」は高額ダメージを与えることができる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したティンクトが出撃し、毎ターン15狂気を獲得、敵は最初の1ターンの間、強化される。"
  },
  AwakerConfig_15574_Characteristic = {
    Text = "力奪取    消費減少"
  },
  AwakerConfig_15574_Gender = {Text = "女性"},
  AwakerConfig_15574_Height = {Text = "163cm"},
  AwakerConfig_15574_Introduction = {
    Text = "時空を超えた歌声で手札の大量のカードの行動力消費を減らし、仲間の戦闘意志を高める。"
  },
  AwakerConfig_15574_Name = {
    Text = "ティンクト"
  },
  AwakerConfig_15574_SummonSlogan = {
    Text = "金の檻の中、無形の枷の下で、ナイチンゲールはただ歌う、ただ歌う。"
  },
  AwakerConfig_15574_Title = {
    Text = "ティンクト"
  },
  AwakerConfig_15574_VoiceActor = {
    Text = "岡本美歌"
  },
  AwakerConfig_15574_Weight = {Text = "50kg"},
  AwakerConfig_15575_AwakerIntroduction = {
    Text = "・狂気解放と霊知覚醒は強力なドロー能力を持ち、チームの許容範囲を高める。\n・「深淵の暗流」により触腕が攻撃するたびにすべての敵に<IntoxicationIconKeywords:毒>を付与でき、触腕攻撃の駆使と「狂熱の海」を組み合わせることで一度に大量の<IntoxicationIconKeywords:毒>を敵に付与できる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発3のファロスが出撃し、敵は最初のターンに強化を獲得する。"
  },
  AwakerConfig_15575_Characteristic = {
    Text = "触腕生成    手札を補充"
  },
  AwakerConfig_15575_Gender = {Text = "女性"},
  AwakerConfig_15575_Height = {Text = "167cm"},
  AwakerConfig_15575_Introduction = {
    Text = "触腕に猛毒を帯びさせて敵を屈服させ、敬虔な信仰心によりチームにカードを獲得させ、進むべき道を示す。"
  },
  AwakerConfig_15575_Name = {
    Text = "ファロス"
  },
  AwakerConfig_15575_SummonSlogan = {
    Text = "海底火山の呼吸はもう耳元で低く鳴らず、深海の幻夢もぼんやりとした映像になっている。"
  },
  AwakerConfig_15575_Title = {
    Text = "ファロス"
  },
  AwakerConfig_15576_AwakerIntroduction = {
    Text = "・独自の防護能力を持ち、敵のダメージを<SacrificeKeyWord:献上>に変換する。\n・カードを使用すると触腕上限を無視した触腕数を獲得できる。\n・柔軟に<SacrificeKeyWord:献上>を前借りして防御に変換することで、より強力な短期戦力を得られる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動した「マーフィー」が出撃する。"
  },
  AwakerConfig_15576_Characteristic = {
    Text = "触腕発動    行動力を補充"
  },
  AwakerConfig_15576_Gender = {Text = "女性"},
  AwakerConfig_15576_Height = {Text = "144cm"},
  AwakerConfig_15576_Introduction = {
    Text = "<SummonBlue:『星辰の正位置』獲得報酬UP>\n「献上」を伴いつつ高ダメージを耐え、触腕の総攻撃を指揮する。"
  },
  AwakerConfig_15576_Name = {
    Text = "マーフィー"
  },
  AwakerConfig_15576_SummonSlogan = {
    Text = "ケーキと柔らかいベッドを差し出せば、彼女は話を聞いてくれるかもしれない。"
  },
  AwakerConfig_15576_Title = {
    Text = "マーフィー"
  },
  AwakerConfig_15576_VoiceActor = {Text = "大内 茜"},
  AwakerConfig_15576_Weight = {Text = "42kg"},
  AwakerConfig_15577_AwakerIntroduction = {
    Text = "・狂気解放は味方に永続的な死亡抵抗を提供できる。\n・死亡抵抗発動後、防御能力と回復能力が増加する。\n・霊知覚醒と指令カードにより大量の反撃を獲得し、敵の<PowerIconKeywords:力量>を削弱でき、複数の敵や複数ダメージに対して有利になる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したファイントが出撃し、毎ターン30の<EmbryoFusionIconKeywords:胚胎融合>と10狂気を獲得する。敵は最初の2ターンの間、強化される。"
  },
  AwakerConfig_15577_Characteristic = {
    Text = "死亡抵抗 力を奪う"
  },
  AwakerConfig_15577_Gender = {Text = "女性"},
  AwakerConfig_15577_Height = {Text = "137cm"},
  AwakerConfig_15577_Introduction = {
    Text = "高い死亡抵抗を付与でき、相手の力を吸収して攻撃に抵抗する。"
  },
  AwakerConfig_15577_Name = {
    Text = "ファイント"
  },
  AwakerConfig_15577_SummonSlogan = {
    Text = "ナイチンゲールを愛する劣等品も、いつかは咲く日が来る。"
  },
  AwakerConfig_15577_Title = {
    Text = "ファイント"
  },
  AwakerConfig_15577_VoiceActor = {
    Text = "伊藤さつき"
  },
  AwakerConfig_15577_Weight = {Text = "33kg"},
  AwakerConfig_15578_Gender = {Text = "女性"},
  AwakerConfig_15578_Height = {Text = "133cm"},
  AwakerConfig_15578_Introduction = {
    Text = "高いクリティカル率とクリティカルダメージを持ち、ブラウンと鼠の群れは彼が多くの敵と戦うための重要な助けとなる。"
  },
  AwakerConfig_15578_Name = {
    Text = "ジェンキン"
  },
  AwakerConfig_15578_Title = {
    Text = "ジェンキン"
  },
  AwakerConfig_15578_Weight = {Text = "30kg"},
  AwakerConfig_15579_AwakerIntroduction = {
    Text = "・強力な防護と狂気を提供する能力を持つ。\n・狂気解放は、他の覚醒体1体により多くの狂気を獲得させ、より多くの狂気解放を発動させることができ、1ターンで連続して狂気解放を発動することも可能。\n・霊知覚醒により、シールド付与時に反撃を獲得でき、多段攻撃の敵に対しても反撃能力を持つ。\n本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したウインクルとロータンが出撃し、試遊戦闘中にバフを獲得、敵は最初の1ターンの間、強化される。"
  },
  AwakerConfig_15579_Characteristic = {
    Text = "狂気供給    ドロー遅延"
  },
  AwakerConfig_15579_Gender = {Text = "女性"},
  AwakerConfig_15579_Height = {Text = "168cm"},
  AwakerConfig_15579_Introduction = {
    Text = "他の味方に狂気を提供でき、同時に手札を使い切って高額シールドを凝縮することもできる。"
  },
  AwakerConfig_15579_Name = {
    Text = "ウインクル"
  },
  AwakerConfig_15579_SummonSlogan = {
    Text = "記憶の中の闇さえも、その恐ろしい呪いを招く。"
  },
  AwakerConfig_15579_Title = {
    Text = "ウインクル"
  },
  AwakerConfig_15579_VoiceActor = {Text = "七緒凛"},
  AwakerConfig_15579_Weight = {Text = "56kg"},
  AwakerConfig_15580_AwakerIntroduction = {
    Text = "・指令カードを通じて敵に素早く<IntoxicationIconKeywords:毒>を蓄積させ、狂気解放を使用して敵の<IntoxicationIconKeywords:毒>効果を誘発し、大ダメージを与える。\n・「夜潮洶湧」が与えるダメージと毒は症状カードを出すたびに成長する。\n・狂気解放が付与する毒は使用回数に応じて増加する。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したニムフィーアが出撃し、戦闘開始時に症状カードを3枚獲得する。"
  },
  AwakerConfig_15580_Characteristic = {
    Text = "毒発動　敵の倦怠化"
  },
  AwakerConfig_15580_Gender = {Text = "女性"},
  AwakerConfig_15580_Height = {Text = "155cm"},
  AwakerConfig_15580_Introduction = {
    Text = "「海毒」と「倦怠」を組み合わせ、生存を確保しつつ敵を苦しめる。"
  },
  AwakerConfig_15580_Name = {
    Text = "ニムフィーア"
  },
  AwakerConfig_15580_SummonSlogan = {
    Text = "一度も咲かなかった睡蓮は再び海の底へ戻っていった。"
  },
  AwakerConfig_15580_Title = {
    Text = "ニムフィーア"
  },
  AwakerConfig_15580_VoiceActor = {
    Text = "東海林亜祐"
  },
  AwakerConfig_15580_Weight = {Text = "41kg"},
  AwakerConfig_15581_AwakerIntroduction = {
    Text = "・強力な防護能力を持ち、生命が低いほど防護が強くなる。\n・痛みが増すほど狂気も増し、窮地においては一撃必殺の力を持つ。\n本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したリリーが出撃する。"
  },
  AwakerConfig_15581_Characteristic = {
    Text = "生命上限    傷ついて強くなる"
  },
  AwakerConfig_15581_Gender = {Text = "女性"},
  AwakerConfig_15581_Height = {Text = "133cm"},
  AwakerConfig_15581_Introduction = {
    Text = "受けた痛みを怒りに変えて敵を倒すか、生命に変えて味方を助ける。"
  },
  AwakerConfig_15581_Name = {Text = "リリー"},
  AwakerConfig_15581_SummonSlogan = {
    Text = "「お母さん、どこ？」"
  },
  AwakerConfig_15581_Title = {Text = "リリー"},
  AwakerConfig_15581_VoiceActor = {
    Text = "盛恵里花"
  },
  AwakerConfig_15581_Weight = {Text = "154kg"},
  AwakerConfig_15582_AwakerIntroduction = {
    Text = "・指令カードに独自の<O07CardKeyWord:祭儀>効果を持ち、<O07CardKeyWord2:「聖礼」>に変換して指令カードを強化する。\n・狂気解放を使用するとより多くの<O07CardKeyWord2:「聖礼」>を獲得できるだけでなく、異なる触腕姿態に応じて異なる効果を得られる。\n・3枚の霊知覚醒を段階的に使用し、それぞれの能力を発揮する。最終的に強力な増益カード「神国の幻影」を持続的に獲得できる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発3の「ミリアム」と「オレッタ」で出撃する。手札の上限+2。「ミリアム」は初期狂気35、毎ターン20狂気を獲得する。"
  },
  AwakerConfig_15582_Characteristic = {
    Text = "触腕生成    狂気支援"
  },
  AwakerConfig_15582_Gender = {Text = "女性"},
  AwakerConfig_15582_Height = {Text = "170cm"},
  AwakerConfig_15582_Introduction = {
    Text = "大祭司の権能でより多くの触腕に号令を下し、祭祀の短剣で敵を毒殺することも可能。"
  },
  AwakerConfig_15582_Name = {
    Text = "ミリアム"
  },
  AwakerConfig_15582_SummonSlogan = {
    Text = "信仰が最終的に己を刺す刃となる。"
  },
  AwakerConfig_15582_Title = {
    Text = "ミリアム"
  },
  AwakerConfig_15582_VoiceActor = {
    Text = "北崎ひとみ"
  },
  AwakerConfig_15582_Weight = {Text = "50kg"},
  AwakerConfig_15583_AwakerIntroduction = {
    Text = "・4種の様々な効果の詩篇を持ち、躍遷をトリガーすると「喜、怒、哀、惧」のいずれかの情緒状態に入る。\n・各情緒状態はすべての覚醒体に異なる能力の強化をもたらし、オルラの狂気解放はさらに多くの強化を受ける。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したオルラとロータンが出撃し、敵は初ターンで強化を得る。"
  },
  AwakerConfig_15583_Characteristic = {
    Text = "遅延回復　　敵方弱体化"
  },
  AwakerConfig_15583_Gender = {Text = "女性"},
  AwakerConfig_15583_Height = {Text = "163cm"},
  AwakerConfig_15583_Introduction = {
    Text = "さまざまな「情緒」が異なる強力なバフをもたらし、一部のカードが狂気解放の効果を強化させる。"
  },
  AwakerConfig_15583_Name = {Text = "オルラ"},
  AwakerConfig_15583_SummonSlogan = {
    Text = "気をつけて、彼女の悲しみは薔薇の棘よりも痛い。"
  },
  AwakerConfig_15583_Title = {Text = "オルラ"},
  AwakerConfig_15583_VoiceActor = {Text = "橘ゆき"},
  AwakerConfig_15583_Weight = {Text = "40kg"},
  AwakerConfig_15584_AwakerIntroduction = {
    Text = "\n・ライフが低いほど、ダメージと回復が強くなる。\n・事前に胚胎を蓄え、無限<DevouredIconKeywords:吞噬>の狂気解放で一度に大量のダメージを与える。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したソレールが出撃し、初期ライフは40%。"
  },
  AwakerConfig_15584_Characteristic = {
    Text = "複数ダメージ    ライフ回復"
  },
  AwakerConfig_15584_Gender = {Text = "女性"},
  AwakerConfig_15584_Height = {Text = "170cm"},
  AwakerConfig_15584_Introduction = {
    Text = "華麗な輪舞で高い多段ダメージを与え、敵の鮮血で自身を癒す。"
  },
  AwakerConfig_15584_Name = {
    Text = "ソレール"
  },
  AwakerConfig_15584_SummonSlogan = {
    Text = "お持ちなさい、金刺繍の豪華な礼服を。\nお持ちなさい、異国の鳥の羽で作られた扇を。\nお持ちなさい、そうすれば彼女のサロンの招待を受けられる。"
  },
  AwakerConfig_15584_Title = {
    Text = "ソレール"
  },
  AwakerConfig_15584_VoiceActor = {
    Text = "田村ゆかり"
  },
  AwakerConfig_15584_Weight = {Text = "59kg"},
  AwakerConfig_15585_Characteristic = {
    Text = "脆弱解除　一時的な力"
  },
  AwakerConfig_15585_Gender = {Text = "男性"},
  AwakerConfig_15585_Height = {
    Text = "彼は自分の身長が150㎝以上だと信じている"
  },
  AwakerConfig_15585_Introduction = {
    Text = "無形の粘液で障壁を凝結し、長槍を掲げて仲間に突撃の号角を指示する。"
  },
  AwakerConfig_15585_Name = {
    Text = "オジール"
  },
  AwakerConfig_15585_SummonSlogan = {
    Text = "「もう誰も傷つけさせない」"
  },
  AwakerConfig_15585_Title = {
    Text = "オジール"
  },
  AwakerConfig_15585_Weight = {Text = "30kg"},
  AwakerConfig_15586_AwakerIntroduction = {
    Text = "・強力な<RetaliateIconKeywords:反撃>能力と、追加で躍遷をトリガーする独特な効果を持つ。\n・カードを使用して「夢引き」を蓄積し、柔軟に「夢引き」を消費して自身の能力を強化する。\n・<RetaliateIconKeywords:反撃>を積み重ね、敵を弱体化し、<RetaliateIconKeywords:反撃>でダメージを増加させる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したワンダが出撃する。"
  },
  AwakerConfig_15586_Characteristic = {
    Text = "高額反撃　　躍遷トリガー"
  },
  AwakerConfig_15586_Gender = {Text = "女性"},
  AwakerConfig_15586_Height = {Text = "170cm"},
  AwakerConfig_15586_Introduction = {
    Text = "<SummonPurple:『燃える饗宴』獲得報酬UP>\n体に棘をまとい大量の反撃を重ねて侵入者を貫き、棘を振るってダメージを与える。"
  },
  AwakerConfig_15586_Name = {Text = "ワンダ"},
  AwakerConfig_15586_SummonSlogan = {
    Text = "盲目の奴隷は厳かに誓い、高貴な律令を唱えた。彼女に近づき、従い……そして永遠に愛する。"
  },
  AwakerConfig_15586_Title = {Text = "ワンダ"},
  AwakerConfig_15586_Weight = {Text = "55kg"},
  AwakerConfig_15587_AwakerIntroduction = {
    Text = "・狂気解放は、このターン中に「攻撃」が与えるダメージを大幅に増加させることができる。\n・手札の「攻撃」が多いほど、「破鎖の一撃」のダメージはより高くなり、獲得する<PowerIconKeywords:力量>ボーナスもより高くなる。狂気解放と組み合わせることで、一度に大ダメージを与えることができる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したヘロットが出撃し、戦闘開始時に「攻撃」を3枚獲得し、毎ターン30の<EmbryoFusionIconKeywords:胚胎融合>、10狂気、6点の<PowerIconKeywords:力量>を獲得する。敵は最初の1ターンの間、強化される。"
  },
  AwakerConfig_15587_Characteristic = {
    Text = "単発高ダメージ    力成長"
  },
  AwakerConfig_15587_Gender = {Text = "女性"},
  AwakerConfig_15587_Introduction = {
    Text = "忍耐を続けて力を蓄え、一撃で敵に終結をもたらす復讐者。"
  },
  AwakerConfig_15587_Name = {
    Text = "ヘロット"
  },
  AwakerConfig_15587_SummonSlogan = {
    Text = "彼女が渇望していたのは、決して血ではなかった。"
  },
  AwakerConfig_15587_Title = {
    Text = "ヘロット"
  },
  AwakerConfig_15588_AwakerIntroduction = {
    Text = "・強力な防護と単体ダメージ能力を持ち、シールドが高いほど、「心眼の刃」が与えるダメージはより高くなる。\n・霊知覚醒後、アルバが与えるすべてのダメージはシールドボーナスを獲得する。\n・「戦闘体勢」は封印を解除する能力を持ち、狂気解放はさらに症状カードや状態カードを捨てて、追加のドローを獲得できる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したアルバが出撃し、敵は最初のターンに強化を獲得する。"
  },
  AwakerConfig_15588_Characteristic = {
    Text = "封印対抗 警戒増加"
  },
  AwakerConfig_15588_Gender = {Text = "女性"},
  AwakerConfig_15588_Height = {Text = "173cm"},
  AwakerConfig_15588_Introduction = {
    Text = "戦場を渡り歩いた戦士は大量のシールドを積み重ね、それを刃に変えて攻撃するのが得意。"
  },
  AwakerConfig_15588_Name = {Text = "アルバ"},
  AwakerConfig_15588_SummonSlogan = {
    Text = "戦場は彼女の四肢を奪ったが、彼女の魂を消すことはできない。"
  },
  AwakerConfig_15588_Title = {Text = "アルバ"},
  AwakerConfig_15588_VoiceActor = {
    Text = "二ノ宮雪乃"
  },
  AwakerConfig_15588_Weight = {Text = "65kg"},
  AwakerConfig_15589_AwakerIntroduction = {
    Text = "・海踊人たちが崇敬する神母として、彼女は新たな秩序を定め、すべての臣民を庇護し、深海界域の基礎効果を大幅に強化する。\n・倒錯した運命によって至高の権能を授かり、敵のライフを神への献上品に変えることができる。しかし、その禁忌の力は往々にして高い代償を伴う……。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動した誕妄・マーフィーとトゥルーが出撃する。"
  },
  AwakerConfig_15589_Characteristic = {
    Text = "触腕発動    行動力を補充"
  },
  AwakerConfig_15589_Gender = {Text = "女性"},
  AwakerConfig_15589_Height = {Text = "144cm"},
  AwakerConfig_15589_Introduction = {
    Text = "神母として臣民に祝福と庇護を与え、至高の権力で敵の生命を神に捧げる祭品へと変える。"
  },
  AwakerConfig_15589_Name = {
    Text = "偽誕・マーフィー"
  },
  AwakerConfig_15589_SummonSlogan = {
    Text = "彼女は神の誕生にその身を捧げ、骨と血をもって永遠の虚妄を贖った。"
  },
  AwakerConfig_15589_Title = {
    Text = "偽誕・マーフィー"
  },
  AwakerConfig_15589_Weight = {Text = "42kg"},
  AwakerConfig_15590_AwakerIntroduction = {
    Text = "・成長可能なダメージ手段と、強力なコンボ爆発能力を持つ。\n・狂気解放はいつでも完璧なカードを創造できる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したダフォダイルが出撃し、毎ターン追加で10狂気を獲得する。"
  },
  AwakerConfig_15590_Characteristic = {
    Text = "万能創造    敵を軟化にする"
  },
  AwakerConfig_15590_Gender = {Text = "女性"},
  AwakerConfig_15590_Height = {Text = "172cm"},
  AwakerConfig_15590_Introduction = {
    Text = "強力な千面幻象をカスタマイズし、超次元空間に配置できる魔女。"
  },
  AwakerConfig_15590_Name = {
    Text = "ダフォダイル"
  },
  AwakerConfig_15590_SummonSlogan = {
    Text = "彼女の小さな店には何でもあるが、彼女が求める報酬には注意。"
  },
  AwakerConfig_15590_Title = {
    Text = "ダフォダイル"
  },
  AwakerConfig_15590_VoiceActor = {
    Text = "小清水亜美"
  },
  AwakerConfig_15590_Weight = {Text = "60kg"},
  AwakerConfig_15591_Characteristic = {
    Text = "石化制御   敵を軟化にする"
  },
  AwakerConfig_15591_Gender = {Text = "女性"},
  AwakerConfig_15591_Height = {Text = "137cm"},
  AwakerConfig_15591_Introduction = {
    Text = "凝結の眼で敵を石化させて行動不能にし、脆くする。"
  },
  AwakerConfig_15591_Name = {
    Text = "アイギス"
  },
  AwakerConfig_15591_SummonSlogan = {
    Text = "剥がれた石片は、彼女が守り愛するものの証。"
  },
  AwakerConfig_15591_Title = {
    Text = "アイギス"
  },
  AwakerConfig_15591_Weight = {Text = "32kg"},
  AwakerConfig_15592_AwakerIntroduction = {
    Text = "・強力な防護と、永続的な触腕生成能力を持ち、触腕が多いほど防護能力が強くなる。\n・狂気解放は範囲ダメージを与えることができ、シールドによってダメージが増加する。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したサンガーが出撃し、敵は最初のターンに強化を獲得する。"
  },
  AwakerConfig_15592_Characteristic = {
    Text = "継続防護  触腕成長"
  },
  AwakerConfig_15592_Gender = {Text = "女性"},
  AwakerConfig_15592_Height = {Text = "165cm"},
  AwakerConfig_15592_Introduction = {
    Text = "石壁を彫り続けて防御を強化し、シールドが高いほど失われた芸術のダメージが増す。"
  },
  AwakerConfig_15592_Name = {
    Text = "サンガー"
  },
  AwakerConfig_15592_SummonSlogan = {
    Text = "穏やかで美しいだけでなく、鋭く攻撃的であることも芸術の一部だ。"
  },
  AwakerConfig_15592_Title = {
    Text = "サンガー"
  },
  AwakerConfig_15592_Weight = {Text = "80kg"},
  AwakerConfig_15593_AwakerIntroduction = {
    Text = "・「鼠たちの集結」は行動力を消費して<DerivativeCardKeywords_12:「鼠たちの突撃」>を生成する。消費する行動力が多いほど、ダメージ回数はより高くなる。行動力を蓄積することで、一度に超高ダメージを出すことができる。\n・「ブラウン出撃！」を使用するたび、「ブラウン出撃！」と<DerivativeCardKeywords_12:「鼠たちの突撃」>のダメージが上昇する。\n・狂気解放と霊知覚醒は、ジェンキンのクリティカル率とクリティカルダメージを上昇させ、その火力をさらに強化することができる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したジェンキンが出撃し、毎ターン<DerivativeCardKeywords_4:「啓示」>を1枚獲得、敵は最初のターンに強化される。"
  },
  AwakerConfig_15593_Characteristic = {
    Text = "複数ダメージ    クリティカル"
  },
  AwakerConfig_15593_Gender = {Text = "女性"},
  AwakerConfig_15593_Height = {Text = "133cm"},
  AwakerConfig_15593_Introduction = {
    Text = "高いクリティカル率とクリティカルダメージを持ち、ブラウンと鼠の群れは彼が多くの敵と戦うための重要な助けとなる。"
  },
  AwakerConfig_15593_Name = {
    Text = "ジェンキン"
  },
  AwakerConfig_15593_SummonSlogan = {
    Text = "鼠を侮ると痛い目に遭うよ！"
  },
  AwakerConfig_15593_Title = {
    Text = "ジェンキン"
  },
  AwakerConfig_15593_Weight = {Text = "30kg"},
  AwakerConfig_15594_AwakerIntroduction = {
    Text = "・強力なライフ回復と<RetaliateIconKeywords:反撃>を蓄積する能力を持ち、多段ダメージの敵に対して優れたパフォーマンスを発揮する。\n・狂気解放と「逆鱗の護り」は、より多くの<RetaliateIconKeywords:反撃>ダメージを与えることができる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したカエクスが出撃し、毎ターン10狂気を獲得し、敵は最初の1ターンの間、強化される。"
  },
  AwakerConfig_15594_Characteristic = {
    Text = "敵に反撃 触腕ダメージ"
  },
  AwakerConfig_15594_Gender = {Text = "男性"},
  AwakerConfig_15594_Height = {Text = "165cm"},
  AwakerConfig_15594_Introduction = {
    Text = "全身の鱗刺を広げ、来襲する敵を反撃し、血脈の力で自身のライフを回復する。"
  },
  AwakerConfig_15594_Name = {
    Text = "カエクス"
  },
  AwakerConfig_15594_SummonSlogan = {
    Text = "エラの跡、鱗……血筋の証が彼の唯一の信念だ。"
  },
  AwakerConfig_15594_Title = {
    Text = "カエクス"
  },
  AwakerConfig_15594_Weight = {Text = "52kg"},
  AwakerConfig_15595_Characteristic = {
    Text = "カード検索    複数ダメージ"
  },
  AwakerConfig_15595_Gender = {Text = "女性"},
  AwakerConfig_15595_Height = {Text = "165cm"},
  AwakerConfig_15595_Introduction = {
    Text = "あなたのチームに最も必要なカード支援を提供し、徐々に速くなる剣術で相手を貫く。"
  },
  AwakerConfig_15595_Name = {
    Text = "ラモンナ"
  },
  AwakerConfig_15595_SummonSlogan = {
    Text = "観察し、感じ、考える。"
  },
  AwakerConfig_15595_Title = {
    Text = "ラモンナ"
  },
  AwakerConfig_15595_VoiceActor = {
    Text = "山本亜衣"
  },
  AwakerConfig_15595_Weight = {Text = "46kg"},
  AwakerConfig_15596_AwakerIntroduction = {
    Text = "・独自のカードコピー能力を持ち、コピー後のカードの行動力消費が減少する。\n・霊知覚醒で<DerivativeCardKeywords_10:聖洁之子>を獲得し、これは血肉の狂気解放で捕食された時、捕食効果を2回発動する。キーオーダー発動時に<DerivativeCardKeywords_2:「胚胎」>を<DerivativeCardKeywords_10:聖洁之子>に変換できる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したタイスとラモンナが出撃し、キーオーダーは「小さな願い」になる。"
  },
  AwakerConfig_15596_Characteristic = {
    Text = "カードコピー    狂気供給"
  },
  AwakerConfig_15596_Gender = {Text = "女性"},
  AwakerConfig_15596_Height = {Text = "175cm"},
  AwakerConfig_15596_Introduction = {
    Text = "聖樹の子を育み、捕食効果を何度も発動する。豊穣の儀で味方のスキルを模倣する。"
  },
  AwakerConfig_15596_Name = {Text = "タイス"},
  AwakerConfig_15596_SummonSlogan = {
    Text = "「私のしもべになりなさい、私の戦士に、そして……私の子どもに」"
  },
  AwakerConfig_15596_Title = {Text = "タイス"},
  AwakerConfig_15596_VoiceActor = {
    Text = "山本亜衣"
  },
  AwakerConfig_15596_Weight = {Text = "68kg"},
  AwakerConfig_15597_AwakerIntroduction = {
    Text = "・狂気解放はライフを多く回復でき、ライフが低いほど回復量が多くなる。\n・霊知覚醒後、自身の指令カードを使用すると<EmbryoFusionIconKeywords:胚胎融合>を上昇させることができ、それによって、より多くの<DerivativeCardKeywords_2:「胚胎」>を獲得し、血肉チームにリソースのサポートを提供する。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したレーアを出撃させる。"
  },
  AwakerConfig_15597_Characteristic = {
    Text = "ライフ回復 力増加"
  },
  AwakerConfig_15597_Gender = {Text = "女性"},
  AwakerConfig_15597_Height = {Text = "161cm"},
  AwakerConfig_15597_Introduction = {
    Text = "自身の痛みを力に変え、低ライフ時に大量回復が可能。"
  },
  AwakerConfig_15597_Name = {Text = "レーア"},
  AwakerConfig_15597_SummonSlogan = {
    Text = "「飲み干して、この甘美な死を」"
  },
  AwakerConfig_15597_Title = {Text = "レーア"},
  AwakerConfig_15597_VoiceActor = {
    Text = "小坂ほのか"
  },
  AwakerConfig_15597_Weight = {Text = "41kg"},
  AwakerConfig_15598_AwakerIntroduction = {
    Text = "・狂気解放は高い全体ダメージを与え、同時に高い<PowerIconKeywords:力量>ボーナスを獲得する。\n・狂気解放が<DevouredIconKeywords:吞噬>を発動すると、この戦闘中以降に発動する狂気解放のダメージと<PowerIconKeywords:力量>ボーナスが増加する。\n・ライフが低いほどダメージが高くなる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したユウハシュが出撃し、毎ターン30の<EmbryoFusionIconKeywords:胚胎融合>を獲得する。敵は最初の2ターンの間、強化される。"
  },
  AwakerConfig_15598_Characteristic = {
    Text = "狂気解放    戦うほど強くなる"
  },
  AwakerConfig_15598_Gender = {Text = "男性"},
  AwakerConfig_15598_Height = {Text = "188cm"},
  AwakerConfig_15598_Introduction = {
    Text = "戦い続けてどんどん強くなる狂戦士で、低ライフ時にさらに強力になる。"
  },
  AwakerConfig_15598_Name = {
    Text = "ユウハシュ"
  },
  AwakerConfig_15598_SummonSlogan = {
    Text = "彼は敵を粉砕する機会を逃さなかった。"
  },
  AwakerConfig_15598_Title = {
    Text = "ユウハシュ"
  },
  AwakerConfig_15598_VoiceActor = {
    Text = "森田絵音"
  },
  AwakerConfig_15598_Weight = {Text = "86kg"},
  AwakerConfig_15599_AwakerIntroduction = {
    Text = "・独自の深紅の炉蓄積能力を持ち、指令カード、ライフ、さらには敵のダメージからも深紅の炉の回復量を蓄積できる。\n・深紅の炉の回復量を柔軟に大量のシールドやダメージに変換できる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したサルバドルが出撃し、初期クリティカル率50%、毎ターン20狂気を獲得するが、敵は最初の2ターン150点の一時的な力を獲得する。"
  },
  AwakerConfig_15599_Characteristic = {
    Text = "行動力支援    シールド転火力"
  },
  AwakerConfig_15599_Gender = {Text = "男性"},
  AwakerConfig_15599_Height = {Text = "187cm"},
  AwakerConfig_15599_Introduction = {
    Text = "尽きること無い仁愛で深紅の炉を蓄積し、負傷時に緊急支援を行う。"
  },
  AwakerConfig_15599_Name = {
    Text = "サルバドル"
  },
  AwakerConfig_15599_SummonSlogan = {
    Text = "「お導きください、神託の救世主よ。私たちを苦のない未来へ」"
  },
  AwakerConfig_15599_Title = {
    Text = "サルバドル"
  },
  AwakerConfig_15599_Weight = {Text = "75kg"},
  AwakerConfig_15600_AwakerIntroduction = {
    Text = "・強力な防護と<IntoxicationIconKeywords:中毒>を付与する能力を持ち、捕食を発動すると永続的な攻防成長を獲得できる。\n・「不耐の施し」は現在の<EmbryoFusionIconKeywords:胚胎融合>を倍増させる能力を持つ。\n・捕食発動時、「蒼白の旋回」は捨て札から手札に戻り、1ターンに複数回使用できる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したアグリッパが出撃し、毎ターン30の<EmbryoFusionIconKeywords:胚胎融合>、10狂気を獲得する。"
  },
  AwakerConfig_15600_Characteristic = {
    Text = "警戒成長    毒連撃"
  },
  AwakerConfig_15600_Gender = {Text = "女性"},
  AwakerConfig_15600_Height = {Text = "157cm"},
  AwakerConfig_15600_Introduction = {
    Text = "大量の胚胎融合を提供しつつ、敵に毒素を注入して精神を破壊する。"
  },
  AwakerConfig_15600_Name = {
    Text = "アグリッパ"
  },
  AwakerConfig_15600_SummonSlogan = {
    Text = "彼女の迷宮では、失うのは方向だけではない。"
  },
  AwakerConfig_15600_Title = {
    Text = "アグリッパ"
  },
  AwakerConfig_15600_Weight = {Text = "41kg"},
  AwakerConfig_15601_AwakerIntroduction = {
    Text = "・抑鬱人格と躁狂人格2つのモードを持ち、初期は抑鬱人格。狂気解放の発動でモードが切り替わり、カード効果が変わる。\n・狂気解放と霊知覚醒は、界域ごとに独自の効果を持つ。さらに、狂気解放は抑鬱と躁狂のモードごとに異なる効果を発動する。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発3の「24」とそれぞれの界域の仲間が出撃する。"
  },
  AwakerConfig_15601_Characteristic = {
    Text = "単発高ダメージ    狂気解放増幅"
  },
  AwakerConfig_15601_Gender = {Text = "女性"},
  AwakerConfig_15601_Height = {Text = "168cm"},
  AwakerConfig_15601_Introduction = {
    Text = "異なる界域のチームに適応してモードを変える。「抑鬱」と「躁狂」の人格を行き来する狩人。"
  },
  AwakerConfig_15601_SummonSlogan = {
    Text = "ヒステリー、神経衰弱、意識障害、心因性の精神疾患……ようするに、彼女は狂った女性だ。"
  },
  AwakerConfig_15601_VoiceActor = {
    Text = "伊藤さつき"
  },
  AwakerConfig_15602_AwakerIntroduction = {
    Text = "・普段は信頼できる支援能力を提供する研究者で、大量の狂気を提供しつつ味方を強化したり敵を弱体化させたりできる。\n・ボス戦では破壊のエンジンを徐々に駆動し、「終末」を蓄積して「虚無終結」を放ち大量のダメージを与え、戦闘終了まで攻撃的になる。\n・今回のステージでは、レベル50、スキルレベル5、霊知啓発3の溶壊・ドールとニムフィーアを連れて出撃し、ターン開始時に溶壊・ドールが追加で50狂気と1層の「終末」を獲得。"
  },
  AwakerConfig_15602_Characteristic = {
    Text = "ライフ回復 高ダメージ"
  },
  AwakerConfig_15602_Gender = {Text = "女性"},
  AwakerConfig_15602_Height = {Text = "158cm"},
  AwakerConfig_15602_Introduction = {
    Text = "普段はチームに回復と大量の狂気を提供できるが、ボス戦では破壊のエンジンを駆動して敵を終わらせる。"
  },
  AwakerConfig_15602_Name = {
    Text = "溶壊・ドール"
  },
  AwakerConfig_15602_SummonSlogan = {
    Text = "希望は人をより苦しめる毒に過ぎない。完全かつ迅速な破壊の中でのみ、すべての人々が真の解放を得る。"
  },
  AwakerConfig_15602_Title = {
    Text = "溶壊・ドール"
  },
  AwakerConfig_15602_VoiceActor = {
    Text = "魚谷佳代"
  },
  AwakerConfig_15602_Weight = {Text = "41kg"},
  AwakerConfig_15603_Characteristic = {
    Text = "攻防一体    形態変換"
  },
  AwakerConfig_15603_Gender = {Text = "女性"},
  AwakerConfig_15603_Height = {Text = "170cm"},
  AwakerConfig_15603_Introduction = {
    Text = "短時間で爆発的な力や警戒を提供でき、攻撃でも防御でも優れた腕を持つ。"
  },
  AwakerConfig_15603_Name = {Text = "エリカ"},
  AwakerConfig_15603_SummonSlogan = {
    Text = "彼女はミサゴの最大のデータベースで、万能の検索機だった。"
  },
  AwakerConfig_15603_Title = {Text = "エリカ"},
  AwakerConfig_15603_Weight = {Text = "83kg"},
  AwakerConfig_15604_AwakerIntroduction = {
    Text = "・狂気解放とスキルにはランダム性があり、運が良いほど収益が高くなる。\n・霊知覚醒で「混沌の遺贈」を獲得または選択してアップグレードできる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したライカーとロータンが出撃し、初期にライカーは25％のクリティカル率ボーナス、すべての「混沌の遺贈」造物と追加のカードセットを所持。敵は最初のターンで一時的な強化を獲得。"
  },
  AwakerConfig_15604_Characteristic = {
    Text = "手札を補充する 黒章を取得する"
  },
  AwakerConfig_15604_Gender = {Text = "男性"},
  AwakerConfig_15604_Introduction = {
    Text = "大量のカードを引きつつ、黒印のドロップで混沌の遺贈造物を獲得し、ライカーをさらに強くする。"
  },
  AwakerConfig_15604_Name = {
    Text = "ライカー"
  },
  AwakerConfig_15604_SummonSlogan = {
    Text = "「最後の賭けをしようか？君と私の未来を賭けて」"
  },
  AwakerConfig_15604_Title = {
    Text = "ライカー"
  },
  AwakerConfig_15604_VoiceActor = {
    Text = "高仲 佑星"
  },
  AwakerConfig_15604_Weight = {Text = "46kg"},
  AwakerConfig_54116_AwakerIntroduction = {
    Text = "・全知の賢者。無限の知恵を持ち、あらゆるスキルを巧みに操り、無数の可能性の中から最良の道を探る。\n・チームに大量のキーエネルギーを提供でき、キーエネルギーを翼に変えて敵に攻撃を加える。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発3の「タヴィ」と「ロータン」が出撃し、戦闘開始時に100狂気を獲得し、キーチャージが50増加する。"
  },
  AwakerConfig_54116_Gender = {Text = "女性"},
  AwakerConfig_54116_Gi = {
    Text = "測定不能"
  },
  AwakerConfig_54116_Height = {Text = "165cm"},
  AwakerConfig_54116_Introduction = {
    Text = "タヴィはすべてを知り尽くし、すべてのスキルを彼女のものとして使い、シルバーキーを資源として攻撃を行う。"
  },
  AwakerConfig_54116_Name = {Text = "タヴィ"},
  AwakerConfig_54116_SummonSlogan = {
    Text = "窮地の門を超えよ、さすれば世界の神秘があなたに開かれる。"
  },
  AwakerConfig_54116_Title = {Text = "タヴィ"},
  AwakerConfig_54116_VoiceActor = {
    Text = "山本亜衣"
  },
  AwakerConfig_54117_AwakerIntroduction = {
    Text = "・優雅かつ柔軟に音符を操り、カードの行動力消費を低減させるだけでなく、追加で複数回効果を発動させることもできる。\n・魂を震わせる音波攻撃は敵に連綿たる貫通ダメージを与え、その戦意を削ぎ、敵の防御を瓦解させる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発3のハムリンが出撃し、毎ターン追加で35狂気を獲得する。"
  },
  AwakerConfig_54117_Gender = {Text = "男性"},
  AwakerConfig_54117_Height = {Text = "178cm"},
  AwakerConfig_54117_Introduction = {
    Text = "回環する楽音でダメージを与えると同時にカードを複数回発動させ、連綿たる楽音は大量の「啓示」を生み出すことができる。"
  },
  AwakerConfig_54117_Name = {
    Text = "ハムリン"
  },
  AwakerConfig_54117_SummonSlogan = {
    Text = "すべての音符は、指揮棒の軌跡と共に舞う。"
  },
  AwakerConfig_54117_Title = {
    Text = "ハムリン"
  },
  AwakerConfig_54117_VoiceActor = {
    Text = "野宮一範"
  },
  AwakerConfig_54117_Weight = {Text = "55kg"},
  AwakerConfig_77911_Gender = {Text = "女性"},
  AwakerConfig_77911_Name = {
    Text = "ハゲワシ"
  },
  AwakerConfig_77911_Title = {
    Text = "ハゲワシ"
  },
  AwakerConfig_77913_AwakerIntroduction = {
    Text = "・すべてを焼き尽くす爆炎の主は、舞い上がる炎は阻もうとするすべての敵を包み込む。\n・残留する炎は爆炎として蓄積され、抑えきれないエネルギーの閃光が閾値に達したとき、轟然と爆発する！\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したキャティグラが出撃し、毎ターン追加で5点の行動力と30狂気、50点の力を獲得する。"
  },
  AwakerConfig_77913_Gender = {Text = "女性"},
  AwakerConfig_77913_Introduction = {
    Text = "熾烈な炎で万物を焼き尽くす烈陽、より多くの演算力を消費することでカードの効果を大幅に強化する。"
  },
  AwakerConfig_77913_Name = {
    Text = "ケティグラ"
  },
  AwakerConfig_77913_SummonSlogan = {
    Text = "彼女は決して沈まぬ太陽であり、等しく死をもたらす。"
  },
  AwakerConfig_77913_Title = {
    Text = "ケティグラ"
  },
  AwakerConfig_77913_VoiceActor = {
    Text = "鳥羽優好"
  },
  AwakerConfig_77914_Gender = {Text = "女性"},
  AwakerConfig_77914_Name = {
    Text = "ランティゴス"
  },
  AwakerConfig_77914_Title = {
    Text = "ランティゴス"
  },
  AwakerConfig_77917_AwakerIntroduction = {
    Text = "・敬虔で尊き提灯の御子は、清らかな聖心で常に光を追い求める。\n・聖なる光の力を用いてカード効果を周期的に強化し、御子の権能によってあらゆる漆黒の罪を裁く。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したポリュクスが出撃し、毎ターン50狂気と「啓示」を1枚獲得する。"
  },
  AwakerConfig_77917_Gender = {Text = "男性"},
  AwakerConfig_77917_Height = {Text = "173cm"},
  AwakerConfig_77917_Introduction = {
    Text = "聖輝の力を周期的に用いてカード効果を強化し、聖子の権能で全ての漆黒の罪悪を裁く。"
  },
  AwakerConfig_77917_Name = {
    Text = "ポリュクス"
  },
  AwakerConfig_77917_SummonSlogan = {
    Text = "聖心の光のもと、いかなる罪人も御子の審判から逃れることはできない。"
  },
  AwakerConfig_77917_Title = {
    Text = "ポリュクス"
  },
  AwakerConfig_77918_AwakerIntroduction = {
    Text = "·運命に縛られた織り手。織り続けることで彼女はより強くなるが、より大きな代償も背負うことになる。\n·織りなすことで「運命」という名の網を張り巡らせ、味方を守りプリズムの力を付与する。蓄積された「裁断」は重要な局面で一気に引き絞られ、穢れを切り除く。\n·本ステージでは、レベル50、スキルレベル5、啓霊3のアラクネとニンフィアが出撃する。\n·本バトル中、すべての覚醒体が付与する毒が200％上昇。ターン開始時、すべての覚醒体は狂気を30獲得し、「織命」を1層獲得し、演算力を3ポイント獲得してカードを3枚引く。"
  },
  AwakerConfig_77918_Gender = {Text = "女性"},
  AwakerConfig_77918_Height = {Text = "173cm"},
  AwakerConfig_77918_Introduction = {
    Text = "運命の織り手。彼女は糸で運命を紡ぎ、紡輪の下の安寧を守り、裁断の力で汚れを断ち切る。"
  },
  AwakerConfig_77918_Name = {
    Text = "アラクネ"
  },
  AwakerConfig_77918_SummonSlogan = {
    Text = "無数の糸がアラクネの紡ぎ車に集まる。彼女は人形に定められた運命を織り、自らに永遠の檻を編んでいる。"
  },
  AwakerConfig_77918_Title = {
    Text = "アラクネ"
  },
  AwakerConfig_77918_VoiceActor = {
    Text = "大西沙織"
  },
  AwakerConfig_77921_AwakerIntroduction = {
    Text = "·「妖精の名付け親」と自称する小柄な少女で、他者が深く秘めた願いを見透かすことができるため、多くの信徒から篤い供物を受けている。\n·「祝福」と引き換えに信徒の供物を受け取ることを常とし、供物が十分に積み重なると、それをすべて享受して自らの力の糧とする。恩恵を与えることと奪い取ることは、彼女にとって表裏一体である。\n·本ステージでは、レベル 50、スキルレベル5、霊知啓発3のカラブを編成して出撃し、戦闘開始時に 300 の力を獲得する。ターン開始時、「胎児」を 1 枚手札に加え、すべての覚醒体が 20 の狂気を獲得する。"
  },
  AwakerConfig_77921_Gender = {Text = "女性"},
  AwakerConfig_77921_Introduction = {
    Text = "妖精から贈られた贈り物には、とうの昔に闇の中で値札がつけられていた。蒼白な肉体が無数の欲深き怨霊を飲み込んでいく。"
  },
  AwakerConfig_77921_Name = {Text = "カラブ"},
  AwakerConfig_77921_SummonSlogan = {
    Text = "仙女のご加護、奉納歓迎！お客様、どのくらいのご予算でお考えですか？"
  },
  AwakerConfig_77921_Title = {Text = "カラブ"},
  AwakerConfig_77921_VoiceActor = {
    Text = "釘宮理恵"
  },
  AwakerConfig_77922_AwakerIntroduction = {
    Text = "・不屈の乙女、死を恐れぬ彼女は、死の脅威に直面したときに無限の潜在能力を発揮する。\n・船の操舵者、夜空に輝く冷光は、大量の触腕を生成すると同時に手札を再構築でき、「余波」効果と合わせて勝利への航路を指し示す。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したコーパサントが出撃し、毎ターン追加で2枚のカードを引き、触腕を1本獲得する。"
  },
  AwakerConfig_77922_Gender = {Text = "女性"},
  AwakerConfig_77922_Height = {Text = "175cm"},
  AwakerConfig_77922_Introduction = {
    Text = "夜空の冷たい光、大量の触腕を生成すると同時に手札を再構築し、「余波」効果と組み合わせてより大きなポテンシャルを発揮する。"
  },
  AwakerConfig_77922_Name = {
    Text = "コーパサント"
  },
  AwakerConfig_77922_SummonSlogan = {
    Text = "彼女の責任、彼女の義務、彼女の命は船に結びついており、他には何もない。"
  },
  AwakerConfig_77922_Title = {
    Text = "コーパサント"
  },
  AwakerConfig_77923_AwakerIntroduction = {
    Text = "・孤高なる不屈の鳥は、翼で狂風を巻き起こして味方を守る。\n・落ちる黒い羽は致命的な「侵蝕」を付与し、敵がそのターンにダメージを受けると、さらに大量のライフを失う。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したカストルとジェンキンが出撃し、戦闘開始時に100狂気を獲得、毎ターン3の狂気を獲得する。"
  },
  AwakerConfig_77923_Gender = {Text = "男性"},
  AwakerConfig_77923_Introduction = {
    Text = "翼で狂風を巻き起こし味方を護り、落ちた黒い羽翼は致命的な「侵蝕」を付与し、ダメージを受ける際に大量のライフを失わせる。"
  },
  AwakerConfig_77923_Name = {
    Text = "カストル"
  },
  AwakerConfig_77923_SummonSlogan = {
    Text = "彼は頑固な不屈の鳥で、自由を失うくらいなら死を選ぶ。"
  },
  AwakerConfig_77923_Title = {
    Text = "カストル"
  },
  AwakerConfig_77924_Gender = {Text = "女性"},
  AwakerConfig_77924_Name = {
    Text = "シャタク鳥"
  },
  AwakerConfig_77924_Title = {
    Text = "シャタク鳥"
  },
  AwakerConfig_77925_AwakerIntroduction = {
    Text = "・穏やかで優雅な心理医師は、患者とのコミュニケーションを通じて、徐々に相手の感情を感知し、「共感」を蓄積する。狂気解放を発動後、「共感」を消費して精神状態を操り、恐怖を与えて敵の戦意を崩すか、トラウマを植え付けて瞬時に心の防御を破壊できる。\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したクレメンタインが出撃し、キーチャージが50増加、毎ターン20狂気を獲得する。"
  },
  AwakerConfig_77925_Gender = {Text = "女性"},
  AwakerConfig_77925_Height = {Text = "167cm"},
  AwakerConfig_77925_Introduction = {
    Text = "共感を積み重ね、敵を催眠してそのダメージを減少させたり、敵を負傷させて敵の受けるダメージを増加させたりする。"
  },
  AwakerConfig_77925_Name = {
    Text = "クレメンタイン"
  },
  AwakerConfig_77925_SummonSlogan = {
    Text = "彼女は心理カウンセリングのリズムを掌握し、救済も破壊も、すべては彼女の一念のうちにある。"
  },
  AwakerConfig_77925_Title = {
    Text = "クレメンタイン"
  },
  AwakerConfig_77925_Weight = {Text = "46kg"},
  AwakerConfig_77926_AwakerIntroduction = {
    Text = "・創作に情熱を注ぐ残骸の画家は、その作品で味方チームに様々な精神的な強化をもたらす。\n・線を描くたびに創意を蓄積し、創意が上限に達すると泉のように迸り、この芸術の狂宴を狂喜の極みに押し上げる！\n本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したピックマンとロータン、オジール、ドールが出陣し、ピックマンは毎ターン追加で100狂気を、他の覚醒体は30狂気を獲得する。"
  },
  AwakerConfig_77926_Gender = {Text = "男性"},
  AwakerConfig_77926_Introduction = {
    Text = "局勢に応じて柔軟に異なる絵巻を創造し、他の覚醒体の狂気爆発効果を大幅に強化する。"
  },
  AwakerConfig_77926_Name = {
    Text = "ピックマン"
  },
  AwakerConfig_77926_SummonSlogan = {
    Text = "彼はその絵を通して、この世界の真実をあなたに見せてくれるだろう。"
  },
  AwakerConfig_77926_Title = {
    Text = "ピックマン"
  },
  AwakerConfig_77926_Weight = {Text = "65kg"},
  AwakerConfig_77927_Gender = {Text = "男性"},
  AwakerConfig_77927_Name = {
    Text = "ファラオ"
  },
  AwakerConfig_77927_Title = {
    Text = "ファラオ"
  },
  AwakerConfig_77928_Gender = {Text = "女性"},
  AwakerConfig_77928_Name = {
    Text = "アヤヴァゴモン"
  },
  AwakerConfig_77928_Title = {
    Text = "アヤヴァゴモン"
  },
  AwakerConfig_78754_Gender = {Text = "女性"},
  AwakerConfig_78754_Name = {
    Text = "真貌・眠れる主"
  },
  AwakerConfig_78754_Title = {
    Text = "真貌・眠れる主"
  },
  AwakerConfig_78840_Characteristic = {
    Text = "カード検索    複数ダメージ"
  },
  AwakerConfig_78840_Gender = {Text = "男性"},
  AwakerConfig_78840_Name = {
    Text = "お馴染みの黒猫"
  },
  AwakerConfig_78840_Title = {
    Text = "ミサゴ校猫"
  },
  AwakerConfig_78840_VoiceActor = {
    Text = "山本亜衣"
  },
  AwakerConfig_78841_Characteristic = {
    Text = "カード検索    複数ダメージ"
  },
  AwakerConfig_78841_Gender = {Text = "男性"},
  AwakerConfig_78841_Name = {
    Text = "お馴染みの黒猫"
  },
  AwakerConfig_78841_Title = {
    Text = "ミサゴ校猫"
  },
  AwakerConfig_78841_VoiceActor = {
    Text = "山本亜衣"
  },
  AwakerConfig_94450_AwakerIntroduction = {
    Text = "·戦斧を手にした活発な少女。戦闘では狂熱的な戦士と化し、逆境の中でより強い戦闘力を爆発させる。\n·仲間との共闘時にモシャの戦意は大いに刺激され、攻勢は打撃を重ねるほどに鋭さを増していく。\n·今回のステージでは、レベル50、スキルレベル5、啓霊3のモシャで出撃。ターン開始時に狂気を50獲得、カードを3枚引き、演算力を3ポイント獲得。"
  },
  AwakerConfig_94450_Gender = {Text = "女性"},
  AwakerConfig_94450_Gi = {Text = "不安定"},
  AwakerConfig_94450_Introduction = {
    Text = "巨斧を手にした活発な少女。戦闘では狂熱的な戦士と化し、逆境の中でより強い戦闘力を爆発させる。"
  },
  AwakerConfig_94450_Name = {
    Text = "ムシェット"
  },
  AwakerConfig_94450_Painter = {
    Text = "ばらばら"
  },
  AwakerConfig_94450_SummonSlogan = {
    Text = "霧境からの来訪者、銀と血の中で、この世にて洗礼を受け生まれ変わる。"
  },
  AwakerConfig_94450_Title = {
    Text = "ムシェット"
  },
  AwakerConfig_94450_VoiceActor = {
    Text = "長谷川育美"
  },
  AwakerConfig_94450_Weight = {Text = "45kg"},
  AwakerConfig_94451_AwakerIntroduction = {
    Text = "·かつては無念のうちに死んだ騎士であり、今もその体内には制御できない黒い澱みが渦巻いている。新たに見出した、守るべきものののために戦う。\n·「暗涌」が積み重なるにつれてダメージはより大きくなるが、自身が受ける負担も増していく；肝心な場面では「暗涌」をすべてガーディアンの力へと変える。\n·本ステージでは、レベル 50、スキルレベル5、霊知啓発3の負誓·オジールを編成して出撃し、ターン開始時にカードを 3 枚引き、行動力を 3 獲得し、すべての覚醒体が 20 の狂気を獲得する。"
  },
  AwakerConfig_94451_Gender = {Text = "男性"},
  AwakerConfig_94451_Introduction = {
    Text = "かつてすべてを失った騎士は、あらゆる罪を背負ったとき、再び守護の誓いを立てた。"
  },
  AwakerConfig_94451_Name = {
    Text = "負誓·オジール"
  },
  AwakerConfig_94451_Painter = {
    Text = "ばらばら"
  },
  AwakerConfig_94451_Title = {
    Text = "本源・オージル"
  },
  AwakerConfig_95786_AwakerIntroduction = {
    Text = "・優雅な美食家は、苦しむ魂に運命づけられた死の解放をもたらす。\n・亡者の残骸を存分に味わえ。食材の養分は、あなたの壮大なライフと無限のエネルギーへと変わる！\n・本ステージでは、レベル50、スキルレベル5、霊知啓発を3まで起動したドゥルセインが出撃し、この戦闘中ドゥルセインが与えるダメージは必ずクリティカルになる。"
  },
  AwakerConfig_95786_Height = {Text = "187cm"},
  AwakerConfig_95786_Introduction = {
    Text = "優雅な美食家は、残りのライフが少ない敵に大きなダメージを与える。亡者の残骸を食らうことで、自身を強化し、ライフを回復できる。"
  },
  AwakerConfig_95786_Name = {
    Text = "ドゥルセイン"
  },
  AwakerConfig_95786_Painter = {
    Text = "ばらばら"
  },
  AwakerConfig_95786_SummonSlogan = {
    Text = "彼はあなたの呼び声に応えた。あなたは招かれた……魂の饗宴へ。"
  },
  AwakerConfig_95786_Title = {
    Text = "ドゥルセイン"
  },
  AwakerConfig_95786_Weight = {Text = "62kg"}
})
return Text_AwakerConfig
