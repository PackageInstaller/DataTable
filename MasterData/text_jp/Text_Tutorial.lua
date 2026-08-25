__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Tutorial = readonly({
  Tutorial_120371_Desc_1 = {
    Text = "戦闘中に既に経過したターンまで遡ることができ、過去25ターン以内の任意のターンに戻ることができます。"
  },
  Tutorial_120371_Title_1 = {
    Text = "時序逆行"
  },
  Tutorial_124999_Desc_1 = {
    Text = "<TutorialHighlight:対人戦・ドラフトモード>では、画面右下の「対人戦準備」をタップするとマッチングに入ります。事前にチームを編成する必要はありません。"
  },
  Tutorial_124999_Desc_2 = {
    Text = "対戦前にシステムがランダムに1つの<TutorialHighlight:遺物>を選び、対戦中にその効果が発動します。\n各対戦では、その遺物の効果に基づいて、ランダムに出現する限られた選択肢のカードプールから必要な覚醒体、運命の札、キーオーダーを順番に選び、自分の編成を構築して相手と対戦します。"
  },
  Tutorial_124999_Desc_3 = {
    Text = "2つの覚醒体をタップして位置を交換し、対戦中の自分のチームの配置を調整します。配置は前後に1～4の順で並びます。"
  },
  Tutorial_124999_Title_1 = {
    Text = "ドラフト編成"
  },
  Tutorial_126878_Desc_1 = {
    Text = "一部の覚醒体の人格の深化が＋12に達すると、自動的に「最終法則」効果を獲得します。各覚醒体が得る効果は異なります。"
  },
  Tutorial_126878_Desc_2 = {
    Text = "覚醒体の「最終法則」を解放すると、対応する覚醒体専用の通信器メッセージを受け取ります。守秘者は必ず確認してください。"
  },
  Tutorial_126878_Title_1 = {
    Text = "最終法則"
  },
  Tutorial_126878_Title_2 = {
    Text = "専属情報"
  },
  Tutorial_148475_Desc_1 = {
    Text = "覚醒体の同調率が <TutorialHighlight:Lv20> に達すると、専用の <TutorialHighlight:輝き> を獲得できます。"
  },
  Tutorial_148475_Desc_2 = {
    Text = "<TutorialHighlight:輝き>はあなたと覚醒体が渾然一体である証です。"
  },
  Tutorial_148475_Desc_3 = {
    Text = "これより、この覚醒体の指令カードは戦闘中に特別な演出で表示され、社交の場で他のシークレットキーパーに披露することができます。"
  },
  Tutorial_148475_Title_1 = {
    Text = "渾然一体"
  },
  Tutorial_17805_Desc_1 = {
    Text = "敵を選択してすべての状態を確認できます。\n<TutorialHighlight:警告>状態の敵は特殊な行動を取るので注意が必要です。"
  },
  Tutorial_17805_Title_1 = {
    Text = "敵の状態"
  },
  Tutorial_17806_Desc_1 = {
    Text = "敵を倒した後に<TutorialHighlight:刻印>を選択できます。\nまた、<TutorialHighlight:交換所>で<TutorialHighlight:黒章>を使って購入可能です。\n<TutorialHighlight:刻印>により指令カードに追加効果を付与でき、各カードは最大<TutorialHighlight:1>回のみ刻印可能です。"
  },
  Tutorial_17807_Desc_1 = {
    Text = "覚醒体に様々な能力を付与し、<TutorialHighlight:セット>効果により特殊効果を得られます。\n全6箇所があり、それぞれの<TutorialHighlight:メイン能力>が異なります。\nメイン能力と出現箇所\nクリティカル率とクリティカルダメージ：Ⅰ、Ⅱ、Ⅲ\n狂気増加とキーチャージ　　　　　　　：Ⅰ、IV、V\n界域知識と黒章のドロップ　　　　　　：Ⅱ、IV、VI\nダメージ強化と死亡抵抗　　　　　　　：Ⅲ、V、VI\n密契完成度で密契と密契セットの強さを直感的に確認できます。密契完成度はレベルアップと転写で強化できます。"
  },
  Tutorial_17807_Title_1 = {Text = "密約"},
  Tutorial_17808_Desc_1 = {
    Text = "<TutorialHighlight:幻夢の深奥>では、各ステージに挑戦するたびにランダムなマップに入ります。\n挑戦に成功すると、ステージの難易度、強化覚醒体、およびステージ内の評価項目に応じて対応するポイントを獲得します。\n毎週の挑戦では、異なる初期遺物と強化覚醒体が設定されます。"
  },
  Tutorial_17808_Desc_2 = {
    Text = "幻夢の深奥は通常28日ごとにシーズンが更新されます。シーズン中に幻夢の深奥を1回クリアすると<TutorialHighlight:シーズンランキング>に参加でき、シーズン終了時にランキングが集計され、メールでランキング報酬が配布されます。"
  },
  Tutorial_17808_Desc_3 = {
    Text = "「潜行記録」には複数の目標が設定されており、達成すると対応する報酬を獲得できます。\n「潜行記録」の目標を達成する、または挑戦に勝利するたびに、<TutorialHighlight:深奥経験値>を獲得できます。\n深奥経験値が一定値に達すると、<TutorialHighlight:深奥レベル>が上昇し、報酬を受け取ることができます。\n画面左下の「潜行記録」および「深奥レベル」から確認できます。"
  },
  Tutorial_17808_Title_1 = {
    Text = "幻夢の深奥"
  },
  Tutorial_17809_Desc_1 = {
    Text = "事件や交換所を通じて<TutorialHighlight:遺物>を獲得できます。\n<TutorialHighlight:遺物>はチームの戦闘能力を強化できます。\nチームの編成に基づいて、より適した<TutorialHighlight:遺物>を選びましょう。"
  },
  Tutorial_17809_Title_1 = {Text = "遺物"},
  Tutorial_17810_Desc_1 = {
    Text = "霧を晴らし、マップの視界が<TutorialHighlight:2>マス見渡せるようになります。"
  },
  Tutorial_17810_Title_1 = {
    Text = "サーチライト"
  },
  Tutorial_17811_Desc_1 = {
    Text = "<TutorialHighlight:毒>を受けた場合、ターン終了時に<TutorialHighlight:毒>の数に等しいダメージを受けます。\n<TutorialHighlight:毒>ダメージは<TutorialHighlight:クリティカルが発生しません>。"
  },
  Tutorial_17811_Title_1 = {Text = "毒"},
  Tutorial_17812_Desc_1 = {
    Text = "<TutorialHighlight:軟化>状態の対象は、受けるダメージが50%増加します。ターン終了時に1層の<TutorialHighlight:軟化>が自動で除去されます。敵が<TutorialHighlight:軟化>状態の時を利用して、より多くのダメージを与えましょう。"
  },
  Tutorial_17812_Title_1 = {Text = "軟化"},
  Tutorial_17813_Desc_1 = {
    Text = "「融蝕の廃墟」「禁忌編纂」「超越存在」では、ステージをクリアすると、そのステージおよびそれ以下の難易度のステージで<TutorialHighlight:リプレイ>ができるようになります。\n<TutorialHighlight:リプレイ>を利用することで、調査報酬を即座に獲得できます。"
  },
  Tutorial_17813_Title_1 = {
    Text = "リプレイ"
  },
  Tutorial_17814_Desc_1 = {
    Text = "<TutorialHighlight:シールド>の数だけダメージを減らします。\n敵のターン終了時にシールドは<TutorialHighlight:自動解除>されます。\nシールドの上限はチームの<TutorialHighlight:ライフ上限>です。"
  },
  Tutorial_17814_Title_1 = {
    Text = "シールド"
  },
  Tutorial_17815_Desc_1 = {
    Text = "重複して獲得した覚醒体は<TutorialHighlight:欠片>に変換されます。\n<TutorialHighlight:欠片>を消費して覚醒体の霊知啓発レベルを上げることで、覚醒体のスキルが特定の特殊能力を獲得できます。\n霊知啓発レベルが最大になると、追加の欠片は<TutorialHighlight:ソウルリセットの破片>に変換されます。"
  },
  Tutorial_17815_Title_1 = {Text = "欠片"},
  Tutorial_17816_Desc_1 = {
    Text = "<TutorialHighlight:行動力>は<TutorialHighlight:チーム全体で共有>され、指令カードを使用するたびに消費します。\nまた、行動力はターン開始時に<TutorialHighlight:自動的に上限まで回復>し、ターン終了後に<TutorialHighlight:自動的にリセット>されます。\n行動力を<TutorialHighlight:効率的に消費して>ターンを終えるようにしましょう。"
  },
  Tutorial_17816_Title_1 = {Text = "行動力"},
  Tutorial_17817_Desc_1 = {
    Text = "<TutorialHighlight:超越存在>の敵を倒すと、上級の<TutorialHighlight:スキル強化素材>を獲得できます。\n1週間に1回まで、クリア時に獲得できます。\nさまざまな素材は<TutorialHighlight:精錬室>で合成や変換が可能です。"
  },
  Tutorial_17817_Title_1 = {
    Text = "超越存在"
  },
  Tutorial_17818_Desc_1 = {
    Text = "獲得後に<TutorialHighlight:所持品で使用>でき、設定値に従って覚醒体のレベルとスキルレベルを即座に上げることができます。"
  },
  Tutorial_17818_Title_1 = {
    Text = "霊知増幅器"
  },
  Tutorial_17819_Desc_1 = {
    Text = "覚醒体の狂気が<TutorialHighlight:100>に達すると、各覚醒体の固有技である<TutorialHighlight:狂気解放>を発動できます。"
  },
  Tutorial_17819_Title_1 = {
    Text = "狂気解放"
  },
  Tutorial_17820_Desc_1 = {
    Text = "<TutorialHighlight:抑圧>状態の対象は、獲得するシールドが25%減少します。ターン終了時に1層の<TutorialHighlight:抑圧>が自動で除去されます。味方チームが<TutorialHighlight:抑圧>状態の場合、防御前に<TutorialHighlight:抑圧>状態を除去する方法を考えるか、戦略を変更して本ターンは全力で攻撃しましょう。"
  },
  Tutorial_17820_Title_1 = {Text = "抑圧"},
  Tutorial_17821_Desc_1 = {
    Text = "覚醒体に<TutorialHighlight:運命の札>を装備すると、覚醒体の能力が向上し、特殊能力を獲得できます。"
  },
  Tutorial_17821_Title_1 = {
    Text = "運命の札"
  },
  Tutorial_17822_Desc_1 = {
    Text = "<TutorialHighlight:出血>を受けた場合、ターン終了時に<TutorialHighlight:出血>の数に等しいダメージを受け、その後<TutorialHighlight:出血状態を解除>します。\n<TutorialHighlight:ライフ回復>時に<TutorialHighlight:ライフ回復量の2倍>の出血を解除します。\n出血ダメージは<TutorialHighlight:クリティカルが発生しません>。"
  },
  Tutorial_17823_Desc_1 = {
    Text = "混沌の覚醒体は<TutorialHighlight:界域の制限を突破>して他の界域の覚醒体と編成でき、異なる共生効果を持ちます。任意のチームに混沌の覚醒体がいる場合、追加で100%の死亡抵抗を獲得できます。"
  },
  Tutorial_17823_Desc_2 = {
    Text = "他の界域のチームと比べて、混沌界域チームはキーエネルギーの獲得速度が速く、2回目のキーオーダーを発動する際には、すべてのキーオーダーの中から選択することができ、選択したキーオーダーは2回発動します。\nしたがって、混沌界域のチームはキーオーダー同士の連携への依存度が高く、適切なキーオーダーを選択することで、混沌界域チームの戦力を大幅に強化することができます！"
  },
  Tutorial_17824_Desc_1 = {
    Text = "<TutorialHighlight:警戒>を1点持つごとに、シールド獲得時に、追加でシールドを1点獲得できます。"
  },
  Tutorial_17824_Title_1 = {Text = "警戒"},
  Tutorial_17825_Desc_1 = {
    Text = "初めて調査を完了すると、<TutorialHighlight:共鳴>を発動するための<TutorialHighlight:共鳴起動素材>を獲得できます。共鳴は各章の全ステージで効果が適用されます。"
  },
  Tutorial_17825_Title_1 = {Text = "共鳴"},
  Tutorial_17826_Desc_1 = {
    Text = "味方チームが<TutorialHighlight:狂気封印>状態の時、狂気解放を発動できません。敵が<TutorialHighlight:狂気封印>を付与する前に、狂気解放を発動して狂気の無駄を避けましょう。"
  },
  Tutorial_17826_Title_1 = {
    Text = "狂気封印"
  },
  Tutorial_17827_Desc_1 = {
    Text = "<TutorialHighlight:霊知の薬剤>で覚醒体のレベルを上げると、覚醒体の能力が向上します。\nレベル上限に達した場合、昇格を行うことで、覚醒体のレベル上限を引き上げることができます。"
  },
  Tutorial_17827_Title_1 = {
    Text = "霊知の薬剤"
  },
  Tutorial_17828_Desc_1 = {
    Text = "<TutorialHighlight:力>が1点減少するごとに、アクティブダメージが1減少します。"
  },
  Tutorial_17828_Title_1 = {
    Text = "力の減少"
  },
  Tutorial_17829_Desc_1 = {
    Text = "ダメージを受ける前に、ダメージを無効化し<TutorialHighlight:バリア>を1層除去します。単発ダメージが高いほど、<TutorialHighlight:バリア>の恩恵は大きくなります。"
  },
  Tutorial_17829_Title_1 = {Text = "バリア"},
  Tutorial_17830_Desc_1 = {
    Text = "<TutorialHighlight:倦怠>状態の対象は、与えるダメージが25%減少します。ターン終了時に1層の<TutorialHighlight:倦怠>が自動で除去されます。味方チームが<TutorialHighlight:倦怠>状態の場合、攻撃前に<TutorialHighlight:倦怠>状態を除去する方法を考えるか、戦略を変更して本ターンは全力で防御しましょう。"
  },
  Tutorial_17830_Title_1 = {Text = "倦怠"},
  Tutorial_17831_Desc_1 = {
    Text = "<TutorialHighlight:禁忌纂録>の敵を倒すと、覚醒体の能力を向上させる<TutorialHighlight:密契>を獲得できます。\n各章のメインストーリーをクリアすると新しい<TutorialHighlight:禁忌纂録>ステージが解放されます。\n密契はショップでの交換も可能です。"
  },
  Tutorial_17831_Title_1 = {
    Text = "禁忌編纂"
  },
  Tutorial_17832_Desc_1 = {
    Text = "超次元チームが毎ターン使用する<TutorialHighlight:1枚目の>指令カードの一時的なコピーが<TutorialHighlight:超次元空間>に入り、強力な跳躍効果を発動します。超次元空間が上限に達すると、追加の<TutorialHighlight:超次元ターン>を1つ獲得し、<TutorialHighlight:超次元ターンではすべての跳躍効果が発動します>。超次元チームを上手く使うための基本的な秘訣は、毎ターン最初に使う1枚目のカードを慎重に計画することです。"
  },
  Tutorial_17832_Title_1 = {Text = "超次元"},
  Tutorial_17833_Desc_1 = {
    Text = "チームのライフが尽きた時、<TutorialHighlight:復活の魂魄>を使って全ライフ、狂気、キーエネルギーを回復できます。\n復活の魂魄は毎日<TutorialHighlight:1>個自動回復します。※上限は<TutorialHighlight:5>個です。"
  },
  Tutorial_17833_Title_1 = {
    Text = "復活の魂魄"
  },
  Tutorial_17834_Desc_1 = {
    Text = "地図上で微かに光る場所を調べると意外な発見があるかもしれません。"
  },
  Tutorial_17834_Title_1 = {
    Text = "黒い水たまり"
  },
  Tutorial_17835_Desc_1 = {
    Text = "すべての敵による、このターンのダメージ総量を現します。\n<TutorialHighlight:シールドの数だけダメージを減らす>ことができます。"
  },
  Tutorial_17835_Title_1 = {
    Text = "敵ダメージ総量"
  },
  Tutorial_17837_Desc_1 = {
    Text = "血肉チームの<TutorialHighlight:胚胎融合>が上限に達すると<TutorialHighlight:「胚胎」>を1枚獲得します。狂気解放を発動すると<TutorialHighlight:「胚胎」>を消費して強力な<TutorialHighlight:捕食>効果を発動します。そのため、可能な限り手札に<TutorialHighlight:「胚胎」>がある時に狂気解放を発動させることが、血肉チームの最大の力を発揮する鍵となります。"
  },
  Tutorial_17837_Desc_2 = {
    Text = "毎戦闘終了後に最大ライフの5%の回復量が深紅の炉に蓄積されます。未使用の<TutorialHighlight:「胚胎」>がある場合、胚胎1つにつき最大ライフの5%の回復量も炉に蓄積されます。深紅の炉は味方チームのライフ回復に使用でき、毎ターン1回炉をライフに変換できます。深紅の炉の使用タイミングを適切に計画することで、戦局を覆す効果を得ることができます。"
  },
  Tutorial_17838_Desc_1 = {
    Text = "休憩所で、味方が失ったライフの50%を回復するか、覚醒体を1名指定して覚醒することができます。\n味方チームのライフが少ない場合はライフの回復を優先し、そうでなければ覚醒体の強化を行いましょう。"
  },
  Tutorial_17838_Title_1 = {Text = "休憩所"},
  Tutorial_17839_Desc_1 = {
    Text = "融痕の交換所は、黒章を捧げることで刻印や遺物などを交換し、チームを強化する場所です。\n欲しいアイテムがない場合、右上の<TutorialHighlight:更新>を選択すると新しいラインナップに変更されます。"
  },
  Tutorial_17839_Title_1 = {
    Text = "融痕の交換所"
  },
  Tutorial_17840_Desc_1 = {
    Text = "<TutorialHighlight:幻影>を強行突破すると「症状」に感染します。"
  },
  Tutorial_17840_Title_1 = {Text = "幻影"},
  Tutorial_17841_Desc_1 = {
    Text = "指令カードを使うことで覚醒体は<TutorialHighlight:狂気>を獲得できます。指令カードのスキルレベルが高いほど、より多くの狂気を獲得できます。"
  },
  Tutorial_17841_Title_1 = {Text = "狂気"},
  Tutorial_17842_Desc_1 = {
    Text = "敵を倒したり、事件を調査すると<TutorialHighlight:黒章>を入手でき、覚醒体の<TutorialHighlight:黒章ドロップ率>の能力により黒章の獲得数が増加します。"
  },
  Tutorial_17842_Desc_2 = {
    Text = "融痕の交換所にて、<TutorialHighlight:黒章>を捧げて消費することで、刻印や遺物を購入したり、覚醒体を覚醒することで霊知覚醒カードを獲得できます。\n最終戦の前には、可能な限りすべての黒章を使い切って味方チームを強化しましょう。"
  },
  Tutorial_17842_Title_1 = {Text = "黒章"},
  Tutorial_17843_Desc_1 = {
    Text = "攻撃を受けると、攻撃者に<TutorialHighlight:反撃>の数と同等のダメージを与えます。\n<TutorialHighlight:反撃>ダメージは<TutorialHighlight:クリティカルが発生しません。>"
  },
  Tutorial_17843_Title_1 = {Text = "反撃"},
  Tutorial_17844_Desc_1 = {
    Text = "<TutorialHighlight:力>を1点持つごとに、敵へ与えるアクティブダメージが1増加します。"
  },
  Tutorial_17844_Title_1 = {Text = "力"},
  Tutorial_17845_Desc_1 = {
    Text = "派遣した覚醒体が任務を完了し、完了後に相応の報酬を獲得できます。\n派遣した覚醒体の<TutorialHighlight:総レベル>が高いほど報酬が増加し、最大で総レベル240まで計算されます。"
  },
  Tutorial_17847_Desc_1 = {
    Text = "致命的なダメージを受けた時、<TutorialHighlight:死亡抵抗の値と同等の確率>でこのダメージを無効化しライフ1を保持します。<TutorialHighlight:発動に成功すると死亡抵抗が半減します>。チームの死亡抵抗は全覚醒体の死亡抵抗の合計であり、チームの死亡抵抗を高めることで戦闘時のミス許容率が向上します。"
  },
  Tutorial_17848_Desc_1 = {
    Text = "深海チームは戦闘開始時に<TutorialHighlight:触腕>を1本生成します。<TutorialHighlight:触腕>はターン終了時に前衛の敵を攻撃します。触腕アイコン下部の計算式を確認することで、現在の触腕ダメージと攻撃回数を知ることができます。一部の覚醒体は触腕の数と触腕ダメージを増加させ、ターン終了時に大量のダメージを与えることができます。"
  },
  Tutorial_17850_Desc_1 = {
    Text = "手札にあるカードを使用するには行動力が必要です。\nターンの終わりには、手札のカードは基本的には<TutorialHighlight:捨て札>に置かれます。"
  },
  Tutorial_17850_Title_1 = {Text = "手札"},
  Tutorial_17851_Desc_1 = {
    Text = "次のターンに敵がとる行動を現します。\n<TutorialHighlight:敵の行動予測>を利用し、このターンの決定を行うことが、戦闘のコアになります。敵をタップし、<TutorialHighlight:敵の行動予測>の詳細が確認できます。"
  },
  Tutorial_17851_Title_1 = {
    Text = "敵の行動予測"
  },
  Tutorial_17852_Desc_1 = {
    Text = "<TutorialHighlight:スキル強化>は覚醒体の能力を向上させ、指令カードの効果を強化します。\n覚醒体のスキル画面で次のレベルをタップすると、アップグレード後の効果を確認できます。"
  },
  Tutorial_17852_Desc_2 = {
    Text = "覚醒体は、それぞれの界域毎に専用の<TutorialHighlight:スキル強化素材>が必要です。"
  },
  Tutorial_17852_Title_1 = {
    Text = "スキル強化"
  },
  Tutorial_20768_Desc_1 = {
    Text = "覚醒体が指令カードを発射するか霊知啓発で行動力を消費する時に<TutorialHighlight:キーエネルギー>を獲得できます。覚醒体の<TutorialHighlight:キーチャージ>能力は、獲得する<TutorialHighlight:キーエネルギー>を増加させることができます。"
  },
  Tutorial_20768_Title_1 = {
    Text = "キーエネルギー"
  },
  Tutorial_20769_Desc_1 = {
    Text = "<TutorialHighlight:扉>は重要な調査ルートを遮ります。\nマップ上で<TutorialHighlight:扉の鍵>を探し、<TutorialHighlight:扉>を開いてください。"
  },
  Tutorial_20769_Title_1 = {Text = "扉"},
  Tutorial_20770_Desc_1 = {
    Text = "<TutorialHighlight:扉>は進行を妨げます。<TutorialHighlight:扉の鍵>で開くことができます。"
  },
  Tutorial_20770_Title_1 = {Text = "扉の鍵"},
  Tutorial_20771_Desc_1 = {
    Text = "<TutorialHighlight:闇の境界>には4つの界域のステージが存在し、クリアするとシルバーコアや霊知の薬剤などの報酬が獲得できます。\nまた、累計の星評価数が一定に達すると、シルバーコアやヘブンズコアなどの報酬を獲得できます。"
  },
  Tutorial_20771_Desc_2 = {
    Text = "それぞれの界域の「隙間」では、覚醒体の編成に対する条件が要求され、<TutorialHighlight:条件を満たす>場合に調査が行えます。"
  },
  Tutorial_20771_Title_1 = {
    Text = "闇の境界"
  },
  Tutorial_20772_Desc_1 = {
    Text = "キーエネルギーが<TutorialHighlight:1000>に達すると携帯している<TutorialHighlight:キーオーダー>を使用できます。毎ターン2回キーオーダーを使用できますが、2回目の使用時はランダムな3つのキーオーダーから1つを選んで使用する形になり、選択したキーオーダーは今回の探索中に再度選択できなくなります。編成時に味方チームに適切なキーオーダーを選択することで、調査をよりスムーズに進めることができます。"
  },
  Tutorial_20772_Title_1 = {
    Text = "キーオーダー"
  },
  Tutorial_20773_Desc_1 = {
    Text = "同じ<TutorialHighlight:運命の札>を消費して重ねるか、<TutorialHighlight:循環基盤>を使用して<TutorialHighlight:SSR運命の札>を重ねると、<TutorialHighlight:運命の札>の能力と特殊効果が向上します。1～3回重ねると効果が強化されます。4～15回重ねると能力が強化されます。重ね画面で「次の段階」ボタンを選択して重ね後の変化を確認することができます。\n召喚等で既に所持している運命の札を入手した場合、システムが自動的に既存の運命の札と重ねます。守秘者が個別に操作する必要はありません。"
  },
  Tutorial_20773_Title_1 = {
    Text = "運命の札強化"
  },
  Tutorial_22247_Desc_1 = {
    Text = "<TutorialHighlight:密約強化>は密約の能力を向上します。最大12レベルです。\n密約を分解すると対応する密約の断片が獲得でき、所持品で材料変換を行うと<TutorialHighlight:千面印章>が獲得できます。密約強化には<TutorialHighlight:千面印章>が必要で、強化済みの密約を分解すると消費した<TutorialHighlight:千面印章>が返還されます。"
  },
  Tutorial_22247_Title_1 = {
    Text = "密約強化"
  },
  Tutorial_22248_Desc_1 = {
    Text = "転写を通じて、<TutorialHighlight:密約>にランダムな種類と強さの属性を獲得できます。サブ属性は部位とは無関係で、クリティカル率、クリティカルダメージ、狂気増加、キーチャージ、界域知識、黒章ドロップ、ダメージ強化、死亡抵抗の8種類が出現する可能性があります。転写の際、特定の属性を保持したい場合は、<TutorialHighlight:ロック>を選択できます。ロックされた属性は転写時に変化しません。"
  },
  Tutorial_22248_Title_1 = {
    Text = "密約転写"
  },
  Tutorial_23466_Desc_1 = {
    Text = "調査レベルが上がるにつれ、<TutorialHighlight:遺物と刻印の効果が強力>になり、<TutorialHighlight:覚醒体の体力がチームのライフに与える影響も増加>します。\n調査や強化演習で、大量の<TutorialHighlight:守秘者経験値>が獲得できます。\nスタミナを1点消費するごとに、1点の<TutorialHighlight:守秘者経験値>を獲得できます。"
  },
  Tutorial_23466_Title_1 = {
    Text = "調査レベル"
  },
  Tutorial_47538_Desc_1 = {
    Text = "融災禁区は高難度システムです。\n複数の挑戦チームを柔軟に組み合わせ、できるだけ多くの特訓値を獲得することで、より多くの報酬を獲得できます。\n高警戒難易度では敵が強くなるだけでなく、様々なデバフ効果も付与されます。"
  },
  Tutorial_47538_Desc_2 = {
    Text = "融災禁区の独自のチーム制限：\n同じチームでの攻略はできないため、ステージ毎に異なる覚醒体、キーオーダー、運命の札のチームを編成する必要があります。\n<TutorialHighlight:救援>で登場する覚醒体はこの制限の影響を受けません。"
  },
  Tutorial_47538_Title_1 = {
    Text = "融災禁区"
  },
  Tutorial_54390_Desc_1 = {
    Text = "<TutorialHighlight:対人戦>モードでは、戦闘画面内の敵と覚醒体の両方の<TutorialHighlight:状態>が、敵のライフと狂気の下に表示されます。\n選択すると、具体的な効果が表示されます。"
  },
  Tutorial_54390_Desc_2 = {
    Text = "<TutorialHighlight:バフ>に属するものは以下：\n<TauntKeywords:挑発>、<PVPPowerIconKeywords:力>、<EnergyStorageKeywords:蓄力>、<PVPProtectiveKeywords:バリア>、<PVPRetaliateIconKeywords:反撃>、<ReinforceKeywords:堅固>、<StrengthenKeywords:強化>。\n（※タップで詳細が確認でき、ウィンドウはスクロールできます）"
  },
  Tutorial_54390_Desc_3 = {
    Text = "<TutorialHighlight:デバフ>に属するものは以下：\n<PVPEntanglementKeywords:纏着>、<PVPVulnerabilityIconKeywords:軟化>、<PVPSlowKeywords:鈍化>、<ComaKeywords:石化>、<DisarmKeywords:麻痺>、<PVPMethysisKeywords:毒>、<PVPEmptinessKeywords:虚無>、<PVPBleedingKeywords:出血>、<PVPSeriousInjuryKeywords:重傷>、<ComaKeywords:昏睡>。\n（※タップで詳細が確認でき、ウィンドウはスクロールできます）"
  },
  Tutorial_54390_Title_1 = {Text = "状態"},
  Tutorial_54391_Desc_1 = {
    Text = "<TutorialHighlight:対人戦>モードでは、覚醒体のカードにはさまざまな<TutorialHighlight:追加効果>があり、<TutorialHighlight:コレクション>システムや戦闘中に長押しで確認できます。\n追加効果は以下：\n<PVPPenetrateKeywords:貫通>、<PrepareKeywords:準備>、<PVPResurrectionKeywords:復活>、<PVPHoldingKeywords:保有>、<PhantomKeywords:幻影>、<PVPRaidKeywords:奇襲>。\n（※タップで詳細が確認でき、ウィンドウはスクロールできます）"
  },
  Tutorial_54391_Title_1 = {
    Text = "追加効果"
  },
  Tutorial_54392_Desc_1 = {
    Text = "一部の特殊なゲームシステムには<TutorialHighlight:シーズン>があり、シーズン期間中に特殊システムのランキングに参加することで、シーズン終了時にランキングに基づいて報酬が精算されます。\n調査行動の進行に伴い、今後さらに多くのシステムが<TutorialHighlight:シーズン>に参加する予定です。"
  },
  Tutorial_54392_Desc_2 = {
    Text = "各シーズン期間中には<TutorialHighlight:シーズンミッション>が用意されています。シーズンミッションを達成すると豊富な報酬を獲得できます。シーズンミッションはシーズン更新時にリセットされます。"
  },
  Tutorial_54392_Title_1 = {
    Text = "シーズン"
  },
  Tutorial_54393_Desc_1 = {
    Text = "<TutorialHighlight:対人戦>モードでは、覚醒体が倒れるとその覚醒体のカードは<TutorialHighlight:幻影>カードになります。倒れた覚醒体に<TutorialHighlight:命輪>を装備すると1枚の幻影カードが追加され、行動力消費が返還されます。\n幻影は特定の命輪の効果で<TutorialHighlight:小さな願い>に変換も可能です。"
  },
  Tutorial_54393_Title_1 = {Text = "幻影"},
  Tutorial_54394_Desc_1 = {
    Text = "<TutorialHighlight:対人戦>モードでは、1ターン目は双方が3点の<TutorialHighlight:行動力>上限を持ち、後手は補充カードを獲得します。以降、各ターン開始時に行動力は1ずつ増え、<TutorialHighlight:最大10>まで増加します。また、他の手段で行動力上限を増減させることもでき、<TutorialHighlight:超えた分は1点ごとに1枚のカードに変換>されます。"
  },
  Tutorial_54394_Title_1 = {Text = "行動力"},
  Tutorial_54395_Desc_1 = {
    Text = "<TutorialHighlight:対人戦>モードでは、各覚醒体に<TutorialHighlight:狂気>と<TutorialHighlight:狂気解放>があります。<TutorialHighlight:攻撃>カードや<TutorialHighlight:スキル>カードの使用時、またダメージを受けたり、ライフが減る毎に狂気を獲得します。（2%のライフか同量のシールドを失う毎に1点獲得します）狂気が100の時、覚醒体を選択して狂気解放を発動できます。"
  },
  Tutorial_54395_Title_1 = {Text = "狂気"},
  Tutorial_54396_Desc_1 = {
    Text = "<TutorialHighlight:対人戦>モードでは、戦闘で「対人戦記録」の指定目標を達成することで、対応する報酬を獲得できます。\nこの報酬は一度限りで、シーズンリセットの影響を受けません。\n画面の左側「対人戦記録」で確認できます。"
  },
  Tutorial_54396_Title_1 = {
    Text = "対人戦記録"
  },
  Tutorial_54397_Desc_1 = {
    Text = "<TutorialHighlight:対人戦>モードでは、画面の左側にある「コレクション」タブですべての覚醒体、運命の札、キーオーダーの情報を閲覧できます。"
  },
  Tutorial_54397_Title_1 = {
    Text = "コレクション"
  },
  Tutorial_54398_Desc_1 = {
    Text = "<TutorialHighlight:対人戦>モードでは、覚醒体ごとに2枚の<TutorialHighlight:攻撃>カードと、3枚の<TutorialHighlight:スキル>カードがあります。\n通常、スキルカードはそれぞれ異なる行動力消費になります。"
  },
  Tutorial_54398_Title_1 = {Text = "スキル"},
  Tutorial_54399_Desc_1 = {
    Text = "<TutorialHighlight:対人戦>モードでは、各ターンに5枚のカードを自動で引き、<TutorialHighlight:手札上限>は10枚になります。\n戦闘画面の右下で現在の枚数と上限を、右上で相手の状況を確認できます。また、他の方法で各ターンの引く枚数や手札の上限を変更できます。"
  },
  Tutorial_54399_Title_1 = {Text = "手札"},
  Tutorial_54400_Desc_1 = {
    Text = "<TutorialHighlight:対人戦>モードでは、覚醒体には以下の5つの<TutorialHighlight:役割>があります。\n<TutorialHighlight:守護>、<TutorialHighlight:闘争>、<TutorialHighlight:知恵>、<TutorialHighlight:凶星>、<TutorialHighlight:祝福>。\n<TutorialHighlight:役割>の異なる覚醒体を4体選択して、チームを<TutorialHighlight:編成>する必要があります。"
  },
  Tutorial_54400_Title_1 = {Text = "役割"},
  Tutorial_54401_Desc_1 = {
    Text = "<TutorialHighlight:対人戦・プリセットモード>では、画面右下の「対人戦準備」をタップすると編成画面に移動します。\nまた、画面左側の<TutorialHighlight:プリセット編成>から、あらかじめチームを構築することもできます。"
  },
  Tutorial_54401_Desc_2 = {
    Text = "複数のチームセットの保存ができ、それぞれチーム名を編集できます。\n各チームは覚醒体4体、運命の札4枚、キーオーダー2つで構成されます。"
  },
  Tutorial_54401_Title_1 = {
    Text = "プリセット編成"
  },
  Tutorial_54705_Desc_1 = {
    Text = "<TutorialHighlight:対人戦>モードで自分の<TutorialHighlight:アイコン>を選択し、送りたい<TutorialHighlight:スタンプ>を選んで、相手に気持ちを伝えましょう！"
  },
  Tutorial_54705_Title_1 = {
    Text = "スタンプ"
  },
  Tutorial_54706_Desc_1 = {
    Text = "<TutorialHighlight:対人戦>は二人対人戦ゲームで、各自のチームで<TutorialHighlight:マッチメイキング>を行います。\nマッチングの際、同程度の相手が選ばれます。"
  },
  Tutorial_54706_Desc_2 = {
    Text = "対戦を通じて、<TutorialHighlight:プリセット経験値>および<TutorialHighlight:ドラフト経験値>を獲得できます。\n獲得した経験値に応じて、<TutorialHighlight:プリセットレベル>および<TutorialHighlight:ドラフトレベル>が一定に達すると<TutorialHighlight:1度限りの報酬>が解放されます。"
  },
  Tutorial_54706_Desc_3 = {
    Text = "毎シーズン、ポイントランキングに応じて<TutorialHighlight:称号>を獲得し、シーズン終了時にランキングが集計され、メールでランキング報酬が配布されます。"
  },
  Tutorial_54706_Title_1 = {
    Text = "対戦概要"
  },
  Tutorial_74798_Desc_1 = {
    Text = "<TutorialHighlight:ステージレベル>による環境変化で、全体的なルールと遺物効果が大幅に変更されます。\n詳細は各ステージ画面で関連するタブをタップして確認できます。"
  },
  Tutorial_74798_Title_1 = {
    Text = "ステージレベル"
  },
  Tutorial_81370_Desc_1 = {
    Text = "<TutorialHighlight:覚醒体のリセット>を行うと、覚醒体の様々な育成素材が返却されます。"
  },
  Tutorial_81370_Desc_2 = {
    Text = "<TutorialHighlight:育成リセット>は、覚醒体のレベル、昇格、スキル、霊知深化のステータスをリセットします。\n消費した素材と金券はすべて返却されます。"
  },
  Tutorial_81370_Desc_3 = {
    Text = "<TutorialHighlight:啓霊リセット>は、覚醒体の啓霊状態をリセットし、啓霊によるレベル上限もリセットされます。消費した素材はすべて返却されます。"
  },
  Tutorial_81370_Desc_4 = {
    Text = "<TutorialHighlight:昏き海への帰還>は、「育成リセット」の効果を含み、覚醒体自身も未解放の状態に戻ります。"
  },
  Tutorial_81370_Title_1 = {
    Text = "覚醒体のリセット"
  },
  Tutorial_81371_Desc_1 = {
    Text = "<TutorialHighlight:覚醒体のレベルアップ>は、覚醒体の能力を向上させる方法の一つです。\n<TutorialHighlight:霊知の薬剤>で覚醒体のレベルを上げることができます。"
  },
  Tutorial_81371_Desc_2 = {
    Text = "覚醒体がレベル上限に達した場合、<TutorialHighlight:昇格>を通じてレベル上限を上げる必要があります。\n覚醒体は、それぞれの界域毎に専用の<TutorialHighlight:昇格素材>が必要です。"
  },
  Tutorial_81371_Title_1 = {
    Text = "覚醒体のレベルアップ"
  },
  Tutorial_81372_Desc_1 = {
    Text = "<TutorialHighlight:霊知啓発>は、覚醒体の指令カードを大幅に強化できます。\nレベル7で、<TutorialHighlight:極限解放>により、覚醒体の狂気解放時に発生する追加効果を獲得できます。\nレベル11とレベル15で、覚醒体レベル上限が5レベル引き上げられます。"
  },
  Tutorial_81372_Title_1 = {
    Text = "霊知啓発"
  }
})
return Text_Tutorial
