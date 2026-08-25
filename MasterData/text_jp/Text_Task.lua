__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Task = readonly({
  Task_100331_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_100331_Name = {Text = "1勝"},
  Task_100332_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_100332_Name = {Text = "10勝"},
  Task_100333_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_100333_Name = {Text = "6勝"},
  Task_100334_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_100334_Name = {Text = "3勝"},
  Task_100523_Desc = {
    Text = "意識潜行「畸世絵」をクリア"
  },
  Task_100523_Name = {
    Text = "現世の狂想"
  },
  Task_100576_Desc = {
    Text = "戦闘を1ターン経験するごとに、調査評価が20ポイント減少します。"
  },
  Task_100576_Name = {
    Text = "時系列の砂時計<size=20><color=#747474>1ターン戦闘ごとに調査スコアが20点減少 </color></size>"
  },
  Task_10143_Desc = {
    Text = "72ターン以内にクリア"
  },
  Task_10143_Name = {
    Text = "72ターン以内にクリア"
  },
  Task_10144_Desc = {
    Text = "79ターン以内にクリア"
  },
  Task_10144_Name = {
    Text = "79ターン以内にクリア"
  },
  Task_10145_Desc = {
    Text = "40歩以内でクリア"
  },
  Task_10145_Name = {Text = "戦略"},
  Task_10146_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_10146_Name = {Text = "爽快"},
  Task_10147_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_10147_Name = {Text = "爽快"},
  Task_10148_Desc = {
    Text = "31ターン以内にクリア"
  },
  Task_10148_Name = {
    Text = "31ターン以内にクリア"
  },
  Task_10149_Desc = {
    Text = "40ターン以内にクリア"
  },
  Task_10149_Name = {
    Text = "40ターン以内にクリア"
  },
  Task_10150_Desc = {
    Text = "47ターン以内にクリア"
  },
  Task_10150_Name = {
    Text = "47ターン以内にクリア"
  },
  Task_10151_Desc = {
    Text = "58ターン以内にクリア"
  },
  Task_10151_Name = {
    Text = "58ターン以内にクリア"
  },
  Task_10152_Desc = {
    Text = "65ターン以内にクリア"
  },
  Task_10152_Name = {
    Text = "65ターン以内にクリア"
  },
  Task_10153_Desc = {
    Text = "融蝕の怪物を倒す"
  },
  Task_10153_Name = {Text = "目標"},
  Task_10154_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10154_Name = {
    Text = "完璧な通過"
  },
  Task_10155_Desc = {
    Text = "18歩以内でクリア"
  },
  Task_10155_Name = {Text = "戦略"},
  Task_10156_Desc = {
    Text = "クリア時の症状が3枚以下"
  },
  Task_10156_Name = {Text = "爽快"},
  Task_10157_Desc = {
    Text = "クリア時に最低黒章を100個所持"
  },
  Task_10157_Name = {
    Text = "次の機会に使いたい"
  },
  Task_10158_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10158_Name = {
    Text = "混沌こそ成長"
  },
  Task_10159_Desc = {
    Text = "最終戦で8ターン以内に勝利"
  },
  Task_10159_Name = {Text = "速攻"},
  Task_10160_Desc = {
    Text = "クリア時に遺物が2個以上"
  },
  Task_10160_Name = {
    Text = "遺物の力"
  },
  Task_10161_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10161_Name = {
    Text = "混沌こそ成長"
  },
  Task_10162_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_10162_Name = {
    Text = "最終降臨"
  },
  Task_10163_Desc = {
    Text = "クリア時に遺物が4個以上"
  },
  Task_10163_Name = {
    Text = "遺物の力"
  },
  Task_10164_Desc = {
    Text = "ステージをクリア"
  },
  Task_10164_Name = {
    Text = "ステージをクリア"
  },
  Task_10165_Desc = {
    Text = "8体の覚醒体との同調率がレベル5に到達"
  },
  Task_10165_Name = {Text = "相棒Ⅳ"},
  Task_10166_Desc = {
    Text = "12名の覚醒体との同調率がレベル3に到達"
  },
  Task_10166_Name = {Text = "相棒Ⅴ"},
  Task_10167_Desc = {
    Text = "45歩以内でクリア"
  },
  Task_10167_Name = {Text = "戦略"},
  Task_10168_Desc = {
    Text = "17ターン以内にクリア"
  },
  Task_10168_Name = {
    Text = "17ターン以内にクリア"
  },
  Task_10169_Desc = {
    Text = "覚醒体を20体所持する"
  },
  Task_10169_Name = {
    Text = "共に戦うⅡ"
  },
  Task_10170_Desc = {
    Text = "覚醒体を30体所持する"
  },
  Task_10170_Name = {
    Text = "共に戦うⅢ"
  },
  Task_10171_Desc = {
    Text = "300回召喚儀式を行う"
  },
  Task_10171_Name = {
    Text = "天才守秘者Ⅳ"
  },
  Task_10172_Desc = {
    Text = "覚醒体を10体所持する"
  },
  Task_10172_Name = {
    Text = "共に戦う"
  },
  Task_10173_Desc = {
    Text = "覚醒体4名と同調率5達成する"
  },
  Task_10173_Name = {Text = "相棒Ⅱ"},
  Task_10174_Desc = {
    Text = "財布を取り戻す"
  },
  Task_10174_Name = {Text = "目標"},
  Task_10175_Desc = {
    Text = "覚醒体を40体所持する"
  },
  Task_10175_Name = {
    Text = "共に戦うⅣ"
  },
  Task_10176_Desc = {
    Text = "4名の覚醒体との同調率がレベル3に到達"
  },
  Task_10176_Name = {Text = "相棒"},
  Task_10177_Desc = {
    Text = "ポナペの廃墟を400回クリア"
  },
  Task_10177_Name = {
    Text = "ポナペの祝福Ⅳ"
  },
  Task_10178_Desc = {
    Text = "ポナペの廃墟を600回クリア"
  },
  Task_10178_Name = {
    Text = "ポナペの祝福Ⅴ"
  },
  Task_10179_Desc = {
    Text = "蠕虫の棲家を50回クリア"
  },
  Task_10179_Name = {
    Text = "蠕虫飼育者"
  },
  Task_10180_Desc = {
    Text = "蠕虫の棲家を100回クリア"
  },
  Task_10180_Name = {
    Text = "蠕虫飼育者Ⅱ"
  },
  Task_10181_Desc = {
    Text = "蠕虫の棲家を200回クリア"
  },
  Task_10181_Name = {
    Text = "蠕虫飼育者Ⅲ"
  },
  Task_10182_Desc = {
    Text = "蠕虫の棲家を400回クリア"
  },
  Task_10182_Name = {
    Text = "蠕虫飼育者Ⅳ"
  },
  Task_10183_Desc = {
    Text = "蠕虫の棲家を600回クリア"
  },
  Task_10183_Name = {
    Text = "蠕虫飼育者Ⅴ"
  },
  Task_10184_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_10184_Name = {
    Text = "秘められた誕生について"
  },
  Task_10185_Desc = {
    Text = "超越存在を10回クリア"
  },
  Task_10185_Name = {
    Text = "秘められた誕生についてⅡ"
  },
  Task_10186_Desc = {
    Text = "超越存在を25回クリア"
  },
  Task_10186_Name = {
    Text = "秘められた誕生についてⅢ"
  },
  Task_10187_Desc = {
    Text = "調査事件第3章「悪犬に注意」を完了する"
  },
  Task_10187_Name = {Text = "星の芽"},
  Task_10188_Desc = {
    Text = "最大6回の戦闘でクリア"
  },
  Task_10188_Name = {
    Text = "精密突破"
  },
  Task_10189_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10190_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_10190_Name = {Text = "爽快"},
  Task_10191_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10191_Name = {
    Text = "完璧な通過"
  },
  Task_10192_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10192_Name = {
    Text = "完璧な通過"
  },
  Task_10193_Desc = {
    Text = "ジェンキンを見つける"
  },
  Task_10193_Name = {Text = "目標"},
  Task_10194_Desc = {
    Text = "薬剤収集Ⅰをクリア"
  },
  Task_10194_Name = {Text = "任務3"},
  Task_10195_Desc = {
    Text = "派遣任務を2回完了する"
  },
  Task_10195_Name = {Text = "任務2"},
  Task_10196_Desc = {
    Text = "累計で召喚を40回行う"
  },
  Task_10196_Name = {Text = "任務1"},
  Task_10197_Desc = {
    Text = "第1章で5回共鳴する"
  },
  Task_10197_Name = {Text = "任務5"},
  Task_10198_Desc = {
    Text = "覚醒体を4体レベル10にする"
  },
  Task_10198_Name = {Text = "任務4"},
  Task_10199_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10199_Name = {
    Text = "混沌こそ成長"
  },
  Task_10200_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_10200_Name = {Text = "爽快"},
  Task_10201_Desc = {
    Text = "動力室から脱出"
  },
  Task_10201_Name = {Text = "目標"},
  Task_10202_Desc = {
    Text = "クリア時に最低8枚の刻印カードを所持"
  },
  Task_10202_Name = {
    Text = "刻印の力"
  },
  Task_10203_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10203_Name = {
    Text = "混沌こそ成長"
  },
  Task_10204_Desc = {
    Text = "調査地点へ"
  },
  Task_10204_Name = {Text = "目標"},
  Task_10205_Desc = {
    Text = "最終戦で8ターン以内に勝利"
  },
  Task_10205_Name = {Text = "速攻"},
  Task_10206_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10206_Name = {
    Text = "混沌こそ成長"
  },
  Task_10207_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10208_Desc = {
    Text = "35歩以内でクリア"
  },
  Task_10208_Name = {Text = "戦略"},
  Task_10209_Desc = {
    Text = "クリア時に遺物が4個以上"
  },
  Task_10209_Name = {
    Text = "遺物の力"
  },
  Task_10210_Desc = {
    Text = "エンフェリンを180消費する"
  },
  Task_10210_Name = {
    Text = "スタミナを消耗"
  },
  Task_10211_Desc = {
    Text = "邪魔する子供たちを排除"
  },
  Task_10211_Name = {Text = "目標"},
  Task_10212_Desc = {
    Text = "ステージ内の全任務を完了後に報酬を受け取り可能"
  },
  Task_10212_Name = {
    Text = "第一段階"
  },
  Task_10213_Desc = {
    Text = "次元を超えてダフォダイルを追う"
  },
  Task_10213_Name = {Text = "目標"},
  Task_10215_Desc = {
    Text = "最終戦で6ターン以内に勝利"
  },
  Task_10215_Name = {
    Text = "最終戦で6ターン以内に勝利"
  },
  Task_10216_Desc = {
    Text = "ステージをクリア"
  },
  Task_10216_Name = {
    Text = "ステージをクリア"
  },
  Task_10217_Desc = {
    Text = "心労値が500未満の状態で、最終戦15ターン以内に勝利"
  },
  Task_10217_Name = {
    Text = "心労値が500以下の状態で、最終戦15ターン以内に勝利"
  },
  Task_10218_Desc = {
    Text = "レベル20の血肉覚醒体を4体所持する"
  },
  Task_10218_Name = {
    Text = "血肉の主Ⅱ"
  },
  Task_10219_Desc = {
    Text = "マーフィーに従う"
  },
  Task_10219_Name = {Text = "目標"},
  Task_10220_Desc = {
    Text = "ステージをクリア"
  },
  Task_10220_Name = {
    Text = "ステージをクリア"
  },
  Task_10221_Desc = {
    Text = "ステージをクリア"
  },
  Task_10221_Name = {
    Text = "ステージをクリア"
  },
  Task_10222_Desc = {
    Text = "累積50枚のカードを使用する"
  },
  Task_10223_Desc = {
    Text = "首狩りの手がかりを探す"
  },
  Task_10223_Name = {Text = "目標"},
  Task_10224_Desc = {
    Text = "ステージをクリア"
  },
  Task_10224_Name = {
    Text = "ステージをクリア"
  },
  Task_10226_Desc = {
    Text = "ステージをクリア"
  },
  Task_10226_Name = {
    Text = "ステージをクリア"
  },
  Task_10228_Desc = {
    Text = "船長を探す"
  },
  Task_10228_Name = {Text = "目標"},
  Task_10229_Desc = {
    Text = "ステージをクリア"
  },
  Task_10229_Name = {
    Text = "ステージをクリア"
  },
  Task_10230_Desc = {
    Text = "「地獄の番犬」を追う"
  },
  Task_10230_Name = {Text = "目標"},
  Task_10231_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10231_Name = {Text = "速攻"},
  Task_10232_Desc = {
    Text = "ステージをクリア"
  },
  Task_10232_Name = {
    Text = "ステージをクリア"
  },
  Task_10233_Desc = {
    Text = "ステージをクリア"
  },
  Task_10233_Name = {
    Text = "ステージをクリア"
  },
  Task_10234_Desc = {
    Text = "ステージをクリア"
  },
  Task_10234_Name = {
    Text = "ステージをクリア"
  },
  Task_10235_Desc = {
    Text = "海底の残像調査を60回クリア"
  },
  Task_10235_Name = {
    Text = "深海の虚Ⅲ"
  },
  Task_10236_Desc = {
    Text = "海底の残像調査を30回クリア"
  },
  Task_10236_Name = {
    Text = "深海の虚Ⅱ"
  },
  Task_10237_Desc = {
    Text = "混濁の残像調査を120回クリア"
  },
  Task_10237_Name = {
    Text = "混沌の虚Ⅳ"
  },
  Task_10238_Desc = {
    Text = "混濁の残像調査を60回クリア"
  },
  Task_10238_Name = {
    Text = "混沌の虚Ⅲ"
  },
  Task_10239_Desc = {
    Text = "海底の残像調査を15回クリア"
  },
  Task_10239_Name = {
    Text = "深海の虚"
  },
  Task_10240_Desc = {
    Text = "混濁の残像調査を240回クリア"
  },
  Task_10240_Name = {
    Text = "混沌の虚Ⅴ"
  },
  Task_10241_Desc = {
    Text = "薬剤収集を600回クリア"
  },
  Task_10241_Name = {
    Text = "天才薬師Ⅴ"
  },
  Task_10242_Desc = {
    Text = "薬剤収集を400回クリア"
  },
  Task_10242_Name = {
    Text = "天才薬師Ⅳ"
  },
  Task_10243_Desc = {
    Text = "混濁の残像調査を30回クリア"
  },
  Task_10243_Name = {
    Text = "混沌の虚Ⅱ"
  },
  Task_10244_Desc = {
    Text = "混濁の残像調査を15回クリア"
  },
  Task_10244_Name = {
    Text = "混沌の虚"
  },
  Task_10245_Desc = {
    Text = "ジェンキンを守る"
  },
  Task_10245_Name = {Text = "目標"},
  Task_10246_Desc = {
    Text = "狂人の変異を阻止"
  },
  Task_10246_Name = {Text = "目標"},
  Task_10247_Desc = {
    Text = "ステージ内の全任務を完了後に報酬を受け取り可能"
  },
  Task_10247_Name = {
    Text = "第三段階"
  },
  Task_10248_Desc = {
    Text = "隠し扉を開ける道具を見つける"
  },
  Task_10248_Name = {Text = "目標"},
  Task_10249_Desc = {
    Text = "危険から逃れる"
  },
  Task_10249_Name = {Text = "目標"},
  Task_10250_Desc = {
    Text = "ステージ終了時に最低2つの事件タイプノードを通過"
  },
  Task_10250_Name = {
    Text = "ノードトリガータイプ"
  },
  Task_10251_Desc = {
    Text = "クリア時にキャンプ回復が未使用"
  },
  Task_10251_Name = {
    Text = "特殊チャレンジタイプ"
  },
  Task_10252_Desc = {
    Text = "最終戦終了時に50%以上のライフが残っている"
  },
  Task_10252_Name = {
    Text = "最終戦でのライフ要件"
  },
  Task_10253_Desc = {
    Text = "症状2枚以上でクリア"
  },
  Task_10253_Name = {
    Text = "デッキプランニング"
  },
  Task_10254_Desc = {
    Text = "症状2枚以内でクリア"
  },
  Task_10254_Name = {
    Text = "デッキプランニング"
  },
  Task_10255_Desc = {
    Text = "30歩以上でクリア"
  },
  Task_10255_Name = {
    Text = "ルートプランニング"
  },
  Task_10256_Desc = {
    Text = "25歩以内でクリア"
  },
  Task_10256_Name = {
    Text = "ルートプランニング"
  },
  Task_10258_Desc = {
    Text = "ステージをクリア"
  },
  Task_10258_Name = {
    Text = "ステージをクリア"
  },
  Task_10259_Desc = {
    Text = "状態が指令で除去された回数（例：倦怠効果が2回消散された）"
  },
  Task_10259_Name = {
    Text = "戦闘効果類"
  },
  Task_10260_Desc = {
    Text = "状態が指令で追加された回数（例：倦怠効果が1回追加された）"
  },
  Task_10260_Name = {
    Text = "戦闘効果類"
  },
  Task_10265_Desc = {
    Text = "首狩りを撃退"
  },
  Task_10265_Name = {Text = "目標"},
  Task_10266_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10267_Desc = {
    Text = "最大3回の戦闘でクリア"
  },
  Task_10267_Name = {
    Text = "精密突破"
  },
  Task_10268_Desc = {
    Text = "クリア時に最低黒章を50個所持"
  },
  Task_10268_Name = {
    Text = "次の機会に使いたい"
  },
  Task_10269_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_10269_Name = {Text = "爽快"},
  Task_10270_Desc = {
    Text = "クリア時に最低8枚の刻印カードを所持"
  },
  Task_10270_Name = {
    Text = "刻印の力"
  },
  Task_10271_Desc = {
    Text = "28歩以内でクリア"
  },
  Task_10271_Name = {Text = "戦略"},
  Task_10272_Desc = {
    Text = "全戦闘で狂気解放回数が4回以下でクリア"
  },
  Task_10272_Name = {
    Text = "冷静で優雅"
  },
  Task_10273_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_10273_Name = {
    Text = "最終降臨"
  },
  Task_10274_Desc = {
    Text = "クリア時に遺物が4個以上"
  },
  Task_10274_Name = {
    Text = "遺物の力"
  },
  Task_10275_Desc = {
    Text = "73ターン以内にクリア"
  },
  Task_10275_Name = {
    Text = "73ターン以内にクリア"
  },
  Task_10276_Desc = {Text = "船室へ"},
  Task_10276_Name = {Text = "目標"},
  Task_10277_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_10277_Desc = {
    Text = "図書館で座っていても覚醒体は得られない。\n出発しよう、足を踏み出し、自然の中でその万分の一の可能性を探そう。"
  },
  Task_10277_Name = {
    Text = "調査任務：霊銀の痕跡"
  },
  Task_10278_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_10278_Name = {Text = "爽快"},
  Task_10279_Desc = {
    Text = "45歩以内でクリア"
  },
  Task_10279_Name = {Text = "戦略"},
  Task_10280_Desc = {
    Text = "30歩以内でクリア"
  },
  Task_10280_Name = {Text = "戦略"},
  Task_10281_Desc = {
    Text = "任意の超次元界域の覚醒体の昇格レベルを2にする"
  },
  Task_10281_Name = {
    Text = "超次元の知識Ⅱ"
  },
  Task_10282_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10283_Desc = {
    Text = "ステージ内の全任務を完了後に報酬を受け取り可能"
  },
  Task_10283_Name = {
    Text = "第五段階"
  },
  Task_10284_Desc = {
    Text = "最終戦で17ターン以内に勝利"
  },
  Task_10284_Name = {
    Text = "最終戦で17ターン以内に勝利"
  },
  Task_10285_Desc = {
    Text = "薔薇金券を10000000消費"
  },
  Task_10285_Name = {
    Text = "金を湯水のように使うⅤ"
  },
  Task_10287_Desc = {
    Text = "薔薇金券を5000000消費"
  },
  Task_10287_Name = {
    Text = "金を湯水のように使うⅣ"
  },
  Task_10288_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_10288_Name = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_10289_Desc = {
    Text = "最大5回の戦闘でクリア"
  },
  Task_10289_Name = {
    Text = "精密突破"
  },
  Task_10290_Desc = {
    Text = "隅の声を探す"
  },
  Task_10290_Name = {Text = "目標"},
  Task_10292_Desc = {
    Text = "累計90日ログイン"
  },
  Task_10292_Name = {
    Text = "努力を続ける"
  },
  Task_10293_Desc = {
    Text = "累計60日ログイン"
  },
  Task_10293_Name = {
    Text = "彼方から来た"
  },
  Task_10294_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10294_Name = {
    Text = "混沌こそ成長"
  },
  Task_10295_Desc = {
    Text = "謎の女性を振り払う"
  },
  Task_10295_Name = {Text = "目標"},
  Task_10297_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10297_Name = {
    Text = "混沌こそ成長"
  },
  Task_10298_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10298_Name = {Text = "速攻"},
  Task_10301_Desc = {
    Text = "地獄の番犬を倒せ"
  },
  Task_10301_Name = {Text = "目標"},
  Task_10302_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_10302_Desc = {
    Text = "混沌は自然の法則、秩序は人間の妄想。"
  },
  Task_10302_Name = {
    Text = "研究任務：純白詩篇"
  },
  Task_10302_UnlockCondDesc = {
    Text = "守秘者 25 レベルで解放"
  },
  Task_10303_Desc = {
    Text = "守秘者がレベル35に到達"
  },
  Task_10303_Name = {
    Text = "守秘者の試練IV"
  },
  Task_10305_Desc = {
    Text = "8体の覚醒体との同調率がレベル3に到達"
  },
  Task_10305_Name = {Text = "相棒Ⅲ"},
  Task_10307_Desc = {
    Text = "混沌の領域・隙間Ⅰをクリア"
  },
  Task_10307_Name = {Text = "任務5"},
  Task_10308_Desc = {
    Text = "任意の残像試練を1回クリア"
  },
  Task_10308_Name = {Text = "任務4"},
  Task_10309_Desc = {
    Text = "金券捜索Ⅰをクリア"
  },
  Task_10309_Name = {Text = "任務3"},
  Task_10310_Desc = {
    Text = "覚醒体を4体レベル20にする"
  },
  Task_10310_Name = {Text = "任務2"},
  Task_10311_Desc = {
    Text = "幻夢の深奥を1回クリア"
  },
  Task_10311_Name = {Text = "任務1"},
  Task_10313_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10314_Desc = {
    Text = "30歩以内でクリア"
  },
  Task_10314_Name = {Text = "戦略"},
  Task_10315_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_10315_Name = {
    Text = "最終降臨"
  },
  Task_10316_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10316_Name = {
    Text = "混沌こそ成長"
  },
  Task_10317_Desc = {
    Text = "クリア時の症状が3枚以下"
  },
  Task_10317_Name = {Text = "爽快"},
  Task_10318_Desc = {
    Text = "クリア時に遺物が3個以上"
  },
  Task_10318_Name = {
    Text = "遺物の力"
  },
  Task_10319_Desc = {
    Text = "最終戦で8ターン以内に勝利"
  },
  Task_10319_Name = {Text = "速攻"},
  Task_10320_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_10320_Desc = {
    Text = "輝くものは必ずしも金ではないが、必ず高価である。\n伝説によると、ミサゴは一群の孤立した錬金術師によって設立され、彼らの野心は金を作ることにとどまらなかった。"
  },
  Task_10320_Name = {
    Text = "研究任務：錬金記録"
  },
  Task_10321_Desc = {
    Text = "33歩以内でクリア"
  },
  Task_10321_Name = {Text = "戦略"},
  Task_10322_Desc = {
    Text = "クリア時に遺物が5個以上"
  },
  Task_10322_Name = {
    Text = "遺物の力"
  },
  Task_10323_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_10323_Desc = {
    Text = "厳密に言えば、覚醒体もシルバーコアテクノロジーの一種だ。\n全力を尽くして彼らが遅れないようにする必要がある。"
  },
  Task_10323_Name = {
    Text = "研究任務：製剤作成"
  },
  Task_10324_Desc = {
    Text = "学長室の異形モンスターを撃退"
  },
  Task_10324_Name = {Text = "目標"},
  Task_10325_Desc = {
    Text = "クリア時に遺物が2個以上"
  },
  Task_10325_Name = {
    Text = "遺物の力"
  },
  Task_10326_Desc = {
    Text = "クリア時に最低5枚の刻印カードを所持"
  },
  Task_10326_Name = {
    Text = "刻印の力"
  },
  Task_10327_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_10327_Name = {Text = "爽快"},
  Task_10328_Desc = {
    Text = "ステージをクリア"
  },
  Task_10328_Name = {
    Text = "ステージをクリア"
  },
  Task_10329_Desc = {
    Text = "ステージをクリア"
  },
  Task_10329_Name = {
    Text = "ステージをクリア"
  },
  Task_10330_Desc = {
    Text = "30歩以内でクリア"
  },
  Task_10330_Name = {Text = "戦略"},
  Task_10331_Desc = {
    Text = "ステージをクリア"
  },
  Task_10331_Name = {
    Text = "ステージをクリア"
  },
  Task_10332_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10332_Name = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10333_Desc = {
    Text = "ステージをクリア"
  },
  Task_10333_Name = {
    Text = "ステージをクリア"
  },
  Task_10334_Desc = {
    Text = "覚醒体スキルを3回強化する"
  },
  Task_10334_Name = {
    Text = "アリーナ愛好者（未使用する）"
  },
  Task_10335_Desc = {
    Text = "クリア: 無光の境地Ⅷ(未完了)"
  },
  Task_10336_Desc = {
    Text = "精神病院の秘密を探る"
  },
  Task_10336_Name = {Text = "目標"},
  Task_10337_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10337_Name = {
    Text = "完璧な通過"
  },
  Task_10338_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10338_Name = {
    Text = "完璧な通過"
  },
  Task_10339_Desc = {
    Text = "最終戦で7ターン以内に勝利"
  },
  Task_10339_Name = {
    Text = "最終戦で7ターン以内に勝利"
  },
  Task_10340_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10340_Name = {
    Text = "完璧な通過"
  },
  Task_10341_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10341_Name = {
    Text = "完璧な通過"
  },
  Task_10342_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10342_Name = {
    Text = "完璧な通過"
  },
  Task_10343_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10343_Name = {
    Text = "完璧な通過"
  },
  Task_10344_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10344_Name = {
    Text = "完璧な通過"
  },
  Task_10345_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10345_Name = {
    Text = "完璧な通過"
  },
  Task_10346_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10346_Name = {
    Text = "完璧な通過"
  },
  Task_10347_Desc = {
    Text = "任意の超次元界域の覚醒体の昇格レベルを3にする"
  },
  Task_10347_Name = {
    Text = "超次元の知識Ⅲ"
  },
  Task_10348_Desc = {
    Text = "任意の血肉界域の覚醒体の昇格レベルを3にする"
  },
  Task_10348_Name = {
    Text = "血肉の知識Ⅲ"
  },
  Task_10349_Desc = {
    Text = "任意の深海界域の覚醒体の昇格レベルを3にする"
  },
  Task_10349_Name = {
    Text = "深海の知識Ⅲ"
  },
  Task_10350_Desc = {
    Text = "任意の混沌界域の覚醒体の昇格レベルを3にする"
  },
  Task_10350_Name = {
    Text = "混沌の知識Ⅲ"
  },
  Task_10351_Desc = {
    Text = "ステージをクリア"
  },
  Task_10351_Name = {
    Text = "ステージをクリア"
  },
  Task_10352_Desc = {
    Text = "レベル40の血肉覚醒体を4体所持する"
  },
  Task_10352_Name = {
    Text = "血肉の主Ⅳ"
  },
  Task_10353_Desc = {
    Text = "ステージをクリア"
  },
  Task_10353_Name = {
    Text = "ステージをクリア"
  },
  Task_10354_Desc = {
    Text = "ステージをクリア"
  },
  Task_10354_Name = {
    Text = "ステージをクリア"
  },
  Task_10355_Desc = {
    Text = "ステージをクリア"
  },
  Task_10355_Name = {
    Text = "ステージをクリア"
  },
  Task_10356_Desc = {
    Text = "アイギスを追う"
  },
  Task_10356_Name = {Text = "目標"},
  Task_10357_Desc = {
    Text = "ステージをクリア"
  },
  Task_10357_Name = {
    Text = "ステージをクリア"
  },
  Task_10358_Desc = {
    Text = "最終戦で3ターン以内に勝利"
  },
  Task_10358_Name = {
    Text = "最終戦で3ターン以内に勝利"
  },
  Task_10359_Desc = {
    Text = "ステージをクリア"
  },
  Task_10359_Name = {
    Text = "ステージをクリア"
  },
  Task_10360_Desc = {
    Text = "ステージをクリア"
  },
  Task_10360_Name = {
    Text = "ステージをクリア"
  },
  Task_10361_Desc = {
    Text = "ステージをクリア"
  },
  Task_10361_Name = {
    Text = "ステージをクリア"
  },
  Task_10362_Desc = {
    Text = "ステージをクリア"
  },
  Task_10362_Name = {
    Text = "ステージをクリア"
  },
  Task_10363_Desc = {
    Text = "ステージをクリア"
  },
  Task_10363_Name = {
    Text = "ステージをクリア"
  },
  Task_10364_Desc = {
    Text = "ステージをクリア"
  },
  Task_10364_Name = {
    Text = "ステージをクリア"
  },
  Task_10365_Desc = {
    Text = "ステージをクリア"
  },
  Task_10365_Name = {
    Text = "ステージをクリア"
  },
  Task_10366_Desc = {
    Text = "ステージをクリア"
  },
  Task_10366_Name = {
    Text = "ステージをクリア"
  },
  Task_10367_Desc = {
    Text = "ステージをクリア"
  },
  Task_10367_Name = {
    Text = "ステージをクリア"
  },
  Task_10368_Desc = {
    Text = "ステージをクリア"
  },
  Task_10368_Name = {
    Text = "ステージをクリア"
  },
  Task_10369_Desc = {
    Text = "ステージをクリア"
  },
  Task_10369_Name = {
    Text = "ステージをクリア"
  },
  Task_10370_Desc = {
    Text = "メインストーリー第2章「@1@2」の黒い水たまりを10箇所見つける"
  },
  Task_10370_Desc2 = {
    Text = "メインストーリー第2章「蝋人形の名において」の黒い水たまりを10箇所見つける"
  },
  Task_10370_Name2 = {
    Text = "潜むささやきⅡ"
  },
  Task_10371_Desc = {
    Text = "メインストーリー第3章「@1@2」の黒い水たまりを9箇所見つける"
  },
  Task_10371_Desc2 = {
    Text = "メインストーリー第3章「猛犬注意」の黒い水たまり9箇所を見つける"
  },
  Task_10371_Name2 = {
    Text = "潜むささやきⅢ"
  },
  Task_10372_Desc = {
    Text = "派遣任務を336回完了する"
  },
  Task_10372_Name = {
    Text = "派遣任務Ⅴ"
  },
  Task_10373_Desc = {
    Text = "メインストーリー第1章「東区の秘め事」の黒い水たまり8箇所を見つける"
  },
  Task_10373_Name = {
    Text = "潜むささやき"
  },
  Task_10374_Desc = {
    Text = "派遣任務を84回完了する"
  },
  Task_10374_Name = {
    Text = "派遣任務Ⅲ"
  },
  Task_10375_Desc = {
    Text = "派遣任務を168回完了する"
  },
  Task_10375_Name = {
    Text = "派遣任務Ⅳ"
  },
  Task_10376_Desc = {
    Text = "派遣任務を12回完了する"
  },
  Task_10376_Name = {
    Text = "派遣任務"
  },
  Task_10377_Desc = {
    Text = "派遣任務を36回完了する"
  },
  Task_10377_Name = {
    Text = "派遣任務Ⅱ"
  },
  Task_10378_Desc = {
    Text = "ステージをクリア"
  },
  Task_10378_Name = {
    Text = "ステージをクリア"
  },
  Task_10379_Desc = {
    Text = "ステージをクリア"
  },
  Task_10379_Name = {
    Text = "ステージをクリア"
  },
  Task_10380_Desc = {
    Text = "ステージをクリア"
  },
  Task_10380_Name = {
    Text = "ステージをクリア"
  },
  Task_10381_Desc = {
    Text = "メインストーリー第4章「@1@2」の黒い水たまりを12箇所見つける"
  },
  Task_10381_Desc2 = {
    Text = "メインストーリー第4章「無音の中で」の黒い水たまりを12箇所見つける"
  },
  Task_10381_Name2 = {
    Text = "潜むささやきⅣ"
  },
  Task_10382_Desc = {
    Text = "レベル60の深海覚醒体を4体所持する"
  },
  Task_10382_Name = {
    Text = "深海の主Ⅵ"
  },
  Task_10384_Desc = {
    Text = "最終戦で1ターンに累計シールドが1000以上"
  },
  Task_10384_Name = {
    Text = "過剰防衛"
  },
  Task_10385_Desc = {
    Text = "意識の通路を越え、フランシスを追う"
  },
  Task_10385_Name = {Text = "目標"},
  Task_10387_Desc = {
    Text = "融蝕変異体を倒す"
  },
  Task_10387_Name = {Text = "目標"},
  Task_10388_Desc = {
    Text = "サラを地下室に連れていく"
  },
  Task_10388_Name = {Text = "目標"},
  Task_10390_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10390_Name = {Text = "速攻"},
  Task_10391_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10391_Name = {Text = "速攻"},
  Task_10392_Desc = {
    Text = "次元空間と「彼」の視線から脱出"
  },
  Task_10392_Name = {Text = "目標"},
  Task_10394_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10394_Name = {Text = "速攻"},
  Task_10395_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10395_Name = {Text = "速攻"},
  Task_10396_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10396_Name = {Text = "速攻"},
  Task_10397_Desc = {
    Text = "消失したリリーを召喚"
  },
  Task_10397_Name = {Text = "目標"},
  Task_10404_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10404_Name = {Text = "速攻"},
  Task_10405_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10405_Name = {Text = "速攻"},
  Task_10406_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10406_Name = {
    Text = "混沌こそ成長"
  },
  Task_10407_Desc = {
    Text = "暗い地下鉄を越える"
  },
  Task_10407_Name = {Text = "目標"},
  Task_10409_Desc = {
    Text = "精神病院から逃れる"
  },
  Task_10409_Name = {Text = "目標"},
  Task_10413_Desc = {
    Text = "クリア時に遺物が4個以上"
  },
  Task_10413_Name = {
    Text = "遺物の力"
  },
  Task_10419_Desc = {
    Text = "パンディアを追う"
  },
  Task_10419_Name = {Text = "目標"},
  Task_10420_Desc = {
    Text = "調査「無音の中で」高難度を完了する"
  },
  Task_10420_Name = {
    Text = "お母さん、痛くないよ・高難度"
  },
  Task_10421_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_10421_Name = {Text = "速攻"},
  Task_10422_Desc = {
    Text = "最終戦で8ターン以内に勝利"
  },
  Task_10422_Name = {Text = "速攻"},
  Task_10423_Desc = {
    Text = "最終戦で8ターン以内に勝利"
  },
  Task_10423_Name = {Text = "速攻"},
  Task_10424_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10424_Name = {Text = "速攻"},
  Task_10425_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10425_Name = {Text = "速攻"},
  Task_10426_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10426_Name = {Text = "速攻"},
  Task_10427_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10427_Name = {Text = "速攻"},
  Task_10428_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10428_Name = {Text = "速攻"},
  Task_10429_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10429_Name = {Text = "速攻"},
  Task_10430_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10430_Name = {Text = "速攻"},
  Task_10431_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10431_Name = {Text = "速攻"},
  Task_10432_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10432_Name = {Text = "速攻"},
  Task_10433_Desc = {
    Text = "最大6回の戦闘でクリア"
  },
  Task_10433_Name = {
    Text = "精密突破"
  },
  Task_10434_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10435_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_10435_Name = {Text = "爽快"},
  Task_10436_Desc = {
    Text = "研究員を阻止"
  },
  Task_10436_Name = {Text = "目標"},
  Task_10437_Desc = {
    Text = "地下室に入る"
  },
  Task_10437_Name = {Text = "目標"},
  Task_10438_Desc = {
    Text = "24ターン以内にクリア"
  },
  Task_10438_Name = {
    Text = "24ターン以内にクリア"
  },
  Task_10439_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10439_Name = {Text = "速攻"},
  Task_10440_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10440_Name = {
    Text = "混沌こそ成長"
  },
  Task_10441_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10441_Name = {Text = "速攻"},
  Task_10442_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10442_Name = {Text = "速攻"},
  Task_10443_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10443_Name = {Text = "速攻"},
  Task_10444_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10444_Name = {Text = "速攻"},
  Task_10445_Desc = {
    Text = "黒章を累計 1000 消費"
  },
  Task_10445_Name = {
    Text = "黒い召喚Ⅲ"
  },
  Task_10446_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10446_Name = {Text = "速攻"},
  Task_10447_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10447_Name = {Text = "速攻"},
  Task_10448_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10448_Name = {Text = "速攻"},
  Task_10449_Desc = {
    Text = "ステージをクリア"
  },
  Task_10449_Name = {
    Text = "ステージをクリア"
  },
  Task_10450_Desc = {
    Text = "ステージをクリア"
  },
  Task_10450_Name = {
    Text = "ステージをクリア"
  },
  Task_10451_Desc = {
    Text = "禁忌編纂を600回クリア"
  },
  Task_10451_Name = {
    Text = "密約刻印師Ⅴ"
  },
  Task_10452_Desc = {
    Text = "禁忌編纂を400回クリア"
  },
  Task_10452_Name = {
    Text = "密約刻印師Ⅳ"
  },
  Task_10453_Desc = {
    Text = "禁忌編纂を200回クリア"
  },
  Task_10453_Name = {
    Text = "密約刻印師Ⅲ"
  },
  Task_10454_Desc = {
    Text = "密約6セット効果を起動する"
  },
  Task_10454_Name = {Text = "任務4"},
  Task_10455_Desc = {
    Text = "禁忌編纂を50回クリア"
  },
  Task_10455_Name = {
    Text = "密約刻印師"
  },
  Task_10456_Desc = {
    Text = "超越存在を50回クリア"
  },
  Task_10456_Name = {
    Text = "秘められた誕生についてⅣ"
  },
  Task_10457_Desc = {
    Text = "ロータンを見つける"
  },
  Task_10457_Name = {Text = "目標"},
  Task_10458_Desc = {
    Text = "ステージをクリア"
  },
  Task_10458_Name = {
    Text = "ステージをクリア"
  },
  Task_10459_Desc = {
    Text = "ステージをクリア"
  },
  Task_10459_Name = {
    Text = "ステージをクリア"
  },
  Task_10460_Desc = {
    Text = "ステージをクリア"
  },
  Task_10460_Name = {
    Text = "ステージをクリア"
  },
  Task_10461_Desc = {
    Text = "ステージをクリア"
  },
  Task_10461_Name = {
    Text = "ステージをクリア"
  },
  Task_10462_Desc = {
    Text = "ステージをクリア"
  },
  Task_10462_Name = {
    Text = "ステージをクリア"
  },
  Task_10463_Desc = {
    Text = "ステージをクリア"
  },
  Task_10463_Name = {
    Text = "ステージをクリア"
  },
  Task_10464_Desc = {
    Text = "ステージをクリア"
  },
  Task_10464_Name = {
    Text = "ステージをクリア"
  },
  Task_10465_Desc = {
    Text = "ステージをクリア"
  },
  Task_10465_Name = {
    Text = "ステージをクリア"
  },
  Task_10466_Desc = {
    Text = "ステージをクリア"
  },
  Task_10466_Name = {
    Text = "ステージをクリア"
  },
  Task_10467_Desc = {
    Text = "ステージをクリア"
  },
  Task_10467_Name = {
    Text = "ステージをクリア"
  },
  Task_10468_Desc = {
    Text = "ステージをクリア"
  },
  Task_10468_Name = {
    Text = "ステージをクリア"
  },
  Task_10469_Desc = {
    Text = "ステージをクリア"
  },
  Task_10469_Name = {
    Text = "ステージをクリア"
  },
  Task_10470_Desc = {
    Text = "ステージをクリア"
  },
  Task_10470_Name = {
    Text = "ステージをクリア"
  },
  Task_10471_Desc = {
    Text = "ステージをクリア"
  },
  Task_10471_Name = {
    Text = "ステージをクリア"
  },
  Task_10472_Desc = {
    Text = "調査メイン第2章\n「蝋人形の名において」を完了"
  },
  Task_10473_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_10473_Desc = {
    Text = "それらは自覚のない恐怖の中で転がっている。\n無知、無光、無名。"
  },
  Task_10473_Name = {
    Text = "研究任務：緋紅詩篇"
  },
  Task_10473_UnlockCondDesc = {
    Text = "守秘者 25 レベルで解放"
  },
  Task_10474_Desc = {
    Text = "ステージをクリア"
  },
  Task_10474_Name = {
    Text = "ステージをクリア"
  },
  Task_10475_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10475_Name = {Text = "速攻"},
  Task_10476_Desc = {
    Text = "金券捜索を400回クリア"
  },
  Task_10476_Name = {
    Text = "金の発掘者Ⅳ"
  },
  Task_10477_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10478_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10478_Name = {Text = "速攻"},
  Task_10479_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10479_Name = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10480_Desc = {
    Text = "ステージをクリア"
  },
  Task_10480_Name = {
    Text = "ステージをクリア"
  },
  Task_10481_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10481_Name = {Text = "速攻"},
  Task_10482_Desc = {
    Text = "調査メイン第4章\n「無音の中で」を完了"
  },
  Task_10483_Desc = {
    Text = "ステージをクリア"
  },
  Task_10483_Name = {
    Text = "ステージをクリア"
  },
  Task_10484_Desc = {
    Text = "ステージをクリア"
  },
  Task_10484_Name = {
    Text = "ステージをクリア"
  },
  Task_10485_Desc = {
    Text = "ステージをクリア"
  },
  Task_10485_Name = {
    Text = "ステージをクリア"
  },
  Task_10486_Desc = {
    Text = "ステージをクリア"
  },
  Task_10486_Name = {
    Text = "ステージをクリア"
  },
  Task_10487_Desc = {
    Text = "ステージをクリア"
  },
  Task_10487_Name = {
    Text = "ステージをクリア"
  },
  Task_10488_Desc = {
    Text = "ステージをクリア"
  },
  Task_10488_Name = {
    Text = "ステージをクリア"
  },
  Task_10489_Desc = {
    Text = "ステージをクリア"
  },
  Task_10489_Name = {
    Text = "ステージをクリア"
  },
  Task_10490_Desc = {
    Text = "ステージをクリア"
  },
  Task_10490_Name = {
    Text = "ステージをクリア"
  },
  Task_10492_Desc = {
    Text = "ステージをクリア"
  },
  Task_10492_Name = {
    Text = "ステージをクリア"
  },
  Task_10493_Desc = {
    Text = "ステージをクリア"
  },
  Task_10493_Name = {
    Text = "ステージをクリア"
  },
  Task_10494_Desc = {
    Text = "ステージをクリア"
  },
  Task_10494_Name = {
    Text = "ステージをクリア"
  },
  Task_10495_Desc = {
    Text = "ステージをクリア"
  },
  Task_10495_Name = {
    Text = "ステージをクリア"
  },
  Task_10496_Desc = {
    Text = "ステージをクリア"
  },
  Task_10496_Name = {
    Text = "ステージをクリア"
  },
  Task_10497_Desc = {
    Text = "「幻夢の深奥」を30回クリア"
  },
  Task_10497_Name = {
    Text = "深淵ダイバーⅢ"
  },
  Task_10498_Desc = {
    Text = "「幻夢の深奥」を60回クリア"
  },
  Task_10498_Name = {
    Text = "深淵ダイバーⅣ"
  },
  Task_10499_Desc = {
    Text = "「幻夢の深奥」を1回クリア"
  },
  Task_10499_Name = {
    Text = "深淵ダイバー"
  },
  Task_10500_Desc = {
    Text = "「幻夢の深奥」を15回クリア"
  },
  Task_10500_Name = {
    Text = "深淵ダイバーⅡ"
  },
  Task_10501_Desc = {
    Text = "一度のダメージが800に達する"
  },
  Task_10501_Name = {
    Text = "強力ダメージⅢ"
  },
  Task_10502_Desc = {
    Text = "一度のダメージが1000に達する"
  },
  Task_10502_Name = {
    Text = "強力ダメージⅣ"
  },
  Task_10503_Desc = {
    Text = "一度のダメージが200に達する"
  },
  Task_10503_Name = {
    Text = "強力ダメージ"
  },
  Task_10504_Desc = {
    Text = "一度のダメージが400に達する"
  },
  Task_10504_Name = {
    Text = "強力ダメージⅡ"
  },
  Task_10505_Desc = {
    Text = "一度のダメージが5000に達する"
  },
  Task_10505_Name = {
    Text = "致命的ダメージⅤ"
  },
  Task_10506_Desc = {
    Text = "敵に毒を500回重ねる"
  },
  Task_10506_Name = {
    Text = "毒理学専門家"
  },
  Task_10507_Desc = {
    Text = "アイギスを阻止"
  },
  Task_10507_Name = {Text = "目標"},
  Task_10510_Desc = {
    Text = "特定の戦闘Xで、1ターンに1000以上のダメージを与える（X精鋭戦）"
  },
  Task_10510_Name = {
    Text = "戦慄カーニバル"
  },
  Task_10511_Desc = {
    Text = "特定の戦闘Xで、1ターンに狂気解放を5回以上使用する"
  },
  Task_10511_Name = {
    Text = "連鎖狂乱"
  },
  Task_10512_Desc = {
    Text = "クリア時にキャンプ回復の使用が1回以下"
  },
  Task_10512_Name = {
    Text = "安全ハウス"
  },
  Task_10513_Desc = {
    Text = "クリア時にキャンプのマップ探索度が80%以上"
  },
  Task_10513_Name = {
    Text = "目から鱗"
  },
  Task_10514_Desc = {
    Text = "クリア時の種類Xのカードが3枚以下"
  },
  Task_10514_Name = {
    Text = "前衛を無効化"
  },
  Task_10515_Desc = {
    Text = "クリア時の種類Xのカードが3枚以上"
  },
  Task_10515_Name = {
    Text = "危篤通知"
  },
  Task_10516_Desc = {
    Text = "クリア時に特定タイプXの遺物が3個以上（X黄金）"
  },
  Task_10516_Name = {
    Text = "ゴールドシーカー"
  },
  Task_10517_Desc = {
    Text = "クリア時に刻印の種類が2つ以上になる（啓示と上位啓示を含む）"
  },
  Task_10517_Name = {
    Text = "刻印コレクター"
  },
  Task_10518_Desc = {
    Text = "クリア時に覚醒体2体以上を覚醒"
  },
  Task_10518_Name = {
    Text = "覚醒の瞬間"
  },
  Task_10519_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10519_Name = {
    Text = "混沌こそ成長"
  },
  Task_10520_Desc = {
    Text = "提灯教会を撃退"
  },
  Task_10520_Name = {Text = "目標"},
  Task_10521_Desc = {
    Text = "法陣の描画時間を稼ぐ"
  },
  Task_10521_Name = {Text = "目標"},
  Task_10523_Desc = {
    Text = "任意の覚醒体スキルをレベル3にする"
  },
  Task_10523_Name = {Text = "任務2"},
  Task_10524_Desc = {
    Text = "メイン調査・高難度1-8を完了する"
  },
  Task_10524_Name = {Text = "任務3"},
  Task_10525_Desc = {
    Text = "覚醒体を4体レベル40にする"
  },
  Task_10525_Name = {Text = "任務1"},
  Task_10526_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10526_Name = {Text = "速攻"},
  Task_10527_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10527_Name = {Text = "速攻"},
  Task_10528_Desc = {
    Text = "薬剤収集を100回クリア"
  },
  Task_10528_Name = {
    Text = "天才薬師Ⅱ"
  },
  Task_10529_Desc = {
    Text = "混沌の領域・隙間Ⅵをクリア"
  },
  Task_10529_Name = {Text = "任務5"},
  Task_10530_Desc = {
    Text = "決戦ヘロット"
  },
  Task_10530_Name = {Text = "目標"},
  Task_10531_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10531_Name = {Text = "速攻"},
  Task_10532_Desc = {
    Text = "金券捜索を200回クリア"
  },
  Task_10532_Name = {
    Text = "金の発掘者Ⅲ"
  },
  Task_10533_Desc = {
    Text = "ドールと協力して提灯教会を撃退"
  },
  Task_10533_Name = {Text = "目標"},
  Task_10534_Desc = {
    Text = "金券捜索を50回クリア"
  },
  Task_10534_Name = {
    Text = "金の発掘者"
  },
  Task_10535_Desc = {
    Text = "金券捜索を100回クリア"
  },
  Task_10535_Name = {
    Text = "金の発掘者Ⅱ"
  },
  Task_10536_Desc = {
    Text = "ステージをクリア"
  },
  Task_10536_Name = {
    Text = "ステージをクリア"
  },
  Task_10537_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10537_Name = {Text = "速攻"},
  Task_10538_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_10538_Desc = {
    Text = "時には、破壊の衝動が創造の衝動となる。\n筆を取れ、芸術に準備は不要だ。"
  },
  Task_10538_Name = {
    Text = "調査任務：ダダイスム"
  },
  Task_10538_UnlockCondDesc = {
    Text = "調査 1-13 を完了する"
  },
  Task_10539_Desc = {
    Text = "ステージ内の全任務を完了後に報酬を受け取り可能"
  },
  Task_10539_Name = {
    Text = "第二段階"
  },
  Task_10540_Desc = {
    Text = "調査メイン第1章\n「東区の秘め事」高難度を完了"
  },
  Task_10544_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10544_Name = {
    Text = "完璧な通過"
  },
  Task_10545_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10545_Name = {
    Text = "完璧な通過"
  },
  Task_10546_Desc = {
    Text = "累計2日ログイン"
  },
  Task_10546_Name = {
    Text = "こんにちは、守秘者"
  },
  Task_10547_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10547_Name = {
    Text = "完璧な通過"
  },
  Task_10548_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10548_Name = {
    Text = "完璧な通過"
  },
  Task_10549_Desc = {
    Text = "混沌の領域・隙間Ⅰをクリア"
  },
  Task_10550_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10550_Name = {
    Text = "完璧な通過"
  },
  Task_10552_Desc = {
    Text = "クリア時に遺物が2個以上"
  },
  Task_10552_Name = {
    Text = "遺物の力"
  },
  Task_10553_Desc = {
    Text = "クリア時に最低5枚の刻印カードを所持"
  },
  Task_10553_Name = {
    Text = "刻印の力"
  },
  Task_10554_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_10554_Name = {Text = "爽快"},
  Task_10555_Desc = {
    Text = "この章の全任務を完了後に受け取る"
  },
  Task_10555_Name = {
    Text = "界域知識Ⅲ"
  },
  Task_10556_Desc = {
    Text = "33歩以内でクリア"
  },
  Task_10556_Name = {Text = "戦略"},
  Task_10557_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10557_Name = {
    Text = "完璧な通過"
  },
  Task_10558_Desc = {
    Text = "最大5回の戦闘でクリア"
  },
  Task_10558_Name = {
    Text = "精密突破"
  },
  Task_10565_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_10565_Desc = {
    Text = "彼の本能、理性、心は小さなガラス瓶に封じ込められている。\n世界は彼と無関係になった。"
  },
  Task_10565_Name = {
    Text = "調査任務：活性解離"
  },
  Task_10565_UnlockCondDesc = {
    Text = "調査 1-13 を完了する"
  },
  Task_10571_Desc = {
    Text = "150回召喚儀式を行う"
  },
  Task_10571_Name = {
    Text = "天才守秘者Ⅲ"
  },
  Task_10572_Desc = {
    Text = "100回召喚儀式を行う"
  },
  Task_10572_Name = {
    Text = "天才守秘者Ⅱ"
  },
  Task_10575_Desc = {
    Text = "任意の血肉界域の覚醒体の昇格レベルを5にする"
  },
  Task_10575_Name = {
    Text = "血肉の知識Ⅴ"
  },
  Task_10576_Desc = {
    Text = "任意の深海界域の覚醒体の昇格レベルを5にする"
  },
  Task_10576_Name = {
    Text = "深海の知識Ⅴ"
  },
  Task_10577_Desc = {
    Text = "50回召喚儀式を行う"
  },
  Task_10577_Name = {
    Text = "天才守秘者"
  },
  Task_10578_Desc = {
    Text = "任意の超次元界域の覚醒体の昇格レベルを5にする"
  },
  Task_10578_Name = {
    Text = "超次元の知識Ⅴ"
  },
  Task_10579_Desc = {
    Text = "レベル9の密約を12個所持する"
  },
  Task_10579_Name = {
    Text = "密約コレクターⅡ"
  },
  Task_10580_Desc = {
    Text = "レベル6の密約を6個所持する"
  },
  Task_10580_Name = {
    Text = "密約コレクター"
  },
  Task_10581_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10581_Name = {Text = "速攻"},
  Task_10582_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10582_Name = {Text = "速攻"},
  Task_10583_Desc = {
    Text = "フランシスの痕跡を追う"
  },
  Task_10583_Name = {Text = "目標"},
  Task_10584_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10584_Name = {Text = "速攻"},
  Task_10585_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10585_Name = {Text = "速攻"},
  Task_10586_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10586_Name = {Text = "速攻"},
  Task_10587_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10587_Name = {Text = "速攻"},
  Task_10588_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10588_Name = {Text = "速攻"},
  Task_10589_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10589_Name = {Text = "速攻"},
  Task_10590_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10590_Name = {Text = "速攻"},
  Task_10591_Desc = {
    Text = "クリア時の症状が3枚以下"
  },
  Task_10591_Name = {Text = "爽快"},
  Task_10592_Desc = {
    Text = "ライ精神病院に再び入る"
  },
  Task_10592_Name = {Text = "目標"},
  Task_10593_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_10593_Name = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_10595_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10595_Name = {
    Text = "完璧な通過"
  },
  Task_10596_Desc = {
    Text = "雪原から逃れる"
  },
  Task_10596_Name = {Text = "目標"},
  Task_10597_Desc = {
    Text = "派遣を3回実行する"
  },
  Task_10597_Name = {
    Text = "派遣を行う"
  },
  Task_10598_Desc = {
    Text = "38ターン以内にクリア"
  },
  Task_10598_Name = {
    Text = "38ターン以内にクリア"
  },
  Task_10599_Desc = {
    Text = "薔薇金券を2500000消費"
  },
  Task_10599_Name = {
    Text = "金を湯水のように使うⅢ"
  },
  Task_10600_Desc = {
    Text = "ゲームにログインする"
  },
  Task_10600_Name = {
    Text = "ゲームにログインする"
  },
  Task_10601_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10601_Name = {
    Text = "完璧な通過"
  },
  Task_10602_Desc = {
    Text = "ステージをクリア"
  },
  Task_10602_Name = {
    Text = "ステージをクリア"
  },
  Task_10603_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_10603_Name = {
    Text = "最終降臨"
  },
  Task_10604_Desc = {
    Text = "クリア時に遺物が4個以上"
  },
  Task_10604_Name = {
    Text = "遺物の力"
  },
  Task_10605_Desc = {
    Text = "ステージをクリア"
  },
  Task_10605_Name = {
    Text = "ステージをクリア"
  },
  Task_10606_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_10606_Name = {Text = "爽快"},
  Task_10607_Desc = {
    Text = "クリア時に最低8枚の刻印カードを所持"
  },
  Task_10607_Name = {
    Text = "刻印の力"
  },
  Task_10608_Desc = {
    Text = "守秘者がレベル25に到達"
  },
  Task_10608_Name = {
    Text = "守秘者の試練Ⅲ"
  },
  Task_10609_Desc = {
    Text = "全戦闘で狂気解放回数が4回以下でクリア"
  },
  Task_10609_Name = {
    Text = "冷静で優雅"
  },
  Task_10610_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10610_Name = {
    Text = "完璧な通過"
  },
  Task_10611_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10612_Desc = {
    Text = "最大3回の戦闘でクリア"
  },
  Task_10612_Name = {
    Text = "精密突破"
  },
  Task_10613_Desc = {
    Text = "クリア時に最低黒章を50個所持"
  },
  Task_10613_Name = {
    Text = "次の機会に使いたい"
  },
  Task_10614_Desc = {
    Text = "16名の覚醒体との同調率がレベル3に到達"
  },
  Task_10614_Name = {Text = "相棒Ⅶ"},
  Task_10616_Desc = {
    Text = "レベル40の深海覚醒体を4体所持する"
  },
  Task_10616_Name = {
    Text = "深海の主Ⅳ"
  },
  Task_10618_Desc = {
    Text = "48ターン以内にクリア"
  },
  Task_10618_Name = {
    Text = "48ターン以内にクリア"
  },
  Task_10619_Desc = {
    Text = "53ターン以内にクリア"
  },
  Task_10619_Name = {
    Text = "53ターン以内にクリア"
  },
  Task_10620_Desc = {
    Text = "次元の残像調査を30回クリア"
  },
  Task_10620_Name = {
    Text = "超次元の虚Ⅱ"
  },
  Task_10621_Desc = {
    Text = "次元の残像調査を60回クリア"
  },
  Task_10621_Name = {
    Text = "超次元の虚Ⅲ"
  },
  Task_10622_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10622_Name = {
    Text = "完璧な通過"
  },
  Task_10623_Desc = {
    Text = "次元の残像調査を15回クリア"
  },
  Task_10623_Name = {
    Text = "超次元の虚"
  },
  Task_10624_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10624_Name = {
    Text = "完璧な通過"
  },
  Task_10625_Desc = {
    Text = "血肉の残像調査を120回クリア"
  },
  Task_10625_Name = {
    Text = "血肉の虚Ⅳ"
  },
  Task_10626_Desc = {
    Text = "血肉の残像調査を15回クリア"
  },
  Task_10626_Name = {
    Text = "血肉の虚"
  },
  Task_10627_Desc = {
    Text = "血肉の残像調査を30回クリア"
  },
  Task_10627_Name = {
    Text = "血肉の虚Ⅱ"
  },
  Task_10628_Desc = {
    Text = "最大6回の戦闘でクリア"
  },
  Task_10628_Name = {
    Text = "精密突破"
  },
  Task_10629_Desc = {
    Text = "海底の残像調査を240回クリア"
  },
  Task_10629_Name = {
    Text = "深海の虚Ⅴ"
  },
  Task_10630_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10630_Name = {
    Text = "完璧な通過"
  },
  Task_10631_Desc = {
    Text = "特定戦闘X（通常）で、1ターンでモンスターを3体以上撃破"
  },
  Task_10631_Name = {
    Text = "狩猟の時"
  },
  Task_10632_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10632_Name = {
    Text = "完璧な通過"
  },
  Task_10633_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10633_Name = {
    Text = "完璧な通過"
  },
  Task_10634_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10634_Name = {
    Text = "完璧な通過"
  },
  Task_10635_Desc = {
    Text = "クリア時に遺物が5個以上"
  },
  Task_10635_Name = {
    Text = "遺物の力"
  },
  Task_10636_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10636_Name = {
    Text = "完璧な通過"
  },
  Task_10637_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10637_Name = {
    Text = "完璧な通過"
  },
  Task_10638_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10638_Name = {
    Text = "完璧な通過"
  },
  Task_10639_Desc = {
    Text = "ステージ内の全任務を完了後に報酬を受け取り可能"
  },
  Task_10639_Name = {
    Text = "第四段階"
  },
  Task_10640_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10640_Name = {
    Text = "完璧な通過"
  },
  Task_10641_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10641_Name = {
    Text = "完璧な通過"
  },
  Task_10642_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10642_Name = {
    Text = "完璧な通過"
  },
  Task_10643_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10643_Name = {
    Text = "完璧な通過"
  },
  Task_10644_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10644_Name = {
    Text = "完璧な通過"
  },
  Task_10645_Desc = {
    Text = "任意の超次元界域の覚醒体の昇格レベルを1にする"
  },
  Task_10645_Name = {
    Text = "超次元の知識Ⅰ"
  },
  Task_10646_Desc = {
    Text = "ステージをクリア"
  },
  Task_10646_Name = {
    Text = "ステージをクリア"
  },
  Task_10647_Desc = {
    Text = "任意の混沌界域の覚醒体の昇格レベルを1にする"
  },
  Task_10647_Name = {
    Text = "混沌の知識Ⅰ"
  },
  Task_10648_Desc = {
    Text = "任意の血肉界域の覚醒体の昇格レベルを1にする"
  },
  Task_10648_Name = {
    Text = "血肉の知識Ⅰ"
  },
  Task_10649_Desc = {
    Text = "任意の深海界域の覚醒体の昇格レベルを1にする"
  },
  Task_10649_Name = {
    Text = "深海の知識Ⅰ"
  },
  Task_10650_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10651_Desc = {
    Text = "ステージをクリア"
  },
  Task_10651_Name = {
    Text = "ステージをクリア"
  },
  Task_10652_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_10652_Desc2 = {
    Text = "調査「蝋人形の名において」を完了する"
  },
  Task_10652_Name2 = {
    Text = "蝋の迷い"
  },
  Task_10653_Desc = {
    Text = "調査「東区の秘め事」で3回共鳴する"
  },
  Task_10653_Name = {
    Text = "感謝の残響"
  },
  Task_10654_Desc = {
    Text = "累計30日ログイン"
  },
  Task_10654_Name = {
    Text = "積極分子"
  },
  Task_10656_Desc = {
    Text = "クリア無光の境地Ⅶ(未完了)"
  },
  Task_10656_Name = {
    Text = "倫理なき芸術家"
  },
  Task_10658_Desc = {
    Text = "毎試合30ポイント"
  },
  Task_10658_Name = {
    Text = "戦闘勝利する <size=20><color=#747474>各30ポイント</color></size>"
  },
  Task_10660_Desc = {Text = "チー"},
  Task_10660_Name = {
    Text = "チューチュー"
  },
  Task_10661_Desc = {
    Text = "ステージをクリア"
  },
  Task_10661_Name = {
    Text = "ステージをクリア"
  },
  Task_10663_Desc = {
    Text = "累計7日ログイン"
  },
  Task_10663_Name = {
    Text = "早起きは三文の徳"
  },
  Task_10664_Desc = {
    Text = "50歩以内でクリア"
  },
  Task_10664_Name = {Text = "戦略"},
  Task_10665_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10666_Desc = {
    Text = "最大7回の戦闘でクリア"
  },
  Task_10666_Name = {
    Text = "精密突破"
  },
  Task_10667_Desc = {
    Text = "覚醒体を4体レベル60にする"
  },
  Task_10667_Name = {Text = "任務1"},
  Task_10668_Desc = {
    Text = "攻撃作戦/防衛演習/協同作戦を20回完了する"
  },
  Task_10668_Name = {
    Text = "スキル素材本（未使用する）"
  },
  Task_10669_Desc = {
    Text = "メイン調査ステージを10回完了する"
  },
  Task_10669_Name = {
    Text = "メインステージ本（未使用する）"
  },
  Task_10670_Desc = {
    Text = "血肉の沼・隙間Ⅰをクリア"
  },
  Task_10671_Desc = {
    Text = "ショップで薔薇金券を3回使用する"
  },
  Task_10671_Name = {
    Text = "コイン購入"
  },
  Task_10672_Desc = {
    Text = "フレンドに10回「いいね」する"
  },
  Task_10672_Name = {
    Text = "フレンド「いいね」"
  },
  Task_10673_Desc = {
    Text = "超越存在を1回完了する"
  },
  Task_10673_Name = {
    Text = "ウィークリーBOSS"
  },
  Task_10674_Desc = {
    Text = "対人戦に3回参加する"
  },
  Task_10674_Name = {Text = "PVP戦闘"},
  Task_10675_Desc = {
    Text = "今週の試練を完了する"
  },
  Task_10675_Name = {
    Text = "今週の試練"
  },
  Task_10676_Desc = {
    Text = "救援を3回使用する"
  },
  Task_10676_Name = {
    Text = "フレンド救援"
  },
  Task_10677_Desc = {
    Text = "今週の幻夢の深奥の累積ポイントが1800に達しました"
  },
  Task_10677_Name = {
    Text = "幻夢の深奥"
  },
  Task_10678_Desc = {
    Text = "クリア時に1黒章ごとに3ポイント、最大600ポイント"
  },
  Task_10678_Name = {
    Text = "黒章 <size=20><color=#747474>クリア時に1黒章ごとに3ポイント、最大600ポイント</color></size>"
  },
  Task_10679_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_10679_Name = {Text = "速攻"},
  Task_10680_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_10680_Desc = {
    Text = "次元、空間、量子……これらの言葉の背後にある深い意味を君は永遠に理解できないかもしれない。\nこの世で起こる大半のことを理解できないように。"
  },
  Task_10680_Name = {
    Text = "研究任務：緋紫詩篇"
  },
  Task_10680_UnlockCondDesc = {
    Text = "守秘者 25 レベルで解放"
  },
  Task_10681_Desc = {
    Text = "クリア時のライフが80%以上"
  },
  Task_10682_Desc = {
    Text = "最終戦で25ターン以内に勝利"
  },
  Task_10682_Name = {
    Text = "最終戦で25ターン以内に勝利"
  },
  Task_10683_Desc = {
    Text = "任意の混沌界域の覚醒体の昇格レベルを2にする"
  },
  Task_10683_Name = {
    Text = "混沌の知識Ⅱ"
  },
  Task_10684_Desc = {
    Text = "調査「@1犬@2意」で8回共鳴する"
  },
  Task_10684_Desc2 = {
    Text = "調査「猛犬注意」で8回共鳴する"
  },
  Task_10684_Name2 = {
    Text = "忍耐の残響Ⅲ"
  },
  Task_10685_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10685_Name = {
    Text = "混沌こそ成長"
  },
  Task_10686_Desc = {
    Text = "クリア時に遺物が3個以上"
  },
  Task_10686_Name = {
    Text = "遺物の力"
  },
  Task_10687_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10688_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10689_Desc = {
    Text = "30歩以内でクリア"
  },
  Task_10689_Name = {Text = "戦略"},
  Task_10690_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_10690_Name = {
    Text = "最終降臨"
  },
  Task_10691_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10691_Name = {
    Text = "混沌こそ成長"
  },
  Task_10692_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10692_Name = {
    Text = "混沌こそ成長"
  },
  Task_10693_Desc = {
    Text = "異変の源を取り除く"
  },
  Task_10693_Name = {Text = "目標"},
  Task_10694_Desc = {
    Text = "提灯教会を撃退"
  },
  Task_10694_Name = {Text = "目標"},
  Task_10695_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10695_Name = {
    Text = "完璧な通過"
  },
  Task_10696_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10696_Name = {
    Text = "完璧な通過"
  },
  Task_10698_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10698_Name = {
    Text = "完璧な通過"
  },
  Task_10706_Desc = {
    Text = "密約を1回強化（未完了）"
  },
  Task_10706_Name = {
    Text = "「密約」強化（未使用する）"
  },
  Task_10707_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10707_Name = {Text = "速攻"},
  Task_10708_Desc = {
    Text = "35歩以内でクリア"
  },
  Task_10708_Name = {Text = "戦略"},
  Task_10710_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10710_Name = {Text = "速攻"},
  Task_10713_Desc = {
    Text = "任意の混沌界域の覚醒体の昇格レベルを5にする"
  },
  Task_10713_Name = {
    Text = "混沌の知識Ⅴ"
  },
  Task_10714_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10714_Name = {Text = "速攻"},
  Task_10715_Desc = {
    Text = "包囲を突破する"
  },
  Task_10715_Name = {Text = "目標"},
  Task_10716_Desc = {
    Text = "守秘者がレベル5に到達"
  },
  Task_10716_Name = {
    Text = "守秘者の試練I"
  },
  Task_10717_Desc = {
    Text = "最終戦で1ターンに累計シールドが1500以上"
  },
  Task_10717_Name = {
    Text = "過剰防衛"
  },
  Task_10720_Desc = {
    Text = "混沌の領域・隙間Ⅶをクリア"
  },
  Task_10720_Name = {Text = "任務5"},
  Task_10721_Desc = {
    Text = "任意の密約を6つレベル12にする"
  },
  Task_10721_Name = {Text = "任務4"},
  Task_10722_Desc = {
    Text = "クリア時に最低8枚の刻印カードを所持"
  },
  Task_10722_Name = {
    Text = "刻印の力"
  },
  Task_10723_Desc = {
    Text = "全戦闘で狂気解放回数が4回以下でクリア"
  },
  Task_10723_Name = {
    Text = "冷静で優雅"
  },
  Task_10724_Desc = {
    Text = "任意の覚醒体スキルをレベル4にする"
  },
  Task_10724_Name = {Text = "任務1"},
  Task_10725_Desc = {
    Text = "最終戦で1ターンに累計シールドが2000以上"
  },
  Task_10725_Name = {
    Text = "過剰防衛"
  },
  Task_10727_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10727_Name = {
    Text = "完璧な通過"
  },
  Task_10728_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10728_Name = {
    Text = "完璧な通過"
  },
  Task_10729_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10729_Name = {
    Text = "完璧な通過"
  },
  Task_10733_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_10733_Desc = {
    Text = "それは神が宇宙を書き記す言葉だった。\nそれを聞くとき、あなたは無限を聞いている。"
  },
  Task_10733_Name = {
    Text = "調査任務：古い巻物"
  },
  Task_10733_UnlockCondDesc = {
    Text = "調査 1-13 を完了する"
  },
  Task_10734_Desc = {
    Text = "金券捜索を600回クリア"
  },
  Task_10734_Name = {
    Text = "金の発掘者Ⅴ"
  },
  Task_10735_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10735_Name = {Text = "速攻"},
  Task_10736_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_10736_Desc = {
    Text = "厳密に言えば、覚醒体もシルバーコアテクノロジーの一種だ。\n全力を尽くして彼らが遅れないようにする必要がある。"
  },
  Task_10736_Name = {
    Text = "研究任務：製剤作成"
  },
  Task_10737_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10737_Name = {
    Text = "完璧な通過"
  },
  Task_10738_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10738_Name = {Text = "速攻"},
  Task_10739_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10739_Name = {
    Text = "完璧な通過"
  },
  Task_10740_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10740_Name = {
    Text = "完璧な通過"
  },
  Task_10741_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10742_Desc = {
    Text = "クリア時に遺物が2個以上"
  },
  Task_10742_Name = {
    Text = "遺物の力"
  },
  Task_10743_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10743_Name = {
    Text = "混沌こそ成長"
  },
  Task_10744_Desc = {
    Text = "最大5回の戦闘でクリア"
  },
  Task_10744_Name = {
    Text = "精密突破"
  },
  Task_10745_Desc = {
    Text = "クリア時の症状が3枚以下"
  },
  Task_10745_Name = {Text = "爽快"},
  Task_10746_Desc = {
    Text = "クリア時に最低黒章を100個所持"
  },
  Task_10746_Name = {
    Text = "次の機会に使いたい"
  },
  Task_10747_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10747_Name = {
    Text = "混沌こそ成長"
  },
  Task_10748_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_10748_Name = {
    Text = "最終降臨"
  },
  Task_10749_Desc = {
    Text = "クリア時に遺物が4個以上"
  },
  Task_10749_Name = {
    Text = "遺物の力"
  },
  Task_10750_Desc = {
    Text = "ステージをクリア"
  },
  Task_10750_Name = {
    Text = "ステージをクリア"
  },
  Task_10751_Desc = {
    Text = "88ターン以内にクリア"
  },
  Task_10751_Name = {
    Text = "88ターン以内にクリア"
  },
  Task_10752_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10752_Name = {Text = "速攻"},
  Task_10753_Desc = {
    Text = "調査「@1@2」で3回共鳴する"
  },
  Task_10753_Desc2 = {
    Text = "調査「蝋人形の名において」で3回共鳴する"
  },
  Task_10753_Name2 = {
    Text = "痙攣の残響"
  },
  Task_10754_Desc = {
    Text = "調査「@1@2」で6回共鳴する"
  },
  Task_10754_Desc2 = {
    Text = "調査「蝋人形の名において」で6回共鳴する"
  },
  Task_10754_Name2 = {
    Text = "痙攣の残響Ⅱ"
  },
  Task_10755_Desc = {
    Text = "調査「@1の@2において」で8回共鳴する"
  },
  Task_10755_Desc2 = {
    Text = "調査「蝋人形の名において」で8回共鳴する"
  },
  Task_10755_Name2 = {
    Text = "痙攣の残響Ⅲ"
  },
  Task_10756_Desc = {
    Text = "調査「@1@2」で3回共鳴する"
  },
  Task_10756_Desc2 = {
    Text = "調査「猛犬注意」で3回共鳴する"
  },
  Task_10756_Name2 = {
    Text = "忍耐の残響"
  },
  Task_10757_Desc = {
    Text = "調査「@1@2」で6回共鳴する"
  },
  Task_10757_Desc2 = {
    Text = "調査「猛犬注意」で6回共鳴する"
  },
  Task_10757_Name2 = {
    Text = "忍耐の残響Ⅱ"
  },
  Task_10758_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10758_Name = {Text = "速攻"},
  Task_10759_Desc = {
    Text = "調査「@1犬@2意」で10回共鳴する"
  },
  Task_10759_Desc2 = {
    Text = "調査「猛犬注意」で10回共鳴する"
  },
  Task_10759_Name2 = {
    Text = "忍耐の残響Ⅳ"
  },
  Task_10760_Desc = {
    Text = "調査「@1@2」で3回共鳴する"
  },
  Task_10760_Desc2 = {
    Text = "調査「無音の中で」で3回共鳴する"
  },
  Task_10760_Name2 = {
    Text = "苦痛の残響"
  },
  Task_10761_Desc = {
    Text = "調査「@1@2」で6回共鳴する"
  },
  Task_10761_Desc2 = {
    Text = "調査「無音の中で」で6回共鳴する"
  },
  Task_10761_Name2 = {
    Text = "苦痛の残響Ⅱ"
  },
  Task_10762_Desc = {
    Text = "調査「@1の@2で」で8回共鳴する"
  },
  Task_10762_Desc2 = {
    Text = "調査「無音の中で」で8回共鳴する"
  },
  Task_10762_Name2 = {
    Text = "苦痛の残響Ⅲ"
  },
  Task_10763_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10763_Name = {Text = "速攻"},
  Task_10764_Desc = {
    Text = "深海の遺産を1回クリア"
  },
  Task_10764_Name = {
    Text = "塔登り-深海"
  },
  Task_10765_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_10765_Name = {Text = "速攻"},
  Task_10766_Desc = {
    Text = "ステージをクリア"
  },
  Task_10766_Name = {
    Text = "ステージをクリア"
  },
  Task_10767_Desc = {
    Text = "ステージをクリア"
  },
  Task_10767_Name = {
    Text = "ステージをクリア"
  },
  Task_10768_Desc = {
    Text = "レベル10の超次元覚醒体を4体所持する"
  },
  Task_10768_Name = {
    Text = "超次元の主"
  },
  Task_10769_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10770_Desc = {
    Text = "この章の全任務を完了後に受け取る"
  },
  Task_10770_Name = {
    Text = "界域知識Ⅴ"
  },
  Task_10771_Desc = {
    Text = "混沌の領域を1回クリア"
  },
  Task_10771_Name = {
    Text = "塔登り-混沌"
  },
  Task_10772_Desc = {
    Text = "超次元の旅を1回クリア"
  },
  Task_10772_Name = {
    Text = "塔登り-超次元"
  },
  Task_10773_Desc = {
    Text = "血肉の沼を1回クリア"
  },
  Task_10773_Name = {
    Text = "塔登り-血肉"
  },
  Task_10774_Desc = {
    Text = "融災禁区を1回クリア（特訓値30に到達）"
  },
  Task_10774_Name = {
    Text = "融災禁区"
  },
  Task_10775_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10775_Name = {
    Text = "完璧な通過"
  },
  Task_10776_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10776_Name = {
    Text = "完璧な通過"
  },
  Task_10777_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10777_Name = {
    Text = "完璧な通過"
  },
  Task_10778_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10778_Name = {
    Text = "完璧な通過"
  },
  Task_10779_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10779_Name = {
    Text = "完璧な通過"
  },
  Task_10780_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10780_Name = {
    Text = "完璧な通過"
  },
  Task_10781_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10781_Name = {
    Text = "完璧な通過"
  },
  Task_10782_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10782_Name = {
    Text = "完璧な通過"
  },
  Task_10783_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10783_Name = {
    Text = "完璧な通過"
  },
  Task_10784_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10784_Name = {
    Text = "完璧な通過"
  },
  Task_10785_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10785_Name = {
    Text = "完璧な通過"
  },
  Task_10786_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10786_Name = {
    Text = "完璧な通過"
  },
  Task_10787_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_10787_Desc = {
    Text = "輝くものは必ずしも金ではないが、必ず高価である。\n伝説によると、ミサゴは一群の孤立した錬金術師によって設立され、彼らの野心は金を作ることにとどまらなかった。"
  },
  Task_10787_Name = {
    Text = "研究任務：錬金記録"
  },
  Task_10789_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10789_Name = {
    Text = "完璧な通過"
  },
  Task_10790_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10790_Name = {
    Text = "完璧な通過"
  },
  Task_10791_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10791_Name = {
    Text = "完璧な通過"
  },
  Task_10792_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10792_Name = {
    Text = "完璧な通過"
  },
  Task_10793_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10793_Name = {
    Text = "完璧な通過"
  },
  Task_10794_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10794_Name = {
    Text = "完璧な通過"
  },
  Task_10795_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10795_Name = {
    Text = "完璧な通過"
  },
  Task_10796_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10796_Name = {
    Text = "完璧な通過"
  },
  Task_10797_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10797_Name = {
    Text = "混沌こそ成長"
  },
  Task_10798_Desc = {
    Text = "敵に毒を2000回重ねる"
  },
  Task_10798_Name = {
    Text = "毒理学専門家Ⅲ"
  },
  Task_10799_Desc = {
    Text = "敵に毒を1000回重ねる"
  },
  Task_10799_Name = {
    Text = "毒理学専門家Ⅱ"
  },
  Task_10800_Desc = {
    Text = "反撃で4人の敵を倒し、勝利する"
  },
  Task_10800_Name = {
    Text = "正当防衛"
  },
  Task_10801_Desc = {
    Text = "敵に毒を5000回重ねる"
  },
  Task_10801_Name = {
    Text = "毒理学専門家Ⅳ"
  },
  Task_10802_Desc = {
    Text = "ステージクリア時にデッキに30枚のカードを所持"
  },
  Task_10802_Name = {
    Text = "カードコレクター"
  },
  Task_10803_Desc = {
    Text = "クリティカルダメージで6体の敵を倒して勝利する"
  },
  Task_10803_Name = {
    Text = "突然の暴虐"
  },
  Task_10804_Desc = {
    Text = "1戦闘で30枚の手札を捨て、勝利する"
  },
  Task_10804_Name = {Text = "傲慢"},
  Task_10805_Desc = {
    Text = "ステージクリア時にデッキに8枚の症状カードを所持"
  },
  Task_10805_Name = {Text = "不運"},
  Task_10806_Desc = {
    Text = "1ターンで10の行動力を消費し、勝利する"
  },
  Task_10806_Name = {
    Text = "完璧な計算"
  },
  Task_10807_Desc = {
    Text = "任意のステージクリア時に7つの遺物を所持"
  },
  Task_10807_Name = {
    Text = "遺物コレクター"
  },
  Task_10808_Desc = {
    Text = "任意の覚醒体スキルをレベル5にする"
  },
  Task_10808_Name = {Text = "任務2"},
  Task_10809_Desc = {
    Text = "任意の混沌界域の覚醒体の昇格レベルを4にする"
  },
  Task_10809_Name = {
    Text = "混沌の知識Ⅳ"
  },
  Task_10810_Desc = {
    Text = "密約転写を10回行う"
  },
  Task_10810_Name = {Text = "任務4"},
  Task_10811_Desc = {
    Text = "混沌の領域・隙間Ⅷをクリア"
  },
  Task_10811_Name = {Text = "任務5"},
  Task_10812_Desc = {
    Text = "任意の超次元界域の覚醒体の昇格レベルを4にする"
  },
  Task_10812_Name = {
    Text = "超次元の知識Ⅳ"
  },
  Task_10814_Desc = {
    Text = "ステージをクリア"
  },
  Task_10814_Name = {
    Text = "ステージをクリア"
  },
  Task_10815_Desc = {
    Text = "クリア時に最大6枚の刻印カードを所持"
  },
  Task_10817_Desc = {
    Text = "薬剤収集を50回クリア"
  },
  Task_10817_Name = {
    Text = "天才薬師"
  },
  Task_10818_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10818_Name = {
    Text = "完璧な通過"
  },
  Task_10819_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10819_Name = {
    Text = "完璧な通過"
  },
  Task_10820_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10820_Name = {
    Text = "完璧な通過"
  },
  Task_10821_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10821_Name = {
    Text = "完璧な通過"
  },
  Task_10822_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10822_Name = {
    Text = "完璧な通過"
  },
  Task_10823_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10823_Name = {
    Text = "完璧な通過"
  },
  Task_10824_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10824_Name = {
    Text = "完璧な通過"
  },
  Task_10825_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10825_Name = {Text = "速攻"},
  Task_10826_Desc = {
    Text = "ステージをクリア"
  },
  Task_10826_Name = {
    Text = "ステージをクリア"
  },
  Task_10827_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10827_Name = {
    Text = "完璧な通過"
  },
  Task_10828_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10828_Name = {Text = "速攻"},
  Task_10830_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10830_Name = {
    Text = "完璧な通過"
  },
  Task_10831_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10831_Name = {
    Text = "完璧な通過"
  },
  Task_10832_Desc = {
    Text = "ステージをクリア"
  },
  Task_10832_Name = {
    Text = "ステージをクリア"
  },
  Task_10833_Desc = {
    Text = "ステージをクリア"
  },
  Task_10833_Name = {
    Text = "ステージをクリア"
  },
  Task_10834_Desc = {
    Text = "クリア時に最低10枚の刻印カードを所持"
  },
  Task_10834_Name = {
    Text = "刻印の力"
  },
  Task_10835_Desc = {
    Text = "ステージをクリア"
  },
  Task_10835_Name = {
    Text = "ステージをクリア"
  },
  Task_10836_Desc = {
    Text = "最終戦で20ターン以内に勝利"
  },
  Task_10836_Name = {
    Text = "最終戦で20ターン以内に勝利"
  },
  Task_10839_Desc = {
    Text = "50歩以内でクリア"
  },
  Task_10839_Name = {Text = "戦略"},
  Task_10840_Desc = {
    Text = "43ターン以内にクリア"
  },
  Task_10840_Name = {
    Text = "43ターン以内にクリア"
  },
  Task_10842_Desc = {
    Text = "調査「猛犬注意」高難度を完了する"
  },
  Task_10842_Name = {
    Text = "倫理なき芸術家"
  },
  Task_10844_Desc = {
    Text = "任意の深海界域の覚醒体の昇格レベルを2にする"
  },
  Task_10844_Name = {
    Text = "深海の知識Ⅱ"
  },
  Task_10845_Desc = {
    Text = "ステージをクリア"
  },
  Task_10845_Name = {
    Text = "ステージをクリア"
  },
  Task_10848_Desc = {
    Text = "24歩以内でクリア"
  },
  Task_10848_Name = {Text = "戦略"},
  Task_10852_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10852_Name = {
    Text = "完璧な通過"
  },
  Task_10853_Desc = {
    Text = "ステージをクリア"
  },
  Task_10853_Name = {
    Text = "ステージをクリア"
  },
  Task_10854_Desc = {
    Text = "ステージをクリア"
  },
  Task_10854_Name = {
    Text = "ステージをクリア"
  },
  Task_10855_Desc = {
    Text = "ステージをクリア"
  },
  Task_10855_Name = {
    Text = "ステージをクリア"
  },
  Task_10857_Desc = {
    Text = "ステージをクリア"
  },
  Task_10857_Name = {
    Text = "ステージをクリア"
  },
  Task_10858_Desc = {
    Text = "ステージをクリア"
  },
  Task_10858_Name = {
    Text = "ステージをクリア"
  },
  Task_10859_Desc = {
    Text = "ステージをクリア"
  },
  Task_10859_Name = {
    Text = "ステージをクリア"
  },
  Task_10860_Desc = {
    Text = "ステージをクリア"
  },
  Task_10860_Name = {
    Text = "ステージをクリア"
  },
  Task_10861_Desc = {
    Text = "ステージをクリア"
  },
  Task_10861_Name = {
    Text = "ステージをクリア"
  },
  Task_10862_Desc = {
    Text = "ステージをクリア"
  },
  Task_10862_Name = {
    Text = "ステージをクリア"
  },
  Task_10863_Desc = {
    Text = "ステージをクリア"
  },
  Task_10863_Name = {
    Text = "ステージをクリア"
  },
  Task_10864_Desc = {
    Text = "ステージをクリア"
  },
  Task_10864_Name = {
    Text = "ステージをクリア"
  },
  Task_10865_Desc = {
    Text = "累計100回召喚儀式を行う"
  },
  Task_10865_Name = {
    Text = "カードを引く"
  },
  Task_10866_Desc = {
    Text = "ステージをクリア"
  },
  Task_10866_Name = {
    Text = "ステージをクリア"
  },
  Task_10867_Desc = {
    Text = "ステージをクリア"
  },
  Task_10867_Name = {
    Text = "ステージをクリア"
  },
  Task_10868_Desc = {
    Text = "ステージをクリア"
  },
  Task_10868_Name = {
    Text = "ステージをクリア"
  },
  Task_10869_Desc = {
    Text = "全戦闘で狂気解放回数が4回以下でクリア"
  },
  Task_10869_Name = {
    Text = "冷静で優雅"
  },
  Task_10870_Desc = {
    Text = "覚醒体スキルを100回昇級"
  },
  Task_10870_Name = {
    Text = "技術磨きⅣ"
  },
  Task_10871_Desc = {
    Text = "覚醒体スキルを200回昇級"
  },
  Task_10871_Name = {
    Text = "技術磨きⅤ"
  },
  Task_10872_Desc = {
    Text = "レベル60の超次元覚醒体を4体所持する"
  },
  Task_10872_Name = {
    Text = "超次元の主Ⅵ"
  },
  Task_10873_Desc = {
    Text = "覚醒体スキルを10回昇級"
  },
  Task_10873_Name = {
    Text = "技術磨き"
  },
  Task_10874_Desc = {
    Text = "覚醒体スキルを20回昇級"
  },
  Task_10874_Name = {
    Text = "技術磨きⅡ"
  },
  Task_10875_Desc = {
    Text = "覚醒体スキルを50回昇級"
  },
  Task_10875_Name = {
    Text = "技術磨きⅢ"
  },
  Task_10876_Desc = {
    Text = "レベル20の超次元覚醒体を4体所持する"
  },
  Task_10876_Name = {
    Text = "超次元の主Ⅱ"
  },
  Task_10877_Desc = {
    Text = "レベル30の超次元覚醒体を4体所持する"
  },
  Task_10877_Name = {
    Text = "超次元の主Ⅲ"
  },
  Task_10878_Desc = {
    Text = "レベル40の超次元覚醒体を4体所持する"
  },
  Task_10878_Name = {
    Text = "超次元の主Ⅳ"
  },
  Task_10879_Desc = {
    Text = "レベル50の超次元覚醒体を4体所持する"
  },
  Task_10879_Name = {
    Text = "超次元の主Ⅴ"
  },
  Task_10880_Desc = {
    Text = "メイン調査・高難度2-11を完了する"
  },
  Task_10880_Name = {Text = "任務3"},
  Task_10881_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10882_Desc = {
    Text = "35歩以内でクリア"
  },
  Task_10882_Name = {Text = "戦略"},
  Task_10883_Desc = {
    Text = "この章の全任務を完了後に受け取る"
  },
  Task_10883_Name = {
    Text = "界域知識Ⅱ"
  },
  Task_10884_Desc = {
    Text = "クリア時に最低8枚の刻印カードを所持"
  },
  Task_10884_Name = {
    Text = "刻印の力"
  },
  Task_10885_Desc = {
    Text = "混沌覚醒体最低2体でクリア"
  },
  Task_10885_Name = {
    Text = "混沌こそ成長"
  },
  Task_10886_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10887_Desc = {
    Text = "最初の戦闘をクリア、子供たちを排除、自分の物を取り戻す"
  },
  Task_10887_Name = {
    Text = "最初の戦闘をクリア"
  },
  Task_10888_Desc = {
    Text = "40歩以内でクリア"
  },
  Task_10888_Name = {Text = "戦略"},
  Task_10889_Desc = {
    Text = "クリア時に最大6枚の刻印カードを所持"
  },
  Task_10890_Desc = {
    Text = "クリア時に最低10枚の刻印カードを所持"
  },
  Task_10890_Name = {
    Text = "刻印の力"
  },
  Task_10892_Desc = {
    Text = "28歩以内でクリア"
  },
  Task_10892_Name = {Text = "戦略"},
  Task_10893_Desc = {
    Text = "ステージをクリア"
  },
  Task_10893_Name = {
    Text = "ステージをクリア"
  },
  Task_10894_Desc = {
    Text = "ステージをクリア"
  },
  Task_10894_Name = {
    Text = "ステージをクリア"
  },
  Task_10895_Desc = {
    Text = "ステージをクリア"
  },
  Task_10895_Name = {
    Text = "ステージをクリア"
  },
  Task_10896_Desc = {
    Text = "ステージをクリア"
  },
  Task_10896_Name = {
    Text = "ステージをクリア"
  },
  Task_10897_Desc = {
    Text = "ステージをクリア"
  },
  Task_10897_Name = {
    Text = "ステージをクリア"
  },
  Task_10898_Desc = {
    Text = "ステージをクリア"
  },
  Task_10898_Name = {
    Text = "ステージをクリア"
  },
  Task_10899_Desc = {
    Text = "ステージをクリア"
  },
  Task_10899_Name = {
    Text = "ステージをクリア"
  },
  Task_10900_Desc = {
    Text = "クリア時に1%の死亡抵抗ごとに1ポイント、最大600ポイント"
  },
  Task_10900_Name = {
    Text = "熟練 <size=20><color=#747474>クリア時に1%死亡抵抗ごとに1ポイント、最大600点</color></size>"
  },
  Task_10901_Desc = {
    Text = "ステージをクリア"
  },
  Task_10901_Name = {
    Text = "ステージをクリア"
  },
  Task_10902_Desc = {
    Text = "ステージをクリア"
  },
  Task_10902_Name = {
    Text = "ステージをクリア"
  },
  Task_10904_Desc = {
    Text = "最終戦で8ターン以内に勝利"
  },
  Task_10904_Name = {Text = "速攻"},
  Task_10905_Desc = {
    Text = "地下蝋人形との戦闘"
  },
  Task_10905_Name = {Text = "目標"},
  Task_10906_Desc = {
    Text = "クリア時の症状が3枚以下"
  },
  Task_10906_Name = {Text = "爽快"},
  Task_10907_Desc = {
    Text = "最大7回の戦闘でクリア"
  },
  Task_10907_Name = {
    Text = "精密突破"
  },
  Task_10908_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10908_Name = {
    Text = "完璧な通過"
  },
  Task_10909_Desc = {
    Text = "守秘者がレベル15に到達"
  },
  Task_10909_Name = {
    Text = "守秘者の試練Ⅱ"
  },
  Task_10910_Desc = {
    Text = "調査「東区の秘め事」で8回共鳴する"
  },
  Task_10910_Name = {
    Text = "感謝の残響Ⅲ"
  },
  Task_10911_Desc = {
    Text = "調査「東区の秘め事」で6回共鳴する"
  },
  Task_10911_Name = {
    Text = "感謝の残響Ⅱ"
  },
  Task_10912_Desc = {
    Text = "任意の血肉界域の覚醒体の昇格レベルを2にする"
  },
  Task_10912_Name = {
    Text = "血肉の知識Ⅱ"
  },
  Task_10913_Desc = {
    Text = "チューチュー、チューチュー……！！"
  },
  Task_10913_Name = {
    Text = "チューチュー"
  },
  Task_10914_Desc = {
    Text = "館長室へ"
  },
  Task_10914_Name = {Text = "目標"},
  Task_10915_Desc = {
    Text = "12名の覚醒体との同調率がレベル5に到達"
  },
  Task_10915_Name = {Text = "相棒Ⅵ"},
  Task_10916_Desc = {
    Text = "調査「東区の秘め事」を完了する"
  },
  Task_10916_Name = {
    Text = "金色のキャンディ包装紙"
  },
  Task_10917_Desc = {
    Text = "16名の覚醒体との同調率がレベル5に到達"
  },
  Task_10917_Name = {Text = "相棒Ⅷ"},
  Task_10918_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_10918_Desc2 = {
    Text = "調査「猛犬注意」を完了する"
  },
  Task_10918_Name2 = {
    Text = "次元を超越する目"
  },
  Task_10919_Desc = {
    Text = "ステージをクリア"
  },
  Task_10919_Name = {
    Text = "ステージをクリア"
  },
  Task_10920_Desc = {
    Text = "ステージをクリア"
  },
  Task_10920_Name = {
    Text = "ステージをクリア"
  },
  Task_10921_Desc = {
    Text = "ステージをクリア"
  },
  Task_10921_Name = {
    Text = "ステージをクリア"
  },
  Task_10922_Desc = {
    Text = "ポナペの廃墟を200回クリア"
  },
  Task_10922_Name = {
    Text = "ポナペの祝福Ⅲ"
  },
  Task_10923_Desc = {
    Text = "ポナペの廃墟を100回クリア"
  },
  Task_10923_Name = {
    Text = "ポナペの祝福Ⅱ"
  },
  Task_10924_Desc = {
    Text = "混沌地帯を400回クリア"
  },
  Task_10924_Name = {
    Text = "群集論者Ⅳ"
  },
  Task_10925_Desc = {
    Text = "混沌地帯を200回クリア"
  },
  Task_10925_Name = {
    Text = "群集論者Ⅲ"
  },
  Task_10926_Desc = {
    Text = "ポナペの廃墟を50回クリア"
  },
  Task_10926_Name = {
    Text = "ポナペの祝福"
  },
  Task_10927_Desc = {
    Text = "混沌地帯を600回クリア"
  },
  Task_10927_Name = {
    Text = "群集論者Ⅴ"
  },
  Task_10928_Desc = {
    Text = "次元の残像調査を240回クリア"
  },
  Task_10928_Name = {
    Text = "超次元の虚Ⅴ"
  },
  Task_10929_Desc = {
    Text = "次元の残像調査を120回クリア"
  },
  Task_10929_Name = {
    Text = "超次元の虚Ⅳ"
  },
  Task_10931_Desc = {
    Text = "混沌地帯を50回クリア"
  },
  Task_10931_Name = {
    Text = "群集論者"
  },
  Task_10932_Desc = {
    Text = "黒章を累計 2500 消費"
  },
  Task_10932_Name = {
    Text = "黒い召喚Ⅳ"
  },
  Task_10933_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10933_Name = {
    Text = "完璧な通過"
  },
  Task_10934_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_10934_Desc = {
    Text = "すべての生命は最終的に海に戻る。\n止まらない時間の流れのように、それは終わりの始まりだ。"
  },
  Task_10934_Name = {
    Text = "研究任務：碧藍詩篇"
  },
  Task_10934_UnlockCondDesc = {
    Text = "守秘者 25 レベルで解放"
  },
  Task_10935_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10935_Name = {
    Text = "完璧な通過"
  },
  Task_10936_Desc = {
    Text = "毎試合60ポイント"
  },
  Task_10936_Name = {
    Text = "精鋭を倒す <size=20><color=#747474>各60ポイント</color></size>"
  },
  Task_10938_Desc = {
    Text = "レベル12の密約を18個所持する"
  },
  Task_10938_Name = {
    Text = "密約コレクターⅢ"
  },
  Task_10941_Desc = {
    Text = "クリア時に任意の覚醒体のカードが1枚以下で100点獲得する"
  },
  Task_10941_Name = {
    Text = "無視された<size=20><color=#747474>クリア時に1体の覚醒体のカード総数が1枚以下</color></size>"
  },
  Task_10944_Desc = {
    Text = "レベル20の深海覚醒体を4体所持する"
  },
  Task_10944_Name = {
    Text = "深海の主Ⅱ"
  },
  Task_10946_Desc = {
    Text = "覚醒体を4体レベル50にする"
  },
  Task_10946_Name = {Text = "任務2"},
  Task_10947_Desc = {
    Text = "ステージをクリア"
  },
  Task_10947_Name = {
    Text = "目標1パッケージ文案待ち"
  },
  Task_10948_Desc = {
    Text = "精神病院を調査"
  },
  Task_10948_Name = {Text = "目標"},
  Task_10949_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_10949_Name = {Text = "爽快"},
  Task_10951_Desc = {
    Text = "クリア時に残り1%のライフごとに1点、最大100点"
  },
  Task_10951_Name = {
    Text = "残りライフ  <size=20><color=#747474>クリア時に残りライフ1%ごとに1点、最大100点</color></size>"
  },
  Task_10953_Desc = {
    Text = "調査メイン第2章\n「蝋人形の名において」高難度を完了"
  },
  Task_10954_Desc = {
    Text = "怒れる子供たちを「なだめる」"
  },
  Task_10954_Name = {Text = "目標"},
  Task_10955_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10955_Name = {Text = "速攻"},
  Task_10956_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_10956_Name = {Text = "速攻"},
  Task_10957_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_10957_Name = {Text = "速攻"},
  Task_10958_Desc = {
    Text = "ステージをクリア"
  },
  Task_10958_Name = {
    Text = "ステージをクリア"
  },
  Task_10959_Desc = {
    Text = "クリア 無光の境地Ⅲ(未完了)"
  },
  Task_10962_Desc = {
    Text = "ステージをクリア"
  },
  Task_10962_Name = {
    Text = "ステージをクリア"
  },
  Task_10963_Desc = {
    Text = "35歩以内でクリア"
  },
  Task_10963_Name = {Text = "戦略"},
  Task_10964_Desc = {
    Text = "ステージをクリア"
  },
  Task_10964_Name = {
    Text = "目標提示は最大8文字"
  },
  Task_10965_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_10965_Name = {Text = "速攻"},
  Task_10966_Desc = {
    Text = "40歩以内でクリア"
  },
  Task_10966_Name = {Text = "戦略"},
  Task_10969_Desc = {
    Text = "クリア時のライフが80%以上"
  },
  Task_10970_Desc = {
    Text = "任意の深海界域の覚醒体の昇格レベルを4にする"
  },
  Task_10970_Name = {
    Text = "深海の知識Ⅳ"
  },
  Task_10971_Desc = {
    Text = "最終戦で8ターン以内に勝利"
  },
  Task_10971_Name = {Text = "速攻"},
  Task_10972_Desc = {
    Text = "任意の血肉界域の覚醒体の昇格レベルを4にする"
  },
  Task_10972_Name = {
    Text = "血肉の知識Ⅳ"
  },
  Task_10973_Desc = {
    Text = "最大7回の戦闘でクリア"
  },
  Task_10973_Name = {
    Text = "精密突破"
  },
  Task_10974_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10974_Name = {
    Text = "完璧な通過"
  },
  Task_10975_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_10975_Desc = {
    Text = "「それはあなたの心を写し取る」\n「そうか、それならきっとボロボロだろうね」"
  },
  Task_10975_Name = {
    Text = "調査任務：映像療法"
  },
  Task_10975_UnlockCondDesc = {
    Text = "調査 1-13 を完了する"
  },
  Task_10976_Desc = {
    Text = "メイン調査・高難度4-12を完了する"
  },
  Task_10976_Name = {Text = "任務3"},
  Task_10977_Desc = {
    Text = "26ターン以内にクリア"
  },
  Task_10977_Name = {
    Text = "26ターン以内にクリア"
  },
  Task_10981_Desc = {
    Text = "最終戦で5ターン以内に勝利"
  },
  Task_10981_Name = {
    Text = "最終戦で5ターン以内に勝利"
  },
  Task_10982_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10982_Name = {
    Text = "完璧な通過"
  },
  Task_10983_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10983_Name = {
    Text = "完璧な通過"
  },
  Task_10984_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10984_Name = {
    Text = "完璧な通過"
  },
  Task_10985_Desc = {
    Text = "血肉の残像調査を60回クリア"
  },
  Task_10985_Name = {
    Text = "血肉の虚Ⅲ"
  },
  Task_10986_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10986_Name = {
    Text = "完璧な通過"
  },
  Task_10987_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_10987_Name = {
    Text = "完璧な通過"
  },
  Task_10988_Desc = {
    Text = "ステージをクリア"
  },
  Task_10988_Name = {
    Text = "ステージをクリア"
  },
  Task_10989_Desc = {
    Text = "ステージをクリア"
  },
  Task_10989_Name = {
    Text = "ステージをクリア"
  },
  Task_10991_Desc = {
    Text = "ステージをクリア"
  },
  Task_10991_Name = {
    Text = "ステージをクリア"
  },
  Task_10992_Desc = {
    Text = "ステージをクリア"
  },
  Task_10992_Name = {
    Text = "ステージをクリア"
  },
  Task_10993_Desc = {
    Text = "闇に潜むものに警戒"
  },
  Task_10993_Name = {Text = "目標"},
  Task_10994_Desc = {
    Text = "ステージをクリア"
  },
  Task_10994_Name = {
    Text = "ステージをクリア"
  },
  Task_10995_Desc = {
    Text = "ステージをクリア"
  },
  Task_10995_Name = {
    Text = "ステージをクリア"
  },
  Task_10997_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_10998_Desc = {
    Text = "最大7回の戦闘でクリア"
  },
  Task_10998_Name = {
    Text = "精密突破"
  },
  Task_10999_Desc = {
    Text = "最終戦で7ターン以内に勝利"
  },
  Task_10999_Name = {Text = "速攻"},
  Task_11003_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_11003_Name = {Text = "爽快"},
  Task_11004_Desc = {
    Text = "ロータンを手助けして敵を追い詰める"
  },
  Task_11004_Name = {Text = "目標"},
  Task_11005_Desc = {
    Text = "海底の残像調査を120回クリア"
  },
  Task_11005_Name = {
    Text = "深海の虚Ⅳ"
  },
  Task_11006_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11006_Name = {
    Text = "完璧な通過"
  },
  Task_11007_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_11007_Desc2 = {
    Text = "調査「無音の中で」を完了する"
  },
  Task_11007_Name2 = {
    Text = "お母さん、痛くないよ"
  },
  Task_11008_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11008_Name = {
    Text = "完璧な通過"
  },
  Task_11009_Desc = {
    Text = "ステージをクリア"
  },
  Task_11009_Name = {
    Text = "ステージをクリア"
  },
  Task_11010_Desc = {
    Text = "黒章を累計 5000 消費"
  },
  Task_11010_Name = {
    Text = "黒い召喚Ⅴ"
  },
  Task_11011_Desc = {
    Text = "クリア時に残りライフが80%以上"
  },
  Task_11011_Name = {
    Text = "お茶の子さいさい"
  },
  Task_11012_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_11012_Name = {Text = "速攻"},
  Task_11013_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11013_Name = {
    Text = "完璧な通過"
  },
  Task_11014_Desc = {
    Text = "密約を3回強化"
  },
  Task_11014_Name = {
    Text = "時間テスト2（未使用する）"
  },
  Task_11015_Desc = {
    Text = "覚醒体を3回昇級"
  },
  Task_11015_Name = {
    Text = "時間テスト1（未使用する）"
  },
  Task_11016_Desc = {
    Text = "特定戦闘X（精鋭）で、特定状態毒（Y）を20回以上付与される"
  },
  Task_11016_Name = {
    Text = "依存性のある量"
  },
  Task_11017_Desc = {
    Text = "最終戦で1ターンに累計シールドが1500以上"
  },
  Task_11017_Name = {
    Text = "過剰防衛"
  },
  Task_11018_Desc = {
    Text = "黒章を累計 500 消費"
  },
  Task_11018_Name = {
    Text = "黒い召喚Ⅱ"
  },
  Task_11019_Desc = {
    Text = "レベル30の深海覚醒体を4体所持する"
  },
  Task_11019_Name = {
    Text = "深海の主Ⅲ"
  },
  Task_11020_Desc = {
    Text = "ステージをクリア"
  },
  Task_11020_Name = {
    Text = "ステージをクリア"
  },
  Task_11021_Desc = {
    Text = "レベル50の深海覚醒体を4体所持する"
  },
  Task_11021_Name = {
    Text = "深海の主Ⅴ"
  },
  Task_11022_Desc = {
    Text = "ステージをクリア"
  },
  Task_11022_Name = {
    Text = "ステージをクリア"
  },
  Task_11023_Desc = {
    Text = "レベル50の血肉覚醒体を4体所持する"
  },
  Task_11023_Name = {
    Text = "血肉の主Ⅴ"
  },
  Task_11024_Desc = {
    Text = "黒章を累計 250 消費"
  },
  Task_11024_Name = {
    Text = "黒い召喚"
  },
  Task_11025_Desc = {
    Text = "レベル10の深海覚醒体を4体所持する"
  },
  Task_11025_Name = {
    Text = "深海の主"
  },
  Task_11026_Desc = {
    Text = "レベル60の血肉覚醒体を4体所持する"
  },
  Task_11026_Name = {
    Text = "血肉の主Ⅵ"
  },
  Task_11027_Desc = {
    Text = "特定の戦闘Xで、1ターンに20枚以上のカードを使用する"
  },
  Task_11027_Name = {
    Text = "カードマスター"
  },
  Task_11029_Desc = {
    Text = "調査「@1の@2で」で10回共鳴する"
  },
  Task_11029_Desc2 = {
    Text = "調査「無音の中で」で10回共鳴する"
  },
  Task_11029_Name2 = {
    Text = "苦痛の残響Ⅳ"
  },
  Task_11030_Desc = {
    Text = "クリア時に最低8枚の刻印カードを所持"
  },
  Task_11030_Name = {
    Text = "刻印の力"
  },
  Task_11031_Desc = {
    Text = "ステージをクリア"
  },
  Task_11031_Name = {
    Text = "ステージをクリア"
  },
  Task_11032_Desc = {
    Text = "特定の戦闘Xで、1ターンに引くカードの数が5枚以上"
  },
  Task_11032_Name = {
    Text = "名医の偶然の発見"
  },
  Task_11033_Desc = {
    Text = "調査「蝋人形の名において」高難度を完了する"
  },
  Task_11033_Name = {
    Text = "蝋の迷宮・高難度"
  },
  Task_11034_Desc = {
    Text = "ダフォダイルを撃退"
  },
  Task_11034_Name = {Text = "目標"},
  Task_11035_Desc = {
    Text = "特定戦闘Xで、シールドが200以上（X精鋭戦）"
  },
  Task_11035_Name = {Text = "不屈"},
  Task_11036_Desc = {
    Text = "調査「東区の秘め事」高難度を完了する"
  },
  Task_11036_Name = {
    Text = "東区の霧・高難度"
  },
  Task_11038_Desc = {
    Text = "クリア時に触発される死亡抵抗の回数が1回以下"
  },
  Task_11038_Name = {
    Text = "死ぬ暇もない"
  },
  Task_11041_Desc = {
    Text = "最終戦で8ターン以内に勝利"
  },
  Task_11041_Name = {Text = "速攻"},
  Task_11042_Desc = {
    Text = "シレストを探す"
  },
  Task_11042_Name = {Text = "目標"},
  Task_11043_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11043_Name = {
    Text = "完璧な通過"
  },
  Task_11044_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11044_Name = {
    Text = "完璧な通過"
  },
  Task_11045_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11045_Name = {
    Text = "完璧な通過"
  },
  Task_11046_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11046_Name = {
    Text = "完璧な通過"
  },
  Task_11047_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11047_Name = {
    Text = "完璧な通過"
  },
  Task_11048_Desc = {
    Text = "禁忌編纂を100回クリア"
  },
  Task_11048_Name = {
    Text = "密約刻印師Ⅱ"
  },
  Task_11050_Desc = {
    Text = "ステージをクリア"
  },
  Task_11050_Name = {
    Text = "ステージをクリア"
  },
  Task_11052_Desc = {
    Text = "血肉の残像調査を240回クリア"
  },
  Task_11052_Name = {
    Text = "血肉の虚Ⅴ"
  },
  Task_11053_Desc = {
    Text = "最終戦で18ターン以内に勝利"
  },
  Task_11053_Name = {
    Text = "最終戦で18ターン以内に勝利"
  },
  Task_11054_Desc = {
    Text = "ハリエットの小屋を見学する"
  },
  Task_11054_Name = {Text = "目標"},
  Task_11057_Desc = {
    Text = "40歩以内でクリア"
  },
  Task_11057_Name = {Text = "戦略"},
  Task_11058_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_11058_Name = {Text = "爽快"},
  Task_11059_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_11059_Name = {Text = "速攻"},
  Task_11060_Desc = {
    Text = "混沌地帯を100回クリア"
  },
  Task_11060_Name = {
    Text = "群集論者Ⅱ"
  },
  Task_11061_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_11061_Name = {Text = "速攻"},
  Task_11062_Desc = {
    Text = "マーフィーを追う"
  },
  Task_11062_Name = {Text = "目標"},
  Task_11063_Desc = {
    Text = "音の源を見つける"
  },
  Task_11063_Name = {Text = "目標"},
  Task_11064_Desc = {
    Text = "ありがとう"
  },
  Task_11064_Name = {
    Text = "ありがとう、"
  },
  Task_11065_Desc = {
    Text = "ハリエットを撃退"
  },
  Task_11065_Name = {Text = "目標"},
  Task_11066_Desc = {
    Text = "忘れないでね。"
  },
  Task_11066_Name = {
    Text = "忘れないでね。"
  },
  Task_11067_Desc = {
    Text = "ありがとう、みんな……"
  },
  Task_11067_Name = {
    Text = "ありがとう、みんな……"
  },
  Task_11068_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_11068_Name = {Text = "速攻"},
  Task_11069_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11069_Name = {
    Text = "完璧な通過"
  },
  Task_11070_Desc = {
    Text = "16ターン以内にクリア"
  },
  Task_11070_Name = {
    Text = "16ターン以内にクリア"
  },
  Task_11071_Desc = {
    Text = "21ターン以内にクリア"
  },
  Task_11071_Name = {
    Text = "21ターン以内にクリア"
  },
  Task_11072_Desc = {
    Text = "11ターン以内にクリア"
  },
  Task_11072_Name = {
    Text = "11ターン以内にクリア"
  },
  Task_11073_Desc = {
    Text = "ステージをクリア"
  },
  Task_11073_Name = {
    Text = "ステージをクリア"
  },
  Task_11074_Desc = {
    Text = "ステージをクリア"
  },
  Task_11074_Name = {
    Text = "ステージをクリア"
  },
  Task_11075_Desc = {
    Text = "ステージをクリア"
  },
  Task_11075_Name = {
    Text = "ステージをクリア"
  },
  Task_11076_Desc = {
    Text = "31ターン以内にクリア"
  },
  Task_11076_Name = {
    Text = "31ターン以内にクリア"
  },
  Task_11077_Desc = {
    Text = "レベル50の混沌覚醒体を4体所持する"
  },
  Task_11077_Name = {
    Text = "混沌の主Ⅴ"
  },
  Task_11078_Desc = {
    Text = "レベル40の混沌覚醒体を4体所持する"
  },
  Task_11078_Name = {
    Text = "混沌の主Ⅳ"
  },
  Task_11079_Desc = {
    Text = "レベル10の血肉覚醒体を4体所持する"
  },
  Task_11079_Name = {
    Text = "血肉の主"
  },
  Task_11080_Desc = {
    Text = "レベル60の混沌覚醒体を4体所持する"
  },
  Task_11080_Name = {
    Text = "混沌の主Ⅵ"
  },
  Task_11081_Desc = {
    Text = "レベル10の混沌覚醒体を4体所持する"
  },
  Task_11081_Name = {
    Text = "混沌の主"
  },
  Task_11082_Desc = {
    Text = "レベル30の混沌覚醒体を4体所持する"
  },
  Task_11082_Name = {
    Text = "混沌の主Ⅲ"
  },
  Task_11083_Desc = {
    Text = "レベル20の混沌覚醒体を4体所持する"
  },
  Task_11083_Name = {
    Text = "混沌の主Ⅱ"
  },
  Task_11084_Desc = {
    Text = "戦闘中に4回の死亡抵抗が発動し、この戦で勝利する"
  },
  Task_11085_Desc = {
    Text = "1ターン内に触腕で敵を15回攻撃し、勝利する"
  },
  Task_11085_Name = {
    Text = "ルルイエの主"
  },
  Task_11086_Desc = {
    Text = "超次元ターン中に5回の跳躍を発動し、勝利する"
  },
  Task_11086_Name = {
    Text = "次元跳躍者"
  },
  Task_11087_Desc = {
    Text = "1ターン内に5つの胚胎を飲み込み、勝利する"
  },
  Task_11087_Name = {Text = "空腹"},
  Task_11088_Desc = {
    Text = "1ターン内に15枚のカードを出し、勝利する"
  },
  Task_11088_Name = {
    Text = "私のターン"
  },
  Task_11089_Desc = {
    Text = "1ターン内に6枚の症状カードを出し、勝利する"
  },
  Task_11089_Name = {Text = "重症者"},
  Task_11090_Desc = {
    Text = "1ターン内に10枚の攻撃カードを出し、勝利する"
  },
  Task_11090_Name = {
    Text = "無限の攻撃"
  },
  Task_11091_Desc = {
    Text = "戦闘勝利する時に手札、捨て札、山札に合計8枚以下のカードを保持する"
  },
  Task_11091_Name = {
    Text = "ポケットが空っぽ"
  },
  Task_11092_Desc = {
    Text = "「24」を追撃する"
  },
  Task_11092_Name = {Text = "目標"},
  Task_11094_Desc = {
    Text = "調査「猛犬注意」高難度を完了する"
  },
  Task_11094_Name = {
    Text = "次元の眼・高難度"
  },
  Task_11095_Desc = {
    Text = "薔薇金券を500000消費"
  },
  Task_11095_Name = {
    Text = "金を湯水のように使う"
  },
  Task_11096_Desc = {
    Text = "薔薇金券を1000000消費"
  },
  Task_11096_Name = {
    Text = "金を湯水のように使うⅡ"
  },
  Task_11097_Desc = {
    Text = "ボス戦に勝利するで1200ポイント獲得する"
  },
  Task_11097_Name = {
    Text = "ボス撃破 <size=20><color=#747474>ボス戦に勝利するで1200ポイント</color></size>"
  },
  Task_11098_Desc = {
    Text = "最終戦で9ターン以内に勝利"
  },
  Task_11098_Name = {
    Text = "最終戦で9ターン以内に勝利"
  },
  Task_11099_Desc = {
    Text = "主人の元に戻る"
  },
  Task_11099_Name = {Text = "目標"},
  Task_11100_Desc = {
    Text = "音の出所を探る"
  },
  Task_11100_Name = {Text = "目標"},
  Task_11101_Desc = {
    Text = "最終戦で8ターン以内に勝利"
  },
  Task_11101_Name = {Text = "速攻"},
  Task_11102_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11102_Name = {
    Text = "完璧な通過"
  },
  Task_11103_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11103_Name = {
    Text = "完璧な通過"
  },
  Task_11104_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_11104_Name = {Text = "速攻"},
  Task_11105_Desc = {
    Text = "ステージをクリア"
  },
  Task_11105_Name = {
    Text = "ステージをクリア"
  },
  Task_11106_Desc = {
    Text = "レベル30の血肉覚醒体を4体所持する"
  },
  Task_11106_Name = {
    Text = "血肉の主Ⅲ"
  },
  Task_11107_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11107_Name = {
    Text = "完璧な通過"
  },
  Task_11108_Desc = {
    Text = "蝋人形《春》を見つける"
  },
  Task_11108_Name = {Text = "目標"},
  Task_11109_Desc = {
    Text = "甲板を越える"
  },
  Task_11109_Name = {Text = "目標"},
  Task_11111_Desc = {
    Text = "ステージをクリア"
  },
  Task_11111_Name = {
    Text = "ステージをクリア"
  },
  Task_11112_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_11112_Name = {Text = "速攻"},
  Task_11113_Desc = {
    Text = "首狩りを追う"
  },
  Task_11113_Name = {Text = "目標"},
  Task_11114_Desc = {
    Text = "最終戦で8ターン以内に勝利"
  },
  Task_11114_Name = {
    Text = "最終戦で8ターン以内に勝利"
  },
  Task_11115_Desc = {
    Text = "58ターン以内にクリア"
  },
  Task_11115_Name = {
    Text = "58ターン以内にクリア"
  },
  Task_11116_Desc = {
    Text = "「日々の訓練」を1回完了する"
  },
  Task_11116_Name = {
    Text = "デイリーチャレンジ"
  },
  Task_11117_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11117_Name = {
    Text = "完璧な通過"
  },
  Task_11118_Desc = {
    Text = "ステージをクリア"
  },
  Task_11118_Name = {
    Text = "ステージをクリア"
  },
  Task_11119_Desc = {
    Text = "融蝕生物を撃破"
  },
  Task_11119_Name = {Text = "目標"},
  Task_11120_Desc = {
    Text = "ステージをクリア"
  },
  Task_11120_Name = {
    Text = "ステージをクリア"
  },
  Task_11121_Desc = {
    Text = "救命ボートに乗る"
  },
  Task_11121_Name = {Text = "目標"},
  Task_11122_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_11122_Name = {Text = "速攻"},
  Task_11123_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_11123_Name = {Text = "速攻"},
  Task_11124_Desc = {
    Text = "ステージをクリア"
  },
  Task_11124_Name = {
    Text = "ステージをクリア"
  },
  Task_11125_Desc = {
    Text = "この章の全任務を完了後に受け取る"
  },
  Task_11125_Name = {
    Text = "界域知識Ⅳ"
  },
  Task_11126_Desc = {
    Text = "薬剤収集を200回クリア"
  },
  Task_11126_Name = {
    Text = "天才薬師Ⅲ"
  },
  Task_11128_Desc = {
    Text = "復活の魂魄を使用するせずにクリア"
  },
  Task_11128_Name = {
    Text = "一命のクリア <size=20><color=#747474>復活の魂魄を使わずにクリア</color></size>"
  },
  Task_11129_Desc = {
    Text = "受付に戻り、パンディアを見つける"
  },
  Task_11129_Name = {Text = "目標"},
  Task_11130_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11130_Name = {
    Text = "完璧な通過"
  },
  Task_11135_Desc = {
    Text = "ミリアムから逃れる"
  },
  Task_11135_Name = {Text = "目標"},
  Task_11136_Desc = {
    Text = "累積で覚醒体のスキルを6回上げる"
  },
  Task_11136_Name = {Text = "任務4"},
  Task_11137_Desc = {
    Text = "任意の超越存在を1回クリア"
  },
  Task_11137_Name = {Text = "任務5"},
  Task_11138_Desc = {
    Text = "精錬室で材料合成を1回行う"
  },
  Task_11138_Name = {Text = "任務1"},
  Task_11139_Desc = {
    Text = "覚醒体を4体レベル30にする"
  },
  Task_11139_Name = {Text = "任務2"},
  Task_11140_Desc = {
    Text = "混沌の領域・隙間Ⅳをクリア"
  },
  Task_11140_Name = {Text = "任務3"},
  Task_11141_Desc = {
    Text = "39ターン以内にクリア"
  },
  Task_11141_Name = {
    Text = "39ターン以内にクリア"
  },
  Task_11142_Desc = {
    Text = "33ターン以内にクリア"
  },
  Task_11142_Name = {
    Text = "33ターン以内にクリア"
  },
  Task_11143_Desc = {
    Text = "54ターン以内にクリア"
  },
  Task_11143_Name = {
    Text = "54ターン以内にクリア"
  },
  Task_11144_Desc = {
    Text = "48ターン以内にクリア"
  },
  Task_11144_Name = {
    Text = "48ターン以内にクリア"
  },
  Task_11145_Desc = {
    Text = "14ターン以内にクリア"
  },
  Task_11145_Name = {
    Text = "14ターン以内にクリア"
  },
  Task_11146_Desc = {
    Text = "50歩以内でクリア"
  },
  Task_11146_Name = {Text = "戦略"},
  Task_11147_Desc = {
    Text = "26ターン以内にクリア"
  },
  Task_11147_Name = {
    Text = "26ターン以内にクリア"
  },
  Task_11148_Desc = {
    Text = "20ターン以内にクリア"
  },
  Task_11148_Name = {
    Text = "20ターン以内にクリア"
  },
  Task_11149_Desc = {
    Text = "ステージをクリア"
  },
  Task_11149_Name = {
    Text = "ステージをクリア"
  },
  Task_11150_Desc = {
    Text = "66ターン以内にクリア"
  },
  Task_11150_Name = {
    Text = "66ターン以内にクリア"
  },
  Task_11151_Desc = {
    Text = "60ターン以内にクリア"
  },
  Task_11151_Name = {
    Text = "60ターン以内にクリア"
  },
  Task_11152_Desc = {
    Text = "ステージ内の全任務を完了後に報酬を受け取り可能"
  },
  Task_11152_Name = {
    Text = "第六段階"
  },
  Task_11153_Desc = {
    Text = "この章の全任務を完了後に受け取る"
  },
  Task_11153_Name = {
    Text = "界域知識Ⅰ"
  },
  Task_11154_Desc = {
    Text = "ステージをクリア"
  },
  Task_11154_Name = {
    Text = "ステージをクリア"
  },
  Task_11155_Desc = {
    Text = "クリア時の症状が3枚以下"
  },
  Task_11155_Name = {Text = "爽快"},
  Task_11156_Desc = {
    Text = "調査メイン第1章\n「東区の秘め事」を完了"
  },
  Task_11157_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_11157_Name = {
    Text = "完璧な通過"
  },
  Task_116471_Desc = {
    Text = "深海界域の覚醒体を使用して「交融の苦血」で2回勝利"
  },
  Task_116472_Desc = {
    Text = "「風の托挙」の任意の難易度をクリアする"
  },
  Task_116473_Desc = {
    Text = "交融する苦血・通関"
  },
  Task_116474_Desc = {
    Text = "「双生羽翼」の狂気難易度をクリアする"
  },
  Task_116475_Desc = {
    Text = "「冒険童話」の任意の難易度をクリアする"
  },
  Task_116476_Desc = {
    Text = "異夢視界「天の彼方・下」をクリアする"
  },
  Task_116477_Desc = {
    Text = "超維界域の覚醒体を使用して「交融の苦血」で1回勝利"
  },
  Task_116478_Desc = {
    Text = "「忘却の毒」の任意の難易度をクリアする"
  },
  Task_116479_Desc = {
    Text = "「天真時代」の任意の難易度をクリアする"
  },
  Task_116480_Desc = {
    Text = "混沌界域の覚醒体を使用して「交融の苦血」で2回勝利"
  },
  Task_116481_Desc = {
    Text = "「交融の苦血·通関」すべての実績を完了しました"
  },
  Task_116482_Desc = {
    Text = "「天真時代」の狂気難易度をクリアする"
  },
  Task_116483_Desc = {
    Text = "「沈黙覚醒」の任意の難易度をクリアする"
  },
  Task_116484_Desc = {
    Text = "「旧帳本」の任意の難易度をクリアする"
  },
  Task_116485_Desc = {
    Text = "「旧帳本」の任意の難易度をクリアする"
  },
  Task_116486_Desc = {
    Text = "交融する苦血・癲狂"
  },
  Task_116487_Desc = {
    Text = "深海界域の覚醒体を使用して「交融の苦血」で1回勝利"
  },
  Task_116488_Desc = {
    Text = "交融する苦血・界域"
  },
  Task_116489_Desc = {
    Text = "「双生羽翼」の任意の難易度をクリアする"
  },
  Task_116490_Desc = {
    Text = "「忘却の毒」の任意の難易度をクリアする"
  },
  Task_116491_Desc = {
    Text = "「冒険童話」の狂気難易度をクリアする"
  },
  Task_116492_Desc = {
    Text = "「旧帳本」の狂気難易度をクリアする"
  },
  Task_116493_Desc = {
    Text = "「風の托挙」の任意の難易度をクリアする"
  },
  Task_116494_Desc = {
    Text = "「沈黙覚醒」の狂気難易度をクリアする"
  },
  Task_116495_Desc = {
    Text = "「冒険童話」の任意の難易度をクリアする"
  },
  Task_116496_Desc = {
    Text = "「天真時代」の任意の難易度をクリアする"
  },
  Task_116497_Desc = {
    Text = "「忘却の毒」の狂気難易度をクリアする"
  },
  Task_116498_Desc = {
    Text = "血肉界域の覚醒体を使用して「交融の苦血」で2回勝利"
  },
  Task_116499_Desc = {
    Text = "「風の托挙」の狂気難易度をクリアする"
  },
  Task_116500_Desc = {
    Text = "血肉界域の覚醒体を使用して「交融の苦血」で1回勝利"
  },
  Task_116501_Desc = {
    Text = "「双生羽翼」の任意の難易度をクリアする"
  },
  Task_116502_Desc = {
    Text = "「沈黙覚醒」の任意の難易度をクリアする"
  },
  Task_116503_Desc = {
    Text = "超維界域の覚醒体を使用して「交融の苦血」で2回勝利"
  },
  Task_116504_Desc = {
    Text = "混沌界域の覚醒体を使用して「交融の苦血」で1回勝利"
  },
  Task_116767_Desc = {
    Text = "波吕克斯の試遊関を1回クリアする"
  },
  Task_116768_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_116769_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_116770_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_116771_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_116772_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_116773_Desc = {
    Text = "「日々の訓練」を4回完了する"
  },
  Task_116774_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_116775_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_116776_Desc = {
    Text = "「日々の訓練」を4回完了する"
  },
  Task_116777_Desc = {
    Text = "エンフェリンを1500消費"
  },
  Task_116778_Desc = {
    Text = "エンフェリンを1500消費"
  },
  Task_116779_Desc = {
    Text = "30回覚醒"
  },
  Task_116780_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_116781_Desc = {
    Text = "30回覚醒"
  },
  Task_116782_Desc = {
    Text = "波吕克斯の試遊関を1回クリアする"
  },
  Task_116793_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_116793_Name = {Text = "3勝"},
  Task_116794_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_116794_Name = {Text = "1勝"},
  Task_116795_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_116795_Name = {Text = "6勝"},
  Task_116796_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_116796_Name = {Text = "10勝"},
  Task_116809_Desc = {
    Text = "異夢視界「さようなら、永遠の郷」を完了しました"
  },
  Task_116809_Name = {
    Text = "美夢の余韻"
  },
  Task_116810_Desc = {
    Text = "異夢視界「さようなら、永遠の郷」困難難易度を完了しました"
  },
  Task_116810_Name = {
    Text = "美夢の余韻・難易度"
  },
  Task_116820_Name = {
    Text = "BOSS3をN回撃破"
  },
  Task_116821_Name = {
    Text = "BOSS6をN回撃破"
  },
  Task_116822_Name = {
    Text = "すべてのBOSSを撃破"
  },
  Task_116823_Name = {
    Text = "BOSS5をN回撃破"
  },
  Task_116824_Name = {
    Text = "BOSS1をN回撃破"
  },
  Task_116825_Name = {
    Text = "BOSS4をN回撃破"
  },
  Task_116826_Name = {
    Text = "BOSS7をN回撃破"
  },
  Task_116827_Name = {
    Text = "BOSS2をN回撃破"
  },
  Task_116884_Desc = {
    Text = "累計ログイン 11 日"
  },
  Task_116885_Desc = {
    Text = "累計ログイン 13 日"
  },
  Task_116886_Desc = {
    Text = "累計ログイン 7 日"
  },
  Task_116887_Desc = {
    Text = "累計ログイン 9 日"
  },
  Task_116888_Desc = {
    Text = "累計ログイン 10 日"
  },
  Task_116890_Desc = {
    Text = "累計ログイン 8 日"
  },
  Task_116891_Desc = {
    Text = "累計ログイン 16 日"
  },
  Task_116892_Desc = {
    Text = "累計ログイン 15 日"
  },
  Task_116894_Desc = {
    Text = "累計ログイン 4 日"
  },
  Task_116895_Desc = {
    Text = "累計ログイン 5 日"
  },
  Task_116896_Desc = {
    Text = "累計ログイン 3 日"
  },
  Task_116897_Desc = {
    Text = "累計ログイン 6 日"
  },
  Task_116899_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_116900_Desc = {
    Text = "累計ログイン 14 日"
  },
  Task_116901_Desc = {
    Text = "累計ログイン 2 日"
  },
  Task_116903_Desc = {
    Text = "累計ログイン 12 日"
  },
  Task_117156_Desc = {
    Text = "深海界域の覚醒体を使用し「湖中の城」で1回勝利"
  },
  Task_117157_Desc = {
    Text = "血肉界域の覚醒体を使用し「湖中の城」で1回勝利"
  },
  Task_117158_Desc = {
    Text = "超次元界域の覚醒体を使用し「湖中の城」で1回勝利"
  },
  Task_117159_Desc = {
    Text = "混沌界域の覚醒体を使用し「湖中の城」で1回勝利"
  },
  Task_117304_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_117304_Name = {Text = "1勝"},
  Task_117305_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_117305_Name = {Text = "6勝"},
  Task_117306_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_117306_Name = {Text = "3勝"},
  Task_117307_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_117307_Name = {Text = "10勝"},
  Task_117487_Desc = {
    Text = "異夢視界「さよならネバーランド」の困難難易度をクリア"
  },
  Task_117487_Name = {
    Text = "決して諦めない ·難易度"
  },
  Task_117488_Desc = {
    Text = "異夢視界「さよならネバーランド」をクリア"
  },
  Task_117488_Name = {
    Text = "決して諦めない"
  },
  Task_117489_Desc = {
    Text = "異夢視界「天の彼方·下」をクリア"
  },
  Task_117489_Name = {
    Text = "青空の上"
  },
  Task_118481_Desc = {
    Text = "マーフィーを連れて行く"
  },
  Task_118481_Name = {Text = "目標"},
  Task_118482_Desc = {
    Text = "儀式の現場に侵入して墨菲を救出する"
  },
  Task_118482_Name = {Text = "目標"},
  Task_118483_Desc = {
    Text = "楽園に再入場"
  },
  Task_118483_Name = {Text = "目標"},
  Task_118484_Desc = {
    Text = "夢の幕を開ける"
  },
  Task_118484_Name = {Text = "目標"},
  Task_118485_Desc = {
    Text = "引航儀式の観察"
  },
  Task_118485_Name = {Text = "目標"},
  Task_118486_Desc = {
    Text = "飛んでくる魚を迎撃せよ"
  },
  Task_118486_Name = {Text = "目標"},
  Task_118487_Desc = {
    Text = "海行者の追撃を撃退"
  },
  Task_118487_Name = {Text = "目標"},
  Task_118488_Desc = {
    Text = "道の終わりに到達"
  },
  Task_118488_Name = {Text = "目標"},
  Task_118489_Desc = {
    Text = "自我を消滅させる"
  },
  Task_118489_Name = {Text = "目標"},
  Task_118490_Desc = {
    Text = "混乱の中でマーフィーを救出する"
  },
  Task_118490_Name = {Text = "目標"},
  Task_118787_Desc = {
    Text = "聖胎の詩"
  },
  Task_118791_Desc = {
    Text = "漆黒の鎖"
  },
  Task_118796_Desc = {
    Text = "砂海の遺跡"
  },
  Task_118799_Desc = {
    Text = "暗海の舟"
  },
  Task_118809_Desc = {
    Text = "荒砂の壁"
  },
  Task_118821_Desc = {
    Text = "蝋人形の秘密"
  },
  Task_118826_Desc = {
    Text = "混濁の残像"
  },
  Task_118835_Desc = {
    Text = "海底の残像"
  },
  Task_118837_Desc = {
    Text = "狂躁蝋人形館"
  },
  Task_118842_Desc = {
    Text = "金券捜索"
  },
  Task_118845_Desc = {
    Text = "嵐の外海"
  },
  Task_118852_Desc = {
    Text = "血肉の残像"
  },
  Task_118856_Desc = {
    Text = "錯乱の異郷"
  },
  Task_118860_Desc = {
    Text = "人形の涙"
  },
  Task_118871_Desc = {
    Text = "時空のくびれ"
  },
  Task_118873_Desc = {
    Text = "蠕虫の棲家"
  },
  Task_118877_Desc = {
    Text = "薬剤収集"
  },
  Task_118879_Desc = {
    Text = "混沌地帯"
  },
  Task_118881_Desc = {
    Text = "原初の裂け目"
  },
  Task_118892_Desc = {
    Text = "信仰の手"
  },
  Task_118907_Desc = {
    Text = "ポナペの廃墟"
  },
  Task_118913_Desc = {
    Text = "異界の影"
  },
  Task_118915_Desc = {
    Text = "昏き海の潮"
  },
  Task_118917_Desc = {
    Text = "次元の残像"
  },
  Task_118918_Desc = {
    Text = "失序山脈"
  },
  Task_118922_Desc = {
    Text = "怪霧の都"
  },
  Task_118979_Desc = {
    Text = "対戦・ドラフト"
  },
  Task_118980_Desc = {
    Text = "「<color=#ae6abb>知恵</color>」の覚醒体を使わずに20勝達成する"
  },
  Task_118981_Desc = {
    Text = "戦闘中にアイコンを選択して3人の対戦相手に「こんにちは」または「Hi」のスタンプを送る"
  },
  Task_118982_Desc = {
    Text = "プリセットモードで500ポイントに到達する"
  },
  Task_118983_Desc = {
    Text = "「<color=#76bf9d>祝福</color>」の覚醒体を使わずに20勝達成する"
  },
  Task_118984_Desc = {
    Text = "ドラフトモードで1000ポイントに到達する"
  },
  Task_118985_Desc = {
    Text = "ドラフトモードで2500ポイントに到達する"
  },
  Task_118986_Desc = {
    Text = "「対戦の啓蒙」の全ての記録を達成する"
  },
  Task_118987_Desc = {
    Text = "「<color=#6a97c2>守護</color>」の覚醒体を使わずに20勝達成する"
  },
  Task_118988_Desc = {
    Text = "対戦の啓蒙"
  },
  Task_118989_Desc = {
    Text = "「スタンプ」で16個のスタンプを一度に持って対戦に参加する"
  },
  Task_118990_Desc = {
    Text = "対戦終了後に相手の編成をコピーする"
  },
  Task_118991_Desc = {
    Text = "「ドラフトモード」に1回参加する"
  },
  Task_118992_Desc = {
    Text = "プリセットモードで2000ポイントに到達する"
  },
  Task_118993_Desc = {
    Text = "ドラフトモードで2000ポイントに到達する"
  },
  Task_118994_Desc = {
    Text = "ドラフトモードで500ポイントに到達する"
  },
  Task_118995_Desc = {
    Text = "対戦終了後、相手と「再戦」する"
  },
  Task_118996_Desc = {
    Text = "プリセットモードで1000ポイントに到達する"
  },
  Task_118997_Desc = {
    Text = "「<color=#c26669>闘争</color>」の覚醒体を使わずに20勝達成する"
  },
  Task_118998_Desc = {
    Text = "「コレクション」内のカードコメントに「いいね」する"
  },
  Task_118999_Desc = {
    Text = "「コレクション」内の「お試し戦闘」で覚醒体を試し、「お馴染みの黒猫」を1匹倒す"
  },
  Task_119000_Desc = {
    Text = "プリセットモードで3000ポイントに到達する"
  },
  Task_119001_Desc = {
    Text = "「プリセットモード」に1回参加する"
  },
  Task_119002_Desc = {
    Text = "プリセットモードで1500ポイントに到達する"
  },
  Task_119003_Desc = {
    Text = "ドラフトモードで3000ポイントに到達する"
  },
  Task_119004_Desc = {
    Text = "ドラフトモードで1500ポイントに到達する"
  },
  Task_119005_Desc = {
    Text = "対戦・プリセット"
  },
  Task_119006_Desc = {
    Text = "「守秘者のプロフィール」の「戦闘記録」で対人戦の「リプレイ」を見る"
  },
  Task_119007_Desc = {
    Text = "「パスワード対戦」に1回参加する"
  },
  Task_119008_Desc = {
    Text = "プリセットモードで2500ポイントに到達する"
  },
  Task_119009_Desc = {
    Text = "「<color=#c3aa64>凶星</color>」の覚醒体を使わずに20勝達成する"
  },
  Task_119010_Desc = {
    Text = "万象洞察"
  },
  Task_119193_Desc = {
    Text = "累計取得 68000 源液"
  },
  Task_119201_Desc = {
    Text = "累計取得 54000 源液"
  },
  Task_119212_Desc = {
    Text = "源液を42000摘出する"
  },
  Task_119216_Desc = {
    Text = "源液を48000摘出する"
  },
  Task_119217_Desc = {
    Text = "源液を36000摘出する"
  },
  Task_119695_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_119696_Desc = {
    Text = "忘却編第4章「無音の中で」をクリア"
  },
  Task_119697_Desc = {
    Text = "星辰篇第4章「楽園」をクリアする"
  },
  Task_119698_Desc = {
    Text = "累計で200回キーオーダーを使用"
  },
  Task_119699_Desc = {
    Text = "忘却篇第7章「欲望の川」をクリア"
  },
  Task_120441_Desc = {
    Text = "「調査」第7章を完了する"
  },
  Task_120500_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_120501_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_120502_Desc = {
    Text = "調査事件「@1@2」で2回の共鳴をしてください"
  },
  Task_120502_Desc2 = {
    Text = "イベント「楽園」で共鳴2回達成"
  },
  Task_120502_Name2 = {
    Text = "虚妄の回響"
  },
  Task_120503_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_120503_Desc2 = {
    Text = "調査事件「楽園」を完了"
  },
  Task_120503_Name2 = {
    Text = "楽園の崩壊"
  },
  Task_120504_Desc = {
    Text = "星辰篇第4章 4-6をクリアする"
  },
  Task_120505_Desc = {
    Text = "調査事件「楽園」難易度を完了"
  },
  Task_120505_Name = {
    Text = "楽園の崩壊・高難度"
  },
  Task_120506_Desc = {
    Text = "調査「@1@2」で6回共鳴する"
  },
  Task_120506_Desc2 = {
    Text = "イベント「楽園」で共鳴6回達成"
  },
  Task_120506_Name2 = {
    Text = "虚妄の回響Ⅲ"
  },
  Task_120507_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_120508_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_120509_Desc = {
    Text = "星辰篇第4章「楽園」難易度をクリアする"
  },
  Task_120510_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_120511_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_120512_Desc = {
    Text = "星辰篇第4章 4-6をクリアする"
  },
  Task_120514_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_120515_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_120516_Desc = {
    Text = "星辰篇第4章 4-5 難易度をクリアする"
  },
  Task_120517_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_120518_Desc = {
    Text = "星辰篇第4章 4-5 難易度をクリアする"
  },
  Task_120519_Desc = {
    Text = "星辰篇第4章「楽園」をクリアする"
  },
  Task_120520_Desc = {
    Text = "調査「@1@2」で7回共鳴する"
  },
  Task_120520_Desc2 = {
    Text = "イベント「楽園」で共鳴7回達成"
  },
  Task_120520_Name2 = {
    Text = "虚妄の回響Ⅳ"
  },
  Task_120521_Desc = {
    Text = "星辰篇第4章「楽園」難易度をクリアする"
  },
  Task_120522_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_120523_Desc = {
    Text = "調査事件「@1@2」で4回の共鳴をしてください"
  },
  Task_120523_Desc2 = {
    Text = "イベント「楽園」で共鳴4回達成"
  },
  Task_120523_Name2 = {
    Text = "虚妄の回響Ⅱ"
  },
  Task_120524_Desc = {
    Text = "星辰篇第4章「楽園」をクリアする"
  },
  Task_120535_Desc = {
    Text = "忘却編第4章「無音の中で」をクリア"
  },
  Task_120536_Desc = {
    Text = "忘却篇第7章「欲望の川」をクリア"
  },
  Task_120537_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_120538_Desc = {
    Text = "星辰篇第4章「楽園」をクリアする"
  },
  Task_120549_Desc = {
    Text = "対戦で降参せずに最後まで100回戦う"
  },
  Task_120850_Desc = {
    Text = "血肉界域の覚醒体のみで「幻夢の深奥」を1回クリア"
  },
  Task_120851_Desc = {
    Text = "混沌界域と超次元界域の覚醒体で「幻夢の深奥」を1回クリア"
  },
  Task_120852_Desc = {
    Text = "混沌界域の覚醒体のみで「幻夢の深奥」を1回クリア"
  },
  Task_120855_Desc = {
    Text = "「幻夢の深奥」で最高スコア1000達成"
  },
  Task_120856_Desc = {
    Text = "混沌界域と血肉界域の覚醒体で「幻夢の深奥」を1回クリア"
  },
  Task_120857_Desc = {
    Text = "混沌界域の覚醒体のみで難易度VI以上の「幻夢の深奥」を5回クリア"
  },
  Task_120862_Desc = {
    Text = "血肉界域の覚醒体のみで難易度VI以上の「幻夢の深奥」を5回クリア"
  },
  Task_120863_Desc = {
    Text = "混沌界域と深海界域の覚醒体で難易度VI以上の「幻夢の深奥」を5回クリア"
  },
  Task_120864_Desc = {
    Text = "混沌界域と超次元界域の覚醒体で難易度VI以上の「幻夢の深奥」を5回クリア"
  },
  Task_120865_Desc = {
    Text = "深海界域と超次元界域の覚醒体で「幻夢の深奥」を1回クリア"
  },
  Task_120867_Desc = {
    Text = "深海界域と血肉界域の覚醒体で難易度VI以上の「幻夢の深奥」を5回クリア"
  },
  Task_120868_Desc = {
    Text = "悪夢の深淵"
  },
  Task_120869_Desc = {
    Text = "超次元界域の覚醒体のみで難易度VI以上の「幻夢の深奥」を5回クリア"
  },
  Task_120870_Desc = {
    Text = "混沌界域と血肉界域の覚醒体で難易度VI以上の「幻夢の深奥」を5回クリア"
  },
  Task_120871_Desc = {
    Text = "「幻夢の深奥」で最高スコア7000達成"
  },
  Task_120872_Desc = {
    Text = "深海界域の覚醒体のみで「幻夢の深奥」を1回クリア"
  },
  Task_120873_Desc = {
    Text = "深海界域の覚醒体のみで難易度VI以上の「幻夢の深奥」を5回クリア"
  },
  Task_120876_Desc = {
    Text = "界海巡遊"
  },
  Task_120878_Desc = {
    Text = "「幻夢の深奥」で最高スコア6000達成"
  },
  Task_120879_Desc = {
    Text = "深海界域と超次元界域の覚醒体で難易度VI以上の「幻夢の深奥」を5回クリア"
  },
  Task_120880_Desc = {
    Text = "「幻夢の深奥」の「ランキング」で記録を1回再生する"
  },
  Task_120882_Desc = {
    Text = "超次元界域の覚醒体のみで「幻夢の深奥」を1回クリア"
  },
  Task_120883_Desc = {
    Text = "混沌界域と深海界域の覚醒体で「幻夢の深奥」を1回クリア"
  },
  Task_120884_Desc = {
    Text = "血肉界域と超次元界域の覚醒体で難易度VI以上の「幻夢の深奥」を5回クリア"
  },
  Task_120885_Desc = {
    Text = "初めての夢海"
  },
  Task_120889_Desc = {
    Text = "「幻夢の深奥」で最高スコア5000達成"
  },
  Task_120890_Desc = {
    Text = "「幻夢の深奥」を1回クリア"
  },
  Task_120891_Desc = {
    Text = "「幻夢の深奥」の「ランキング」で編成を1回コピーする"
  },
  Task_120892_Desc = {
    Text = "「幻夢の深奥」で最高スコア2000達成"
  },
  Task_120894_Desc = {
    Text = "「幻夢の深奥」で最高スコア4000達成"
  },
  Task_120895_Desc = {
    Text = "「幻夢の深奥」で最高スコア3000達成"
  },
  Task_120966_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_120966_Name = {Text = "3勝"},
  Task_120967_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_120967_Name = {Text = "6勝"},
  Task_120968_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_120968_Name = {Text = "10勝"},
  Task_120969_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_120969_Name = {Text = "1勝"},
  Task_120994_Desc = {
    Text = "「再戦原初・失調の序曲」のすべての分身を排除"
  },
  Task_120994_Name = {
    Text = "BOSS1を撃破"
  },
  Task_120995_Desc = {
    Text = "「再戦原初・倒錯の声」のすべての分身を排除"
  },
  Task_120995_Name = {
    Text = "BOSS4を撃破"
  },
  Task_120996_Name = {
    Text = "ワールドBOSSイベント終了"
  },
  Task_120997_Desc = {
    Text = "「再戦原初・永遠の眠り」のすべての分身を排除"
  },
  Task_120997_Name = {
    Text = "BOSS7を撃破"
  },
  Task_120998_Desc = {
    Text = "「再戦原初・死寂の律動」のすべての分身を排除"
  },
  Task_120998_Name = {
    Text = "BOSS3を撃破"
  },
  Task_120999_Desc = {
    Text = "「再戦原初・邪信の奏音」のすべての分身を排除"
  },
  Task_120999_Name = {
    Text = "BOSS5を撃破"
  },
  Task_121000_Desc = {
    Text = "「再戦原初・狂気の尾章」のすべての分身を排除"
  },
  Task_121000_Name = {
    Text = "BOSS6を撃破"
  },
  Task_121001_Desc = {
    Text = "「再戦原初・無秩序の前奏」のすべての分身を倒す"
  },
  Task_121001_Name = {
    Text = "BOSS2を撃破"
  },
  Task_121033_Desc = {
    Text = "累計で召喚を30回行う"
  },
  Task_121035_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_121040_Desc = {
    Text = "「日々の訓練」を4回完了する"
  },
  Task_121041_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_121042_Desc = {
    Text = "エンフェリンを1500消費"
  },
  Task_121044_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_121045_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_121046_Desc = {
    Text = "ミリアムの試遊ステージを1回クリア"
  },
  Task_121047_Desc = {
    Text = "累計で召喚を30回行う"
  },
  Task_121050_Desc = {
    Text = "エンフェリンを1500消費"
  },
  Task_121051_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_121053_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_121054_Desc = {
    Text = "「日々の訓練」を4回完了する"
  },
  Task_121058_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_121061_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_121062_Desc = {
    Text = "ミリアムの試遊ステージを1回クリア"
  },
  Task_121206_Desc = {
    Text = "累計取得 76000 源液"
  },
  Task_121207_Desc = {
    Text = "累計取得 84000 源液"
  },
  Task_121208_Desc = {
    Text = "累計取得 92000 源液"
  },
  Task_121233_Desc = {
    Text = "「信仰の手Ⅳ」で星3評価を獲得"
  },
  Task_121234_Desc = {
    Text = "「蝋人形の秘密Ⅱ」で星3評価を獲得"
  },
  Task_121235_Desc = {
    Text = "「血肉の残像Ⅲ」で星3評価を獲得"
  },
  Task_121236_Desc = {
    Text = "「人形の涙Ⅴ」で星3評価を獲得"
  },
  Task_121237_Desc = {
    Text = "「蝋人形の秘密Ⅲ」で星3評価を獲得"
  },
  Task_121238_Desc = {
    Text = "「金券捜索Ⅰ」で星3評価を獲得"
  },
  Task_121239_Desc = {
    Text = "「異界の影Ⅳ」で星3評価を獲得"
  },
  Task_121240_Desc = {
    Text = "「混沌地帯Ⅳ」で星3評価を獲得"
  },
  Task_121241_Desc = {
    Text = "「聖胎の詩Ⅱ」で星3評価を獲得"
  },
  Task_121242_Desc = {
    Text = "「暗海の舟Ⅲ」で星3評価を獲得"
  },
  Task_121243_Desc = {
    Text = "「漆黒の鎖Ⅲ」で星3評価を獲得"
  },
  Task_121244_Desc = {
    Text = "「海底の残像Ⅴ」で星3評価を獲得"
  },
  Task_121245_Desc = {
    Text = "「次元の残像Ⅰ」で星3評価を獲得"
  },
  Task_121246_Desc = {
    Text = "「失序山脈Ⅱ」で星3評価を獲得"
  },
  Task_121247_Desc = {
    Text = "「怪霧の都Ⅱ」で星3評価を獲得"
  },
  Task_121248_Desc = {
    Text = "「ポナペの廃墟Ⅱ」で星3評価を獲得"
  },
  Task_121249_Desc = {
    Text = "「血肉の残像Ⅱ」で星3評価を獲得"
  },
  Task_121250_Desc = {
    Text = "「失序山脈Ⅰ」で星3評価を獲得"
  },
  Task_121251_Desc = {
    Text = "「次元の残像Ⅱ」で星3評価を獲得"
  },
  Task_121252_Desc = {
    Text = "「混濁の残像Ⅳ」で星3評価を獲得"
  },
  Task_121253_Desc = {
    Text = "「狂躁蝋人形館Ⅱ」で星3評価を獲得"
  },
  Task_121254_Desc = {
    Text = "「信仰の手Ⅰ」で星3評価を獲得"
  },
  Task_121255_Desc = {
    Text = "「混沌地帯Ⅰ」で星3評価を獲得"
  },
  Task_121256_Desc = {
    Text = "「蝋人形の秘密Ⅳ」で星3評価を獲得"
  },
  Task_121257_Desc = {
    Text = "「蠕虫の棲家Ⅰ」で星3評価を獲得"
  },
  Task_121258_Desc = {
    Text = "「荒砂の壁Ⅰ」で星3評価を獲得"
  },
  Task_121259_Desc = {
    Text = "「人形の涙Ⅱ」で星3評価を獲得"
  },
  Task_121260_Desc = {
    Text = "「信仰の手Ⅲ」で星3評価を獲得"
  },
  Task_121261_Desc = {
    Text = "「異界の影Ⅲ」で星3評価を獲得"
  },
  Task_121262_Desc = {
    Text = "「砂海の遺跡Ⅲ」で星3評価を獲得"
  },
  Task_121263_Desc = {
    Text = "「混沌地帯Ⅱ」で星3評価を獲得"
  },
  Task_121264_Desc = {
    Text = "「錯乱の異郷Ⅰ」で星3評価を獲得"
  },
  Task_121265_Desc = {
    Text = "「海底の残像Ⅰ」で星3評価を獲得"
  },
  Task_121266_Desc = {
    Text = "「砂海の遺跡Ⅰ」で星3評価を獲得"
  },
  Task_121267_Desc = {
    Text = "「狂躁蝋人形館Ⅲ」で星3評価を獲得"
  },
  Task_121268_Desc = {
    Text = "「海底の残像Ⅳ」で星3評価を獲得"
  },
  Task_121269_Desc = {
    Text = "「時空のくびれⅣ」で星3評価を獲得"
  },
  Task_121270_Desc = {
    Text = "「次元の残像Ⅲ」で星3評価を獲得"
  },
  Task_121271_Desc = {
    Text = "「金券捜索Ⅳ」で星3評価を獲得"
  },
  Task_121272_Desc = {
    Text = "「海底の残像Ⅲ」で星3評価を獲得"
  },
  Task_121273_Desc = {
    Text = "「薬剤収集Ⅰ」で星3評価を獲得"
  },
  Task_121274_Desc = {
    Text = "「蝋人形の秘密Ⅴ」で星3評価を獲得"
  },
  Task_121275_Desc = {
    Text = "「砂海の遺跡Ⅱ」で星3評価を獲得"
  },
  Task_121276_Desc = {
    Text = "「狂躁蝋人形館Ⅰ」で星3評価を獲得"
  },
  Task_121277_Desc = {
    Text = "「失序山脈Ⅲ」で星3評価を獲得"
  },
  Task_121278_Desc = {
    Text = "「薬剤収集Ⅳ」で星3評価を獲得"
  },
  Task_121279_Desc = {
    Text = "「人形の涙Ⅲ」で星3評価を獲得"
  },
  Task_121280_Desc = {
    Text = "「血肉の残像Ⅴ」で星3評価を獲得"
  },
  Task_121281_Desc = {
    Text = "「暗海の舟Ⅰ」で星3評価を獲得"
  },
  Task_121282_Desc = {
    Text = "「昏き海の潮Ⅱ」で星3評価を獲得"
  },
  Task_121283_Desc = {
    Text = "「混濁の残像Ⅲ」で星3評価を獲得"
  },
  Task_121284_Desc = {
    Text = "「信仰の手Ⅱ」で星3評価を獲得"
  },
  Task_121285_Desc = {
    Text = "「嵐の外海Ⅰ」で星3評価を獲得"
  },
  Task_121286_Desc = {
    Text = "「蝋人形の秘密Ⅰ」で星3評価を獲得"
  },
  Task_121287_Desc = {
    Text = "「ポナペの廃墟Ⅲ」で星3評価を獲得"
  },
  Task_121288_Desc = {
    Text = "「聖胎の詩Ⅲ」で星3評価を獲得"
  },
  Task_121289_Desc = {
    Text = "「血肉の残像Ⅳ」で星3評価を獲得"
  },
  Task_121290_Desc = {
    Text = "「血肉の残像Ⅰ」で星3評価を獲得"
  },
  Task_121291_Desc = {
    Text = "「異界の影Ⅱ」で星3評価を獲得"
  },
  Task_121292_Desc = {
    Text = "「聖胎の詩Ⅰ」で星3評価を獲得"
  },
  Task_121293_Desc = {
    Text = "「時空のくびれⅢ」で星3評価を獲得"
  },
  Task_121294_Desc = {
    Text = "「異界の影Ⅰ」で星3評価を獲得"
  },
  Task_121295_Desc = {
    Text = "「金券捜索Ⅱ」で星3評価を獲得"
  },
  Task_121296_Desc = {
    Text = "「薬剤収集Ⅴ」で星3評価を獲得"
  },
  Task_121297_Desc = {
    Text = "「錯乱の異郷Ⅱ」で星3評価を獲得"
  },
  Task_121298_Desc = {
    Text = "「薬剤収集Ⅱ」で星3評価を獲得"
  },
  Task_121299_Desc = {
    Text = "「時空のくびれⅡ」で星3評価を獲得"
  },
  Task_121300_Desc = {
    Text = "「金券捜索Ⅴ」で星3評価を獲得"
  },
  Task_121301_Desc = {
    Text = "「怪霧の都Ⅲ」で星3評価を獲得"
  },
  Task_121302_Desc = {
    Text = "「薬剤収集Ⅲ」で星3評価を獲得"
  },
  Task_121303_Desc = {
    Text = "「ポナペの廃墟Ⅳ」で星3評価を獲得"
  },
  Task_121304_Desc = {
    Text = "「混沌地帯Ⅲ」で星3評価を獲得"
  },
  Task_121305_Desc = {
    Text = "「怪霧の都Ⅰ」で星3評価を獲得"
  },
  Task_121306_Desc = {
    Text = "「蠕虫の棲家Ⅲ」で星3評価を獲得"
  },
  Task_121307_Desc = {
    Text = "「海底の残像Ⅱ」で星3評価を獲得"
  },
  Task_121308_Desc = {
    Text = "「蠕虫の棲家Ⅳ」で星3評価を獲得"
  },
  Task_121309_Desc = {
    Text = "「ポナペの廃墟Ⅰ」で星3評価を獲得"
  },
  Task_121310_Desc = {
    Text = "「混濁の残像Ⅱ」で星3評価を獲得"
  },
  Task_121311_Desc = {
    Text = "「次元の残像Ⅴ」で星3評価を獲得"
  },
  Task_121312_Desc = {
    Text = "「蠕虫の棲家Ⅱ」で星3評価を獲得"
  },
  Task_121313_Desc = {
    Text = "「漆黒の鎖Ⅱ」で星3評価を獲得"
  },
  Task_121314_Desc = {
    Text = "「次元の残像Ⅳ」で星3評価を獲得"
  },
  Task_121315_Desc = {
    Text = "「混濁の残像Ⅴ」で星3評価を獲得"
  },
  Task_121316_Desc = {
    Text = "「漆黒の鎖Ⅳ」で星3評価を獲得"
  },
  Task_121317_Desc = {
    Text = "「漆黒の鎖Ⅰ」で星3評価を獲得"
  },
  Task_121318_Desc = {
    Text = "「錯乱の異郷Ⅲ」で星3評価を獲得"
  },
  Task_121319_Desc = {
    Text = "「人形の涙Ⅰ」で星3評価を獲得"
  },
  Task_121320_Desc = {
    Text = "「暗海の舟Ⅱ」で星3評価を獲得"
  },
  Task_121321_Desc = {
    Text = "「金券捜索Ⅲ」で星3評価を獲得"
  },
  Task_121322_Desc = {
    Text = "「漆黒の鎖Ⅴ」で星3評価を獲得"
  },
  Task_121323_Desc = {
    Text = "「人形の涙Ⅳ」で星3評価を獲得"
  },
  Task_121324_Desc = {
    Text = "「昏き海の潮Ⅰ」で星3評価を獲得"
  },
  Task_121325_Desc = {
    Text = "「混濁の残像Ⅰ」で星3評価を獲得"
  },
  Task_121326_Desc = {
    Text = "「時空のくびれⅠ」で星3評価を獲得"
  },
  Task_121327_Desc = {
    Text = "「原初の裂け目Ⅰ」で星3評価を獲得"
  },
  Task_121331_Desc = {
    Text = "「初めての夢海」の全記録を完了"
  },
  Task_121332_Desc = {
    Text = "深海界域と血肉界域の覚醒体で「幻夢の深奥」を1回クリア"
  },
  Task_121333_Desc = {
    Text = "血肉界域と超次元界域の覚醒体で「幻夢の深奥」を1回クリア"
  },
  Task_121834_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_121834_Name = {
    Text = "完璧な通過"
  },
  Task_121835_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_121835_Name = {
    Text = "完璧な通過"
  },
  Task_121836_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_121836_Name = {
    Text = "完璧な通過"
  },
  Task_121837_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_121837_Name = {
    Text = "完璧な通過"
  },
  Task_121838_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_121838_Name = {
    Text = "完璧な通過"
  },
  Task_121839_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_121839_Name = {
    Text = "完璧な通過"
  },
  Task_121840_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_121840_Name = {
    Text = "完璧な通過"
  },
  Task_121841_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_121841_Name = {
    Text = "完璧な通過"
  },
  Task_121842_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_121842_Name = {
    Text = "完璧な通過"
  },
  Task_121843_Desc = {
    Text = "すべての聖獣の呪いを受け入れ、「楽園の投影」を15ターン以内に撃破する。"
  },
  Task_121843_Name = {
    Text = "楽園の崩壊・隠れ"
  },
  Task_121844_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_121844_Name = {
    Text = "完璧な通過"
  },
  Task_121897_Desc = {
    Text = "残り1ターンごとに20点獲得。(現在の残りターン：{s1})"
  },
  Task_121897_Name = {
    Text = "時序の砂時計<size=20><color=#747474>開始時50ターン。残り1ターンごとに20点獲得。</color></size>"
  },
  Task_122110_Desc = {
    Text = "毎日初回プレイで500点獲得。"
  },
  Task_122110_Name = {
    Text = "夢の先駆者<size=20><color=#747474>毎日初回プレイで500点獲得。</color></size>"
  },
  Task_122197_Desc = {
    Text = "混沌界域の覚醒体を使用し「迷失した自己」で1回勝利"
  },
  Task_122198_Desc = {
    Text = "「四肢を支配する」狂気の難易度をクリア"
  },
  Task_122199_Desc = {
    Text = "「心臓を打ち砕く」を超難度でクリア"
  },
  Task_122200_Desc = {
    Text = "「切除盲腸」任意の難易度をクリア"
  },
  Task_122201_Desc = {
    Text = "「言語の制御」を任意の難易度でクリア"
  },
  Task_122202_Desc = {
    Text = "「本能思考」任意の難易度をクリア"
  },
  Task_122203_Desc = {
    Text = "「真我の解放」狂気の難易度をクリア"
  },
  Task_122204_Desc = {
    Text = "「目を覆う」狂気の難易度をクリア"
  },
  Task_122205_Desc = {
    Text = "「心臓を打ち砕く」を任意の難易度でクリア"
  },
  Task_122206_Desc = {
    Text = "「言語の制御」を任意の難易度でクリア"
  },
  Task_122207_Desc = {
    Text = "「切除盲腸」超難度をクリア"
  },
  Task_122208_Desc = {
    Text = "「本能思考」任意の難易度をクリア"
  },
  Task_122209_Desc = {
    Text = "超次元界域の覚醒体を使用し「迷失した自己」で1回勝利"
  },
  Task_122210_Desc = {
    Text = "「四肢を支配する」任意の難易度をクリア"
  },
  Task_122211_Desc = {
    Text = "任意の難易度で「真の解放」をクリアする"
  },
  Task_122212_Desc = {
    Text = "多次元接続クリア「銀と血の洗礼」"
  },
  Task_122213_Desc = {
    Text = "「迷失した自己・クリア」のすべての成果を達成する"
  },
  Task_122214_Desc = {
    Text = "「目を欺く」任意の難易度をクリア"
  },
  Task_122215_Desc = {
    Text = "迷失した自己・界域"
  },
  Task_122216_Desc = {
    Text = "「本能思考」超難度をクリア"
  },
  Task_122217_Desc = {
    Text = "「四肢を支配する」任意の難易度をクリア"
  },
  Task_122218_Desc = {
    Text = "任意の難易度で「真の解放」をクリアする"
  },
  Task_122219_Desc = {
    Text = "失われた自我・突破"
  },
  Task_122220_Desc = {
    Text = "血肉界域の覚醒体を使用し「迷失した自己」で2回勝利する"
  },
  Task_122221_Desc = {
    Text = "迷い失った自己・狂気"
  },
  Task_122222_Desc = {
    Text = "「目を欺く」任意の難易度をクリア"
  },
  Task_122223_Desc = {
    Text = "「言語を制御する」狂気の難易度をクリア"
  },
  Task_122224_Desc = {
    Text = "「切除盲腸」任意の難易度をクリア"
  },
  Task_122225_Desc = {
    Text = "深海界域の覚醒体を使用し「迷失の自己」で1回勝利する"
  },
  Task_122226_Desc = {
    Text = "深海界域の覚醒体を使用し「迷失した自己」で2回勝利する"
  },
  Task_122227_Desc = {
    Text = "血肉界域の覚醒体を使用して「迷い失った自己」で1回勝利"
  },
  Task_122228_Desc = {
    Text = "「心臓を打ち砕く」を任意の難易度でクリア"
  },
  Task_122229_Desc = {
    Text = "超次元界域の覚醒体を使用し「迷いし自我」で2回勝利"
  },
  Task_122230_Desc = {
    Text = "混沌界域の覚醒体を使用し「迷失した自己」で2回勝利する"
  },
  Task_122411_Desc = {
    Text = "強化覚醒体を1/2体編成して出撃時、250/500点獲得。（現在出撃中：{s1}）"
  },
  Task_122411_Name = {
    Text = "深淵の呼びかけ<size=20><color=#747474>強化覚醒体を1/2体編成して出撃時、250/500点獲得。</color></size>"
  },
  Task_122584_Name = {
    Text = "すべてのBOSSを撃破"
  },
  Task_122704_Desc = {
    Text = "モカの同調率がレベル10に到達する"
  },
  Task_122808_Desc = {
    Text = "茉夏獲得時に霊感6を得る"
  },
  Task_122808_Name = {
    Text = "茉夏獲得時に霊感6を得る"
  },
  Task_122808_UnlockCondDesc = {
    Text = "イベント@覚醒体モシャ霊知啓発ギフト2"
  },
  Task_122809_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_122812_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_122816_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_122819_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_122824_Desc = {
    Text = "茉夏の霊知啓発2を獲得する"
  },
  Task_122824_Name = {
    Text = "茉夏の霊知啓発2を獲得する"
  },
  Task_122824_UnlockCondDesc = {
    Text = "イベント@覚醒体モシャ霊知啓発ギフト2"
  },
  Task_122828_Desc = {
    Text = "「調査行動-忘却篇-第3章」高難度を完了する"
  },
  Task_122829_Desc = {
    Text = "「調査行動-忘却編-第1章」高難度をクリア"
  },
  Task_122830_Desc = {
    Text = "「調査行動-忘却編-第6章」高難度を完了"
  },
  Task_122831_Desc = {
    Text = "「調査行動-忘却篇-第7章」高難度を完了"
  },
  Task_122832_Desc = {
    Text = "「調査行動-忘却篇-第4章」高難度を完了する"
  },
  Task_122833_Desc = {
    Text = "「調査行動-忘却篇-第2章」高難度を完了する"
  },
  Task_122834_Desc = {
    Text = "「調査行動-忘却篇-第5章」高難度を完了"
  },
  Task_123135_Desc = {
    Text = "混沌界域の覚醒体を使用し「魔女の小店」で2回勝利"
  },
  Task_123136_Desc = {
    Text = "深海領域の覚醒体を使用して「魔女の小店」で2回勝利する"
  },
  Task_123137_Desc = {
    Text = "血肉界域の覚醒体を使用し「魔女の小店」で1回勝利"
  },
  Task_123138_Desc = {
    Text = "超次元界域の覚醒体を使用し「魔女の小店」で1回勝利"
  },
  Task_123139_Desc = {
    Text = "混沌界域の覚醒体を使用し「魔女の小店」で1回勝利"
  },
  Task_123140_Desc = {
    Text = "血肉界域の覚醒体を使用して「魔女の小店」で2回勝利する"
  },
  Task_123141_Desc = {
    Text = "魔女の店・界域"
  },
  Task_123142_Desc = {
    Text = "深海界域の覚醒体を使用し「魔女の小店」で1回勝利"
  },
  Task_123143_Desc = {
    Text = "超次元界域の覚醒体を使用し「魔女の小店」で2回勝利"
  },
  Task_123288_Desc = {
    Text = "超次元界域の覚醒体を使用し「深海凝視」で2回勝利"
  },
  Task_123289_Desc = {
    Text = "深海界域の覚醒体を使用し「深海凝視」で2回勝利"
  },
  Task_123290_Desc = {
    Text = "血肉界域の覚醒体を使用し「深海凝視」で2回勝利"
  },
  Task_123291_Desc = {
    Text = "混沌界域の覚醒体を使用し「深海凝視」で2回勝利"
  },
  Task_123324_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_123325_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_123326_Desc = {
    Text = "「日々の訓練」を4回完了する"
  },
  Task_123327_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_123328_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_123329_Desc = {
    Text = "「日々の訓練」を4回完了する"
  },
  Task_123330_Desc = {
    Text = "タイスの試遊ステージを1回クリア"
  },
  Task_123331_Desc = {
    Text = "エンフェリンを1500消費"
  },
  Task_123332_Desc = {
    Text = "累計で召喚を30回行う"
  },
  Task_123333_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_123334_Desc = {
    Text = "タイスの試遊ステージを1回クリア"
  },
  Task_123335_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_123336_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_123337_Desc = {
    Text = "エンフェリンを1500消費"
  },
  Task_123338_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_123339_Desc = {
    Text = "累計で召喚を30回行う"
  },
  Task_123488_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_123488_Name = {Text = "3勝"},
  Task_123489_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_123489_Name = {Text = "6勝"},
  Task_123490_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_123490_Name = {Text = "10勝"},
  Task_123491_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_123491_Name = {Text = "1勝"},
  Task_123726_Name = {
    Text = "モシャのサブステージの通常6を再クリア"
  },
  Task_123878_Desc = {
    Text = "混沌界域の覚醒体を使用し「獣の本能」で2回勝利"
  },
  Task_123883_Desc = {
    Text = "超次元界域の覚醒体を使用し「獣の本能」で2回勝利"
  },
  Task_123885_Desc = {
    Text = "深海界域の覚醒体を使用し「獣の本能」で2回勝利"
  },
  Task_123887_Desc = {
    Text = "血肉界域の覚醒体を使用し「獣の本能」で2回勝利"
  },
  Task_124214_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_124214_Name = {Text = "3勝"},
  Task_124215_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_124215_Name = {Text = "10勝"},
  Task_124216_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_124216_Name = {Text = "1勝"},
  Task_124217_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_124217_Name = {Text = "6勝"},
  Task_124797_Desc = {
    Text = "多次元接続「逆転ラウンド」を完了する"
  },
  Task_124797_Name = {
    Text = "万象逆転"
  },
  Task_124798_Desc = {
    Text = "多次元接続「銀と血の洗礼」の困難難易度をクリア"
  },
  Task_124798_Name = {
    Text = "未来がやってくる·高難度"
  },
  Task_124799_Desc = {
    Text = "多次元接続「銀と血の洗礼」を完了する"
  },
  Task_124799_Name = {
    Text = "未来はやってくる"
  },
  Task_124835_Desc = {
    Text = "「調査行動-忘却編-第1章」をクリア"
  },
  Task_125386_Desc = {
    Text = "「尸解」任意の難易度をクリア"
  },
  Task_125387_Desc = {
    Text = "任意の難易度で「窓の後ろの影」をクリアする"
  },
  Task_125388_Desc = {
    Text = "「吮」を任意の難易度でクリア"
  },
  Task_125389_Desc = {
    Text = "「循香」の狂気の難易度をクリア"
  },
  Task_125390_Desc = {
    Text = "「臃容な大衆」の任意の難易度をクリア"
  },
  Task_125391_Desc = {
    Text = "血肉界域の覚醒体を使用し「玄女無相」で1回勝利"
  },
  Task_125392_Desc = {
    Text = "意識潜游「扇下夜談」をクリア"
  },
  Task_125392_Name = {
    Text = "天も地も恐れおののいている"
  },
  Task_125393_Desc = {
    Text = "「香を循環させる」任意の難易度をクリア"
  },
  Task_125394_Desc = {
    Text = "「枉死」狂気の難易度をクリア"
  },
  Task_125395_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_125396_Desc = {
    Text = "混沌界域の覚醒体を使用し「玄女無相」で2回勝利"
  },
  Task_125397_Desc = {
    Text = "「愛憎相生」狂気の難易度をクリア"
  },
  Task_125398_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_125399_Desc = {
    Text = "「無念の死」を任意の難易度でクリア"
  },
  Task_125400_Desc = {
    Text = "混沌界域の覚醒体を使用し「玄女無相」で1回勝利"
  },
  Task_125401_Desc = {
    Text = "玄女無相・クリア"
  },
  Task_125402_Desc = {
    Text = "「吮」を任意の難易度でクリア"
  },
  Task_125403_Desc = {
    Text = "任意の難易度で「窓の後ろの影」をクリアする"
  },
  Task_125404_Desc = {
    Text = "「極楽」狂気の難易度をクリア"
  },
  Task_125406_Desc = {
    Text = "深海界域の覚醒体を使用し「玄女無相」で1回勝利"
  },
  Task_125407_Desc = {
    Text = "「極楽」任意の難易度をクリア"
  },
  Task_125409_Desc = {
    Text = "「極楽」任意の難易度をクリア"
  },
  Task_125410_Desc = {
    Text = "血肉界域の覚醒体を使用して「玄女無相」で2回勝利する"
  },
  Task_125411_Desc = {
    Text = "深海界域の覚醒体を使用して「玄女無相」で2回勝利する"
  },
  Task_125412_Desc = {
    Text = "「吮」を狂気の難易度でクリア"
  },
  Task_125413_Desc = {
    Text = "クリア「意識潜航：扇下夜談」"
  },
  Task_125414_Desc = {
    Text = "「ロジック」を任意の難易度でクリア"
  },
  Task_125415_Desc = {
    Text = "徐の同調率がレベル10に到達する"
  },
  Task_125416_Desc = {
    Text = "超次元界域の覚醒体を使用し「玄女無相」で2回勝利"
  },
  Task_125417_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_125418_Desc = {
    Text = "徐の霊知啓発2を獲得する"
  },
  Task_125418_Name = {
    Text = "徐の霊知啓発2を獲得する"
  },
  Task_125418_UnlockCondDesc = {
    Text = "イベント@覚醒体徐霊知啓発ギフト2"
  },
  Task_125419_Desc = {
    Text = "「愛憎相生」任意の難易度をクリア"
  },
  Task_125420_Desc = {
    Text = "玄女無相・界域"
  },
  Task_125421_Desc = {
    Text = "「窓の影」狂気の難易度をクリア"
  },
  Task_125422_Desc = {
    Text = "「愛憎相生」任意の難易度をクリア"
  },
  Task_125423_Desc = {
    Text = "超次元界域の覚醒体を使用し「玄女無相」で1回勝利"
  },
  Task_125424_Desc = {
    Text = "「香を循環させる」任意の難易度をクリア"
  },
  Task_125425_Desc = {
    Text = "「臃容众」狂気の難易度をクリア"
  },
  Task_125426_Desc = {
    Text = "徐の霊知啓発6を獲得する"
  },
  Task_125426_Name = {
    Text = "徐の霊知啓発6を獲得する"
  },
  Task_125426_UnlockCondDesc = {
    Text = "イベント@覚醒体徐霊知啓発ギフト2"
  },
  Task_125427_Desc = {
    Text = "「ロジック」を任意の難易度でクリア"
  },
  Task_125428_Desc = {
    Text = "「玄女無相・クリア」のすべての成果を達成する"
  },
  Task_125429_Desc = {
    Text = "「尸解」任意の難易度をクリア"
  },
  Task_125430_Desc = {
    Text = "「羅織」を狂気の難易度でクリア"
  },
  Task_125431_Desc = {
    Text = "「臃容な大衆」の任意の難易度をクリア"
  },
  Task_125432_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_125433_Desc = {
    Text = "「無念の死」を任意の難易度でクリア"
  },
  Task_125434_Desc = {
    Text = "玄女無相・狂気"
  },
  Task_125435_Desc = {
    Text = "「尸解」の狂気難易度をクリア"
  },
  Task_125500_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_125500_Name = {Text = "6勝"},
  Task_125501_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_125501_Name = {Text = "10勝"},
  Task_125502_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_125502_Name = {Text = "1勝"},
  Task_125503_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_125503_Name = {Text = "3勝"},
  Task_125686_Desc = {
    Text = "追跡から逃れる"
  },
  Task_125686_Name = {Text = "目標"},
  Task_125687_Desc = {
    Text = "待ち伏せから生き延びる"
  },
  Task_125687_Name = {Text = "目標"},
  Task_125688_Desc = {
    Text = "リッツの身体を取り戻す"
  },
  Task_125688_Name = {Text = "目標"},
  Task_125689_Desc = {
    Text = "アラクネの罠から逃げる"
  },
  Task_125689_Name = {Text = "目標"},
  Task_125690_Desc = {
    Text = "三質体の封印を解除する"
  },
  Task_125690_Name = {Text = "目標"},
  Task_125691_Desc = {
    Text = "酒場の敵に対抗する"
  },
  Task_125691_Name = {Text = "目標"},
  Task_125692_Desc = {
    Text = "変異体を排除せよ"
  },
  Task_125692_Name = {Text = "目標"},
  Task_125693_Desc = {
    Text = "「善良」を救って"
  },
  Task_125693_Name = {Text = "目標"},
  Task_125694_Desc = {
    Text = "ソレールを守る"
  },
  Task_125694_Name = {Text = "目標"},
  Task_125695_Desc = {
    Text = "「思い出」に復讐"
  },
  Task_125695_Name = {Text = "目標"},
  Task_125845_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_125845_Name = {
    Text = "完璧な通過"
  },
  Task_125846_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_125846_Name = {
    Text = "完璧な通過"
  },
  Task_125847_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_125847_Name = {
    Text = "完璧な通過"
  },
  Task_125848_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_125848_Name = {
    Text = "完璧な通過"
  },
  Task_125849_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_125849_Name = {
    Text = "完璧な通過"
  },
  Task_125850_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_125850_Name = {
    Text = "完璧な通過"
  },
  Task_125851_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_125851_Name = {
    Text = "完璧な通過"
  },
  Task_125852_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_125852_Name = {
    Text = "完璧な通過"
  },
  Task_125853_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_125853_Name = {
    Text = "完璧な通過"
  },
  Task_125854_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_125854_Name = {
    Text = "完璧な通過"
  },
  Task_126276_Desc = {
    Text = "「ネタバレ禁止」を狂乱難易度でクリアする"
  },
  Task_126277_Desc = {
    Text = "人形の舞台·狂乱"
  },
  Task_126279_Desc = {
    Text = "深海界域覚醒体を使用して「人形の舞台」で1回勝利する"
  },
  Task_126280_Desc = {
    Text = "人形の舞台·クリア"
  },
  Task_126281_Desc = {
    Text = "「燃焼」を任意の難易度でクリアする"
  },
  Task_126282_Desc = {
    Text = "「ネタバレ禁止」を任意の難易度でクリアする"
  },
  Task_126285_Desc = {
    Text = "「入場」を任意の難易度でクリアする"
  },
  Task_126286_Desc = {
    Text = "「反転、反転」を任意の難易度でクリアする"
  },
  Task_126288_Desc = {
    Text = "「壁の上の銃」を任意の難易度でクリアする"
  },
  Task_126290_Desc = {
    Text = "「燃焼」を狂乱難易度でクリアする"
  },
  Task_126292_Desc = {
    Text = "「壁の上の銃」を狂乱難易度でクリアする"
  },
  Task_126293_Desc = {
    Text = "「燃焼」を任意の難易度でクリアする"
  },
  Task_126294_Desc = {
    Text = "「人形の舞台·クリア」の全実績を達成する"
  },
  Task_126295_Desc = {
    Text = "超維界域覚醒体を使用して「人形の舞台」で1回勝利する"
  },
  Task_126296_Desc = {
    Text = "「反転、反転」を狂乱難易度でクリアする"
  },
  Task_126297_Desc = {
    Text = "「入場」を狂乱難易度でクリアする"
  },
  Task_126298_Desc = {
    Text = "人形の舞台·界域"
  },
  Task_126299_Desc = {
    Text = "深海界域覚醒体を使用して「人形の舞台」で2回勝利する"
  },
  Task_126302_Desc = {
    Text = "混沌界域覚醒体を使用して「人形の舞台」で2回勝利する"
  },
  Task_126303_Desc = {
    Text = "「入場」を任意の難易度でクリアする"
  },
  Task_126304_Desc = {
    Text = "血肉界域覚醒体を使用して「人形の舞台」で2回勝利する"
  },
  Task_126305_Desc = {
    Text = "「ネタバレ禁止」を任意の難易度でクリアする"
  },
  Task_126307_Desc = {
    Text = "「壁の上の銃」を任意の難易度でクリアする"
  },
  Task_126309_Desc = {
    Text = "血肉界域覚醒体を使用して「人形の舞台」で1回勝利する"
  },
  Task_126311_Desc = {
    Text = "超維界域覚醒体を使用して「人形の舞台」で2回勝利する"
  },
  Task_126312_Desc = {
    Text = "混沌界域覚醒体を使用して「人形の舞台」で1回勝利する"
  },
  Task_126313_Desc = {
    Text = "「反転、反転」を任意の難易度でクリアする"
  },
  Task_126385_Desc = {
    Text = "クリア星辰篇第5章「運命劇場」難しい難易度"
  },
  Task_126386_Desc = {
    Text = "クリア星辰篇第5章「運命劇場」難しい難易度"
  },
  Task_126387_Desc = {
    Text = "星辰篇第5章 5-7をクリアする"
  },
  Task_126388_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_126390_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_126391_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_126392_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_126393_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_126394_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_126395_Desc = {
    Text = "クリア星辰篇第5章「運命劇場」"
  },
  Task_126396_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_126397_Desc = {
    Text = "星辰篇第5章 5-6を困難難易度でクリアする"
  },
  Task_126398_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_126399_Desc = {
    Text = "星辰篇第5章 5-6を困難難易度でクリアする"
  },
  Task_126400_Desc = {
    Text = "星辰篇第5章 5-7をクリアする"
  },
  Task_126401_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_126402_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_126403_Desc = {
    Text = "クリア星辰篇第5章「運命劇場」"
  },
  Task_126493_Desc = {
    Text = "古国雑録Ⅶ"
  },
  Task_126494_Desc = {
    Text = "古代の国の雑記・期間限定専用"
  },
  Task_126495_Desc = {
    Text = "古国雑録Ⅴ"
  },
  Task_126496_Desc = {
    Text = "古国雑録Ⅰ"
  },
  Task_126497_Desc = {
    Text = "古国雑煮Ⅵ"
  },
  Task_126498_Desc = {
    Text = "古国雑記Ⅲ"
  },
  Task_126499_Desc = {
    Text = "古国雑録Ⅳ"
  },
  Task_126500_Desc = {
    Text = "古国雑煮・無料"
  },
  Task_126501_Desc = {
    Text = "古代の雑録Ⅱ"
  },
  Task_127071_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_127071_Name = {Text = "10勝"},
  Task_127072_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_127072_Name = {Text = "3勝"},
  Task_127073_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_127073_Name = {Text = "6勝"},
  Task_127074_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_127074_Name = {Text = "1勝"},
  Task_127094_Desc = {
    Text = "オレッタの霊知啓発が人格の深化12に達する"
  },
  Task_127095_Desc = {
    Text = "環行・ラモンナの霊知啓発が人格の深化12に達する"
  },
  Task_127096_Desc = {
    Text = "ラモンナの霊知啓発が人格の深化12に達する"
  },
  Task_127097_Desc = {
    Text = "アイギスの霊知啓発が人格の深化12に達する"
  },
  Task_127098_Desc = {
    Text = "ロータンの霊知啓発が人格の深化12に達する"
  },
  Task_127099_Desc = {
    Text = "エリカの霊知啓発が人格の深化12に達する"
  },
  Task_127100_Desc = {
    Text = "ドールの霊知啓発が人格の深化12に達する"
  },
  Task_127101_Desc = {
    Text = "オジールの霊知啓発が人格の深化12に達する"
  },
  Task_129511_Desc = {
    Text = "血肉3体と超次元覚醒体1体で構成されたチームで難しいまたは狂気の難易度をクリアする"
  },
  Task_129512_Desc = {
    Text = "混沌3体と超次元覚醒体1体で構成されたチームで難しいまたは狂気の難易度をクリアする"
  },
  Task_129513_Desc = {
    Text = "特急の軌跡・難しい"
  },
  Task_129513_Name = {
    Text = "特急の軌跡・難しい"
  },
  Task_129514_Desc = {
    Text = "狂気・第3段階クリア"
  },
  Task_129515_Desc = {
    Text = "1体の血肉と3体の超次元覚醒体で構成されたチームで難しいまたは狂気の難易度をクリア"
  },
  Task_129516_Desc = {
    Text = "任意難易度・第3段階のボス「メルトダウン・ドル」を撃破"
  },
  Task_129517_Desc = {
    Text = "任意難易度・第3段階のボス「楽園の帳」を撃破"
  },
  Task_129518_Desc = {
    Text = "「専用列車の軌跡・難しい」のすべての任務を完了する"
  },
  Task_129519_Desc = {
    Text = "任意の難易度で4名の超次元覚醒体で構成されたチームでクリアする"
  },
  Task_129520_Desc = {
    Text = "通常・第2段階クリア"
  },
  Task_129521_Desc = {
    Text = "任意難易度・第2段階のボス「ハイドラ」を撃破"
  },
  Task_129522_Desc = {
    Text = "任意の難易度で4体の血肉覚醒体で構成されたチームでクリアする"
  },
  Task_129523_Desc = {
    Text = "任意の難易度で、2体の血肉と2体の超次元覚醒体で構成されたチームでクリアする"
  },
  Task_129524_Desc = {
    Text = "深海3名と血肉覚醒体1名で構成されたチームを使用して、難しいまたは狂気の難易度をクリア"
  },
  Task_129525_Desc = {
    Text = "通常・第1段階クリア"
  },
  Task_129526_Desc = {
    Text = "任意の難易度で、混沌2体と血肉覚醒体2体で構成されたチームでクリアする"
  },
  Task_129527_Desc = {
    Text = "混沌3体と血肉覚醒体1体で構成されたチームで難しいまたは狂気の難易度をクリアする"
  },
  Task_129528_Desc = {
    Text = "「沿途の記憶・歓喜の回廊」全任務完了"
  },
  Task_129529_Desc = {
    Text = "通常・第3段階クリア"
  },
  Task_129530_Desc = {
    Text = "混沌と深海覚醒体1体で構成された3名のチームで、難しいまたは狂気の難易度をクリアする"
  },
  Task_129531_Desc = {
    Text = "任意難易度・第1段階のボス「▼あ▼▼や」を撃破"
  },
  Task_129532_Desc = {
    Text = "高難度・第2段階クリア"
  },
  Task_129533_Desc = {
    Text = "狂気・第1段階クリア"
  },
  Task_129534_Desc = {
    Text = "沿途の記憶・昔の回想"
  },
  Task_129534_Name = {
    Text = "沿途の記憶・昔のの回想"
  },
  Task_129535_Desc = {
    Text = "任意難易度・第3段階のボス「腐潮の傀儡」を撃破"
  },
  Task_129536_Desc = {
    Text = "沿途の記憶・歓喜の回廊"
  },
  Task_129536_Name = {
    Text = "沿途の記憶・歓喜の回廊"
  },
  Task_129537_Desc = {
    Text = "任意難易度・第3段階のボス「超次元@2のさなぎ」を撃破"
  },
  Task_129538_Desc = {
    Text = "深海と血肉覚醒体をそれぞれ2体ずつ含むチームで、任意の難易度をクリアする"
  },
  Task_129539_Desc = {
    Text = "任意難易度・第2段階のボス「豊穣の母樹」を撃破"
  },
  Task_129540_Desc = {
    Text = "任意難易度・第1段階のボス「泣き虫ジョー▼」を撃破"
  },
  Task_129541_Desc = {
    Text = "混沌と深海覚醒体各2体で構成されたチームで、任意の難易度をクリアする"
  },
  Task_129542_Desc = {
    Text = "高難度・第3段階クリア"
  },
  Task_129543_Desc = {
    Text = "任意難易度・第1段階のボス「修▼▼」を撃破"
  },
  Task_129544_Desc = {
    Text = "深海3体と超次元覚醒体1体で構成されたチームで難しいまたは狂気の難易度をクリア"
  },
  Task_129545_Desc = {
    Text = "狂気・第2段階クリア"
  },
  Task_129546_Desc = {
    Text = "任意難易度・第1段階のボス「次元を巡る犬」を撃破"
  },
  Task_129547_Desc = {
    Text = "任意難易度・第2段階のボス「双子の矛盾」を撃破"
  },
  Task_129548_Desc = {
    Text = "深海1体と血肉覚醒体3体で構成されたチームで難しいまたは狂気の難易度をクリアする"
  },
  Task_129549_Desc = {
    Text = "任意の難易度で、2体の混沌と2体の超次元覚醒体で構成されたチームでクリアする"
  },
  Task_129550_Desc = {
    Text = "高難度・第1段階クリア"
  },
  Task_129551_Desc = {
    Text = "「専用列車の軌跡・ノーマル」のすべての任務を完了する"
  },
  Task_129552_Desc = {
    Text = "2名の深海と2名の超次元覚醒体で構成されたチームで任意の難易度をクリアする"
  },
  Task_129553_Desc = {
    Text = "特急軌跡·通常"
  },
  Task_129553_Name = {
    Text = "特急軌跡·通常"
  },
  Task_129554_Desc = {
    Text = "混沌1体と血肉覚醒体3体で構成されたチームで、難しいまたは狂気の難易度をクリアする"
  },
  Task_129555_Desc = {
    Text = "混沌1体と超次元覚醒体3体で構成されたチームで難しいまたは狂気の難易度をクリア"
  },
  Task_129556_Desc = {
    Text = "4体の深海覚醒体で構成されたチームを使用して任意の難易度をクリアする"
  },
  Task_129557_Desc = {
    Text = "混沌1体と深海覚醒体3体で構成されたチームで難しいまたは狂気の難易度をクリアする"
  },
  Task_129558_Desc = {
    Text = "1名の深海と3名の超次元覚醒体で構成されたチームで、難しいまたは狂気の難易度をクリアする"
  },
  Task_129559_Desc = {
    Text = "4体のカオスウェイクアップボディで構成されたチームで任意の難易度をクリア"
  },
  Task_129560_Desc = {
    Text = "「沿途の記憶・昔の回想」全任務完了"
  },
  Task_129561_Desc = {
    Text = "任意難易度・第2段階のボス「聖嬰」を撃破"
  },
  Task_129895_Desc = {
    Text = "特務記録「祈年祭行きの列車」を完成しました"
  },
  Task_129895_Name = {
    Text = "爆竹の音の中で一年が過ぎる"
  },
  Task_130180_Desc = {
    Text = "多次元接続「忘れられた愛の種子」をクリア"
  },
  Task_130181_Desc = {
    Text = "「晩酌」超難度をクリア"
  },
  Task_130182_Desc = {
    Text = "「食卓」任意の難易度をクリア"
  },
  Task_130183_Desc = {
    Text = "深海界域の覚醒体を使用し「顛倒の新生」で2回勝利"
  },
  Task_130184_Desc = {
    Text = "血肉界域の覚醒体を使用し「顛倒の新生」で1回勝利"
  },
  Task_130185_Desc = {
    Text = "「学校」任意の難易度をクリア"
  },
  Task_130186_Desc = {
    Text = "「病院」任意の難易度をクリア"
  },
  Task_130187_Desc = {
    Text = "「晩酌」任意の難易度をクリア"
  },
  Task_130188_Desc = {
    Text = "「病院」超難度をクリア"
  },
  Task_130189_Desc = {
    Text = "混沌界域の覚醒体を使用し「顛倒の新生」で1回勝利"
  },
  Task_130190_Desc = {
    Text = "血肉界域の覚醒体を使用し「顛倒の新生」で2回勝利"
  },
  Task_130191_Desc = {
    Text = "「井戸」超難度をクリア"
  },
  Task_130192_Desc = {
    Text = "超次元界域の覚醒体を使用し「顛倒の新生」で2回勝利"
  },
  Task_130193_Desc = {
    Text = "「学校」超難度をクリア"
  },
  Task_130194_Desc = {
    Text = "「食卓」任意の難易度をクリア"
  },
  Task_130195_Desc = {
    Text = "「我が家」任意の難易度をクリア"
  },
  Task_130196_Desc = {
    Text = "「晩酌」任意の難易度をクリア"
  },
  Task_130197_Desc = {
    Text = "「脳障害」任意の難易度をクリア"
  },
  Task_130198_Desc = {
    Text = "深海界域の覚醒体を使用し「顛倒の新生」で1回勝利"
  },
  Task_130199_Desc = {
    Text = "「脳障害」任意の難易度をクリア"
  },
  Task_130200_Desc = {
    Text = "「井戸」任意の難易度をクリア"
  },
  Task_130201_Desc = {
    Text = "「我が家」任意の難易度をクリア"
  },
  Task_130202_Desc = {
    Text = "「学校」任意の難易度をクリア"
  },
  Task_130203_Desc = {
    Text = "「病院」任意の難易度をクリア"
  },
  Task_130204_Desc = {
    Text = "「井戸」任意の難易度をクリア"
  },
  Task_130205_Desc = {
    Text = "顛倒の新生・超難度"
  },
  Task_130206_Desc = {
    Text = "「我が家」超難度をクリア"
  },
  Task_130207_Desc = {
    Text = "「脳障害」超難度をクリア"
  },
  Task_130208_Desc = {
    Text = "顛倒の新生・界域"
  },
  Task_130209_Desc = {
    Text = "「顛倒の新生・突破」のすべての実績を達成"
  },
  Task_130210_Desc = {
    Text = "顛倒の新生・突破"
  },
  Task_130211_Desc = {
    Text = "超次元界域の覚醒体を使用し「顛倒の新生」で1回勝利"
  },
  Task_130212_Desc = {
    Text = "「食卓」超難度をクリア"
  },
  Task_130213_Desc = {
    Text = "混沌界域の覚醒体を使用し「顛倒の新生」で2回勝利"
  },
  Task_130412_Desc = {
    Text = "本源オジールを得ることで霊知啓発2"
  },
  Task_130412_Name = {
    Text = "本源オジールを得ることで霊知啓発2"
  },
  Task_130412_UnlockCondDesc = {
    Text = "イベント@覚醒体起源オジール霊知啓発ギフト2"
  },
  Task_130413_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130414_Desc = {
    Text = "沙耶の霊知啓発2を獲得する"
  },
  Task_130414_Name = {
    Text = "沙耶の霊知啓発2を獲得する"
  },
  Task_130414_UnlockCondDesc = {
    Text = "イベント@覚醒体沙耶霊知啓発ギフト2"
  },
  Task_130416_Desc = {
    Text = "沙耶の霊知啓発6を獲得する"
  },
  Task_130416_Name = {
    Text = "沙耶の霊知啓発6を獲得する"
  },
  Task_130416_UnlockCondDesc = {
    Text = "イベント@覚醒体沙耶霊知啓発ギフト2"
  },
  Task_130417_Desc = {
    Text = "サトグアの霊知啓発2を獲得する"
  },
  Task_130417_Name = {
    Text = "サトグアの霊知啓発2を獲得する"
  },
  Task_130417_UnlockCondDesc = {
    Text = "イベント@覚醒体サトグア霊知啓発ギフト2"
  },
  Task_130418_Desc = {
    Text = "サトグアの霊知啓発6を獲得する"
  },
  Task_130418_Name = {
    Text = "サトグアの霊知啓発6を獲得する"
  },
  Task_130418_UnlockCondDesc = {
    Text = "イベント@覚醒体サトグア霊知啓発ギフト2"
  },
  Task_130420_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130421_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130424_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130425_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130427_Desc = {
    Text = "起源オジールを得ることで霊知啓発6を獲得する"
  },
  Task_130427_Name = {
    Text = "起源オジールを得ることで霊知啓発6を獲得する"
  },
  Task_130427_UnlockCondDesc = {
    Text = "イベント@覚醒体起源オジール霊知啓発ギフト2"
  },
  Task_130429_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130440_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130441_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130442_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130446_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130447_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130448_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130459_Desc = {
    Text = "起源オジールの同調率がレベル10に到達する"
  },
  Task_130460_Desc = {
    Text = "サトグアの同調率がレベル10に到達する"
  },
  Task_130461_Desc = {
    Text = "沙耶の同調率がレベル10に到達する"
  },
  Task_130555_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_130555_Name = {Text = "3勝"},
  Task_130556_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_130556_Name = {Text = "10勝"},
  Task_130557_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_130557_Name = {Text = "1勝"},
  Task_130558_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_130558_Name = {Text = "6勝"},
  Task_130950_Desc = {
    Text = "「大・渦・潮」狂気の難易度をクリア"
  },
  Task_130951_Desc = {
    Text = "クリア「平凡な毎日」狂気の難易度"
  },
  Task_130952_Desc = {
    Text = "「轟鳴の雷暴」を任意の難易度でクリア"
  },
  Task_130953_Desc = {
    Text = "「仲間の発見」狂気の難易度をクリア"
  },
  Task_130954_Desc = {
    Text = "モスクと海・界域"
  },
  Task_130956_Desc = {
    Text = "「モスクと海・クリア」のすべての成果を達成する"
  },
  Task_130957_Desc = {
    Text = "「大・渦・潮」任意の難易度をクリア"
  },
  Task_130958_Desc = {
    Text = "モスクの霊知啓発6を獲得する"
  },
  Task_130958_Name = {
    Text = "モスクの霊知啓発6を獲得する"
  },
  Task_130958_UnlockCondDesc = {
    Text = "イベント@覚醒体モスク霊知啓発ギフト2"
  },
  Task_130959_Desc = {
    Text = "「大・渦・潮」任意の難易度をクリア"
  },
  Task_130960_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130961_Desc = {
    Text = "モスクと海・クリア"
  },
  Task_130962_Desc = {
    Text = "「帰還の道」任意の難易度をクリア"
  },
  Task_130963_Desc = {
    Text = "クリア意識潜行「沈溺」"
  },
  Task_130964_Desc = {
    Text = "混沌界域の覚醒体を使用し「モスクと海」で2回勝利する"
  },
  Task_130965_Desc = {
    Text = "クリア「平凡な毎日」任意難易度"
  },
  Task_130966_Desc = {
    Text = "「出海時刻」の任意の難易度をクリア"
  },
  Task_130967_Desc = {
    Text = "「帰還の道」任意の難易度をクリア"
  },
  Task_130968_Desc = {
    Text = "「仲間発見」任意の難易度をクリア"
  },
  Task_130970_Desc = {
    Text = "モスクの霊知啓発2を獲得する"
  },
  Task_130970_Name = {
    Text = "モスクの霊知啓発2を獲得する"
  },
  Task_130970_UnlockCondDesc = {
    Text = "イベント@覚醒体モスク霊知啓発ギフト2"
  },
  Task_130971_Desc = {
    Text = "血肉界域の覚醒体を使用して「モスクと海」で1回勝利する"
  },
  Task_130972_Desc = {
    Text = "「轟鳴の雷暴」を任意の難易度でクリア"
  },
  Task_130973_Desc = {
    Text = "「漂流の宝物」狂気の難易度をクリア"
  },
  Task_130974_Desc = {
    Text = "「出海の瞬間」狂気の難易度をクリア"
  },
  Task_130975_Desc = {
    Text = "モスクの同調率がレベル10に到達する"
  },
  Task_130976_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130977_Desc = {
    Text = "「仲間発見」任意の難易度をクリア"
  },
  Task_130978_Desc = {
    Text = "深海界域の覚醒体を使用し「モスクと海」で1回勝利する"
  },
  Task_130979_Desc = {
    Text = "「轟鳴の雷暴」狂気の難易度をクリア"
  },
  Task_130980_Desc = {
    Text = "混沌界域の覚醒体を使用し「モスクと海」で1回勝利する"
  },
  Task_130981_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130982_Desc = {
    Text = "「帰航の道」狂気の難易度をクリア"
  },
  Task_130983_Desc = {
    Text = "超次元界域の覚醒体を使用し「モスクと海」で2回勝利する"
  },
  Task_130984_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_130985_Desc = {
    Text = "「出海時刻」の任意の難易度をクリア"
  },
  Task_130986_Desc = {
    Text = "深海界域の覚醒体を使用して「モスクと海」で2回勝利する"
  },
  Task_130987_Desc = {
    Text = "血肉界域覚醒体を使用し「モスクと海」で2回勝利する"
  },
  Task_130988_Desc = {
    Text = "「漂流する宝物」の任意の難易度をクリアする"
  },
  Task_130989_Desc = {
    Text = "超次元界域の覚醒体を使用し「モスクと海」で1回勝利"
  },
  Task_130990_Desc = {
    Text = "クリア「平凡な毎日」任意難易度"
  },
  Task_130991_Desc = {
    Text = "「漂流する宝物」の任意の難易度をクリアする"
  },
  Task_130992_Desc = {
    Text = "モスクと海・狂気"
  },
  Task_131106_Desc = {
    Text = "ネフレアを阻止する"
  },
  Task_131106_Name = {Text = "目標"},
  Task_131172_Desc = {
    Text = "共役の運命·期間限定専用"
  },
  Task_131371_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_131372_Desc = {
    Text = "累計で召喚を30回行う"
  },
  Task_131373_Desc = {
    Text = "累計で召喚を30回行う"
  },
  Task_131374_Desc = {
    Text = "エンフェリンを1500消費"
  },
  Task_131375_Desc = {
    Text = "1週間のすべての毎週試練任務を完了する"
  },
  Task_131376_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_131377_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_131378_Desc = {
    Text = "1週間のすべての毎週試練任務を完了する"
  },
  Task_131379_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_131380_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_131381_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_131382_Desc = {
    Text = "エンフェリンを1500消費"
  },
  Task_131383_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_131384_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_131385_Desc = {
    Text = "ライカーの試遊ステージを1回クリア"
  },
  Task_131386_Desc = {
    Text = "ライカーの試遊ステージを1回クリア"
  },
  Task_131450_Desc = {
    Text = "対人戦で60体の覚醒体を撃破する"
  },
  Task_131451_Desc = {
    Text = "対人戦で36名の覚醒体を撃破"
  },
  Task_131452_Desc = {
    Text = "プレセットモードで10勝を獲得"
  },
  Task_131453_Desc = {
    Text = "対人戦で740回カードを使用する"
  },
  Task_131454_Desc = {
    Text = "対人戦で狂気解放を108回発動する"
  },
  Task_131455_Desc = {
    Text = "対人戦で狂気解放を192回発動する"
  },
  Task_131456_Desc = {
    Text = "対人戦で狂気解放を60回リリースする"
  },
  Task_131457_Desc = {
    Text = "対人戦で111名の覚醒体を撃破する"
  },
  Task_131458_Desc = {
    Text = "対人戦で300回カードを出す"
  },
  Task_131459_Desc = {
    Text = "対人戦でカードを480回出す"
  },
  Task_131460_Desc = {
    Text = "相位対弈で320回カードを出す"
  },
  Task_131461_Desc = {
    Text = "対人戦で6体の覚醒体を撃破する"
  },
  Task_131462_Desc = {
    Text = "対人戦で129体の覚醒体を撃破する"
  },
  Task_131463_Desc = {
    Text = "対人戦で狂気解放を102回使用する"
  },
  Task_131464_Desc = {
    Text = "対人戦で100回カードを使用する"
  },
  Task_131465_Desc = {
    Text = "対人戦で狂気解放を66回リリースする"
  },
  Task_131466_Desc = {
    Text = "対人戦で12名の覚醒体を撃破する"
  },
  Task_131467_Desc = {
    Text = "対人戦で累計45勝を獲得"
  },
  Task_131468_Desc = {
    Text = "対人戦で狂気の爆発を54回リリースする"
  },
  Task_131469_Desc = {
    Text = "対人戦で狂気解放を240回放つ"
  },
  Task_131470_Desc = {
    Text = "対人戦で99人の覚醒体を撃破する"
  },
  Task_131471_Desc = {
    Text = "対人戦で87体の覚醒体を撃破する"
  },
  Task_131472_Desc = {
    Text = "ローテーションモードで、もう一回プレイして相手を1回倒してください"
  },
  Task_131473_Desc = {
    Text = "相位対弈で30人の覚醒体を撃破する"
  },
  Task_131474_Desc = {
    Text = "プレセットモードで、連勝2回を1回達成"
  },
  Task_131475_Desc = {
    Text = "ローテーションモードで2回勝利を獲得"
  },
  Task_131476_Desc = {
    Text = "対人戦で狂気解放を156回使用する"
  },
  Task_131477_Desc = {
    Text = "ローテーションモードで6回勝利する"
  },
  Task_131478_Desc = {
    Text = "対人戦で160回カードを出す"
  },
  Task_131479_Desc = {
    Text = "対人戦で135体の覚醒体を撃破する"
  },
  Task_131480_Desc = {
    Text = "対人戦で880回カードを出す"
  },
  Task_131481_Desc = {
    Text = "対人戦で狂気解放を132回発動"
  },
  Task_131482_Desc = {
    Text = "対人戦で狂気の爆発を204回リリースする"
  },
  Task_131483_Desc = {
    Text = "プレセットモードで4回勝利を獲得する"
  },
  Task_131484_Desc = {
    Text = "対人戦で狂気解放を144回リリースする"
  },
  Task_131485_Desc = {
    Text = "対人戦で240回カードを使用する"
  },
  Task_131486_Desc = {
    Text = "対人戦で940回カードを出す"
  },
  Task_131487_Desc = {
    Text = "対人戦で狂気解放を210回リリースする"
  },
  Task_131488_Desc = {
    Text = "対人戦で狂気解放を174回リリースする"
  },
  Task_131489_Desc = {
    Text = "対人戦で54体の覚醒体を倒す"
  },
  Task_131490_Desc = {
    Text = "対人戦で21体の覚醒体を撃破する"
  },
  Task_131491_Desc = {
    Text = "対人戦で180回カードを使用する"
  },
  Task_131492_Desc = {
    Text = "栄誉の試練"
  },
  Task_131493_Desc = {
    Text = "相位対弈で400回カードを使用する"
  },
  Task_131494_Desc = {
    Text = "対人戦で57体の覚醒体を撃破する"
  },
  Task_131495_Desc = {
    Text = "ローテーションモードで8回勝利を獲得する"
  },
  Task_131496_Desc = {
    Text = "対人戦で81体の覚醒体を撃破する"
  },
  Task_131497_Desc = {
    Text = "対人戦で93体の覚醒体を撃破する"
  },
  Task_131498_Desc = {
    Text = "対人戦で120体の覚醒体を撃破する"
  },
  Task_131499_Desc = {
    Text = "対人戦で狂気解放を30回リリースする"
  },
  Task_131500_Desc = {
    Text = "対人戦で220回カードを使用する"
  },
  Task_131501_Desc = {
    Text = "対人戦で狂気解放を264回リリースする"
  },
  Task_131502_Desc = {
    Text = "対人戦で102体の覚醒体を撃破する"
  },
  Task_131503_Desc = {
    Text = "対人戦で140回カードを出す"
  },
  Task_131504_Desc = {
    Text = "対人戦で狂気解放を96回放つ"
  },
  Task_131505_Desc = {
    Text = "プレセットモードで、もう一回相手を1回撃破する"
  },
  Task_131506_Desc = {
    Text = "対人戦で狂気解放を78回放つ"
  },
  Task_131507_Desc = {
    Text = "対人戦で1000回カードを使用する"
  },
  Task_131508_Desc = {
    Text = "対人戦で狂気解放を90回放つ"
  },
  Task_131509_Desc = {
    Text = "対人戦で132体の覚醒体を撃破する"
  },
  Task_131510_Desc = {
    Text = "対人戦で126体の覚醒体を撃破する"
  },
  Task_131511_Desc = {
    Text = "対人戦で9体の覚醒体を撃破する"
  },
  Task_131512_Desc = {
    Text = "対人戦で狂気解放を168回発動する"
  },
  Task_131513_Desc = {
    Text = "対人戦で狂気解放を162回放つ"
  },
  Task_131514_Desc = {
    Text = "対人戦で狂気解放を222回発動する"
  },
  Task_131515_Desc = {
    Text = "臨界点の試練"
  },
  Task_131516_Desc = {
    Text = "対人戦で380回カードを出す"
  },
  Task_131517_Desc = {
    Text = "対人戦で660回カードを使用する"
  },
  Task_131518_Desc = {
    Text = "対人戦で狂気解放を114回リリースする"
  },
  Task_131519_Desc = {
    Text = "対人戦で狂気解放を120回使用する"
  },
  Task_131520_Desc = {
    Text = "対人戦で144体の覚醒体を撃破する"
  },
  Task_131521_Desc = {
    Text = "対人戦で24名の覚醒体を撃破する"
  },
  Task_131522_Desc = {
    Text = "相位対人戦で42名の覚醒体を撃破する"
  },
  Task_131523_Desc = {
    Text = "対人戦で460回カードを出す"
  },
  Task_131524_Desc = {
    Text = "対人戦で狂気解放を180回使用する"
  },
  Task_131525_Desc = {
    Text = "対人戦で520回出牌する"
  },
  Task_131526_Desc = {
    Text = "対人戦で840回出牌する"
  },
  Task_131527_Desc = {
    Text = "対人戦で69名の覚醒体を撃破する"
  },
  Task_131528_Desc = {
    Text = "対人戦で720回カードを使用する"
  },
  Task_131529_Desc = {
    Text = "対人戦で33名の覚醒体を撃破"
  },
  Task_131530_Desc = {
    Text = "対人戦で39人の覚醒体を撃破する"
  },
  Task_131531_Desc = {
    Text = "対人戦で860回カードを出す"
  },
  Task_131532_Desc = {
    Text = "対人戦で560回カードを使用する"
  },
  Task_131533_Desc = {
    Text = "対人戦で600回カードを出す"
  },
  Task_131534_Desc = {
    Text = "対人戦でアイコンをクリックして3人の相手に任意のかおもじを送信"
  },
  Task_131535_Desc = {
    Text = "対人戦で66体の覚醒体を撃破する"
  },
  Task_131536_Desc = {
    Text = "対人戦で200回カードを出す"
  },
  Task_131537_Desc = {
    Text = "ローテーションモードで1回勝利を獲得"
  },
  Task_131538_Desc = {
    Text = "対人戦で狂気解放を234回リリースする"
  },
  Task_131539_Desc = {
    Text = "対人戦で820回カードを出す"
  },
  Task_131540_Desc = {
    Text = "対人戦で狂気解放を18回発動する"
  },
  Task_131541_Desc = {
    Text = "対人戦で63名の覚醒体を撃破する"
  },
  Task_131542_Desc = {
    Text = "対人戦で狂気解放を258回リリースする"
  },
  Task_131543_Desc = {
    Text = "対人戦が終了した後、相手にいいねを1回する"
  },
  Task_131544_Desc = {
    Text = "対人戦で累計25勝する"
  },
  Task_131545_Desc = {
    Text = "27名の覚醒体を対人戦で撃破する"
  },
  Task_131546_Desc = {
    Text = "対人戦で18名の覚醒体を撃破する"
  },
  Task_131547_Desc = {
    Text = "対人戦で150体の覚醒体を撃破する"
  },
  Task_131548_Desc = {
    Text = "対人戦で狂気の爆発を48回リリースする"
  },
  Task_131549_Desc = {
    Text = "対人戦で20回カードを出す"
  },
  Task_131550_Desc = {
    Text = "対人戦で狂気の爆発を36回リリースする"
  },
  Task_131551_Desc = {
    Text = "対人戦で15体の覚醒体を撃破する"
  },
  Task_131552_Desc = {
    Text = "対人戦で84体の覚醒体を撃破する"
  },
  Task_131553_Desc = {
    Text = "対人戦で280回カードを使用する"
  },
  Task_131554_Desc = {
    Text = "対人戦で狂気解放を72回リリースする"
  },
  Task_131555_Desc = {
    Text = "対人戦で108体の覚醒体を撃破する"
  },
  Task_131556_Desc = {
    Text = "対人戦で狂気解放を246回発動する"
  },
  Task_131557_Desc = {
    Text = "対人戦で700回カードを出す"
  },
  Task_131558_Desc = {
    Text = "対人戦で累計35勝を獲得する"
  },
  Task_131559_Desc = {
    Text = "対人戦で累計50勝する"
  },
  Task_131560_Desc = {
    Text = "対人戦で覚醒体3体を撃破する"
  },
  Task_131561_Desc = {
    Text = "対人戦で75体の覚醒体を撃破する"
  },
  Task_131562_Desc = {
    Text = "対人戦で51体の覚醒体を撃破する"
  },
  Task_131563_Desc = {
    Text = "対人戦で120回カードを出す"
  },
  Task_131564_Desc = {
    Text = "対人戦で78体の覚醒体を撃破する"
  },
  Task_131565_Desc = {
    Text = "対人戦で138体の覚醒体を撃破する"
  },
  Task_131566_Desc = {
    Text = "対人戦で90体の覚醒体を撃破する"
  },
  Task_131567_Desc = {
    Text = "秘儀の試練"
  },
  Task_131568_Desc = {
    Text = "プレセットモードで6回勝利する"
  },
  Task_131569_Desc = {
    Text = "プレセットモードで8回勝利を獲得する"
  },
  Task_131570_Desc = {
    Text = "対人戦で117体の覚醒体を撃破する"
  },
  Task_131571_Desc = {
    Text = "対人戦で累計40勝する"
  },
  Task_131572_Desc = {
    Text = "対人戦で狂気解放を126回使用する"
  },
  Task_131573_Desc = {
    Text = "相位対弈で760回カードを使用する"
  },
  Task_131574_Desc = {
    Text = "対人戦で狂気解放を270回発動"
  },
  Task_131575_Desc = {
    Text = "プレセットモードで、1回の勝利を得る"
  },
  Task_131576_Desc = {
    Text = "対人戦で狂気解放を84回発動する"
  },
  Task_131577_Desc = {
    Text = "対人戦で狂気解放を294回リリースする"
  },
  Task_131578_Desc = {
    Text = "対人戦で累計30勝する"
  },
  Task_131579_Desc = {
    Text = "対人戦でカードを960回使用する"
  },
  Task_131580_Desc = {
    Text = "対人戦で260回カードを出す"
  },
  Task_131581_Desc = {
    Text = "対人戦で狂気解放を42回発動する"
  },
  Task_131582_Desc = {
    Text = "対人戦で96体の覚醒体を撃破する"
  },
  Task_131583_Desc = {
    Text = "対人戦で狂気の爆発を228回リリースする"
  },
  Task_131584_Desc = {
    Text = "対人戦で40回カードを出す"
  },
  Task_131585_Desc = {
    Text = "対人戦で800回カードを出す"
  },
  Task_131586_Desc = {
    Text = "対人戦で580回カードを使用する"
  },
  Task_131587_Desc = {
    Text = "対人戦で狂気解放を150回放つ"
  },
  Task_131588_Desc = {
    Text = "対人戦で114体の覚醒体を撃破する"
  },
  Task_131589_Desc = {
    Text = "対人戦でカードを780回使用する"
  },
  Task_131590_Desc = {
    Text = "対人戦で狂気解放を24回放つ"
  },
  Task_131591_Desc = {
    Text = "対人戦で狂気解放を216回リリースする"
  },
  Task_131592_Desc = {
    Text = "対人戦で狂気解放を276回リリースする"
  },
  Task_131593_Desc = {
    Text = "対人戦で500回カードを出す"
  },
  Task_131594_Desc = {
    Text = "対人戦で147体の覚醒体を撃破する"
  },
  Task_131595_Desc = {
    Text = "プレセットモードで2回勝利を獲得"
  },
  Task_131596_Desc = {
    Text = "対人戦で72体の覚醒体を撃破する"
  },
  Task_131597_Desc = {
    Text = "対人戦で640回カードを使用する"
  },
  Task_131598_Desc = {
    Text = "対人戦で105体の覚醒体を撃破する"
  },
  Task_131599_Desc = {
    Text = "対人戦で狂気解放を300回放つ"
  },
  Task_131600_Desc = {
    Text = "対人戦で48体の覚醒体を撃破する"
  },
  Task_131601_Desc = {
    Text = "対人戦で920回カードを出す"
  },
  Task_131602_Desc = {
    Text = "対人戦で60回カードを使用する"
  },
  Task_131603_Desc = {
    Text = "対人戦で360回カードを使用する"
  },
  Task_131604_Desc = {
    Text = "対人戦で狂気の爆発を282回リリースする"
  },
  Task_131605_Desc = {
    Text = "相位対弈で440回カードを出す"
  },
  Task_131606_Desc = {
    Text = "対人戦で123名の覚醒体を撃破する"
  },
  Task_131607_Desc = {
    Text = "対人戦で狂気解放を198回リリースする"
  },
  Task_131608_Desc = {
    Text = "対人戦でカードを680回使用する"
  },
  Task_131609_Desc = {
    Text = "対人戦で45体の覚醒体を撃破する"
  },
  Task_131610_Desc = {
    Text = "ローテーションモードで、連勝を2回達成"
  },
  Task_131611_Desc = {
    Text = "対人戦で狂気解放を186回リリースする"
  },
  Task_131612_Desc = {
    Text = "対人戦で狂気解放を6回放つ"
  },
  Task_131613_Desc = {
    Text = "対人戦で620回カードを使用する"
  },
  Task_131614_Desc = {
    Text = "ローテーションモードで、連勝を2回達成する1回"
  },
  Task_131615_Desc = {
    Text = "対人戦で900回カードを出す"
  },
  Task_131616_Desc = {
    Text = "対人戦で狂気解放を252回発動する"
  },
  Task_131617_Desc = {
    Text = "対人戦でカードを980回使用する"
  },
  Task_131618_Desc = {
    Text = "対人戦で141体の覚醒体を撃破する"
  },
  Task_131619_Desc = {
    Text = "対人戦で狂気解放を288回リリースする"
  },
  Task_131620_Desc = {
    Text = "相位対弈で420回カードを出す"
  },
  Task_131621_Desc = {
    Text = "ローテーションモードで10勝を獲得"
  },
  Task_131622_Desc = {
    Text = "相位対弈で340回カードを出す"
  },
  Task_131623_Desc = {
    Text = "ローテーションモードで4回勝利を獲得する"
  },
  Task_131624_Desc = {
    Text = "対人戦で80回カードを使用する"
  },
  Task_131625_Desc = {
    Text = "プレセットモードで、連勝2回"
  },
  Task_131626_Desc = {
    Text = "対人戦で540回カードを出す"
  },
  Task_131627_Desc = {
    Text = "対人戦で狂気解放を138回発動"
  },
  Task_131628_Desc = {
    Text = "対人戦で狂気解放を12回発動する"
  },
  Task_131768_Desc = {
    Text = "意識潜行「沈溺」を完了する"
  },
  Task_131768_Name = {
    Text = "チュッ！"
  },
  Task_131801_Name = {
    Text = "逆転回合復刻イベント終了"
  },
  Task_131891_Desc = {
    Text = "永遠の記憶·期間限定特典"
  },
  Task_131892_Desc = {
    Text = "永遠の記憶Ⅴ"
  },
  Task_131893_Desc = {
    Text = "永遠の記憶Ⅶ"
  },
  Task_131894_Desc = {
    Text = "永遠の記憶Ⅱ"
  },
  Task_131895_Desc = {
    Text = "永遠の記憶Ⅰ"
  },
  Task_131896_Desc = {
    Text = "永遠の記憶·無料"
  },
  Task_131897_Desc = {
    Text = "永遠の記憶Ⅲ"
  },
  Task_131898_Desc = {
    Text = "永遠の記憶Ⅳ"
  },
  Task_131899_Desc = {
    Text = "永遠の記憶Ⅵ"
  },
  Task_132335_Desc = {
    Text = "意識潜行「戴冠の日」をクリア"
  },
  Task_132454_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_132454_Name = {Text = "10勝"},
  Task_132455_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_132455_Name = {Text = "3勝"},
  Task_132456_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_132456_Name = {Text = "6勝"},
  Task_132457_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_132457_Name = {Text = "1勝"},
  Task_132689_Desc = {
    Text = "PC端末でログイン"
  },
  Task_132690_Desc = {
    Text = "携帯端末で1回プラチナジェルを抽出"
  },
  Task_132691_Desc = {
    Text = "PC端末で1回プラチナジェルを抽出"
  },
  Task_132692_Desc = {
    Text = "携帯端末でログイン"
  },
  Task_132874_Desc = {
    Text = "第三段階のボスを1回撃破"
  },
  Task_132875_Desc = {
    Text = "今シーズン5回勝利する"
  },
  Task_132876_Desc = {
    Text = "今シーズン5回勝利する"
  },
  Task_132877_Desc = {
    Text = "今シーズン「幻夢深潜」を3回クリアする"
  },
  Task_132909_Desc = {
    Text = "アラクネの試遊ステージを1回クリア"
  },
  Task_132910_Desc = {
    Text = "派遣を15回完了する"
  },
  Task_132911_Desc = {
    Text = "任意のシーズン任務を1つ完了する"
  },
  Task_132912_Desc = {
    Text = "累計300枚のカードを使用する"
  },
  Task_132913_Desc = {
    Text = "任意のシーズン任務を1つ完了する"
  },
  Task_132914_Desc = {
    Text = "30回覚醒"
  },
  Task_132915_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_132916_Desc = {
    Text = "アラクネの試遊ステージを1回クリア"
  },
  Task_132917_Desc = {
    Text = "派遣を15回完了する"
  },
  Task_132918_Desc = {
    Text = "ログイン累計1日"
  },
  Task_132919_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_132920_Desc = {
    Text = "週間アクティブ度1000に到達する"
  },
  Task_132921_Desc = {
    Text = "週間アクティブ度1000に到達する"
  },
  Task_132922_Desc = {
    Text = "累計300枚のカードを使用する"
  },
  Task_132923_Desc = {
    Text = "ログイン累計1日"
  },
  Task_132924_Desc = {
    Text = "30回覚醒"
  },
  Task_132928_Desc = {
    Text = "上記の全任務を完了"
  },
  Task_132929_Desc = {
    Text = "エンフェリンを1800ポイント消費する"
  },
  Task_132930_Desc = {
    Text = "1週のすべての週間試練タスクを完了する"
  },
  Task_132931_Desc = {
    Text = "累積ログイン 1 日"
  },
  Task_132932_Desc = {
    Text = "20回の派遣を完了"
  },
  Task_132933_Desc = {
    Text = "融災禁域特訓値が100に達しました"
  },
  Task_133297_Desc = {
    Text = "異夢視界「キッチン征服記」を完了する"
  },
  Task_133297_Name = {
    Text = "歓喜！激怒！涙！"
  },
  Task_133302_Desc = {
    Text = "「精粋活性イオン」が1000に到達"
  },
  Task_133303_Desc = {
    Text = "救援を3回使用する"
  },
  Task_133304_Desc = {
    Text = "「精粋活性イオン」が1000に到達"
  },
  Task_133305_Desc = {
    Text = "累計300枚のカードを使用する"
  },
  Task_133306_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_133307_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_133308_Desc = {
    Text = "累計300枚のカードを使用する"
  },
  Task_133309_Desc = {
    Text = "30回覚醒"
  },
  Task_133310_Desc = {
    Text = "ログイン累計1日"
  },
  Task_133311_Desc = {
    Text = "「禁忌試練」のシーズンタスクをクリアする"
  },
  Task_133312_Desc = {
    Text = "30回覚醒"
  },
  Task_133313_Desc = {
    Text = "派遣を15回完了する"
  },
  Task_133314_Desc = {
    Text = "「禁忌試練」のシーズンタスクをクリアする"
  },
  Task_133315_Desc = {
    Text = "救援を3回使用する"
  },
  Task_133316_Desc = {
    Text = "ログイン累計1日"
  },
  Task_133317_Desc = {
    Text = "派遣を15回完了する"
  },
  Task_133940_Desc = {
    Text = "フレンドに「いいね」を1回する"
  },
  Task_133940_Name = {
    Text = "フレンド「いいね」"
  },
  Task_133941_Desc = {
    Text = "180工ンフェリンを消費する"
  },
  Task_133941_Name = {
    Text = "スタミナを消耗"
  },
  Task_133943_Desc = {
    Text = "50枚のカードを使用する"
  },
  Task_133943_Name = {
    Text = "日々の訓練"
  },
  Task_133944_Desc = {
    Text = "派遣を3回実行する"
  },
  Task_133944_Name = {
    Text = "派遣を行う"
  },
  Task_133945_Desc = {
    Text = "密契転写を50回完了する"
  },
  Task_133945_Name = {
    Text = "密約転写"
  },
  Task_133946_Desc = {
    Text = "超越存在を1回完了する"
  },
  Task_133946_Name = {
    Text = "ウィークリーBOSS"
  },
  Task_133947_Desc = {
    Text = "30回召喚儀式を行う"
  },
  Task_133947_Name = {
    Text = "カードを引く"
  },
  Task_133948_Desc = {
    Text = "1500工ンフェリンを消費する"
  },
  Task_133948_Name = {
    Text = "スタミナを消耗"
  },
  Task_133949_Desc = {
    Text = "薔薇金券を100万消費する"
  },
  Task_133949_Name = {
    Text = "金を湯水のように使う"
  },
  Task_134074_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_134074_Desc2 = {
    Text = "調査事件「運命劇場」を完了しました"
  },
  Task_134074_Name2 = {
    Text = "運命の主演"
  },
  Task_134075_Desc = {
    Text = "調査事件「運命劇場」を難しい難易度で完了しました"
  },
  Task_134075_Name = {
    Text = "運命の主演·困難"
  },
  Task_134095_Desc = {
    Text = "調査「@1@2」で3回共鳴する"
  },
  Task_134095_Desc2 = {
    Text = "調査事件「運命劇場」で共鳴3回"
  },
  Task_134095_Name2 = {
    Text = "依従の残響"
  },
  Task_134096_Desc = {
    Text = "調査「@1@2」で共鳴10回"
  },
  Task_134096_Desc2 = {
    Text = "調査事件「運命劇場」で共鳴10回"
  },
  Task_134096_Name2 = {
    Text = "依従の残響Ⅳ"
  },
  Task_134097_Desc = {
    Text = "調査「@1@2」で9回共鳴する"
  },
  Task_134097_Desc2 = {
    Text = "調査事件「運命劇場」で共鳴9回"
  },
  Task_134097_Name2 = {
    Text = "依従の残響Ⅲ"
  },
  Task_134098_Desc = {
    Text = "調査「@1@2」で6回共鳴する"
  },
  Task_134098_Desc2 = {
    Text = "調査事件「運命劇場」で共鳴6回"
  },
  Task_134098_Name2 = {
    Text = "依従の残響Ⅱ"
  },
  Task_134099_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_134099_Name = {
    Text = "完璧な通過"
  },
  Task_134121_Desc = {
    Text = "カラブの人格深化が12に到達する"
  },
  Task_134122_Desc = {
    Text = "ケイクスの人格深化が12に到達する"
  },
  Task_134123_Desc = {
    Text = "ファロスの人格深化が12に到達する"
  },
  Task_134124_Desc = {
    Text = "モシャの人格深化が12に到達する"
  },
  Task_134125_Desc = {
    Text = "サヤの人格深化が12に到達する"
  },
  Task_134126_Desc = {
    Text = "ツァトグアの人格深化が12に到達する"
  },
  Task_134127_Desc = {
    Text = "タイースの人格深化が12に到達する"
  },
  Task_134128_Desc = {
    Text = "本源眠れる主の人格深化が12に到達する"
  },
  Task_134129_Desc = {
    Text = "シロの人格深化が12に到達する"
  },
  Task_134130_Desc = {
    Text = "タヴィの人格深化が12に到達する"
  },
  Task_134131_Desc = {
    Text = "ポリュクスの人格深化が12に到達する"
  },
  Task_134132_Desc = {
    Text = "「24」の人格深化が12に到達する"
  },
  Task_134134_Desc = {
    Text = "ユウハシの人格深化が12に到達する"
  },
  Task_134135_Desc = {
    Text = "誕妄·モーフィの人格深化が12に到達する"
  },
  Task_134136_Desc = {
    Text = "溶毀·ドールの人格深化が12に到達する"
  },
  Task_134137_Desc = {
    Text = "ピックマンの人格深化が12に到達する"
  },
  Task_134138_Desc = {
    Text = "パンディアの人格深化が12に到達する"
  },
  Task_134140_Desc = {
    Text = "オルラの人格深化が12に到達する"
  },
  Task_134141_Desc = {
    Text = "シュイの人格深化が12に到達する"
  },
  Task_134142_Desc = {
    Text = "ティンクトの人格深化が12に到達する"
  },
  Task_134143_Desc = {
    Text = "カティグラの人格深化が12に到達する"
  },
  Task_134144_Desc = {
    Text = "レアの人格深化が12に到達する"
  },
  Task_134145_Desc = {
    Text = "モーフィの人格深化が12に到達する"
  },
  Task_134146_Desc = {
    Text = "ドゥルセインの人格深化が12に到達する"
  },
  Task_134148_Desc = {
    Text = "コーパサントの人格深化が12に到達する"
  },
  Task_134149_Desc = {
    Text = "リリの人格深化が12に到達する"
  },
  Task_134150_Desc = {
    Text = "血鎖·シロの人格深化が12に到達する"
  },
  Task_134151_Desc = {
    Text = "ウィンクルの人格深化が12に到達する"
  },
  Task_134152_Desc = {
    Text = "ハムリンの人格深化が12に到達する"
  },
  Task_134153_Desc = {
    Text = "ライクの人格深化が12に到達する"
  },
  Task_134154_Desc = {
    Text = "シャンの人格深化が12に到達する"
  },
  Task_134155_Desc = {
    Text = "カシアの人格深化が12に到達する"
  },
  Task_134156_Desc = {
    Text = "カストルの人格深化が12に到達する"
  },
  Task_134157_Desc = {
    Text = "モスの人格深化が12に到達する"
  },
  Task_134158_Desc = {
    Text = "フェイントの人格深化が12に到達する"
  },
  Task_134159_Desc = {
    Text = "ノディラの人格深化が12に到達する"
  },
  Task_134160_Desc = {
    Text = "アグリッパの人格深化が12に到達する"
  },
  Task_134161_Desc = {
    Text = "ジェンキンの人格深化が12に到達する"
  },
  Task_134162_Desc = {
    Text = "サルヴァドの人格深化が12に到達する"
  },
  Task_134163_Desc = {
    Text = "アラクネは人格の深化12に達しました"
  },
  Task_134164_Desc = {
    Text = "ダフデルの人格深化が12に到達する"
  },
  Task_134165_Desc = {
    Text = "シレストの人格深化が12に到達する"
  },
  Task_134166_Desc = {
    Text = "ソレイルの人格深化が12に到達する"
  },
  Task_134167_Desc = {
    Text = "ゴリアの人格深化が12に到達する"
  },
  Task_134168_Desc = {
    Text = "トゥルの人格深化が12に到達する"
  },
  Task_134169_Desc = {
    Text = "クレメンティンの人格深化が12に到達する"
  },
  Task_134170_Desc = {
    Text = "カレンの人格深化が12に到達する"
  },
  Task_134171_Desc = {
    Text = "ニンフィアの人格深化が12に到達する"
  },
  Task_134172_Desc = {
    Text = "ワンダの人格深化が12に到達する"
  },
  Task_134173_Desc = {
    Text = "リズの人格深化が12に到達する"
  },
  Task_134174_Desc = {
    Text = "エルヴァの人格深化が12に到達する"
  },
  Task_134175_Desc = {
    Text = "ミリアムの人格深化が12に到達する"
  },
  Task_134394_Desc = {
    Text = "累計ログイン 6 日"
  },
  Task_134395_Desc = {
    Text = "累計ログイン 10 日"
  },
  Task_134396_Desc = {
    Text = "累計ログイン 16 日"
  },
  Task_134397_Desc = {
    Text = "累計ログイン 7 日"
  },
  Task_134398_Desc = {
    Text = "累計ログイン 15 日"
  },
  Task_134399_Desc = {
    Text = "累計ログイン 9 日"
  },
  Task_134400_Desc = {
    Text = "累計ログイン 4 日"
  },
  Task_134401_Desc = {
    Text = "累計ログイン 14 日"
  },
  Task_134402_Desc = {
    Text = "累計ログイン 5 日"
  },
  Task_134403_Desc = {
    Text = "累計ログイン 11 日"
  },
  Task_134404_Desc = {
    Text = "累計ログイン 13 日"
  },
  Task_134405_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_134406_Desc = {
    Text = "累計ログイン 2 日"
  },
  Task_134407_Desc = {
    Text = "累計ログイン 3 日"
  },
  Task_134408_Desc = {
    Text = "累計ログイン 8 日"
  },
  Task_134409_Desc = {
    Text = "累計ログイン 12 日"
  },
  Task_135038_Desc = {
    Text = "ゲームにログインする"
  },
  Task_135038_Name = {
    Text = "ゲームにログインする"
  },
  Task_137649_Desc = {
    Text = "150枚のカードを使用"
  },
  Task_137650_Desc = {
    Text = "150枚のカードを使用"
  },
  Task_138583_Desc = {
    Text = "30回覚醒"
  },
  Task_138584_Desc = {
    Text = "「禁忌試練」のシーズンタスクをクリアする"
  },
  Task_138585_Desc = {
    Text = "累計300枚のカードを使用する"
  },
  Task_138586_Desc = {
    Text = "救援を3回使用する"
  },
  Task_138587_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_138588_Desc = {
    Text = "ログイン累計1日"
  },
  Task_138589_Desc = {
    Text = "30回覚醒"
  },
  Task_138590_Desc = {
    Text = "派遣を15回完了する"
  },
  Task_138591_Desc = {
    Text = "累計300枚のカードを使用する"
  },
  Task_138592_Desc = {
    Text = "救援を3回使用する"
  },
  Task_138593_Desc = {
    Text = "「精粋活性イオン」が1000に到達"
  },
  Task_138594_Desc = {
    Text = "「精粋活性イオン」が1000に到達"
  },
  Task_138595_Desc = {
    Text = "ログイン累計1日"
  },
  Task_138596_Desc = {
    Text = "「禁忌試練」のシーズンタスクをクリアする"
  },
  Task_138597_Desc = {
    Text = "派遣を15回完了する"
  },
  Task_138598_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_138762_Desc = {
    Text = "「運命を凌駕する悲歌」を受けた後、「背信の網」ネフレアを撃破する。"
  },
  Task_138762_Name = {
    Text = "運命の主演・隠し"
  },
  Task_139118_Desc = {
    Text = "多次元接続「忘れられた愛の種子」を完了"
  },
  Task_139119_Desc = {
    Text = "上記の全任務を完了"
  },
  Task_139121_Desc = {
    Text = "1000回覚醒する"
  },
  Task_139123_Desc = {
    Text = "250回覚醒する"
  },
  Task_139124_Desc = {
    Text = "ログイン 1 日"
  },
  Task_139125_Desc = {
    Text = "調査「忘却篇・第4章」通常を完了"
  },
  Task_139126_Desc = {
    Text = "500回覚醒する"
  },
  Task_139127_Desc = {
    Text = "100回覚醒する"
  },
  Task_139600_Desc = {
    Text = "累計捕獲 1000000回"
  },
  Task_139614_Desc = {
    Text = "累計捕獲 500000回"
  },
  Task_139618_Desc = {
    Text = "累計捕獲 50回"
  },
  Task_139619_Desc = {
    Text = "累計捕獲 1000000回"
  },
  Task_139626_Desc = {
    Text = "累計捕獲 300000回"
  },
  Task_139629_Desc = {
    Text = "累計捕獲 700000回"
  },
  Task_139646_Desc = {
    Text = "学園捕獲記録"
  },
  Task_139649_Desc = {
    Text = "累計捕獲 100000回"
  },
  Task_139651_Desc = {
    Text = "個人逮捕記録"
  },
  Task_139652_Desc = {
    Text = "累計捕獲 100回"
  },
  Task_140087_Desc = {
    Text = "「巨物」を1回クリア"
  },
  Task_140088_Desc = {
    Text = "「ブラックゴールドラッシュ」を1回クリア"
  },
  Task_140089_Desc = {
    Text = "「逮捕拒否」を10回クリア"
  },
  Task_140090_Desc = {
    Text = "「網を引け！網を引け！」を5回クリア"
  },
  Task_140091_Desc = {
    Text = "「大漁御礼」を5回クリア"
  },
  Task_140092_Desc = {
    Text = "「逮捕拒否」を1回クリア"
  },
  Task_140093_Desc = {
    Text = "「巨物」を10回クリア"
  },
  Task_140094_Desc = {
    Text = "「最初のシルバーコア」を5回クリア"
  },
  Task_140095_Desc = {
    Text = "「ブラックゴールドラッシュ」を5回クリア"
  },
  Task_140096_Desc = {
    Text = "「最初のシルバーコア」を1回クリア"
  },
  Task_140097_Desc = {
    Text = "「大漁御礼」を10回クリア"
  },
  Task_140098_Desc = {
    Text = "「逮捕拒否」を5回クリア"
  },
  Task_140099_Desc = {
    Text = "「巨物」を5回クリア"
  },
  Task_140100_Desc = {
    Text = "「大漁御礼」を1回クリア"
  },
  Task_140101_Desc = {
    Text = "「網を引け！網を引け！」を10回クリア"
  },
  Task_140102_Desc = {
    Text = "「もう一回」を1回クリア"
  },
  Task_140103_Desc = {
    Text = "「もう一回」を10回クリア"
  },
  Task_140104_Desc = {
    Text = "「最初のシルバーコア」を10回クリア"
  },
  Task_140105_Desc = {
    Text = "「網を引け！網を引け！」を1回クリア"
  },
  Task_140106_Desc = {
    Text = "「ブラックゴールドラッシュ」を10回クリア"
  },
  Task_140107_Desc = {
    Text = "「もう一回」を5回クリア"
  },
  Task_140114_Desc = {
    Text = "多次元接続「忘れられた愛の種子」を完了"
  },
  Task_140115_Desc = {
    Text = "上記の全任務を完了"
  },
  Task_140116_Desc = {
    Text = "ログイン 1 日"
  },
  Task_140117_Desc = {
    Text = "調査「忘却篇・第4章」通常を完了"
  },
  Task_140189_Desc = {
    Text = "累積5000プラチナジェル\n抽出する"
  },
  Task_140190_Desc = {
    Text = "累積20000プラチナジェル\n抽出する"
  },
  Task_140191_Desc = {
    Text = "累積10000プラチナジェル\n抽出する"
  },
  Task_140192_Desc = {
    Text = "累積30000プラチナジェル\n抽出する"
  },
  Task_140306_Desc = {
    Text = "多次元接続「忘れられた愛の種」の困難難易度をクリアする"
  },
  Task_140306_Name = {
    Text = "さすらい人の帰り処·難しい"
  },
  Task_140307_Desc = {
    Text = "多次元接続「忘れられた愛の種」をクリアする"
  },
  Task_140307_Name = {
    Text = "さすらい人の帰り処"
  },
  Task_140463_Desc = {
    Text = "累計200枚のカードを出す"
  },
  Task_140464_Desc = {
    Text = "20回の派遣を完了"
  },
  Task_140465_Desc = {
    Text = "累積ログイン 1 日"
  },
  Task_140466_Desc = {
    Text = "「精粋活性イオン」が1000に到達"
  },
  Task_140467_Desc = {
    Text = "上記の全任務を完了"
  },
  Task_140468_Desc = {
    Text = "「禁忌試練」のシーズンタスクをクリアする"
  },
  Task_141311_Desc = {
    Text = "意識潜行「永遠のエポヤンス」をクリア"
  },
  Task_141312_Desc = {
    Text = "ポントスの同調率がレベル10に達する"
  },
  Task_141313_Desc = {
    Text = "超次元界域覚醒体を使用して「高所巡狩」で1回勝利する"
  },
  Task_141314_Desc = {
    Text = "「森林法典」の狂気の難易度をクリアする"
  },
  Task_141315_Desc = {
    Text = "「麦酒と香辛料」を任意の難易度でクリア"
  },
  Task_141316_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_141317_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_141318_Desc = {
    Text = "「告白」を任意の難易度でクリア"
  },
  Task_141319_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_141320_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_141321_Desc = {
    Text = "血肉界域覚醒体を使用して「高所巡狩」で2回勝利する"
  },
  Task_141322_Desc = {
    Text = "混沌界域の覚醒体を使用して「高所巡狩」で2回勝利する"
  },
  Task_141323_Desc = {
    Text = "深海界域の覚醒体を使用して「高所巡狩」で1回勝利する"
  },
  Task_141324_Desc = {
    Text = "高所巡狩·界域"
  },
  Task_141325_Desc = {
    Text = "「哨笛」の狂気の難易度をクリアする"
  },
  Task_141326_Desc = {
    Text = "「追走ゲーム」を任意の難易度でクリア"
  },
  Task_141327_Desc = {
    Text = "「麦酒と香辛料」を任意の難易度でクリア"
  },
  Task_141328_Desc = {
    Text = "「森林法典」を任意の難易度でクリア"
  },
  Task_141329_Desc = {
    Text = "高所巡狩·狂気"
  },
  Task_141330_Desc = {
    Text = "「二元論」の狂気の難易度をクリアする"
  },
  Task_141331_Desc = {
    Text = "「森林法典」を任意の難易度でクリア"
  },
  Task_141332_Desc = {
    Text = "「麦酒と香辛料」の狂気の難易度をクリアする"
  },
  Task_141333_Desc = {
    Text = "「告白」の狂気の難易度をクリアする"
  },
  Task_141335_Desc = {
    Text = "「肋軟骨」を任意の難易度でクリア"
  },
  Task_141336_Desc = {
    Text = "「二元論」を任意の難易度でクリア"
  },
  Task_141337_Desc = {
    Text = "「高所巡狩·クリア」の全実績を達成"
  },
  Task_141338_Desc = {
    Text = "ポントス入手時の霊知啓発6"
  },
  Task_141338_Name = {
    Text = "ポントス入手時の霊知啓発6"
  },
  Task_141338_UnlockCondDesc = {
    Text = "活動@覚醒体ポントス霊知啓発ギフトパック2活動"
  },
  Task_141339_Desc = {
    Text = "「肋軟骨」を任意の難易度でクリア"
  },
  Task_141340_Desc = {
    Text = "「二元論」を任意の難易度でクリア"
  },
  Task_141341_Desc = {
    Text = "高所巡狩·クリア"
  },
  Task_141342_Desc = {
    Text = "深海界域の覚醒体を使用して「高所巡狩」で2回勝利する"
  },
  Task_141343_Desc = {
    Text = "「哨笛」を任意の難易度でクリア"
  },
  Task_141344_Desc = {
    Text = "「告白」を任意の難易度でクリア"
  },
  Task_141345_Desc = {
    Text = "超次元界域覚醒体を使用して「高所巡狩」で2回勝利する"
  },
  Task_141346_Desc = {
    Text = "混沌界域の覚醒体を使用して「高所巡狩」で1回勝利する"
  },
  Task_141347_Desc = {
    Text = "「追走ゲーム」の狂気の難易度をクリアする"
  },
  Task_141348_Desc = {
    Text = "「哨笛」を任意の難易度でクリア"
  },
  Task_141349_Desc = {
    Text = "血肉界域覚醒体を使用して「高所巡狩」で1回勝利する"
  },
  Task_141350_Desc = {
    Text = "ポントスが人格の深化12に達する"
  },
  Task_141351_Desc = {
    Text = "ポントス入手時の霊知啓発2"
  },
  Task_141351_Name = {
    Text = "ポントス入手時の霊知啓発2"
  },
  Task_141351_UnlockCondDesc = {
    Text = "活動@覚醒体ポントス霊知啓発ギフトパック2活動"
  },
  Task_141352_Desc = {
    Text = "「追走ゲーム」を任意の難易度でクリア"
  },
  Task_141353_Desc = {
    Text = "「肋軟骨」の狂気の難易度をクリアする"
  },
  Task_141511_Desc = {
    Text = "累計300枚のカードを使用する"
  },
  Task_141512_Desc = {
    Text = "「禁忌試練」のシーズンタスクをクリアする"
  },
  Task_141513_Desc = {
    Text = "救援を3回使用する"
  },
  Task_141514_Desc = {
    Text = "派遣を15回完了する"
  },
  Task_141515_Desc = {
    Text = "ログイン累計1日"
  },
  Task_141516_Desc = {
    Text = "ログイン累計1日"
  },
  Task_141517_Desc = {
    Text = "30回覚醒"
  },
  Task_141518_Desc = {
    Text = "「禁忌試練」のシーズンタスクをクリアする"
  },
  Task_141519_Desc = {
    Text = "救援を3回使用する"
  },
  Task_141520_Desc = {
    Text = "「精粋活性イオン」が1000に到達"
  },
  Task_141521_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_141522_Desc = {
    Text = "累計300枚のカードを使用する"
  },
  Task_141523_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_141524_Desc = {
    Text = "30回覚醒"
  },
  Task_141525_Desc = {
    Text = "「精粋活性イオン」が1000に到達"
  },
  Task_141526_Desc = {
    Text = "派遣を15回完了する"
  },
  Task_141799_Desc = {
    Text = "深海界域の覚醒体を使用して「ウマーパティの宝物」で2回勝利"
  },
  Task_141800_Desc = {
    Text = "超次元界域覚醒体を使用して「ウマーパティの宝物」で2回勝利する"
  },
  Task_141801_Desc = {
    Text = "「糸」を任意難度でクリア"
  },
  Task_141802_Desc = {
    Text = "血肉界域覚醒体を使用して「ウマーパティの宝物」で2回勝利する"
  },
  Task_141803_Desc = {
    Text = "「ウマーパティの宝物·クリア」の全実績を達成"
  },
  Task_141804_Desc = {
    Text = "混沌界域の覚醒体を使用して「ウマーパティの宝物」で1回勝利"
  },
  Task_141805_Desc = {
    Text = "「リンゴ」を任意難度でクリア"
  },
  Task_141806_Desc = {
    Text = "「鏡」任意の難易度をクリア"
  },
  Task_141807_Desc = {
    Text = "「鍵」を任意難度でクリア"
  },
  Task_141808_Desc = {
    Text = "「鏡子」超難度をクリア"
  },
  Task_141809_Desc = {
    Text = "「王冠」を狂気の難易度でクリアする"
  },
  Task_141810_Desc = {
    Text = "「羽根」を任意難度でクリア"
  },
  Task_141811_Desc = {
    Text = "「目」を任意難度でクリア"
  },
  Task_141812_Desc = {
    Text = "「糸」を狂気の難易度でクリアする"
  },
  Task_141813_Desc = {
    Text = "「リンゴ」を狂気の難易度でクリアする"
  },
  Task_141814_Desc = {
    Text = "「王冠」を任意難度でクリア"
  },
  Task_141815_Desc = {
    Text = "血肉界域覚醒体を使用して「ウマーパティの宝物」で1回勝利する"
  },
  Task_141816_Desc = {
    Text = "「鏡」任意の難易度をクリア"
  },
  Task_141817_Desc = {
    Text = "「羽根」を狂気の難易度でクリアする"
  },
  Task_141818_Desc = {
    Text = "「羽根」を任意難度でクリア"
  },
  Task_141819_Desc = {
    Text = "ウマーパティの宝物·狂気"
  },
  Task_141820_Desc = {
    Text = "ウマーパティの宝物·領域"
  },
  Task_141821_Desc = {
    Text = "「目」を任意難度でクリア"
  },
  Task_141822_Desc = {
    Text = "「糸」を任意難度でクリア"
  },
  Task_141823_Desc = {
    Text = "「鍵」を任意難度でクリア"
  },
  Task_141824_Desc = {
    Text = "ウマーパティの宝物·クリア"
  },
  Task_141825_Desc = {
    Text = "「リンゴ」を任意難度でクリア"
  },
  Task_141826_Desc = {
    Text = "超次元界域覚醒体を使用して「ウマーパティの宝物」で1回勝利する"
  },
  Task_141827_Desc = {
    Text = "深海界域の覚醒体を使用して「ウマーパティの宝物」で1回勝利"
  },
  Task_141828_Desc = {
    Text = "「目」を狂気の難易度でクリアする"
  },
  Task_141829_Desc = {
    Text = "混沌界域の覚醒体を使用して「ウマーパティの宝物」で2回勝利"
  },
  Task_141830_Desc = {
    Text = "「鍵」を狂気の難易度でクリアする"
  },
  Task_141831_Desc = {
    Text = "「王冠」を任意難度でクリア"
  },
  Task_141899_Desc = {
    Text = "「ユーザーセンター-プロフィール編集」で携帯番号またはメールアドレスを連携する"
  },
  Task_143320_Desc = {
    Text = "意識潜行「永遠のエポヤンス」の難しい難易度を完了する"
  },
  Task_143320_Name = {
    Text = "涼しい夏の夜・難しい"
  },
  Task_143321_Desc = {
    Text = "意識潜行「永遠のエポヤンス」を完了する"
  },
  Task_143321_Name = {
    Text = "涼しい夏の夜"
  },
  Task_143588_Desc = {
    Text = "彼の腕の中のエポヤンス…………"
  },
  Task_143588_Name = {
    Text = "彼の腕の中のエポヤンス…………"
  },
  Task_143589_Desc = {
    Text = "留まる…………"
  },
  Task_143589_Name = {
    Text = "留まる…………"
  },
  Task_143590_Desc = {
    Text = "エポヤンスに留まる"
  },
  Task_143590_Name = {
    Text = "エポヤンスに留まる"
  },
  Task_144311_Desc = {
    Text = "1/2/3/4 名の強化覚醒体を出撃させた際に、250 / 500 750 / 1000 点を獲得する。（現在の出撃：{s1}）"
  },
  Task_144311_Name = {
    Text = "深淵の呼びかけ<size=20><color=#747474>強化覚醒体を1/2/3/4体出撃させた際、250 / 500 / 750 / 1000 点を獲得する </color></size>"
  },
  Task_144312_Desc = {
    Text = "意識潜航「一時的なテキスト」をクリアする"
  },
  Task_144313_Desc = {
    Text = "顛倒の新生・突破"
  },
  Task_144314_Desc = {
    Text = "「脳障害」超難度をクリア"
  },
  Task_144315_Desc = {
    Text = "深海界域の覚醒体を使用し「顛倒の新生」で1回勝利"
  },
  Task_144316_Desc = {
    Text = "「晩酌」超難度をクリア"
  },
  Task_144317_Desc = {
    Text = "「晩酌」任意の難易度をクリア"
  },
  Task_144318_Desc = {
    Text = "顛倒の新生・界域"
  },
  Task_144319_Desc = {
    Text = "「病院」任意の難易度をクリア"
  },
  Task_144320_Desc = {
    Text = "深海界域の覚醒体を使用し「顛倒の新生」で2回勝利"
  },
  Task_144321_Desc = {
    Text = "「食卓」任意の難易度をクリア"
  },
  Task_144322_Desc = {
    Text = "「食卓」超難度をクリア"
  },
  Task_144323_Desc = {
    Text = "「我が家」任意の難易度をクリア"
  },
  Task_144324_Desc = {
    Text = "超次元界域の覚醒体を使用し「顛倒の新生」で1回勝利"
  },
  Task_144325_Desc = {
    Text = "「井戸」任意の難易度をクリア"
  },
  Task_144326_Desc = {
    Text = "「我が家」任意の難易度をクリア"
  },
  Task_144327_Desc = {
    Text = "混沌界域の覚醒体を使用し「顛倒の新生」で2回勝利"
  },
  Task_144328_Desc = {
    Text = "「病院」任意の難易度をクリア"
  },
  Task_144329_Desc = {
    Text = "「井戸」任意の難易度をクリア"
  },
  Task_144330_Desc = {
    Text = "「学校」任意の難易度をクリア"
  },
  Task_144331_Desc = {
    Text = "「脳障害」任意の難易度をクリア"
  },
  Task_144332_Desc = {
    Text = "「顛倒の新生・突破」のすべての実績を達成"
  },
  Task_144333_Desc = {
    Text = "「食卓」任意の難易度をクリア"
  },
  Task_144334_Desc = {
    Text = "「学校」超難度をクリア"
  },
  Task_144335_Desc = {
    Text = "「我が家」超難度をクリア"
  },
  Task_144336_Desc = {
    Text = "血肉界域の覚醒体を使用し「顛倒の新生」で1回勝利"
  },
  Task_144337_Desc = {
    Text = "「脳障害」任意の難易度をクリア"
  },
  Task_144338_Desc = {
    Text = "「学校」任意の難易度をクリア"
  },
  Task_144339_Desc = {
    Text = "「晩酌」任意の難易度をクリア"
  },
  Task_144340_Desc = {
    Text = "血肉界域の覚醒体を使用し「顛倒の新生」で2回勝利"
  },
  Task_144341_Desc = {
    Text = "混沌界域の覚醒体を使用し「顛倒の新生」で1回勝利"
  },
  Task_144342_Desc = {
    Text = "超次元界域の覚醒体を使用し「顛倒の新生」で2回勝利"
  },
  Task_144343_Desc = {
    Text = "顛倒の新生・超難度"
  },
  Task_144344_Desc = {
    Text = "「井戸」超難度をクリア"
  },
  Task_144345_Desc = {
    Text = "「病院」超難度をクリア"
  },
  Task_144360_Desc = {
    Text = "累計300枚のカードを使用する"
  },
  Task_144361_Desc = {
    Text = "「禁忌試練」のシーズンタスクをクリアする"
  },
  Task_144362_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_144363_Desc = {
    Text = "派遣を15回完了する"
  },
  Task_144364_Desc = {
    Text = "「精粋活性イオン」が1000に到達"
  },
  Task_144365_Desc = {
    Text = "30回覚醒"
  },
  Task_144366_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_144367_Desc = {
    Text = "ログイン累計1日"
  },
  Task_144368_Desc = {
    Text = "「禁忌試練」のシーズンタスクをクリアする"
  },
  Task_144369_Desc = {
    Text = "派遣を15回完了する"
  },
  Task_144370_Desc = {
    Text = "累計300枚のカードを使用する"
  },
  Task_144371_Desc = {
    Text = "「精粋活性イオン」が1000に到達"
  },
  Task_144372_Desc = {
    Text = "30回覚醒"
  },
  Task_144373_Desc = {
    Text = "救援を3回使用する"
  },
  Task_144374_Desc = {
    Text = "救援を3回使用する"
  },
  Task_144375_Desc = {
    Text = "ログイン累計1日"
  },
  Task_145388_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_145389_Desc = {
    Text = "深海界域の覚醒体を使用して「貪戮の角逐」で2回勝利"
  },
  Task_145390_Desc = {
    Text = "「謁献」を任意の難易度でクリア"
  },
  Task_145392_Desc = {
    Text = "貪戮の角逐·クリア"
  },
  Task_145393_Desc = {
    Text = "「殺戮の殿堂」を狂気の難易度でクリア"
  },
  Task_145394_Desc = {
    Text = "「権欲の王冠」を任意の難易度でクリア"
  },
  Task_145395_Desc = {
    Text = "意識潜行「天の鯨が堕ちるまで」をクリア"
  },
  Task_145396_Desc = {
    Text = "蝕滅・ロータン入手時に霊知啓発6"
  },
  Task_145396_Name = {
    Text = "蝕滅・ロータン入手時に霊知啓発6"
  },
  Task_145396_UnlockCondDesc = {
    Text = "イベント@覚醒体蝕滅・ロータン霊知啓発ギフトパック2イベント"
  },
  Task_145397_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_145398_Desc = {
    Text = "蝕滅・ロータンの同調率が10級に達する"
  },
  Task_145399_Desc = {
    Text = "貪戮の角逐·界域"
  },
  Task_145400_Desc = {
    Text = "「囚われの獣」を任意の難易度でクリア"
  },
  Task_145401_Desc = {
    Text = "「殺戮の殿堂」を任意の難易度でクリア"
  },
  Task_145402_Desc = {
    Text = "「囚われの獣」を任意の難易度でクリア"
  },
  Task_145403_Desc = {
    Text = "「囚われの獣」を狂気の難易度でクリア"
  },
  Task_145404_Desc = {
    Text = "超次元界域覚醒体を使用して「貪戮の角逐」で1回勝利"
  },
  Task_145405_Desc = {
    Text = "混沌界域の覚醒体を使用して「貪戮の角逐」で2回勝利"
  },
  Task_145406_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_145408_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_145409_Desc = {
    Text = "「権欲の王冠」を任意の難易度でクリア"
  },
  Task_145410_Desc = {
    Text = "「貪戮の角逐·クリア」の全実績を達成"
  },
  Task_145411_Desc = {
    Text = "血肉界域覚醒体を使用して「貪戮の角逐」で1回勝利"
  },
  Task_145412_Desc = {
    Text = "血肉界域覚醒体を使用して「貪戮の角逐」で2回勝利"
  },
  Task_145413_Desc = {
    Text = "「謁献」を任意の難易度でクリア"
  },
  Task_145414_Desc = {
    Text = "蝕滅・ロータン入手時に霊知啓発2"
  },
  Task_145414_Name = {
    Text = "蝕滅・ロータン入手時に霊知啓発2"
  },
  Task_145414_UnlockCondDesc = {
    Text = "イベント@覚醒体蝕滅・ロータン霊知啓発ギフトパック2イベント"
  },
  Task_145415_Desc = {
    Text = "混沌界域の覚醒体を使用して「貪戮の角逐」で1回勝利"
  },
  Task_145416_Desc = {
    Text = "超次元界域覚醒体を使用して「貪戮の角逐」で2回勝利"
  },
  Task_145417_Desc = {
    Text = "「謁献」を狂気の難易度でクリア"
  },
  Task_145418_Desc = {
    Text = "貪戮の角逐·狂気"
  },
  Task_145419_Desc = {
    Text = "「無人の鏡」を狂気の難易度でクリア"
  },
  Task_145420_Desc = {
    Text = "「無人の鏡」を任意の難易度でクリア"
  },
  Task_145421_Desc = {
    Text = "「権欲の王冠」を狂気の難易度でクリア"
  },
  Task_145423_Desc = {
    Text = "深海界域の覚醒体を使用して「貪戮の角逐」で1回勝利"
  },
  Task_145424_Desc = {
    Text = "「無人の鏡」を任意の難易度でクリア"
  },
  Task_145425_Desc = {
    Text = "蝕滅・ロータンの人格の深化が12に達する"
  },
  Task_145426_Desc = {
    Text = "「殺戮の殿堂」を任意の難易度でクリア"
  },
  Task_145479_Desc = {
    Text = "意識潜行「天の鯨が堕ちるまで」をクリア"
  },
  Task_145479_Name = {
    Text = "我こそが嵐"
  },
  Task_145576_Desc = {
    Text = "仮テキスト・期間限定"
  },
  Task_145578_Desc = {
    Text = "万願擬造·期間限定専属"
  },
  Task_146542_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_146543_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_146544_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_146545_Desc = {
    Text = "星辰篇第6章 6-9をクリア"
  },
  Task_146546_Desc = {
    Text = "星辰篇第6章「山の宴」難しい難度をクリア"
  },
  Task_146547_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_146548_Desc = {
    Text = "星辰篇第6章「山の宴」難しい難度をクリア"
  },
  Task_146549_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_146550_Desc = {
    Text = "星辰篇第6章 6-9をクリア"
  },
  Task_146552_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_146553_Desc = {
    Text = "星辰篇第6章「山の宴」をクリア"
  },
  Task_146554_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_146555_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_146556_Desc = {
    Text = "星辰篇第6章 6-5を難しい難度でクリア"
  },
  Task_146557_Desc = {
    Text = "星辰篇第6章 6-5を難しい難度でクリア"
  },
  Task_146558_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_146559_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_146560_Desc = {
    Text = "星辰篇第6章「山の宴」をクリア"
  },
  Task_146801_Desc = {
    Text = "深海界域の覚醒体を「一時的なテキスト」で1回勝利しました"
  },
  Task_146802_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146803_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_146804_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146805_Desc = {
    Text = "血肉界域の覚醒体を「一時的なテキスト」で2回勝利しました"
  },
  Task_146806_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146807_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146808_Desc = {
    Text = "意識潜行「五日談」をクリア"
  },
  Task_146809_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146810_Desc = {
    Text = "深海界域の覚醒体を「一時的なテキスト」で2回勝利しました"
  },
  Task_146811_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146812_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146813_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146814_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146815_Desc = {
    Text = "混沌界域の覚醒体を「一時的なテキスト」で1回勝利しました"
  },
  Task_146816_Desc = {
    Text = "超維界域の覚醒体を「一時的なテキスト」で1回勝利しました"
  },
  Task_146817_Desc = {
    Text = "一時的なテキスト·クリア"
  },
  Task_146818_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146819_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146820_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146821_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_146822_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_146823_Desc = {
    Text = "一時的なテキスト·境界"
  },
  Task_146824_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_146825_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_146826_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146827_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146828_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_146829_Desc = {
    Text = "混沌界域の覚醒体を「一時的なテキスト」で2回勝利しました"
  },
  Task_146830_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_146831_Desc = {
    Text = "超維界域の覚醒体を「一時的なテキスト」で2回勝利しました"
  },
  Task_146832_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146833_Desc = {
    Text = "血肉界域の覚醒体を「一時的なテキスト」で1回勝利しました"
  },
  Task_146834_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146835_Desc = {
    Text = "一時的なテキスト·狂気"
  },
  Task_146836_Desc = {
    Text = "「一時的なテキスト・クリア」のすべての成果を完了"
  },
  Task_146837_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_146838_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_146839_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_146840_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147442_Desc = {
    Text = "血肉界域の覚醒体を「一時的なテキスト」で2回勝利しました"
  },
  Task_147443_Desc = {
    Text = "暮星・ティンクトの同調率がレベル10に達する"
  },
  Task_147444_Desc = {
    Text = "深海界域の覚醒体を「一時的なテキスト」で1回勝利しました"
  },
  Task_147450_Desc = {
    Text = "意識潜航「一時的なテキスト」をクリアする"
  },
  Task_147451_Desc = {
    Text = "超維界域の覚醒体を「一時的なテキスト」で1回勝利しました"
  },
  Task_147452_Desc = {
    Text = "混沌界域の覚醒体を「一時的なテキスト」で1回勝利しました"
  },
  Task_147453_Desc = {
    Text = "深海界域の覚醒体を「一時的なテキスト」で2回勝利しました"
  },
  Task_147454_Desc = {
    Text = "血肉界域の覚醒体を「一時的なテキスト」で1回勝利しました"
  },
  Task_147456_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_147458_Desc = {
    Text = "暮星・ティンクト入手時に霊知啓発2"
  },
  Task_147458_Name = {
    Text = "暮星・ティンクト入手時に霊知啓発2"
  },
  Task_147458_UnlockCondDesc = {
    Text = "活動@覚醒体暮星・ティンクト霊知啓発ギフトパック2活動"
  },
  Task_147461_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_147464_Desc = {
    Text = "意識潜行完了する「一時的なテキスト」"
  },
  Task_147464_Name = {
    Text = "一時的なテキスト"
  },
  Task_147465_Desc = {
    Text = "暮星・ティンクト入手時に霊知啓発6"
  },
  Task_147465_Name = {
    Text = "暮星・ティンクト入手時に霊知啓発6"
  },
  Task_147465_UnlockCondDesc = {
    Text = "活動@覚醒体暮星・ティンクト霊知啓発ギフトパック2活動"
  },
  Task_147471_Desc = {
    Text = "暮星・ティンクトの人格を深めること12に達する"
  },
  Task_147472_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_147474_Desc = {
    Text = "混沌界域の覚醒体を「一時的なテキスト」で2回勝利しました"
  },
  Task_147475_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_147476_Desc = {
    Text = "「一時的なテキスト・クリア」のすべての成果を完了"
  },
  Task_147478_Desc = {
    Text = "意識潜行「一時的テキスト」の難しい難易度を完了する"
  },
  Task_147478_Name = {
    Text = "一時的なテキスト・難しい"
  },
  Task_147483_Desc = {
    Text = "超維界域の覚醒体を「一時的なテキスト」で2回勝利しました"
  },
  Task_147552_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147553_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147554_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147555_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147556_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_147557_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147558_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147559_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147560_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_147561_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147562_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_147563_Desc = {
    Text = "一時的なテキスト·狂気"
  },
  Task_147564_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147565_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147566_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147567_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_147568_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_147569_Desc = {
    Text = "一時的なテキスト·境界"
  },
  Task_147570_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147571_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147572_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_147573_Desc = {
    Text = "クリア「一時的テキスト」癫狂難易度"
  },
  Task_147574_Desc = {
    Text = "一時的なテキスト·クリア"
  },
  Task_147575_Desc = {
    Text = "クリア「一時的なテキスト」任意難易度"
  },
  Task_147676_Desc = {
    Text = "プレイヤーレベルが2に達する"
  },
  Task_147676_Name = {
    Text = "（パッケージ待ち）"
  },
  Task_147677_Desc = {
    Text = "レベル10の覚醒体を1体所持する"
  },
  Task_147677_Name = {
    Text = "（パッケージ待ち）"
  },
  Task_147678_Desc = {
    Text = "調査事件「入学日」を完了する"
  },
  Task_147678_Name = {
    Text = "（パッケージ待ち）"
  },
  Task_147679_Desc = {
    Text = "覚醒体を5体所持する"
  },
  Task_147679_Name = {
    Text = "（パッケージ待ち）"
  },
  Task_147894_Desc = {
    Text = "一時的なテキスト"
  },
  Task_147894_Name = {Text = "目標"},
  Task_147895_Desc = {
    Text = "調査事件「山の宴」の難しい難易度を完了する"
  },
  Task_147895_Name = {
    Text = "標高8840メートルの安眠·難しい"
  },
  Task_147896_Desc = {
    Text = "一時的なテキスト"
  },
  Task_147896_Name = {Text = "目標"},
  Task_147897_Desc = {
    Text = "一時的なテキスト"
  },
  Task_147897_Name = {Text = "目標"},
  Task_147898_Desc = {
    Text = "一時的なテキスト"
  },
  Task_147898_Name = {Text = "目標"},
  Task_147899_Desc = {
    Text = "一時的なテキスト"
  },
  Task_147899_Name = {Text = "目標"},
  Task_147900_Desc = {
    Text = "一時的なテキスト"
  },
  Task_147900_Name = {Text = "目標"},
  Task_147901_Desc = {
    Text = "一時的なテキスト"
  },
  Task_147901_Name = {Text = "目標"},
  Task_147902_Desc = {
    Text = "調査「@1@2」で9回共鳴する"
  },
  Task_147902_Desc2 = {
    Text = "調査事件「山の宴」で9回共鳴する"
  },
  Task_147902_Name2 = {
    Text = "嘘なき者の七重礼拝Ⅳ"
  },
  Task_147903_Desc = {
    Text = "一時的なテキスト"
  },
  Task_147903_Name = {Text = "目標"},
  Task_147904_Desc = {
    Text = "一時的なテキスト"
  },
  Task_147904_Name = {Text = "目標"},
  Task_147905_Desc = {
    Text = "調査「@1@2」で3回共鳴する"
  },
  Task_147905_Desc2 = {
    Text = "調査事件「山の宴」で3回共鳴する"
  },
  Task_147905_Name2 = {
    Text = "嘘なき者の七重礼拝"
  },
  Task_147906_Desc = {
    Text = "調査「@1@2」で7回共鳴する"
  },
  Task_147906_Desc2 = {
    Text = "調査事件「山の宴」で7回共鳴する"
  },
  Task_147906_Name2 = {
    Text = "嘘なき者の七重礼拝Ⅲ"
  },
  Task_147907_Desc = {
    Text = "調査事件「@1@2」で5回共鳴する"
  },
  Task_147907_Desc2 = {
    Text = "調査事件「山の宴」で5回共鳴する"
  },
  Task_147907_Name2 = {
    Text = "嘘なき者の七重礼拝Ⅱ"
  },
  Task_147908_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_147908_Desc2 = {
    Text = "調査事件「山の宴」を完了する"
  },
  Task_147908_Name2 = {
    Text = "標高8840メートルの安眠"
  },
  Task_147909_Desc = {
    Text = "一時的なテキスト"
  },
  Task_147909_Name = {Text = "目標"},
  Task_147910_Desc = {
    Text = "一時的なテキスト"
  },
  Task_147910_Name = {Text = "目標"},
  Task_148121_Desc = {
    Text = "派遣を15回完了する"
  },
  Task_148122_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_148123_Desc = {
    Text = "ログイン累計1日"
  },
  Task_148124_Desc = {
    Text = "30回覚醒"
  },
  Task_148125_Desc = {
    Text = "ログイン累計1日"
  },
  Task_148126_Desc = {
    Text = "「禁忌試練」のシーズンタスクをクリアする"
  },
  Task_148127_Desc = {
    Text = "「禁忌試練」のシーズンタスクをクリアする"
  },
  Task_148128_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_148129_Desc = {
    Text = "30回覚醒"
  },
  Task_148130_Desc = {
    Text = "派遣を15回完了する"
  },
  Task_148131_Desc = {
    Text = "救援を3回使用する"
  },
  Task_148132_Desc = {
    Text = "「精粋活性イオン」が1000に到達"
  },
  Task_148133_Desc = {
    Text = "救援を3回使用する"
  },
  Task_148134_Desc = {
    Text = "累計300枚のカードを使用する"
  },
  Task_148135_Desc = {
    Text = "「精粋活性イオン」が1000に到達"
  },
  Task_148136_Desc = {
    Text = "累計300枚のカードを使用する"
  },
  Task_148489_Desc = {
    Text = "意識潜行「五日談」を完了する"
  },
  Task_148489_Name = {
    Text = "故郷を失った者の凱旋"
  },
  Task_148490_Desc = {
    Text = "意識潜行「五日談」難しい難度を完了する"
  },
  Task_148490_Name = {
    Text = "故郷を失った者の凱旋·難しい"
  },
  Task_149335_Desc = {
    Text = "ドラゴンを屠る"
  },
  Task_149335_Name = {Text = "目標"},
  Task_149989_Desc = {
    Text = "星辰篇第6章 6-1をクリア"
  },
  Task_149990_Desc = {
    Text = "起源オジールの人格を深めるレベル12に到達する"
  },
  Task_19734_Desc = {
    Text = "超次元の旅・隙間Ⅵをクリア"
  },
  Task_19735_Desc = {
    Text = "血肉の沼・隙間Ⅷをクリア"
  },
  Task_19736_Desc = {
    Text = "超次元の旅・隙間Ⅳをクリア"
  },
  Task_19737_Desc = {
    Text = "血肉の沼・隙間Ⅱをクリア"
  },
  Task_19738_Desc = {
    Text = "超次元の旅・隙間Ⅱをクリア"
  },
  Task_19739_Desc = {
    Text = "血肉の沼・隙間Ⅵをクリア"
  },
  Task_19740_Desc = {
    Text = "罠を仕掛け、「狩り」を実行"
  },
  Task_19740_Name = {Text = "目標"},
  Task_19741_Desc = {
    Text = "超次元の旅・隙間Ⅷをクリア"
  },
  Task_19742_Desc = {
    Text = "深海の遺産・隙間Ⅱをクリア"
  },
  Task_19743_Desc = {
    Text = "混沌の領域・隙間Ⅱをクリア"
  },
  Task_19744_Desc = {
    Text = "深海の遺産・隙間Ⅵをクリア"
  },
  Task_19745_Desc = {
    Text = "混沌の領域・隙間Ⅳをクリア"
  },
  Task_19746_Desc = {
    Text = "深海の遺産・隙間Ⅳをクリア"
  },
  Task_19747_Desc = {
    Text = "混沌の領域・隙間Ⅵをクリア"
  },
  Task_19748_Desc = {
    Text = "混沌の領域・隙間Ⅷをクリア"
  },
  Task_19749_Desc = {
    Text = "深海の遺産・隙間Ⅷをクリア"
  },
  Task_19750_Desc = {
    Text = "罠を仕掛け、「狩り」を実行"
  },
  Task_19750_Name = {Text = "目標"},
  Task_19751_Desc = {
    Text = "ロータンを手助けして敵を追い詰める"
  },
  Task_19751_Name = {Text = "目標"},
  Task_19752_Desc = {
    Text = "血肉の沼・隙間Ⅳをクリア"
  },
  Task_20972_Desc = {
    Text = "超次元の旅・隙間Ⅰをクリア"
  },
  Task_20973_Desc = {
    Text = "深海の遺産・隙間Ⅰをクリア"
  },
  Task_20990_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_20990_Name = {Text = "速攻"},
  Task_20991_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_20991_Name = {
    Text = "完璧な通過"
  },
  Task_20992_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_20992_Name = {
    Text = "完璧な通過"
  },
  Task_20993_Desc = {
    Text = "最終戦で1ターンに最低4回の狂気解放を行う"
  },
  Task_20993_Name = {
    Text = "死に至る魔術"
  },
  Task_20994_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_20994_Name = {
    Text = "完璧な通過"
  },
  Task_20995_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_20995_Name = {
    Text = "完璧な通過"
  },
  Task_20996_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_20996_Name = {
    Text = "優雅で正確"
  },
  Task_20997_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_20997_Name = {Text = "速攻"},
  Task_20998_Desc = {
    Text = "最終戦で1ターンに追加で最低5枚のカードを引く"
  },
  Task_20998_Name = {
    Text = "ドロー！"
  },
  Task_20999_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_20999_Name = {
    Text = "完璧な通過"
  },
  Task_21000_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21000_Name = {Text = "速攻"},
  Task_21001_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21001_Name = {
    Text = "完璧な通過"
  },
  Task_21002_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_21002_Name = {
    Text = "無限の抱擁"
  },
  Task_21003_Desc = {
    Text = "4種以上の異なる刻印を獲得"
  },
  Task_21003_Name = {
    Text = "霊魂烙印"
  },
  Task_21004_Desc = {
    Text = "精鋭戦で1ターンに最低240ダメージを与える"
  },
  Task_21004_Name = {
    Text = "全力一撃"
  },
  Task_21005_Desc = {
    Text = "クリア時に休憩所でライフを回復していない"
  },
  Task_21005_Name = {
    Text = "無火の人"
  },
  Task_21006_Desc = {
    Text = "クリア時の症状が3枚以下"
  },
  Task_21006_Name = {
    Text = "省エネ主義"
  },
  Task_21007_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_21007_Name = {
    Text = "伏兵の宝物"
  },
  Task_21008_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_21008_Name = {
    Text = "省エネ主義"
  },
  Task_21009_Desc = {
    Text = "最終戦で1ターン中カード4枚以上使用"
  },
  Task_21009_Name = {
    Text = "私のターン"
  },
  Task_21010_Desc = {
    Text = "探索度が100%に達する"
  },
  Task_21010_Name = {
    Text = "霧の境界の俯瞰"
  },
  Task_21011_Desc = {
    Text = "クリア時、遺物を5個以上所持"
  },
  Task_21011_Name = {
    Text = "伏兵の宝物"
  },
  Task_21012_Desc = {
    Text = "クリア時、遺物を5個以上所持"
  },
  Task_21012_Name = {
    Text = "伏兵の宝物"
  },
  Task_21013_Desc = {
    Text = "クリア時、遺物を5個以上所持"
  },
  Task_21013_Name = {
    Text = "伏兵の宝物"
  },
  Task_21014_Desc = {
    Text = "最終戦で1ターンに最大ライフの50%のシールドを獲得"
  },
  Task_21014_Name = {
    Text = "鋼鉄の体"
  },
  Task_21015_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21015_Name = {
    Text = "完璧な通過"
  },
  Task_21016_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21016_Name = {
    Text = "優雅で正確"
  },
  Task_21017_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21017_Name = {
    Text = "完璧な通過"
  },
  Task_21018_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21018_Name = {
    Text = "優雅で正確"
  },
  Task_21019_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21019_Name = {
    Text = "優雅で正確"
  },
  Task_21020_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21020_Name = {
    Text = "完璧な通過"
  },
  Task_21021_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_21021_Name = {Text = "速攻"},
  Task_21022_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21022_Name = {
    Text = "完璧な通過"
  },
  Task_21023_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21023_Name = {
    Text = "省エネ主義"
  },
  Task_21024_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21024_Name = {
    Text = "完璧な通過"
  },
  Task_21025_Desc = {
    Text = "最終戦で1ターンに最低4回狂気解放を行う"
  },
  Task_21025_Name = {
    Text = "死に至る魔術"
  },
  Task_21026_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21026_Name = {
    Text = "完璧な通過"
  },
  Task_21027_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21027_Name = {Text = "速攻"},
  Task_21028_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_21028_Name = {Text = "速攻"},
  Task_21029_Desc = {
    Text = "最終戦で1ターン中カード6枚以上使用"
  },
  Task_21029_Name = {
    Text = "私のターン"
  },
  Task_21030_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21030_Name = {
    Text = "完璧な通過"
  },
  Task_21032_Desc = {
    Text = "最終戦で1ターンに最低40000ダメージを与える"
  },
  Task_21032_Name = {
    Text = "全力一撃"
  },
  Task_21033_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21033_Name = {
    Text = "完璧な通過"
  },
  Task_21034_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21034_Name = {
    Text = "完璧な通過"
  },
  Task_21035_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21035_Name = {Text = "速攻"},
  Task_21036_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21036_Name = {
    Text = "完璧な通過"
  },
  Task_21037_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_21037_Name = {
    Text = "省エネ主義"
  },
  Task_21038_Desc = {
    Text = "最終戦で1ターン中カード4枚以上使用"
  },
  Task_21038_Name = {
    Text = "私のターン"
  },
  Task_21039_Desc = {
    Text = "探索度が100%に達する"
  },
  Task_21039_Name = {
    Text = "霧の境界の俯瞰"
  },
  Task_21040_Desc = {
    Text = "クリア時、遺物を5個以上所持"
  },
  Task_21040_Name = {
    Text = "伏兵の宝物"
  },
  Task_21041_Desc = {
    Text = "クリア時、遺物を5個以上所持"
  },
  Task_21041_Name = {
    Text = "伏兵の宝物"
  },
  Task_21042_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21042_Name = {
    Text = "優雅で正確"
  },
  Task_21043_Desc = {
    Text = "最終戦で1ターンに最大ライフの50%のシールドを獲得"
  },
  Task_21043_Name = {
    Text = "鋼鉄の体"
  },
  Task_21044_Desc = {
    Text = "4種以上の異なる刻印を獲得"
  },
  Task_21044_Name = {
    Text = "霊魂烙印"
  },
  Task_21045_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21045_Name = {
    Text = "優雅で正確"
  },
  Task_21046_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21046_Name = {Text = "速攻"},
  Task_21047_Desc = {
    Text = "最終戦で1ターンに最低4回狂気解放を行う"
  },
  Task_21047_Name = {
    Text = "死に至る魔術"
  },
  Task_21048_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21048_Name = {
    Text = "完璧な通過"
  },
  Task_21049_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_21049_Name = {
    Text = "省エネ主義"
  },
  Task_21050_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_21050_Name = {
    Text = "無限の抱擁"
  },
  Task_21051_Desc = {
    Text = "クリア時、遺物を2個以上所持"
  },
  Task_21051_Name = {
    Text = "伏兵の宝物"
  },
  Task_21052_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21052_Name = {
    Text = "完璧な通過"
  },
  Task_21053_Desc = {
    Text = "4種以上の異なる刻印を獲得"
  },
  Task_21053_Name = {
    Text = "霊魂烙印"
  },
  Task_21054_Desc = {
    Text = "4種以上の異なる刻印を獲得"
  },
  Task_21054_Name = {
    Text = "霊魂烙印"
  },
  Task_21055_Desc = {
    Text = "精鋭戦で1ターンに最低980ダメージを与える"
  },
  Task_21055_Name = {
    Text = "全力一撃"
  },
  Task_21056_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21056_Name = {
    Text = "優雅で正確"
  },
  Task_21057_Desc = {
    Text = "クリア時の症状が3枚以下"
  },
  Task_21057_Name = {
    Text = "省エネ主義"
  },
  Task_21058_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_21058_Name = {
    Text = "伏兵の宝物"
  },
  Task_21059_Desc = {
    Text = "探索度が100%に達する"
  },
  Task_21059_Name = {
    Text = "霧の境界の俯瞰"
  },
  Task_21060_Desc = {
    Text = "精鋭戦で1ターンに最低3回狂気解放を使用する"
  },
  Task_21060_Name = {
    Text = "死に至る魔術"
  },
  Task_21061_Desc = {
    Text = "最終戦で1ターンに追加で最低5枚のカードを引く"
  },
  Task_21061_Name = {
    Text = "ドロー！"
  },
  Task_21062_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21062_Name = {Text = "速攻"},
  Task_21063_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21063_Name = {
    Text = "完璧な通過"
  },
  Task_21064_Desc = {
    Text = "クリア時、遺物を2個以上所持"
  },
  Task_21064_Name = {
    Text = "伏兵の宝物"
  },
  Task_21065_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21065_Name = {
    Text = "省エネ主義"
  },
  Task_21066_Desc = {
    Text = "3種以上の刻印を獲得"
  },
  Task_21066_Name = {
    Text = "霊魂烙印"
  },
  Task_21067_Desc = {
    Text = "クリア時に覚醒体2名以上を覚醒"
  },
  Task_21067_Name = {
    Text = "無限の抱擁"
  },
  Task_21068_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21068_Name = {
    Text = "優雅で正確"
  },
  Task_21069_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_21069_Name = {
    Text = "伏兵の宝物"
  },
  Task_21070_Desc = {
    Text = "最終戦で1ターン中カード4枚以上使用"
  },
  Task_21070_Name = {
    Text = "私のターン"
  },
  Task_21071_Desc = {
    Text = "最終戦で1ターンに最低3回狂気解放を行う"
  },
  Task_21071_Name = {
    Text = "死に至る魔術"
  },
  Task_21072_Desc = {
    Text = "クリア時の症状が3枚以下"
  },
  Task_21072_Name = {
    Text = "省エネ主義"
  },
  Task_21073_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_21073_Name = {
    Text = "省エネ主義"
  },
  Task_21074_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21074_Name = {
    Text = "完璧な通過"
  },
  Task_21075_Desc = {
    Text = "4種の異なる刻印を所持"
  },
  Task_21075_Name = {
    Text = "霊魂烙印"
  },
  Task_21076_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21076_Name = {Text = "速攻"},
  Task_21077_Desc = {
    Text = "最終戦で1ターン中カード5枚以上使用"
  },
  Task_21077_Name = {
    Text = "私のターン"
  },
  Task_21078_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21078_Name = {
    Text = "完璧な通過"
  },
  Task_21079_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21079_Name = {
    Text = "完璧な通過"
  },
  Task_21080_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21080_Name = {
    Text = "完璧な通過"
  },
  Task_21081_Desc = {
    Text = "最終戦で1ターンに350ダメージを与える"
  },
  Task_21081_Name = {
    Text = "全力一撃"
  },
  Task_21082_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21082_Name = {Text = "速攻"},
  Task_21083_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21083_Name = {Text = "速攻"},
  Task_21084_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21084_Name = {
    Text = "完璧な通過"
  },
  Task_21085_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21085_Name = {
    Text = "完璧な通過"
  },
  Task_21086_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21086_Name = {
    Text = "省エネ主義"
  },
  Task_21087_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21087_Name = {Text = "速攻"},
  Task_21088_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21088_Name = {Text = "速攻"},
  Task_21089_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21089_Name = {
    Text = "完璧な通過"
  },
  Task_21090_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21090_Name = {Text = "速攻"},
  Task_21091_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21091_Name = {Text = "速攻"},
  Task_21092_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21092_Name = {Text = "速攻"},
  Task_21093_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21093_Name = {Text = "速攻"},
  Task_21094_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21094_Name = {Text = "速攻"},
  Task_21095_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21095_Name = {Text = "速攻"},
  Task_21096_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21096_Name = {Text = "速攻"},
  Task_21097_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21097_Name = {Text = "速攻"},
  Task_21098_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21098_Name = {Text = "速攻"},
  Task_21099_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_21099_Name = {
    Text = "伏兵の宝物"
  },
  Task_21100_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21100_Name = {
    Text = "優雅で正確"
  },
  Task_21101_Desc = {
    Text = "任意の戦闘で1ターン内に最低2体の敵を倒す"
  },
  Task_21101_Name = {Text = "根絶"},
  Task_21102_Desc = {
    Text = "クリア時、遺物を8個以上所持"
  },
  Task_21102_Name = {
    Text = "伏兵の宝物"
  },
  Task_21103_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_21103_Name = {
    Text = "省エネ主義"
  },
  Task_21104_Desc = {
    Text = "最終戦で1ターン中カード5枚以上使用"
  },
  Task_21104_Name = {
    Text = "私のターン"
  },
  Task_21105_Desc = {
    Text = "最終戦で1ターンに最低300ダメージを与える"
  },
  Task_21105_Name = {
    Text = "全力一撃"
  },
  Task_21106_Desc = {
    Text = "最終戦で1ターンに追加で最低3枚のカードを引く"
  },
  Task_21106_Name = {
    Text = "ドロー！"
  },
  Task_21107_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21107_Name = {
    Text = "完璧な通過"
  },
  Task_21108_Desc = {
    Text = "最終戦で1ターンに最低96000ダメージを与える"
  },
  Task_21108_Name = {
    Text = "全力一撃"
  },
  Task_21110_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21110_Name = {
    Text = "省エネ主義"
  },
  Task_21111_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_21111_Name = {
    Text = "省エネ主義"
  },
  Task_21112_Desc = {
    Text = "任意の戦闘で1ターン内に最低2体の敵を倒す"
  },
  Task_21112_Name = {Text = "根絶"},
  Task_21113_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21113_Name = {
    Text = "完璧な通過"
  },
  Task_21114_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21114_Name = {Text = "速攻"},
  Task_21115_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21115_Name = {
    Text = "省エネ主義"
  },
  Task_21116_Desc = {
    Text = "クリア時のライフが80%以上"
  },
  Task_21116_Name = {
    Text = "優雅で正確"
  },
  Task_21117_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21117_Name = {
    Text = "完璧な通過"
  },
  Task_21118_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21118_Name = {Text = "速攻"},
  Task_21119_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_21119_Name = {
    Text = "省エネ主義"
  },
  Task_21120_Desc = {
    Text = "任意の戦闘で1ターン内に最低2体の敵を倒す"
  },
  Task_21120_Name = {Text = "根絶"},
  Task_21121_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21121_Name = {
    Text = "省エネ主義"
  },
  Task_21122_Desc = {
    Text = "精鋭戦で1ターンに最低1600ダメージを与える"
  },
  Task_21122_Name = {
    Text = "全力一撃"
  },
  Task_21123_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21123_Name = {Text = "速攻"},
  Task_21124_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21124_Name = {
    Text = "完璧な通過"
  },
  Task_21125_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21125_Name = {
    Text = "完璧な通過"
  },
  Task_21126_Desc = {
    Text = "精鋭戦で1ターンに最低3回狂気解放を使用する"
  },
  Task_21126_Name = {
    Text = "死に至る魔術"
  },
  Task_21127_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21127_Name = {Text = "速攻"},
  Task_21128_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21128_Name = {
    Text = "完璧な通過"
  },
  Task_21129_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_21129_Name = {
    Text = "省エネ主義"
  },
  Task_21130_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21130_Name = {
    Text = "完璧な通過"
  },
  Task_21131_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_21131_Name = {
    Text = "無限の抱擁"
  },
  Task_21132_Desc = {
    Text = "最終戦で1ターンに最低6000ダメージを与える"
  },
  Task_21132_Name = {
    Text = "全力一撃"
  },
  Task_21133_Desc = {
    Text = "最終戦で1ターンに追加で最低5枚のカードを引く"
  },
  Task_21133_Name = {
    Text = "ドロー！"
  },
  Task_21134_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21134_Name = {
    Text = "完璧な通過"
  },
  Task_21135_Desc = {
    Text = "最終戦で1ターンに追加で最低4枚のカードを引く"
  },
  Task_21135_Name = {
    Text = "ドロー！"
  },
  Task_21136_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_21136_Name = {Text = "速攻"},
  Task_21137_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21137_Name = {Text = "速攻"},
  Task_21138_Desc = {
    Text = "精鋭戦で1ターンに最低1800ダメージを与える"
  },
  Task_21138_Name = {
    Text = "全力一撃"
  },
  Task_21139_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_21139_Name = {
    Text = "伏兵の宝物"
  },
  Task_21140_Desc = {
    Text = "最終戦で1ターン中カード5枚以上使用"
  },
  Task_21140_Name = {
    Text = "私のターン"
  },
  Task_21141_Desc = {
    Text = "最終戦で1ターンに最大ライフの65%のシールドを獲得"
  },
  Task_21141_Name = {
    Text = "鋼鉄の体"
  },
  Task_21142_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21142_Name = {
    Text = "省エネ主義"
  },
  Task_21143_Desc = {
    Text = "4種以上の異なる刻印を獲得"
  },
  Task_21143_Name = {
    Text = "霊魂烙印"
  },
  Task_21144_Desc = {
    Text = "クリア時、遺物を2個以上所持"
  },
  Task_21144_Name = {
    Text = "伏兵の宝物"
  },
  Task_21145_Desc = {
    Text = "クリア時に休憩所での回復が1回以下"
  },
  Task_21145_Name = {
    Text = "無火の人"
  },
  Task_21146_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_21146_Name = {
    Text = "伏兵の宝物"
  },
  Task_21147_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21147_Name = {
    Text = "省エネ主義"
  },
  Task_21148_Desc = {
    Text = "精鋭戦で1ターンに最低500ダメージを与える"
  },
  Task_21148_Name = {
    Text = "全力一撃"
  },
  Task_21149_Desc = {
    Text = "任意の戦闘で1ターン内に最低2体の敵を倒す"
  },
  Task_21149_Name = {Text = "根絶"},
  Task_21150_Desc = {
    Text = "覚醒体3名以上を覚醒"
  },
  Task_21150_Name = {
    Text = "無限の抱擁"
  },
  Task_21151_Desc = {
    Text = "4種以上の異なる刻印を獲得"
  },
  Task_21151_Name = {
    Text = "霊魂烙印"
  },
  Task_21152_Desc = {
    Text = "探索度が100%に達する"
  },
  Task_21152_Name = {
    Text = "霧の境界の俯瞰"
  },
  Task_21153_Desc = {
    Text = "最終戦で1ターンに最低4回狂気解放を行う"
  },
  Task_21153_Name = {
    Text = "死に至る魔術"
  },
  Task_21154_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21154_Name = {
    Text = "省エネ主義"
  },
  Task_21155_Desc = {
    Text = "最終戦で1ターンに最大ライフの60%のシールドを獲得"
  },
  Task_21155_Name = {
    Text = "鋼鉄の体"
  },
  Task_21156_Desc = {
    Text = "クリア時、遺物を8個以上所持"
  },
  Task_21156_Name = {
    Text = "伏兵の宝物"
  },
  Task_21157_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21157_Name = {
    Text = "優雅で正確"
  },
  Task_21158_Desc = {
    Text = "最終戦で1ターンに追加で最低4枚のカードを引く"
  },
  Task_21158_Name = {
    Text = "ドロー！"
  },
  Task_21159_Desc = {
    Text = "最終戦で1ターンに最低5200ダメージを与える"
  },
  Task_21159_Name = {
    Text = "全力一撃"
  },
  Task_21160_Desc = {
    Text = "最終戦で1ターンに追加で最低3枚のカードを引く"
  },
  Task_21160_Name = {
    Text = "ドロー！"
  },
  Task_21161_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21161_Name = {
    Text = "完璧な通過"
  },
  Task_21162_Desc = {
    Text = "最終戦で1ターンに最大ライフの65%のシールドを獲得"
  },
  Task_21162_Name = {
    Text = "鋼鉄の体"
  },
  Task_21163_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21163_Name = {
    Text = "省エネ主義"
  },
  Task_21164_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_21164_Name = {
    Text = "伏兵の宝物"
  },
  Task_21165_Desc = {
    Text = "最終戦で1ターン中カード4枚以上使用"
  },
  Task_21165_Name = {
    Text = "私のターン"
  },
  Task_21166_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21166_Name = {
    Text = "完璧な通過"
  },
  Task_21167_Desc = {
    Text = "4種の異なる刻印を所持"
  },
  Task_21167_Name = {
    Text = "霊魂烙印"
  },
  Task_21168_Desc = {
    Text = "最終戦で1ターンに120ダメージを与える"
  },
  Task_21168_Name = {
    Text = "全力一撃"
  },
  Task_21169_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21169_Name = {
    Text = "優雅で正確"
  },
  Task_21170_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21170_Name = {
    Text = "優雅で正確"
  },
  Task_21171_Desc = {
    Text = "任意の戦闘で1ターン内に最低2体の敵を倒す"
  },
  Task_21171_Name = {Text = "根絶"},
  Task_21172_Desc = {
    Text = "最終戦で1ターンに追加で最低3枚のカードを引く"
  },
  Task_21172_Name = {
    Text = "ドロー！"
  },
  Task_21173_Desc = {
    Text = "覚醒体3名以上を覚醒"
  },
  Task_21173_Name = {
    Text = "無限の抱擁"
  },
  Task_21174_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21174_Name = {
    Text = "優雅で正確"
  },
  Task_21176_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21176_Name = {Text = "速攻"},
  Task_21177_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21177_Name = {Text = "速攻"},
  Task_21178_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21178_Name = {
    Text = "省エネ主義"
  },
  Task_21179_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21179_Name = {
    Text = "完璧な通過"
  },
  Task_21180_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21180_Name = {
    Text = "完璧な通過"
  },
  Task_21181_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21181_Name = {
    Text = "完璧な通過"
  },
  Task_21182_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_21182_Name = {
    Text = "省エネ主義"
  },
  Task_21183_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21183_Name = {
    Text = "省エネ主義"
  },
  Task_21184_Desc = {
    Text = "探索度が100%に達する"
  },
  Task_21184_Name = {
    Text = "霧の境界の俯瞰"
  },
  Task_21185_Desc = {
    Text = "最終戦で1ターンに最低1000ダメージを与える"
  },
  Task_21185_Name = {
    Text = "全力一撃"
  },
  Task_21186_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21186_Name = {Text = "速攻"},
  Task_21187_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21187_Name = {Text = "速攻"},
  Task_21188_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21188_Name = {Text = "速攻"},
  Task_21189_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21189_Name = {Text = "速攻"},
  Task_21190_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21190_Name = {Text = "速攻"},
  Task_21191_Desc = {
    Text = "クリア時の症状が1枚以下"
  },
  Task_21191_Name = {
    Text = "省エネ主義"
  },
  Task_21192_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21192_Name = {Text = "速攻"},
  Task_21193_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21193_Name = {Text = "速攻"},
  Task_21194_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21194_Name = {Text = "速攻"},
  Task_21195_Desc = {
    Text = "最終戦で1ターンに最低7300ダメージを与える"
  },
  Task_21195_Name = {
    Text = "全力一撃"
  },
  Task_21196_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21196_Name = {Text = "速攻"},
  Task_21197_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21197_Name = {
    Text = "優雅で正確"
  },
  Task_21198_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21198_Name = {Text = "速攻"},
  Task_21199_Desc = {
    Text = "最終戦で1ターン中カード4枚以上使用"
  },
  Task_21199_Name = {
    Text = "私のターン"
  },
  Task_21200_Desc = {
    Text = "クリア時の症状が3枚以下"
  },
  Task_21200_Name = {
    Text = "省エネ主義"
  },
  Task_21201_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21201_Name = {
    Text = "完璧な通過"
  },
  Task_21202_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21202_Name = {
    Text = "完璧な通過"
  },
  Task_21203_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21203_Name = {
    Text = "完璧な通過"
  },
  Task_21204_Desc = {
    Text = "クリア時、遺物を2個以上所持"
  },
  Task_21204_Name = {
    Text = "伏兵の宝物"
  },
  Task_21205_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21205_Name = {
    Text = "省エネ主義"
  },
  Task_21206_Desc = {
    Text = "3種以上の刻印を獲得"
  },
  Task_21206_Name = {
    Text = "霊魂烙印"
  },
  Task_21207_Desc = {
    Text = "クリア時に覚醒体2名以上を覚醒"
  },
  Task_21207_Name = {
    Text = "無限の抱擁"
  },
  Task_21208_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21208_Name = {
    Text = "優雅で正確"
  },
  Task_21209_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_21209_Name = {
    Text = "伏兵の宝物"
  },
  Task_21210_Desc = {
    Text = "最終戦で1ターン中カード4枚以上使用"
  },
  Task_21210_Name = {
    Text = "私のターン"
  },
  Task_21211_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21211_Name = {
    Text = "完璧な通過"
  },
  Task_21212_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21212_Name = {Text = "速攻"},
  Task_21213_Desc = {
    Text = "最終戦で1ターンに最低2500ダメージを与える"
  },
  Task_21213_Name = {
    Text = "全力一撃"
  },
  Task_21214_Desc = {
    Text = "最終戦で1ターンに追加で最低5枚のカードを引く"
  },
  Task_21214_Name = {
    Text = "ドロー！"
  },
  Task_21215_Desc = {
    Text = "最終戦で1ターン中カード6枚以上使用"
  },
  Task_21215_Name = {
    Text = "私のターン"
  },
  Task_21216_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21216_Name = {
    Text = "優雅で正確"
  },
  Task_21217_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21217_Name = {
    Text = "優雅で正確"
  },
  Task_21218_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_21218_Name = {
    Text = "無限の抱擁"
  },
  Task_21219_Desc = {
    Text = "最終戦で1ターンに追加で最低3枚のカードを引く"
  },
  Task_21219_Name = {
    Text = "ドロー！"
  },
  Task_21220_Desc = {
    Text = "覚醒体3名以上を覚醒"
  },
  Task_21220_Name = {
    Text = "無限の抱擁"
  },
  Task_21221_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21221_Name = {
    Text = "優雅で正確"
  },
  Task_21222_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_21222_Name = {
    Text = "伏兵の宝物"
  },
  Task_21223_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21223_Name = {
    Text = "完璧な通過"
  },
  Task_21224_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21224_Name = {
    Text = "完璧な通過"
  },
  Task_21225_Desc = {
    Text = "任意の戦闘で1ターン内に最低2体の敵を倒す"
  },
  Task_21225_Name = {Text = "根絶"},
  Task_21226_Desc = {
    Text = "クリア時、遺物を2個以上所持"
  },
  Task_21226_Name = {
    Text = "伏兵の宝物"
  },
  Task_21227_Desc = {
    Text = "4種以上の異なる刻印を獲得"
  },
  Task_21227_Name = {
    Text = "霊魂烙印"
  },
  Task_21228_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21228_Name = {
    Text = "完璧な通過"
  },
  Task_21229_Desc = {
    Text = "クリア時に休憩所でライフを回復していない"
  },
  Task_21229_Name = {
    Text = "無火の人"
  },
  Task_21230_Desc = {
    Text = "探索度が100%に達する"
  },
  Task_21230_Name = {
    Text = "霧の境界の俯瞰"
  },
  Task_21231_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21231_Name = {Text = "速攻"},
  Task_21232_Desc = {
    Text = "クリア時に休憩所での回復が1回以下"
  },
  Task_21232_Name = {
    Text = "無火の人"
  },
  Task_21233_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21233_Name = {
    Text = "完璧な通過"
  },
  Task_21234_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21234_Name = {
    Text = "完璧な通過"
  },
  Task_21235_Desc = {
    Text = "最終戦で1ターンに追加で最低4枚のカードを引く"
  },
  Task_21235_Name = {
    Text = "ドロー！"
  },
  Task_21236_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21236_Name = {Text = "速攻"},
  Task_21237_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21237_Name = {Text = "速攻"},
  Task_21238_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21238_Name = {
    Text = "完璧な通過"
  },
  Task_21239_Desc = {
    Text = "最終戦で1ターンに最低3回狂気解放を行う"
  },
  Task_21239_Name = {
    Text = "死に至る魔術"
  },
  Task_21240_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21240_Name = {
    Text = "完璧な通過"
  },
  Task_21241_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21241_Name = {
    Text = "完璧な通過"
  },
  Task_21242_Desc = {
    Text = "クリア時のライフが80%以上"
  },
  Task_21242_Name = {
    Text = "優雅で正確"
  },
  Task_21243_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21243_Name = {Text = "速攻"},
  Task_21244_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21244_Name = {Text = "速攻"},
  Task_21245_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21245_Name = {Text = "速攻"},
  Task_21246_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21246_Name = {Text = "速攻"},
  Task_21247_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21247_Name = {Text = "速攻"},
  Task_21248_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21248_Name = {Text = "速攻"},
  Task_21249_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21249_Name = {Text = "速攻"},
  Task_21250_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_21250_Name = {Text = "速攻"},
  Task_21251_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21251_Name = {Text = "速攻"},
  Task_21252_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21252_Name = {Text = "速攻"},
  Task_21253_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21253_Name = {Text = "速攻"},
  Task_21254_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21254_Name = {
    Text = "優雅で正確"
  },
  Task_21255_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21255_Name = {Text = "速攻"},
  Task_21256_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21256_Name = {Text = "速攻"},
  Task_21257_Desc = {
    Text = "精鋭戦で1ターンに最低6000ダメージを与える"
  },
  Task_21257_Name = {
    Text = "全力一撃"
  },
  Task_21258_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_21258_Name = {
    Text = "伏兵の宝物"
  },
  Task_21259_Desc = {
    Text = "最終戦で1ターン中カード5枚以上使用"
  },
  Task_21259_Name = {
    Text = "私のターン"
  },
  Task_21260_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21260_Name = {
    Text = "完璧な通過"
  },
  Task_21261_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21261_Name = {
    Text = "完璧な通過"
  },
  Task_21262_Desc = {
    Text = "4種以上の異なる刻印を獲得"
  },
  Task_21262_Name = {
    Text = "霊魂烙印"
  },
  Task_21263_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21263_Name = {
    Text = "完璧な通過"
  },
  Task_21264_Desc = {
    Text = "クリア時、遺物を2個以上所持"
  },
  Task_21264_Name = {
    Text = "伏兵の宝物"
  },
  Task_21265_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21265_Name = {Text = "速攻"},
  Task_21266_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21266_Name = {
    Text = "完璧な通過"
  },
  Task_21267_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21267_Name = {
    Text = "完璧な通過"
  },
  Task_21268_Desc = {
    Text = "覚醒体3名以上を覚醒"
  },
  Task_21268_Name = {
    Text = "無限の抱擁"
  },
  Task_21269_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21269_Name = {
    Text = "完璧な通過"
  },
  Task_21270_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21270_Name = {Text = "速攻"},
  Task_21271_Desc = {
    Text = "クリア時、遺物を5個以上所持"
  },
  Task_21271_Name = {
    Text = "伏兵の宝物"
  },
  Task_21272_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21272_Name = {Text = "速攻"},
  Task_21273_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21273_Name = {Text = "速攻"},
  Task_21274_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21274_Name = {
    Text = "完璧な通過"
  },
  Task_21275_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_21275_Name = {Text = "速攻"},
  Task_21276_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21276_Name = {
    Text = "完璧な通過"
  },
  Task_21277_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21277_Name = {Text = "速攻"},
  Task_21278_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21278_Name = {
    Text = "完璧な通過"
  },
  Task_21279_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21279_Name = {
    Text = "完璧な通過"
  },
  Task_21280_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_21280_Name = {
    Text = "無限の抱擁"
  },
  Task_21281_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_21281_Name = {
    Text = "省エネ主義"
  },
  Task_21282_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21282_Name = {
    Text = "完璧な通過"
  },
  Task_21283_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21283_Name = {
    Text = "完璧な通過"
  },
  Task_21284_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21284_Name = {
    Text = "完璧な通過"
  },
  Task_21285_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21285_Name = {
    Text = "完璧な通過"
  },
  Task_21286_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21286_Name = {
    Text = "完璧な通過"
  },
  Task_21287_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21287_Name = {
    Text = "完璧な通過"
  },
  Task_21288_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21288_Name = {
    Text = "完璧な通過"
  },
  Task_21289_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21289_Name = {
    Text = "完璧な通過"
  },
  Task_21290_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21290_Name = {
    Text = "完璧な通過"
  },
  Task_21291_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21291_Name = {
    Text = "完璧な通過"
  },
  Task_21292_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21292_Name = {
    Text = "完璧な通過"
  },
  Task_21293_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_21293_Name = {Text = "速攻"},
  Task_21294_Desc = {
    Text = "最終戦で1ターンに最大ライフの60%のシールドを獲得"
  },
  Task_21294_Name = {
    Text = "鋼鉄の体"
  },
  Task_21295_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_21295_Name = {
    Text = "無限の抱擁"
  },
  Task_21296_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_21296_Name = {
    Text = "優雅で正確"
  },
  Task_21297_Desc = {
    Text = "最終戦で1ターンに追加で最低4枚のカードを引く"
  },
  Task_21297_Name = {
    Text = "ドロー！"
  },
  Task_21298_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_21298_Name = {Text = "速攻"},
  Task_21299_Desc = {
    Text = "最終戦で15ターン以内に勝利"
  },
  Task_21299_Name = {Text = "速攻"},
  Task_21300_Desc = {
    Text = "チューチュー、チューチュー……！！"
  },
  Task_21300_Name = {
    Text = "チューチュー"
  },
  Task_21301_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_21301_Name = {
    Text = "完璧な通過"
  },
  Task_21401_Desc = {
    Text = "カードを50枚使用"
  },
  Task_21401_Name = {
    Text = "日々の訓練"
  },
  Task_21794_Desc = {
    Text = "累計ログイン 3 日"
  },
  Task_21795_Desc = {
    Text = "累計ログイン 7 日"
  },
  Task_21821_Desc = {
    Text = "初期40点、3ターン後に毎ターン5点減少"
  },
  Task_21821_Name = {
    Text = "精鋭ターン数 <size=20><color=#747474>初期40点、3ターン後ごとに5点減少</color></size>"
  },
  Task_21822_Desc = {
    Text = "初期40点、クリア時に40歩を超えると1歩ごとに2点減少"
  },
  Task_21822_Name = {
    Text = "累計歩数 <size=20><color=#747474>初期40ポイント、クリア時に40歩を超えると1歩ごとに2点減少</color></size>"
  },
  Task_21823_Desc = {
    Text = "初期600点、12ターン後に毎ターン60点減少"
  },
  Task_21823_Name = {
    Text = "最終戦のターン数 <size=20><color=#747474>初期600ポイント、12ターンを超えるごとに毎ターン60点減少</color></size>"
  },
  Task_21824_Desc = {
    Text = "毎試合初期30ポイント、2ターン後毎ターン3点減少"
  },
  Task_21824_Name = {
    Text = "戦闘ターン数 <size=20><color=#747474>各戦闘開始時30分、2ターン以降は毎ターン3分減少</color></size>"
  },
  Task_21907_Desc = {
    Text = "累計で召喚を50回行う"
  },
  Task_21908_Desc = {
    Text = "累計で召喚を300回行う"
  },
  Task_21914_Desc = {
    Text = "調査レベル40到達"
  },
  Task_21915_Desc = {
    Text = "「調査」第1章を完了する"
  },
  Task_21916_Desc = {
    Text = "調査レベル30到達"
  },
  Task_21917_Desc = {
    Text = "調査レベル20到達"
  },
  Task_21918_Desc = {
    Text = "調査レベル50到達"
  },
  Task_22347_Desc = {
    Text = "ユウハシュを撃破"
  },
  Task_22347_Name = {Text = "目標"},
  Task_22348_Desc = {
    Text = "オーギュストの衝動を抑える"
  },
  Task_22348_Name = {Text = "目標"},
  Task_22349_Desc = {
    Text = "姫を護る"
  },
  Task_22349_Name = {Text = "目標"},
  Task_22350_Desc = {
    Text = "オーギュストを止める"
  },
  Task_22350_Name = {Text = "目標"},
  Task_22351_Desc = {
    Text = "アグリッパを見つける"
  },
  Task_22351_Name = {Text = "目標"},
  Task_22352_Desc = {
    Text = "砂嵐を避ける"
  },
  Task_22352_Name = {Text = "目標"},
  Task_22353_Desc = {
    Text = "エリカを保護する"
  },
  Task_22353_Name = {Text = "目標"},
  Task_22354_Desc = {
    Text = "エリカを見つける"
  },
  Task_22354_Name = {Text = "目標"},
  Task_22355_Desc = {
    Text = "ユウハシュを追え"
  },
  Task_22355_Name = {Text = "目標"},
  Task_22356_Desc = {
    Text = "怒れる奴隷を撃退"
  },
  Task_22356_Name = {Text = "目標"},
  Task_22358_Desc = {
    Text = "最大ライフ50%のシールドを重ねる"
  },
  Task_22358_Name = {
    Text = "ライフの守護Ⅱ"
  },
  Task_22359_Desc = {
    Text = "最大ライフ30%のシールドを重ねる"
  },
  Task_22359_Name = {
    Text = "ライフの守護Ⅰ"
  },
  Task_22380_Desc = {
    Text = "メインストーリー第5章「@1@2」の黒い水たまりを10箇所見つける"
  },
  Task_22380_Desc2 = {
    Text = "メインストーリー第5章「嵐の眼」の黒い水たまり10箇所を見つける"
  },
  Task_22380_Name2 = {
    Text = "潜むささやきⅤ"
  },
  Task_22381_Desc = {
    Text = "時空のくびれを600回完了する"
  },
  Task_22381_Name = {
    Text = "曲がった視界Ⅴ"
  },
  Task_22382_Desc = {
    Text = "時空のくびれを100回完了する"
  },
  Task_22382_Name = {
    Text = "曲がった視界Ⅱ"
  },
  Task_22383_Desc = {
    Text = "時空のくびれを50回完了する"
  },
  Task_22383_Name = {
    Text = "曲がった視界"
  },
  Task_22384_Desc = {
    Text = "時空のくびれを400回完了する"
  },
  Task_22384_Name = {
    Text = "曲がった視界Ⅳ"
  },
  Task_22385_Desc = {
    Text = "時空のくびれを200回完了する"
  },
  Task_22385_Name = {
    Text = "曲がった視界Ⅲ"
  },
  Task_22387_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_22387_Desc2 = {
    Text = "調査「嵐の眼」を完了する"
  },
  Task_22387_Name2 = {
    Text = "迷失の三角"
  },
  Task_22388_Desc = {
    Text = "調査「@1@2」で3回共鳴する"
  },
  Task_22388_Desc2 = {
    Text = "調査「嵐の眼」で3回共鳴する"
  },
  Task_22388_Name2 = {
    Text = "絶望の残響"
  },
  Task_22389_Desc = {
    Text = "調査「嵐の眼」高難度を完了する"
  },
  Task_22389_Name = {
    Text = "失われた三角・高難度"
  },
  Task_22390_Desc = {
    Text = "調査「@1@2」で7回共鳴する"
  },
  Task_22390_Desc2 = {
    Text = "調査「嵐の眼」で7回共鳴する"
  },
  Task_22390_Name2 = {
    Text = "絶望の残響Ⅲ"
  },
  Task_22391_Desc = {
    Text = "調査「@1@2」で6回共鳴する"
  },
  Task_22391_Desc2 = {
    Text = "調査「嵐の眼」で6回共鳴する"
  },
  Task_22391_Name2 = {
    Text = "絶望の残響Ⅱ"
  },
  Task_22392_Desc = {
    Text = "調査「@1@2」で10回共鳴する"
  },
  Task_22392_Desc2 = {
    Text = "調査「嵐の眼」で10回共鳴する"
  },
  Task_22392_Name2 = {
    Text = "絶望の残響Ⅳ"
  },
  Task_23613_Desc = {
    Text = "ダフォダイルを探す"
  },
  Task_23613_Name = {Text = "目標"},
  Task_23614_Desc = {
    Text = "百貨店へ"
  },
  Task_23614_Name = {Text = "目標"},
  Task_23615_Desc = {
    Text = "撮影を完了する"
  },
  Task_23615_Name = {Text = "目標"},
  Task_23616_Desc = {
    Text = "イベント会場に戻る"
  },
  Task_23616_Name = {Text = "目標"},
  Task_23617_Desc = {
    Text = "撮影を行う"
  },
  Task_23617_Name = {Text = "目標"},
  Task_23618_Name = {Text = "目標"},
  Task_23619_Desc = {
    Text = "敵を撃退する"
  },
  Task_23619_Name = {Text = "目標"},
  Task_23620_Desc = {
    Text = "療養所を訪れる"
  },
  Task_23620_Name = {Text = "目標"},
  Task_23646_Desc = {
    Text = "累計で召喚を1000回行う"
  },
  Task_23708_Desc = {
    Text = "最終戦で1ターンに追加で5枚のカードを引き、100ポイントを獲得する"
  },
  Task_23708_Name = {
    Text = "もう一度引け <size=20><color=#747474>最終戦で1ターンに追加で5枚引く</color></size>"
  },
  Task_23709_Desc = {
    Text = "高級遺物を5個取得、100ポイント獲得する"
  },
  Task_23709_Name = {
    Text = "金色の煌めき<size=20><color=#747474>高級遺物を5個獲得する</color></size>"
  },
  Task_23710_Desc = {
    Text = "2個の呪われた遺物を獲得する。と100ポイントを獲得する"
  },
  Task_23710_Name = {
    Text = "伏兵の宝物 <size=20><color=#747474>呪われた遺物を2個獲得する</color></size>"
  },
  Task_23711_Desc = {
    Text = "最終戦で1ターン中7枚のカードを使用し、100ポイントを獲得する"
  },
  Task_23711_Name = {
    Text = "私のターン <size=20><color=#747474>最終戦で1ターン中カード7枚以上使用</color></size>"
  },
  Task_23712_Desc = {
    Text = "4名の覚醒体を覚醒すると、100ポイントを獲得する。"
  },
  Task_23712_Name = {
    Text = "覚醒の瞬間 <size=20><color=#747474>4名の覚醒体を覚醒させる</color></size>"
  },
  Task_23713_Desc = {
    Text = "最終戦で1ターンに追加で3点の行動力を獲得すると、100ポイントを獲得する"
  },
  Task_23713_Name = {
    Text = "神算妙計 <size=20><color=#747474>最終戦で1ターンに追加で3点の行動力を獲得する。</color></size>"
  },
  Task_23714_Desc = {
    Text = "最終戦で1ターンで最低3回の狂気解放を使用する、100ポイント獲得する"
  },
  Task_23714_Name = {
    Text = "死に至る魔術  <size=20><color=#747474>最終戦で1ターンに最低3回狂気解放を使用する</color></size>"
  },
  Task_23715_Desc = {
    Text = "11個の刻印を獲得する。と100ポイントを獲得する"
  },
  Task_23715_Name = {
    Text = "刻印の力<size=20><color=#747474>刻印を11個獲得する</color></size>"
  },
  Task_23716_Desc = {
    Text = "最終戦で1ターンでボス最大ライフの50%のダメージを与え、100点を獲得する。"
  },
  Task_23716_Name = {
    Text = "到来の穢れ  <size=20><color=#747474>最終戦の1ターンでボスの最大ライフの50%を超えるダメージを与える</color></size>"
  },
  Task_23717_Desc = {
    Text = "9種の異なる刻印を取得、100ポイント獲得する"
  },
  Task_23717_Name = {
    Text = "刻印コレクション<size=20><color=#747474>異なる刻印を9個獲得する</color></size>"
  },
  Task_23718_Desc = {
    Text = "最終戦で1ターンで最大ライフの80%のシールドを得て100点を獲得する。"
  },
  Task_23718_Name = {
    Text = "鋼鉄の体<size=20><color=#747474>最終戦で最大ライフの80%のシールドを一回獲得する。</color></size>"
  },
  Task_23719_Desc = {
    Text = "クリア時の症状が4枚以上で100ポイント獲得する"
  },
  Task_23719_Name = {
    Text = "末期患者 <size=20><color=#747474>クリア時の症状が4枚以上</color></size>"
  },
  Task_23720_Desc = {
    Text = "最終戦で毎ターン狂気解放を使用し、100ポイントを獲得する"
  },
  Task_23720_Name = {
    Text = "恐怖のショー <size=20><color=#747474>最終戦で毎ターン狂気解放を使用する</color></size>"
  },
  Task_23721_Desc = {
    Text = "遺物を7個獲得すると、100点を獲得する。"
  },
  Task_23721_Name = {
    Text = "満載の帰還  <size=20><color=#747474>7つの遺物を獲得する</color></size>"
  },
  Task_23722_Desc = {
    Text = "任意の戦闘で1ターン内に4体の敵を倒すと、100点を獲得する"
  },
  Task_23722_Name = {
    Text = "許せない <size=20><color=#747474>任意の戦闘で1ターンに4体の敵を倒す</color></size>"
  },
  Task_23789_Desc = {
    Text = "累計ログイン 30 日"
  },
  Task_23868_Desc = {
    Text = "対人戦で5勝する"
  },
  Task_23868_Name = {
    Text = "毎週の報酬"
  },
  Task_23869_Desc = {
    Text = "相位対弈の段位が達人Ⅰに到達"
  },
  Task_23873_Desc = {
    Text = "最終戦で1ターンでボス最大ライフの30%のダメージを与え、100点を獲得する。"
  },
  Task_23873_Name = {
    Text = "到来の穢れ  <size=20><color=#747474>最終戦の1ターンでボスの最大ライフの30%を超えるダメージを与える</color></size>"
  },
  Task_23874_Desc = {
    Text = "高級遺物または呪われた遺物を5個取得、100ポイント獲得する"
  },
  Task_23874_Name = {
    Text = "良し悪し<size=20><color=#747474>高級遺物または呪われた遺物を5つ獲得すると、100点を獲得する。</color></size>"
  },
  Task_23875_Desc = {
    Text = "8種の異なる刻印を取得、100ポイント獲得する"
  },
  Task_23875_Name = {
    Text = "刻印コレクション<size=20><color=#747474>異なる刻印を8個獲得する</color></size>"
  },
  Task_23876_Desc = {
    Text = "10個の刻印を獲得する。と100ポイントを獲得する"
  },
  Task_23876_Name = {
    Text = "刻印の力<size=20><color=#747474>刻印を10個獲得する</color></size>"
  },
  Task_23877_Desc = {
    Text = "最終戦で1ターンで最低4回の狂気解放を使用する、100ポイント獲得する"
  },
  Task_23877_Name = {
    Text = "死に至る魔術  <size=20><color=#747474>最終戦で1ターンに最低4回狂気解放を使用する</color></size>"
  },
  Task_23878_Desc = {
    Text = "任意の戦闘で1ターン内に3体の敵を倒すと、100点を獲得する"
  },
  Task_23878_Name = {
    Text = "許せない <size=20><color=#747474>任意の戦闘で1ターンに3体の敵を倒す</color></size>"
  },
  Task_23879_Desc = {
    Text = "遺物を8個獲得すると、100点を獲得する。"
  },
  Task_23879_Name = {
    Text = "満載の帰還  <size=20><color=#747474>8つの遺物を獲得する</color></size>"
  },
  Task_23885_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_23886_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_23887_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_23888_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_23889_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_23890_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_23891_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_23892_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_23893_Desc = {
    Text = "意識潜行「蒼白の末裔」通常モードを完了する"
  },
  Task_23893_Name = {
    Text = "クリア報酬"
  },
  Task_23894_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_23895_Desc = {
    Text = "特務記録「雨の町に潜む影」通常を完了"
  },
  Task_23895_Name = {
    Text = "クリア報酬"
  },
  Task_23896_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_24139_Desc = {
    Text = "クリア時、遺物を5個以上所持"
  },
  Task_24139_Name = {
    Text = "伏兵の宝物"
  },
  Task_24140_Desc = {
    Text = "最終戦で1ターン中カード6枚以上使用"
  },
  Task_24140_Name = {
    Text = "私のターン"
  },
  Task_24141_Desc = {
    Text = "クリア時、遺物を5個以上所持"
  },
  Task_24141_Name = {
    Text = "伏兵の宝物"
  },
  Task_24142_Desc = {
    Text = "最終戦で1ターン中カード6枚以上使用"
  },
  Task_24142_Name = {
    Text = "私のターン"
  },
  Task_24177_Desc = {
    Text = "動力室から脱出"
  },
  Task_24177_Name = {Text = "目標"},
  Task_24403_Desc = {
    Text = "怪しい馬車を追う"
  },
  Task_24403_Name = {Text = "目標"},
  Task_24404_Desc = {
    Text = "「N」の視線を避ける"
  },
  Task_24404_Name = {Text = "目標"},
  Task_24405_Desc = {
    Text = "《薔薇の名》の招待状を探す"
  },
  Task_24405_Name = {Text = "目標"},
  Task_24406_Desc = {
    Text = "人工密境に入り、事件当日に戻る"
  },
  Task_24406_Name = {Text = "目標"},
  Task_24407_Desc = {
    Text = "怪しい男を捕まえろ"
  },
  Task_24407_Name = {Text = "目標"},
  Task_24408_Desc = {
    Text = "侍女カレンを追う"
  },
  Task_24408_Name = {Text = "目標"},
  Task_24409_Desc = {
    Text = "謎の影の攻撃を防ぐ"
  },
  Task_24409_Name = {Text = "目標"},
  Task_24410_Desc = {
    Text = "仮面の影の攻撃を防ぐ"
  },
  Task_24410_Name = {Text = "目標"},
  Task_24411_Desc = {
    Text = "ランベール氏の捕獲"
  },
  Task_24411_Name = {Text = "目標"},
  Task_24412_Desc = {
    Text = "融蝕の怪物を撃退"
  },
  Task_24412_Name = {Text = "目標"},
  Task_24457_Desc = {
    Text = "最終戦で1ターンで最低3/4回の狂気解放を使用する、50/100ポイント獲得する。"
  },
  Task_24457_Name = {
    Text = "死に至る魔術<size=20><color=#747474>最終戦で1ターンに最低3回狂気解放を使用する</color></size>"
  },
  Task_24458_Desc = {
    Text = "7/9/11個の刻印を取得、30/60/100ポイント獲得する。"
  },
  Task_24458_Name = {
    Text = "刻印の力<size=20><color=#747474>刻印を7個獲得する</color></size>"
  },
  Task_24459_Desc = {
    Text = "4/5/6個の高級遺物を獲得する。と、それぞれ30/60/100ポイントを獲得する。"
  },
  Task_24459_Name = {
    Text = "金色の煌めき<size=20><color=#747474>高級遺物を5個獲得する</color></size>"
  },
  Task_24460_Desc = {
    Text = "4/5/6個の高級遺物を獲得する。と、それぞれ30/60/100ポイントを獲得する。"
  },
  Task_24460_Name = {
    Text = "金色の煌めき<size=20><color=#747474>高級遺物を4個獲得する</color></size>"
  },
  Task_24461_Desc = {
    Text = "4/5/6個の高級遺物または呪われた遺物を獲得する。と、それぞれ30/60/100ポイントを獲得する。"
  },
  Task_24461_Name = {
    Text = "良し悪し<size=20><color=#747474>高級遺物または呪われた遺物を6つ獲得する</color></size>"
  },
  Task_24462_Desc = {
    Text = "4/5/6個の高級遺物または呪われた遺物を獲得する。と、それぞれ30/60/100ポイントを獲得する。"
  },
  Task_24462_Name = {
    Text = "良し悪し<size=20><color=#747474>高級遺物または呪われた遺物を4つ獲得する</color></size>"
  },
  Task_24463_Desc = {
    Text = "4/5/6個の高級遺物または呪われた遺物を獲得する。と、それぞれ30/60/100ポイントを獲得する。"
  },
  Task_24463_Name = {
    Text = "良し悪し<size=20><color=#747474>高級遺物または呪われた遺物を5つ獲得する</color></size>"
  },
  Task_24464_Desc = {
    Text = "7/9/11個の刻印を取得、30/60/100ポイント獲得する。"
  },
  Task_24464_Name = {
    Text = "刻印の力<size=20><color=#747474>刻印を9個獲得する</color></size>"
  },
  Task_24465_Desc = {
    Text = "3/4名の覚醒体を覚醒すると、50/100ポイントを獲得する。"
  },
  Task_24465_Name = {
    Text = "覚醒の瞬間<size=20><color=#747474>3名の覚醒体を覚醒させる</color></size>"
  },
  Task_24466_Desc = {
    Text = "最終戦で1ターン中5/7/9枚のカードを使用し、30/60/100ポイントを獲得する。"
  },
  Task_24466_Name = {
    Text = "私のターン<size=20><color=#747474>最終戦で1ターン中カード9枚以上使用</color></size>"
  },
  Task_24467_Desc = {
    Text = "3/4名の覚醒体を覚醒すると、50/100ポイントを獲得する。"
  },
  Task_24467_Name = {
    Text = "覚醒の瞬間<size=20><color=#747474>4名の覚醒体を覚醒させる</color></size>"
  },
  Task_24468_Desc = {
    Text = "最終戦で1ターンで最低3/4回の狂気解放を使用する、50/100ポイント獲得する。"
  },
  Task_24468_Name = {
    Text = "死に至る魔術<size=20><color=#747474>最終戦で1ターンに最低4回狂気解放を使用する</color></size>"
  },
  Task_24469_Desc = {
    Text = "最終戦で1ターンに追加で2/3/4点の行動力を獲得すると、30/60/100ポイントを獲得する。"
  },
  Task_24469_Name = {
    Text = "神算妙計<size=20><color=#747474>最終戦で1ターンに2点の行動力を追加獲得</color></size>"
  },
  Task_24470_Desc = {
    Text = "最終戦で1ターンに追加で2/3/4点の行動力を獲得すると、30/60/100ポイントを獲得する。"
  },
  Task_24470_Name = {
    Text = "神算妙計<size=20><color=#747474>最終戦で1ターンに3点の行動力を追加獲得</color></size>"
  },
  Task_24471_Desc = {
    Text = "クリア時の症状が3/4枚以上で50/100ポイント獲得する"
  },
  Task_24471_Name = {
    Text = "末期患者<size=20><color=#747474>クリア時の症状が3枚以上</color></size>"
  },
  Task_24472_Desc = {
    Text = "クリア時の症状が3/4枚以上で50/100ポイント獲得する"
  },
  Task_24472_Name = {
    Text = "末期患者<size=20><color=#747474>クリア時の症状が4枚以上</color></size>"
  },
  Task_24473_Desc = {
    Text = "最終戦で1ターンに追加で2/3/4点の行動力を獲得すると、30/60/100ポイントを獲得する。"
  },
  Task_24473_Name = {
    Text = "神算妙計<size=20><color=#747474>最終戦で1ターンに4点の行動力を追加獲得</color></size>"
  },
  Task_24474_Desc = {
    Text = "クリア時に任意の覚醒体のカードが2/1枚以下で50/100点獲得する"
  },
  Task_24474_Name = {
    Text = "無視された<size=20><color=#747474>クリア時に1体の覚醒体のカード総数が2枚以下</color></size>"
  },
  Task_24475_Desc = {
    Text = "最終戦で連続3/4/5ターン狂気解放を使用し、30/60/100ポイントを獲得する。"
  },
  Task_24475_Name = {
    Text = "恐怖のショー<size=20><color=#747474>最終戦で5ターン連続狂気解放を使用</color></size>"
  },
  Task_24476_Desc = {
    Text = "クリア時に任意の覚醒体のカードが2/1枚以下で50/100点獲得する"
  },
  Task_24476_Name = {
    Text = "無視された<size=20><color=#747474>クリア時に1体の覚醒体のカード総数が1枚以下</color></size>"
  },
  Task_24477_Desc = {
    Text = "最終戦で連続3/4/5ターン狂気解放を使用し、30/60/100ポイントを獲得する。"
  },
  Task_24477_Name = {
    Text = "恐怖のショー<size=20><color=#747474>最終戦で4ターン連続狂気解放を使用</color></size>"
  },
  Task_24478_Desc = {
    Text = "6/7/8個の遺物を獲得すると、30/60/100点を獲得する。"
  },
  Task_24478_Name = {
    Text = "満載の帰還<size=20><color=#747474>7つの遺物を獲得する</color></size>"
  },
  Task_24479_Desc = {
    Text = "6/7/8個の遺物を獲得すると、30/60/100点を獲得する。"
  },
  Task_24479_Name = {
    Text = "満載の帰還<size=20><color=#747474>6つの遺物を獲得する</color></size>"
  },
  Task_24480_Desc = {
    Text = "最終戦で1ターンで最大ライフの25%/50%/75%のシールドを獲得すると、30/60/100点を獲得する。"
  },
  Task_24480_Name = {
    Text = "鋼鉄の体<size=20><color=#747474>最終戦で最大ライフの25%のシールドを一回獲得する。</color></size>"
  },
  Task_24481_Desc = {
    Text = "最終戦で1ターンでボス最大ライフの20%/30%/40%のダメージを与え、30/60/100点を獲得する。"
  },
  Task_24481_Name = {
    Text = "到来の穢れ<size=20><color=#747474>1ターンでボスの最大ライフの30%以上のダメージ</color></size>"
  },
  Task_24482_Desc = {
    Text = "6/7/8個の遺物を獲得すると、30/60/100点を獲得する。"
  },
  Task_24482_Name = {
    Text = "満載の帰還<size=20><color=#747474>8つの遺物を獲得する</color></size>"
  },
  Task_24483_Desc = {
    Text = "5/7/9種の異なる刻印を取得、30/60/100ポイント獲得する。"
  },
  Task_24483_Name = {
    Text = "刻印コレクション<size=20><color=#747474>異なる刻印を9個獲得する</color></size>"
  },
  Task_24484_Desc = {
    Text = "5/7/9種の異なる刻印を取得、30/60/100ポイント獲得する。"
  },
  Task_24484_Name = {
    Text = "刻印コレクション<size=20><color=#747474>異なる刻印を5個獲得する</color></size>"
  },
  Task_24485_Desc = {
    Text = "5/7/9種の異なる刻印を取得、30/60/100ポイント獲得する。"
  },
  Task_24485_Name = {
    Text = "刻印コレクション<size=20><color=#747474>異なる刻印を7個獲得する</color></size>"
  },
  Task_24486_Desc = {
    Text = "4/5/6個の高級遺物を獲得する。と、それぞれ30/60/100ポイントを獲得する。"
  },
  Task_24486_Name = {
    Text = "金色の煌めき<size=20><color=#747474>高級遺物を6個獲得する</color></size>"
  },
  Task_24487_Desc = {
    Text = "最終戦で連続3/4/5ターン狂気解放を使用し、30/60/100ポイントを獲得する。"
  },
  Task_24487_Name = {
    Text = "恐怖のショー<size=20><color=#747474>最終戦で3ターン連続狂気解放を使用</color></size>"
  },
  Task_24488_Desc = {
    Text = "2/3個の呪われた遺物を獲得する。と、それぞれ50/100ポイントを獲得する。"
  },
  Task_24488_Name = {
    Text = "伏兵の宝物<size=20><color=#747474>呪われた遺物を3個獲得する</color></size>"
  },
  Task_24489_Desc = {
    Text = "2/3個の呪われた遺物を獲得する。と、それぞれ50/100ポイントを獲得する。"
  },
  Task_24489_Name = {
    Text = "伏兵の宝物<size=20><color=#747474>呪われた遺物を2個獲得する</color></size>"
  },
  Task_24490_Desc = {
    Text = "最終戦で1ターンで最大ライフの25%/50%/75%のシールドを獲得すると、30/60/100点を獲得する。"
  },
  Task_24490_Name = {
    Text = "鋼鉄の体<size=20><color=#747474>最終戦で最大ライフの50%のシールドを一回獲得する。</color></size>"
  },
  Task_24491_Desc = {
    Text = "最終戦で1ターン中5/7/9枚のカードを使用し、30/60/100ポイントを獲得する。"
  },
  Task_24491_Name = {
    Text = "私のターン<size=20><color=#747474>最終戦で1ターン中カード7枚以上使用</color></size>"
  },
  Task_24492_Desc = {
    Text = "7/9/11個の刻印を取得、30/60/100ポイント獲得する。"
  },
  Task_24492_Name = {
    Text = "刻印の力<size=20><color=#747474>刻印を11個獲得する</color></size>"
  },
  Task_24493_Desc = {
    Text = "最終戦で1ターン中5/7/9枚のカードを使用し、30/60/100ポイントを獲得する。"
  },
  Task_24493_Name = {
    Text = "私のターン<size=20><color=#747474>最終戦で1ターン中カード5枚以上使用</color></size>"
  },
  Task_24494_Desc = {
    Text = "最終戦で1ターンでボス最大ライフの20%/30%/40%のダメージを与え、30/60/100点を獲得する。"
  },
  Task_24494_Name = {
    Text = "到来の穢れ<size=20><color=#747474>1ターンでボスの最大ライフの40%以上のダメージ</color></size>"
  },
  Task_24495_Desc = {
    Text = "最終戦で1ターンで最大ライフの25%/50%/75%のシールドを獲得すると、30/60/100点を獲得する。"
  },
  Task_24495_Name = {
    Text = "鋼鉄の体<size=20><color=#747474>最終戦で最大ライフの75%のシールドを一回獲得する。</color></size>"
  },
  Task_24496_Desc = {
    Text = "最終戦で1ターンでボス最大ライフの20%/30%/40%のダメージを与え、30/60/100点を獲得する。"
  },
  Task_24496_Name = {
    Text = "到来の穢れ<size=20><color=#747474>1ターンでボスの最大ライフの20%以上のダメージ</color></size>"
  },
  Task_24497_Desc = {
    Text = "任意の戦闘で1ターン内に3/4体の敵を倒すと、50/100点を獲得する。"
  },
  Task_24497_Name = {
    Text = "許されざる<size=20><color=#747474>任意の戦闘で1ターンに敵を4体倒す</color></size>"
  },
  Task_24498_Desc = {
    Text = "最終戦で1ターンに追加で4/5/6枚のカードを引き、30/60/100ポイントを獲得する。"
  },
  Task_24498_Name = {
    Text = "もう一度引け<size=20><color=#747474>最終戦で1ターンに追加で5枚引く</color></size>"
  },
  Task_24499_Desc = {
    Text = "最終戦で1ターンに追加で4/5/6枚のカードを引き、30/60/100ポイントを獲得する。"
  },
  Task_24499_Name = {
    Text = "もう一度引け<size=20><color=#747474>最終戦で1ターンに追加で4枚引く</color></size>"
  },
  Task_24500_Desc = {
    Text = "任意の戦闘で1ターン内に3/4体の敵を倒すと、50/100点を獲得する。"
  },
  Task_24500_Name = {
    Text = "許されざる<size=20><color=#747474>任意の戦闘で1ターンに敵を3体倒す</color></size>"
  },
  Task_24501_Desc = {
    Text = "最終戦で1ターンに追加で4/5/6枚のカードを引き、30/60/100ポイントを獲得する。"
  },
  Task_24501_Name = {
    Text = "もう一度引け<size=20><color=#747474>最終戦で1ターンに追加で6枚引く</color></size>"
  },
  Task_24534_Desc = {
    Text = "ラモンナを追う"
  },
  Task_24534_Name = {Text = "目標"},
  Task_25013_Desc = {
    Text = "特務記録「薔薇の讃歌」通常を完了"
  },
  Task_25013_Name = {
    Text = "クリア報酬"
  },
  Task_25014_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_25015_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_25016_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_25017_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_25018_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_25019_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_25020_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_25021_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_25022_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_25023_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_25024_Desc = {
    Text = "意識潜行「一歩の距離」通常を完了"
  },
  Task_25024_Name = {
    Text = "クリア報酬"
  },
  Task_25164_Desc = {
    Text = "ラモンナに従う"
  },
  Task_25164_Name = {Text = "目標"},
  Task_25167_Desc = {
    Text = "謎の邸宅に入る"
  },
  Task_25167_Name = {Text = "目標"},
  Task_25168_Desc = {
    Text = "ソレール夫人のボックスに戻る"
  },
  Task_25168_Name = {Text = "目標"},
  Task_34729_Desc = {
    Text = "脚本の謎·超次元"
  },
  Task_34731_Desc = {
    Text = "脚本の謎·カオス"
  },
  Task_34734_Desc = {
    Text = "特務記録"
  },
  Task_34737_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_34740_Desc = {
    Text = "脚本の謎·深海"
  },
  Task_34741_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_34742_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_34743_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_34744_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_34745_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_34746_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_34748_Desc = {
    Text = "脚本の謎・血肉"
  },
  Task_34750_Desc = {
    Text = "「特命記録」のすべての任務を完了"
  },
  Task_34942_Desc = {
    Text = "混沌界域の覚醒体を使用して「脚本の謎」で累計25回キーを使用する"
  },
  Task_34943_Desc = {
    Text = "「脚本の謎」で、累計50枚の「胎児」を獲得"
  },
  Task_34944_Desc = {
    Text = "「脚本の謎」において、超次元ターンに累計10回進入する"
  },
  Task_34945_Desc = {
    Text = "「脚本の謎」において、触腕攻撃を累積250回使用する"
  },
  Task_34946_Desc = {
    Text = "血肉界域の覚醒体を使用し「脚本の謎」で1回勝利"
  },
  Task_34947_Desc = {
    Text = "超次元界域の覚醒体を使用し「脚本の謎」で1回勝利"
  },
  Task_34948_Desc = {
    Text = "「脚本の謎」で、タッチアーム攻撃を100回以上使用する"
  },
  Task_34949_Desc = {
    Text = "「脚本の謎」において、累計で超次元ターンに5回進入する"
  },
  Task_34950_Desc = {
    Text = "深海界域の覚醒体を使用し「脚本の謎」で1回勝利"
  },
  Task_34951_Desc = {
    Text = "「脚本の謎」で、累計15枚の「胎児」を獲得"
  },
  Task_34952_Desc = {
    Text = "カオス境界の覚醒体を使用し、「脚本の謎」で累計10回キーを使用する"
  },
  Task_34953_Desc = {
    Text = "混沌界域の覚醒体を使用し「脚本の謎」で1回勝利"
  },
  Task_35262_Desc = {
    Text = "「脚本の謎」のすべての境界任務を完了"
  },
  Task_35263_Desc = {Text = "終章"},
  Task_35808_Desc = {
    Text = "薔薇金券を累計 500万 消費"
  },
  Task_35808_Name = {
    Text = "金を湯水のように使う"
  },
  Task_36141_Desc = {
    Text = "調査「@1@2」で6回共鳴する"
  },
  Task_36141_Desc2 = {
    Text = "調査「倒錯した星々」で6回共鳴する"
  },
  Task_36141_Name2 = {
    Text = "渇望の残響Ⅱ"
  },
  Task_36142_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_36142_Desc2 = {
    Text = "調査「倒錯した星々」を完了する"
  },
  Task_36142_Name2 = {
    Text = "呼びかけ拒否"
  },
  Task_36143_Desc = {
    Text = "調査「@1@2」で3回共鳴する"
  },
  Task_36143_Desc2 = {
    Text = "調査「倒錯した星々」で3回共鳴する"
  },
  Task_36143_Name2 = {
    Text = "渇望の残響"
  },
  Task_36144_Desc = {
    Text = "調査「倒錯した星々」高難度を完了する"
  },
  Task_36144_Name = {
    Text = "呼びかけ拒否・高難度"
  },
  Task_36145_Desc = {
    Text = "調査「@1@2」で8回共鳴する"
  },
  Task_36145_Desc2 = {
    Text = "調査「倒錯した星々」で8回共鳴する"
  },
  Task_36145_Name2 = {
    Text = "渇望の残響Ⅲ"
  },
  Task_36155_Desc = {
    Text = "船長をカバーして操縦"
  },
  Task_36155_Name = {Text = "目標"},
  Task_36156_Desc = {
    Text = "動力室に入る"
  },
  Task_36156_Name = {Text = "目標"},
  Task_36157_Desc = {
    Text = "仲間を探す"
  },
  Task_36157_Name = {Text = "目標"},
  Task_36158_Desc = {
    Text = "海踊人の攻勢を防ぐ"
  },
  Task_36158_Name = {Text = "目標"},
  Task_36159_Desc = {
    Text = "「聖なる赤子」に接近"
  },
  Task_36159_Name = {Text = "目標"},
  Task_36160_Desc = {
    Text = "攻撃を防ぐ"
  },
  Task_36160_Name = {Text = "目標"},
  Task_36161_Desc = {
    Text = "運転席に戻る"
  },
  Task_36161_Name = {Text = "目標"},
  Task_36162_Desc = {
    Text = "敵を撃退する"
  },
  Task_36162_Name = {Text = "目標"},
  Task_36163_Desc = {
    Text = "操縦室へ"
  },
  Task_36163_Name = {Text = "目標"},
  Task_36164_Desc = {
    Text = "動力室へ"
  },
  Task_36164_Name = {Text = "目標"},
  Task_36169_Desc = {Text = "広場へ"},
  Task_36169_Name = {Text = "目標"},
  Task_36316_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_36316_Name = {
    Text = "省エネ主義"
  },
  Task_36317_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_36317_Name = {
    Text = "省エネ主義"
  },
  Task_36359_Desc = {
    Text = "メインストーリー第6章「@1@2」の黒い水たまりを10箇所見つける"
  },
  Task_36359_Desc2 = {
    Text = "メインストーリー第6章「倒錯した星々」の黒い水たまり10箇所を見つける"
  },
  Task_36359_Name2 = {
    Text = "潜むささやきⅥ"
  },
  Task_36622_Desc = {
    Text = "異変を抑える村人"
  },
  Task_36622_Name = {Text = "目標"},
  Task_36623_Desc = {
    Text = "ワンダの寝宮へ"
  },
  Task_36623_Name = {Text = "目標"},
  Task_36624_Desc = {
    Text = "融蝕液の怪物を撃退"
  },
  Task_36624_Name = {Text = "目標"},
  Task_36842_Desc = {
    Text = "意識潜行「いつも通り」通常モードを完了する"
  },
  Task_36842_Name = {
    Text = "クリア報酬"
  },
  Task_36864_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_36872_Desc = {
    Text = "1回復活の魂魄を使用するごとに調査評価が30%減少する"
  },
  Task_36872_Name = {
    Text = "精神消耗  <size=20><color=#747474>復活の魂魄を1回使うごとに調査評価が30%減少</color></size>"
  },
  Task_38749_Desc = {
    Text = "エンフェリンを180消費する"
  },
  Task_38750_Desc = {
    Text = "救援を3回使用する"
  },
  Task_38751_Desc = {
    Text = "フレンドに10回「いいね」する"
  },
  Task_38752_Desc = {
    Text = "今週の試練を完了する"
  },
  Task_38753_Desc = {
    Text = "派遣を3回実行する"
  },
  Task_38754_Desc = {
    Text = "すべての訓練任務を完了する"
  },
  Task_38755_Desc = {
    Text = "幻夢の深奥1回勝利"
  },
  Task_38814_Desc = {
    Text = "混沌界域の覚醒体を使用し「湖中の城」で1回勝利"
  },
  Task_38815_Desc = {
    Text = "混沌界域の覚醒体を使用し「湖の都」で5回勝利する"
  },
  Task_38816_Desc = {
    Text = "使用混沌界域の覚醒体を「湖の都」で3回勝利する"
  },
  Task_38817_Desc = {
    Text = "湖の都・血肉"
  },
  Task_38818_Desc = {
    Text = "クリア「啓示録」任意の追憶"
  },
  Task_38819_Desc = {
    Text = "クリア「一段の記憶」任意の追憶"
  },
  Task_38820_Desc = {
    Text = "使用超次元領域覚醒体を「湖の都」で5回勝利する"
  },
  Task_38821_Desc = {
    Text = "超次元領域の覚醒体を使用して「湖の都」で3回勝利する"
  },
  Task_38822_Desc = {
    Text = "超次元界域の覚醒体を使用し「湖中の城」で1回勝利"
  },
  Task_38823_Desc = {
    Text = "湖の都・深海"
  },
  Task_38824_Desc = {
    Text = "「フリージア」の任意の追憶をクリア"
  },
  Task_38825_Desc = {
    Text = "「井」の任意の追憶をクリア"
  },
  Task_38826_Desc = {
    Text = "意識潜行"
  },
  Task_38827_Desc = {
    Text = "深海界域の覚醒体を使用して「湖中の城」で3回勝利する"
  },
  Task_38828_Desc = {
    Text = "深海界域の覚醒体を使用し「湖中の城」で5回勝利する"
  },
  Task_38829_Desc = {
    Text = "深海界域の覚醒体を使用し「湖中の城」で1回勝利"
  },
  Task_38830_Desc = {
    Text = "「蜃気楼」の任意の追憶をクリア"
  },
  Task_38831_Desc = {
    Text = "湖の都・カオス"
  },
  Task_38832_Desc = {
    Text = "「リアル」の任意の追憶をクリア"
  },
  Task_38833_Desc = {
    Text = "湖の都・追憶"
  },
  Task_38834_Desc = {
    Text = "「黄金の街」の任意の追憶をクリア"
  },
  Task_38835_Desc = {
    Text = "血肉界域の覚醒体を使用し「湖中の城」で1回勝利"
  },
  Task_38836_Desc = {
    Text = "血肉の境界の覚醒体を使用して「湖の都」で5回勝利する"
  },
  Task_38837_Desc = {
    Text = "血肉境界の覚醒体を使用して「湖の都」で3回勝利する"
  },
  Task_38838_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_38839_Desc = {
    Text = "湖の都·超次元"
  },
  Task_38840_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_39279_Desc = {
    Text = "「復活の魂魄」使用ごとに、調査評価が20%減少。（使用回数：{s1}）"
  },
  Task_39279_Name = {
    Text = "幻界の救済<size=20><color=#747474>復活の魂魄使用ごとに、調査評価20%減少</color></size>"
  },
  Task_40465_Desc = {
    Text = "1/2/3回以上の死亡抵抗を発動し、100/300/500点を獲得。"
  },
  Task_40465_Name = {
    Text = "生死の狭間<size=20><color=#747474>死亡抵抗を1回発動</color></size>"
  },
  Task_40466_Desc = {
    Text = "1/2/3回以上の死亡抵抗を発動し、100/300/500点を獲得。"
  },
  Task_40466_Name = {
    Text = "生死の狭間<size=20><color=#747474>死亡抵抗を3回以上発動</color></size>"
  },
  Task_40467_Desc = {
    Text = "1/2/3回以上の死亡抵抗を発動し、100/300/500点を獲得。"
  },
  Task_40467_Name = {
    Text = "生死の狭間<size=20><color=#747474>死亡抵抗を2回発動</color></size>"
  },
  Task_40468_Desc = {
    Text = "5/6/7/8個の遺物を持つことで、250/500/750/1000点を獲得。"
  },
  Task_40468_Name = {
    Text = "真理の探索<size=20><color=#747474>5個の遺物を保持</color></size>"
  },
  Task_40469_Desc = {
    Text = "5/6/7/8個の遺物を持つことで、250/500/750/1000点を獲得。"
  },
  Task_40469_Name = {
    Text = "真理の探索<size=20><color=#747474>7個の遺物を所有</color></size>"
  },
  Task_40470_Desc = {
    Text = "5/6/7/8個の遺物を持つことで、250/500/750/1000点を獲得。"
  },
  Task_40470_Name = {
    Text = "真理の探索<size=20><color=#747474>6個の遺物を所有</color></size>"
  },
  Task_40471_Desc = {
    Text = "最終戦で11/10/9/8ターン以内に勝利すると、250/500/750/1000\n/1000点を獲得。"
  },
  Task_40471_Name = {
    Text = "夢幻の疾走<size=20><color=#747474>8ターン以内にボスを倒す</color></size>"
  },
  Task_40472_Desc = {
    Text = "最終戦で11/10/9/8ターン以内に勝利すると、250/500/750/1000\n/1000点を獲得。"
  },
  Task_40472_Name = {
    Text = "夢幻の疾走<size=20><color=#747474>8ターン以内にボスを倒す</color></size>"
  },
  Task_40473_Desc = {
    Text = "最終戦で11/10/9/8ターン以内に勝利すると、250/500/750/1000\n/1000点を獲得。"
  },
  Task_40473_Name = {
    Text = "夢幻の疾走<size=20><color=#747474>9ターン以内にボスを倒す</color></size>"
  },
  Task_40474_Desc = {
    Text = "最終戦で11/10/9/8ターン以内に勝利すると、250/500/750/1000\n/1000点を獲得。"
  },
  Task_40474_Name = {
    Text = "夢幻の疾走<size=20><color=#747474>10ターン以内にボスを倒す</color></size>"
  },
  Task_40475_Desc = {
    Text = "最終戦で11/10/9/8ターン以内に勝利すると、250/500/750/1000\n/1000点を獲得。"
  },
  Task_40475_Name = {
    Text = "夢幻の疾走<size=20><color=#747474>11ターン以内にボスを倒す</color></size>"
  },
  Task_40476_Desc = {
    Text = "最終戦で勝利すると、1000点を獲得。"
  },
  Task_40476_Name = {
    Text = "凶夢の終焉<size=20><color=#747474>ボス戦に勝利する</color></size>"
  },
  Task_41334_Desc = {
    Text = "ボス{s1}を撃退"
  },
  Task_41334_Name = {Text = "目標"},
  Task_41367_Desc = {
    Text = "「調査」第3章を完了する"
  },
  Task_41368_Desc = {
    Text = "「調査」第5章を完了する"
  },
  Task_41369_Desc = {
    Text = "「調査」第4章を完了する"
  },
  Task_41370_Desc = {
    Text = "「調査」第2章を完了する"
  },
  Task_41371_Desc = {
    Text = "特訓値が初めて\n325に到達"
  },
  Task_41372_Desc = {
    Text = "特訓値が初めて\n350に到達"
  },
  Task_41373_Desc = {
    Text = "特訓値が初めて\n225に到達"
  },
  Task_41374_Desc = {
    Text = "特訓値が初めて\n300に到達"
  },
  Task_41375_Desc = {
    Text = "特訓値が初めて\n100に到達"
  },
  Task_41376_Desc = {
    Text = "特訓値が初めて\n150に到達"
  },
  Task_41377_Desc = {
    Text = "特訓値が初めて\n50に到達"
  },
  Task_41380_Desc = {
    Text = "以上すべての追憶任務を完了する"
  },
  Task_43476_Desc = {
    Text = "守秘者がレベル55に到達"
  },
  Task_43476_Name = {
    Text = "守秘者の試練IV"
  },
  Task_43477_Desc = {
    Text = "守秘者がレベル45に到達"
  },
  Task_43477_Name = {
    Text = "守秘者の試練Ⅲ"
  },
  Task_43514_Desc = {
    Text = "グレンたちを撃退"
  },
  Task_43514_Name = {Text = "目標"},
  Task_43561_Desc = {
    Text = "調査メイン第6章\n「倒錯した星々」を完了"
  },
  Task_43562_Desc = {
    Text = "調査メイン第5章\n「嵐の眼」を完了"
  },
  Task_43563_Desc = {
    Text = "調査メイン第3章\n「猛犬注意」を完了"
  },
  Task_43564_Desc = {
    Text = "調査メイン第6章\n「倒錯した星々」高難度を完了"
  },
  Task_43565_Desc = {
    Text = "調査メイン第4章\n「無音の中で」高難度を完了"
  },
  Task_43566_Desc = {
    Text = "調査メイン第3章\n「猛犬注意」高難度を完了"
  },
  Task_43567_Desc = {
    Text = "調査メイン第5章\n「嵐の眼」高難度を完了"
  },
  Task_43568_Desc = {
    Text = "調査メイン第4章\n「無音の中で」を完了"
  },
  Task_43822_Desc = {
    Text = "レベル80の覚醒体を1体所持する"
  },
  Task_43822_Name = {
    Text = "「超越の力」Ⅰ"
  },
  Task_43824_Desc = {
    Text = "一度のダメージが250000に達する"
  },
  Task_43824_Name = {
    Text = "存在の耐えられない痛みⅣ"
  },
  Task_43825_Desc = {
    Text = "一度のダメージが500000に達する"
  },
  Task_43825_Name = {
    Text = "存在の耐えられない痛みⅤ"
  },
  Task_43826_Desc = {
    Text = "一度のダメージが50000に達する"
  },
  Task_43826_Name = {
    Text = "存在の耐えられない痛みⅡ"
  },
  Task_43827_Desc = {
    Text = "一度のダメージが100000に達する"
  },
  Task_43827_Name = {
    Text = "存在の耐えられない痛みⅢ"
  },
  Task_43828_Desc = {
    Text = "レベル80の覚醒体を3体所持する"
  },
  Task_43828_Name = {
    Text = "「超越の力」Ⅲ"
  },
  Task_43829_Desc = {
    Text = "レベル80の覚醒体を2体所持する"
  },
  Task_43829_Name = {
    Text = "「超越の力」Ⅱ"
  },
  Task_43831_Desc = {
    Text = "敵に毒を10000回重ねる"
  },
  Task_43831_Name = {
    Text = "現実の毒Ⅰ"
  },
  Task_43832_Desc = {
    Text = "意識潜行「騎士の願い」を完了する"
  },
  Task_43832_Name = {
    Text = "千夜一夜"
  },
  Task_43833_Desc = {
    Text = "意識潜行「燃える饗宴」を完了する"
  },
  Task_43833_Name = {
    Text = "月下に新しき事はなし"
  },
  Task_43834_Desc = {
    Text = "特務記録「薔薇の讃歌」高難度を完了"
  },
  Task_43834_Name = {
    Text = "赤い薔薇は沈黙しない・高難度"
  },
  Task_43835_Desc = {
    Text = "特務記録「物語の魔法」高難度を完了"
  },
  Task_43835_Name = {
    Text = "ありふれた子供時代・高難度"
  },
  Task_43836_Desc = {
    Text = "特務記録「物語の魔法」を完了"
  },
  Task_43836_Name = {
    Text = "ありふれた子供時代"
  },
  Task_43837_Desc = {
    Text = "特務記録「雨の町に潜む影」高難度を完了"
  },
  Task_43837_Name = {
    Text = "時代の魔女・高難度"
  },
  Task_43838_Desc = {
    Text = "特務記録「雨の町に潜む影」完了"
  },
  Task_43838_Name = {
    Text = "時代の魔女"
  },
  Task_43839_Desc = {
    Text = "特務記録「薔薇の讃歌」を完了"
  },
  Task_43839_Name = {
    Text = "赤い薔薇は沈黙しない"
  },
  Task_43840_Desc = {
    Text = "対人戦で2000回対人戦する"
  },
  Task_43840_Name = {
    Text = "重なり合う位相Ⅴ"
  },
  Task_43843_Desc = {
    Text = "SSR運命の札を1つ分解する"
  },
  Task_43843_Name = {
    Text = "外部の物"
  },
  Task_43844_Desc = {
    Text = "運命の札の強化を700回達成する"
  },
  Task_43844_Name = {
    Text = "量子もつれの未来Ⅰ"
  },
  Task_43845_Desc = {
    Text = "覚醒体スキルを1000回昇級"
  },
  Task_43845_Name = {
    Text = "「武器マスター」Ⅷ"
  },
  Task_43846_Desc = {
    Text = "覚醒体スキルを1100回昇級"
  },
  Task_43846_Name = {
    Text = "「武器マスター」Ⅸ"
  },
  Task_43847_Desc = {
    Text = "覚醒体スキルを1200回昇級"
  },
  Task_43847_Name = {
    Text = "「武器マスター」Ⅹ"
  },
  Task_43849_Desc = {
    Text = "運命の札を100個分解する"
  },
  Task_43849_Name = {
    Text = "貴重な好奇心"
  },
  Task_43850_Desc = {
    Text = "運命の札を200個分解する"
  },
  Task_43850_Name = {
    Text = "バラバラにする楽しみ"
  },
  Task_43851_Desc = {
    Text = "運命の札を300個分解する"
  },
  Task_43851_Name = {
    Text = "殻の中の宇宙"
  },
  Task_43863_Desc = {
    Text = "対人戦で1000回対人戦する"
  },
  Task_43863_Name = {
    Text = "重なり合う位相Ⅳ"
  },
  Task_43864_Desc = {
    Text = "対人戦で500回対人戦する"
  },
  Task_43864_Name = {
    Text = "重なり合う位相Ⅲ"
  },
  Task_43866_Desc = {
    Text = "「幻夢の深奥」を100回クリア"
  },
  Task_43866_Name = {
    Text = "夢の探索者"
  },
  Task_43867_Desc = {
    Text = "対人戦で250回対人戦する"
  },
  Task_43867_Name = {
    Text = "重なり合う位相Ⅱ"
  },
  Task_43868_Desc = {
    Text = "対人戦で100回対人戦する"
  },
  Task_43868_Name = {
    Text = "重なり合う位相Ⅰ"
  },
  Task_43869_Desc = {
    Text = "40名の覚醒体との同調率がレベル10に到達"
  },
  Task_43869_Name = {
    Text = "みんな、私の翼だ"
  },
  Task_43873_Desc = {
    Text = "運命の札の強化を600回達成する"
  },
  Task_43873_Name = {
    Text = "交錯する運命Ⅵ"
  },
  Task_43874_Desc = {
    Text = "運命の札の強化を500回達成する"
  },
  Task_43874_Name = {
    Text = "交錯する運命Ⅴ"
  },
  Task_43875_Desc = {
    Text = "運命の札の強化を400回達成する"
  },
  Task_43875_Name = {
    Text = "交錯する運命Ⅳ"
  },
  Task_43876_Desc = {
    Text = "運命の札の強化を300回達成する"
  },
  Task_43876_Name = {
    Text = "交錯する運命Ⅲ"
  },
  Task_43877_Desc = {
    Text = "運命の札の強化を200回達成する"
  },
  Task_43877_Name = {
    Text = "交錯する運命Ⅱ"
  },
  Task_43878_Desc = {
    Text = "運命の札の強化を100回達成する"
  },
  Task_43878_Name = {
    Text = "交錯する運命Ⅰ"
  },
  Task_43880_Desc = {
    Text = "覚醒体が霊知啓発を600回起動する"
  },
  Task_43880_Name = {
    Text = "未知からの呼び声"
  },
  Task_43881_Desc = {
    Text = "覚醒体が霊知啓発を500回起動する"
  },
  Task_43881_Name = {
    Text = "魂と肉の融合Ⅳ"
  },
  Task_43882_Desc = {
    Text = "覚醒体が霊知啓発を400回起動する"
  },
  Task_43882_Name = {
    Text = "魂と肉の融合Ⅲ"
  },
  Task_43883_Desc = {
    Text = "意識潜行「歌のような彫刻」高難度を完了する"
  },
  Task_43883_Name = {
    Text = "アレフの秘密・高難度"
  },
  Task_43884_Desc = {
    Text = "意識潜行「血と砂」高難度を完了する"
  },
  Task_43884_Name = {
    Text = "獣の言葉・高難度"
  },
  Task_43885_Desc = {
    Text = "意識潜行「一歩の距離」を完了する"
  },
  Task_43886_Desc = {
    Text = "意識潜行「いつも通り」を完了する"
  },
  Task_43886_Name = {
    Text = "見えない都市"
  },
  Task_43887_Desc = {
    Text = "意識潜行「騎士の願い」高難度を完了する"
  },
  Task_43887_Name = {
    Text = "千夜一夜 ・ 高難度"
  },
  Task_43888_Desc = {
    Text = "意識潜行「燃える饗宴」高難度を完了する"
  },
  Task_43888_Name = {
    Text = "月下に新しき事はなし・高難度"
  },
  Task_43889_Desc = {
    Text = "意識潜行「歌のような彫刻」を完了する"
  },
  Task_43889_Name = {
    Text = "アレフの秘密"
  },
  Task_43890_Desc = {
    Text = "意識潜行「血と砂」を完了する"
  },
  Task_43890_Name = {
    Text = "獣の言葉"
  },
  Task_43891_Desc = {
    Text = "意識潜行「歪みの核」を完了する"
  },
  Task_43891_Name = {
    Text = "オートマタは夢を見るか"
  },
  Task_43892_Desc = {
    Text = "意識潜行「蒼白の末裔」を完了する"
  },
  Task_43892_Name = {
    Text = "私のデミアン"
  },
  Task_43893_Desc = {
    Text = "敵に毒を25000回重ねる"
  },
  Task_43893_Name = {
    Text = "現実の毒Ⅱ"
  },
  Task_43896_Desc = {
    Text = "意識潜行「一歩の距離」高難度を完了する"
  },
  Task_43896_Name = {
    Text = "回路使者・高難度"
  },
  Task_43897_Desc = {
    Text = "10000回召喚儀式を行う"
  },
  Task_43897_Name = {
    Text = "知識の歌い手"
  },
  Task_43898_Desc = {
    Text = "意識潜行「歪みの核」高難度を完了する"
  },
  Task_43898_Name = {
    Text = "オートマタは夢を見るか・高難度"
  },
  Task_43899_Desc = {
    Text = "黒章を累計 100000 消費"
  },
  Task_43899_Name = {
    Text = "ようこそ「光」Ⅳ"
  },
  Task_43900_Desc = {
    Text = "黒章を累計 50000 消費"
  },
  Task_43900_Name = {
    Text = "ようこそ「光」Ⅲ"
  },
  Task_43901_Desc = {
    Text = "黒章を累計 25000 消費"
  },
  Task_43901_Name = {
    Text = "ようこそ「光」Ⅱ"
  },
  Task_43902_Desc = {
    Text = "黒章を累計 10000 消費"
  },
  Task_43902_Name = {
    Text = "ようこそ「光」Ⅰ"
  },
  Task_43903_Desc = {
    Text = "レベル12の密約を100個所持する"
  },
  Task_43903_Name = {
    Text = "禁忌の守護者Ⅲ"
  },
  Task_43904_Desc = {
    Text = "レベル12の密約を150個所持する"
  },
  Task_43904_Name = {
    Text = "禁忌の守護者Ⅳ"
  },
  Task_43905_Desc = {
    Text = "レベル12の密約を25個所持する"
  },
  Task_43905_Name = {
    Text = "禁忌の守護者Ⅰ"
  },
  Task_43906_Desc = {
    Text = "レベル12の密約を50個所持する"
  },
  Task_43906_Name = {
    Text = "禁忌の守護者Ⅱ"
  },
  Task_43907_Desc = {
    Text = "2500回召喚儀式を行う"
  },
  Task_43907_Name = {
    Text = "魂を吟じる者Ⅱ"
  },
  Task_43908_Desc = {
    Text = "5000回召喚儀式を行う"
  },
  Task_43908_Name = {
    Text = "魂を吟じる者Ⅲ"
  },
  Task_43909_Desc = {
    Text = "500回召喚儀式を行う"
  },
  Task_43909_Name = {
    Text = "天才守秘者Ⅴ"
  },
  Task_43910_Desc = {
    Text = "1000回召喚儀式を行う"
  },
  Task_43910_Name = {
    Text = "魂を吟じる者Ⅰ"
  },
  Task_43911_Desc = {
    Text = "意識潜行「蒼白の末裔」高難度を完了する"
  },
  Task_43911_Name = {
    Text = "私のデミアン・高難度"
  },
  Task_43916_Desc = {
    Text = "一日で3回以上アイコンを変更する"
  },
  Task_43916_Name = {
    Text = "変相怪傑"
  },
  Task_43917_Desc = {
    Text = "寮で覚醒体と100回対話する"
  },
  Task_43917_Name = {
    Text = "今日はここまでにしよう"
  },
  Task_43918_Desc = {
    Text = "密約転写を250回完了する"
  },
  Task_43918_Name = {Text = "違和感"},
  Task_43919_Desc = {
    Text = "密約転写を100回完了する"
  },
  Task_43919_Name = {
    Text = "筆が神のように走る"
  },
  Task_43921_Desc = {
    Text = "密約転写を500回完了する"
  },
  Task_43921_Name = {Text = "再版"},
  Task_43923_Desc = {
    Text = "一度のダメージが10000に達する"
  },
  Task_43923_Name = {
    Text = "存在の耐えられない痛みⅠ"
  },
  Task_43928_Desc = {
    Text = "30名の覚醒体との同調率がレベル10に到達"
  },
  Task_43928_Name = {
    Text = "「愛」の解析"
  },
  Task_43930_Desc = {
    Text = "16名の覚醒体との同調率がレベル10に到達"
  },
  Task_43930_Name = {
    Text = "心と魂の対話"
  },
  Task_43932_Desc = {
    Text = "20名の覚醒体との同調率がレベル10に到達"
  },
  Task_43932_Name = {
    Text = "霊魂の読者"
  },
  Task_43934_Desc = {
    Text = "ラモンナの真貌形態を解放する"
  },
  Task_43934_Name = {
    Text = "少女のそばで"
  },
  Task_43936_Desc = {
    Text = "12名の覚醒体との同調率がレベル10に到達"
  },
  Task_43936_Name = {
    Text = "眠れる心を、そっと叩いて"
  },
  Task_43937_Desc = {
    Text = "累計300日ログイン"
  },
  Task_43937_Name = {
    Text = "1つの揺るぎない決意"
  },
  Task_43938_Desc = {
    Text = "累計365日ログイン"
  },
  Task_43938_Name = {
    Text = "1夜の星々が輝く夜空"
  },
  Task_43943_Desc = {
    Text = "累計120日ログイン"
  },
  Task_43943_Name = {
    Text = "1つのいつもの朝"
  },
  Task_43944_Desc = {
    Text = "累計150日ログイン"
  },
  Task_43944_Name = {
    Text = "一杯の平凡なコーヒー"
  },
  Task_43945_Desc = {
    Text = "累計180日ログイン"
  },
  Task_43945_Name = {
    Text = "1つの簡単な会話"
  },
  Task_43946_Desc = {
    Text = "累計240日ログイン"
  },
  Task_43946_Name = {
    Text = "1粒の燃えるような心臓"
  },
  Task_43948_Desc = {
    Text = "30種類の異なる運命の札を獲得する"
  },
  Task_43948_Name = {
    Text = "無常の支配者"
  },
  Task_43949_Desc = {
    Text = "20種類の異なる運命の札を獲得する"
  },
  Task_43949_Name = {
    Text = "運命の徒弟Ⅱ"
  },
  Task_43950_Desc = {
    Text = "10種類の異なる運命の札を獲得する"
  },
  Task_43950_Name = {
    Text = "運命の徒弟Ⅰ"
  },
  Task_43953_Desc = {
    Text = "40種類の異なる運命の札を獲得する"
  },
  Task_43953_Name = {
    Text = "運命を編む者"
  },
  Task_43957_Desc = {
    Text = "救援を1回使用する"
  },
  Task_43957_Name = {
    Text = "出かける時は友達を頼れ"
  },
  Task_43958_Desc = {
    Text = "自己紹介文を変更する"
  },
  Task_43958_Name = {
    Text = "ハローワールド！"
  },
  Task_43959_Desc = {
    Text = "「いいね」を1000回される"
  },
  Task_43959_Name = {
    Text = "称賛が訪れる時"
  },
  Task_43961_Desc = {
    Text = "「いいね」を100回行う"
  },
  Task_43961_Name = {
    Text = "心の一歩を踏み出す"
  },
  Task_43962_Desc = {
    Text = "「いいね」を50回行う"
  },
  Task_43962_Name = {
    Text = "取るに足らない試み"
  },
  Task_43964_Desc = {
    Text = "フレンドを100人フォローする"
  },
  Task_43964_Name = {
    Text = "星々が輝く時"
  },
  Task_43965_Desc = {
    Text = "フレンドを1人フォローする"
  },
  Task_43965_Name = {
    Text = "君の名前は？"
  },
  Task_43966_Desc = {
    Text = "累計500日ログイン"
  },
  Task_43966_Name = {
    Text = "カダスの太陽はいつも通り昇る"
  },
  Task_43967_Desc = {
    Text = "覚醒体が霊知啓発を60回起動する"
  },
  Task_43967_Name = {
    Text = "魂と心の出会いⅤ"
  },
  Task_43968_Desc = {
    Text = "覚醒体が霊知啓発を100回起動する"
  },
  Task_43968_Name = {
    Text = "影の中で待つ"
  },
  Task_43969_Desc = {
    Text = "覚醒体が霊知啓発を30回起動する"
  },
  Task_43969_Name = {
    Text = "魂と心の出会いⅢ"
  },
  Task_43970_Desc = {
    Text = "覚醒体が霊知啓発を45回起動する"
  },
  Task_43970_Name = {
    Text = "魂と心の出会いⅣ"
  },
  Task_43972_Desc = {
    Text = "覚醒体が霊知啓発を15回起動する"
  },
  Task_43972_Name = {
    Text = "魂と心の出会いⅡ"
  },
  Task_43973_Desc = {
    Text = "レベル80の覚醒体を4体所持する"
  },
  Task_43973_Name = {
    Text = "「超越の力」Ⅳ"
  },
  Task_43975_Desc = {
    Text = "覚醒体が霊知啓発を200回起動する"
  },
  Task_43975_Name = {
    Text = "魂と肉の融合Ⅰ"
  },
  Task_43976_Desc = {
    Text = "覚醒体が霊知啓発を300回起動する"
  },
  Task_43976_Name = {
    Text = "魂と肉の融合Ⅱ"
  },
  Task_44231_Desc = {
    Text = "超次元界域の覚醒体を使用し「聖堂の道」で1回勝利"
  },
  Task_44232_Desc = {
    Text = "超次元界域の覚醒体を使用し「聖堂の道」で3回勝利"
  },
  Task_44233_Desc = {
    Text = "超次元界域の覚醒体を使用し「聖堂の道」で2回勝利"
  },
  Task_44234_Desc = {
    Text = "「争奪」任意の難易度をクリア"
  },
  Task_44235_Desc = {
    Text = "「偏執」任意の難易度をクリア"
  },
  Task_44236_Desc = {
    Text = "深海界域の覚醒体を使用し「聖堂の道」で1回勝利"
  },
  Task_44237_Desc = {
    Text = "混沌界域の覚醒体を使用し「聖堂の道」で3回勝利"
  },
  Task_44238_Desc = {
    Text = "混沌界域の覚醒体を使用し「聖堂の道」で2回勝利"
  },
  Task_44239_Desc = {
    Text = "混沌界域の覚醒体を使用し「聖堂の道」で1回勝利"
  },
  Task_44240_Desc = {
    Text = "深海界域の覚醒体を使用し「聖堂の道」で3回勝利"
  },
  Task_44241_Desc = {
    Text = "「ビッグジョンの不思議なチャリティ」で150回購入"
  },
  Task_44242_Desc = {
    Text = "「ビッグジョンの不思議なチャリティ」で200回購入"
  },
  Task_44243_Desc = {
    Text = "「ビッグジョンの不思議なチャリティ」で100回購入"
  },
  Task_44244_Desc = {
    Text = "「グレイ夫人の小店」で200回購入"
  },
  Task_44245_Desc = {
    Text = "「グレイ夫人の小店」で150回購入"
  },
  Task_44246_Desc = {
    Text = "「グレイ夫人の小店」で100回購入"
  },
  Task_44247_Desc = {
    Text = "血肉界域の覚醒体を使用し「聖堂の道」で3回勝利"
  },
  Task_44248_Desc = {
    Text = "血肉界域の覚醒体を使用し「聖堂の道」で2回勝利"
  },
  Task_44249_Desc = {
    Text = "血肉界域の覚醒体を使用し「聖堂の道」で1回勝利"
  },
  Task_44250_Desc = {
    Text = "「懺悔」任意の難易度をクリア"
  },
  Task_44251_Desc = {
    Text = "聖堂チャリティ会場"
  },
  Task_44252_Desc = {
    Text = "「スミスセール」で100回購入"
  },
  Task_44253_Desc = {
    Text = "「スミスセール」で200回購入"
  },
  Task_44254_Desc = {
    Text = "「スミスセール」で150回購入"
  },
  Task_44255_Desc = {
    Text = "聖堂の道・深海"
  },
  Task_44256_Desc = {
    Text = "聖堂の道・超次元"
  },
  Task_44257_Desc = {
    Text = "聖堂の道・混沌"
  },
  Task_44258_Desc = {
    Text = "「要求」任意の難易度をクリア"
  },
  Task_44259_Desc = {
    Text = "「聖堂の道」全ステージを任意の難易度でクリア"
  },
  Task_44260_Desc = {
    Text = "「非難」任意の難易度をクリア"
  },
  Task_44261_Desc = {
    Text = "深海界域の覚醒体を使用し「聖堂の道」で2回勝利"
  },
  Task_44262_Desc = {
    Text = "聖堂の道・血肉"
  },
  Task_44263_Desc = {
    Text = "聖堂の道・成長"
  },
  Task_44264_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_44567_Desc = {
    Text = "ソフィアを阻止"
  },
  Task_44567_Name = {Text = "目標"},
  Task_45665_Desc = {
    Text = "意識潜行「巨人の墜落」通常モードを完了する"
  },
  Task_45665_Name = {
    Text = "クリア報酬"
  },
  Task_45666_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_46575_Desc = {
    Text = "超次元界域の覚醒体を使用し「無意識の記憶」を任意の難易度でクリア"
  },
  Task_46576_Desc = {
    Text = "「鏡」任意の難易度をクリア"
  },
  Task_46577_Desc = {
    Text = "血肉界域の覚醒体を使用し「爬虫類の脳」をどの難易度でもクリア"
  },
  Task_46578_Desc = {
    Text = "記憶の収集・血肉"
  },
  Task_46579_Desc = {
    Text = "「爬虫類脳」任意の難易度をクリア"
  },
  Task_46580_Desc = {
    Text = "血肉界域の覚醒体を使用し「無意識の記憶」をどの難易度でもクリア"
  },
  Task_46581_Desc = {
    Text = "記憶の収集・深海"
  },
  Task_46582_Desc = {
    Text = "「無意識記」任意の難易度をクリア"
  },
  Task_46583_Desc = {
    Text = "混沌界域の覚醒体を使用し「忘却曲線」を任意の難易度でクリア"
  },
  Task_46584_Desc = {
    Text = "混沌界域の覚醒体を使用し「鏡」を任意の難易度でクリア"
  },
  Task_46585_Desc = {
    Text = "混沌界域の覚醒体を使用し「アーモンド体」を任意の難易度でクリア"
  },
  Task_46586_Desc = {
    Text = "混沌界域の覚醒体を使用し「爬虫類の脳」を任意の難易度でクリア"
  },
  Task_46587_Desc = {
    Text = "混沌界域の覚醒体を使用し「無意識の記憶」を任意の難易度でクリア"
  },
  Task_46588_Desc = {
    Text = "深海界域の覚醒体を使用し「鏡」を任意の難易度でクリア"
  },
  Task_46589_Desc = {
    Text = "深海界域の覚醒体を使用し「忘却曲線」を任意の難易度でクリア"
  },
  Task_46590_Desc = {
    Text = "深海界域の覚醒体を使用し「無意識の記憶」を任意の難易度でクリア"
  },
  Task_46591_Desc = {
    Text = "深海界域の覚醒体を使用し「爬虫類の脳」を任意の難易度でクリア"
  },
  Task_46592_Desc = {
    Text = "深海界域の覚醒体を使用し「アーモンド体」を任意の難易度でクリア"
  },
  Task_46593_Desc = {
    Text = "「記憶の収集」全ステージを任意の難易度で完了する"
  },
  Task_46594_Desc = {
    Text = "「忘却曲線」任意の難易度をクリア"
  },
  Task_46595_Desc = {
    Text = "記憶の収集・混沌"
  },
  Task_46596_Desc = {
    Text = "「扁桃体」任意の難易度をクリア"
  },
  Task_46597_Desc = {
    Text = "超次元界域の覚醒体を使用し「忘却曲線」を任意の難易度でクリア"
  },
  Task_46598_Desc = {
    Text = "超次元界域の覚醒体を使用し「鏡」を任意の難易度でクリア"
  },
  Task_46599_Desc = {
    Text = "血肉界域の覚醒体を使用し「忘却曲線」をどの難易度でもクリア"
  },
  Task_46600_Desc = {
    Text = "血肉界域の覚醒体を使用し「鏡」をどの難易度でもクリア"
  },
  Task_46601_Desc = {
    Text = "血肉界域の覚醒体を使用し「アーモンド体」をどの難易度でもクリア"
  },
  Task_46602_Desc = {
    Text = "記憶の収集・湧現"
  },
  Task_46603_Desc = {
    Text = "超次元界域の覚醒体を使用し「扁桃体」を任意の難易度でクリア"
  },
  Task_46604_Desc = {
    Text = "超次元界域の覚醒体を使用し「爬虫類の脳」を任意の難易度でクリア"
  },
  Task_46605_Desc = {
    Text = "記憶の収集・超次元"
  },
  Task_46624_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_46798_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46798_Name = {Text = "200点"},
  Task_46799_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46799_Name = {Text = "450点"},
  Task_46806_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46806_Name = {Text = "50点"},
  Task_46807_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46807_Name = {Text = "100点"},
  Task_46808_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46808_Name = {Text = "150点"},
  Task_46809_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46809_Name = {Text = "1500点"},
  Task_46810_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46810_Name = {Text = "250点"},
  Task_46811_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46811_Name = {Text = "300点"},
  Task_46812_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46812_Name = {Text = "350点"},
  Task_46821_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_46821_Name = {Text = "6勝"},
  Task_46822_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_46822_Name = {Text = "3勝"},
  Task_46823_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_46823_Name = {Text = "1勝"},
  Task_46826_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46826_Name = {Text = "1450点"},
  Task_46827_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46827_Name = {Text = "1400点"},
  Task_46828_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46828_Name = {Text = "1350点"},
  Task_46829_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46829_Name = {Text = "1300点"},
  Task_46830_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46830_Name = {Text = "1250点"},
  Task_46831_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46831_Name = {Text = "1200点"},
  Task_46832_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46832_Name = {Text = "1150点"},
  Task_46833_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46833_Name = {Text = "1100点"},
  Task_46834_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46834_Name = {Text = "1050点"},
  Task_46835_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46835_Name = {Text = "1000点"},
  Task_46836_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46836_Name = {Text = "600点"},
  Task_46837_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46837_Name = {Text = "650点"},
  Task_46838_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46838_Name = {Text = "500点"},
  Task_46839_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46839_Name = {Text = "550点"},
  Task_46840_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46840_Name = {Text = "800点"},
  Task_46841_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46841_Name = {Text = "850点"},
  Task_46842_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46842_Name = {Text = "700点"},
  Task_46843_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46843_Name = {Text = "750点"},
  Task_46844_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46844_Name = {Text = "900点"},
  Task_46845_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46845_Name = {Text = "950点"},
  Task_46846_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_46846_Name = {Text = "10勝"},
  Task_46847_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_46847_Name = {Text = "400点"},
  Task_46850_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_46850_Name = {Text = "10勝"},
  Task_46852_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_46852_Name = {Text = "3勝"},
  Task_46853_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_46853_Name = {Text = "6勝"},
  Task_46854_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_46854_Name = {Text = "1勝"},
  Task_47794_Desc = {
    Text = "闇の境界全界域隙間Ⅶクリア"
  },
  Task_47795_Desc = {
    Text = "闇の境界全界域隙間Ⅰクリア"
  },
  Task_47796_Desc = {
    Text = "闇の境界全界域隙間Ⅲクリア"
  },
  Task_47797_Desc = {
    Text = "闇の境界全界域隙間Ⅴクリア"
  },
  Task_47799_Desc = {
    Text = "闇の境界全界域隙間Ⅳクリア"
  },
  Task_47800_Desc = {
    Text = "闇の境界全界域隙間Ⅵクリア"
  },
  Task_47801_Desc = {
    Text = "闇の境界全界域隙間Ⅷクリア"
  },
  Task_47802_Desc = {
    Text = "闇の境界全界域隙間Ⅱクリア"
  },
  Task_48166_Desc = {
    Text = "ロジャーズたちを撃退"
  },
  Task_48166_Name = {Text = "目標"},
  Task_48167_Desc = {
    Text = "影「24」を倒す"
  },
  Task_48167_Name = {Text = "目標"},
  Task_48733_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_48733_Desc = {
    Text = "倒壊した教会と壊れた工芸品から、博物館はそれらを収蔵し、あなたは自分の収蔵品を得た。\nお互いに必要なものを得た。"
  },
  Task_48733_Name = {
    Text = "調査任務：汎神信仰"
  },
  Task_48733_UnlockCondDesc = {
    Text = "守秘者 40 レベルで解放"
  },
  Task_48734_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_48734_Desc = {
    Text = "認識を捨て、目的を捨てろ。\n真実は彼らが教えてくれる。"
  },
  Task_48734_Name = {
    Text = "調査任務：先験理論"
  },
  Task_48734_UnlockCondDesc = {
    Text = "守秘者 30 レベルで解放"
  },
  Task_48735_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_48735_Desc = {
    Text = "地理は高次元の存在による嘘と知れ。\n等高線に注意をはらえ。"
  },
  Task_48735_Name = {
    Text = "調査任務：探査と測量"
  },
  Task_48735_UnlockCondDesc = {
    Text = "守秘者 20 レベルで解放"
  },
  Task_48736_CompleteCondDesc = {
    Text = "派遣総レベル>={s1}"
  },
  Task_48736_Desc = {
    Text = "信じられない約束を二つと、忘れられない夢を一つ収穫した。"
  },
  Task_48736_Name = {
    Text = "調査任務：秘境幻影"
  },
  Task_48736_UnlockCondDesc = {
    Text = "守秘者 50 レベルで解放"
  },
  Task_48775_Desc = {
    Text = "リリーの同調率がレベル10に到達する"
  },
  Task_48776_Desc = {
    Text = "オレッタの同調率がレベル10に到達する"
  },
  Task_48777_Desc = {
    Text = "ファイントの同調率がレベル10に到達する"
  },
  Task_48778_Desc = {
    Text = "ワンダの同調率がレベル10に到達する"
  },
  Task_48779_Desc = {
    Text = "ジェンキンの同調率がレベル10に到達する"
  },
  Task_48780_Desc = {
    Text = "オジールの同調率がレベル10に到達する"
  },
  Task_48781_Desc = {
    Text = "リッツの同調率がレベル10に到達する"
  },
  Task_48782_Desc = {
    Text = "ダフォダイルの同調率がレベル10に到達する"
  },
  Task_48783_Desc = {
    Text = "ドールの同調率がレベル10に到達する"
  },
  Task_48784_Desc = {
    Text = "シレストの同調率がレベル10に到達する"
  },
  Task_48785_Desc = {
    Text = "アイギスの同調率がレベル10に到達する"
  },
  Task_48786_Desc = {
    Text = "マーフィーの同調率がレベル10に到達する"
  },
  Task_48787_Desc = {
    Text = "サンガーの同調率がレベル10に到達する"
  },
  Task_48788_Desc = {
    Text = "ユウハシュの同調率がレベル10に到達する"
  },
  Task_48789_Desc = {
    Text = "ナウティラの同調率がレベル10に到達する"
  },
  Task_48790_Desc = {
    Text = "「24」 の同調率がレベル10に到達する"
  },
  Task_48791_Desc = {
    Text = "アグリッパの同調率がレベル10に到達する"
  },
  Task_48792_Desc = {
    Text = "ファロスの同調率がレベル10に到達する"
  },
  Task_48793_Desc = {
    Text = "ウインクルの同調率がレベル10に到達する"
  },
  Task_48794_Desc = {
    Text = "サルバドルの同調率がレベル10に到達する"
  },
  Task_48795_Desc = {
    Text = "ヘロットの同調率がレベル10に到達する"
  },
  Task_48796_Desc = {
    Text = "エリカの同調率がレベル10に到達する"
  },
  Task_48797_Desc = {
    Text = "ラモンナの同調率がレベル10に到達する"
  },
  Task_48798_Desc = {
    Text = "ソレールの同調率がレベル10に到達する"
  },
  Task_48799_Desc = {
    Text = "タイスの同調率がレベル10に到達する"
  },
  Task_48800_Desc = {
    Text = "ゴリアテの同調率がレベル10に到達する"
  },
  Task_48801_Desc = {
    Text = "レーアの同調率がレベル10に到達する"
  },
  Task_48802_Desc = {
    Text = "アルバの同調率がレベル10に到達する"
  },
  Task_48803_Desc = {
    Text = "カエクスの同調率がレベル10に到達する"
  },
  Task_48804_Desc = {
    Text = "トゥルーの同調率がレベル10に到達する"
  },
  Task_48805_Desc = {
    Text = "カーシアの同調率がレベル10に到達する"
  },
  Task_48806_Desc = {
    Text = "カレンの同調率がレベル10に到達する"
  },
  Task_48807_Desc = {
    Text = "パンディアの同調率がレベル10に到達する"
  },
  Task_48808_Desc = {
    Text = "ティンクトの同調率がレベル10に到達する"
  },
  Task_48809_Desc = {
    Text = "ニムフィーアの同調率がレベル10に到達する"
  },
  Task_48810_Desc = {
    Text = "ロータンの同調率がレベル10に到達する"
  },
  Task_48829_Desc = {
    Text = "累計ログイン 11 日"
  },
  Task_48830_Desc = {
    Text = "累計ログイン 14 日"
  },
  Task_48831_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_48832_Desc = {
    Text = "累計ログイン 16 日"
  },
  Task_48833_Desc = {
    Text = "累計ログイン 12 日"
  },
  Task_48834_Desc = {
    Text = "累計ログイン 13 日"
  },
  Task_48835_Desc = {
    Text = "累計ログイン 10 日"
  },
  Task_48836_Desc = {
    Text = "累計ログイン 5 日"
  },
  Task_48837_Desc = {
    Text = "累計ログイン 6 日"
  },
  Task_48838_Desc = {
    Text = "累計ログイン 7 日"
  },
  Task_48839_Desc = {
    Text = "累計ログイン 2 日"
  },
  Task_48840_Desc = {
    Text = "累計ログイン 3 日"
  },
  Task_48841_Desc = {
    Text = "累計ログイン 8 日"
  },
  Task_48842_Desc = {
    Text = "累計ログイン 9 日"
  },
  Task_48843_Desc = {
    Text = "累計ログイン 15 日"
  },
  Task_48844_Desc = {
    Text = "累計ログイン 4 日"
  },
  Task_49241_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_49241_Name = {Text = "1勝"},
  Task_49242_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_49242_Name = {Text = "3勝"},
  Task_49243_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_49243_Name = {Text = "6勝"},
  Task_49244_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_49244_Name = {Text = "10勝"},
  Task_49245_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_49245_Name = {Text = "10勝"},
  Task_49246_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_49246_Name = {Text = "1勝"},
  Task_49247_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_49247_Name = {Text = "6勝"},
  Task_49248_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_49248_Name = {Text = "3勝"},
  Task_49262_Desc = {
    Text = "最終戦で30ターン以内に勝利"
  },
  Task_49262_Name = {
    Text = "最終戦で30ターン以内に勝利"
  },
  Task_49380_Desc = {
    Text = "「再生花」任意の難易度をクリア"
  },
  Task_49381_Desc = {
    Text = "波乱の情欲・リプレイ"
  },
  Task_49382_Desc = {
    Text = "「波乱の情欲・突破」のすべての任務を完了する"
  },
  Task_49383_Desc = {
    Text = "波乱の情欲・突破"
  },
  Task_49384_Desc = {
    Text = "「多胚生殖」任意の難易度をクリア"
  },
  Task_49385_Desc = {
    Text = "「落果」任意の難易度をクリア"
  },
  Task_49386_Desc = {
    Text = "「波乱の情欲」で30回リプレイ"
  },
  Task_49387_Desc = {
    Text = "「蜜腺」任意の難易度をクリア"
  },
  Task_49388_Desc = {
    Text = "「波乱の情欲」で10回リプレイ"
  },
  Task_49389_Desc = {
    Text = "「幼根」任意の難易度をクリア"
  },
  Task_49390_Desc = {
    Text = "「発芽」任意の難易度をクリア"
  },
  Task_49391_Desc = {
    Text = "「波乱の情欲」で20回リプレイ"
  },
  Task_49392_Desc = {
    Text = "「波乱の情欲」で50回リプレイ"
  },
  Task_49393_Desc = {
    Text = "「波乱の情欲」で40回リプレイ"
  },
  Task_49394_Desc = {
    Text = "「花のウテナ」任意の難易度をクリア"
  },
  Task_49395_Desc = {
    Text = "「胚珠」任意の難易度をクリア"
  },
  Task_49396_Desc = {
    Text = "「受粉」任意の難易度をクリア"
  },
  Task_49397_Desc = {
    Text = "「年輪」任意の難易度をクリア"
  },
  Task_49769_Desc = {
    Text = "最終戦で1ターンに最大ライフの50%のシールドを獲得"
  },
  Task_49769_Name = {
    Text = "鋼鉄の体"
  },
  Task_49770_Desc = {
    Text = "精鋭戦で1ターンに最低3000ダメージを与える"
  },
  Task_49770_Name = {
    Text = "全力一撃"
  },
  Task_49771_Desc = {
    Text = "任意の戦闘で1ターン内に最低2体の敵を倒す"
  },
  Task_49771_Name = {Text = "根絶"},
  Task_49772_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_49772_Name = {
    Text = "伏兵の宝物"
  },
  Task_49773_Desc = {
    Text = "4種以上の異なる刻印を獲得"
  },
  Task_49773_Name = {
    Text = "霊魂烙印"
  },
  Task_49774_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_49774_Name = {
    Text = "優雅で正確"
  },
  Task_49775_Desc = {
    Text = "最終戦で1ターン中カード7枚以上使用"
  },
  Task_49775_Name = {
    Text = "私のターン"
  },
  Task_49776_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_49776_Name = {
    Text = "無限の抱擁"
  },
  Task_49777_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_49777_Name = {
    Text = "省エネ主義"
  },
  Task_49778_Desc = {
    Text = "任意の戦闘で1ターン内に最低2体の敵を倒す"
  },
  Task_49778_Name = {Text = "根絶"},
  Task_49779_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_49779_Name = {
    Text = "伏兵の宝物"
  },
  Task_49780_Desc = {
    Text = "4種以上の異なる刻印を獲得"
  },
  Task_49780_Name = {
    Text = "霊魂烙印"
  },
  Task_49781_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_49781_Name = {
    Text = "優雅で正確"
  },
  Task_49782_Desc = {
    Text = "最終戦で1ターン中カード7枚以上使用"
  },
  Task_49782_Name = {
    Text = "私のターン"
  },
  Task_49783_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_49783_Name = {
    Text = "無限の抱擁"
  },
  Task_49784_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_49784_Name = {
    Text = "省エネ主義"
  },
  Task_49785_Desc = {
    Text = "最終戦で1ターンに最大ライフの50%のシールドを獲得"
  },
  Task_49785_Name = {
    Text = "鋼鉄の体"
  },
  Task_49786_Desc = {
    Text = "精鋭戦で1ターンに最低4500ダメージを与える"
  },
  Task_49786_Name = {
    Text = "全力一撃"
  },
  Task_49787_Desc = {
    Text = "精鋭戦で1ターンに最低7300ダメージを与える"
  },
  Task_49787_Name = {
    Text = "全力一撃"
  },
  Task_49788_Desc = {
    Text = "6種以上の異なる刻印を獲得"
  },
  Task_49788_Name = {
    Text = "霊魂烙印"
  },
  Task_49789_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_49789_Name = {
    Text = "優雅で正確"
  },
  Task_49790_Desc = {
    Text = "クリア時、遺物を7個以上所持"
  },
  Task_49790_Name = {
    Text = "伏兵の宝物"
  },
  Task_49791_Desc = {
    Text = "クリア時に休憩所でライフを回復していない"
  },
  Task_49791_Name = {
    Text = "無火の人"
  },
  Task_49792_Desc = {
    Text = "精鋭戦で1ターンに最低9000ダメージを与える"
  },
  Task_49792_Name = {
    Text = "全力一撃"
  },
  Task_49793_Desc = {
    Text = "6種以上の異なる刻印を獲得"
  },
  Task_49793_Name = {
    Text = "霊魂烙印"
  },
  Task_49794_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_49794_Name = {
    Text = "優雅で正確"
  },
  Task_49795_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_49795_Name = {Text = "速攻"},
  Task_49796_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_49796_Name = {Text = "速攻"},
  Task_49797_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_49797_Name = {Text = "速攻"},
  Task_49798_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_49798_Name = {Text = "速攻"},
  Task_49799_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_49799_Name = {Text = "速攻"},
  Task_49800_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_49800_Name = {Text = "速攻"},
  Task_49801_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_49801_Name = {Text = "速攻"},
  Task_49802_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_49802_Name = {Text = "速攻"},
  Task_49803_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_49803_Name = {Text = "速攻"},
  Task_49804_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_49804_Name = {
    Text = "完璧な通過"
  },
  Task_49805_Desc = {
    Text = "クリア時、遺物を7個以上所持"
  },
  Task_49805_Name = {
    Text = "伏兵の宝物"
  },
  Task_49806_Desc = {
    Text = "クリア時に休憩所でライフを回復していない"
  },
  Task_49806_Name = {
    Text = "無火の人"
  },
  Task_49807_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_49807_Name = {
    Text = "完璧な通過"
  },
  Task_49808_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_49808_Name = {
    Text = "完璧な通過"
  },
  Task_49809_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_49809_Name = {
    Text = "完璧な通過"
  },
  Task_49810_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_49810_Name = {
    Text = "完璧な通過"
  },
  Task_49811_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_49811_Name = {
    Text = "完璧な通過"
  },
  Task_49812_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_49812_Name = {
    Text = "完璧な通過"
  },
  Task_49813_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_49813_Name = {
    Text = "完璧な通過"
  },
  Task_49814_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_49814_Name = {
    Text = "完璧な通過"
  },
  Task_49815_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_49815_Name = {
    Text = "完璧な通過"
  },
  Task_49816_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_49816_Name = {
    Text = "完璧な通過"
  },
  Task_49817_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_49817_Name = {
    Text = "省エネ主義"
  },
  Task_49818_Desc = {
    Text = "最終戦で1ターンに最低4体の敵を倒す"
  },
  Task_49818_Name = {Text = "根絶"},
  Task_49819_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_49819_Name = {
    Text = "省エネ主義"
  },
  Task_49820_Desc = {
    Text = "最終戦で1ターンに最低4体の敵を倒す"
  },
  Task_49820_Name = {Text = "根絶"},
  Task_49821_Desc = {
    Text = "最終戦で18ターン以内に勝利"
  },
  Task_49821_Name = {Text = "速攻"},
  Task_49822_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_49822_Name = {Text = "速攻"},
  Task_49823_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_49823_Name = {Text = "速攻"},
  Task_49824_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_49824_Name = {
    Text = "完璧な通過"
  },
  Task_49852_Desc = {
    Text = "脅威キャンプのヌビアを掃除"
  },
  Task_49852_Name = {Text = "目標"},
  Task_49853_Desc = {
    Text = "嵐の壁の中を進む"
  },
  Task_49853_Name = {Text = "目標"},
  Task_49854_Desc = {
    Text = "アラン兵を誘拐して遺骸の場所を聞き出す"
  },
  Task_49854_Name = {Text = "目標"},
  Task_49855_Desc = {
    Text = "水源を探す"
  },
  Task_49855_Name = {Text = "目標"},
  Task_49856_Desc = {
    Text = "カーシアを撃破し、遺骸を取り戻す"
  },
  Task_49856_Name = {Text = "目標"},
  Task_49857_Desc = {
    Text = "タイスと共に戦う"
  },
  Task_49857_Name = {Text = "目標"},
  Task_49858_Desc = {
    Text = "カーシアの魔の手から逃れる"
  },
  Task_49858_Name = {Text = "目標"},
  Task_49859_Desc = {
    Text = "母樹復活の儀式を阻止"
  },
  Task_49859_Name = {Text = "目標"},
  Task_49860_Desc = {
    Text = "豊穣母樹の意識の海の中へ"
  },
  Task_49860_Name = {Text = "目標"},
  Task_49861_Desc = {
    Text = "アラン族を助けてヌビアを追放"
  },
  Task_49861_Name = {Text = "目標"},
  Task_49862_Desc = {
    Text = "母樹の遺骸を探す"
  },
  Task_49862_Name = {Text = "目標"},
  Task_49863_Desc = {
    Text = "母樹を撃破"
  },
  Task_49863_Name = {Text = "目標"},
  Task_49879_Desc = {
    Text = "環行・ラモンナの同調率が10に到達する"
  },
  Task_50033_Desc = {
    Text = "調査「@1@2」で6回共鳴する"
  },
  Task_50033_Desc2 = {
    Text = "調査「欲望の川」で6回共鳴する"
  },
  Task_50033_Name2 = {
    Text = "妄念の残響Ⅱ"
  },
  Task_50034_Desc = {
    Text = "調査「@1@2」で9回共鳴する"
  },
  Task_50034_Desc2 = {
    Text = "調査「欲望の川」で9回共鳴する"
  },
  Task_50034_Name2 = {
    Text = "妄念の残響Ⅲ"
  },
  Task_50035_Desc = {
    Text = "メインストーリー第7章「@1@2」の黒い水たまりを12箇所見つける"
  },
  Task_50035_Desc2 = {
    Text = "メインストーリー第7章「欲望の川」の黒い水たまりを12箇所見つける"
  },
  Task_50035_Name2 = {
    Text = "潜むささやきⅦ"
  },
  Task_50036_Desc = {
    Text = "調査「@1@2」で3回共鳴する"
  },
  Task_50036_Desc2 = {
    Text = "調査「欲望の川」で3回共鳴する"
  },
  Task_50036_Name2 = {
    Text = "妄念の残響"
  },
  Task_50037_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_50037_Desc2 = {
    Text = "調査「欲望の川」を完了する"
  },
  Task_50037_Name2 = {
    Text = "聖樹が燃え尽きる時"
  },
  Task_50038_Desc = {
    Text = "調査「欲望の川」高難度を完了する"
  },
  Task_50038_Name = {
    Text = "聖樹が燃え尽きる時・高難度"
  },
  Task_50039_Desc = {
    Text = "調査「@1@2」で11回共鳴する"
  },
  Task_50039_Desc2 = {
    Text = "調査「欲望の川」で11回共鳴する"
  },
  Task_50039_Name2 = {
    Text = "妄念の残響Ⅳ"
  },
  Task_51106_Desc = {
    Text = "深海界域の覚醒体を使用し「脚本の謎」で2回勝利"
  },
  Task_51107_Desc = {
    Text = "「脚本の謎・突破」の全任務を完了する"
  },
  Task_51108_Desc = {
    Text = "「プロットの転換」任意の難易度をクリア"
  },
  Task_51109_Desc = {
    Text = "特務記録"
  },
  Task_51109_Name = {
    Text = "[廃棄済み]"
  },
  Task_51110_Desc = {
    Text = "深海界域の覚醒体を使用し「脚本の謎」で1回勝利"
  },
  Task_51111_Desc = {
    Text = "脚本の謎・界域"
  },
  Task_51112_Desc = {
    Text = "混沌界域の覚醒体を使用し「脚本の謎」で1回勝利"
  },
  Task_51113_Desc = {
    Text = "超次元界域の覚醒体を使用し「脚本の謎」で2回勝利"
  },
  Task_51114_Desc = {
    Text = "「カタルシス」任意の難易度をクリア"
  },
  Task_51115_Desc = {
    Text = "混沌界域の覚醒体を使用し「脚本の謎」で2回勝利"
  },
  Task_51116_Desc = {
    Text = "「仮面喜劇」任意の難易度をクリア"
  },
  Task_51117_Desc = {
    Text = "「三位一体」任意の難易度をクリア"
  },
  Task_51118_Desc = {
    Text = "超次元界域の覚醒体を使用し「脚本の謎」で1回勝利"
  },
  Task_51119_Desc = {
    Text = "「劇中人物論」任意の難易度をクリア"
  },
  Task_51120_Desc = {
    Text = "「劇作ピラミッド」任意の難易度をクリア"
  },
  Task_51121_Desc = {
    Text = "血肉界域の覚醒体を使用し「脚本の謎」で1回勝利"
  },
  Task_51122_Desc = {
    Text = "「演劇の第四の壁」任意の難易度をクリア"
  },
  Task_51123_Desc = {
    Text = "「異化効果」任意の難易度をクリア"
  },
  Task_51124_Desc = {
    Text = "脚本の謎・突破"
  },
  Task_51125_Desc = {
    Text = "血肉界域の覚醒体を使用し「脚本の謎」で2回勝利"
  },
  Task_51126_Desc = {
    Text = "「静寂の瞬間」任意の難易度をクリア"
  },
  Task_51140_Desc = {
    Text = "特務記録「物語の魔法」をクリア"
  },
  Task_51141_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_51141_Name = {
    Text = "[廃棄済み]"
  },
  Task_51142_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_51142_Name = {
    Text = "[廃棄済み]"
  },
  Task_51143_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_51143_Name = {
    Text = "[廃棄済み]"
  },
  Task_51144_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_51144_Name = {
    Text = "[廃棄済み]"
  },
  Task_51145_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_51145_Name = {
    Text = "[廃棄済み]"
  },
  Task_51146_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_51146_Name = {
    Text = "[廃棄済み]"
  },
  Task_52280_Desc = {
    Text = "「晶泪祭壇」に供物を捧げ、100回報酬を獲得"
  },
  Task_52281_Desc = {
    Text = "「晶泪祭壇」に供物を捧げ、200回報酬を獲得"
  },
  Task_52282_Desc = {
    Text = "混沌界域の覚醒体を使用し「深淵の祀り」で2回勝利"
  },
  Task_52283_Desc = {
    Text = "深淵の祀り・突破"
  },
  Task_52284_Desc = {
    Text = "「証言」任意の難易度をクリア"
  },
  Task_52285_Desc = {
    Text = "深海界域の覚醒体を使用し「深淵の祀り」で1回勝利"
  },
  Task_52286_Desc = {
    Text = "深海界域の覚醒体を使用し「深淵の祀り」で2回勝利"
  },
  Task_52287_Desc = {
    Text = "「篤信」任意の難易度をクリア"
  },
  Task_52288_Desc = {
    Text = "混沌界域の覚醒体を使用し「深淵の祀り」で1回勝利"
  },
  Task_52289_Desc = {
    Text = "血肉界域の覚醒体を使用し「深淵の祀り」で1回勝利"
  },
  Task_52290_Desc = {
    Text = "深淵の祀り・界域"
  },
  Task_52291_Desc = {
    Text = "異夢視界「冒涜」をクリア"
  },
  Task_52292_Desc = {
    Text = "「紅血祭壇」に供物を捧げ、100回報酬を獲得"
  },
  Task_52293_Desc = {
    Text = "「紅血祭壇」に供物を捧げ、200回報酬を獲得"
  },
  Task_52294_Desc = {
    Text = "「霊髄祭壇」に供物を捧げ、200回報酬を獲得"
  },
  Task_52295_Desc = {
    Text = "「霊髄祭壇」に供物を捧げ、100回報酬を獲得"
  },
  Task_52296_Desc = {
    Text = "「疑問」任意の難易度をクリア"
  },
  Task_52297_Desc = {
    Text = "「動揺」任意の難易度をクリア"
  },
  Task_52298_Desc = {
    Text = "血肉界域の覚醒体を使用し「深淵の祀り」で2回勝利"
  },
  Task_52299_Desc = {
    Text = "超次元界域の覚醒体を使用し「深淵の祀り」で1回勝利"
  },
  Task_52300_Desc = {
    Text = "「到来」任意の難易度をクリア"
  },
  Task_52301_Desc = {
    Text = "超次元界域の覚醒体を使用し「深淵の祀り」で2回勝利"
  },
  Task_52302_Desc = {
    Text = "深淵の応答"
  },
  Task_52303_Desc = {
    Text = "「深淵の祀り・突破」と「深淵の応答」の全任務を完了する"
  },
  Task_53694_Desc = {
    Text = "「精粋活性イオン」が1000に到達"
  },
  Task_53695_Desc = {
    Text = "派遣を累積20回完了する"
  },
  Task_53696_Desc = {
    Text = "帰校報告1日目"
  },
  Task_53697_Desc = {
    Text = "混沌界域の覚醒体を使用し3回勝利"
  },
  Task_53698_Desc = {
    Text = "フレンドで他の人に10回「いいね」をする"
  },
  Task_53699_Desc = {
    Text = "帰校報告6日目"
  },
  Task_53700_Desc = {
    Text = "帰校報告5日目"
  },
  Task_53701_Desc = {Text = "第四日"},
  Task_53702_Desc = {Text = "第二日"},
  Task_53703_Desc = {Text = "第三日"},
  Task_53704_Desc = {Text = "初日"},
  Task_53705_Desc = {
    Text = "超次元界域の覚醒体を使用し3回勝利"
  },
  Task_53706_Desc = {
    Text = "帰校報告4日目"
  },
  Task_53707_Desc = {
    Text = "血肉界域の覚醒体を使用し3回勝利"
  },
  Task_53708_Desc = {
    Text = "深海界域の覚醒体を使用し3回勝利"
  },
  Task_53709_Desc = {
    Text = "帰校報告2日目"
  },
  Task_53710_Desc = {
    Text = "任意の覚醒体育成を1回完了する"
  },
  Task_53711_Desc = {
    Text = "薔薇金券を累計 50000 消費"
  },
  Task_53712_Desc = {
    Text = "エンフェリンを累計1500消費"
  },
  Task_53713_Desc = {
    Text = "「精粋活性イオン」が500に到達"
  },
  Task_53714_Desc = {
    Text = "薔薇金券を累計 50万消費"
  },
  Task_53715_Desc = {
    Text = "任意のイベント召喚を累計20回行う"
  },
  Task_53716_Desc = {
    Text = "闇の境界または超越存在を1回クリア"
  },
  Task_53717_Desc = {
    Text = "フレンドの救援覚醒体を10回使用する"
  },
  Task_53718_Desc = {
    Text = "帰校報告3日目"
  },
  Task_53719_Desc = {
    Text = "フレンドの救援覚醒体を使用する"
  },
  Task_53720_Desc = {
    Text = "商店で金券を使って3回交換する"
  },
  Task_53721_Desc = {
    Text = "エンフェリンを180消費"
  },
  Task_53722_Desc = {
    Text = "派遣を3回実行する"
  },
  Task_53723_Desc = {
    Text = "帰校報告7日目"
  },
  Task_53724_Desc = {
    Text = "「基礎活性イオン」が1000に到達"
  },
  Task_53725_Desc = {
    Text = "覚醒体試遊ステージを1回クリア"
  },
  Task_53726_Desc = {
    Text = "召喚を1回行う"
  },
  Task_53982_Desc = {
    Text = "混沌界域の覚醒体を使用し「薔薇の記憶」で1回勝利"
  },
  Task_53983_Desc = {
    Text = "「傀儡遊戯」任意の難易度をクリア"
  },
  Task_53984_Desc = {
    Text = "「視線」任意の難易度をクリア"
  },
  Task_53985_Desc = {
    Text = "血肉界域の覚醒体を使用し「薔薇の記憶」で2回勝利"
  },
  Task_53986_Desc = {
    Text = "血肉界域の覚醒体を使用し「薔薇の記憶」で1回勝利"
  },
  Task_53987_Desc = {
    Text = "混沌界域の覚醒体を使用し「薔薇の記憶」で2回勝利"
  },
  Task_53988_Desc = {
    Text = "薔薇の記憶・界域"
  },
  Task_53989_Desc = {
    Text = "深海界域の覚醒体を使用し「薔薇の記憶」で1回勝利"
  },
  Task_53990_Desc = {
    Text = "深海界域の覚醒体を使用し「薔薇の記憶」で2回勝利"
  },
  Task_53991_Desc = {
    Text = "「薔薇の記憶・突破」全任務を完了する"
  },
  Task_53992_Desc = {
    Text = "「未完の脚本」任意の難易度をクリア"
  },
  Task_53993_Desc = {
    Text = "超次元界域の覚醒体を使用し「薔薇の記憶」で1回勝利"
  },
  Task_53994_Desc = {
    Text = "「薔薇の棘」任意の難易度をクリア"
  },
  Task_53995_Desc = {
    Text = "薔薇の記憶・突破"
  },
  Task_53996_Desc = {
    Text = "超次元界域の覚醒体を使用し「薔薇の記憶」で2回勝利"
  },
  Task_53997_Desc = {
    Text = "「あしながおじさん」任意の難易度をクリア"
  },
  Task_53998_Desc = {
    Text = "「贈り物」任意の難易度をクリア"
  },
  Task_53999_Desc = {
    Text = "「終曲」任意の難易度をクリア"
  },
  Task_54000_Desc = {
    Text = "「釜中の魚」任意の難易度をクリア"
  },
  Task_54001_Desc = {
    Text = "「顔」任意の難易度をクリア"
  },
  Task_54542_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_54542_Name = {Text = "1勝"},
  Task_54543_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_54543_Name = {Text = "6勝"},
  Task_54544_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_54544_Name = {Text = "3勝"},
  Task_54545_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_54545_Name = {Text = "10勝"},
  Task_54546_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_54546_Name = {Text = "1勝"},
  Task_54547_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_54547_Name = {Text = "10勝"},
  Task_54548_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_54548_Name = {Text = "10勝"},
  Task_54549_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_54549_Name = {Text = "6勝"},
  Task_54550_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_54550_Name = {Text = "1勝"},
  Task_54551_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_54551_Name = {Text = "3勝"},
  Task_54552_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_54552_Name = {Text = "6勝"},
  Task_54553_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_54553_Name = {Text = "3勝"},
  Task_54554_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_54554_Name = {Text = "6勝"},
  Task_54555_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_54555_Name = {Text = "1勝"},
  Task_54556_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_54556_Name = {Text = "10勝"},
  Task_54557_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_54557_Name = {Text = "3勝"},
  Task_54585_Desc = {
    Text = "累積1000プラチナジェル\n抽出する"
  },
  Task_54586_Desc = {
    Text = "累積3000プラチナジェル\n抽出する"
  },
  Task_54587_Desc = {
    Text = "累積6000プラチナジェル\n抽出する"
  },
  Task_54588_Desc = {
    Text = "累積10000プラチナジェル\n抽出する"
  },
  Task_54589_Desc = {
    Text = "累積30000プラチナジェル\n抽出する"
  },
  Task_54590_Desc = {
    Text = "累積60000プラチナジェル\n抽出する"
  },
  Task_54591_Desc = {
    Text = "累積100000プラチナジェル\n抽出する"
  },
  Task_55092_Desc = {
    Text = "この章の全任務を完了後に受け取る"
  },
  Task_55092_Name = {
    Text = "界域知識Ⅶ"
  },
  Task_55093_Desc = {
    Text = "この章の全任務を完了後に受け取る"
  },
  Task_55093_Name = {
    Text = "界域知識Ⅵ"
  },
  Task_55094_Desc = {
    Text = "任意の血肉界域の覚醒体を3体レベル60にする"
  },
  Task_55094_Name = {
    Text = "界域知識Ⅶ"
  },
  Task_55095_Desc = {
    Text = "任意の深海界域の覚醒体を3体レベル60にする"
  },
  Task_55095_Name = {
    Text = "界域知識Ⅶ"
  },
  Task_55096_Desc = {
    Text = "任意の混沌界域の覚醒体を3体レベル60にする"
  },
  Task_55096_Name = {
    Text = "界域知識Ⅶ"
  },
  Task_55097_Desc = {
    Text = "この章の全任務を完了後に受け取る"
  },
  Task_55097_Name = {
    Text = "界域知識Ⅷ"
  },
  Task_55098_Desc = {
    Text = "任意の超次元界域の覚醒体を3体レベル60にする"
  },
  Task_55098_Name = {
    Text = "界域知識Ⅶ"
  },
  Task_55099_Desc = {
    Text = "任意の超次元界域の覚醒体を1体レベル60にする"
  },
  Task_55099_Name = {
    Text = "界域知識Ⅵ"
  },
  Task_55100_Desc = {
    Text = "任意の混沌界域の覚醒体を1体レベル60にする"
  },
  Task_55100_Name = {
    Text = "界域知識Ⅵ"
  },
  Task_55101_Desc = {
    Text = "任意の深海界域の覚醒体を1体レベル60にする"
  },
  Task_55101_Name = {
    Text = "界域知識Ⅵ"
  },
  Task_55102_Desc = {
    Text = "任意の血肉界域の覚醒体を1体レベル60にする"
  },
  Task_55102_Name = {
    Text = "界域知識Ⅵ"
  },
  Task_55103_Desc = {
    Text = "任意の超次元界域の覚醒体を6体レベル60にする"
  },
  Task_55103_Name = {
    Text = "界域知識Ⅷ"
  },
  Task_55104_Desc = {
    Text = "任意の深海界域の覚醒体を6体レベル60にする"
  },
  Task_55104_Name = {
    Text = "界域知識Ⅷ"
  },
  Task_55105_Desc = {
    Text = "任意の血肉界域の覚醒体を6体レベル60にする"
  },
  Task_55105_Name = {
    Text = "界域知識Ⅷ"
  },
  Task_55106_Desc = {
    Text = "任意の混沌界域の覚醒体を6体レベル60にする"
  },
  Task_55106_Name = {
    Text = "界域知識Ⅷ"
  },
  Task_55177_Desc = {
    Text = "「ガーデンの思い出·クリア」の実績をすべて完了する"
  },
  Task_55178_Desc = {
    Text = "花園の記憶・界域"
  },
  Task_55179_Desc = {
    Text = "コレットの温室"
  },
  Task_55180_Desc = {
    Text = "混沌界域の覚醒体を使用し「花園の記憶」で2回勝利"
  },
  Task_55181_Desc = {
    Text = "「小さな王国」任意の難易度をクリア"
  },
  Task_55182_Desc = {
    Text = "混沌界域の覚醒体を使用し「花園の記憶」で1回勝利"
  },
  Task_55183_Desc = {
    Text = "花園の記憶・突破"
  },
  Task_55184_Desc = {
    Text = "「咲く詩篇」任意の難易度をクリア"
  },
  Task_55185_Desc = {
    Text = "「薔薇の花園」で詩文を交換し100回の報酬を受け取る"
  },
  Task_55186_Desc = {
    Text = "「薔薇の花園」で詩文を交換し200回の報酬を受け取る"
  },
  Task_55187_Desc = {
    Text = "「灰」任意の難易度をクリア"
  },
  Task_55188_Desc = {
    Text = "血肉界域の覚醒体を使用し「花園の記憶」で2回勝利"
  },
  Task_55189_Desc = {
    Text = "「桔梗花圃」で詩文を交換し200回の報酬を受け取る"
  },
  Task_55190_Desc = {
    Text = "「桔梗花圃」で詩文を交換し100回の報酬を受け取る"
  },
  Task_55191_Desc = {
    Text = "血肉界域の覚醒体を使用し「花園の記憶」で1回勝利"
  },
  Task_55192_Desc = {
    Text = "特務記録「薔薇の住処」をクリア"
  },
  Task_55193_Desc = {
    Text = "「手を取る」任意の難易度をクリア"
  },
  Task_55194_Desc = {
    Text = "「最初の薔薇」任意の難易度をクリア"
  },
  Task_55195_Desc = {
    Text = "「アイリスガーデン」で詩文を交換し200回の報酬を受け取る"
  },
  Task_55196_Desc = {
    Text = "超次元界域の覚醒体を使用し「花園の記憶」で1回勝利"
  },
  Task_55197_Desc = {
    Text = "超次元界域の覚醒体を使用し「花園の記憶」で2回勝利"
  },
  Task_55198_Desc = {
    Text = "深海界域の覚醒体を使用し「花園の記憶」で2回勝利"
  },
  Task_55199_Desc = {
    Text = "深海界域の覚醒体を使用し「花園の記憶」で1回勝利"
  },
  Task_55200_Desc = {
    Text = "「アイリスガーデン」で詩文を交換し100回の報酬を受け取る"
  },
  Task_55426_Desc = {
    Text = "コレットを撃破"
  },
  Task_55426_Name = {Text = "目標"},
  Task_55852_Desc = {
    Text = "任意の覚醒体をレベル70にする"
  },
  Task_55852_Name = {Text = "任務2"},
  Task_55853_Desc = {
    Text = "調査・通常第7章を完了する"
  },
  Task_55853_Name = {Text = "任務3"},
  Task_55854_Desc = {
    Text = "覚醒体を4体レベル62にする"
  },
  Task_55854_Name = {Text = "任務1"},
  Task_55855_Desc = {
    Text = "任意の覚醒体を人格深化レベル4にする"
  },
  Task_55855_Name = {Text = "任務4"},
  Task_55856_Desc = {
    Text = "融災特訓値が150に達する"
  },
  Task_55856_Name = {Text = "任務5"},
  Task_55857_Desc = {
    Text = "ステージ内の全任務を完了後に報酬を受け取り可能"
  },
  Task_55857_Name = {
    Text = "第八段階"
  },
  Task_55858_Desc = {
    Text = "ステージ内の全任務を完了後に報酬を受け取り可能"
  },
  Task_55858_Name = {
    Text = "第七段階"
  },
  Task_55859_Desc = {
    Text = "任意の覚醒体をレベル62にする"
  },
  Task_55859_Name = {Text = "任務2"},
  Task_55860_Desc = {
    Text = "調査・通常第6章を完了する"
  },
  Task_55860_Name = {Text = "任務3"},
  Task_55861_Desc = {
    Text = "任意の覚醒体スキルをレベル6にする"
  },
  Task_55861_Name = {Text = "任務1"},
  Task_55862_Desc = {
    Text = "任意の覚醒体の才能を1回起動する"
  },
  Task_55862_Name = {Text = "任務4"},
  Task_55863_Desc = {
    Text = "融災特訓値が50に達する"
  },
  Task_55863_Name = {Text = "任務5"},
  Task_56002_Desc = {
    Text = "意識潜行「巨人の墜落」高難度を完了する"
  },
  Task_56002_Name = {
    Text = "無匹の猛勇・高難度"
  },
  Task_56003_Desc = {
    Text = "意識潜行「いつも通り」高難度を完了する"
  },
  Task_56003_Name = {
    Text = "見えない都市・高難度"
  },
  Task_56004_Desc = {
    Text = "意識潜行「巨人の墜落」を完了する"
  },
  Task_56004_Name = {
    Text = "無双の勇猛"
  },
  Task_56005_Desc = {
    Text = "特務記録「静かな分裂」高難度を完了"
  },
  Task_56005_Name = {
    Text = "源流への回帰・高難度"
  },
  Task_56006_Desc = {
    Text = "特務記録「血の色」高難度を完了"
  },
  Task_56006_Name = {
    Text = "永遠の慈愛・高難度"
  },
  Task_56007_Desc = {
    Text = "特務記録「静かな分裂」を完了"
  },
  Task_56007_Name = {
    Text = "源流への回帰"
  },
  Task_56008_Desc = {
    Text = "特務記録「血の色」を完了"
  },
  Task_56008_Name = {
    Text = "永遠の慈愛"
  },
  Task_56009_Desc = {
    Text = "異夢視界「冒涜」を完了する"
  },
  Task_56009_Name = {
    Text = "歪んだ狂信"
  },
  Task_56103_Desc = {
    Text = "敵に毒を50000回重ねる"
  },
  Task_56103_Name = {
    Text = "現実の毒Ⅲ"
  },
  Task_56104_Desc = {
    Text = "敵に毒を100000回重ねる"
  },
  Task_56104_Name = {
    Text = "現実の毒Ⅳ"
  },
  Task_56106_Desc = {
    Text = "レベル80の覚醒体を6体所持する"
  },
  Task_56106_Name = {
    Text = "「超越の力」Ⅴ"
  },
  Task_56107_Desc = {
    Text = "異夢視界「天の果て·上」をクリア"
  },
  Task_56107_Name = {Text = "落下"},
  Task_56108_Desc = {
    Text = "「幻夢の深奥」を200回クリア"
  },
  Task_56108_Name = {
    Text = "夢の冒険者"
  },
  Task_56109_Desc = {
    Text = "「幻夢の深奥」を300回クリア"
  },
  Task_56109_Name = {
    Text = "夢の旅人"
  },
  Task_56110_Desc = {
    Text = "「幻夢の深奥」を500回クリア"
  },
  Task_56110_Name = {
    Text = "夢操り師"
  },
  Task_56111_Desc = {
    Text = "レベル80の覚醒体を8体所持する"
  },
  Task_56111_Name = {
    Text = "「超越の力」Ⅵ"
  },
  Task_56112_Desc = {
    Text = "レベル80の覚醒体を10体所持する"
  },
  Task_56112_Name = {
    Text = "「超越の力」Ⅶ"
  },
  Task_56113_Desc = {
    Text = "8体の覚醒体との同調率がレベル10に到達"
  },
  Task_56113_Name = {
    Text = "会うは別れの始まり"
  },
  Task_56115_Desc = {
    Text = "合成材料11111回"
  },
  Task_56115_Name = {
    Text = "高速稼働のるつぼがミサゴに入る"
  },
  Task_56116_Desc = {
    Text = "レベル12の密約を200個所持する"
  },
  Task_56116_Name = {
    Text = "禁忌の守護者Ⅳ"
  },
  Task_56117_Desc = {
    Text = "4名の覚醒体との同調率がレベル10に到達"
  },
  Task_56117_Name = {Text = "相棒Ⅸ"},
  Task_56118_Desc = {
    Text = "覚醒体スキルを400回昇級"
  },
  Task_56118_Name = {
    Text = "「武器マスター」Ⅱ"
  },
  Task_56120_Desc = {
    Text = "レベル80の覚醒体を30体所持する"
  },
  Task_56120_Name = {
    Text = "虚無への宣戦Ⅲ"
  },
  Task_56121_Desc = {
    Text = "レベル80の覚醒体を25体所持する"
  },
  Task_56121_Name = {
    Text = "虚無への宣戦Ⅱ"
  },
  Task_56122_Desc = {
    Text = "レベル80の覚醒体を20体所持する"
  },
  Task_56122_Name = {
    Text = "虚無への宣戦Ⅰ"
  },
  Task_56123_Desc = {
    Text = "レベル80の覚醒体を15体所持する"
  },
  Task_56123_Name = {
    Text = "「超越の力」Ⅷ"
  },
  Task_56126_Desc = {
    Text = "レベル80の覚醒体を40体所持する"
  },
  Task_56126_Name = {
    Text = "虚無への宣戦Ⅴ"
  },
  Task_56127_Desc = {
    Text = "レベル80の覚醒体を35体所持する"
  },
  Task_56127_Name = {
    Text = "虚無への宣戦Ⅳ"
  },
  Task_56128_Desc = {
    Text = "黒章を累計 250000 消費"
  },
  Task_56128_Name = {
    Text = "ようこそ「光」Ⅴ"
  },
  Task_56129_Desc = {
    Text = "黒章を累計 1000000 消費"
  },
  Task_56129_Name = {
    Text = "ようこそ「光」Ⅶ"
  },
  Task_56130_Desc = {
    Text = "黒章を累計 500000 消費"
  },
  Task_56130_Name = {
    Text = "ようこそ「光」Ⅵ"
  },
  Task_56131_Desc = {
    Text = "覚醒体スキルを800回昇級"
  },
  Task_56131_Name = {
    Text = "「武器マスター」Ⅵ"
  },
  Task_56132_Desc = {
    Text = "覚醒体スキルを700回昇級"
  },
  Task_56132_Name = {
    Text = "「武器マスター」Ⅴ"
  },
  Task_56133_Desc = {
    Text = "覚醒体スキルを600回昇級"
  },
  Task_56133_Name = {
    Text = "「武器マスター」Ⅳ"
  },
  Task_56134_Desc = {
    Text = "覚醒体スキルを500回昇級"
  },
  Task_56134_Name = {
    Text = "「武器マスター」Ⅲ"
  },
  Task_56135_Desc = {
    Text = "密約転写を5000回完了する"
  },
  Task_56135_Name = {
    Text = "五彩の黒"
  },
  Task_56136_Desc = {
    Text = "密約転写を2500回完了する"
  },
  Task_56136_Name = {
    Text = "気まぐれな心"
  },
  Task_56137_Desc = {
    Text = "密約転写を1000回完了する"
  },
  Task_56137_Name = {
    Text = "初稿に戻せ！"
  },
  Task_56138_Desc = {
    Text = "覚醒体スキルを900回昇級"
  },
  Task_56138_Name = {
    Text = "「武器マスター」Ⅶ"
  },
  Task_56140_Desc = {
    Text = "密約転写を10000回完了する"
  },
  Task_56140_Name = {
    Text = "悪魔クライアント"
  },
  Task_56156_Desc = {
    Text = "運命の札の強化を800回達成する"
  },
  Task_56156_Name = {
    Text = "量子もつれの未来Ⅱ"
  },
  Task_56157_Desc = {
    Text = "運命の札の強化を900回達成する"
  },
  Task_56157_Name = {
    Text = "量子もつれの未来Ⅲ"
  },
  Task_56161_Desc = {
    Text = "オルラの同調率がレベル10に到達する"
  },
  Task_56162_Desc = {
    Text = "ミリアムの同調率がレベル10に到達する"
  },
  Task_56177_Desc = {
    Text = "80種類の異なる運命の札を獲得する"
  },
  Task_56177_Name = {
    Text = "運命を編む者"
  },
  Task_56178_Desc = {
    Text = "70種類の異なる運命の札を獲得する"
  },
  Task_56178_Name = {
    Text = "無常の支配者"
  },
  Task_56179_Desc = {
    Text = "覚醒体スキルを300回昇級"
  },
  Task_56179_Name = {
    Text = "「武器マスター」Ⅰ"
  },
  Task_56180_Desc = {
    Text = "運命の札の強化を1100回達成する"
  },
  Task_56180_Name = {
    Text = "量子もつれの未来Ⅴ"
  },
  Task_56181_Desc = {
    Text = "運命の札の強化を1200回達成する"
  },
  Task_56181_Name = {
    Text = "量子もつれの未来Ⅵ"
  },
  Task_56182_Desc = {
    Text = "「いいね」を1000回行う"
  },
  Task_56182_Name = {
    Text = "社交の強者"
  },
  Task_56184_Desc = {
    Text = "「いいね」を250回行う"
  },
  Task_56184_Name = {
    Text = "外部への大きな一歩"
  },
  Task_56185_Desc = {
    Text = "「いいね」を500回行う"
  },
  Task_56185_Name = {
    Text = "世界への大きな一歩"
  },
  Task_56186_Desc = {
    Text = "運命の札を2000個分解する"
  },
  Task_56186_Name = {
    Text = "運命の主人"
  },
  Task_56187_Desc = {
    Text = "運命の札を1000個分解する"
  },
  Task_56187_Name = {
    Text = "運命の喉を掴む"
  },
  Task_56188_Desc = {
    Text = "60種類の異なる運命の札を獲得する"
  },
  Task_56188_Name = {
    Text = "運命の徒弟Ⅱ"
  },
  Task_56189_Desc = {
    Text = "50種類の異なる運命の札を獲得する"
  },
  Task_56189_Name = {
    Text = "運命の徒弟Ⅰ"
  },
  Task_56191_Desc = {
    Text = "運命の札の強化を1000回達成する"
  },
  Task_56191_Name = {
    Text = "量子もつれの未来Ⅳ"
  },
  Task_56192_Desc = {
    Text = "運命の札を500個分解する"
  },
  Task_56192_Name = {
    Text = "運命に挑む"
  },
  Task_56349_Desc = {
    Text = "ボス「アイギス」を撃退"
  },
  Task_56349_Name = {Text = "目標"},
  Task_56350_Desc = {
    Text = "ボス「ダフォダイル」を撃退"
  },
  Task_56350_Name = {Text = "目標"},
  Task_56351_Desc = {
    Text = "ボス「レーア」を撃退"
  },
  Task_56351_Name = {Text = "目標"},
  Task_56352_Desc = {
    Text = "ボス「オルラへ」を撃退"
  },
  Task_56352_Name = {Text = "目標"},
  Task_56353_Desc = {
    Text = "ボス「24」を撃退"
  },
  Task_56353_Name = {Text = "目標"},
  Task_56412_Desc = {
    Text = "「神の降臨」任意の難易度をクリア"
  },
  Task_56413_Desc = {
    Text = "「処刑人」任意の難易度をクリア"
  },
  Task_56414_Desc = {
    Text = "暗き胎内・突破"
  },
  Task_56415_Desc = {
    Text = "「聖骸布」任意の難易度をクリア"
  },
  Task_56416_Desc = {
    Text = "暗き胎内・界域"
  },
  Task_56417_Desc = {
    Text = "「休眠」任意の難易度をクリア"
  },
  Task_56420_Desc = {
    Text = "「生贄の子羊」任意の難易度をクリア"
  },
  Task_56421_Desc = {
    Text = "「時空の裂け目」任意の難易度をクリア"
  },
  Task_56422_Desc = {
    Text = "「黄色い星」任意の難易度をクリア"
  },
  Task_57121_Desc = {
    Text = "「生贄の子羊」超難度をクリア"
  },
  Task_57122_Desc = {
    Text = "「処刑人」超難度をクリア"
  },
  Task_57123_Desc = {
    Text = "深海界域の覚醒体を使用し「暗き胎内」で2回勝利"
  },
  Task_57124_Desc = {
    Text = "超次元界域の覚醒体を使用し「暗き胎内」で2回勝利"
  },
  Task_57125_Desc = {
    Text = "「神の降臨」超難度をクリア"
  },
  Task_57126_Desc = {
    Text = "深海界域の覚醒体を使用し「暗き胎内」で1回勝利"
  },
  Task_57127_Desc = {
    Text = "「時空の裂け目」超難度をクリア"
  },
  Task_57128_Desc = {
    Text = "「黄色い星」超難度をクリア"
  },
  Task_57129_Desc = {
    Text = "混沌界域の覚醒体を使用し「暗き胎内」で1回勝利"
  },
  Task_57130_Desc = {
    Text = "「休眠」超難度をクリア"
  },
  Task_57131_Desc = {
    Text = "混沌界域の覚醒体を使用し「暗き胎内」で2回勝利"
  },
  Task_57132_Desc = {
    Text = "血肉界域の覚醒体を使用し「暗き胎内」で1回勝利"
  },
  Task_57133_Desc = {
    Text = "「暗き胎内・突破」と「暗き胎内・界域」全任務を完了する"
  },
  Task_57134_Desc = {
    Text = "血肉界域の覚醒体を使用し「暗き胎内」で2回勝利"
  },
  Task_57135_Desc = {
    Text = "「聖骸布」超難度をクリア"
  },
  Task_57136_Desc = {
    Text = "超次元界域の覚醒体を使用し「暗き胎内」で1回勝利"
  },
  Task_57137_Desc = {
    Text = "暗き胎内・狂気"
  },
  Task_57369_Desc = {
    Text = "「見立て殺人」任意の難易度をクリア"
  },
  Task_57370_Desc = {
    Text = "月夜の伝説・超難度"
  },
  Task_57371_Desc = {
    Text = "「密室の謎」任意の難易度をクリア"
  },
  Task_57372_Desc = {
    Text = "月夜の伝説・突破"
  },
  Task_57373_Desc = {
    Text = "「見立て殺人」超難度をクリア"
  },
  Task_57374_Desc = {
    Text = "「首なし死体」任意の難易度をクリア"
  },
  Task_57375_Desc = {
    Text = "混沌界域の覚醒体を使用し「月夜の伝説」で2回勝利"
  },
  Task_57376_Desc = {
    Text = "血肉界域の覚醒体を使用し「月夜の伝説」で2回勝利"
  },
  Task_57377_Desc = {
    Text = "血肉界域の覚醒体を使用し「月夜の伝説」で1回勝利"
  },
  Task_57378_Desc = {
    Text = "「招かれざる客」超難度をクリア"
  },
  Task_57379_Desc = {
    Text = "「首なし死体」超難度をクリア"
  },
  Task_57380_Desc = {
    Text = "「月夜の伝説・突破」全任務を完了する"
  },
  Task_57381_Desc = {
    Text = "「密室の謎」超難度をクリア"
  },
  Task_57382_Desc = {
    Text = "超次元界域の覚醒体を使用し「月夜の伝説」で1回勝利"
  },
  Task_57383_Desc = {
    Text = "超次元界域の覚醒体を使用し「月夜の伝説」で2回勝利"
  },
  Task_57384_Desc = {
    Text = "深海界域の覚醒体を使用し「月夜の伝説」で1回勝利"
  },
  Task_57385_Desc = {
    Text = "深海界域の覚醒体を使用し「月夜の伝説」で2回勝利"
  },
  Task_57386_Desc = {
    Text = "「幸運な凡人」任意の難易度をクリア"
  },
  Task_57387_Desc = {
    Text = "「アリバイの証明」超難度をクリア"
  },
  Task_57388_Desc = {
    Text = "「探偵の友」任意の難易度をクリア"
  },
  Task_57389_Desc = {
    Text = "「招かれざる客」任意の難易度をクリア"
  },
  Task_57390_Desc = {
    Text = "混沌界域の覚醒体を使用し「月夜の伝説」で1回勝利"
  },
  Task_57391_Desc = {
    Text = "月夜の伝説・界域"
  },
  Task_57392_Desc = {
    Text = "「探偵の友」超難度をクリア"
  },
  Task_57393_Desc = {
    Text = "「アリバイの証明」任意の難易度をクリア"
  },
  Task_57394_Desc = {
    Text = "「幸運な凡人」超難度をクリア"
  },
  Task_57404_Desc = {
    Text = "「後記」任意の難易度をクリア"
  },
  Task_57405_Desc = {
    Text = "「叙述トリック」任意の難易度をクリア"
  },
  Task_57406_Desc = {
    Text = "「後記」超難度をクリア"
  },
  Task_57407_Desc = {
    Text = "「叙述トリック」超難度をクリア"
  },
  Task_57409_Desc = {
    Text = "特務記録「良き狩りを！」をクリア"
  },
  Task_57570_Desc = {
    Text = "「叙述トリック」任意の難易度をクリア"
  },
  Task_57571_Desc = {
    Text = "「探偵の友」任意の難易度をクリア"
  },
  Task_57572_Desc = {
    Text = "「首なし死体」任意の難易度をクリア"
  },
  Task_57573_Desc = {
    Text = "「生贄の子羊」任意の難易度をクリア"
  },
  Task_57574_Desc = {
    Text = "「アリバイの証明」任意の難易度をクリア"
  },
  Task_57575_Desc = {
    Text = "「黄色い星」任意の難易度をクリア"
  },
  Task_57576_Desc = {
    Text = "「神の降臨」任意の難易度をクリア"
  },
  Task_57577_Desc = {
    Text = "「処刑人」任意の難易度をクリア"
  },
  Task_57578_Desc = {
    Text = "「後記」任意の難易度をクリア"
  },
  Task_57579_Desc = {
    Text = "「聖骸布」任意の難易度をクリア"
  },
  Task_57580_Desc = {
    Text = "「招かれざる客」任意の難易度をクリア"
  },
  Task_57581_Desc = {
    Text = "「休眠」任意の難易度をクリア"
  },
  Task_57582_Desc = {
    Text = "「時空の裂け目」任意の難易度をクリア"
  },
  Task_57583_Desc = {
    Text = "「見立て殺人」任意の難易度をクリア"
  },
  Task_57584_Desc = {
    Text = "「幸運な凡人」任意の難易度をクリア"
  },
  Task_57585_Desc = {
    Text = "「密室の謎」任意の難易度をクリア"
  },
  Task_58104_Desc = {
    Text = "「懺悔」任意の難易度をクリア"
  },
  Task_58107_Desc = {
    Text = "「告発」任意の難易度をクリア"
  },
  Task_58109_Desc = {
    Text = "「偏執」超難度をクリア"
  },
  Task_58110_Desc = {
    Text = "「争奪」任意の難易度をクリア"
  },
  Task_58111_Desc = {
    Text = "「争奪」任意の難易度をクリア"
  },
  Task_58112_Desc = {
    Text = "「懺悔」任意の難易度をクリア"
  },
  Task_58113_Desc = {
    Text = "「偏執」任意の難易度をクリア"
  },
  Task_58114_Desc = {
    Text = "「懺悔」超難度をクリア"
  },
  Task_58115_Desc = {
    Text = "「要求」任意の難易度をクリア"
  },
  Task_58118_Desc = {
    Text = "「告発」超難度をクリア"
  },
  Task_58119_Desc = {
    Text = "「要求」超難度をクリア"
  },
  Task_58120_Desc = {
    Text = "「聖堂の道」全ステージを任意の難易度でクリア"
  },
  Task_58122_Desc = {
    Text = "「告発」任意の難易度をクリア"
  },
  Task_58123_Desc = {
    Text = "聖堂チャリティ会場"
  },
  Task_58124_Desc = {
    Text = "「偏執」任意の難易度をクリア"
  },
  Task_58126_Desc = {
    Text = "「要求」任意の難易度をクリア"
  },
  Task_58128_Desc = {
    Text = "聖堂の道・超難度"
  },
  Task_58130_Desc = {
    Text = "聖堂の道・増長"
  },
  Task_58131_Desc = {
    Text = "「争奪」超難度をクリア"
  },
  Task_58132_Desc = {
    Text = "「ジョン爺のマジカルバザー」で100回購入"
  },
  Task_58133_Desc = {
    Text = "「ジョン爺のマジカルバザー」で200回購入"
  },
  Task_58134_Desc = {
    Text = "「グレイおばさんの店」で100回購入"
  },
  Task_58135_Desc = {
    Text = "「グレイおばさんの店」で200回購入"
  },
  Task_58136_Desc = {
    Text = "「スミスの特別セール」で200回購入"
  },
  Task_58137_Desc = {
    Text = "「スミスの特別セール」で100回購入"
  },
  Task_58138_Desc = {
    Text = "調査「{s1}」を完了する"
  },
  Task_58500_Desc = {
    Text = "轟音の響き・突破"
  },
  Task_58501_Desc = {
    Text = "「管弦楽団」超難度をクリア"
  },
  Task_58502_Desc = {
    Text = "「序曲」任意の難易度をクリア"
  },
  Task_58503_Desc = {
    Text = "「メヌエット」任意の難易度をクリア"
  },
  Task_58504_Desc = {
    Text = "「余韻」任意の難易度をクリア"
  },
  Task_58505_Desc = {
    Text = "「終曲」任意の難易度をクリア"
  },
  Task_58506_Desc = {
    Text = "「アダージョ」任意の難易度をクリア"
  },
  Task_58507_Desc = {
    Text = "「アレグロ」超難度をクリア"
  },
  Task_58508_Desc = {
    Text = "「メヌエット」超難度をクリア"
  },
  Task_58509_Desc = {
    Text = "「余韻」任意の難易度をクリア"
  },
  Task_58510_Desc = {
    Text = "混沌界域の覚醒体を使用し「轟音の響き」で1回勝利"
  },
  Task_58511_Desc = {
    Text = "混沌界域の覚醒体を使用し「轟音の響き」で2回勝利"
  },
  Task_58512_Desc = {
    Text = "「迷夢の導き」任意の難易度をクリア"
  },
  Task_58513_Desc = {
    Text = "轟音の響き・界域"
  },
  Task_58514_Desc = {
    Text = "「余韻」超難度をクリア"
  },
  Task_58515_Desc = {
    Text = "「メヌエット」任意の難易度をクリア"
  },
  Task_58516_Desc = {
    Text = "轟音の響き・超難度"
  },
  Task_58517_Desc = {
    Text = "「アレグロ」任意の難易度をクリア"
  },
  Task_58518_Desc = {
    Text = "「序曲」超難度をクリア"
  },
  Task_58519_Desc = {
    Text = "「管弦楽団」任意の難易度をクリア"
  },
  Task_58520_Desc = {
    Text = "「アダージョ」超難度をクリア"
  },
  Task_58521_Desc = {
    Text = "「アダージョ」任意の難易度をクリア"
  },
  Task_58522_Desc = {
    Text = "深海界域の覚醒体を使用し「轟音の響き」で2回勝利"
  },
  Task_58523_Desc = {
    Text = "深海界域の覚醒体を使用し「轟音の響き」で1回勝利"
  },
  Task_58524_Desc = {
    Text = "「幕切れ」任意の難易度をクリア"
  },
  Task_58525_Desc = {
    Text = "「終曲」超難度をクリア"
  },
  Task_58526_Desc = {
    Text = "「迷夢の導き」超難度をクリア"
  },
  Task_58527_Desc = {
    Text = "超次元界域の覚醒体を使用し「轟音の響き」で2回勝利"
  },
  Task_58528_Desc = {
    Text = "超次元界域の覚醒体を使用し「轟音の響き」で1回勝利"
  },
  Task_58529_Desc = {
    Text = "「アレグロ」任意の難易度をクリア"
  },
  Task_58530_Desc = {
    Text = "「轟音の響き・突破」全任務を完了する"
  },
  Task_58531_Desc = {
    Text = "「序曲」任意の難易度をクリア"
  },
  Task_58532_Desc = {
    Text = "「幕切れ」任意の難易度をクリア"
  },
  Task_58533_Desc = {
    Text = "「管弦楽団」任意の難易度をクリア"
  },
  Task_58534_Desc = {
    Text = "「迷夢の導き」任意の難易度をクリア"
  },
  Task_58535_Desc = {
    Text = "「終曲」任意の難易度をクリア"
  },
  Task_58536_Desc = {
    Text = "「幕切れ」超難度をクリア"
  },
  Task_58537_Desc = {
    Text = "血肉界域の覚醒体を使用し「轟音の響き」で1回勝利"
  },
  Task_58538_Desc = {
    Text = "血肉界域の覚醒体を使用し「轟音の響き」で2回勝利"
  },
  Task_58989_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_58989_Name = {Text = "速攻"},
  Task_58990_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_58990_Name = {Text = "速攻"},
  Task_58991_Desc = {
    Text = "最終戦で1ターンに追加で最低5枚のカードを引く"
  },
  Task_58991_Name = {
    Text = "ドロー！"
  },
  Task_58992_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_58992_Name = {
    Text = "省エネ主義"
  },
  Task_58993_Desc = {
    Text = "4種以上の異なる刻印を獲得"
  },
  Task_58993_Name = {
    Text = "霊魂烙印"
  },
  Task_58994_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_58994_Name = {Text = "速攻"},
  Task_58995_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_58995_Name = {Text = "速攻"},
  Task_58996_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_58996_Name = {Text = "速攻"},
  Task_58997_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_58997_Name = {Text = "速攻"},
  Task_58998_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_58998_Name = {Text = "速攻"},
  Task_58999_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_58999_Name = {Text = "速攻"},
  Task_59000_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_59000_Name = {Text = "速攻"},
  Task_59001_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_59001_Name = {
    Text = "完璧な通過"
  },
  Task_59002_Desc = {
    Text = "クリア時の症状が3枚以下"
  },
  Task_59002_Name = {
    Text = "省エネ主義"
  },
  Task_59003_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_59003_Name = {
    Text = "省エネ主義"
  },
  Task_59004_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_59004_Name = {
    Text = "完璧な通過"
  },
  Task_59005_Desc = {
    Text = "クリア時、遺物を8個以上所持"
  },
  Task_59005_Name = {
    Text = "伏兵の宝物"
  },
  Task_59006_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_59006_Name = {
    Text = "完璧な通過"
  },
  Task_59007_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_59007_Name = {
    Text = "伏兵の宝物"
  },
  Task_59008_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_59008_Name = {
    Text = "完璧な通過"
  },
  Task_59009_Desc = {
    Text = "最終戦で1ターン中カード6枚以上使用"
  },
  Task_59009_Name = {
    Text = "私のターン"
  },
  Task_59010_Desc = {
    Text = "最終戦で1ターンに最大ライフの65%のシールドを獲得"
  },
  Task_59010_Name = {
    Text = "鋼鉄の体"
  },
  Task_59011_Desc = {
    Text = "最終戦で1ターン中カード6枚以上使用"
  },
  Task_59011_Name = {
    Text = "私のターン"
  },
  Task_59012_Desc = {
    Text = "最終戦で1ターンに最大ライフの65%のシールドを獲得"
  },
  Task_59012_Name = {
    Text = "鋼鉄の体"
  },
  Task_59013_Desc = {
    Text = "最終戦で1ターンに追加で最低5枚のカードを引く"
  },
  Task_59013_Name = {
    Text = "ドロー！"
  },
  Task_59014_Desc = {
    Text = "最終戦で1ターンに最低20000ダメージを与える"
  },
  Task_59014_Name = {
    Text = "全力一撃"
  },
  Task_59015_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_59015_Name = {
    Text = "優雅で正確"
  },
  Task_59016_Desc = {
    Text = "4種以上の異なる刻印を獲得"
  },
  Task_59016_Name = {
    Text = "霊魂烙印"
  },
  Task_59017_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_59017_Name = {
    Text = "優雅で正確"
  },
  Task_59018_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_59018_Name = {
    Text = "伏兵の宝物"
  },
  Task_59019_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_59019_Name = {
    Text = "無限の抱擁"
  },
  Task_59020_Desc = {
    Text = "クリア時、遺物を2個以上所持"
  },
  Task_59020_Name = {
    Text = "伏兵の宝物"
  },
  Task_59021_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_59021_Name = {
    Text = "伏兵の宝物"
  },
  Task_59022_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_59022_Name = {
    Text = "省エネ主義"
  },
  Task_59023_Desc = {
    Text = "最終戦で1ターンに追加で最低4枚のカードを引く"
  },
  Task_59023_Name = {
    Text = "ドロー！"
  },
  Task_59024_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_59024_Name = {
    Text = "完璧な通過"
  },
  Task_59025_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_59025_Name = {
    Text = "完璧な通過"
  },
  Task_59026_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_59026_Name = {
    Text = "完璧な通過"
  },
  Task_59027_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_59027_Name = {
    Text = "完璧な通過"
  },
  Task_59028_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_59028_Name = {
    Text = "完璧な通過"
  },
  Task_59029_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_59029_Name = {
    Text = "完璧な通過"
  },
  Task_59030_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_59030_Name = {
    Text = "完璧な通過"
  },
  Task_59031_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_59031_Name = {
    Text = "完璧な通過"
  },
  Task_59032_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_59032_Name = {
    Text = "完璧な通過"
  },
  Task_59033_Desc = {
    Text = "クリア時に全覚醒体が覚醒"
  },
  Task_59033_Name = {
    Text = "無限の抱擁"
  },
  Task_59034_Desc = {
    Text = "クリア時、遺物を2個以上所持"
  },
  Task_59034_Name = {
    Text = "伏兵の宝物"
  },
  Task_59035_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_59035_Name = {Text = "速攻"},
  Task_59036_Desc = {
    Text = "クリア時、呪われた遺物を1個以上所持"
  },
  Task_59036_Name = {
    Text = "伏兵の宝物"
  },
  Task_59037_Desc = {
    Text = "最終戦で18ターン以内に勝利"
  },
  Task_59037_Name = {Text = "速攻"},
  Task_59038_Desc = {
    Text = "最終戦で12ターン以内に勝利"
  },
  Task_59038_Name = {Text = "速攻"},
  Task_59039_Desc = {
    Text = "最終戦で1ターンに最大ライフの60%のシールドを獲得"
  },
  Task_59039_Name = {
    Text = "鋼鉄の体"
  },
  Task_59040_Desc = {
    Text = "最終戦で1ターン中カード5枚以上使用"
  },
  Task_59040_Name = {
    Text = "私のターン"
  },
  Task_59041_Desc = {
    Text = "最終戦で1ターンに最大ライフの60%のシールドを獲得"
  },
  Task_59041_Name = {
    Text = "鋼鉄の体"
  },
  Task_59042_Desc = {
    Text = "クリア時の症状が3枚以下"
  },
  Task_59042_Name = {
    Text = "省エネ主義"
  },
  Task_59043_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_59043_Name = {
    Text = "優雅で正確"
  },
  Task_59044_Desc = {
    Text = "最終戦で18ターン以内に勝利"
  },
  Task_59044_Name = {Text = "速攻"},
  Task_59045_Desc = {
    Text = "最終戦で1ターンに追加で最低4枚のカードを引く"
  },
  Task_59045_Name = {
    Text = "ドロー！"
  },
  Task_59046_Desc = {
    Text = "クリア時、遺物を8個以上所持"
  },
  Task_59046_Name = {
    Text = "伏兵の宝物"
  },
  Task_59047_Desc = {
    Text = "最終戦で1ターン中カード5枚以上使用"
  },
  Task_59047_Name = {
    Text = "私のターン"
  },
  Task_59048_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_59048_Name = {
    Text = "優雅で正確"
  },
  Task_59438_Desc = {
    Text = "ライカーの同調率がレベル10に到達する"
  },
  Task_60163_Desc = {
    Text = "ステージをクリア"
  },
  Task_60163_Name = {
    Text = "ステージをクリア"
  },
  Task_60163_UnlockCondDesc = {
    Text = "ステージ8-9クリアで解放"
  },
  Task_60164_Desc = {
    Text = "ステージをクリア"
  },
  Task_60164_Name = {
    Text = "ステージをクリア"
  },
  Task_60164_UnlockCondDesc = {
    Text = "ステージ8-11クリアで解放"
  },
  Task_60165_Desc = {
    Text = "ステージをクリア"
  },
  Task_60165_Name = {
    Text = "ステージをクリア"
  },
  Task_60165_UnlockCondDesc = {
    Text = "ステージ8-10クリアで解放"
  },
  Task_60443_Desc = {
    Text = "調査メイン第4章\n「無音の中で」を完了"
  },
  Task_60444_Desc = {
    Text = "特訓値が初めて\n150に到達"
  },
  Task_60445_Desc = {
    Text = "特訓値が初めて\n325に到達"
  },
  Task_60446_Desc = {
    Text = "特訓値が初めて\n50に到達"
  },
  Task_60447_Desc = {
    Text = "特訓値が初めて\n100に到達"
  },
  Task_60448_Desc = {
    Text = "調査メイン第4章\n「無音の中で」高難度を完了"
  },
  Task_60449_Desc = {
    Text = "特訓値が初めて\n300に到達"
  },
  Task_60450_Desc = {
    Text = "調査メイン第2章\n「蝋人形の名において」を完了"
  },
  Task_60451_Desc = {
    Text = "調査メイン第5章\n「嵐の眼」高難度を完了"
  },
  Task_60452_Desc = {
    Text = "特訓値が初めて\n225に到達"
  },
  Task_60453_Desc = {
    Text = "調査メイン第1章\n「東区の秘め事」を完了"
  },
  Task_60454_Desc = {
    Text = "調査メイン第6章\n「倒錯した星々」高難度を完了"
  },
  Task_60455_Desc = {
    Text = "調査メイン第2章\n「蝋人形の名において」高難度を完了"
  },
  Task_60456_Desc = {
    Text = "調査メイン第5章\n「嵐の眼」を完了"
  },
  Task_60457_Desc = {
    Text = "調査メイン第3章\n「猛犬注意」高難度を完了"
  },
  Task_60458_Desc = {
    Text = "調査メイン第1章\n「東区の秘め事」高難度を完了"
  },
  Task_60459_Desc = {
    Text = "調査メイン第3章\n「猛犬注意」を完了"
  },
  Task_60460_Desc = {
    Text = "調査メイン第6章\n「倒錯した星々」を完了"
  },
  Task_60461_Desc = {
    Text = "特訓値が初めて\n350に到達"
  },
  Task_60601_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60602_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60603_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60604_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60606_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60607_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60608_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60609_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60610_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60611_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60612_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60613_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60614_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60615_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60616_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60617_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60618_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60619_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60620_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60622_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60623_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60624_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60625_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60626_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60627_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60628_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60629_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60630_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60631_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60633_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60634_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60635_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60636_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60637_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60638_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60639_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60640_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60641_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60642_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60643_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60644_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60645_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60646_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60647_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60648_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60649_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60650_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60651_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60653_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60654_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60655_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60656_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60657_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60658_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60659_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60660_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60661_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60663_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60664_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60665_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60666_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60667_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60668_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60669_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60670_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60671_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60672_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60673_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60674_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60675_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60676_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60677_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60678_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60680_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60681_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60682_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60683_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60684_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60685_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60686_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60687_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60688_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60689_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60690_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60691_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60692_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60694_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60696_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60697_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60699_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60742_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60743_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60747_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60748_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60749_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60750_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60751_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60752_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60754_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60755_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60757_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60758_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60759_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60760_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60761_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60763_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60765_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60766_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60768_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60769_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60770_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60772_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60773_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60774_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60777_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60778_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60779_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60780_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60781_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60782_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60783_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60784_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60785_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60787_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60788_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60789_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60790_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60793_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60795_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60796_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60797_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60798_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60799_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60800_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60801_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60803_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60804_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60805_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_60829_Desc = {
    Text = "ハムリンの同調率がレベル10に到達する"
  },
  Task_61103_Desc = {
    Text = "溶壊・ドールを獲得する"
  },
  Task_61103_Name = {
    Text = "溶壊・ドールを獲得する"
  },
  Task_61104_Desc = {
    Text = "血ノ鎖・ヘロットを獲得する"
  },
  Task_61104_Name = {
    Text = "血ノ鎖・ヘロットを獲得する"
  },
  Task_61105_Desc = {
    Text = "リリーを獲得する"
  },
  Task_61105_Name = {
    Text = "リリーを獲得する"
  },
  Task_61106_Desc = {
    Text = "オルラを獲得する"
  },
  Task_61106_Name = {
    Text = "オルラを獲得する"
  },
  Task_61107_Desc = {
    Text = "ミリアムを獲得する"
  },
  Task_61107_Name = {
    Text = "ミリアムを獲得する"
  },
  Task_61108_Desc = {
    Text = "ライカーを獲得する"
  },
  Task_61108_Name = {
    Text = "ライカーを獲得する"
  },
  Task_61109_Desc = {
    Text = "ソレールを獲得する"
  },
  Task_61109_Name = {
    Text = "ソレールを獲得する"
  },
  Task_61110_Desc = {
    Text = "サルバドルを獲得する"
  },
  Task_61110_Name = {
    Text = "サルバドルを獲得する"
  },
  Task_61111_Desc = {
    Text = "ワンダを獲得する"
  },
  Task_61111_Name = {
    Text = "ワンダを獲得する"
  },
  Task_61112_Desc = {
    Text = "トゥルーを獲得する"
  },
  Task_61112_Name = {
    Text = "トゥルーを獲得する"
  },
  Task_61113_Desc = {
    Text = "「24」を獲得する"
  },
  Task_61113_Name = {
    Text = "「24」を獲得する"
  },
  Task_61114_Desc = {
    Text = "タヴィを獲得する"
  },
  Task_61114_Name = {
    Text = "タヴィを獲得する"
  },
  Task_61115_Desc = {
    Text = "タイスを獲得する"
  },
  Task_61115_Name = {
    Text = "タイスを獲得する"
  },
  Task_61116_Desc = {
    Text = "ハムリンを獲得する"
  },
  Task_61116_Name = {
    Text = "ハムリンを獲得する"
  },
  Task_61117_Desc = {
    Text = "ダフォダイルを獲得する"
  },
  Task_61117_Name = {
    Text = "ダフォダイルを獲得する"
  },
  Task_61118_Desc = {
    Text = "マーフィーを獲得する"
  },
  Task_61118_Name = {
    Text = "マーフィーを獲得する"
  },
  Task_61157_Desc = {
    Text = "調査メイン第8章\n「終末交響曲」高難度を完了"
  },
  Task_61158_Desc = {
    Text = "調査メイン第7章\n「欲望の川」を完了"
  },
  Task_61159_Desc = {
    Text = "調査メイン第7章\n「欲望の川」高難度を完了"
  },
  Task_61160_Desc = {
    Text = "調査メイン第8章\n「終末交響曲」高難度を完了"
  },
  Task_61161_Desc = {
    Text = "調査メイン第8章\n「終末交響曲」を完了"
  },
  Task_61162_Desc = {
    Text = "調査メイン第7章\n「欲望の川」高難度を完了"
  },
  Task_61163_Desc = {
    Text = "調査メイン第7章\n「欲望の川」を完了"
  },
  Task_61164_Desc = {
    Text = "調査メイン第8章\n「終末交響曲」を完了"
  },
  Task_61186_Desc = {
    Text = "「記憶の欠片」任意の難易度をクリア"
  },
  Task_61187_Desc = {
    Text = "「黄金の城」任意の難易度をクリア"
  },
  Task_61188_Desc = {
    Text = "混沌界域の覚醒体を使用し「湖中の城」で1回勝利"
  },
  Task_61189_Desc = {
    Text = "「湖中の城・突破」のすべての任務を完了する"
  },
  Task_61190_Desc = {
    Text = "「黙示録」任意の難易度をクリア"
  },
  Task_61191_Desc = {
    Text = "「真実」超難度をクリア"
  },
  Task_61192_Desc = {
    Text = "「黄金の城」超難度をクリア"
  },
  Task_61193_Desc = {
    Text = "「蜃気楼」任意の難易度をクリア"
  },
  Task_61194_Desc = {
    Text = "湖中の城・突破"
  },
  Task_61195_Desc = {
    Text = "「真実」任意の難易度をクリア"
  },
  Task_61196_Desc = {
    Text = "「フリージア」任意の難易度をクリア"
  },
  Task_61197_Desc = {
    Text = "「蜃気楼」任意の難易度をクリア"
  },
  Task_61198_Desc = {
    Text = "超次元界域の覚醒体を使用し「湖中の城」で1回勝利"
  },
  Task_61199_Desc = {
    Text = "深海界域の覚醒体を使用し「湖中の城」で1回勝利"
  },
  Task_61200_Desc = {
    Text = "「蜃気楼」超難度をクリア"
  },
  Task_61201_Desc = {
    Text = "湖中の城・界域"
  },
  Task_61202_Desc = {
    Text = "「黄金の城」任意の難易度をクリア"
  },
  Task_61203_Desc = {
    Text = "「黙示録」任意の難易度をクリア"
  },
  Task_61204_Desc = {
    Text = "「井の中」任意の難易度をクリア"
  },
  Task_61205_Desc = {
    Text = "「記憶の欠片」任意の難易度をクリア"
  },
  Task_61206_Desc = {
    Text = "血肉界域の覚醒体を使用し「湖中の城」で1回勝利"
  },
  Task_61207_Desc = {
    Text = "「フリージア」超難度をクリア"
  },
  Task_61208_Desc = {
    Text = "「黙示録」超難度をクリア"
  },
  Task_61209_Desc = {
    Text = "「井の中」任意の難易度をクリア"
  },
  Task_61210_Desc = {
    Text = "「フリージア」任意の難易度をクリア"
  },
  Task_61211_Desc = {
    Text = "湖中の城・超難度"
  },
  Task_61212_Desc = {
    Text = "「真実」任意の難易度をクリア"
  },
  Task_61213_Desc = {
    Text = "「記憶の欠片」超難度をクリア"
  },
  Task_61214_Desc = {
    Text = "「井の中」超難度をクリア"
  },
  Task_61215_Desc = {
    Text = "意識潜行「燃える饗宴」をクリア"
  },
  Task_61375_Desc = {
    Text = "累計ログイン 12 日"
  },
  Task_61376_Desc = {
    Text = "累計ログイン 3 日"
  },
  Task_61377_Desc = {
    Text = "累計ログイン 9 日"
  },
  Task_61378_Desc = {
    Text = "累計ログイン 11 日"
  },
  Task_61379_Desc = {
    Text = "累計ログイン 10 日"
  },
  Task_61380_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_61381_Desc = {
    Text = "累計ログイン 4 日"
  },
  Task_61382_Desc = {
    Text = "累計ログイン 15 日"
  },
  Task_61383_Desc = {
    Text = "累計ログイン 14 日"
  },
  Task_61384_Desc = {
    Text = "累計ログイン 5 日"
  },
  Task_61385_Desc = {
    Text = "累計ログイン 8 日"
  },
  Task_61386_Desc = {
    Text = "累計ログイン 2 日"
  },
  Task_61387_Desc = {
    Text = "累計ログイン 13 日"
  },
  Task_61388_Desc = {
    Text = "累計ログイン 6 日"
  },
  Task_61389_Desc = {
    Text = "累計ログイン 16 日"
  },
  Task_61390_Desc = {
    Text = "累計ログイン 7 日"
  },
  Task_61394_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61395_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61396_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61397_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61398_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61399_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61400_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61401_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61402_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61403_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61404_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61405_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61407_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61408_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61409_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61410_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61411_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61412_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61413_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61414_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61415_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61416_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61417_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61418_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61419_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61420_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61421_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61422_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61425_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61426_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61427_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61428_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61430_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61431_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61432_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61433_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61434_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61435_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61436_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61438_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61439_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61440_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61441_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61442_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61443_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61444_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61445_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61446_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61447_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61448_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61449_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61450_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61451_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61452_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61453_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61455_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61456_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61457_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61458_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61459_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61460_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61461_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61462_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61463_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61464_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61465_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61466_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61468_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61469_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61470_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61471_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61472_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61473_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61474_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61475_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61476_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61477_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61478_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61479_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61481_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61519_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61520_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61521_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61522_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61523_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61524_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61525_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61526_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61527_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61528_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61616_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61617_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61620_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61621_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61622_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61623_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61626_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61627_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61628_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61629_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61631_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61633_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61634_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61636_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61637_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61639_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61640_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61642_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61643_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61644_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61645_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61648_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61649_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61650_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61652_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61653_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61654_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61655_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61657_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61659_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61660_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61661_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61662_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61665_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61666_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61668_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61669_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61671_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61672_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61673_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61675_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61676_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61678_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61679_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61681_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61682_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61684_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61685_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61687_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61688_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61690_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61691_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61693_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61694_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61696_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61697_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61699_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61700_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61701_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61702_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61704_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61705_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61706_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61707_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61709_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61710_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61712_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61713_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61716_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61717_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61719_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61720_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61722_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61723_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61725_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61726_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61727_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61729_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61731_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61733_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61734_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61735_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61736_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61739_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61740_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61743_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61744_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61748_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61749_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61750_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61751_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61753_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61754_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61756_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61757_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61758_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61759_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61762_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61763_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61765_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61766_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61767_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61769_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61770_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61771_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61772_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61774_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61777_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61778_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61781_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61782_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61783_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61784_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61785_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61788_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61789_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61791_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61792_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61794_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61795_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61796_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61797_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61798_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61801_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61802_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61804_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61805_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61807_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61808_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61810_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61811_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61814_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61815_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61816_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61817_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61819_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61820_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61821_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61824_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_61825_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_62002_Desc = {
    Text = "「望山」超難度をクリア"
  },
  Task_62003_Desc = {
    Text = "「破土」任意の難易度をクリア"
  },
  Task_62004_Desc = {
    Text = "獣の本能・界域"
  },
  Task_62005_Desc = {
    Text = "「寒夜」任意の難易度をクリア"
  },
  Task_62006_Desc = {
    Text = "「貪食の野心」で蕾を交換して200回報酬を獲得する"
  },
  Task_62007_Desc = {
    Text = "「貪食の野心」で蕾を交換して100回報酬を獲得する"
  },
  Task_62008_Desc = {
    Text = "「寒夜」超難度をクリア"
  },
  Task_62009_Desc = {
    Text = "「寒夜」任意の難易度をクリア"
  },
  Task_62010_Desc = {
    Text = "「望山」任意の難易度をクリア"
  },
  Task_62011_Desc = {
    Text = "「闘獣」任意の難易度をクリア"
  },
  Task_62012_Desc = {
    Text = "「望山」任意の難易度をクリア"
  },
  Task_62013_Desc = {
    Text = "超次元界域の覚醒体を使用し「獣の本能」で1回勝利"
  },
  Task_62014_Desc = {
    Text = "山嶺の大穴"
  },
  Task_62015_Desc = {
    Text = "「破土」超難度をクリア"
  },
  Task_62016_Desc = {
    Text = "獣の本能・超難度"
  },
  Task_62017_Desc = {
    Text = "「帰還」超難度をクリア"
  },
  Task_62018_Desc = {
    Text = "獣の本能・突破"
  },
  Task_62019_Desc = {
    Text = "深海界域の覚醒体を使用し「獣の本能」で1回勝利"
  },
  Task_62020_Desc = {
    Text = "「再生の希望」で蕾を交換して100回報酬を獲得する"
  },
  Task_62021_Desc = {
    Text = "「復讐の戦意」で蕾を交換して200回報酬を獲得する"
  },
  Task_62022_Desc = {
    Text = "「復讐の戦意」で蕾を交換して100回報酬を獲得する"
  },
  Task_62023_Desc = {
    Text = "「獣の本能・突破」と「山嶺の大穴」全任務を完了する"
  },
  Task_62024_Desc = {
    Text = "混沌界域の覚醒体を使用し「獣の本能」で1回勝利"
  },
  Task_62025_Desc = {
    Text = "「再生の希望」で蕾を交換して200回報酬を獲得する"
  },
  Task_62026_Desc = {
    Text = "「帰還」任意の難易度をクリア"
  },
  Task_62027_Desc = {
    Text = "血肉界域の覚醒体を使用し「獣の本能」で1回勝利"
  },
  Task_62028_Desc = {
    Text = "「闘獣」任意の難易度をクリア"
  },
  Task_62029_Desc = {
    Text = "「闘獣」超難度をクリア"
  },
  Task_62030_Desc = {
    Text = "「帰還」任意の難易度をクリア"
  },
  Task_62031_Desc = {
    Text = "「破土」任意の難易度をクリア"
  },
  Task_62092_Desc = {
    Text = "特務記録「雪山へのの帰還」をクリア"
  },
  Task_62207_Desc = {
    Text = "血ノ鎖・ヘロットの同調率がレベル10に到達する"
  },
  Task_62209_Desc = {
    Text = "雪山から生還する"
  },
  Task_62209_Name = {Text = "目標"},
  Task_62231_Desc = {
    Text = "ライカーの霊知啓発6を獲得する"
  },
  Task_62231_Name = {
    Text = "ライカーの霊知啓発6を獲得する"
  },
  Task_62231_UnlockCondDesc = {
    Text = "イベント@覚醒体ライカー霊知啓発ギフト2"
  },
  Task_62232_Desc = {
    Text = "ジェンキンの霊知啓発2を獲得する"
  },
  Task_62232_Name = {
    Text = "ジェンキンの霊知啓発2を獲得する"
  },
  Task_62232_UnlockCondDesc = {
    Text = "イベント@覚醒体ジェンキン霊知啓発ギフト1"
  },
  Task_62233_Desc = {
    Text = "ジェンキンの霊知啓発6を獲得する"
  },
  Task_62233_Name = {
    Text = "ジェンキンの霊知啓発6を獲得する"
  },
  Task_62233_UnlockCondDesc = {
    Text = "イベント@覚醒体ジェンキン霊知啓発ギフト2"
  },
  Task_62234_Desc = {
    Text = "ハムリンの霊知啓発2を獲得する"
  },
  Task_62234_Name = {
    Text = "ハムリンの霊知啓発2を獲得する"
  },
  Task_62234_UnlockCondDesc = {
    Text = "イベント@覚醒体ハムリン霊知啓発ギフト1"
  },
  Task_62235_Desc = {
    Text = "ワンダの霊知啓発2を獲得する"
  },
  Task_62235_Name = {
    Text = "ワンダの霊知啓発2を獲得する"
  },
  Task_62235_UnlockCondDesc = {
    Text = "イベント@覚醒体ワンダ霊知啓発ギフト1"
  },
  Task_62236_Desc = {
    Text = "ニムフィーアの霊知啓発6を獲得する"
  },
  Task_62236_Name = {
    Text = "ニムフィーアの霊知啓発6を獲得する"
  },
  Task_62236_UnlockCondDesc = {
    Text = "イベント@覚醒体ニムフィーア霊知啓発ギフト2"
  },
  Task_62237_Desc = {
    Text = "オルラの霊知啓発2を獲得する"
  },
  Task_62237_Name = {
    Text = "オルラの霊知啓発2を獲得する"
  },
  Task_62237_UnlockCondDesc = {
    Text = "イベント@覚醒体オルラ霊知啓発ギフト1"
  },
  Task_62238_Desc = {
    Text = "ワンダの霊知啓発6を獲得する"
  },
  Task_62238_Name = {
    Text = "ワンダの霊知啓発6を獲得する"
  },
  Task_62238_UnlockCondDesc = {
    Text = "イベント@覚醒体ワンダ霊知啓発ギフト2"
  },
  Task_62239_Desc = {
    Text = "カーシアの霊知啓発2を獲得する"
  },
  Task_62239_Name = {
    Text = "カーシアの霊知啓発2を獲得する"
  },
  Task_62239_UnlockCondDesc = {
    Text = "イベント@覚醒体カーシア霊知啓発ギフト1"
  },
  Task_62240_Desc = {
    Text = "ファロスの霊知啓発2を獲得する"
  },
  Task_62240_Name = {
    Text = "ファロスの霊知啓発2を獲得する"
  },
  Task_62240_UnlockCondDesc = {
    Text = "イベント@覚醒体ファロス霊知啓発ギフト1"
  },
  Task_62241_Desc = {
    Text = "ハムリンの霊知啓発6を獲得する"
  },
  Task_62241_Name = {
    Text = "ハムリンの霊知啓発6を獲得する"
  },
  Task_62241_UnlockCondDesc = {
    Text = "イベント@覚醒体ハムリン霊知啓発ギフト2"
  },
  Task_62242_Desc = {
    Text = "ティンクトの霊知啓発6を獲得する"
  },
  Task_62242_Name = {
    Text = "ティンクトの霊知啓発6を獲得する"
  },
  Task_62242_UnlockCondDesc = {
    Text = "イベント@覚醒体ティンクト霊知啓発ギフト2"
  },
  Task_62243_Desc = {
    Text = "ゴリアテの霊知啓発6を獲得する"
  },
  Task_62243_Name = {
    Text = "ゴリアテの霊知啓発6を獲得する"
  },
  Task_62243_UnlockCondDesc = {
    Text = "イベント@覚醒体ゴリアテ霊知啓発ギフト2"
  },
  Task_62244_Desc = {
    Text = "ティンクトの霊知啓発2を獲得する"
  },
  Task_62244_Name = {
    Text = "ティンクトの霊知啓発2を獲得する"
  },
  Task_62244_UnlockCondDesc = {
    Text = "イベント@覚醒体ティンクト霊知啓発ギフト1"
  },
  Task_62245_Desc = {
    Text = "レーアの霊知啓発6を獲得する"
  },
  Task_62245_Name = {
    Text = "レーアの霊知啓発6を獲得する"
  },
  Task_62245_UnlockCondDesc = {
    Text = "イベント@覚醒体レーア霊知啓発ギフト2"
  },
  Task_62246_Desc = {
    Text = "トゥルーの霊知啓発6を獲得する"
  },
  Task_62246_Name = {
    Text = "トゥルーの霊知啓発6を獲得する"
  },
  Task_62246_UnlockCondDesc = {
    Text = "イベント@覚醒体トゥルー霊知啓発ギフト2"
  },
  Task_62247_Desc = {
    Text = "ユウハシュの霊知啓発2を獲得する"
  },
  Task_62247_Name = {
    Text = "ユウハシュの霊知啓発2を獲得する"
  },
  Task_62247_UnlockCondDesc = {
    Text = "イベント@覚醒体ユウハシュ霊知啓発ギフト1"
  },
  Task_62248_Desc = {
    Text = "トゥルーの霊知啓発2を獲得する"
  },
  Task_62248_Name = {
    Text = "トゥルーの霊知啓発2を獲得する"
  },
  Task_62248_UnlockCondDesc = {
    Text = "イベント@覚醒体トゥルー霊知啓発ギフト1"
  },
  Task_62249_Desc = {
    Text = "リリーの霊知啓発6を獲得する"
  },
  Task_62249_Name = {
    Text = "リリーの霊知啓発6を獲得する"
  },
  Task_62249_UnlockCondDesc = {
    Text = "イベント@覚醒体リリー霊知啓発ギフト2"
  },
  Task_62250_Desc = {
    Text = "ファイントの霊知啓発2を獲得する"
  },
  Task_62250_Name = {
    Text = "ファイントの霊知啓発2を獲得する"
  },
  Task_62250_UnlockCondDesc = {
    Text = "イベント@覚醒体ファイント霊知啓発ギフト1"
  },
  Task_62251_Desc = {
    Text = "ダフォダイルの霊知啓発6を獲得する"
  },
  Task_62251_Name = {
    Text = "ダフォダイルの霊知啓発6を獲得する"
  },
  Task_62251_UnlockCondDesc = {
    Text = "イベント@覚醒体ダフォダイル霊知啓発ギフト2"
  },
  Task_62252_Desc = {
    Text = "アグリッパの霊知啓発6を獲得する"
  },
  Task_62252_Name = {
    Text = "アグリッパの霊知啓発6を獲得する"
  },
  Task_62252_UnlockCondDesc = {
    Text = "イベント@覚醒体アグリッパ霊知啓発ギフト2"
  },
  Task_62253_Desc = {
    Text = "パンディアの霊知啓発2を獲得する"
  },
  Task_62253_Name = {
    Text = "パンディアの霊知啓発2を獲得する"
  },
  Task_62253_UnlockCondDesc = {
    Text = "イベント@覚醒体パンディア霊知啓発ギフト1"
  },
  Task_62254_Desc = {
    Text = "ダフォダイルの霊知啓発2を獲得する"
  },
  Task_62254_Name = {
    Text = "ダフォダイルの霊知啓発2を獲得する"
  },
  Task_62254_UnlockCondDesc = {
    Text = "イベント@覚醒体ダフォダイル霊知啓発ギフト1"
  },
  Task_62255_Desc = {
    Text = "ソレールの霊知啓発2を獲得する"
  },
  Task_62255_Name = {
    Text = "ソレールの霊知啓発2を獲得する"
  },
  Task_62255_UnlockCondDesc = {
    Text = "イベント@覚醒体ソレール霊知啓発ギフト1"
  },
  Task_62256_Desc = {
    Text = "パンディアの霊知啓発6を獲得する"
  },
  Task_62256_Name = {
    Text = "パンディアの霊知啓発6を獲得する"
  },
  Task_62256_UnlockCondDesc = {
    Text = "イベント@覚醒体パンディア霊知啓発ギフト2"
  },
  Task_62257_Desc = {
    Text = "「24」の霊知啓発6を獲得する"
  },
  Task_62257_Name = {
    Text = "「24」の霊知啓発6を獲得する"
  },
  Task_62257_UnlockCondDesc = {
    Text = "イベント@覚醒体「24」霊知啓発ギフト2"
  },
  Task_62258_Desc = {
    Text = "リッツの霊知啓発2を獲得する"
  },
  Task_62258_Name = {
    Text = "リッツの霊知啓発2を獲得する"
  },
  Task_62258_UnlockCondDesc = {
    Text = "イベント@覚醒体リッツ霊知啓発ギフト1"
  },
  Task_62259_Desc = {
    Text = "「24」の霊知啓発2を獲得する"
  },
  Task_62259_Name = {
    Text = "「24」の霊知啓発2を獲得する"
  },
  Task_62259_UnlockCondDesc = {
    Text = "イベント@覚醒体「24」霊知啓発ギフト1"
  },
  Task_62260_Desc = {
    Text = "リッツの霊知啓発6を獲得する"
  },
  Task_62260_Name = {
    Text = "リッツの霊知啓発6を獲得する"
  },
  Task_62260_UnlockCondDesc = {
    Text = "イベント@覚醒体リッツ霊知啓発ギフト2"
  },
  Task_62261_Desc = {
    Text = "ヘロットの霊知啓発2を獲得する"
  },
  Task_62261_Name = {
    Text = "ヘロットの霊知啓発2を獲得する"
  },
  Task_62261_UnlockCondDesc = {
    Text = "イベント@覚醒体ヘロット霊知啓発ギフト1"
  },
  Task_62262_Desc = {
    Text = "サルバドルの霊知啓発2を獲得する"
  },
  Task_62262_Name = {
    Text = "サルバドルの霊知啓発2を獲得する"
  },
  Task_62262_UnlockCondDesc = {
    Text = "イベント@覚醒体サルバドル霊知啓発ギフト1"
  },
  Task_62263_Desc = {
    Text = "ヘロットの霊知啓発6を獲得する"
  },
  Task_62263_Name = {
    Text = "ヘロットの霊知啓発6を獲得する"
  },
  Task_62263_UnlockCondDesc = {
    Text = "イベント@覚醒体ヘロット霊知啓発ギフト2"
  },
  Task_62264_Desc = {
    Text = "サルバドルの霊知啓発6を獲得する"
  },
  Task_62264_Name = {
    Text = "サルバドルの霊知啓発6を獲得する"
  },
  Task_62264_UnlockCondDesc = {
    Text = "イベント@覚醒体サルバドル霊知啓発ギフト2"
  },
  Task_62265_Desc = {
    Text = "ニムフィーアの霊知啓発2を獲得する"
  },
  Task_62265_Name = {
    Text = "ニムフィーアの霊知啓発2を獲得する"
  },
  Task_62265_UnlockCondDesc = {
    Text = "イベント@覚醒体ニムフィーア霊知啓発ギフト1"
  },
  Task_62266_Desc = {
    Text = "マーフィーの霊知啓発2を獲得する"
  },
  Task_62266_Name = {
    Text = "マーフィーの霊知啓発2を獲得する"
  },
  Task_62266_UnlockCondDesc = {
    Text = "イベント@覚醒体マーフィー霊知啓発ギフト1"
  },
  Task_62267_Desc = {
    Text = "ライカーの霊知啓発2を獲得する"
  },
  Task_62267_Name = {
    Text = "ライカーの霊知啓発2を獲得する"
  },
  Task_62267_UnlockCondDesc = {
    Text = "イベント@覚醒体ライカー霊知啓発ギフト1"
  },
  Task_62268_Desc = {
    Text = "タヴィの霊知啓発6を獲得する"
  },
  Task_62268_Name = {
    Text = "タヴィの霊知啓発6を獲得する"
  },
  Task_62268_UnlockCondDesc = {
    Text = "イベント@覚醒体タヴィ霊知啓発ギフト2"
  },
  Task_62269_Desc = {
    Text = "ファロスの霊知啓発6を獲得する"
  },
  Task_62269_Name = {
    Text = "ファロスの霊知啓発6を獲得する"
  },
  Task_62269_UnlockCondDesc = {
    Text = "イベント@覚醒体ファロス霊知啓発ギフト2"
  },
  Task_62270_Desc = {
    Text = "タヴィの霊知啓発2を獲得する"
  },
  Task_62270_Name = {
    Text = "タヴィの霊知啓発2を獲得する"
  },
  Task_62270_UnlockCondDesc = {
    Text = "イベント@覚醒体タヴィ霊知啓発ギフト1"
  },
  Task_62271_Desc = {
    Text = "ファイントの霊知啓発6を獲得する"
  },
  Task_62271_Name = {
    Text = "ファイントの霊知啓発6を獲得する"
  },
  Task_62271_UnlockCondDesc = {
    Text = "イベント@覚醒体ファイント霊知啓発ギフト2"
  },
  Task_62272_Desc = {
    Text = "ソレールの霊知啓発6を獲得する"
  },
  Task_62272_Name = {
    Text = "ソレールの霊知啓発6を獲得する"
  },
  Task_62272_UnlockCondDesc = {
    Text = "イベント@覚醒体ソレール霊知啓発ギフト2"
  },
  Task_62273_Desc = {
    Text = "サンガーの霊知啓発2を獲得する"
  },
  Task_62273_Name = {
    Text = "サンガーの霊知啓発2を獲得する"
  },
  Task_62273_UnlockCondDesc = {
    Text = "イベント@覚醒体サンガー霊知啓発ギフト1"
  },
  Task_62274_Desc = {
    Text = "ゴリアテの霊知啓発2を獲得する"
  },
  Task_62274_Name = {
    Text = "ゴリアテの霊知啓発2を獲得する"
  },
  Task_62274_UnlockCondDesc = {
    Text = "イベント@覚醒体ゴリアテ霊知啓発ギフト1"
  },
  Task_62275_Desc = {
    Text = "ミリアムの霊知啓発2を獲得する"
  },
  Task_62275_Name = {
    Text = "ミリアムの霊知啓発2を獲得する"
  },
  Task_62275_UnlockCondDesc = {
    Text = "イベント@覚醒体ミリアム霊知啓発ギフト1"
  },
  Task_62276_Desc = {
    Text = "ウインクルの霊知啓発6を獲得する"
  },
  Task_62276_Name = {
    Text = "ウインクルの霊知啓発6を獲得する"
  },
  Task_62276_UnlockCondDesc = {
    Text = "イベント@覚醒体ウインクル霊知啓発ギフト2"
  },
  Task_62277_Desc = {
    Text = "カエクスの霊知啓発2を獲得する"
  },
  Task_62277_Name = {
    Text = "カエクスの霊知啓発2を獲得する"
  },
  Task_62277_UnlockCondDesc = {
    Text = "イベント@覚醒体カエクス霊知啓発ギフト1"
  },
  Task_62278_Desc = {
    Text = "ミリアムの霊知啓発6を獲得する"
  },
  Task_62278_Name = {
    Text = "ミリアムの霊知啓発6を獲得する"
  },
  Task_62278_UnlockCondDesc = {
    Text = "イベント@覚醒体ミリアム霊知啓発ギフト2"
  },
  Task_62279_Desc = {
    Text = "ウインクルの霊知啓発2を獲得する"
  },
  Task_62279_Name = {
    Text = "ウインクルの霊知啓発2を獲得する"
  },
  Task_62279_UnlockCondDesc = {
    Text = "イベント@覚醒体ウインクル霊知啓発ギフト1"
  },
  Task_62280_Desc = {
    Text = "カエクスの霊知啓発6を獲得する"
  },
  Task_62280_Name = {
    Text = "カエクスの霊知啓発6を獲得する"
  },
  Task_62280_UnlockCondDesc = {
    Text = "イベント@覚醒体カエクス霊知啓発ギフト2"
  },
  Task_62281_Desc = {
    Text = "ナウティラの霊知啓発2を獲得する"
  },
  Task_62281_Name = {
    Text = "ナウティラの霊知啓発2を獲得する"
  },
  Task_62281_UnlockCondDesc = {
    Text = "イベント@覚醒体ナウティラ霊知啓発ギフト1"
  },
  Task_62282_Desc = {
    Text = "レーアの霊知啓発2を獲得する"
  },
  Task_62282_Name = {
    Text = "レーアの霊知啓発2を獲得する"
  },
  Task_62282_UnlockCondDesc = {
    Text = "イベント@覚醒体レーア霊知啓発ギフト1"
  },
  Task_62283_Desc = {
    Text = "シレストの霊知啓発2を獲得する"
  },
  Task_62283_Name = {
    Text = "シレストの霊知啓発2を獲得する"
  },
  Task_62283_UnlockCondDesc = {
    Text = "イベント@覚醒体シレスト霊知啓発ギフト1"
  },
  Task_62284_Desc = {
    Text = "カレンの霊知啓発2を獲得する"
  },
  Task_62284_Name = {
    Text = "カレンの霊知啓発2を獲得する"
  },
  Task_62284_UnlockCondDesc = {
    Text = "イベント@覚醒体カレン霊知啓発ギフト1"
  },
  Task_62285_Desc = {
    Text = "サンガーの霊知啓発6を獲得する"
  },
  Task_62285_Name = {
    Text = "サンガーの霊知啓発6を獲得する"
  },
  Task_62285_UnlockCondDesc = {
    Text = "イベント@覚醒体サンガー霊知啓発ギフト2"
  },
  Task_62286_Desc = {
    Text = "シレストの霊知啓発6を獲得する"
  },
  Task_62286_Name = {
    Text = "シレストの霊知啓発6を獲得する"
  },
  Task_62286_UnlockCondDesc = {
    Text = "イベント@覚醒体シレスト霊知啓発ギフト2"
  },
  Task_62287_Desc = {
    Text = "カレンの霊知啓発6を獲得する"
  },
  Task_62287_Name = {
    Text = "カレンの霊知啓発6を獲得する"
  },
  Task_62287_UnlockCondDesc = {
    Text = "イベント@覚醒体カレン霊知啓発ギフト2"
  },
  Task_62288_Desc = {
    Text = "ナウティラの霊知啓発6を獲得する"
  },
  Task_62288_Name = {
    Text = "ナウティラの霊知啓発6を獲得する"
  },
  Task_62288_UnlockCondDesc = {
    Text = "イベント@覚醒体ナウティラ霊知啓発ギフト2"
  },
  Task_62289_Desc = {
    Text = "マーフィーの霊知啓発6を獲得する"
  },
  Task_62289_Name = {
    Text = "マーフィーの霊知啓発6を獲得する"
  },
  Task_62289_UnlockCondDesc = {
    Text = "イベント@覚醒体マーフィー霊知啓発ギフト2"
  },
  Task_62290_Desc = {
    Text = "オルラの霊知啓発6を獲得する"
  },
  Task_62290_Name = {
    Text = "オルラの霊知啓発6を獲得する"
  },
  Task_62290_UnlockCondDesc = {
    Text = "イベント@覚醒体オルラ霊知啓発ギフト2"
  },
  Task_62291_Desc = {
    Text = "タイスの霊知啓発2を獲得する"
  },
  Task_62291_Name = {
    Text = "タイスの霊知啓発2を獲得する"
  },
  Task_62291_UnlockCondDesc = {
    Text = "イベント@覚醒体タイス霊知啓発ギフト1"
  },
  Task_62292_Desc = {
    Text = "アルバの霊知啓発6を獲得する"
  },
  Task_62292_Name = {
    Text = "アルバの霊知啓発6を獲得する"
  },
  Task_62292_UnlockCondDesc = {
    Text = "イベント@覚醒体アルバ霊知啓発ギフト2"
  },
  Task_62293_Desc = {
    Text = "アグリッパの霊知啓発2を獲得する"
  },
  Task_62293_Name = {
    Text = "アグリッパの霊知啓発2を獲得する"
  },
  Task_62293_UnlockCondDesc = {
    Text = "イベント@覚醒体アグリッパ霊知啓発ギフト1"
  },
  Task_62294_Desc = {
    Text = "リリーの霊知啓発2を獲得する"
  },
  Task_62294_Name = {
    Text = "リリーの霊知啓発2を獲得する"
  },
  Task_62294_UnlockCondDesc = {
    Text = "イベント@覚醒体リリー霊知啓発ギフト1"
  },
  Task_62295_Desc = {
    Text = "タイスの霊知啓発6を獲得する"
  },
  Task_62295_Name = {
    Text = "タイスの霊知啓発6を獲得する"
  },
  Task_62295_UnlockCondDesc = {
    Text = "イベント@覚醒体タイス霊知啓発ギフト2"
  },
  Task_62296_Desc = {
    Text = "アルバの霊知啓発2を獲得する"
  },
  Task_62296_Name = {
    Text = "アルバの霊知啓発2を獲得する"
  },
  Task_62296_UnlockCondDesc = {
    Text = "イベント@覚醒体アルバ霊知啓発ギフト1"
  },
  Task_62297_Desc = {
    Text = "ユウハシュの霊知啓発6を獲得する"
  },
  Task_62297_Name = {
    Text = "ユウハシュの霊知啓発6を獲得する"
  },
  Task_62297_UnlockCondDesc = {
    Text = "イベント@覚醒体ユウハシュ霊知啓発ギフト2"
  },
  Task_62298_Desc = {
    Text = "血ノ鎖・ヘロットの霊知啓発2を獲得する"
  },
  Task_62298_Name = {
    Text = "血ノ鎖・ヘロットの霊知啓発2を獲得する"
  },
  Task_62298_UnlockCondDesc = {
    Text = "イベント@覚醒体血ノ鎖・ヘロット霊知啓発ギフト1"
  },
  Task_62299_Desc = {
    Text = "血ノ鎖・ヘロットの霊知啓発6を獲得する"
  },
  Task_62299_Name = {
    Text = "血ノ鎖・ヘロットの霊知啓発6を獲得する"
  },
  Task_62299_UnlockCondDesc = {
    Text = "イベント@覚醒体血ノ鎖・ヘロット霊知啓発ギフト2"
  },
  Task_62300_Desc = {
    Text = "カーシアの霊知啓発6を獲得する"
  },
  Task_62300_Name = {
    Text = "カーシアの霊知啓発6を獲得する"
  },
  Task_62300_UnlockCondDesc = {
    Text = "イベント@覚醒体カーシア霊知啓発ギフト2"
  },
  Task_62320_Desc = {
    Text = "特務記録「雪山への帰還」高難度を完了"
  },
  Task_62320_Name = {
    Text = "命、山を破り出づる・高難度"
  },
  Task_62321_Desc = {
    Text = "調査「終末交響曲」高難度を完了する"
  },
  Task_62321_Name = {
    Text = "戦闘、記憶に名を刻むために・高難度"
  },
  Task_62322_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_62322_Desc2 = {
    Text = "調査「終末交響曲」を完了する"
  },
  Task_62322_Name2 = {
    Text = "戦闘、記憶に名を刻むために"
  },
  Task_62323_Desc = {
    Text = "調査「@1@2」で3回共鳴する"
  },
  Task_62323_Desc2 = {
    Text = "調査「終末交響曲」で3回共鳴する"
  },
  Task_62323_Name2 = {
    Text = "不屈の残響"
  },
  Task_62324_Desc = {
    Text = "特務記録「良き狩りを！」を完了"
  },
  Task_62324_Name = {
    Text = "運命の戯れ"
  },
  Task_62325_Desc = {
    Text = "調査「@1@2」で9回共鳴する"
  },
  Task_62325_Desc2 = {
    Text = "調査「終末交響曲」で9回共鳴する"
  },
  Task_62325_Name2 = {
    Text = "不屈の残響Ⅲ"
  },
  Task_62326_Desc = {
    Text = "メインストーリー第8章「@1@2」の黒い水たまりを10箇所見つける"
  },
  Task_62326_Desc2 = {
    Text = "メインストーリー第8章「終末交響曲」の黒い水たまりを10箇所見つける"
  },
  Task_62326_Name2 = {
    Text = "潜むささやきⅧ"
  },
  Task_62327_Desc = {
    Text = "特務記録「雪山への帰還」を完了"
  },
  Task_62327_Name = {
    Text = "命、山を破り出づる"
  },
  Task_62328_Desc = {
    Text = "特務記録「良き狩りを！」高難度を完了"
  },
  Task_62328_Name = {
    Text = "運命の戯れ・高難度"
  },
  Task_62329_Desc = {
    Text = "特務記録「薔薇の住処」を完了"
  },
  Task_62329_Name = {
    Text = "花と詩の残り香"
  },
  Task_62330_Desc = {
    Text = "調査「@1@2」で6回共鳴する"
  },
  Task_62330_Desc2 = {
    Text = "調査「終末交響曲」で6回共鳴する"
  },
  Task_62330_Name2 = {
    Text = "不屈の残響Ⅱ"
  },
  Task_62331_Desc = {
    Text = "調査「@1@2」で13回共鳴する"
  },
  Task_62331_Desc2 = {
    Text = "調査「終末交響曲」で13回共鳴する"
  },
  Task_62331_Name2 = {
    Text = "不屈の残響Ⅳ"
  },
  Task_62332_Desc = {
    Text = "特務記録「薔薇の住処」高難度を完了"
  },
  Task_62332_Name = {
    Text = "花と詩の残り香・高難度"
  },
  Task_62346_Desc = {
    Text = "ラモンナの助けを借りず、「終焉の忘却の理」を倒す。"
  },
  Task_62346_Name = {
    Text = "孤独の至高の威厳"
  },
  Task_62371_Desc = {
    Text = "ラモンナの助けで「忘れられた始まり」を倒す。"
  },
  Task_62371_Name = {
    Text = "私の手を握って、守秘者"
  },
  Task_65510_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_65511_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_65512_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_65513_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_65514_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_65515_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_65516_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_65517_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_65518_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_65519_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_65722_Desc = {
    Text = "血肉界域の覚醒体を使用し「記憶の収集」で1回勝利"
  },
  Task_65723_Desc = {
    Text = "「鏡」任意の難易度をクリア"
  },
  Task_65724_Desc = {
    Text = "超次元界域の覚醒体を使用し「記憶の収集」で1回勝利"
  },
  Task_65725_Desc = {
    Text = "記憶の収集・突破"
  },
  Task_65726_Desc = {
    Text = "記憶の収集・界域"
  },
  Task_65727_Desc = {
    Text = "「扁桃体」超難度をクリア"
  },
  Task_65728_Desc = {
    Text = "「忘却曲線」超難度をクリア"
  },
  Task_65729_Desc = {
    Text = "混沌界域の覚醒体を使用し「記憶の収集」で1回勝利"
  },
  Task_65730_Desc = {
    Text = "「扁桃体」任意の難易度をクリア"
  },
  Task_65731_Desc = {
    Text = "「扁桃体」任意の難易度をクリア"
  },
  Task_65732_Desc = {
    Text = "「鏡」任意の難易度をクリア"
  },
  Task_65733_Desc = {
    Text = "「忘却曲線」任意の難易度をクリア"
  },
  Task_65734_Desc = {
    Text = "「爬虫類脳」任意の難易度をクリア"
  },
  Task_65735_Desc = {
    Text = "「記憶の収集・突破」全任務を完了する"
  },
  Task_65736_Desc = {
    Text = "「忘却曲線」任意の難易度をクリア"
  },
  Task_65737_Desc = {
    Text = "「無意識の記憶」任意の難易度をクリア"
  },
  Task_65738_Desc = {
    Text = "「鏡子」超難度をクリア"
  },
  Task_65739_Desc = {
    Text = "記憶の収集・超難度"
  },
  Task_65740_Desc = {
    Text = "「無意識の記憶」任意の難易度をクリア"
  },
  Task_65741_Desc = {
    Text = "特務記録「静かな分裂」をクリア"
  },
  Task_65742_Desc = {
    Text = "「無意識の記憶」超難度をクリア"
  },
  Task_65743_Desc = {
    Text = "「爬虫類脳」任意の難易度をクリア"
  },
  Task_65744_Desc = {
    Text = "「爬虫類脳」超難度をクリア"
  },
  Task_65745_Desc = {
    Text = "深海界域の覚醒体を使用し「記憶の収集」で1回勝利"
  },
  Task_66015_Desc = {
    Text = "タヴィの同調率がレベル10に到達する"
  },
  Task_66213_Desc = {
    Text = "神国の降臨・狂気"
  },
  Task_66214_Desc = {
    Text = "超次元界域の覚醒体を使用し「神国の降臨」で1回勝利"
  },
  Task_66215_Desc = {
    Text = "「証明」任意の難易度をクリア"
  },
  Task_66216_Desc = {
    Text = "「動揺」超難度をクリア"
  },
  Task_66217_Desc = {
    Text = "「降臨」任意の難易度をクリア"
  },
  Task_66218_Desc = {
    Text = "「信仰」超難度をクリア"
  },
  Task_66219_Desc = {
    Text = "混沌界域の覚醒体を使用し「神国の降臨」で1回勝利"
  },
  Task_66220_Desc = {
    Text = "「信仰」任意の難易度をクリア"
  },
  Task_66221_Desc = {
    Text = "「証明」任意の難易度をクリア"
  },
  Task_66224_Desc = {
    Text = "「疑問」任意の難易度をクリア"
  },
  Task_66227_Desc = {
    Text = "異夢視界「冒涜」をクリア"
  },
  Task_66228_Desc = {
    Text = "「神国の降臨・突破」全任務を完了する"
  },
  Task_66229_Desc = {
    Text = "「証明」超難度をクリア"
  },
  Task_66230_Desc = {
    Text = "深海界域の覚醒体を使用し「神国の降臨」で1回勝利"
  },
  Task_66231_Desc = {
    Text = "「降臨」超難度をクリア"
  },
  Task_66232_Desc = {
    Text = "神国の降臨・界域"
  },
  Task_66233_Desc = {
    Text = "「動揺」任意の難易度をクリア"
  },
  Task_66235_Desc = {
    Text = "「疑問」超難度をクリア"
  },
  Task_66236_Desc = {
    Text = "血肉界域の覚醒体を使用し「神国の降臨」で1回勝利"
  },
  Task_66237_Desc = {
    Text = "「降臨」任意の難易度をクリア"
  },
  Task_66238_Desc = {
    Text = "「動揺」任意の難易度をクリア"
  },
  Task_66240_Desc = {
    Text = "神国の降臨・突破"
  },
  Task_66241_Desc = {
    Text = "「信仰」任意の難易度をクリア"
  },
  Task_66242_Desc = {
    Text = "「疑問」任意の難易度をクリア"
  },
  Task_66243_Desc = {
    Text = "深淵の応答"
  },
  Task_66335_Desc = {
    Text = "審査会の追撃から逃れる"
  },
  Task_66335_Name = {Text = "目標"},
  Task_66336_Desc = {
    Text = "人面犬の密告を阻止"
  },
  Task_66336_Name = {Text = "目標"},
  Task_66337_Desc = {
    Text = "審査会の封鎖を突破"
  },
  Task_66337_Name = {Text = "目標"},
  Task_66338_Desc = {
    Text = "タイスを討伐"
  },
  Task_66338_Name = {Text = "目標"},
  Task_66339_Desc = {Text = "Nを撃破"},
  Task_66339_Name = {Text = "目標"},
  Task_66340_Desc = {
    Text = "審査会の侵入を阻止"
  },
  Task_66340_Name = {Text = "目標"},
  Task_66341_Desc = {
    Text = "双神像を破壊"
  },
  Task_66341_Name = {Text = "目標"},
  Task_66342_Desc = {
    Text = "ハムリンを阻止"
  },
  Task_66342_Name = {Text = "目標"},
  Task_66343_Desc = {
    Text = "タヴィを見つけろ"
  },
  Task_66343_Name = {Text = "目標"},
  Task_66344_Desc = {
    Text = "ジュリエットを阻止"
  },
  Task_66344_Name = {Text = "目標"},
  Task_66422_Name = {
    Text = "BOSS1をN回撃破"
  },
  Task_66423_Name = {
    Text = "BOSS2をN回撃破"
  },
  Task_66424_Name = {
    Text = "BOSS3をN回撃破"
  },
  Task_66425_Name = {
    Text = "BOSS4をN回撃破"
  },
  Task_66426_Name = {
    Text = "BOSS5をN回撃破"
  },
  Task_66428_Name = {
    Text = "すべてのBOSSを撃破"
  },
  Task_66580_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_66580_Name = {
    Text = "完璧な通過"
  },
  Task_66581_Desc = {
    Text = "クリア時、遺物を8個以上所持"
  },
  Task_66581_Name = {
    Text = "伏兵の宝物"
  },
  Task_66582_Desc = {
    Text = "最終戦で25ターン以内に勝利"
  },
  Task_66582_Name = {Text = "速攻"},
  Task_66583_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_66583_Name = {
    Text = "優雅で正確"
  },
  Task_66584_Desc = {
    Text = "クリア時、遺物を8個以上所持"
  },
  Task_66584_Name = {
    Text = "伏兵の宝物"
  },
  Task_66585_Desc = {
    Text = "最終戦で1ターンに最低200000ダメージを与える"
  },
  Task_66585_Name = {
    Text = "全力一撃"
  },
  Task_66724_Desc = {
    Text = "「旅立ち」超難度をクリア"
  },
  Task_66725_Desc = {
    Text = "「諸世の門」超難度をクリア"
  },
  Task_66726_Desc = {
    Text = "「知行の門」超難度をクリア"
  },
  Task_66727_Desc = {
    Text = "「窮地の門」任意の難易度をクリア"
  },
  Task_66728_Desc = {
    Text = "「是非の門」超難度をクリア"
  },
  Task_66729_Desc = {
    Text = "「一体の門」任意の難易度をクリア"
  },
  Task_66730_Desc = {
    Text = "「旅立ち」任意の難易度をクリア"
  },
  Task_66731_Desc = {
    Text = "「是非の門」任意の難易度をクリア"
  },
  Task_66732_Desc = {
    Text = "「扉の内」超難度をクリア"
  },
  Task_66733_Desc = {
    Text = "深海界域の覚醒体を使用し「最終テスト」で1回勝利"
  },
  Task_66734_Desc = {
    Text = "超次元界域の覚醒体を使用し「最終テスト」で2回勝利"
  },
  Task_66735_Desc = {
    Text = "深海界域の覚醒体を使用し「最終テスト」で2回勝利"
  },
  Task_66736_Desc = {
    Text = "超次元界域の覚醒体を使用し「最終テスト」で1回勝利"
  },
  Task_66737_Desc = {
    Text = "「是非の門」任意の難易度をクリア"
  },
  Task_66738_Desc = {
    Text = "「知行の門」任意の難易度をクリア"
  },
  Task_66739_Desc = {
    Text = "最終テスト・超難度"
  },
  Task_66740_Desc = {
    Text = "「知行の門」任意の難易度をクリア"
  },
  Task_66741_Desc = {
    Text = "「諸世の門」任意の難易度をクリア"
  },
  Task_66742_Desc = {
    Text = "「窮地の門」任意の難易度をクリア"
  },
  Task_66743_Desc = {
    Text = "「扉の内」任意の難易度をクリア"
  },
  Task_66744_Desc = {
    Text = "最終テスト・突破"
  },
  Task_66745_Desc = {
    Text = "血肉界域の覚醒体を使用し「最終テスト」で2回勝利"
  },
  Task_66746_Desc = {
    Text = "血肉界域の覚醒体を使用し「最終テスト」で1回勝利"
  },
  Task_66747_Desc = {
    Text = "「理性の門」超難度をクリア"
  },
  Task_66748_Desc = {
    Text = "「一体の門」超難度をクリア"
  },
  Task_66749_Desc = {
    Text = "「旅立ち」任意の難易度をクリア"
  },
  Task_66750_Desc = {
    Text = "混沌界域の覚醒体を使用し「最終テスト」で2回勝利"
  },
  Task_66751_Desc = {
    Text = "混沌界域の覚醒体を使用し「最終テスト」で1回勝利"
  },
  Task_66752_Desc = {
    Text = "「扉の内」任意の難易度をクリア"
  },
  Task_66753_Desc = {
    Text = "「本性の門」任意の難易度をクリア"
  },
  Task_66754_Desc = {
    Text = "「本性の門」超難度をクリア"
  },
  Task_66755_Desc = {
    Text = "「窮地の門」超難度をクリア"
  },
  Task_66756_Desc = {
    Text = "最終テスト・界域"
  },
  Task_66757_Desc = {
    Text = "「最終テスト・突破」全任務を完了する"
  },
  Task_66758_Desc = {
    Text = "「理性の門」任意の難易度をクリア"
  },
  Task_66759_Desc = {
    Text = "「本性の門」任意の難易度をクリア"
  },
  Task_66760_Desc = {
    Text = "「諸世の門」任意の難易度をクリア"
  },
  Task_66761_Desc = {
    Text = "「理性の門」任意の難易度をクリア"
  },
  Task_66762_Desc = {
    Text = "「一体の門」任意の難易度をクリア"
  },
  Task_67066_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_67067_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_67068_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_67069_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_67070_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_67071_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_67072_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_67073_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_67075_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_67076_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_67113_Desc = {
    Text = "メインストーリーの終章「@1@2」の黒い水たまりを2か所見つける"
  },
  Task_67113_Desc2 = {
    Text = "メインストーリーの終章「長き夢の尽きる時」の黒い水たまりを2か所見つける"
  },
  Task_67113_Name2 = {
    Text = "潜伏する囁きⅨ"
  },
  Task_67114_Desc = {
    Text = "調査「長き夢の尽きる時」高難度を完了する"
  },
  Task_67114_Name = {
    Text = "守り続ける、死ぬまで・高難度"
  },
  Task_67115_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_67115_Desc2 = {
    Text = "調査「長き夢の尽きる時」を完了する"
  },
  Task_67115_Name2 = {
    Text = "守り続ける、死ぬまで"
  },
  Task_67116_Desc = {
    Text = "調査「@1@2」で3回共鳴する"
  },
  Task_67116_Desc2 = {
    Text = "調査「長き夢の尽きる時」で3回共鳴する"
  },
  Task_67116_Name2 = {
    Text = "極限の残響"
  },
  Task_67125_Name = {
    Text = "BOSS6をN回撃破"
  },
  Task_67126_Name = {
    Text = "BOSS7をN回撃破"
  },
  Task_67408_Desc = {
    Text = "トオワボを阻止し、扉を閉じる"
  },
  Task_67408_Name = {Text = "目標"},
  Task_67409_Desc = {
    Text = "ミサゴの内通者を見つける"
  },
  Task_67409_Name = {Text = "目標"},
  Task_67410_Desc = {
    Text = "トオワボを阻止"
  },
  Task_67410_Name = {Text = "目標"},
  Task_67411_Desc = {
    Text = "覚醒体たちと別れを告げる"
  },
  Task_67411_Name = {Text = "目標"},
  Task_67827_Desc = {
    Text = "服従せよ……この永遠なる混沌の真実に……"
  },
  Task_67827_Name = {
    Text = "服従せよ……この永遠なる混沌の真実に……"
  },
  Task_67828_Desc = {
    Text = "彼の神の痴愚なること、抗うこと能わず。"
  },
  Task_67828_Name = {
    Text = "彼の神の痴愚なること、抗うこと能わず。"
  },
  Task_67829_Desc = {
    Text = "彼の神の威容なること、直視すること能わず。"
  },
  Task_67829_Name = {
    Text = "彼の神の威容なること、直視すること能わず。"
  },
  Task_67919_Desc = {
    Text = "『ソナニール号・狂気の視線』のすべての分身を排除した時、解放"
  },
  Task_67919_Name = {
    Text = "BOSS6を撃破"
  },
  Task_67920_Desc = {
    Text = "『蝋人形館・恐怖の視線』のすべての分身を排除した時、解放"
  },
  Task_67920_Name = {
    Text = "BOSS2を撃破"
  },
  Task_67921_Desc = {
    Text = "『療養所・異常の視線』のすべての分身を排除した時、解放"
  },
  Task_67921_Name = {
    Text = "BOSS4を撃破"
  },
  Task_67922_Desc = {
    Text = "『ブリルポート・邪信の視線』のすべての分身を排除した時、解放"
  },
  Task_67922_Name = {
    Text = "BOSS5を撃破"
  },
  Task_67923_Desc = {
    Text = "『ワークハウス・悲嘆の視線』のすべての分身を排除した時、解放"
  },
  Task_67923_Name = {
    Text = "BOSS1を撃破"
  },
  Task_67924_Desc = {
    Text = "『ヴォルムワヒ・顕現の視線』のすべての分身を排除した時、解放"
  },
  Task_67924_Name = {
    Text = "BOSS7を撃破"
  },
  Task_67925_Desc = {
    Text = "『ライ・刺心の視線』のすべての分身を排除した時、解放"
  },
  Task_67925_Name = {
    Text = "BOSS3を撃破"
  },
  Task_67926_Name = {
    Text = "5つの原初の視線のすべての分身を撃破"
  },
  Task_67927_Name = {
    Text = "2つの原初の視線のすべての分身を撃破"
  },
  Task_67928_Name = {
    Text = "4つの原初の視線のすべての分身を撃破"
  },
  Task_67929_Name = {
    Text = "6つの原初の視線のすべての分身を撃破"
  },
  Task_67930_Name = {
    Text = "1つの原初の視線のすべての分身を撃破"
  },
  Task_67931_Name = {
    Text = "7つの原初の視線のすべての分身を撃破"
  },
  Task_67932_Name = {
    Text = "3つの原初の視線のすべての分身を撃破"
  },
  Task_68342_Desc = {
    Text = "星辰を超えてⅢ"
  },
  Task_68343_Desc = {
    Text = "星辰を超えてⅤ"
  },
  Task_68344_Desc = {
    Text = "星辰を超えてⅦ"
  },
  Task_68345_Desc = {
    Text = "星辰を超えてⅡ"
  },
  Task_68346_Desc = {
    Text = "星辰を超えてⅣ"
  },
  Task_68347_Desc = {
    Text = "星辰を超えてⅠ"
  },
  Task_68348_Desc = {
    Text = "星辰を超えてⅥ"
  },
  Task_68365_Desc = {
    Text = "星辰を超えて・無料"
  },
  Task_68377_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68378_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68379_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68380_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68382_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68383_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68384_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68385_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68386_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68387_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68388_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68389_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68390_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68391_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68392_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68393_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68394_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68395_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68396_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68397_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_68418_Name = {
    Text = "ワールドBOSSイベント終了"
  },
  Task_68492_Desc = {
    Text = "深海界域の覚醒体を使用し「深海凝視」で1回勝利"
  },
  Task_68493_Desc = {
    Text = "「神の目」を超難度でクリア"
  },
  Task_68494_Desc = {
    Text = "超次元界域の覚醒体を使用し「深海凝視」で1回勝利"
  },
  Task_68495_Desc = {
    Text = "「素晴らしき幻想」を任意の難易度でクリア"
  },
  Task_68496_Desc = {
    Text = "「素晴らしき幻想」を超難度でクリア"
  },
  Task_68497_Desc = {
    Text = "「人間性の崩壊」を任意の難易度でクリア"
  },
  Task_68498_Desc = {
    Text = "「人間性の崩壊」を超難度でクリア"
  },
  Task_68499_Desc = {
    Text = "血肉界域の覚醒体を使用し「深海凝視」で1回勝利"
  },
  Task_68500_Desc = {
    Text = "「神の目」を任意の難易度でクリア"
  },
  Task_68501_Desc = {
    Text = "「人間性の崩壊」を任意の難易度でクリア"
  },
  Task_68502_Desc = {
    Text = "「郷愁」を任意の難易度でクリア"
  },
  Task_68503_Desc = {
    Text = "混沌界域の覚醒体を使用し「深海凝視」で1回勝利"
  },
  Task_68504_Desc = {
    Text = "深海凝視・超難度"
  },
  Task_68505_Desc = {
    Text = "「素晴らしき幻想」を任意の難易度でクリア"
  },
  Task_68506_Desc = {
    Text = "「衰亡の国」を任意の難易度でクリア"
  },
  Task_68507_Desc = {
    Text = "深海凝視・突破"
  },
  Task_68508_Desc = {
    Text = "「郷愁」を任意の難易度でクリア"
  },
  Task_68509_Desc = {
    Text = "「郷愁」を超難度でクリア"
  },
  Task_68510_Desc = {
    Text = "「衰亡の国」を任意の難易度でクリア"
  },
  Task_68511_Desc = {
    Text = "「衰亡の国」を超難度でクリア"
  },
  Task_68512_Desc = {
    Text = "深海凝視・界域"
  },
  Task_68513_Desc = {
    Text = "「深海凝視・突破」のすべての任務を完了する"
  },
  Task_68514_Desc = {
    Text = "「神の目」を任意の難易度でクリア"
  },
  Task_68860_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_68860_Name = {Text = "1勝"},
  Task_68861_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_68861_Name = {Text = "6勝"},
  Task_68862_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_68862_Name = {Text = "3勝"},
  Task_68863_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_68863_Name = {Text = "10勝"},
  Task_68864_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_68864_Name = {Text = "3勝"},
  Task_68865_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_68865_Name = {Text = "6勝"},
  Task_68866_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_68866_Name = {Text = "1勝"},
  Task_68867_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_68867_Name = {Text = "10勝"},
  Task_69819_Desc = {
    Text = "最終戦で35ターン以内に勝利"
  },
  Task_69819_Name = {
    Text = "最終戦で35ターン以内に勝利"
  },
  Task_70112_Desc = {
    Text = "深海界域の覚醒体を使用し「波乱の情欲」で1回勝利"
  },
  Task_70113_Desc = {
    Text = "「年輪」を超難度でクリア"
  },
  Task_70114_Desc = {
    Text = "深海界域の覚醒体を使用し「波乱の情欲」で2回勝利"
  },
  Task_70115_Desc = {
    Text = "「幼根」任意の難易度をクリア"
  },
  Task_70116_Desc = {
    Text = "「受粉」任意の難易度をクリア"
  },
  Task_70117_Desc = {
    Text = "「幼根」を超難度でクリア"
  },
  Task_70118_Desc = {
    Text = "「発芽」任意の難易度をクリア"
  },
  Task_70119_Desc = {
    Text = "超次元界域の覚醒体を使用し「波乱の情欲」で1回勝利"
  },
  Task_70120_Desc = {
    Text = "超次元界域の覚醒体を使用し「波乱の情欲」で2回勝利"
  },
  Task_70121_Desc = {
    Text = "波乱の情欲・超難度"
  },
  Task_70122_Desc = {
    Text = "「落果」を超難度でクリア"
  },
  Task_70123_Desc = {
    Text = "波乱の情欲・界域"
  },
  Task_70124_Desc = {
    Text = "「受粉」を超難度でクリア"
  },
  Task_70125_Desc = {
    Text = "「花のウテナ」を超難度でクリア"
  },
  Task_70126_Desc = {
    Text = "「再生花」任意の難易度をクリア"
  },
  Task_70127_Desc = {
    Text = "「再生花」を超難度でクリア"
  },
  Task_70128_Desc = {
    Text = "「発芽」を超難度でクリア"
  },
  Task_70129_Desc = {
    Text = "「蜜腺」任意の難易度をクリア"
  },
  Task_70130_Desc = {
    Text = "「年輪」任意の難易度をクリア"
  },
  Task_70131_Desc = {
    Text = "「胚珠」任意の難易度をクリア"
  },
  Task_70132_Desc = {
    Text = "「落果」任意の難易度をクリア"
  },
  Task_70133_Desc = {
    Text = "「胚珠」を超難度でクリア"
  },
  Task_70134_Desc = {
    Text = "混沌界域の覚醒体を使用し「波乱の情欲」で2回勝利"
  },
  Task_70135_Desc = {
    Text = "「花のウテナ」任意の難易度をクリア"
  },
  Task_70136_Desc = {
    Text = "混沌界域の覚醒体を使用し「波乱の情欲」で1回勝利"
  },
  Task_70137_Desc = {
    Text = "血肉界域の覚醒体を使用し「波乱の情欲」で2回勝利"
  },
  Task_70138_Desc = {
    Text = "「多胚生殖」を超難度でクリア"
  },
  Task_70139_Desc = {
    Text = "血肉界域の覚醒体を使用し「波乱の情欲」で1回勝利"
  },
  Task_70140_Desc = {
    Text = "「多胚生殖」任意の難易度をクリア"
  },
  Task_70141_Desc = {
    Text = "「蜜腺」を超難度でクリア"
  },
  Task_70307_Desc = {
    Text = "最終戦で40ターン以内に勝利"
  },
  Task_70307_Name = {
    Text = "最終戦で40ターン以内に勝利"
  },
  Task_70446_Name = {
    Text = "8-8を再クリア"
  },
  Task_70447_Name = {
    Text = "8-4を再クリア"
  },
  Task_70448_Name = {
    Text = "ライカーのサブステージの通常12を再クリア"
  },
  Task_70449_Name = {
    Text = "エリカのサブステージの通常3を再クリア"
  },
  Task_70450_Name = {
    Text = "3-14を再クリア"
  },
  Task_70451_Name = {
    Text = "サンガーのサブステージの通常4を再クリア"
  },
  Task_70452_Name = {
    Text = "オルラのサブステージの通常9を再クリア"
  },
  Task_70453_Name = {
    Text = "オジールのサブステージの通常4を再クリア"
  },
  Task_70454_Name = {
    Text = "2-16を再クリア"
  },
  Task_70455_Name = {
    Text = "2-15を再クリア"
  },
  Task_70456_Name = {
    Text = "オレッタのサブステージの通常3を再クリア"
  },
  Task_70457_Name = {
    Text = "「24」のサブステージの通常10を再クリア"
  },
  Task_70458_Name = {
    Text = "ダフォダイルのサブステージの通常10を再クリア"
  },
  Task_70459_Name = {
    Text = "アグリッパのサブステージの通常5を再クリア"
  },
  Task_70460_Name = {
    Text = "6-8を再クリア"
  },
  Task_70461_Name = {
    Text = "8-14を再クリア"
  },
  Task_70462_Name = {
    Text = "ソレールのサブステージの通常13を再クリア"
  },
  Task_70463_Name = {
    Text = "ミリアムのサブステージの通常15を再クリア"
  },
  Task_70464_Name = {
    Text = "8-7を再クリア"
  },
  Task_70465_Name = {
    Text = "7-2を再クリア"
  },
  Task_70466_Name = {
    Text = "7-3を再クリア"
  },
  Task_70467_Name = {
    Text = "7-1を再クリア"
  },
  Task_70468_Name = {
    Text = "リリーのサブステージの通常7を再クリア"
  },
  Task_70469_Name = {
    Text = "環行・ラモンナのサブステージの通常4を再クリア"
  },
  Task_70470_Name = {
    Text = "1-8を再クリア"
  },
  Task_70471_Name = {
    Text = "血ノ鎖・ヘロットのサブステージの通常9を再クリア"
  },
  Task_70472_Name = {
    Text = "4-16を再クリア"
  },
  Task_70473_Name = {
    Text = "1-14を再クリア"
  },
  Task_70474_Name = {
    Text = "4-13を再クリア"
  },
  Task_70475_Name = {
    Text = "1-15を再クリア"
  },
  Task_70476_Name = {
    Text = "9-13を再クリア"
  },
  Task_70477_Name = {
    Text = "3-2を再クリア"
  },
  Task_70478_Name = {
    Text = "3-3を再クリア"
  },
  Task_70479_Name = {
    Text = "ユウハシュのサブステージの通常4を再クリア"
  },
  Task_70480_Name = {
    Text = "6-15を再クリア"
  },
  Task_70481_Name = {
    Text = "ゴリアテのサブステージの通常3を再クリア"
  },
  Task_70482_Name = {
    Text = "5-12を再クリア"
  },
  Task_70483_Name = {
    Text = "6-10を再クリア"
  },
  Task_70484_Name = {
    Text = "サルバドルのサブステージの通常9を再クリア"
  },
  Task_70485_Name = {
    Text = "ワンダのサブステージの通常4を再クリア"
  },
  Task_70941_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_70941_Name = {Text = "速攻"},
  Task_70942_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_70942_Name = {
    Text = "優雅で正確"
  },
  Task_70943_Desc = {
    Text = "最終戦で1ターンに追加で最低5枚のカードを引く"
  },
  Task_70943_Name = {
    Text = "ドロー！"
  },
  Task_70944_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_70944_Name = {
    Text = "省エネ主義"
  },
  Task_70945_Desc = {
    Text = "刻印を最低1つ獲得"
  },
  Task_70945_Name = {
    Text = "霊魂烙印"
  },
  Task_70946_Desc = {
    Text = "クリア時のライフが50%以上"
  },
  Task_70946_Name = {
    Text = "優雅で正確"
  },
  Task_70947_Desc = {
    Text = "クリア時、高級遺物を1個以上所持"
  },
  Task_70947_Name = {
    Text = "伏兵の宝物"
  },
  Task_70948_Desc = {
    Text = "クリア時の症状が2枚以下"
  },
  Task_70948_Name = {
    Text = "省エネ主義"
  },
  Task_70949_Desc = {
    Text = "クリア時、遺物を2個以上所持"
  },
  Task_70949_Name = {
    Text = "伏兵の宝物"
  },
  Task_70950_Desc = {
    Text = "クリア時、高級遺物を1個以上所持"
  },
  Task_70950_Name = {
    Text = "伏兵の宝物"
  },
  Task_70951_Desc = {
    Text = "最終戦で1ターン中カード5枚以上使用"
  },
  Task_70951_Name = {
    Text = "私のターン"
  },
  Task_70952_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_70952_Name = {Text = "速攻"},
  Task_70953_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_70953_Name = {Text = "速攻"},
  Task_70954_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_70954_Name = {Text = "速攻"},
  Task_70955_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_70955_Name = {Text = "速攻"},
  Task_70956_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_70956_Name = {Text = "速攻"},
  Task_70957_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_70957_Name = {Text = "速攻"},
  Task_70958_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_70958_Name = {Text = "速攻"},
  Task_70959_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_70959_Name = {Text = "速攻"},
  Task_70960_Desc = {
    Text = "最終戦で10ターン以内に勝利"
  },
  Task_70960_Name = {Text = "速攻"},
  Task_71343_Desc = {
    Text = "「狂災」を超難度でクリア"
  },
  Task_71344_Desc = {
    Text = "混沌界域の覚醒体を使用し「虚無の門」で1回勝利"
  },
  Task_71345_Desc = {
    Text = "混沌界域の覚醒体を使用し「虚無の門」で2回勝利"
  },
  Task_71346_Desc = {
    Text = "「輝かしい消滅」を任意の難易度でクリア"
  },
  Task_71347_Desc = {
    Text = "「狂災」を任意の難易度でクリア"
  },
  Task_71348_Desc = {
    Text = "「混沌の予言」を任意の難易度でクリア"
  },
  Task_71349_Desc = {
    Text = "虚無の扉・界域"
  },
  Task_71350_Desc = {
    Text = "「人形の家」を任意の難易度でクリア"
  },
  Task_71351_Desc = {
    Text = "「星」を超難度でクリア"
  },
  Task_71352_Desc = {
    Text = "「狂災」を任意の難易度でクリア"
  },
  Task_71353_Desc = {
    Text = "「輝かしい消滅」を任意の難易度でクリア"
  },
  Task_71354_Desc = {
    Text = "「狂騒舞踏会」を任意の難易度でクリア"
  },
  Task_71355_Desc = {
    Text = "虚無の扉・狂気"
  },
  Task_71356_Desc = {
    Text = "「操りの線」を任意の難易度でクリア"
  },
  Task_71357_Desc = {
    Text = "「真実の毒」を任意の難易度でクリア"
  },
  Task_71358_Desc = {
    Text = "「操りの線」を超難度でクリア"
  },
  Task_71359_Desc = {
    Text = "血肉界域の覚醒体を使用し「虚無の門」で2回勝利"
  },
  Task_71360_Desc = {
    Text = "「混沌の予言」を任意の難易度でクリア"
  },
  Task_71361_Desc = {
    Text = "「招待」を超難度でクリア"
  },
  Task_71362_Desc = {
    Text = "超次元界域の覚醒体を使用し「虚無の扉」で2回勝利"
  },
  Task_71363_Desc = {
    Text = "超次元界域の覚醒体を使用し「虚無の扉」で1回勝利"
  },
  Task_71364_Desc = {
    Text = "虚無の扉・突破"
  },
  Task_71365_Desc = {
    Text = "「虚無の門・突破」のすべての実績を達成"
  },
  Task_71366_Desc = {
    Text = "「輝かしい消滅」を超難度でクリア"
  },
  Task_71367_Desc = {
    Text = "「真実の毒」を超難度でクリア"
  },
  Task_71368_Desc = {
    Text = "「操りの線」を任意の難易度でクリア"
  },
  Task_71369_Desc = {
    Text = "血肉界域の覚醒体を使用し「虚無の門」で1回勝利"
  },
  Task_71370_Desc = {
    Text = "「人形の家」を超難度でクリア"
  },
  Task_71373_Desc = {
    Text = "「星」を任意の難易度でクリア"
  },
  Task_71374_Desc = {
    Text = "深海界域の覚醒体を使用し「虚無の扉」で2回勝利"
  },
  Task_71375_Desc = {
    Text = "深海界域の覚醒体を使用し「虚無の扉」で1回勝利"
  },
  Task_71376_Desc = {
    Text = "「狂騒舞踏会」を任意の難易度でクリア"
  },
  Task_71377_Desc = {
    Text = "「人形の家」を任意の難易度でクリア"
  },
  Task_71378_Desc = {
    Text = "「星」を任意の難易度でクリア"
  },
  Task_71379_Desc = {
    Text = "「招待」を任意の難易度でクリア"
  },
  Task_71380_Desc = {
    Text = "「混沌の予言」を超難度でクリア"
  },
  Task_71381_Desc = {
    Text = "「狂騒舞踏会」を超難度でクリア"
  },
  Task_71382_Desc = {
    Text = "「真実の毒」を任意の難易度でクリア"
  },
  Task_71385_Desc = {
    Text = "「招待」を任意の難易度でクリア"
  },
  Task_71757_Desc = {
    Text = "「仮面喜劇」の超難度をクリア"
  },
  Task_71758_Desc = {
    Text = "「プロットの転換」任意の難易度をクリア"
  },
  Task_71759_Desc = {
    Text = "「静寂の瞬間」の超難度をクリア"
  },
  Task_71760_Desc = {
    Text = "「静寂の瞬間」任意の難易度をクリア"
  },
  Task_71761_Desc = {
    Text = "「カタルシス」の超難度をクリア"
  },
  Task_71762_Desc = {
    Text = "「劇中人物論」任意の難易度をクリア"
  },
  Task_71763_Desc = {
    Text = "「プロットの転換」の超難度をクリア"
  },
  Task_71764_Desc = {
    Text = "「異化効果」の超難度をクリア"
  },
  Task_71765_Desc = {
    Text = "「三位一体」の超難度をクリア"
  },
  Task_71766_Desc = {
    Text = "「三位一体」任意の難易度をクリア"
  },
  Task_71767_Desc = {
    Text = "「カタルシス」任意の難易度をクリア"
  },
  Task_71768_Desc = {
    Text = "「仮面喜劇」任意の難易度をクリア"
  },
  Task_71769_Desc = {
    Text = "「演劇の第四の壁」の超難度をクリア"
  },
  Task_71770_Desc = {
    Text = "「演劇の第四の壁」任意の難易度をクリア"
  },
  Task_71771_Desc = {
    Text = "「異化効果」任意の難易度をクリア"
  },
  Task_71772_Desc = {
    Text = "「劇中人物論」の超難度をクリア"
  },
  Task_71773_Desc = {
    Text = "「劇作ピラミッド」の超難度をクリア"
  },
  Task_71774_Desc = {
    Text = "「劇作ピラミッド」任意の難易度をクリア"
  },
  Task_71775_Desc = {
    Text = "脚本の謎・超難度"
  },
  Task_71795_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71795_Name = {Text = "2800点"},
  Task_71796_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71796_Name = {Text = "2700点"},
  Task_71797_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71797_Name = {Text = "2900点"},
  Task_71798_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71798_Name = {Text = "2600点"},
  Task_71799_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71799_Name = {Text = "2300点"},
  Task_71800_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71800_Name = {Text = "2400点"},
  Task_71801_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71801_Name = {Text = "2500点"},
  Task_71802_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71802_Name = {Text = "1900点"},
  Task_71803_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71803_Name = {Text = "2000点"},
  Task_71804_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71804_Name = {Text = "2100点"},
  Task_71805_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71805_Name = {Text = "2200点"},
  Task_71806_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71806_Name = {Text = "3000点"},
  Task_71807_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71807_Name = {Text = "1600点"},
  Task_71808_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71808_Name = {Text = "1700点"},
  Task_71809_Desc = {
    Text = "対人戦最高到達ポイント"
  },
  Task_71809_Name = {Text = "1800点"},
  Task_71819_Desc = {
    Text = "「終曲」任意の難易度をクリア"
  },
  Task_71820_Desc = {
    Text = "「顔」任意の難易度をクリア"
  },
  Task_71821_Desc = {
    Text = "「あしながおじさん」任意の難易度をクリア"
  },
  Task_71822_Desc = {
    Text = "「視線」任意の難易度をクリア"
  },
  Task_71823_Desc = {
    Text = "「傀儡遊戯」任意の難易度をクリア"
  },
  Task_71824_Desc = {
    Text = "「未完の脚本」任意の難易度をクリア"
  },
  Task_71825_Desc = {
    Text = "「薔薇の棘」任意の難易度をクリア"
  },
  Task_71826_Desc = {
    Text = "「釜中の魚」任意の難易度をクリア"
  },
  Task_71827_Desc = {
    Text = "「贈り物」任意の難易度をクリア"
  },
  Task_71867_Desc = {
    Text = "5/6/7/8個の遺物を持つことで、250/500/750/1000点を獲得。"
  },
  Task_71867_Name = {
    Text = "真理の探索<size=20><color=#747474>8個の遺物を所有</color></size>"
  },
  Task_71868_Desc = {
    Text = "「肉体の記憶」使用ごとに、調査評価が20%減少。"
  },
  Task_71868_Name = {
    Text = "夢路の旅人<size=20><color=#747474>肉体の記憶使用ごとに、調査評価20%減少</color></size>"
  },
  Task_71934_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71935_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71936_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71937_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71939_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71940_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71941_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71942_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71943_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71944_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71945_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71946_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71947_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71948_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71949_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71950_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71952_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71953_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71954_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71955_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71977_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71978_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71980_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_71981_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_72038_Name = {
    Text = "トゥルーのサブステージの通常4を再クリア"
  },
  Task_72039_Desc = {
    Text = "「視線」の超難度をクリア"
  },
  Task_72040_Desc = {
    Text = "「釜中の魚」の超難度をクリア"
  },
  Task_72041_Desc = {
    Text = "「傀儡遊戯」の超難度をクリア"
  },
  Task_72042_Desc = {
    Text = "「贈り物」の超難度をクリア"
  },
  Task_72043_Desc = {
    Text = "特務記録「薔薇の讃歌」をクリア"
  },
  Task_72044_Desc = {
    Text = "「あしながおじさん」の超難度をクリア"
  },
  Task_72045_Desc = {
    Text = "「未完の脚本」の超難度をクリア"
  },
  Task_72046_Desc = {
    Text = "「薔薇の棘」の超難度をクリア"
  },
  Task_72047_Desc = {
    Text = "「顔」の超難度をクリア"
  },
  Task_72048_Desc = {
    Text = "「終曲」超難度をクリア"
  },
  Task_72049_Desc = {
    Text = "薔薇の記憶・超難度"
  },
  Task_72245_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72245_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72386_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72386_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72387_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72387_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72389_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72389_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72390_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72390_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72391_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72391_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72392_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72392_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72393_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72393_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72394_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72394_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72395_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72395_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72396_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72396_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72416_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72416_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72420_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72420_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72540_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72540_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72541_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72541_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72542_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72542_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72545_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72545_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72546_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72546_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72547_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72547_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72548_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72548_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72549_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72549_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72632_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72632_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72652_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72652_UnlockCondDesc = {
    Text = "「逆転回合：異界からの客人」を完了すると解放されます、逆転ターンに向かいますか？"
  },
  Task_72677_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72677_UnlockCondDesc = {
    Text = "「逆転回合：異界からの客人」を完了すると解放されます、逆転ターンに向かいますか？"
  },
  Task_72678_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72678_UnlockCondDesc = {
    Text = "「逆転回合：異界からの客人」を完了すると解放されます、逆転ターンに向かいますか？"
  },
  Task_72679_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72679_UnlockCondDesc = {
    Text = "「逆転回合：異界からの客人」を完了すると解放されます、逆転ターンに向かいますか？"
  },
  Task_72681_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72681_UnlockCondDesc = {
    Text = "「逆転回合：異界からの客人」を完了すると解放されます、逆転ターンに向かいますか？"
  },
  Task_72682_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72682_UnlockCondDesc = {
    Text = "「逆転回合：異界からの客人」を完了すると解放されます、逆転ターンに向かいますか？"
  },
  Task_72683_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72683_UnlockCondDesc = {
    Text = "「逆転回合：異界からの客人」を完了すると解放されます、逆転ターンに向かいますか？"
  },
  Task_72684_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72684_UnlockCondDesc = {
    Text = "「逆転回合：異界からの客人」を完了すると解放されます、逆転ターンに向かいますか？"
  },
  Task_72685_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72685_UnlockCondDesc = {
    Text = "「逆転回合：異界からの客人」を完了すると解放されます、逆転ターンに向かいますか？"
  },
  Task_72700_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72700_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72701_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72701_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72703_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72703_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72704_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72704_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72705_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72705_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72706_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72706_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72707_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72707_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72709_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72709_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72773_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72773_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72790_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72790_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72798_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72798_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72799_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72799_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72800_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72800_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72801_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72801_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72802_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72802_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72803_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72803_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72805_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72805_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72806_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72806_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72807_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_72807_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_72957_Desc = {
    Text = "「痛みを越えて」を使用して3回勝利"
  },
  Task_72958_Desc = {
    Text = "「奇体の反噬」を使用して1回勝利"
  },
  Task_72959_Desc = {
    Text = "「核溶解」を使用して3回勝利"
  },
  Task_72961_Desc = {
    Text = "「35mmの魔法」を使用して1回勝利"
  },
  Task_72963_Desc = {
    Text = "「女王の戒律」を使用して3回勝利"
  },
  Task_72965_Desc = {
    Text = "「百万の寵愛の眼」を使用して1回勝利"
  },
  Task_72968_Desc = {
    Text = "「湧出」を使用して1回勝利"
  },
  Task_72973_Desc = {
    Text = "「リリー」を使用して1回勝利"
  },
  Task_72975_Desc = {
    Text = "「咆哮する血と砂」を使用して3回勝利"
  },
  Task_72976_Desc = {
    Text = "「至高の秘蔵品」を使用して3回勝利"
  },
  Task_72977_Desc = {
    Text = "「隠世の転輪」を使用して3回勝利"
  },
  Task_72978_Desc = {
    Text = "「情報は命」を使用して3回勝利"
  },
  Task_72980_Desc = {
    Text = "「リッツ」を使用して1回勝利"
  },
  Task_72982_Desc = {
    Text = "「死を超える」を使用して3回勝利"
  },
  Task_72983_Desc = {
    Text = "「湖畔の回想」を使用して1回勝利"
  },
  Task_72986_Desc = {
    Text = "「巨人の刃」を使用して1回勝利"
  },
  Task_72989_Desc = {
    Text = "「オジール」を使用して3回勝利"
  },
  Task_72990_Desc = {
    Text = "「捕食者の子守唄」を使用して1回勝利"
  },
  Task_72992_Desc = {
    Text = "「臨界点」を使用して1回勝利"
  },
  Task_72993_Desc = {
    Text = "「親友へ」を使用して1回勝利"
  },
  Task_72994_Desc = {
    Text = "「儚き永遠」を使用して1回勝利"
  },
  Task_72995_Desc = {
    Text = "「珊瑚の女の死」を使用して1回勝利"
  },
  Task_72997_Desc = {
    Text = "「オレッタ」を使用して3回勝利"
  },
  Task_72999_Desc = {
    Text = "「薔薇の勝利」を使用して3回勝利"
  },
  Task_73001_Desc = {
    Text = "「寵愛」を使用して1回勝利"
  },
  Task_73003_Desc = {
    Text = "「イサラウの眼差し」を使用して3回勝利"
  },
  Task_73004_Desc = {
    Text = "「貴族の杖」を使用して1回勝利"
  },
  Task_73006_Desc = {
    Text = "「幸運の時」を使用して3回勝利"
  },
  Task_73007_Desc = {
    Text = "「アグリッパ」を使用して3回勝利"
  },
  Task_73009_Desc = {
    Text = "「雪山が溶けるまで」を使用して1回勝利"
  },
  Task_73011_Desc = {
    Text = "「心の障壁」を使用して1回勝利"
  },
  Task_73012_Desc = {
    Text = "「ミリアム」を使用して3回勝利"
  },
  Task_73014_Desc = {
    Text = "「ハムリン」を使用して1回勝利"
  },
  Task_73015_Desc = {
    Text = "「海の夢」を使用して3回勝利"
  },
  Task_73016_Desc = {
    Text = "「錯乱」を使用して1回勝利"
  },
  Task_73018_Desc = {
    Text = "「マジックショー」を使用して1回勝利"
  },
  Task_73019_Desc = {
    Text = "「熟成」を使用して1回勝利"
  },
  Task_73021_Desc = {
    Text = "「純銀の初心」を使用して1回勝利"
  },
  Task_73022_Desc = {
    Text = "「ドール」を使用して1回勝利"
  },
  Task_73025_Desc = {
    Text = "「呟き」を使用して1回勝利"
  },
  Task_73026_Desc = {
    Text = "「活性」を使用して1回勝利"
  },
  Task_73028_Desc = {
    Text = "「ダフォダイル」を使用して1回勝利"
  },
  Task_73030_Desc = {
    Text = "「ウインクル」を使用して3回勝利"
  },
  Task_73033_Desc = {
    Text = "「深紅に沈む」を使用して1回勝利"
  },
  Task_73037_Desc = {
    Text = "「鎖を断ち切る日」を使用して3回勝利"
  },
  Task_73039_Desc = {
    Text = "「冬の夜の追憶」を使用して1回勝利"
  },
  Task_73041_Desc = {
    Text = "「秘められた誕生」を使用して1回勝利"
  },
  Task_73044_Desc = {
    Text = "「ライカー」を使用して3回勝利"
  },
  Task_73045_Desc = {
    Text = "「溶壊・ドール」を使用して1回勝利"
  },
  Task_73047_Desc = {
    Text = "「ファイント」を使用して1回勝利"
  },
  Task_73048_Desc = {
    Text = "「タイス」を使用して3回勝利"
  },
  Task_73050_Desc = {
    Text = "「アイギス」を使用して3回勝利"
  },
  Task_73051_Desc = {
    Text = "「オレッタ」を使用して1回勝利"
  },
  Task_73052_Desc = {
    Text = "「サンガー」を使用して1回勝利"
  },
  Task_73053_Desc = {
    Text = "「マーフィー」を使用して1回勝利"
  },
  Task_73054_Desc = {
    Text = "「タヴィ」を使用して3回勝利"
  },
  Task_73055_Desc = {
    Text = "「ドール」を使用して3回勝利"
  },
  Task_73056_Desc = {
    Text = "「サルバドル」を使用して1回勝利"
  },
  Task_73057_Desc = {
    Text = "「唯一の種子」を使用して3回勝利"
  },
  Task_73059_Desc = {
    Text = "「銀ダラの決意」を使用して3回勝利"
  },
  Task_73061_Desc = {
    Text = "「切断と危害」を使用して3回勝利"
  },
  Task_73063_Desc = {
    Text = "「慈悲の育み」を使用して1回勝利"
  },
  Task_73064_Desc = {
    Text = "「懲罰」を使用して3回勝利"
  },
  Task_73066_Desc = {
    Text = "「運命のルーレット」を使用して3回勝利"
  },
  Task_73067_Desc = {
    Text = "「パンディア」を使用して1回勝利"
  },
  Task_73068_Desc = {
    Text = "「すべてが彼女」を使用して1回勝利"
  },
  Task_73070_Desc = {
    Text = "「巨人の覇道」を使用して3回勝利"
  },
  Task_73073_Desc = {
    Text = "「ラモンナ」を使用して3回勝利"
  },
  Task_73074_Desc = {
    Text = "「詩の結び」を使用して1回勝利"
  },
  Task_73075_Desc = {
    Text = "「蒼白の末裔」を使用して3回勝利"
  },
  Task_73077_Desc = {
    Text = "「ワンダ」を使用して1回勝利"
  },
  Task_73081_Desc = {
    Text = "「信仰の力」を使用して1回勝利"
  },
  Task_73082_Desc = {
    Text = "「記憶螺旋」を使用して1回勝利"
  },
  Task_73083_Desc = {
    Text = "「時を遡る時計」を使用して3回勝利"
  },
  Task_73085_Desc = {
    Text = "「オルラ」を使用して1回勝利"
  },
  Task_73086_Desc = {
    Text = "「集会の時」を使用して1回勝利"
  },
  Task_73087_Desc = {
    Text = "「無声の宴」を使用して3回勝利"
  },
  Task_73088_Desc = {
    Text = "「暴風雨の中で」を使用して1回勝利"
  },
  Task_73089_Desc = {
    Text = "「ロータン」を使用して1回勝利"
  },
  Task_73090_Desc = {
    Text = "「血肉の宴」を使用して1回勝利"
  },
  Task_73095_Desc = {
    Text = "「カレン」を使用して1回勝利"
  },
  Task_73097_Desc = {
    Text = "「欲望の海」を使用して1回勝利"
  },
  Task_73098_Desc = {
    Text = "「カーシア」を使用して1回勝利"
  },
  Task_73099_Desc = {
    Text = "「真夏の夢」を使用して1回勝利"
  },
  Task_73100_Desc = {
    Text = "「ソレール」を使用して3回勝利"
  },
  Task_73102_Desc = {
    Text = "「神王の讃歌」を使用して1回勝利"
  },
  Task_73105_Desc = {
    Text = "「不平等な交換」を使用して3回勝利"
  },
  Task_73107_Desc = {
    Text = "「騎士の心」を使用して1回勝利"
  },
  Task_73109_Desc = {
    Text = "「苦しみの呪縛」を使用して3回勝利"
  },
  Task_73110_Desc = {
    Text = "「サルバドル」を使用して3回勝利"
  },
  Task_73111_Desc = {
    Text = "「星天の獣」を使用して3回勝利"
  },
  Task_73117_Desc = {
    Text = "「骨を蝕む抱擁」を使用して1回勝利"
  },
  Task_73118_Desc = {
    Text = "「オレッタの宝物」を使用して1回勝利"
  },
  Task_73120_Desc = {
    Text = "「暴食寓話」を使用して1回勝利"
  },
  Task_73122_Desc = {
    Text = "「環行・ラモンナ」を使用して3回勝利"
  },
  Task_73123_Desc = {
    Text = "「最後の誓い」を使用して1回勝利"
  },
  Task_73124_Desc = {
    Text = "「追放」を使用して3回勝利"
  },
  Task_73126_Desc = {
    Text = "「庇護」を使用して1回勝利"
  },
  Task_73128_Desc = {
    Text = "「強欲」を使用して3回勝利"
  },
  Task_73129_Desc = {
    Text = "「カエクス」を使用して1回勝利"
  },
  Task_73130_Desc = {
    Text = "「真理の門」を使用して3回勝利"
  },
  Task_73131_Desc = {
    Text = "「薔薇の名において」を使用して1回勝利"
  },
  Task_73134_Desc = {
    Text = "「エリカ」を使用して3回勝利"
  },
  Task_73136_Desc = {
    Text = "「死の分析」を使用して3回勝利"
  },
  Task_73138_Desc = {
    Text = "「ティンクト」を使用して3回勝利"
  },
  Task_73139_Desc = {
    Text = "「儚き永遠」を使用して3回勝利"
  },
  Task_73140_Desc = {
    Text = "「職責」を使用して3回勝利"
  },
  Task_73141_Desc = {
    Text = "「悟り」を使用して1回勝利"
  },
  Task_73144_Desc = {
    Text = "「巨人の刃」を使用して3回勝利"
  },
  Task_73147_Desc = {
    Text = "「永劫の演奏」を使用して3回勝利"
  },
  Task_73148_Desc = {
    Text = "「氷河の眠り」を使用して3回勝利"
  },
  Task_73150_Desc = {
    Text = "「リリー」を使用して3回勝利"
  },
  Task_73151_Desc = {
    Text = "「薔薇の勝利」を使用して1回勝利"
  },
  Task_73152_Desc = {
    Text = "「灰霧の正体」を使用して3回勝利"
  },
  Task_73153_Desc = {
    Text = "「トゥルー」を使用して1回勝利"
  },
  Task_73154_Desc = {
    Text = "「希望」を使用して1回勝利"
  },
  Task_73156_Desc = {
    Text = "「レーア」を使用して3回勝利"
  },
  Task_73157_Desc = {
    Text = "「寵愛」を使用して3回勝利"
  },
  Task_73161_Desc = {
    Text = "「ニムフィーア」を使用して3回勝利"
  },
  Task_73162_Desc = {
    Text = "「狂乱」を使用して3回勝利"
  },
  Task_73165_Desc = {
    Text = "「存在しない場所」を使用して1回勝利"
  },
  Task_73166_Desc = {
    Text = "「ファロス」を使用して3回勝利"
  },
  Task_73167_Desc = {
    Text = "「ヘロット」を使用して1回勝利"
  },
  Task_73170_Desc = {
    Text = "「トゥルー」を使用して3回勝利"
  },
  Task_73172_Desc = {
    Text = "「吸収」を使用して3回勝利"
  },
  Task_73173_Desc = {
    Text = "「導きの帆」を使用して1回勝利"
  },
  Task_73174_Desc = {
    Text = "「集会の時」を使用して3回勝利"
  },
  Task_73176_Desc = {
    Text = "「シレスト」を使用して1回勝利"
  },
  Task_73177_Desc = {
    Text = "「サンガー」を使用して3回勝利"
  },
  Task_73178_Desc = {
    Text = "「洞察」を使用して1回勝利"
  },
  Task_73180_Desc = {
    Text = "「永遠の鎮魂歌」を使用して3回勝利"
  },
  Task_73181_Desc = {
    Text = "「計算不能な演算」を使用して3回勝利"
  },
  Task_73182_Desc = {
    Text = "「アグリッパ」を使用して1回勝利"
  },
  Task_73183_Desc = {
    Text = "「縛られた歌」を使用して3回勝利"
  },
  Task_73185_Desc = {
    Text = "「極夜と暁」を使用して3回勝利"
  },
  Task_73186_Desc = {
    Text = "「精神集中」を使用して1回勝利"
  },
  Task_73189_Desc = {
    Text = "「虚無に堕ちた人形」を使用して3回勝利"
  },
  Task_73192_Desc = {
    Text = "「夜に伏す」を使用して1回勝利"
  },
  Task_73193_Desc = {
    Text = "「記憶障害」を使用して1回勝利"
  },
  Task_73197_Desc = {
    Text = "「忘却の手」を使用して3回勝利"
  },
  Task_73200_Desc = {
    Text = "「旅の荷物」を使用して1回勝利"
  },
  Task_73204_Desc = {
    Text = "「血ノ鎖・ヘロット」を使用して3回勝利"
  },
  Task_73206_Desc = {
    Text = "「捕食者の子守唄」を使用して3回勝利"
  },
  Task_73208_Desc = {
    Text = "「溶壊・ドール」を使用して3回勝利"
  },
  Task_73209_Desc = {
    Text = "「珊瑚の女の死」を使用して3回勝利"
  },
  Task_73210_Desc = {
    Text = "「オジール」を使用して1回勝利"
  },
  Task_73212_Desc = {
    Text = "「慈悲の育み」を使用して3回勝利"
  },
  Task_73213_Desc = {
    Text = "「臨界点」を使用して3回勝利"
  },
  Task_73214_Desc = {
    Text = "「親友へ」を使用して3回勝利"
  },
  Task_73216_Desc = {
    Text = "「深紅に沈む」を使用して3回勝利"
  },
  Task_73217_Desc = {
    Text = "「切断と危害」を使用して1回勝利"
  },
  Task_73218_Desc = {
    Text = "「灰霧の正体」を使用して1回勝利"
  },
  Task_73219_Desc = {
    Text = "「頭の中の音」を使用して3回勝利"
  },
  Task_73220_Desc = {
    Text = "「貴族の杖」を使用して3回勝利"
  },
  Task_73222_Desc = {
    Text = "「忘却の手」を使用して1回勝利"
  },
  Task_73223_Desc = {
    Text = "「ジェンキン」を使用して3回勝利"
  },
  Task_73224_Desc = {
    Text = "「ミリアム」を使用して1回勝利"
  },
  Task_73225_Desc = {
    Text = "「幸運の時」を使用して1回勝利"
  },
  Task_73227_Desc = {
    Text = "「迷いの道」を使用して1回勝利"
  },
  Task_73228_Desc = {
    Text = "「アルバ」を使用して1回勝利"
  },
  Task_73229_Desc = {
    Text = "「神言の石板」を使用して1回勝利"
  },
  Task_73232_Desc = {
    Text = "「湧出」を使用して3回勝利"
  },
  Task_73233_Desc = {
    Text = "「ユウハシュ」を使用して3回勝利"
  },
  Task_73235_Desc = {
    Text = "「35mmの魔法」を使用して3回勝利"
  },
  Task_73236_Desc = {
    Text = "「腐朽の贈り物」を使用して1回勝利"
  },
  Task_73237_Desc = {
    Text = "「強欲」を使用して1回勝利"
  },
  Task_73241_Desc = {
    Text = "「存在しない場所」を使用して3回勝利"
  },
  Task_73243_Desc = {
    Text = "「リッツ」を使用して3回勝利"
  },
  Task_73246_Desc = {
    Text = "「隠世の転輪」を使用して1回勝利"
  },
  Task_73249_Desc = {
    Text = "「頭の中の音」を使用して1回勝利"
  },
  Task_73250_Desc = {
    Text = "「24」を使用して1回勝利"
  },
  Task_73253_Desc = {
    Text = "「不屈の意志」を使用して3回勝利"
  },
  Task_73254_Desc = {
    Text = "「奇体の反噬」を使用して3回勝利"
  },
  Task_73257_Desc = {
    Text = "「タイス」を使用して1回勝利"
  },
  Task_73259_Desc = {
    Text = "「ファイント」を使用して3回勝利"
  },
  Task_73260_Desc = {
    Text = "「タヴィ」を使用して1回勝利"
  },
  Task_73262_Desc = {
    Text = "「アイギス」を使用して1回勝利"
  },
  Task_73266_Desc = {
    Text = "「銀ダラの決意」を使用して1回勝利"
  },
  Task_73267_Desc = {
    Text = "「ロータン」を使用して3回勝利"
  },
  Task_73268_Desc = {
    Text = "「唯一の種子」を使用して1回勝利"
  },
  Task_73269_Desc = {
    Text = "「懲罰」を使用して1回勝利"
  },
  Task_73270_Desc = {
    Text = "「疼痛の鰭」を使用して1回勝利"
  },
  Task_73271_Desc = {
    Text = "「真夏の夢」を使用して3回勝利"
  },
  Task_73278_Desc = {
    Text = "「巨人の覇道」を使用して1回勝利"
  },
  Task_73279_Desc = {
    Text = "「エリカ」を使用して1回勝利"
  },
  Task_73280_Desc = {
    Text = "「追放」を使用して1回勝利"
  },
  Task_73281_Desc = {
    Text = "「海の夢」を使用して1回勝利"
  },
  Task_73282_Desc = {
    Text = "「雪山が溶けるまで」を使用して3回勝利"
  },
  Task_73284_Desc = {
    Text = "「運命のルーレット」を使用して1回勝利"
  },
  Task_73285_Desc = {
    Text = "「真理の門」を使用して1回勝利"
  },
  Task_73286_Desc = {
    Text = "「ラモンナ」を使用して1回勝利"
  },
  Task_73287_Desc = {
    Text = "「パンディア」を使用して3回勝利"
  },
  Task_73288_Desc = {
    Text = "「薔薇の名において」を使用して3回勝利"
  },
  Task_73289_Desc = {
    Text = "「すべてが彼女」を使用して3回勝利"
  },
  Task_73290_Desc = {
    Text = "「ワンダ」を使用して3回勝利"
  },
  Task_73292_Desc = {
    Text = "「詩の結び」を使用して3回勝利"
  },
  Task_73293_Desc = {
    Text = "「蒼白の末裔」を使用して1回勝利"
  },
  Task_73294_Desc = {
    Text = "「ティンクト」を使用して1回勝利"
  },
  Task_73296_Desc = {
    Text = "「核溶解」を使用して1回勝利"
  },
  Task_73297_Desc = {
    Text = "「神の御業」を使用して1回勝利"
  },
  Task_73298_Desc = {
    Text = "「咆哮する血と砂」を使用して1回勝利"
  },
  Task_73299_Desc = {
    Text = "「ジェンキン」を使用して1回勝利"
  },
  Task_73302_Desc = {
    Text = "「呟き」を使用して3回勝利"
  },
  Task_73303_Desc = {
    Text = "「女王の戒律」を使用して1回勝利"
  },
  Task_73305_Desc = {
    Text = "「熟成」を使用して3回勝利"
  },
  Task_73306_Desc = {
    Text = "「痛みを越えて」を使用して1回勝利"
  },
  Task_73309_Desc = {
    Text = "「無声の宴」を使用して1回勝利"
  },
  Task_73311_Desc = {
    Text = "「迷いの道」を使用して3回勝利"
  },
  Task_73312_Desc = {
    Text = "「ゴリアテ」を使用して3回勝利"
  },
  Task_73313_Desc = {
    Text = "「暴食寓話」を使用して3回勝利"
  },
  Task_73314_Desc = {
    Text = "「ウインクル」を使用して1回勝利"
  },
  Task_73315_Desc = {
    Text = "「百万の寵愛の眼」を使用して3回勝利"
  },
  Task_73316_Desc = {
    Text = "「ダフォダイル」を使用して3回勝利"
  },
  Task_73317_Desc = {
    Text = "「情報は命」を使用して1回勝利"
  },
  Task_73318_Desc = {
    Text = "「ライカー」を使用して1回勝利"
  },
  Task_73321_Desc = {
    Text = "「オルラ」を使用して3回勝利"
  },
  Task_73322_Desc = {
    Text = "「至高の秘蔵品」を使用して1回勝利"
  },
  Task_73323_Desc = {
    Text = "「ナウティラ」を使用して3回勝利"
  },
  Task_73324_Desc = {
    Text = "「湖畔の回想」を使用して3回勝利"
  },
  Task_73325_Desc = {
    Text = "「死を超える」を使用して1回勝利"
  },
  Task_73326_Desc = {
    Text = "「冬の夜の追憶」を使用して3回勝利"
  },
  Task_73327_Desc = {
    Text = "「旅の荷物」を使用して3回勝利"
  },
  Task_73328_Desc = {
    Text = "「ゴリアテ」を使用して1回勝利"
  },
  Task_73330_Desc = {
    Text = "「苦しみの呪縛」を使用して1回勝利"
  },
  Task_73333_Desc = {
    Text = "「計算不能な演算」を使用して1回勝利"
  },
  Task_73334_Desc = {
    Text = "「星天の獣」を使用して1回勝利"
  },
  Task_73335_Desc = {
    Text = "「神の御業」を使用して3回勝利"
  },
  Task_73338_Desc = {
    Text = "「虚無に堕ちた人形」を使用して1回勝利"
  },
  Task_73341_Desc = {
    Text = "「マーフィー」を使用して3回勝利"
  },
  Task_73343_Desc = {
    Text = "「極夜と暁」を使用して1回勝利"
  },
  Task_73345_Desc = {
    Text = "「イサラウの眼差し」を使用して1回勝利"
  },
  Task_73346_Desc = {
    Text = "「精神集中」を使用して3回勝利"
  },
  Task_73349_Desc = {
    Text = "「骨を蝕む抱擁」を使用して3回勝利"
  },
  Task_73352_Desc = {
    Text = "「夜に伏す」を使用して3回勝利"
  },
  Task_73353_Desc = {
    Text = "「庇護」を使用して3回勝利"
  },
  Task_73354_Desc = {
    Text = "「ナウティラ」を使用して1回勝利"
  },
  Task_73355_Desc = {
    Text = "「環行・ラモンナ」を使用して1回勝利"
  },
  Task_73356_Desc = {
    Text = "「オレッタの宝物」を使用して3回勝利"
  },
  Task_73357_Desc = {
    Text = "「最後の誓い」を使用して3回勝利"
  },
  Task_73359_Desc = {
    Text = "「カエクス」を使用して3回勝利"
  },
  Task_73360_Desc = {
    Text = "「死の分析」を使用して1回勝利"
  },
  Task_73362_Desc = {
    Text = "「マジックショー」を使用して3回勝利"
  },
  Task_73363_Desc = {
    Text = "「ニムフィーア」を使用して1回勝利"
  },
  Task_73366_Desc = {
    Text = "「時を遡る時計」を使用して1回勝利"
  },
  Task_73369_Desc = {
    Text = "「錯乱」を使用して3回勝利"
  },
  Task_73370_Desc = {
    Text = "「ハムリン」を使用して3回勝利"
  },
  Task_73372_Desc = {
    Text = "「純銀の初心」を使用して3回勝利"
  },
  Task_73374_Desc = {
    Text = "「カレン」を使用して3回勝利"
  },
  Task_73377_Desc = {
    Text = "「不平等な交換」を使用して1回勝利"
  },
  Task_73379_Desc = {
    Text = "「ソレール」を使用して1回勝利"
  },
  Task_73380_Desc = {
    Text = "「カーシア」を使用して3回勝利"
  },
  Task_73382_Desc = {
    Text = "「鎖を断ち切る日」を使用して1回勝利"
  },
  Task_73387_Desc = {
    Text = "「秘められた誕生」を使用して3回勝利"
  },
  Task_73388_Desc = {
    Text = "「心の障壁」を使用して3回勝利"
  },
  Task_73390_Desc = {
    Text = "「疼痛の鰭」を使用して3回勝利"
  },
  Task_73392_Desc = {
    Text = "「ユウハシュ」を使用して1回勝利"
  },
  Task_73394_Desc = {
    Text = "「信仰の力」を使用して3回勝利"
  },
  Task_73395_Desc = {
    Text = "「血ノ鎖・ヘロット」を使用して1回勝利"
  },
  Task_73396_Desc = {
    Text = "「神言の石板」を使用して獲得する3回勝利"
  },
  Task_73400_Desc = {
    Text = "「永遠の鎮魂歌」を使用して1回勝利"
  },
  Task_73404_Desc = {
    Text = "「鏡の中の人」を使用して1回勝利"
  },
  Task_73405_Desc = {
    Text = "「暴風雨の中で」を使用して3回勝利"
  },
  Task_73407_Desc = {
    Text = "「腐朽の贈り物」を使用して3回勝利"
  },
  Task_73409_Desc = {
    Text = "「シレスト」を使用して3回勝利"
  },
  Task_73410_Desc = {
    Text = "「洞察」を使用して3回勝利"
  },
  Task_73413_Desc = {
    Text = "「縛られた歌」を使用して1回勝利"
  },
  Task_73417_Desc = {
    Text = "「記憶障害」を使用して3回勝利"
  },
  Task_73418_Desc = {
    Text = "「鏡の中の人」を使用して3回勝利"
  },
  Task_73422_Desc = {
    Text = "「24」を使用して3回勝利"
  },
  Task_73425_Desc = {
    Text = "「不屈の意志」を使用して1回勝利"
  },
  Task_73426_Desc = {
    Text = "「アルバ」を使用して3回勝利"
  },
  Task_73427_Desc = {
    Text = "「狂乱」を使用して1回勝利"
  },
  Task_73430_Desc = {
    Text = "「活性」を使用して3回勝利"
  },
  Task_73431_Desc = {
    Text = "「永劫の演奏」を使用して1回勝利"
  },
  Task_73432_Desc = {
    Text = "「職責」を使用して1回勝利"
  },
  Task_73433_Desc = {
    Text = "「悟り」を使用して3回勝利"
  },
  Task_73435_Desc = {
    Text = "「記憶螺旋」を使用して3回勝利"
  },
  Task_73437_Desc = {
    Text = "「希望」を使用して3回勝利"
  },
  Task_73440_Desc = {
    Text = "「氷河の眠り」を使用して1回勝利"
  },
  Task_73442_Desc = {
    Text = "「血肉の宴」を使用して3回勝利"
  },
  Task_73444_Desc = {
    Text = "「欲望の海」を使用して3回勝利"
  },
  Task_73445_Desc = {
    Text = "「レーア」を使用して1回勝利"
  },
  Task_73451_Desc = {
    Text = "「ヘロット」を使用して3回勝利"
  },
  Task_73453_Desc = {
    Text = "「導きの帆」を使用して3回勝利"
  },
  Task_73456_Desc = {
    Text = "「ファロス」を使用して1回勝利"
  },
  Task_73457_Desc = {
    Text = "「騎士の心」を使用して3回勝利"
  },
  Task_73459_Desc = {
    Text = "「神王の讃歌」を使用して3回勝利"
  },
  Task_73462_Desc = {
    Text = "「吸収」を使用して1回勝利"
  },
  Task_73584_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_73584_Name = {Text = "10勝"},
  Task_73585_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_73585_Name = {Text = "1勝"},
  Task_73586_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_73586_Name = {Text = "6勝"},
  Task_73587_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_73587_Name = {Text = "3勝"},
  Task_73588_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_73588_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_73589_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_73589_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_73590_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_73590_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_73591_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_73591_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_73592_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_73592_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_73593_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_73593_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_73594_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_73594_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_73595_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_73595_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_73596_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_73596_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_73597_Desc = {
    Text = "魔法のドングリに到達"
  },
  Task_73597_UnlockCondDesc = {
    Text = "「逆転回合：逆転万象の瞬間」を完了すると解放されます。逆転ターンに向かいますか？"
  },
  Task_73672_Desc = {
    Text = "溶壊・ドールの霊知啓発2を獲得する"
  },
  Task_73672_Name = {
    Text = "溶壊・ドールの霊知啓発2を獲得する"
  },
  Task_73672_UnlockCondDesc = {
    Text = "イベント@覚醒体溶壊・ドール霊知啓発ギフト1"
  },
  Task_73673_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_73674_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_73676_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_73677_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_73679_Desc = {
    Text = "溶壊・ドールの霊知啓発6を獲得する"
  },
  Task_73679_Name = {
    Text = "溶壊・ドールの霊知啓発6を獲得する"
  },
  Task_73679_UnlockCondDesc = {
    Text = "イベント@覚醒体溶壊・ドール霊知啓発ギフト2"
  },
  Task_73686_Desc = {
    Text = "溶壊・ドールの同調率がレベル10に到達する"
  },
  Task_73880_Desc = {
    Text = "溶壊・ドールに従って「答え」を確認する"
  },
  Task_73880_Name = {Text = "目標"},
  Task_73881_Desc = {
    Text = "異化に陥ったサラを抑制する"
  },
  Task_73881_Name = {Text = "目標"},
  Task_73882_Desc = {
    Text = "B-68号溶壊・ドールを撃破"
  },
  Task_73882_Name = {Text = "目標"},
  Task_73883_Desc = {
    Text = "目の前の次元の世界を探索する"
  },
  Task_73883_Name = {Text = "目標"},
  Task_73884_Desc = {
    Text = "ジェンキンを静かにさせる"
  },
  Task_73884_Name = {Text = "目標"},
  Task_73885_Desc = {
    Text = "束縛溶壊・ドール"
  },
  Task_73885_Name = {Text = "目標"},
  Task_73886_Desc = {
    Text = "守衛時計塔"
  },
  Task_73886_Name = {Text = "目標"},
  Task_73887_Desc = {
    Text = "ワークハウスの廊下の変異体を清掃する"
  },
  Task_73887_Name = {Text = "目標"},
  Task_73888_Desc = {
    Text = "ジュリエットの手からサルバドルを救出"
  },
  Task_73888_Name = {Text = "目標"},
  Task_73889_Desc = {
    Text = "救世の大聖堂の道を開く"
  },
  Task_73889_Name = {Text = "目標"},
  Task_74202_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_74203_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_74204_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_74205_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_74206_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_74207_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_74208_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_74210_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_74211_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_74212_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_74222_Desc = {
    Text = "意識潜行「戴冠の日」を完了する"
  },
  Task_74222_Name = {
    Text = "永劫の王権"
  },
  Task_74223_Desc = {
    Text = "調査「霧の都への再訪」高難度をクリア"
  },
  Task_74223_Name = {
    Text = "灰夜に迷うべからず・高難度"
  },
  Task_74224_Desc = {
    Text = "調査「@1@2」で共鳴10回"
  },
  Task_74224_Desc2 = {
    Text = "調査「霧の都への再訪」で共鳴10回"
  },
  Task_74224_Name2 = {
    Text = "虚無の残響Ⅳ"
  },
  Task_74225_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_74225_Desc2 = {
    Text = "調査「霧の都への再訪」を完了する"
  },
  Task_74225_Name2 = {
    Text = "灰夜に迷うべからず"
  },
  Task_74226_Desc = {
    Text = "調査「@1@2」で3回共鳴する"
  },
  Task_74226_Desc2 = {
    Text = "調査「霧の都への再訪」で共鳴3回"
  },
  Task_74226_Name2 = {
    Text = "虚無の残響"
  },
  Task_74227_Desc = {
    Text = "調査「@1@2」で6回共鳴する"
  },
  Task_74227_Desc2 = {
    Text = "調査「霧の都への再訪」で共鳴6回"
  },
  Task_74227_Name2 = {
    Text = "虚無の残響Ⅱ"
  },
  Task_74228_Desc = {
    Text = "調査「@1@2」で共鳴8回"
  },
  Task_74228_Desc2 = {
    Text = "調査「霧の都への再訪」で共鳴8回"
  },
  Task_74228_Name2 = {
    Text = "虚無の残響Ⅲ"
  },
  Task_74235_Desc = {
    Text = "リズを見つける"
  },
  Task_74235_Name = {Text = "目標"},
  Task_74295_Desc = {
    Text = "意識潜行「熱情の残響」を完了する"
  },
  Task_74295_Name = {
    Text = "青炎旋舞"
  },
  Task_74296_Desc = {
    Text = "意識潜行「熱情の残響」高難度を完了する"
  },
  Task_74296_Name = {
    Text = "青焰旋舞・高難度"
  },
  Task_74332_Name = {
    Text = "逆転回合のイベント終了"
  },
  Task_74333_Desc = {
    Text = "逆転回合の物語第2章をクリア"
  },
  Task_74333_UnlockCondDesc = {
    Text = "「回合奇賞：ポイントが1200に達する」を受け取った後、ロック解放"
  },
  Task_74334_Desc = {
    Text = "逆転回合の物語プロローグをクリア"
  },
  Task_74335_Desc = {
    Text = "逆転回合の物語第3章をクリア"
  },
  Task_74335_UnlockCondDesc = {
    Text = "「回合奇賞：ポイントが2400に達する」を受け取った後、ロック解放"
  },
  Task_74342_Desc = {
    Text = "守護型のキャラクターで25枚のカードを使用する"
  },
  Task_74343_Desc = {
    Text = "凶星型のキャラクターで25枚のカードを使用する"
  },
  Task_74344_Desc = {
    Text = "祝福型のキャラクターで25枚のカードを使用する"
  },
  Task_74345_Desc = {
    Text = "智恵型のキャラクターで25枚のカードを使用する"
  },
  Task_74346_Desc = {
    Text = "闘争型のキャラクターで25枚のカードを使用する"
  },
  Task_74375_Desc = {
    Text = "闘争型のキャラクターで1750枚のカードを使用する"
  },
  Task_74376_Desc = {
    Text = "祝福型のキャラクターで400枚のカードを使用する"
  },
  Task_74377_Desc = {
    Text = "智恵型のキャラクターで1225枚のカードを使用する"
  },
  Task_74378_Desc = {
    Text = "凶星型のキャラクターで1125枚のカードを使用する"
  },
  Task_74379_Desc = {
    Text = "凶星型のキャラクターで775枚のカードを使用する"
  },
  Task_74380_Desc = {
    Text = "祝福型のキャラクターで1775枚のカードを使用する"
  },
  Task_74381_Desc = {
    Text = "闘争型のキャラクターで775枚のカードを使用する"
  },
  Task_74382_Desc = {
    Text = "智恵型のキャラクターで700枚のカードを使用する"
  },
  Task_74383_Desc = {
    Text = "守護型のキャラクターで1875枚のカードを使用する"
  },
  Task_74384_Desc = {
    Text = "祝福型のキャラクターで825枚のカードを使用する"
  },
  Task_74385_Desc = {
    Text = "闘争型のキャラクターで1800枚のカードを使用する"
  },
  Task_74386_Desc = {
    Text = "闘争型のキャラクターで1200枚のカードを使用する"
  },
  Task_74387_Desc = {
    Text = "祝福型のキャラクターで775枚のカードを使用する"
  },
  Task_74388_Desc = {
    Text = "智恵型のキャラクターで525枚のカードを使用する"
  },
  Task_74389_Desc = {
    Text = "智恵型のキャラクターで1600枚のカードを使用する"
  },
  Task_74390_Desc = {
    Text = "祝福型のキャラクターで675枚のカードを使用する"
  },
  Task_74391_Desc = {
    Text = "闘争型のキャラクターで1975枚のカードを使用する"
  },
  Task_74392_Desc = {
    Text = "守護型のキャラクターで1525枚のカードを使用する"
  },
  Task_74393_Desc = {
    Text = "凶星型のキャラクターで1325枚のカードを使用する"
  },
  Task_74394_Desc = {
    Text = "凶星型のキャラクターで1550枚のカードを使用する"
  },
  Task_74395_Desc = {
    Text = "祝福型のキャラクターで1125枚のカードを使用する"
  },
  Task_74396_Desc = {
    Text = "凶星型のキャラクターで125枚のカードを使用する"
  },
  Task_74397_Desc = {
    Text = "凶星型のキャラクターで1600枚のカードを使用する"
  },
  Task_74398_Desc = {
    Text = "祝福型のキャラクターで650枚のカードを使用する"
  },
  Task_74399_Desc = {
    Text = "凶星型のキャラクターで325枚のカードを使用する"
  },
  Task_74400_Desc = {
    Text = "祝福型のキャラクターで1325枚のカードを使用する"
  },
  Task_74401_Desc = {
    Text = "祝福型のキャラクターで150枚のカードを使用する"
  },
  Task_74402_Desc = {
    Text = "凶星型のキャラクターで50枚のカードを使用する"
  },
  Task_74403_Desc = {
    Text = "祝福型のキャラクターで2000枚のカードを使用する"
  },
  Task_74404_Desc = {
    Text = "闘争型のキャラクターで850枚のカードを使用する"
  },
  Task_74405_Desc = {
    Text = "祝福型のキャラクターで1150枚のカードを使用する"
  },
  Task_74406_Desc = {
    Text = "凶星型のキャラクターで150枚のカードを使用する"
  },
  Task_74407_Desc = {
    Text = "守護型のキャラクターで550枚のカードを使用する"
  },
  Task_74408_Desc = {
    Text = "凶星型のキャラクターで800枚のカードを使用する"
  },
  Task_74409_Desc = {
    Text = "闘争型のキャラクターで100枚のカードを使用する"
  },
  Task_74410_Desc = {
    Text = "守護型のキャラクターで1600枚のカードを使用する"
  },
  Task_74411_Desc = {
    Text = "智恵型のキャラクターで1300枚のカードを使用する"
  },
  Task_74412_Desc = {
    Text = "祝福型のキャラクターで1850枚のカードを使用する"
  },
  Task_74413_Desc = {
    Text = "智恵型のキャラクターで1525枚のカードを使用する"
  },
  Task_74414_Desc = {
    Text = "守護型のキャラクターで1425枚のカードを使用する"
  },
  Task_74415_Desc = {
    Text = "守護型のキャラクターで1275枚のカードを使用する"
  },
  Task_74416_Desc = {
    Text = "智恵型のキャラクターで925枚のカードを使用する"
  },
  Task_74417_Desc = {
    Text = "守護型のキャラクターで800枚のカードを使用する"
  },
  Task_74418_Desc = {
    Text = "智恵型のキャラクターで1625枚のカードを使用する"
  },
  Task_74419_Desc = {
    Text = "智恵型のキャラクターで1775枚のカードを使用する"
  },
  Task_74420_Desc = {
    Text = "祝福型のキャラクターで1100枚のカードを使用する"
  },
  Task_74421_Desc = {
    Text = "凶星型のキャラクターで100枚のカードを使用する"
  },
  Task_74422_Desc = {
    Text = "智恵型のキャラクターで1750枚のカードを使用する"
  },
  Task_74423_Desc = {
    Text = "智恵型のキャラクターで1125枚のカードを使用する"
  },
  Task_74424_Desc = {
    Text = "智恵型のキャラクターで750枚のカードを使用する"
  },
  Task_74425_Desc = {
    Text = "凶星型のキャラクターで1725枚のカードを使用する"
  },
  Task_74426_Desc = {
    Text = "闘争型のキャラクターで1150枚のカードを使用する"
  },
  Task_74427_Desc = {
    Text = "智恵型のキャラクターで175枚のカードを使用する"
  },
  Task_74428_Desc = {
    Text = "凶星型のキャラクターで1625枚のカードを使用する"
  },
  Task_74429_Desc = {
    Text = "祝福型のキャラクターで425枚のカードを使用する"
  },
  Task_74430_Desc = {
    Text = "智恵型のキャラクターで1700枚のカードを使用する"
  },
  Task_74431_Desc = {
    Text = "闘争型のキャラクターで1325枚のカードを使用する"
  },
  Task_74432_Desc = {
    Text = "祝福型のキャラクターで1225枚のカードを使用する"
  },
  Task_74433_Desc = {
    Text = "凶星型のキャラクターで225枚のカードを使用する"
  },
  Task_74434_Desc = {
    Text = "闘争型のキャラクターで1875枚のカードを使用する"
  },
  Task_74435_Desc = {
    Text = "智恵型のキャラクターで725枚のカードを使用する"
  },
  Task_74436_Desc = {
    Text = "智恵型のキャラクターで325枚のカードを使用する"
  },
  Task_74437_Desc = {
    Text = "智恵型のキャラクターで1350枚のカードを使用する"
  },
  Task_74438_Desc = {
    Text = "守護型のキャラクターで1725枚のカードを使用する"
  },
  Task_74439_Desc = {
    Text = "闘争型のキャラクターで1375枚のカードを使用する"
  },
  Task_74440_Desc = {
    Text = "守護型のキャラクターで925枚のカードを使用する"
  },
  Task_74441_Desc = {
    Text = "凶星型のキャラクターで1950枚のカードを使用する"
  },
  Task_74442_Desc = {
    Text = "闘争型のキャラクターで450枚のカードを使用する"
  },
  Task_74443_Desc = {
    Text = "守護型のキャラクターで175枚のカードを使用する"
  },
  Task_74444_Desc = {
    Text = "守護型のキャラクターで1100枚のカードを使用する"
  },
  Task_74445_Desc = {
    Text = "守護型のキャラクターで450枚のカードを使用する"
  },
  Task_74446_Desc = {
    Text = "闘争型のキャラクターで1225枚のカードを使用する"
  },
  Task_74447_Desc = {
    Text = "智恵型のキャラクターで1475枚のカードを使用する"
  },
  Task_74448_Desc = {
    Text = "守護型のキャラクターで1250枚のカードを使用する"
  },
  Task_74449_Desc = {
    Text = "智恵型のキャラクターで100枚のカードを使用する"
  },
  Task_74450_Desc = {
    Text = "闘争型のキャラクターで975枚のカードを使用する"
  },
  Task_74451_Desc = {
    Text = "祝福型のキャラクターで800枚のカードを使用する"
  },
  Task_74452_Desc = {
    Text = "凶星型のキャラクターで1875枚のカードを使用する"
  },
  Task_74453_Desc = {
    Text = "闘争型のキャラクターで900枚のカードを使用する"
  },
  Task_74454_Desc = {
    Text = "守護型のキャラクターで1950枚のカードを使用する"
  },
  Task_74455_Desc = {
    Text = "守護型のキャラクターで1000枚のカードを使用する"
  },
  Task_74456_Desc = {
    Text = "闘争型のキャラクターで1925枚のカードを使用する"
  },
  Task_74457_Desc = {
    Text = "智恵型のキャラクターで1825枚のカードを使用する"
  },
  Task_74458_Desc = {
    Text = "闘争型のキャラクターで1725枚のカードを使用する"
  },
  Task_74459_Desc = {
    Text = "凶星型のキャラクターで1500枚のカードを使用する"
  },
  Task_74460_Desc = {
    Text = "凶星型のキャラクターで1375枚のカードを使用する"
  },
  Task_74461_Desc = {
    Text = "守護型のキャラクターで350枚のカードを使用する"
  },
  Task_74462_Desc = {
    Text = "凶星型のキャラクターで1975枚のカードを使用する"
  },
  Task_74463_Desc = {
    Text = "守護型のキャラクターで625枚のカードを使用する"
  },
  Task_74464_Desc = {
    Text = "守護型のキャラクターで500枚のカードを使用する"
  },
  Task_74465_Desc = {
    Text = "智恵型のキャラクターで1200枚のカードを使用する"
  },
  Task_74466_Desc = {
    Text = "智恵型のキャラクターで775枚のカードを使用する"
  },
  Task_74467_Desc = {
    Text = "智恵型のキャラクターで975枚のカードを使用する"
  },
  Task_74468_Desc = {
    Text = "智恵型のキャラクターで1550枚のカードを使用する"
  },
  Task_74469_Desc = {
    Text = "智恵型のキャラクターで2000枚のカードを使用する"
  },
  Task_74470_Desc = {
    Text = "凶星型のキャラクターで1050枚のカードを使用する"
  },
  Task_74471_Desc = {
    Text = "守護型のキャラクターで1700枚のカードを使用する"
  },
  Task_74472_Desc = {
    Text = "闘争型のキャラクターで1500枚のカードを使用する"
  },
  Task_74473_Desc = {
    Text = "祝福型のキャラクターで75枚のカードを使用する"
  },
  Task_74474_Desc = {
    Text = "祝福型のキャラクターで550枚のカードを使用する"
  },
  Task_74475_Desc = {
    Text = "智恵型のキャラクターで150枚のカードを使用する"
  },
  Task_74476_Desc = {
    Text = "闘争型のキャラクターで1575枚のカードを使用する"
  },
  Task_74477_Desc = {
    Text = "智恵型のキャラクターで425枚のカードを使用する"
  },
  Task_74478_Desc = {
    Text = "守護型のキャラクターで950枚のカードを使用する"
  },
  Task_74479_Desc = {
    Text = "守護型のキャラクターで700枚のカードを使用する"
  },
  Task_74480_Desc = {
    Text = "闘争型のキャラクターで1175枚のカードを使用する"
  },
  Task_74481_Desc = {
    Text = "闘争型のキャラクターで700枚のカードを使用する"
  },
  Task_74482_Desc = {
    Text = "祝福型のキャラクターで1275枚のカードを使用する"
  },
  Task_74483_Desc = {
    Text = "智恵型のキャラクターで625枚のカードを使用する"
  },
  Task_74484_Desc = {
    Text = "凶星型のキャラクターで275枚のカードを使用する"
  },
  Task_74485_Desc = {
    Text = "守護型のキャラクターで1575枚のカードを使用する"
  },
  Task_74486_Desc = {
    Text = "守護型のキャラクターで1400枚のカードを使用する"
  },
  Task_74487_Desc = {
    Text = "闘争型のキャラクターで1675枚のカードを使用する"
  },
  Task_74488_Desc = {
    Text = "智恵型のキャラクターで1075枚のカードを使用する"
  },
  Task_74489_Desc = {
    Text = "守護型のキャラクターで325枚のカードを使用する"
  },
  Task_74490_Desc = {
    Text = "祝福型のキャラクターで1025枚のカードを使用する"
  },
  Task_74491_Desc = {
    Text = "智恵型のキャラクターで1025枚のカードを使用する"
  },
  Task_74492_Desc = {
    Text = "智恵型のキャラクターで1050枚のカードを使用する"
  },
  Task_74493_Desc = {
    Text = "守護型のキャラクターで600枚のカードを使用する"
  },
  Task_74494_Desc = {
    Text = "智恵型のキャラクターで1900枚のカードを使用する"
  },
  Task_74495_Desc = {
    Text = "守護型のキャラクターで125枚のカードを使用する"
  },
  Task_74496_Desc = {
    Text = "智恵型のキャラクターで200枚のカードを使用する"
  },
  Task_74497_Desc = {
    Text = "祝福型のキャラクターで1575枚のカードを使用する"
  },
  Task_74498_Desc = {
    Text = "凶星型のキャラクターで575枚のカードを使用する"
  },
  Task_74499_Desc = {
    Text = "闘争型のキャラクターで800枚のカードを使用する"
  },
  Task_74500_Desc = {
    Text = "智恵型のキャラクターで1275枚のカードを使用する"
  },
  Task_74501_Desc = {
    Text = "守護型のキャラクターで1625枚のカードを使用する"
  },
  Task_74502_Desc = {
    Text = "祝福型のキャラクターで1900枚のカードを使用する"
  },
  Task_74503_Desc = {
    Text = "闘争型のキャラクターで1100枚のカードを使用する"
  },
  Task_74504_Desc = {
    Text = "闘争型のキャラクターで150枚のカードを使用する"
  },
  Task_74505_Desc = {
    Text = "祝福型のキャラクターで50枚のカードを使用する"
  },
  Task_74506_Desc = {
    Text = "闘争型のキャラクターで1025枚のカードを使用する"
  },
  Task_74507_Desc = {
    Text = "闘争型のキャラクターで1900枚のカードを使用する"
  },
  Task_74508_Desc = {
    Text = "闘争型のキャラクターで675枚のカードを使用する"
  },
  Task_74509_Desc = {
    Text = "守護型のキャラクターで1925枚のカードを使用する"
  },
  Task_74510_Desc = {
    Text = "智恵型のキャラクターで1850枚のカードを使用する"
  },
  Task_74511_Desc = {
    Text = "凶星型のキャラクターで1250枚のカードを使用する"
  },
  Task_74512_Desc = {
    Text = "闘争型のキャラクターで1950枚のカードを使用する"
  },
  Task_74513_Desc = {
    Text = "闘争型のキャラクターで550枚のカードを使用する"
  },
  Task_74514_Desc = {
    Text = "闘争型のキャラクターで250枚のカードを使用する"
  },
  Task_74515_Desc = {
    Text = "凶星型のキャラクターで1525枚のカードを使用する"
  },
  Task_74516_Desc = {
    Text = "守護型のキャラクターで75枚のカードを使用する"
  },
  Task_74517_Desc = {
    Text = "智恵型のキャラクターで1150枚のカードを使用する"
  },
  Task_74518_Desc = {
    Text = "凶星型のキャラクターで825枚のカードを使用する"
  },
  Task_74519_Desc = {
    Text = "守護型のキャラクターで50枚のカードを使用する"
  },
  Task_74520_Desc = {
    Text = "凶星型のキャラクターで1200枚のカードを使用する"
  },
  Task_74521_Desc = {
    Text = "闘争型のキャラクターで1600枚のカードを使用する"
  },
  Task_74522_Desc = {
    Text = "闘争型のキャラクターで1125枚のカードを使用する"
  },
  Task_74523_Desc = {
    Text = "凶星型のキャラクターで1425枚のカードを使用する"
  },
  Task_74524_Desc = {
    Text = "闘争型のキャラクターで225枚のカードを使用する"
  },
  Task_74525_Desc = {
    Text = "智恵型のキャラクターで375枚のカードを使用する"
  },
  Task_74526_Desc = {
    Text = "守護型のキャラクターで1475枚のカードを使用する"
  },
  Task_74527_Desc = {
    Text = "守護型のキャラクターで100枚のカードを使用する"
  },
  Task_74528_Desc = {
    Text = "闘争型のキャラクターで375枚のカードを使用する"
  },
  Task_74529_Desc = {
    Text = "守護型のキャラクターで1850枚のカードを使用する"
  },
  Task_74530_Desc = {
    Text = "闘争型のキャラクターで350枚のカードを使用する"
  },
  Task_74531_Desc = {
    Text = "祝福型のキャラクターで1675枚のカードを使用する"
  },
  Task_74532_Desc = {
    Text = "凶星型のキャラクターで675枚のカードを使用する"
  },
  Task_74533_Desc = {
    Text = "智恵型のキャラクターで1650枚のカードを使用する"
  },
  Task_74534_Desc = {
    Text = "智恵型のキャラクターで75枚のカードを使用する"
  },
  Task_74535_Desc = {
    Text = "闘争型のキャラクターで50枚のカードを使用する"
  },
  Task_74536_Desc = {
    Text = "闘争型のキャラクターで875枚のカードを使用する"
  },
  Task_74537_Desc = {
    Text = "守護型のキャラクターで1650枚のカードを使用する"
  },
  Task_74538_Desc = {
    Text = "祝福型のキャラクターで250枚のカードを使用する"
  },
  Task_74539_Desc = {
    Text = "祝福型のキャラクターで100枚のカードを使用する"
  },
  Task_74540_Desc = {
    Text = "祝福型のキャラクターで1075枚のカードを使用する"
  },
  Task_74541_Desc = {
    Text = "凶星型のキャラクターで1750枚のカードを使用する"
  },
  Task_74542_Desc = {
    Text = "闘争型のキャラクターで750枚のカードを使用する"
  },
  Task_74543_Desc = {
    Text = "智恵型のキャラクターで550枚のカードを使用する"
  },
  Task_74544_Desc = {
    Text = "闘争型のキャラクターで1450枚のカードを使用する"
  },
  Task_74545_Desc = {
    Text = "闘争型のキャラクターで725枚のカードを使用する"
  },
  Task_74546_Desc = {
    Text = "智恵型のキャラクターで600枚のカードを使用する"
  },
  Task_74547_Desc = {
    Text = "祝福型のキャラクターで700枚のカードを使用する"
  },
  Task_74548_Desc = {
    Text = "守護型のキャラクターで1550枚のカードを使用する"
  },
  Task_74549_Desc = {
    Text = "祝福型のキャラクターで850枚のカードを使用する"
  },
  Task_74550_Desc = {
    Text = "凶星型のキャラクターで1450枚のカードを使用する"
  },
  Task_74551_Desc = {
    Text = "闘争型のキャラクターで1625枚のカードを使用する"
  },
  Task_74552_Desc = {
    Text = "闘争型のキャラクターで200枚のカードを使用する"
  },
  Task_74553_Desc = {
    Text = "祝福型のキャラクターで1525枚のカードを使用する"
  },
  Task_74554_Desc = {
    Text = "凶星型のキャラクターで525枚のカードを使用する"
  },
  Task_74555_Desc = {
    Text = "祝福型のキャラクターで325枚のカードを使用する"
  },
  Task_74556_Desc = {
    Text = "闘争型のキャラクターで1525枚のカードを使用する"
  },
  Task_74557_Desc = {
    Text = "凶星型のキャラクターで375枚のカードを使用する"
  },
  Task_74558_Desc = {
    Text = "祝福型のキャラクターで1375枚のカードを使用する"
  },
  Task_74559_Desc = {
    Text = "祝福型のキャラクターで300枚のカードを使用する"
  },
  Task_74560_Desc = {
    Text = "祝福型のキャラクターで225枚のカードを使用する"
  },
  Task_74561_Desc = {
    Text = "闘争型のキャラクターで1850枚のカードを使用する"
  },
  Task_74562_Desc = {
    Text = "守護型のキャラクターで475枚のカードを使用する"
  },
  Task_74563_Desc = {
    Text = "祝福型のキャラクターで600枚のカードを使用する"
  },
  Task_74564_Desc = {
    Text = "守護型のキャラクターで1375枚のカードを使用する"
  },
  Task_74565_Desc = {
    Text = "守護型のキャラクターで1450枚のカードを使用する"
  },
  Task_74566_Desc = {
    Text = "守護型のキャラクターで300枚のカードを使用する"
  },
  Task_74567_Desc = {
    Text = "智恵型のキャラクターで950枚のカードを使用する"
  },
  Task_74568_Desc = {
    Text = "守護型のキャラクターで1200枚のカードを使用する"
  },
  Task_74569_Desc = {
    Text = "凶星型のキャラクターで1025枚のカードを使用する"
  },
  Task_74570_Desc = {
    Text = "祝福型のキャラクターで950枚のカードを使用する"
  },
  Task_74571_Desc = {
    Text = "闘争型のキャラクターで1350枚のカードを使用する"
  },
  Task_74572_Desc = {
    Text = "守護型のキャラクターで525枚のカードを使用する"
  },
  Task_74573_Desc = {
    Text = "闘争型のキャラクターで125枚のカードを使用する"
  },
  Task_74574_Desc = {
    Text = "祝福型のキャラクターで475枚のカードを使用する"
  },
  Task_74575_Desc = {
    Text = "智恵型のキャラクターで350枚のカードを使用する"
  },
  Task_74576_Desc = {
    Text = "智恵型のキャラクターで1175枚のカードを使用する"
  },
  Task_74577_Desc = {
    Text = "智恵型のキャラクターで1250枚のカードを使用する"
  },
  Task_74578_Desc = {
    Text = "守護型のキャラクターで775枚のカードを使用する"
  },
  Task_74579_Desc = {
    Text = "守護型のキャラクターで400枚のカードを使用する"
  },
  Task_74580_Desc = {
    Text = "闘争型のキャラクターで825枚のカードを使用する"
  },
  Task_74581_Desc = {
    Text = "智恵型のキャラクターで650枚のカードを使用する"
  },
  Task_74582_Desc = {
    Text = "凶星型のキャラクターで1575枚のカードを使用する"
  },
  Task_74583_Desc = {
    Text = "祝福型のキャラクターで350枚のカードを使用する"
  },
  Task_74584_Desc = {
    Text = "闘争型のキャラクターで1400枚のカードを使用する"
  },
  Task_74585_Desc = {
    Text = "守護型のキャラクターで275枚のカードを使用する"
  },
  Task_74586_Desc = {
    Text = "祝福型のキャラクターで1500枚のカードを使用する"
  },
  Task_74587_Desc = {
    Text = "凶星型のキャラクターで500枚のカードを使用する"
  },
  Task_74588_Desc = {
    Text = "闘争型のキャラクターで1075枚のカードを使用する"
  },
  Task_74589_Desc = {
    Text = "祝福型のキャラクターで625枚のカードを使用する"
  },
  Task_74590_Desc = {
    Text = "闘争型のキャラクターで575枚のカードを使用する"
  },
  Task_74591_Desc = {
    Text = "凶星型のキャラクターで850枚のカードを使用する"
  },
  Task_74592_Desc = {
    Text = "守護型のキャラクターで650枚のカードを使用する"
  },
  Task_74593_Desc = {
    Text = "祝福型のキャラクターで575枚のカードを使用する"
  },
  Task_74594_Desc = {
    Text = "祝福型のキャラクターで375枚のカードを使用する"
  },
  Task_74595_Desc = {
    Text = "守護型のキャラクターで225枚のカードを使用する"
  },
  Task_74596_Desc = {
    Text = "智恵型のキャラクターで1875枚のカードを使用する"
  },
  Task_74597_Desc = {
    Text = "守護型のキャラクターで1075枚のカードを使用する"
  },
  Task_74598_Desc = {
    Text = "闘争型のキャラクターで1825枚のカードを使用する"
  },
  Task_74599_Desc = {
    Text = "凶星型のキャラクターで1700枚のカードを使用する"
  },
  Task_74600_Desc = {
    Text = "守護型のキャラクターで150枚のカードを使用する"
  },
  Task_74601_Desc = {
    Text = "守護型のキャラクターで1750枚のカードを使用する"
  },
  Task_74602_Desc = {
    Text = "守護型のキャラクターで1975枚のカードを使用する"
  },
  Task_74603_Desc = {
    Text = "凶星型のキャラクターで750枚のカードを使用する"
  },
  Task_74604_Desc = {
    Text = "祝福型のキャラクターで1750枚のカードを使用する"
  },
  Task_74605_Desc = {
    Text = "凶星型のキャラクターで1150枚のカードを使用する"
  },
  Task_74606_Desc = {
    Text = "凶星型のキャラクターで1475枚のカードを使用する"
  },
  Task_74607_Desc = {
    Text = "守護型のキャラクターで875枚のカードを使用する"
  },
  Task_74608_Desc = {
    Text = "凶星型のキャラクターで725枚のカードを使用する"
  },
  Task_74609_Desc = {
    Text = "祝福型のキャラクターで1725枚のカードを使用する"
  },
  Task_74610_Desc = {
    Text = "凶星型のキャラクターで1800枚のカードを使用する"
  },
  Task_74611_Desc = {
    Text = "祝福型のキャラクターで1050枚のカードを使用する"
  },
  Task_74612_Desc = {
    Text = "祝福型のキャラクターで1925枚のカードを使用する"
  },
  Task_74613_Desc = {
    Text = "凶星型のキャラクターで925枚のカードを使用する"
  },
  Task_74614_Desc = {
    Text = "智恵型のキャラクターで250枚のカードを使用する"
  },
  Task_74615_Desc = {
    Text = "智恵型のキャラクターで900枚のカードを使用する"
  },
  Task_74616_Desc = {
    Text = "凶星型のキャラクターで350枚のカードを使用する"
  },
  Task_74617_Desc = {
    Text = "祝福型のキャラクターで1350枚のカードを使用する"
  },
  Task_74618_Desc = {
    Text = "祝福型のキャラクターで125枚のカードを使用する"
  },
  Task_74619_Desc = {
    Text = "凶星型のキャラクターで1775枚のカードを使用する"
  },
  Task_74620_Desc = {
    Text = "凶星型のキャラクターで1925枚のカードを使用する"
  },
  Task_74621_Desc = {
    Text = "凶星型のキャラクターで1900枚のカードを使用する"
  },
  Task_74622_Desc = {
    Text = "智恵型のキャラクターで875枚のカードを使用する"
  },
  Task_74623_Desc = {
    Text = "守護型のキャラクターで250枚のカードを使用する"
  },
  Task_74624_Desc = {
    Text = "守護型のキャラクターで900枚のカードを使用する"
  },
  Task_74625_Desc = {
    Text = "守護型のキャラクターで675枚のカードを使用する"
  },
  Task_74626_Desc = {
    Text = "守護型のキャラクターで1350枚のカードを使用する"
  },
  Task_74627_Desc = {
    Text = "智恵型のキャラクターで1450枚のカードを使用する"
  },
  Task_74628_Desc = {
    Text = "祝福型のキャラクターで875枚のカードを使用する"
  },
  Task_74629_Desc = {
    Text = "闘争型のキャラクターで1550枚のカードを使用する"
  },
  Task_74630_Desc = {
    Text = "智恵型のキャラクターで1000枚のカードを使用する"
  },
  Task_74631_Desc = {
    Text = "凶星型のキャラクターで2000枚のカードを使用する"
  },
  Task_74632_Desc = {
    Text = "智恵型のキャラクターで675枚のカードを使用する"
  },
  Task_74633_Desc = {
    Text = "守護型のキャラクターで1025枚のカードを使用する"
  },
  Task_74634_Desc = {
    Text = "凶星型のキャラクターで1300枚のカードを使用する"
  },
  Task_74635_Desc = {
    Text = "智恵型のキャラクターで1800枚のカードを使用する"
  },
  Task_74636_Desc = {
    Text = "守護型のキャラクターで1825枚のカードを使用する"
  },
  Task_74637_Desc = {
    Text = "闘争型のキャラクターで1700枚のカードを使用する"
  },
  Task_74638_Desc = {
    Text = "闘争型のキャラクターで1000枚のカードを使用する"
  },
  Task_74639_Desc = {
    Text = "祝福型のキャラクターで275枚のカードを使用する"
  },
  Task_74640_Desc = {
    Text = "智恵型のキャラクターで1100枚のカードを使用する"
  },
  Task_74641_Desc = {
    Text = "祝福型のキャラクターで1800枚のカードを使用する"
  },
  Task_74642_Desc = {
    Text = "闘争型のキャラクターで1475枚のカードを使用する"
  },
  Task_74643_Desc = {
    Text = "凶星型のキャラクターで1225枚のカードを使用する"
  },
  Task_74644_Desc = {
    Text = "祝福型のキャラクターで975枚のカードを使用する"
  },
  Task_74645_Desc = {
    Text = "闘争型のキャラクターで400枚のカードを使用する"
  },
  Task_74646_Desc = {
    Text = "智恵型のキャラクターで800枚のカードを使用する"
  },
  Task_74647_Desc = {
    Text = "智恵型のキャラクターで1925枚のカードを使用する"
  },
  Task_74648_Desc = {
    Text = "智恵型のキャラクターで1375枚のカードを使用する"
  },
  Task_74649_Desc = {
    Text = "智恵型のキャラクターで400枚のカードを使用する"
  },
  Task_74650_Desc = {
    Text = "祝福型のキャラクターで1000枚のカードを使用する"
  },
  Task_74651_Desc = {
    Text = "凶星型のキャラクターで700枚のカードを使用する"
  },
  Task_74652_Desc = {
    Text = "祝福型のキャラクターで1700枚のカードを使用する"
  },
  Task_74653_Desc = {
    Text = "凶星型のキャラクターで1075枚のカードを使用する"
  },
  Task_74654_Desc = {
    Text = "闘争型のキャラクターで1050枚のカードを使用する"
  },
  Task_74655_Desc = {
    Text = "闘争型のキャラクターで175枚のカードを使用する"
  },
  Task_74656_Desc = {
    Text = "智恵型のキャラクターで300枚のカードを使用する"
  },
  Task_74657_Desc = {
    Text = "凶星型のキャラクターで1000枚のカードを使用する"
  },
  Task_74658_Desc = {
    Text = "智恵型のキャラクターで825枚のカードを使用する"
  },
  Task_74659_Desc = {
    Text = "闘争型のキャラクターで600枚のカードを使用する"
  },
  Task_74660_Desc = {
    Text = "守護型のキャラクターで725枚のカードを使用する"
  },
  Task_74661_Desc = {
    Text = "守護型のキャラクターで750枚のカードを使用する"
  },
  Task_74662_Desc = {
    Text = "凶星型のキャラクターで1675枚のカードを使用する"
  },
  Task_74663_Desc = {
    Text = "智恵型のキャラクターで1500枚のカードを使用する"
  },
  Task_74664_Desc = {
    Text = "守護型のキャラクターで375枚のカードを使用する"
  },
  Task_74665_Desc = {
    Text = "守護型のキャラクターで1150枚のカードを使用する"
  },
  Task_74666_Desc = {
    Text = "智恵型のキャラクターで275枚のカードを使用する"
  },
  Task_74667_Desc = {
    Text = "祝福型のキャラクターで900枚のカードを使用する"
  },
  Task_74668_Desc = {
    Text = "智恵型のキャラクターで475枚のカードを使用する"
  },
  Task_74669_Desc = {
    Text = "凶星型のキャラクターで75枚のカードを使用する"
  },
  Task_74670_Desc = {
    Text = "祝福型のキャラクターで175枚のカードを使用する"
  },
  Task_74671_Desc = {
    Text = "守護型のキャラクターで1775枚のカードを使用する"
  },
  Task_74672_Desc = {
    Text = "智恵型のキャラクターで575枚のカードを使用する"
  },
  Task_74673_Desc = {
    Text = "闘争型のキャラクターで500枚のカードを使用する"
  },
  Task_74674_Desc = {
    Text = "智恵型のキャラクターで1725枚のカードを使用する"
  },
  Task_74675_Desc = {
    Text = "闘争型のキャラクターで950枚のカードを使用する"
  },
  Task_74676_Desc = {
    Text = "智恵型のキャラクターで1950枚のカードを使用する"
  },
  Task_74677_Desc = {
    Text = "守護型のキャラクターで1500枚のカードを使用する"
  },
  Task_74678_Desc = {
    Text = "祝福型のキャラクターで1975枚のカードを使用する"
  },
  Task_74679_Desc = {
    Text = "凶星型のキャラクターで975枚のカードを使用する"
  },
  Task_74680_Desc = {
    Text = "智恵型のキャラクターで1325枚のカードを使用する"
  },
  Task_74681_Desc = {
    Text = "闘争型のキャラクターで1775枚のカードを使用する"
  },
  Task_74682_Desc = {
    Text = "智恵型のキャラクターで125枚のカードを使用する"
  },
  Task_74683_Desc = {
    Text = "祝福型のキャラクターで1550枚のカードを使用する"
  },
  Task_74684_Desc = {
    Text = "闘争型のキャラクターで2000枚のカードを使用する"
  },
  Task_74685_Desc = {
    Text = "凶星型のキャラクターで1275枚のカードを使用する"
  },
  Task_74686_Desc = {
    Text = "祝福型のキャラクターで525枚のカードを使用する"
  },
  Task_74687_Desc = {
    Text = "凶星型のキャラクターで550枚のカードを使用する"
  },
  Task_74688_Desc = {
    Text = "闘争型のキャラクターで650枚のカードを使用する"
  },
  Task_74689_Desc = {
    Text = "凶星型のキャラクターで875枚のカードを使用する"
  },
  Task_74690_Desc = {
    Text = "祝福型のキャラクターで1875枚のカードを使用する"
  },
  Task_74691_Desc = {
    Text = "守護型のキャラクターで1300枚のカードを使用する"
  },
  Task_74692_Desc = {
    Text = "凶星型のキャラクターで1100枚のカードを使用する"
  },
  Task_74693_Desc = {
    Text = "守護型のキャラクターで2000枚のカードを使用する"
  },
  Task_74694_Desc = {
    Text = "凶星型のキャラクターで1850枚のカードを使用する"
  },
  Task_74695_Desc = {
    Text = "闘争型のキャラクターで75枚のカードを使用する"
  },
  Task_74696_Desc = {
    Text = "闘争型のキャラクターで625枚のカードを使用する"
  },
  Task_74697_Desc = {
    Text = "闘争型のキャラクターで1425枚のカードを使用する"
  },
  Task_74698_Desc = {
    Text = "守護型のキャラクターで1800枚のカードを使用する"
  },
  Task_74699_Desc = {
    Text = "智恵型のキャラクターで225枚のカードを使用する"
  },
  Task_74700_Desc = {
    Text = "祝福型のキャラクターで725枚のカードを使用する"
  },
  Task_74701_Desc = {
    Text = "守護型のキャラクターで1175枚のカードを使用する"
  },
  Task_74702_Desc = {
    Text = "智恵型のキャラクターで450枚のカードを使用する"
  },
  Task_74703_Desc = {
    Text = "守護型のキャラクターで575枚のカードを使用する"
  },
  Task_74704_Desc = {
    Text = "祝福型のキャラクターで1625枚のカードを使用する"
  },
  Task_74705_Desc = {
    Text = "凶星型のキャラクターで625枚のカードを使用する"
  },
  Task_74706_Desc = {
    Text = "凶星型のキャラクターで1350枚のカードを使用する"
  },
  Task_74707_Desc = {
    Text = "祝福型のキャラクターで1650枚のカードを使用する"
  },
  Task_74708_Desc = {
    Text = "凶星型のキャラクターで650枚のカードを使用する"
  },
  Task_74709_Desc = {
    Text = "守護型のキャラクターで200枚のカードを使用する"
  },
  Task_74710_Desc = {
    Text = "守護型のキャラクターで1125枚のカードを使用する"
  },
  Task_74711_Desc = {
    Text = "智恵型のキャラクターで50枚のカードを使用する"
  },
  Task_74712_Desc = {
    Text = "凶星型のキャラクターで450枚のカードを使用する"
  },
  Task_74713_Desc = {
    Text = "祝福型のキャラクターで1250枚のカードを使用する"
  },
  Task_74714_Desc = {
    Text = "凶星型のキャラクターで250枚のカードを使用する"
  },
  Task_74715_Desc = {
    Text = "祝福型のキャラクターで1450枚のカードを使用する"
  },
  Task_74716_Desc = {
    Text = "智恵型のキャラクターで1675枚のカードを使用する"
  },
  Task_74717_Desc = {
    Text = "凶星型のキャラクターで900枚のカードを使用する"
  },
  Task_74718_Desc = {
    Text = "智恵型のキャラクターで500枚のカードを使用する"
  },
  Task_74719_Desc = {
    Text = "守護型のキャラクターで1325枚のカードを使用する"
  },
  Task_74720_Desc = {
    Text = "凶星型のキャラクターで425枚のカードを使用する"
  },
  Task_74721_Desc = {
    Text = "祝福型のキャラクターで1425枚のカードを使用する"
  },
  Task_74722_Desc = {
    Text = "闘争型のキャラクターで1300枚のカードを使用する"
  },
  Task_74723_Desc = {
    Text = "祝福型のキャラクターで925枚のカードを使用する"
  },
  Task_74724_Desc = {
    Text = "祝福型のキャラクターで1825枚のカードを使用する"
  },
  Task_74725_Desc = {
    Text = "祝福型のキャラクターで1175枚のカードを使用する"
  },
  Task_74726_Desc = {
    Text = "凶星型のキャラクターで175枚のカードを使用する"
  },
  Task_74727_Desc = {
    Text = "祝福型のキャラクターで750枚のカードを使用する"
  },
  Task_74728_Desc = {
    Text = "守護型のキャラクターで850枚のカードを使用する"
  },
  Task_74729_Desc = {
    Text = "闘争型のキャラクターで1650枚のカードを使用する"
  },
  Task_74730_Desc = {
    Text = "闘争型のキャラクターで1275枚のカードを使用する"
  },
  Task_74731_Desc = {
    Text = "凶星型のキャラクターで1175枚のカードを使用する"
  },
  Task_74732_Desc = {
    Text = "智恵型のキャラクターで1975枚のカードを使用する"
  },
  Task_74733_Desc = {
    Text = "闘争型のキャラクターで275枚のカードを使用する"
  },
  Task_74734_Desc = {
    Text = "智恵型のキャラクターで1425枚のカードを使用する"
  },
  Task_74735_Desc = {
    Text = "守護型のキャラクターで1900枚のカードを使用する"
  },
  Task_74736_Desc = {
    Text = "祝福型のキャラクターで1600枚のカードを使用する"
  },
  Task_74737_Desc = {
    Text = "凶星型のキャラクターで600枚のカードを使用する"
  },
  Task_74738_Desc = {
    Text = "守護型のキャラクターで1050枚のカードを使用する"
  },
  Task_74739_Desc = {
    Text = "凶星型のキャラクターで1400枚のカードを使用する"
  },
  Task_74740_Desc = {
    Text = "祝福型のキャラクターで200枚のカードを使用する"
  },
  Task_74741_Desc = {
    Text = "祝福型のキャラクターで500枚のカードを使用する"
  },
  Task_74742_Desc = {
    Text = "守護型のキャラクターで1225枚のカードを使用する"
  },
  Task_74743_Desc = {
    Text = "闘争型のキャラクターで525枚のカードを使用する"
  },
  Task_74744_Desc = {
    Text = "凶星型のキャラクターで400枚のカードを使用する"
  },
  Task_74745_Desc = {
    Text = "祝福型のキャラクターで1400枚のカードを使用する"
  },
  Task_74746_Desc = {
    Text = "守護型のキャラクターで425枚のカードを使用する"
  },
  Task_74747_Desc = {
    Text = "闘争型のキャラクターで475枚のカードを使用する"
  },
  Task_74748_Desc = {
    Text = "凶星型のキャラクターで475枚のカードを使用する"
  },
  Task_74749_Desc = {
    Text = "祝福型のキャラクターで1475枚のカードを使用する"
  },
  Task_74750_Desc = {
    Text = "闘争型のキャラクターで300枚のカードを使用する"
  },
  Task_74751_Desc = {
    Text = "智恵型のキャラクターで1575枚のカードを使用する"
  },
  Task_74752_Desc = {
    Text = "守護型のキャラクターで1675枚のカードを使用する"
  },
  Task_74753_Desc = {
    Text = "守護型のキャラクターで975枚のカードを使用する"
  },
  Task_74754_Desc = {
    Text = "闘争型のキャラクターで1250枚のカードを使用する"
  },
  Task_74755_Desc = {
    Text = "智恵型のキャラクターで850枚のカードを使用する"
  },
  Task_74756_Desc = {
    Text = "祝福型のキャラクターで1200枚のカードを使用する"
  },
  Task_74757_Desc = {
    Text = "凶星型のキャラクターで1650枚のカードを使用する"
  },
  Task_74758_Desc = {
    Text = "凶星型のキャラクターで200枚のカードを使用する"
  },
  Task_74759_Desc = {
    Text = "祝福型のキャラクターで1950枚のカードを使用する"
  },
  Task_74760_Desc = {
    Text = "凶星型のキャラクターで950枚のカードを使用する"
  },
  Task_74761_Desc = {
    Text = "祝福型のキャラクターで450枚のカードを使用する"
  },
  Task_74762_Desc = {
    Text = "智恵型のキャラクターで1400枚のカードを使用する"
  },
  Task_74763_Desc = {
    Text = "闘争型のキャラクターで325枚のカードを使用する"
  },
  Task_74764_Desc = {
    Text = "闘争型のキャラクターで925枚のカードを使用する"
  },
  Task_74765_Desc = {
    Text = "凶星型のキャラクターで1825枚のカードを使用する"
  },
  Task_74766_Desc = {
    Text = "凶星型のキャラクターで300枚のカードを使用する"
  },
  Task_74767_Desc = {
    Text = "祝福型のキャラクターで1300枚のカードを使用する"
  },
  Task_74768_Desc = {
    Text = "闘争型のキャラクターで425枚のカードを使用する"
  },
  Task_74769_Desc = {
    Text = "守護型のキャラクターで825枚のカードを使用する"
  },
  Task_75738_Desc = {
    Text = "「首なし死体」任意の難易度をクリア"
  },
  Task_75739_Desc = {
    Text = "「灰海に帰する」任意の難易度でクリア"
  },
  Task_75740_Desc = {
    Text = "「沼の悪鬼」任意の難易度でクリア"
  },
  Task_75741_Desc = {
    Text = "「雨夜の追跡」任意の難易度でクリア"
  },
  Task_75742_Desc = {
    Text = "「それと彼女」任意の難易度でクリア"
  },
  Task_76237_Desc = {
    Text = "星辰篇第1章 1-5 高難度をクリア"
  },
  Task_76238_Desc = {
    Text = "終章\n「長き夢の尽きる時」をクリア"
  },
  Task_76239_Desc = {
    Text = "星辰篇第1章 1-6をクリア"
  },
  Task_76240_Desc = {
    Text = "終章 9-3 高難度をクリア"
  },
  Task_76241_Desc = {
    Text = "終章\n「長き夢の尽きる時」高難度をクリア"
  },
  Task_76242_Desc = {
    Text = "終章\n「長き夢の尽きる時」をクリア"
  },
  Task_76243_Desc = {
    Text = "星辰篇第1章\n「霧の都への再訪」高難度をクリア"
  },
  Task_76244_Desc = {
    Text = "星辰篇第1章\n「霧の都への再訪」高難度をクリア"
  },
  Task_76245_Desc = {
    Text = "終章 9-4 をクリア"
  },
  Task_76246_Desc = {
    Text = "星辰篇第1章 1-6をクリア"
  },
  Task_76247_Desc = {
    Text = "星辰篇第1章\n「霧の都への再訪」をクリア"
  },
  Task_76248_Desc = {
    Text = "星辰篇第1章 1-5 高難度をクリア"
  },
  Task_76249_Desc = {
    Text = "終章\n「長き夢の尽きる時」高難度をクリア"
  },
  Task_76250_Desc = {
    Text = "終章 9-3 高難度をクリア"
  },
  Task_76251_Desc = {
    Text = "終章 9-4 をクリア"
  },
  Task_76252_Desc = {
    Text = "星辰篇第1章\n「霧の都への再訪」をクリア"
  },
  Task_76339_Desc = {
    Text = "「灰海に帰する」任意の難易度でクリア"
  },
  Task_76340_Desc = {
    Text = "魔女の店・狂乱"
  },
  Task_76341_Desc = {
    Text = "「雨夜の追跡」超難度をクリア"
  },
  Task_76342_Desc = {
    Text = "「沼の悪鬼」超難度をクリア"
  },
  Task_76343_Desc = {
    Text = "「それと彼女」任意の難易度でクリア"
  },
  Task_76344_Desc = {
    Text = "魔女の宝庫"
  },
  Task_76345_Desc = {
    Text = "「華麗なる秘宝」で300個のアイテムを交換して獲得する"
  },
  Task_76346_Desc = {
    Text = "「華麗なる秘宝」で150個のアイテムを交換して獲得する"
  },
  Task_76347_Desc = {
    Text = "「首なし死体」超難度をクリア"
  },
  Task_76348_Desc = {
    Text = "「雨夜の追跡」任意の難易度でクリア"
  },
  Task_76349_Desc = {
    Text = "「それと彼女」超難度をクリア"
  },
  Task_76350_Desc = {
    Text = "「灰海に帰する」超難度をクリア"
  },
  Task_76351_Desc = {
    Text = "「珠玉の珍品」で150個のアイテムを交換して獲得する"
  },
  Task_76352_Desc = {
    Text = "特務記録「雨の町に潜む影」クリア"
  },
  Task_76353_Desc = {
    Text = "「魔女の店・突破」すべての任務を完了する"
  },
  Task_76354_Desc = {
    Text = "「珠玉の珍品」で300個のアイテムを交換して獲得する"
  },
  Task_76355_Desc = {
    Text = "「沼の悪鬼」任意の難易度でクリア"
  },
  Task_76356_Desc = {
    Text = "「悩み解消の逸品」で300個のアイテムを交換して獲得する"
  },
  Task_76357_Desc = {
    Text = "「悩み解消の逸品」で150個のアイテムを交換して獲得する"
  },
  Task_76358_Desc = {
    Text = "魔女の店・突破"
  },
  Task_76359_Desc = {
    Text = "「首なし死体」任意の難易度をクリア"
  },
  Task_77674_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_77674_Name = {Text = "10勝"},
  Task_77675_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_77675_Name = {Text = "1勝"},
  Task_77676_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_77676_Name = {Text = "3勝"},
  Task_77677_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_77677_Name = {Text = "6勝"},
  Task_78106_Desc = {
    Text = "「環行・ラモンナ」を使用して6回勝利"
  },
  Task_78107_Desc = {
    Text = "「イサラウの眼差し」を使用して6回勝利"
  },
  Task_78108_Desc = {
    Text = "「不屈の意志」を使用して6回勝利"
  },
  Task_78109_Desc = {
    Text = "「エリカ」を使用して10回勝利"
  },
  Task_78112_Desc = {
    Text = "「リリー」を使用して6回勝利"
  },
  Task_78113_Desc = {
    Text = "「真夏の夢」を使用して6回勝利"
  },
  Task_78114_Desc = {
    Text = "「すべてが彼女」を使用して6回勝利"
  },
  Task_78115_Desc = {
    Text = "「血ノ鎖・ヘロット」を使用して10回勝利"
  },
  Task_78116_Desc = {
    Text = "「ライカー」を使用して10回勝利"
  },
  Task_78117_Desc = {
    Text = "「ラモンナ」を使用して10回勝利"
  },
  Task_78118_Desc = {
    Text = "「ニムフィーア」を使用して6回勝利"
  },
  Task_78119_Desc = {
    Text = "「薔薇の名において」を使用して6回勝利"
  },
  Task_78120_Desc = {
    Text = "「アグリッパ」を使用して6回勝利"
  },
  Task_78122_Desc = {
    Text = "「ミリアム」を使用して6回勝利"
  },
  Task_78123_Desc = {
    Text = "「リッツ」を使用して6回勝利"
  },
  Task_78124_Desc = {
    Text = "「追放」を使用して6回勝利"
  },
  Task_78125_Desc = {
    Text = "「寵愛」を使用して6回勝利"
  },
  Task_78126_Desc = {
    Text = "「鏡の中の人」を使用して6回勝利"
  },
  Task_78127_Desc = {
    Text = "「鎖を断ち切る日」を使用して6回勝利"
  },
  Task_78128_Desc = {
    Text = "「迷いの道」を使用して6回勝利"
  },
  Task_78129_Desc = {
    Text = "「ティンクト」を使用して6回勝利"
  },
  Task_78130_Desc = {
    Text = "「集会の時」を使用して6回勝利"
  },
  Task_78131_Desc = {
    Text = "「パンディア」を使用して6回勝利"
  },
  Task_78132_Desc = {
    Text = "「サルバドル」を使用して10回勝利"
  },
  Task_78133_Desc = {
    Text = "「海の夢」を使用して6回勝利"
  },
  Task_78134_Desc = {
    Text = "「真理の門」を使用して6回勝利"
  },
  Task_78135_Desc = {
    Text = "「狂乱」を使用して6回勝利"
  },
  Task_78137_Desc = {
    Text = "「疼痛の鰭」を使用して6回勝利"
  },
  Task_78138_Desc = {
    Text = "「ヘロット」を使用して10回勝利"
  },
  Task_78139_Desc = {Text = "覚醒体"},
  Task_78140_Desc = {
    Text = "「24」を使用して6回勝利"
  },
  Task_78141_Desc = {
    Text = "「カーシア」を使用して6回勝利"
  },
  Task_78142_Desc = {
    Text = "「タヴィ」を使用して6回勝利"
  },
  Task_78143_Desc = {
    Text = "「ゴリアテ」を使用して6回勝利"
  },
  Task_78144_Desc = {
    Text = "「24」を使用して10回勝利"
  },
  Task_78145_Desc = {
    Text = "「神言の石板」を使用して6回勝利"
  },
  Task_78146_Desc = {
    Text = "「永遠の鎮魂歌」を使用して6回勝利"
  },
  Task_78147_Desc = {
    Text = "「懲罰」を使用して6回勝利"
  },
  Task_78148_Desc = {
    Text = "「神の御業」を使用して6回勝利"
  },
  Task_78149_Desc = {
    Text = "「詩の結び」を使用して6回勝利"
  },
  Task_78150_Desc = {
    Text = "「虚無に堕ちた人形」を使用して6回勝利"
  },
  Task_78151_Desc = {
    Text = "「無声の宴」を使用して6回勝利"
  },
  Task_78152_Desc = {
    Text = "「信仰の力」を使用して6回勝利"
  },
  Task_78153_Desc = {
    Text = "「トゥルー」を使用して10回勝利"
  },
  Task_78154_Desc = {
    Text = "「銀ダラの決意」を使用して6回勝利"
  },
  Task_78155_Desc = {
    Text = "「強欲」を使用して6回勝利"
  },
  Task_78159_Desc = {
    Text = "「悟り」を使用して6回勝利"
  },
  Task_78160_Desc = {
    Text = "「灰霧の正体」を使用して6回勝利"
  },
  Task_78161_Desc = {
    Text = "「血肉の宴」を使用して6回勝利"
  },
  Task_78162_Desc = {
    Text = "「ウインクル」を使用して6回勝利"
  },
  Task_78163_Desc = {
    Text = "「百万の寵愛の眼」を使用して6回勝利"
  },
  Task_78164_Desc = {
    Text = "「呟き」を使用して6回勝利"
  },
  Task_78166_Desc = {
    Text = "「ドール」を使用して6回勝利"
  },
  Task_78168_Desc = {
    Text = "「アグリッパ」を使用して10回勝利"
  },
  Task_78169_Desc = {
    Text = "「ロータン」を使用して10回勝利"
  },
  Task_78170_Desc = {
    Text = "「ゴリアテ」を使用して10回勝利"
  },
  Task_78171_Desc = {
    Text = "「深紅に沈む」を使用して6回勝利"
  },
  Task_78172_Desc = {
    Text = "「パンディア」を使用して10回勝利"
  },
  Task_78173_Desc = {
    Text = "「暴食寓話」を使用して6回勝利"
  },
  Task_78174_Desc = {
    Text = "「運命のルーレット」を使用して6回勝利"
  },
  Task_78175_Desc = {
    Text = "「切断と危害」を使用して6回勝利"
  },
  Task_78176_Desc = {
    Text = "「神王の讃歌」を使用して6回勝利"
  },
  Task_78177_Desc = {
    Text = "「溶壊・ドール」を使用して10回勝利"
  },
  Task_78178_Desc = {
    Text = "「レーア」を使用して6回勝利"
  },
  Task_78179_Desc = {
    Text = "運命の札"
  },
  Task_78180_Desc = {
    Text = "「ヘロット」を使用して6回勝利"
  },
  Task_78181_Desc = {
    Text = "「冬の夜の追憶」を使用して6回勝利"
  },
  Task_78182_Desc = {
    Text = "「巨人の覇道」を使用して6回勝利"
  },
  Task_78183_Desc = {
    Text = "「ダフォダイル」を使用して10回勝利"
  },
  Task_78184_Desc = {
    Text = "「導きの帆」を使用して6回勝利"
  },
  Task_78185_Desc = {
    Text = "「ライカー」を使用して6回勝利"
  },
  Task_78186_Desc = {
    Text = "「ファイント」を使用して6回勝利"
  },
  Task_78187_Desc = {
    Text = "「忘却の手」を使用して6回勝利"
  },
  Task_78188_Desc = {
    Text = "「タイス」を使用して6回勝利"
  },
  Task_78189_Desc = {
    Text = "「ニムフィーア」を使用して10回勝利"
  },
  Task_78190_Desc = {
    Text = "「ワンダ」を使用して6回勝利"
  },
  Task_78192_Desc = {
    Text = "「ナウティラ」を使用して6回勝利"
  },
  Task_78193_Desc = {
    Text = "「アイギス」を使用して6回勝利"
  },
  Task_78194_Desc = {
    Text = "「計算不能な演算」を使用して6回勝利"
  },
  Task_78196_Desc = {
    Text = "「女王の戒律」を使用して6回勝利"
  },
  Task_78197_Desc = {
    Text = "「オレッタ」を使用して6回勝利"
  },
  Task_78198_Desc = {
    Text = "「環行・ラモンナ」を使用して10回勝利"
  },
  Task_78199_Desc = {
    Text = "「夜に伏す」を使用して6回勝利"
  },
  Task_78200_Desc = {
    Text = "「血ノ鎖・ヘロット」を使用して6回勝利"
  },
  Task_78201_Desc = {
    Text = "「痛みを越えて」を使用して6回勝利"
  },
  Task_78202_Desc = {
    Text = "「巨人の刃」を使用して6回勝利"
  },
  Task_78203_Desc = {
    Text = "「アルバ」を使用して10回勝利"
  },
  Task_78204_Desc = {
    Text = "「臨界点」を使用して6回勝利"
  },
  Task_78205_Desc = {
    Text = "「珊瑚の女の死」を使用して6回勝利"
  },
  Task_78206_Desc = {
    Text = "「唯一の種子」を使用して6回勝利"
  },
  Task_78208_Desc = {
    Text = "「捕食者の子守唄」を使用して6回勝利"
  },
  Task_78209_Desc = {
    Text = "「親友へ」を使用して6回勝利"
  },
  Task_78210_Desc = {
    Text = "「精神集中」を使用して6回勝利"
  },
  Task_78212_Desc = {
    Text = "「記憶障害」を使用して6回勝利"
  },
  Task_78213_Desc = {
    Text = "「ダフォダイル」を使用して6回勝利"
  },
  Task_78214_Desc = {
    Text = "「雪山が溶けるまで」を使用して6回勝利"
  },
  Task_78216_Desc = {
    Text = "「希望」を使用して6回勝利"
  },
  Task_78217_Desc = {
    Text = "「極夜と暁」を使用して6回勝利"
  },
  Task_78218_Desc = {
    Text = "「マーフィー」を使用して10回勝利"
  },
  Task_78219_Desc = {
    Text = "「不平等な交換」を使用して6回勝利"
  },
  Task_78220_Desc = {
    Text = "「オレッタの宝物」を使用して6回勝利"
  },
  Task_78221_Desc = {
    Text = "「アイギス」を使用して10回勝利"
  },
  Task_78223_Desc = {
    Text = "「貴族の杖」を使用して6回勝利"
  },
  Task_78224_Desc = {
    Text = "「欲望の海」を使用して6回勝利"
  },
  Task_78225_Desc = {
    Text = "「ユウハシュ」を使用して6回勝利"
  },
  Task_78226_Desc = {
    Text = "「ミリアム」を使用して10回勝利"
  },
  Task_78227_Desc = {
    Text = "「ラモンナ」を使用して6回勝利"
  },
  Task_78228_Desc = {
    Text = "「騎士の心」を使用して6回勝利"
  },
  Task_78229_Desc = {
    Text = "「溶壊・ドール」を使用して6回勝利"
  },
  Task_78230_Desc = {
    Text = "「至高の秘蔵品」を使用して6回勝利"
  },
  Task_78231_Desc = {
    Text = "「旅の荷物」を使用して6回勝利"
  },
  Task_78232_Desc = {
    Text = "「庇護」を使用して6回勝利"
  },
  Task_78233_Desc = {
    Text = "「アルバ」を使用して6回勝利"
  },
  Task_78234_Desc = {
    Text = "「最後の誓い」を使用して6回勝利"
  },
  Task_78235_Desc = {
    Text = "「オルラ」を使用して6回勝利"
  },
  Task_78236_Desc = {
    Text = "「暴風雨の中で」を使用して6回勝利"
  },
  Task_78237_Desc = {
    Text = "「ドール」を使用して10回勝利"
  },
  Task_78238_Desc = {
    Text = "「死を超える」を使用して6回勝利"
  },
  Task_78239_Desc = {
    Text = "「星天の獣」を使用して6回勝利"
  },
  Task_78240_Desc = {
    Text = "「咆哮する血と砂」を使用して6回勝利"
  },
  Task_78241_Desc = {
    Text = "「湖畔の回想」を使用して6回勝利"
  },
  Task_78242_Desc = {
    Text = "「ジェンキン」を使用して10回勝利"
  },
  Task_78243_Desc = {
    Text = "キーオーダー"
  },
  Task_78244_Desc = {
    Text = "「蒼白の末裔」を使用して6回勝利"
  },
  Task_78245_Desc = {
    Text = "「カエクス」を使用して6回勝利"
  },
  Task_78246_Desc = {
    Text = "「ハムリン」を使用して6回勝利"
  },
  Task_78247_Desc = {
    Text = "「オルラ」を使用して10回勝利"
  },
  Task_78248_Desc = {
    Text = "「核溶解」を使用して6回勝利"
  },
  Task_78249_Desc = {
    Text = "「錯乱」を使用して6回勝利"
  },
  Task_78250_Desc = {
    Text = "「秘められた誕生」を使用して6回勝利"
  },
  Task_78251_Desc = {
    Text = "「オレッタ」を使用して10回勝利"
  },
  Task_78252_Desc = {
    Text = "「マーフィー」を使用して6回勝利"
  },
  Task_78253_Desc = {
    Text = "「純銀の初心」を使用して6回勝利"
  },
  Task_78254_Desc = {
    Text = "「トゥルー」を使用して6回勝利"
  },
  Task_78255_Desc = {
    Text = "「サンガー」を使用して6回勝利"
  },
  Task_78256_Desc = {
    Text = "「ジェンキン」を使用して6回勝利"
  },
  Task_78257_Desc = {
    Text = "「ウインクル」を使用して10回勝利"
  },
  Task_78258_Desc = {
    Text = "「ワンダ」を使用して10回勝利"
  },
  Task_78261_Desc = {
    Text = "「時を遡る時計」を使用して6回勝利"
  },
  Task_78262_Desc = {
    Text = "「薔薇の勝利」を使用して6回勝利"
  },
  Task_78263_Desc = {
    Text = "「オジール」を使用して10回勝利"
  },
  Task_78264_Desc = {
    Text = "「ファロス」を使用して6回勝利"
  },
  Task_78265_Desc = {
    Text = "「ファイント」を使用して10回勝利"
  },
  Task_78266_Desc = {
    Text = "「ハムリン」を使用して10回勝利"
  },
  Task_78267_Desc = {
    Text = "「慈悲の育み」を使用して6回勝利"
  },
  Task_78269_Desc = {
    Text = "「死の分析」を使用して6回勝利"
  },
  Task_78270_Desc = {
    Text = "「熟成」を使用して6回勝利"
  },
  Task_78272_Desc = {
    Text = "「情報は命」を使用して6回勝利"
  },
  Task_78273_Desc = {
    Text = "「骨を蝕む抱擁」を使用して6回勝利"
  },
  Task_78274_Desc = {
    Text = "「サンガー」を使用して10回勝利"
  },
  Task_78275_Desc = {
    Text = "「氷河の眠り」を使用して6回勝利"
  },
  Task_78276_Desc = {
    Text = "「エリカ」を使用して6回勝利"
  },
  Task_78277_Desc = {
    Text = "「隠世の転輪」を使用して6回勝利"
  },
  Task_78278_Desc = {
    Text = "「35mmの魔法」を使用して6回勝利"
  },
  Task_78279_Desc = {
    Text = "「頭の中の音」を使用して6回勝利"
  },
  Task_78280_Desc = {
    Text = "「幸運の時」を使用して6回勝利"
  },
  Task_78281_Desc = {
    Text = "「カレン」を使用して10回勝利"
  },
  Task_78282_Desc = {
    Text = "「タヴィ」を使用して10回勝利"
  },
  Task_78283_Desc = {
    Text = "「ユウハシュ」を使用して10回勝利"
  },
  Task_78284_Desc = {
    Text = "「リッツ」を使用して10回勝利"
  },
  Task_78286_Desc = {
    Text = "「心の障壁」を使用して6回勝利"
  },
  Task_78287_Desc = {
    Text = "「カーシア」を使用して10回勝利"
  },
  Task_78288_Desc = {
    Text = "「奇体の反噬」を使用して6回勝利"
  },
  Task_78289_Desc = {
    Text = "「永劫の演奏」を使用して6回勝利"
  },
  Task_78290_Desc = {
    Text = "「苦しみの呪縛」を使用して6回勝利"
  },
  Task_78291_Desc = {
    Text = "「シレスト」を使用して10回勝利"
  },
  Task_78292_Desc = {
    Text = "「存在しない場所」を使用して6回勝利"
  },
  Task_78294_Desc = {
    Text = "「ティンクト」を使用して10回勝利"
  },
  Task_78295_Desc = {
    Text = "「ファロス」を使用して10回勝利"
  },
  Task_78296_Desc = {
    Text = "「リリー」を使用して10回勝利"
  },
  Task_78297_Desc = {
    Text = "「儚き永遠」を使用して6回勝利"
  },
  Task_78298_Desc = {
    Text = "「活性」を使用して6回勝利"
  },
  Task_78299_Desc = {
    Text = "「ナウティラ」を使用して10回勝利"
  },
  Task_78301_Desc = {
    Text = "「サルバドル」を使用して6回勝利"
  },
  Task_78303_Desc = {
    Text = "「吸収」を使用して6回勝利"
  },
  Task_78304_Desc = {
    Text = "「カエクス」を使用して10回勝利"
  },
  Task_78305_Desc = {
    Text = "「オジール」を使用して6回勝利"
  },
  Task_78306_Desc = {
    Text = "「職責」を使用して6回勝利"
  },
  Task_78307_Desc = {
    Text = "「ソレール」を使用して10回勝利"
  },
  Task_78308_Desc = {
    Text = "「マジックショー」を使用して6回勝利"
  },
  Task_78309_Desc = {
    Text = "「洞察」を使用して6回勝利"
  },
  Task_78310_Desc = {
    Text = "「シレスト」を使用して6回勝利"
  },
  Task_78313_Desc = {
    Text = "「湧出」を使用して6回勝利"
  },
  Task_78314_Desc = {
    Text = "「レーア」を使用して10回勝利"
  },
  Task_78315_Desc = {
    Text = "「縛られた歌」を使用して6回勝利"
  },
  Task_78316_Desc = {
    Text = "「ソレール」を使用して6回勝利"
  },
  Task_78317_Desc = {
    Text = "「カレン」を使用して6回勝利"
  },
  Task_78318_Desc = {
    Text = "カードを出す"
  },
  Task_78319_Desc = {
    Text = "「ロータン」を使用して6回勝利"
  },
  Task_78320_Desc = {
    Text = "「腐朽の贈り物」を使用して6回勝利"
  },
  Task_78321_Desc = {
    Text = "「タイス」を使用して10回勝利"
  },
  Task_78322_Desc = {
    Text = "「記憶螺旋」を使用して6回勝利"
  },
  Task_78326_Desc = {
    Text = "ケティグラの同調率がレベル10に到達する"
  },
  Task_78327_Desc = {
    Text = "アヤヴァゴモンの同調率がレベル10に到達する"
  },
  Task_78328_Desc = {
    Text = "ポリュクスの同調率がレベル10に到達する"
  },
  Task_78329_Desc = {
    Text = "ハゲワシの同調率がレベル10に到達する"
  },
  Task_78332_Desc = {
    Text = "ランティゴスの同調率がレベル10に到達する"
  },
  Task_78333_Desc = {
    Text = "カラブの同調率がレベル10に到達する"
  },
  Task_78334_Desc = {
    Text = "コーパサント同調率がレベル10に到達する"
  },
  Task_78336_Desc = {
    Text = "アラクネの同調率がレベル10に到達する"
  },
  Task_78338_Desc = {
    Text = "ファラオの同調率がレベル10に到達する"
  },
  Task_78339_Desc = {
    Text = "シャタク鳥の同調率がレベル10に到達する"
  },
  Task_78340_Desc = {
    Text = "ピックマンの同調率がレベル10に到達する"
  },
  Task_78341_Desc = {
    Text = "クレメンタインの同調率がレベル10に到達する"
  },
  Task_78342_Desc = {
    Text = "カストルの同調率がレベル10に到達する"
  },
  Task_78366_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78367_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78368_Desc = {
    Text = "シャタク鳥の霊知啓発6を獲得する"
  },
  Task_78368_Name = {
    Text = "シャタク鳥の霊知啓発6を獲得する"
  },
  Task_78368_UnlockCondDesc = {
    Text = "イベント@覚醒体シャタク鳥霊知啓発ギフト2"
  },
  Task_78369_Desc = {
    Text = "ケティグラの霊知啓発6を獲得する"
  },
  Task_78369_Name = {
    Text = "ケティグラの霊知啓発6を獲得する"
  },
  Task_78369_UnlockCondDesc = {
    Text = "イベント@覚醒体ケティグラ霊知啓発ギフト2"
  },
  Task_78370_Desc = {
    Text = "シャタク鳥の霊知啓発2を獲得する"
  },
  Task_78370_Name = {
    Text = "シャタク鳥の霊知啓発2を獲得する"
  },
  Task_78370_UnlockCondDesc = {
    Text = "イベント@覚醒体シャタク鳥霊知啓発ギフト2"
  },
  Task_78371_Desc = {
    Text = "ケティグラの霊知啓発2を獲得する"
  },
  Task_78371_Name = {
    Text = "ケティグラの霊知啓発2を獲得する"
  },
  Task_78371_UnlockCondDesc = {
    Text = "イベント@覚醒体ケティグラ霊知啓発ギフト2"
  },
  Task_78372_Desc = {
    Text = "ポリュクスの霊知啓発2を獲得する"
  },
  Task_78372_Name = {
    Text = "ポリュクスの霊知啓発2を獲得する"
  },
  Task_78372_UnlockCondDesc = {
    Text = "イベント@覚醒体ポリュクス霊知啓発ギフト2"
  },
  Task_78373_Desc = {
    Text = "ポリュクスの霊知啓発6を獲得する"
  },
  Task_78373_Name = {
    Text = "ポリュクスの霊知啓発6を獲得する"
  },
  Task_78373_UnlockCondDesc = {
    Text = "イベント@覚醒体ポリュクス霊知啓発ギフト2"
  },
  Task_78375_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78379_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78380_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78382_Desc = {
    Text = "アラクネの霊知啓発6を獲得する"
  },
  Task_78382_Name = {
    Text = "アラクネの霊知啓発6を獲得する"
  },
  Task_78382_UnlockCondDesc = {
    Text = "イベント@覚醒体アラクネ霊知啓発ギフト2"
  },
  Task_78383_Desc = {
    Text = "アラクネの霊知啓発2を獲得する"
  },
  Task_78383_Name = {
    Text = "アラクネの霊知啓発2を獲得する"
  },
  Task_78383_UnlockCondDesc = {
    Text = "イベント@覚醒体アラクネ霊知啓発ギフト2"
  },
  Task_78384_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78385_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78390_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78391_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78394_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78395_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78396_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78397_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78400_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78401_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78402_Desc = {
    Text = "ピックマンの霊知啓発6を獲得する"
  },
  Task_78402_Name = {
    Text = "ピックマンの霊知啓発6を獲得する"
  },
  Task_78402_UnlockCondDesc = {
    Text = "イベント@覚醒体ピックマン霊知啓発ギフト2"
  },
  Task_78403_Desc = {
    Text = "ピックマンの霊知啓発2を獲得する"
  },
  Task_78403_Name = {
    Text = "ピックマンの霊知啓発2を獲得する"
  },
  Task_78403_UnlockCondDesc = {
    Text = "イベント@覚醒体ピックマン霊知啓発ギフト2"
  },
  Task_78404_Desc = {
    Text = "カストルの霊知啓発2を獲得する"
  },
  Task_78404_Name = {
    Text = "カストルの霊知啓発2を獲得する"
  },
  Task_78404_UnlockCondDesc = {
    Text = "イベント@覚醒体カストル霊知啓発ギフト2"
  },
  Task_78405_Desc = {
    Text = "カストルの霊知啓発6を獲得する"
  },
  Task_78405_Name = {
    Text = "カストルの霊知啓発6を獲得する"
  },
  Task_78405_UnlockCondDesc = {
    Text = "イベント@覚醒体カストル霊知啓発ギフト2"
  },
  Task_78409_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78415_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78416_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78418_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78419_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78421_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78423_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78424_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78426_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78429_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78430_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78431_Desc = {
    Text = "カラブの霊知啓発2を獲得する"
  },
  Task_78431_Name = {
    Text = "カラブの霊知啓発2を獲得する"
  },
  Task_78431_UnlockCondDesc = {
    Text = "イベント@覚醒体カラブ霊知啓発ギフト2"
  },
  Task_78432_Desc = {
    Text = "カラブの霊知啓発6を獲得する"
  },
  Task_78432_Name = {
    Text = "カラブの霊知啓発6を獲得する"
  },
  Task_78432_UnlockCondDesc = {
    Text = "イベント@覚醒体カラブ霊知啓発ギフト2"
  },
  Task_78435_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78436_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78437_Desc = {
    Text = "アヴァゴモンの霊知啓発2を獲得する"
  },
  Task_78437_Name = {
    Text = "アヴァゴモンの霊知啓発2を獲得する"
  },
  Task_78437_UnlockCondDesc = {
    Text = "イベント@覚醒体アヴァルゴモン霊知啓発ギフト2"
  },
  Task_78438_Desc = {
    Text = "クレメンタインの霊知啓発2を獲得する"
  },
  Task_78438_Name = {
    Text = "クレメンタインの霊知啓発2を獲得する"
  },
  Task_78438_UnlockCondDesc = {
    Text = "イベント@覚醒体クレメンタイン霊知啓発ギフト2"
  },
  Task_78440_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78441_Desc = {
    Text = "クレメンタインの霊知啓発6を獲得する"
  },
  Task_78441_Name = {
    Text = "クレメンタインの霊知啓発6を獲得する"
  },
  Task_78441_UnlockCondDesc = {
    Text = "イベント@覚醒体クレメンタイン霊知啓発ギフト2"
  },
  Task_78446_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78447_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78449_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78450_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78451_Desc = {
    Text = "ファラオの霊知啓発2を獲得する"
  },
  Task_78451_Name = {
    Text = "ファラオの霊知啓発2を獲得する"
  },
  Task_78451_UnlockCondDesc = {
    Text = "イベント@覚醒体ファラオ霊知啓発ギフト2"
  },
  Task_78453_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78458_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78459_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78460_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78466_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78468_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78470_Desc = {
    Text = "ファラオの霊知啓発6を獲得する"
  },
  Task_78470_Name = {
    Text = "ファラオの霊知啓発6を獲得する"
  },
  Task_78470_UnlockCondDesc = {
    Text = "イベント@覚醒体ファラオ霊知啓発ギフト2"
  },
  Task_78476_Desc = {
    Text = "ランティゴスの霊知啓発6を獲得する"
  },
  Task_78476_Name = {
    Text = "ランティゴスの霊知啓発6を獲得する"
  },
  Task_78476_UnlockCondDesc = {
    Text = "イベント@覚醒体ランティゴス霊知啓発ギフト2"
  },
  Task_78477_Desc = {
    Text = "ランティゴスの霊知啓発2を獲得する"
  },
  Task_78477_Name = {
    Text = "ランティゴスの霊知啓発2を獲得する"
  },
  Task_78477_UnlockCondDesc = {
    Text = "イベント@覚醒体ランティゴス霊知啓発ギフト2"
  },
  Task_78481_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78483_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78484_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78485_Desc = {
    Text = "ハゲワシの霊知啓発2を獲得する"
  },
  Task_78485_Name = {
    Text = "ハゲワシの霊知啓発2を獲得する"
  },
  Task_78485_UnlockCondDesc = {
    Text = "イベント@覚醒体ハゲワシ霊知啓発ギフト2"
  },
  Task_78486_Desc = {
    Text = "ハゲワシの霊知啓発6を獲得する"
  },
  Task_78486_Name = {
    Text = "ハゲワシの霊知啓発6を獲得する"
  },
  Task_78486_UnlockCondDesc = {
    Text = "イベント@覚醒体ハゲワシ霊知啓発ギフト2"
  },
  Task_78487_Desc = {
    Text = "アヴァゴモンの霊知啓発6を獲得する"
  },
  Task_78487_Name = {
    Text = "アヴァゴモンの霊知啓発6を獲得する"
  },
  Task_78487_UnlockCondDesc = {
    Text = "イベント@覚醒体アヴァルゴモン霊知啓発ギフト2"
  },
  Task_78488_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78489_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78492_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78493_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78495_Desc = {
    Text = "コーパサントの霊知啓発6を獲得する"
  },
  Task_78495_Name = {
    Text = "コーパサントの霊知啓発6を獲得する"
  },
  Task_78495_UnlockCondDesc = {
    Text = "イベント@覚醒体コーパサント霊知啓発ギフト2"
  },
  Task_78496_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78497_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78499_Desc = {
    Text = "コーパサントの霊知啓発2を獲得する"
  },
  Task_78499_Name = {
    Text = "コーパサントの霊知啓発2を獲得する"
  },
  Task_78499_UnlockCondDesc = {
    Text = "イベント@覚醒体コーパサント霊知啓発ギフト2"
  },
  Task_78573_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78574_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78576_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78577_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78599_Desc = {
    Text = "最終戦で13ターン以内に勝利"
  },
  Task_78599_Name = {
    Text = "最終戦で13ターン以内に勝利"
  },
  Task_78600_Desc = {
    Text = "最終戦で14ターン以内に勝利"
  },
  Task_78600_Name = {
    Text = "最終戦で14ターン以内に勝利"
  },
  Task_78718_Desc = {
    Text = "血肉界域の覚醒体を使用し「記憶の収集」で2回勝利"
  },
  Task_78719_Desc = {
    Text = "混沌界域の覚醒体を使用し「記憶の収集」で2回勝利"
  },
  Task_78720_Desc = {
    Text = "深海界域の覚醒体を使用し「記憶の収集」で2回勝利"
  },
  Task_78721_Desc = {
    Text = "超次元界域の覚醒体を使用し「記憶の収集」で2回勝利"
  },
  Task_78723_Desc = {
    Text = "暗潮虫鳴Ⅱ"
  },
  Task_78724_Desc = {
    Text = "暗潮虫鳴Ⅰ"
  },
  Task_78725_Desc = {
    Text = "暗潮虫鳴Ⅶ"
  },
  Task_78726_Desc = {
    Text = "暗潮虫鳴Ⅴ"
  },
  Task_78727_Desc = {
    Text = "暗潮虫鳴・無料"
  },
  Task_78728_Desc = {
    Text = "暗潮虫鳴Ⅵ"
  },
  Task_78729_Desc = {
    Text = "暗潮虫鳴Ⅲ"
  },
  Task_78730_Desc = {
    Text = "暗潮虫鳴Ⅳ"
  },
  Task_78740_Desc = {
    Text = "真貌・眠れる主の霊知啓発6を獲得する"
  },
  Task_78740_Name = {
    Text = "真貌・眠れる主の霊知啓発6を獲得する"
  },
  Task_78740_UnlockCondDesc = {
    Text = "イベント@覚醒体真貌・眠れる主霊知啓発ギフト2"
  },
  Task_78741_Desc = {
    Text = "真貌・眠れる主の同調率がレベル10に到達する"
  },
  Task_78742_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78743_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78745_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78746_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78748_Desc = {
    Text = "真貌・眠れる主の霊知啓発2を獲得する"
  },
  Task_78748_Name = {
    Text = "真貌・眠れる主の霊知啓発2を獲得する"
  },
  Task_78748_UnlockCondDesc = {
    Text = "イベント@覚醒体真貌・眠れる主霊知啓発ギフト2"
  },
  Task_78763_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78764_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78766_Desc = {
    Text = "真貌・深海の淑女の霊知啓発2を獲得する"
  },
  Task_78766_Name = {
    Text = "真貌・深海の淑女の霊知啓発2を獲得する"
  },
  Task_78766_UnlockCondDesc = {
    Text = "イベント@覚醒体真貌・深海の淑女霊知啓発ギフト2"
  },
  Task_78767_Desc = {
    Text = "真貌・深海の淑女の霊知啓発6を獲得する"
  },
  Task_78767_Name = {
    Text = "真貌・深海の淑女の霊知啓発6を獲得する"
  },
  Task_78767_UnlockCondDesc = {
    Text = "イベント@覚醒体真貌・深海の淑女霊知啓発ギフト2"
  },
  Task_78768_Desc = {
    Text = "真貌・深海の淑女の同調率がレベル10に到達する"
  },
  Task_78769_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_78770_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_79259_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_79259_Name = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_79283_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_79283_Name = {
    Text = "完璧な通過"
  },
  Task_79284_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_79284_Name = {
    Text = "完璧な通過"
  },
  Task_79285_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_79285_Name = {
    Text = "完璧な通過"
  },
  Task_79286_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_79286_Name = {
    Text = "完璧な通過"
  },
  Task_79287_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_79287_Name = {
    Text = "完璧な通過"
  },
  Task_79288_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_79288_Name = {
    Text = "完璧な通過"
  },
  Task_79289_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_79289_Name = {
    Text = "完璧な通過"
  },
  Task_79290_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_79290_Name = {
    Text = "完璧な通過"
  },
  Task_79291_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_79291_Name = {
    Text = "完璧な通過"
  },
  Task_79292_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_79292_Name = {
    Text = "完璧な通過"
  },
  Task_79304_Desc = {
    Text = "「純白の出会い」を使用して1回勝利"
  },
  Task_79305_Desc = {
    Text = "「落日」を使用して1回勝利"
  },
  Task_79306_Desc = {
    Text = "「虚無の疫病」を使用して1回勝利"
  },
  Task_79307_Desc = {
    Text = "「回れ回れ」を使用して6回勝利"
  },
  Task_79308_Desc = {
    Text = "「鼠の知恵」を使用して1回勝利"
  },
  Task_79309_Desc = {
    Text = "「純白の出会い」を使用して3回勝利"
  },
  Task_79310_Desc = {
    Text = "「熱い別れのキス」を使用して6回勝利"
  },
  Task_79311_Desc = {
    Text = "「落日」を使用して3回勝利"
  },
  Task_79312_Desc = {
    Text = "「羊飼いの杖」を使用して3回勝利"
  },
  Task_79313_Desc = {
    Text = "「不朽の葬儀」を使用して1回勝利"
  },
  Task_79314_Desc = {
    Text = "「鼠の知恵」を使用して3回勝利"
  },
  Task_79315_Desc = {
    Text = "「銀嶺の覚悟」を使用して3回勝利"
  },
  Task_79316_Desc = {
    Text = "「小さな願い」を使用して3回勝利"
  },
  Task_79317_Desc = {
    Text = "「魂の誕生」を使用して1回勝利"
  },
  Task_79318_Desc = {
    Text = "「深海の呼び声」を使用して6回勝利"
  },
  Task_79319_Desc = {
    Text = "「腐敗の饗宴」を使用して6回勝利"
  },
  Task_79320_Desc = {
    Text = "「星々の加護」を使用して3回勝利"
  },
  Task_79321_Desc = {
    Text = "「腐敗の饗宴」を使用して3回勝利"
  },
  Task_79322_Desc = {
    Text = "「扉の彼方の真実」を使用して1回勝利"
  },
  Task_79323_Desc = {
    Text = "「羊飼いの杖」を使用して6回勝利"
  },
  Task_79324_Desc = {
    Text = "「深海の呼び声」を使用して1回勝利"
  },
  Task_79325_Desc = {
    Text = "「深海の呼び声」を使用して3回勝利"
  },
  Task_79326_Desc = {
    Text = "「虚無の疫病」を使用して3回勝利"
  },
  Task_79327_Desc = {
    Text = "「春の詩集」を使用して6回勝利"
  },
  Task_79328_Desc = {
    Text = "「一発の銃声」を使用して1回勝利"
  },
  Task_79329_Desc = {
    Text = "「不朽の葬儀」を使用して3回勝利"
  },
  Task_79330_Desc = {
    Text = "「酒場の扉」を使用して1回勝利"
  },
  Task_79331_Desc = {
    Text = "「永遠の執念」を使用して3回勝利"
  },
  Task_79332_Desc = {
    Text = "「小さな願い」を使用して1回勝利"
  },
  Task_79333_Desc = {
    Text = "「扉の彼方の真実」を使用して6回勝利"
  },
  Task_79334_Desc = {
    Text = "「青石の玉座」を使用して6回勝利"
  },
  Task_79335_Desc = {
    Text = "「星々の加護」を使用して1回勝利"
  },
  Task_79336_Desc = {
    Text = "「銀嶺の覚悟」を使用して6回勝利"
  },
  Task_79337_Desc = {
    Text = "「落日」を使用して6回勝利"
  },
  Task_79338_Desc = {
    Text = "「アクートの春」を使用して6回勝利"
  },
  Task_79339_Desc = {
    Text = "「鼠の知恵」を使用して6回勝利"
  },
  Task_79340_Desc = {
    Text = "「暴食」を使用して6回勝利"
  },
  Task_79341_Desc = {
    Text = "「不朽の葬儀」を使用して6回勝利"
  },
  Task_79342_Desc = {
    Text = "「海の祭」を使用して6回勝利"
  },
  Task_79343_Desc = {
    Text = "「注射の加護」を使用して1回勝利"
  },
  Task_79344_Desc = {
    Text = "「注射の加護」を使用して3回勝利"
  },
  Task_79345_Desc = {
    Text = "「酒場の扉」を使用して3回勝利"
  },
  Task_79346_Desc = {
    Text = "「昔日の花と詩」を使用して3回勝利"
  },
  Task_79347_Desc = {
    Text = "「回れ回れ」を使用して1回勝利"
  },
  Task_79348_Desc = {
    Text = "「魔女のつば広帽子」を使用して6回勝利"
  },
  Task_79349_Desc = {
    Text = "「回帰の扉を越え」を使用して3回勝利"
  },
  Task_79350_Desc = {
    Text = "「第四楽章」を使用して6回勝利"
  },
  Task_79351_Desc = {
    Text = "「青石の玉座」を使用して1回勝利"
  },
  Task_79352_Desc = {
    Text = "「第四楽章」を使用して1回勝利"
  },
  Task_79353_Desc = {
    Text = "「酒場の扉」を使用して6回勝利"
  },
  Task_79354_Desc = {
    Text = "「虚無の疫病」を使用して6回勝利"
  },
  Task_79355_Desc = {
    Text = "「一発の銃声」を使用して6回勝利"
  },
  Task_79356_Desc = {
    Text = "「魔女のつば広帽子」を使用して1回勝利"
  },
  Task_79357_Desc = {
    Text = "「回れ回れ」を使用して3回勝利"
  },
  Task_79358_Desc = {
    Text = "「腐敗の饗宴」を使用して1回勝利"
  },
  Task_79359_Desc = {
    Text = "「青石の玉座」を使用して3回勝利"
  },
  Task_79360_Desc = {
    Text = "「熱い別れのキス」を使用して3回勝利"
  },
  Task_79361_Desc = {
    Text = "「魂の誕生」を使用して3回勝利"
  },
  Task_79362_Desc = {
    Text = "「永遠の執念」を使用して1回勝利"
  },
  Task_79363_Desc = {
    Text = "「回帰の扉を越え」を使用して1回勝利"
  },
  Task_79364_Desc = {
    Text = "「熱い別れのキス」を使用して1回勝利"
  },
  Task_79365_Desc = {
    Text = "「昔日の花と詩」を使用して6回勝利"
  },
  Task_79366_Desc = {
    Text = "「星々の加護」を使用して6回勝利"
  },
  Task_79367_Desc = {
    Text = "「春の詩集」を使用して1回勝利"
  },
  Task_79368_Desc = {
    Text = "「銀嶺の覚悟」を使用して1回勝利"
  },
  Task_79369_Desc = {
    Text = "「アクートの春」を使用して3回勝利"
  },
  Task_79370_Desc = {
    Text = "「注射の加護」を使用して6回勝利"
  },
  Task_79371_Desc = {
    Text = "「魔女のつば広帽子」を使用して3回勝利"
  },
  Task_79372_Desc = {
    Text = "「海の祭」を使用して3回勝利"
  },
  Task_79373_Desc = {
    Text = "「回帰の扉を越え」を使用して6回勝利"
  },
  Task_79374_Desc = {
    Text = "「純白の出会い」を使用して6回勝利"
  },
  Task_79375_Desc = {
    Text = "「小さな願い」を使用して6回勝利"
  },
  Task_79376_Desc = {
    Text = "「暴食」を使用して3回勝利"
  },
  Task_79377_Desc = {
    Text = "「海の祭」を使用して1回勝利"
  },
  Task_79378_Desc = {
    Text = "「第四楽章」を使用して3回勝利"
  },
  Task_79379_Desc = {
    Text = "「暴食」を使用して1回勝利"
  },
  Task_79380_Desc = {
    Text = "「扉の彼方の真実」を使用して3回勝利"
  },
  Task_79381_Desc = {
    Text = "「昔日の花と詩」を使用して1回勝利"
  },
  Task_79382_Desc = {
    Text = "「羊飼いの杖」を使用して1回勝利"
  },
  Task_79383_Desc = {
    Text = "「一発の銃声」を使用して3回勝利"
  },
  Task_79384_Desc = {
    Text = "「魂の誕生」を使用して6回勝利"
  },
  Task_79385_Desc = {
    Text = "「アクートの春」を使用して1回勝利"
  },
  Task_79386_Desc = {
    Text = "「永遠の執念」を使用して6回勝利"
  },
  Task_79387_Desc = {
    Text = "「春の詩集」を使用して3回勝利"
  },
  Task_79483_Desc = {
    Text = "恐怖治療・境界"
  },
  Task_79484_Desc = {
    Text = "深海領域の覚醒体を使用して、「恐怖の癒し」で2回勝利する"
  },
  Task_79485_Desc = {
    Text = "深海境界覚醒体を使用して「恐怖の治療」で1回勝利する"
  },
  Task_79486_Desc = {
    Text = "「記憶クリニック」の任意の難易度をクリアする"
  },
  Task_79487_Desc = {
    Text = "超次元領域覚醒体を使用して「恐怖の治療」に2回勝利する"
  },
  Task_79488_Desc = {
    Text = "超次元領域覚醒体を使用して「恐怖療法」で1回勝利する"
  },
  Task_79489_Desc = {
    Text = "「新生」狂気の難易度をクリア"
  },
  Task_79490_Desc = {
    Text = "恐怖回復·クリア"
  },
  Task_79491_Desc = {
    Text = "「炎の蛾」の任意の難易度をクリアする"
  },
  Task_79492_Desc = {
    Text = "血肉界域の覚醒体を使用して「恐怖の癒し」で一度勝利する"
  },
  Task_79493_Desc = {
    Text = "使用血肉境界の覚醒体を「恐怖の癒し」で2回勝利する"
  },
  Task_79494_Desc = {
    Text = "「新生」の任意難易度をクリアする"
  },
  Task_79495_Desc = {
    Text = "「燃える世界」狂気難易度をクリア"
  },
  Task_79496_Desc = {
    Text = "「侵夢の時」狂気の難易度をクリア"
  },
  Task_79497_Desc = {
    Text = "「記憶クリニック」の任意の難易度をクリアする"
  },
  Task_79498_Desc = {
    Text = "「炎の蛾」の任意の難易度をクリアする"
  },
  Task_79499_Desc = {
    Text = "「燃える世界」の任意の難易度をクリアする"
  },
  Task_79500_Desc = {
    Text = "恐怖ヒーリング・狂気"
  },
  Task_79501_Desc = {
    Text = "「燃える世界」の任意の難易度をクリアする"
  },
  Task_79502_Desc = {
    Text = "「侵夢の時」の任意の難易度をクリアする"
  },
  Task_79503_Desc = {
    Text = "混沌界域覚醒体を使用して「恐怖の癒し」で1回勝利する"
  },
  Task_79504_Desc = {
    Text = "「恐怖の治療」でカオス境界の覚醒体を活用して2回勝利する"
  },
  Task_79505_Desc = {
    Text = "「新生」の任意難易度をクリアする"
  },
  Task_79506_Desc = {
    Text = "「炎の蛾」狂気の難易度クリア"
  },
  Task_79507_Desc = {
    Text = "「恐怖治療・クリア」のすべての任務を完了"
  },
  Task_79508_Desc = {
    Text = "「侵夢の時」の任意の難易度をクリアする"
  },
  Task_79509_Desc = {
    Text = "「記憶クリニック」の狂気の難易度をクリア"
  },
  Task_79747_Desc = {
    Text = "クレメンティーンを得る"
  },
  Task_79747_Name = {
    Text = "クレメンティーンを得る"
  },
  Task_80218_Desc = {
    Text = "道を塞ぐ「住民」を撃破せよ"
  },
  Task_80218_Name = {Text = "目標"},
  Task_80219_Desc = {
    Text = "生命儀式を阻止する"
  },
  Task_80219_Name = {Text = "目標"},
  Task_80220_Desc = {
    Text = "宇宙@2の投影を撃破します"
  },
  Task_80220_Name = {Text = "目標"},
  Task_80221_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_80221_Name = {
    Text = "完璧な通過"
  },
  Task_80222_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_80222_Name = {
    Text = "完璧な通過"
  },
  Task_80223_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_80223_Name = {
    Text = "完璧な通過"
  },
  Task_80224_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_80224_Name = {
    Text = "完璧な通過"
  },
  Task_80225_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_80225_Name = {
    Text = "完璧な通過"
  },
  Task_80226_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_80226_Name = {
    Text = "完璧な通過"
  },
  Task_80227_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_80227_Name = {
    Text = "完璧な通過"
  },
  Task_80228_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_80228_Name = {
    Text = "完璧な通過"
  },
  Task_80229_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_80229_Name = {
    Text = "完璧な通過"
  },
  Task_80230_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_80230_Name = {
    Text = "完璧な通過"
  },
  Task_80231_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_80231_Name = {
    Text = "完璧な通過"
  },
  Task_80232_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_80232_Name = {
    Text = "完璧な通過"
  },
  Task_80233_Desc = {
    Text = "「ラモナ」を確認"
  },
  Task_80233_Name = {Text = "目標"},
  Task_80234_Desc = {
    Text = "巡回隊に捕まらないようにする"
  },
  Task_80234_Name = {Text = "目標"},
  Task_80235_Desc = {
    Text = "「クレメンティン」たちを振り切る"
  },
  Task_80235_Name = {Text = "目標"},
  Task_80236_Desc = {
    Text = "クレメンタインの診療室へ向かいます"
  },
  Task_80236_Name = {Text = "目標"},
  Task_80237_Desc = {Text = "帰宅"},
  Task_80237_Name = {Text = "目標"},
  Task_80238_Desc = {
    Text = "ヘルベルトの「収容」を阻止する"
  },
  Task_80238_Name = {Text = "目標"},
  Task_80239_Desc = {
    Text = "医者の追跡から逃れる"
  },
  Task_80239_Name = {Text = "目標"},
  Task_80240_Desc = {
    Text = "アルビノの記憶に深く入り込む"
  },
  Task_80240_Name = {Text = "目標"},
  Task_80241_Desc = {
    Text = "狂気を抑圧する患者"
  },
  Task_80241_Name = {Text = "目標"},
  Task_80286_Desc = {
    Text = "星辰編第2章2-9をクリアする"
  },
  Task_80287_Desc = {
    Text = "星辰編第2章2-6 難易度をクリアする"
  },
  Task_80288_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_80288_Desc2 = {
    Text = "調査事件「蜕変」を完了"
  },
  Task_80288_Name2 = {
    Text = "宇宙の唸りを聴く"
  },
  Task_80289_Desc = {
    Text = "調査事件「蜕変」を難易度で完了"
  },
  Task_80289_Name = {
    Text = "宇宙の唸り・難易度"
  },
  Task_80290_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_80291_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_80292_Desc = {
    Text = "通関星辰篇第2章「変革」"
  },
  Task_80293_Desc = {
    Text = "通関星辰篇第2章「変革」困難難易度"
  },
  Task_80294_Desc = {
    Text = "星辰編第2章2-6 難易度をクリアする"
  },
  Task_80295_Desc = {
    Text = "調査「@1@2」で9回共鳴する"
  },
  Task_80295_Desc2 = {
    Text = "「蜕変」事件の調査で9回の共鳴"
  },
  Task_80295_Name2 = {
    Text = "変異の響きⅢ"
  },
  Task_80296_Desc = {
    Text = "調査「@1@2」で6回共鳴する"
  },
  Task_80296_Desc2 = {
    Text = "調査イベント「変容」で共鳴 6 回"
  },
  Task_80296_Name2 = {
    Text = "変異の響きⅡ"
  },
  Task_80297_Desc = {
    Text = "調査「@1@2」で3回共鳴する"
  },
  Task_80297_Desc2 = {
    Text = "調査イベント「変容」で共鳴 3 回"
  },
  Task_80297_Name2 = {
    Text = "変異の響き"
  },
  Task_80298_Desc = {
    Text = "星辰編第2章2-9をクリアする"
  },
  Task_80299_Desc = {
    Text = "調査「@1@2」で11回共鳴する"
  },
  Task_80299_Desc2 = {
    Text = "「蜕変」事件の調査で11回の共鳴"
  },
  Task_80299_Name2 = {
    Text = "変異の響きⅣ"
  },
  Task_80300_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_80301_Desc = {
    Text = "通関星辰篇第2章「変革」"
  },
  Task_80302_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_80303_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_80304_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_80305_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_80306_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_80307_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_80309_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_80310_Desc = {
    Text = "通関星辰篇第2章「変革」困難難易度"
  },
  Task_80419_Name = {
    Text = "星辰篇2_18を再挑戦する"
  },
  Task_80433_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_80433_Name = {Text = "10勝"},
  Task_80434_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_80434_Name = {Text = "6勝"},
  Task_80435_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_80435_Name = {Text = "3勝"},
  Task_80436_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_80436_Name = {Text = "1勝"},
  Task_80993_Desc = {
    Text = "掃除ツールが達成されました"
  },
  Task_80994_Desc = {
    Text = "任意の3つの任務を完了"
  },
  Task_80994_Name = {
    Text = "今日の掃除は完了！"
  },
  Task_80995_Desc = {
    Text = "イベント報酬"
  },
  Task_80996_Desc = {
    Text = "掃除ツールが達成されました"
  },
  Task_80997_Desc = {
    Text = "100000薔薇金券を消費します"
  },
  Task_80997_Name = {
    Text = "バックパック整理"
  },
  Task_80998_Desc = {
    Text = "掃除ツールが達成されました"
  },
  Task_80999_Desc = {
    Text = "掃除ツールが達成されました"
  },
  Task_81000_Desc = {
    Text = "累計ログイン 6 日"
  },
  Task_81001_Desc = {
    Text = "任意の調査行動を1回クリアする"
  },
  Task_81001_Name = {
    Text = "思い出の除塵"
  },
  Task_81002_Desc = {
    Text = "累計ログイン 3 日"
  },
  Task_81003_Desc = {
    Text = "掃除ツールが達成されました"
  },
  Task_81004_Desc = {
    Text = "掃除ツールが達成されました"
  },
  Task_81005_Desc = {
    Text = "掃除ツールが達成されました"
  },
  Task_81006_Desc = {
    Text = "イベントタスク"
  },
  Task_81007_Desc = {
    Text = "1回相位対弈を完了"
  },
  Task_81007_Name = {
    Text = "次元消毒"
  },
  Task_81008_Desc = {
    Text = "累計ログイン 5 日"
  },
  Task_81009_Desc = {
    Text = "累計ログイン 7 日"
  },
  Task_81010_Desc = {
    Text = "掃除ツールが達成されました"
  },
  Task_81011_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_81012_Desc = {
    Text = "累計ログイン 4 日"
  },
  Task_81013_Desc = {
    Text = "累計ログイン 2 日"
  },
  Task_81014_Desc = {
    Text = "掃除ツールが達成されました"
  },
  Task_81015_Desc = {
    Text = "掃除ツールが達成されました"
  },
  Task_81016_Desc = {
    Text = "融蚀の墟で180ポイントのエンフェリンを消費する"
  },
  Task_81016_Name = {
    Text = "腐食の清理"
  },
  Task_81017_Desc = {
    Text = "7日間ログイン"
  },
  Task_81018_Desc = {
    Text = "幻夢の深潜を 1 回クリア"
  },
  Task_81018_Name = {
    Text = "夢の通風"
  },
  Task_81083_Desc = {
    Text = "深海迷航・癲狂"
  },
  Task_81084_Desc = {
    Text = "「最終の挽歌」を任意の難易度でクリア"
  },
  Task_81085_Desc = {
    Text = "深海の領域の覚醒体で「邃海迷航」に2回勝利する"
  },
  Task_81086_Desc = {
    Text = "「古いコンパス」を任意の難易度でクリア"
  },
  Task_81087_Desc = {
    Text = "深海の領域の覚醒体で「邃海迷航」に1回勝利する"
  },
  Task_81088_Desc = {
    Text = "「最終の挽歌」を任意の難易度でクリア"
  },
  Task_81089_Desc = {
    Text = "「航海士の手引き」を癲狂難易度でクリア"
  },
  Task_81090_Desc = {
    Text = "「指導の光」を癲狂難易度でクリア"
  },
  Task_81091_Desc = {
    Text = "超次元の領域の覚醒体で「邃海迷航」に2回勝利する"
  },
  Task_81092_Desc = {
    Text = "「古い六分儀」を癲狂難易度でクリア"
  },
  Task_81093_Desc = {
    Text = "意識潜航「最後の引航」をクリア"
  },
  Task_81094_Desc = {
    Text = "「古いコンパス」を癲狂難易度でクリア"
  },
  Task_81095_Desc = {
    Text = "「指導の光」を任意の難易度でクリア"
  },
  Task_81096_Desc = {
    Text = "「古いコンパス」を任意の難易度でクリア"
  },
  Task_81097_Desc = {
    Text = "「深海迷航・クリア」すべての成果を達成します"
  },
  Task_81098_Desc = {
    Text = "「指導の光」を任意の難易度でクリア"
  },
  Task_81099_Desc = {
    Text = "「星辰の軌跡」を癲狂難易度でクリア"
  },
  Task_81100_Desc = {
    Text = "「星辰の軌跡」を任意の難易度でクリア"
  },
  Task_81101_Desc = {
    Text = "「信号旗語」を任意の難易度でクリア"
  },
  Task_81102_Desc = {
    Text = "「信号旗語」を任意の難易度でクリア"
  },
  Task_81103_Desc = {
    Text = "「古い六分儀」を任意の難易度でクリア"
  },
  Task_81104_Desc = {
    Text = "「古い海図」を任意の難易度でクリア"
  },
  Task_81105_Desc = {
    Text = "「信号旗語」を癲狂難易度でクリア"
  },
  Task_81106_Desc = {
    Text = "「航海士の手引き」を任意の難易度でクリア"
  },
  Task_81107_Desc = {
    Text = "「航海士の手引き」を任意の難易度でクリア"
  },
  Task_81108_Desc = {
    Text = "「斑駁の星盤」を任意の難易度でクリア"
  },
  Task_81109_Desc = {
    Text = "血肉の領域の覚醒体で「邃海迷航」に1回勝利する"
  },
  Task_81110_Desc = {
    Text = "超次元の領域の覚醒体で「邃海迷航」に1回勝利する"
  },
  Task_81111_Desc = {
    Text = "「最終の挽歌」を癲狂難易度でクリア"
  },
  Task_81112_Desc = {
    Text = "深海迷航・通関"
  },
  Task_81113_Desc = {
    Text = "「星辰の軌跡」を任意の難易度でクリア"
  },
  Task_81114_Desc = {
    Text = "「古い海図」を任意の難易度でクリア"
  },
  Task_81115_Desc = {
    Text = "「古い海図」を癲狂難易度でクリア"
  },
  Task_81116_Desc = {
    Text = "「斑駁の星盤」を癲狂難易度でクリア"
  },
  Task_81117_Desc = {
    Text = "「古い六分儀」を任意の難易度でクリア"
  },
  Task_81118_Desc = {
    Text = "「斑駁の星盤」を任意の難易度でクリア"
  },
  Task_81119_Desc = {
    Text = "深海迷航・境域"
  },
  Task_81120_Desc = {
    Text = "混沌の領域の覚醒体で「邃海迷航」に2回勝利する"
  },
  Task_81121_Desc = {
    Text = "血肉の領域の覚醒体で「邃海迷航」に2回勝利する"
  },
  Task_81122_Desc = {
    Text = "混沌の領域の覚醒体で「邃海迷航」に1回勝利する"
  },
  Task_81481_Desc = {
    Text = "環・ラモナの協力を必要とせず、「宇宙@2投影」を打倒する。"
  },
  Task_81481_Name = {
    Text = "宇宙の唸りを聞く·隠された"
  },
  Task_81772_Name = {
    Text = "BOSS1をN回撃破"
  },
  Task_81773_Name = {
    Text = "BOSS7をN回撃破"
  },
  Task_81774_Name = {
    Text = "すべてのBOSSを撃破"
  },
  Task_81775_Name = {
    Text = "BOSS3をN回撃破"
  },
  Task_81776_Name = {
    Text = "BOSS2をN回撃破"
  },
  Task_81777_Name = {
    Text = "BOSS6をN回撃破"
  },
  Task_81778_Name = {
    Text = "BOSS4をN回撃破"
  },
  Task_81779_Name = {
    Text = "BOSS5をN回撃破"
  },
  Task_84111_Name = {
    Text = "クポサントの支線ミッションの通常4を再クリア"
  },
  Task_84143_Desc = {
    Text = "ログイン累計2日"
  },
  Task_84144_Desc = {
    Text = "ログイン累計3日"
  },
  Task_84145_Desc = {
    Text = "ログイン累計2日"
  },
  Task_84146_Desc = {
    Text = "ログイン累計5日"
  },
  Task_84147_Desc = {
    Text = "ログイン累計8日"
  },
  Task_84148_Desc = {
    Text = "ログイン累計2日"
  },
  Task_84149_Desc = {
    Text = "ログイン累計5日"
  },
  Task_84150_Desc = {
    Text = "ログイン累計10日"
  },
  Task_84151_Desc = {
    Text = "ログイン累計5日"
  },
  Task_84152_Desc = {
    Text = "ログイン累計10日"
  },
  Task_84153_Desc = {
    Text = "ログイン累計4日"
  },
  Task_84154_Desc = {
    Text = "ログイン累計9日"
  },
  Task_84155_Desc = {
    Text = "ログイン累計3日"
  },
  Task_84156_Desc = {
    Text = "ログイン累計6日"
  },
  Task_84157_Desc = {
    Text = "ログイン累計2日"
  },
  Task_84158_Desc = {
    Text = "ログイン累計4日"
  },
  Task_84159_Desc = {
    Text = "ログイン累計3日"
  },
  Task_84160_Desc = {
    Text = "ログイン累計1日"
  },
  Task_84161_Desc = {
    Text = "ログイン累計7日"
  },
  Task_84162_Desc = {
    Text = "ログイン累計5日"
  },
  Task_84163_Desc = {
    Text = "ログイン累計1日"
  },
  Task_84164_Desc = {
    Text = "ログイン累計1日"
  },
  Task_84165_Desc = {
    Text = "ログイン累計8日"
  },
  Task_84166_Desc = {
    Text = "ログイン累計7日"
  },
  Task_84167_Desc = {
    Text = "ログイン累計4日"
  },
  Task_84168_Desc = {
    Text = "ログイン累計6日"
  },
  Task_84169_Desc = {
    Text = "ログイン累計4日"
  },
  Task_84170_Desc = {
    Text = "ログイン累計9日"
  },
  Task_84171_Desc = {
    Text = "ログイン累計1日"
  },
  Task_84172_Desc = {
    Text = "ログイン累計3日"
  },
  Task_84323_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_84323_Name = {Text = "3勝"},
  Task_84324_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_84324_Name = {Text = "6勝"},
  Task_84325_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_84325_Name = {Text = "1勝"},
  Task_84326_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_84326_Name = {Text = "10勝"},
  Task_84349_Desc = {
    Text = "意識潜行「最後の導航」をクリア"
  },
  Task_84349_Name = {
    Text = "星々と深淵の導き"
  },
  Task_88945_Desc = {
    Text = "任意の難易度で「囚われの檻を破る」をクリアする"
  },
  Task_88946_Desc = {
    Text = "異夢視界「天辺の外·上」をクリア"
  },
  Task_88947_Desc = {
    Text = "混沌の領域覚醒体を使い、「飛躍青空」で2回勝利する"
  },
  Task_88948_Desc = {
    Text = "任意の難易度で「孤独の旅」をクリアする"
  },
  Task_88949_Desc = {
    Text = "深海の領域覚醒体を使い、「飛躍青空」で1回勝利する"
  },
  Task_88950_Desc = {
    Text = "混沌の領域覚醒体を使い、「飛躍青空」で1回勝利する"
  },
  Task_88951_Desc = {
    Text = "任意の難易度で「伝烛者」をクリアする"
  },
  Task_88952_Desc = {
    Text = "癲狂難易度で「囚われの檻を破る」をクリアする"
  },
  Task_88953_Desc = {
    Text = "任意の難易度で「囚われの檻を破る」をクリアする"
  },
  Task_88954_Desc = {
    Text = "超次元領域覚醒体を使い、「飛躍青空」で1回勝利する"
  },
  Task_88955_Desc = {
    Text = "癲狂難易度で「自由と死」をクリアする"
  },
  Task_88956_Desc = {
    Text = "任意の難易度で「孤独の旅」をクリアする"
  },
  Task_88957_Desc = {
    Text = "飛躍青空・癲狂"
  },
  Task_88958_Desc = {
    Text = "任意の難易度で「自由と死」をクリアする"
  },
  Task_88959_Desc = {
    Text = "任意の難易度で「自由と死」をクリアする"
  },
  Task_88960_Desc = {
    Text = "任意の難易度で「無尽の砂」をクリアする"
  },
  Task_88961_Desc = {
    Text = "「飛躍青空·通関」のすべての成果を完了する"
  },
  Task_88962_Desc = {
    Text = "任意の難易度で「伝烛者」をクリアする"
  },
  Task_88963_Desc = {
    Text = "癲狂難易度で「無尽の砂」をクリアする"
  },
  Task_88964_Desc = {
    Text = "癲狂難易度で「愚者」をクリアする"
  },
  Task_88965_Desc = {
    Text = "癲狂難易度で「昨日の夢」をクリアする"
  },
  Task_88966_Desc = {
    Text = "癲狂難易度で「孤独の旅」をクリアする"
  },
  Task_88967_Desc = {
    Text = "血肉の領域覚醒体を使い、「飛躍青空」で2回勝利する"
  },
  Task_88968_Desc = {
    Text = "任意の難易度で「昨日の夢」をクリアする"
  },
  Task_88969_Desc = {
    Text = "飛躍青空・境域"
  },
  Task_88970_Desc = {
    Text = "深海の領域覚醒体を使い、「飛躍青空」で2回勝利する"
  },
  Task_88971_Desc = {
    Text = "飛躍青空・クリア"
  },
  Task_88972_Desc = {
    Text = "任意の難易度で「無尽の砂」をクリアする"
  },
  Task_88973_Desc = {
    Text = "血肉の領域覚醒体を使い、「飛躍青空」で1回勝利する"
  },
  Task_88974_Desc = {
    Text = "任意の難易度で「愚者」をクリアする"
  },
  Task_88975_Desc = {
    Text = "癲狂難易度で「伝烛者」をクリアする"
  },
  Task_88976_Desc = {
    Text = "超次元領域覚醒体を使い、「飛躍青空」で2回勝利する"
  },
  Task_88977_Desc = {
    Text = "任意の難易度で「昨日の夢」をクリアする"
  },
  Task_88978_Desc = {
    Text = "任意の難易度で「愚者」をクリアする"
  },
  Task_89577_Desc = {
    Text = "累計ログイン 12 日"
  },
  Task_89578_Desc = {
    Text = "累計ログイン 15 日"
  },
  Task_89579_Desc = {
    Text = "累計ログイン 2 日"
  },
  Task_89580_Desc = {
    Text = "累計ログイン 10 日"
  },
  Task_89581_Desc = {
    Text = "累計ログイン 11 日"
  },
  Task_89582_Desc = {
    Text = "累計ログイン 3 日"
  },
  Task_89583_Desc = {
    Text = "累計ログイン 6 日"
  },
  Task_89584_Desc = {
    Text = "累計ログイン 16 日"
  },
  Task_89585_Desc = {
    Text = "累計ログイン 4 日"
  },
  Task_89586_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_89587_Desc = {
    Text = "累計ログイン 7 日"
  },
  Task_89588_Desc = {
    Text = "累計ログイン 14 日"
  },
  Task_89589_Desc = {
    Text = "累計ログイン 8 日"
  },
  Task_89590_Desc = {
    Text = "累計ログイン 5 日"
  },
  Task_89591_Desc = {
    Text = "累計ログイン 13 日"
  },
  Task_89592_Desc = {
    Text = "累計ログイン 9 日"
  },
  Task_89844_Desc = {
    Text = "初回の命軌合契覚醒({s1}/1)"
  },
  Task_89844_Name = {
    Text = "タスクを完了して幻衣描写券を受け取る"
  },
  Task_89845_Desc = {
    Text = "7日ログイン({s1}/7)"
  },
  Task_89845_Name = {
    Text = "タスクを完了して幻衣描写券を受け取る"
  },
  Task_89846_Desc = {
    Text = "異動する海潮の群れを撃退（{s1}/30）"
  },
  Task_89846_Name = {
    Text = "タスクを完了して幻衣描写券を受け取る"
  },
  Task_90036_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_90036_Name = {Text = "6勝"},
  Task_90037_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_90037_Name = {Text = "3勝"},
  Task_90038_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_90038_Name = {Text = "10勝"},
  Task_90039_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_90039_Name = {Text = "1勝"},
  Task_90495_Desc = {
    Text = "実技指導クリア・混沌の念"
  },
  Task_90495_Name = {
    Text = "混沌の念"
  },
  Task_90866_Desc = {
    Text = "深海胎動Ⅰ"
  },
  Task_90867_Desc = {
    Text = "万願擬造Ⅰ"
  },
  Task_90868_Desc = {
    Text = "仮テキスト・無料"
  },
  Task_90869_Desc = {
    Text = "頭蓋庭挽歌Ⅶ"
  },
  Task_90870_Desc = {
    Text = "仮テキストⅣ"
  },
  Task_90871_Desc = {
    Text = "共鳴する運命Ⅲ"
  },
  Task_90872_Desc = {
    Text = "頭蓋庭挽歌Ⅰ"
  },
  Task_90873_Desc = {
    Text = "万願擬造Ⅴ"
  },
  Task_90874_Desc = {
    Text = "深海胎動Ⅵ"
  },
  Task_90875_Desc = {
    Text = "仮テキストⅠ"
  },
  Task_90876_Desc = {
    Text = "深海胎動·無料"
  },
  Task_90877_Desc = {
    Text = "頭蓋庭挽歌・無料"
  },
  Task_90878_Desc = {
    Text = "頭蓋庭挽歌Ⅵ"
  },
  Task_90879_Desc = {
    Text = "万願擬造Ⅳ"
  },
  Task_90880_Desc = {
    Text = "万願擬造·無料"
  },
  Task_90881_Desc = {
    Text = "頭蓋庭挽歌Ⅲ"
  },
  Task_90882_Desc = {
    Text = "共鳴する運命Ⅱ"
  },
  Task_90883_Desc = {
    Text = "仮テキストⅤ"
  },
  Task_90884_Desc = {
    Text = "頭蓋庭挽歌Ⅴ"
  },
  Task_90885_Desc = {
    Text = "仮テキストⅥ"
  },
  Task_90886_Desc = {
    Text = "仮テキストⅦ"
  },
  Task_90887_Desc = {
    Text = "共役の運命Ⅵ"
  },
  Task_90888_Desc = {
    Text = "共役する運命Ⅳ"
  },
  Task_90889_Desc = {
    Text = "頭蓋庭挽歌Ⅳ"
  },
  Task_90890_Desc = {
    Text = "共役の運命Ⅴ"
  },
  Task_90891_Desc = {
    Text = "共鳴：運命の道Ⅰ"
  },
  Task_90892_Desc = {
    Text = "万願擬造Ⅲ"
  },
  Task_90893_Desc = {
    Text = "深海胎動Ⅱ"
  },
  Task_90894_Desc = {
    Text = "仮テキストⅢ"
  },
  Task_90895_Desc = {
    Text = "共役の運命Ⅶ"
  },
  Task_90896_Desc = {
    Text = "頭蓋庭挽歌Ⅱ"
  },
  Task_90897_Desc = {
    Text = "深海胎動Ⅶ"
  },
  Task_90898_Desc = {
    Text = "深海胎動Ⅴ"
  },
  Task_90899_Desc = {
    Text = "深海胎動Ⅳ"
  },
  Task_90900_Desc = {
    Text = "万願擬造Ⅵ"
  },
  Task_90901_Desc = {
    Text = "共役の運命·無料"
  },
  Task_90902_Desc = {
    Text = "万願擬造Ⅱ"
  },
  Task_90903_Desc = {
    Text = "深海胎動Ⅲ"
  },
  Task_90904_Desc = {
    Text = "万願擬造Ⅶ"
  },
  Task_90905_Desc = {
    Text = "仮テキストⅡ"
  },
  Task_91028_Desc = {
    Text = "「勇士の冠」癲狂難易度をクリア"
  },
  Task_91029_Desc = {
    Text = "混沌の領域の覚醒体を使用して「神聖な獲物」で1回勝利する"
  },
  Task_91030_Desc = {
    Text = "血肉の領域の覚醒体を使用して「神聖な獲物」で1回勝利する"
  },
  Task_91031_Desc = {
    Text = "超次元の領域の覚醒体を使用して「神聖な獲物」で1回勝利する"
  },
  Task_91032_Desc = {
    Text = "血肉の領域の覚醒体を使用して「神聖な獲物」で2回勝利する"
  },
  Task_91033_Desc = {
    Text = "神聖な狩り・通過"
  },
  Task_91034_Desc = {
    Text = "「凶猛な獲物」任意の難易度をクリア"
  },
  Task_91035_Desc = {
    Text = "神聖な狩り・癲狂"
  },
  Task_91036_Desc = {
    Text = "「遠征号角」任意の難易度をクリア"
  },
  Task_91037_Desc = {
    Text = "「協力の知恵」任意の難易度をクリア"
  },
  Task_91038_Desc = {
    Text = "深海の領域の覚醒体を使用して「神聖な獲物」で2回勝利する"
  },
  Task_91039_Desc = {
    Text = "超次元の領域の覚醒体を使用して「神聖な獲物」で2回勝利する"
  },
  Task_91040_Desc = {
    Text = "異夢視界「征キッチン記」をクリア"
  },
  Task_91041_Desc = {
    Text = "「勇士の冠」任意の難易度をクリア"
  },
  Task_91042_Desc = {
    Text = "「勇士の冠」任意の難易度をクリア"
  },
  Task_91043_Desc = {
    Text = "深海の領域の覚醒体を使用して「神聖な獲物」で1回勝利する"
  },
  Task_91044_Desc = {
    Text = "「栄光の凱旋」任意の難易度をクリア"
  },
  Task_91045_Desc = {
    Text = "「凶猛な獲物」任意の難易度をクリア"
  },
  Task_91046_Desc = {
    Text = "「協力の知恵」癲狂難易度をクリア"
  },
  Task_91047_Desc = {
    Text = "「遠征号角」任意の難易度をクリア"
  },
  Task_91048_Desc = {
    Text = "「協力の知恵」任意の難易度をクリア"
  },
  Task_91049_Desc = {
    Text = "「栄光の凱旋」任意の難易度をクリア"
  },
  Task_91050_Desc = {
    Text = "「神聖の狩り·クリア」のすべての実績を達成する"
  },
  Task_91051_Desc = {
    Text = "「遠征号角」癲狂難易度をクリア"
  },
  Task_91052_Desc = {
    Text = "「栄光の凱旋」癲狂難易度をクリア"
  },
  Task_91053_Desc = {
    Text = "神聖な狩り・境域"
  },
  Task_91054_Desc = {
    Text = "「凶猛な獲物」癲狂難易度をクリア"
  },
  Task_91055_Desc = {
    Text = "混沌の領域の覚醒体を使用して「神聖な獲物」で2回勝利する"
  },
  Task_91129_Desc = {
    Text = "レベル20に到達"
  },
  Task_91131_Desc = {
    Text = "レベル5に到達"
  },
  Task_91149_Desc = {
    Text = "レベル15に到達"
  },
  Task_91154_Desc = {
    Text = "レベル10に到達"
  },
  Task_91332_Desc = {
    Text = "ドゥルサインを撃破せよ"
  },
  Task_91332_Name = {Text = "目標"},
  Task_91333_Desc = {
    Text = "侵入者を撃退せよ"
  },
  Task_91333_Name = {Text = "目標"},
  Task_91334_Desc = {
    Text = "「腐潮の傀」を撃破し、葬骸城を守れ"
  },
  Task_91334_Name = {Text = "目標"},
  Task_91335_Desc = {
    Text = "海行者を撃破せよ"
  },
  Task_91335_Name = {Text = "目標"},
  Task_91336_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_91336_Name = {
    Text = "完璧な通過"
  },
  Task_91337_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_91337_Name = {
    Text = "完璧な通過"
  },
  Task_91338_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_91338_Name = {
    Text = "完璧な通過"
  },
  Task_91339_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_91339_Name = {
    Text = "完璧な通過"
  },
  Task_91340_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_91340_Name = {
    Text = "完璧な通過"
  },
  Task_91341_Desc = {
    Text = "ピクマンの「絵画」を破壊する"
  },
  Task_91341_Name = {Text = "目標"},
  Task_91342_Desc = {
    Text = "敵を撃破し、食屍鬼王城へ入る"
  },
  Task_91342_Name = {Text = "目標"},
  Task_91343_Desc = {
    Text = "食屍鬼の追跡から逃れる"
  },
  Task_91343_Name = {Text = "目標"},
  Task_91344_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_91344_Name = {
    Text = "完璧な通過"
  },
  Task_91345_Desc = {
    Text = "融蚀体を撃破せよ"
  },
  Task_91345_Name = {Text = "目標"},
  Task_91346_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_91346_Name = {
    Text = "完璧な通過"
  },
  Task_91347_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_91347_Name = {
    Text = "完璧な通過"
  },
  Task_91348_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_91348_Name = {
    Text = "完璧な通過"
  },
  Task_91349_Desc = {
    Text = "ゴリアを撃退し、法陣を破壊せよ"
  },
  Task_91349_Name = {Text = "目標"},
  Task_91350_Desc = {
    Text = "復活の魂魄を使用せずにクリア"
  },
  Task_91350_Name = {
    Text = "完璧な通過"
  },
  Task_91351_Desc = {
    Text = "執事フランを撃破せよ"
  },
  Task_91351_Name = {Text = "目標"},
  Task_91357_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_91358_Desc = {
    Text = "星辰篇第3章 3-5を通過"
  },
  Task_91359_Desc = {
    Text = "調査「@1@2」を完了する"
  },
  Task_91359_Desc2 = {
    Text = "調査イベント「餍飨」を完了しました"
  },
  Task_91359_Name2 = {
    Text = "骨と霊の共餐"
  },
  Task_91360_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_91361_Desc = {
    Text = "星辰篇第3章 3-5 難易度「困難」を通過"
  },
  Task_91362_Desc = {
    Text = "星辰篇第3章「饗宴」難易度「困難」を通過"
  },
  Task_91363_Desc = {
    Text = "調査事件「饗宴」難易度困難を完了"
  },
  Task_91363_Name = {
    Text = "骨と霊の共食・難易度"
  },
  Task_91364_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_91365_Desc = {
    Text = "星辰篇第3章「饗宴」を通過"
  },
  Task_91366_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_91367_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_91368_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_91370_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_91371_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_91372_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_91373_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_91379_Desc = {
    Text = "星辰篇第3章 2-5 難易度「困難」を通過"
  },
  Task_91380_Desc = {
    Text = "星辰篇第3章 2-5を通過"
  },
  Task_91381_Desc = {
    Text = "星辰篇第3章「饗宴」難易度「困難」を通過"
  },
  Task_91382_Desc = {
    Text = "星辰篇第3章「饗宴」を通過"
  },
  Task_91436_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_91436_Name = {Text = "1勝"},
  Task_91437_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_91437_Name = {Text = "3勝"},
  Task_91438_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_91438_Name = {Text = "6勝"},
  Task_91439_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_91439_Name = {Text = "10勝"},
  Task_91720_Desc = {
    Text = "7日ログイン({s1}/7)"
  },
  Task_91720_Name = {
    Text = "タスクを完了して幻衣描写券を受け取る"
  },
  Task_91721_Desc = {
    Text = "全ての癲狂難易度をクリア(({s1}/5)"
  },
  Task_91721_Name = {
    Text = "タスクを完了して幻衣描写券を受け取る"
  },
  Task_91786_Desc = {
    Text = "血肉界域の覚醒体を使用し「神国の降臨」で2回勝利"
  },
  Task_91787_Desc = {
    Text = "混沌界域の覚醒体を使用し「神国の降臨」で2回勝利"
  },
  Task_91788_Desc = {
    Text = "深海界域の覚醒体を使用し「神国の降臨」で2回勝利"
  },
  Task_91789_Desc = {
    Text = "超次元界域の覚醒体を使用し「神国の降臨」で2回勝利"
  },
  Task_94489_Desc = {
    Text = "6体の混沌キャラクターを80レベルに昇格させる"
  },
  Task_94489_Name = {
    Text = "境域精通Ⅹ"
  },
  Task_94490_Desc = {
    Text = "6体の深海キャラクターを70レベルに昇格させる"
  },
  Task_94490_Name = {
    Text = "境域精通Ⅸ"
  },
  Task_94491_Desc = {
    Text = "6体の超次元キャラクターを70レベルに昇格させる"
  },
  Task_94491_Name = {
    Text = "境域精通Ⅸ"
  },
  Task_94492_Desc = {
    Text = "6体の血肉キャラクターを80レベルに昇格させる"
  },
  Task_94492_Name = {
    Text = "境域精通Ⅹ"
  },
  Task_94493_Desc = {
    Text = "6体の深海キャラクターを80レベルに昇格させる"
  },
  Task_94493_Name = {
    Text = "境域精通Ⅹ"
  },
  Task_94494_Desc = {
    Text = "6体の血肉キャラクターを70レベルに昇格させる"
  },
  Task_94494_Name = {
    Text = "境域精通Ⅸ"
  },
  Task_94495_Desc = {
    Text = "6体の混沌キャラクターを70レベルに昇格させる"
  },
  Task_94495_Name = {
    Text = "境域精通Ⅸ"
  },
  Task_94496_Desc = {
    Text = "6体の超次元キャラクターを80レベルに昇格させる"
  },
  Task_94496_Name = {
    Text = "境域精通Ⅹ"
  },
  Task_94497_Desc = {
    Text = "この章の全任務を完了後に受け取る"
  },
  Task_94497_Name = {
    Text = "境域精通Ⅹ"
  },
  Task_94498_Desc = {
    Text = "この章の全任務を完了後に受け取る"
  },
  Task_94498_Name = {
    Text = "境域精通Ⅸ"
  },
  Task_94613_Desc = {
    Text = "実技指導クリア・超次元の域"
  },
  Task_94613_Name = {
    Text = "超次元の域"
  },
  Task_94614_Desc = {
    Text = "実技指導クリア・血肉の殖"
  },
  Task_94614_Name = {
    Text = "血肉の殖"
  },
  Task_94615_Desc = {
    Text = "実技指導クリア・深海の触"
  },
  Task_94615_Name = {
    Text = "深海の触"
  },
  Task_94699_Desc = {
    Text = "顱庭の挽歌·期間限定"
  },
  Task_94861_Desc = {
    Text = "エンフェリンを1800消費"
  },
  Task_94863_Desc = {
    Text = "累計で召喚を100回行う"
  },
  Task_94865_Desc = {
    Text = "救援を3回使用する"
  },
  Task_94867_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_94871_Desc = {
    Text = "1回ケティグラのプレイテストステージをクリア"
  },
  Task_94874_Desc = {
    Text = "今週の試練を2回完了する"
  },
  Task_94876_Desc = {
    Text = "エンフェリンを1800消費"
  },
  Task_94877_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_94882_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_94885_Desc = {
    Text = "今週の試練を2回完了する"
  },
  Task_94886_Desc = {
    Text = "1回ケティグラのプレイテストステージをクリア"
  },
  Task_94888_Desc = {
    Text = "救援を3回使用する"
  },
  Task_94891_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_94895_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_94898_Desc = {
    Text = "累計で召喚を100回行う"
  },
  Task_94901_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_95192_Desc = {
    Text = "「地表の太陽」の癲狂難易度をクリアする"
  },
  Task_95193_Desc = {
    Text = "血肉の領域の覚醒体を使用して「灰燼の狩猟」で2回勝利する"
  },
  Task_95194_Desc = {
    Text = "「無声の世界」の任意難易度をクリアする"
  },
  Task_95195_Desc = {
    Text = "混沌の領域の覚醒体を使用して「灰燼の狩猟」で1回勝利する"
  },
  Task_95196_Desc = {
    Text = "意識潜航「不滅の極昼」をクリア"
  },
  Task_95197_Desc = {
    Text = "「契約目標」の任意難易度をクリアする"
  },
  Task_95198_Desc = {
    Text = "「無声の世界」の癲狂難易度をクリアする"
  },
  Task_95199_Desc = {
    Text = "「契約目標」の任意難易度をクリアする"
  },
  Task_95200_Desc = {
    Text = "「地表の太陽」の任意難易度をクリアする"
  },
  Task_95201_Desc = {
    Text = "「熾焰の宣判」の任意難易度をクリアする"
  },
  Task_95202_Desc = {
    Text = "深海の領域の覚醒体を使用して「灰燼の狩猟」で1回勝利する"
  },
  Task_95203_Desc = {
    Text = "「古の誓い」の任意難易度をクリアする"
  },
  Task_95204_Desc = {
    Text = "「熾焰の宣判」の任意難易度をクリアする"
  },
  Task_95205_Desc = {
    Text = "超次元の領域の覚醒体を使用して「灰燼の狩猟」で1回勝利する"
  },
  Task_95206_Desc = {
    Text = "混沌の領域の覚醒体を使用して「灰燼の狩猟」で2回勝利する"
  },
  Task_95207_Desc = {
    Text = "通過「覆世の光」任意の難易度"
  },
  Task_95208_Desc = {
    Text = "「地表の太陽」の任意難易度をクリアする"
  },
  Task_95209_Desc = {
    Text = "血肉の領域の覚醒体を使用して「灰燼の狩猟」で1回勝利する"
  },
  Task_95210_Desc = {
    Text = "超次元の領域の覚醒体を使用して「灰燼の狩猟」で2回勝利する"
  },
  Task_95211_Desc = {
    Text = "「熾焰の宣判」の癲狂難易度をクリアする"
  },
  Task_95212_Desc = {
    Text = "灰燼の追跡·癲狂"
  },
  Task_95213_Desc = {
    Text = "深海の領域の覚醒体を使用して「灰燼の狩猟」で2回勝利する"
  },
  Task_95214_Desc = {
    Text = "「契約目標」の癲狂難易度をクリアする"
  },
  Task_95215_Desc = {
    Text = "「無声の世界」の任意難易度をクリアする"
  },
  Task_95216_Desc = {
    Text = "通過「覆世の光」任意の難易度"
  },
  Task_95217_Desc = {
    Text = "灰燼の追跡·界域"
  },
  Task_95218_Desc = {
    Text = "「煉獄の歌」の任意難易度をクリアする"
  },
  Task_95219_Desc = {
    Text = "「古の誓い」の任意難易度をクリアする"
  },
  Task_95220_Desc = {
    Text = "「古の誓い」の癲狂難易度をクリアする"
  },
  Task_95221_Desc = {
    Text = "通過「覆世の光」狂気難易度"
  },
  Task_95222_Desc = {
    Text = "「煉獄の歌」の任意難易度をクリアする"
  },
  Task_95223_Desc = {
    Text = "「灰燼追跡・通関」の全ての実績を完了"
  },
  Task_95224_Desc = {
    Text = "「煉獄の歌」の癲狂難易度をクリアする"
  },
  Task_95225_Desc = {
    Text = "灰燼の追跡·通関"
  },
  Task_95470_Desc = {
    Text = "Nを打ち負かす"
  },
  Task_95470_Name = {Text = "目標"},
  Task_95520_Desc = {
    Text = "累積16000プラチナジェル\n抽出する"
  },
  Task_95521_Desc = {
    Text = "累積25000プラチナジェル\n抽出する"
  },
  Task_95522_Desc = {
    Text = "累積13000プラチナジェル\n抽出する"
  },
  Task_95523_Desc = {
    Text = "累積8000プラチナジェル\n抽出する"
  },
  Task_95524_Desc = {
    Text = "累積2000プラチナジェル\n抽出する"
  },
  Task_95525_Desc = {
    Text = "累積20000プラチナジェル\n抽出する"
  },
  Task_95526_Desc = {
    Text = "累積4000プラチナジェル\n抽出する"
  },
  Task_95527_Desc = {
    Text = "累積5000プラチナジェル\n抽出する"
  },
  Task_95532_Desc = {
    Text = "花園の記憶・超難度"
  },
  Task_95533_Desc = {
    Text = "「灰」超難度をクリア"
  },
  Task_95534_Desc = {
    Text = "「小さな王国」超難度をクリア"
  },
  Task_95535_Desc = {
    Text = "「最初の薔薇」超難度をクリア"
  },
  Task_95536_Desc = {
    Text = "「手を取る」超難度をクリア"
  },
  Task_95537_Desc = {
    Text = "「咲き誇る詩篇」超難度をクリア"
  },
  Task_95543_Desc = {
    Text = "「最初の薔薇」任意の難易度をクリア"
  },
  Task_95544_Desc = {
    Text = "「手を取る」任意の難易度をクリア"
  },
  Task_95545_Desc = {
    Text = "「咲く詩篇」任意の難易度をクリア"
  },
  Task_95546_Desc = {
    Text = "「灰」任意の難易度をクリア"
  },
  Task_95547_Desc = {
    Text = "「小さな王国」任意の難易度をクリア"
  },
  Task_95830_Desc = {
    Text = "霊を噛む饗宴・界域"
  },
  Task_95831_Desc = {
    Text = "「亡焰炙魂」の癲狂難易度をクリアする"
  },
  Task_95832_Desc = {
    Text = "通過「腐植の調香」任意の難易度"
  },
  Task_95833_Desc = {
    Text = "通過「腐植の調香」狂気難易度"
  },
  Task_95834_Desc = {
    Text = "「沈棺開封」の任意難易度をクリアする"
  },
  Task_95835_Desc = {
    Text = "血肉の領域の覚醒体を使用して「噬魂の饗宴」で2回勝利する"
  },
  Task_95836_Desc = {
    Text = "デュレサインを獲得したときに啓霊2"
  },
  Task_95836_Name = {
    Text = "デュレサインを獲得したときに啓霊2"
  },
  Task_95836_UnlockCondDesc = {
    Text = "活動@覚醒体デュレセイン啓霊ギフト2活動"
  },
  Task_95837_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_95838_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_95839_Desc = {
    Text = "「沈棺開封」の任意難易度をクリアする"
  },
  Task_95840_Desc = {
    Text = "混沌の領域の覚醒体を使用して「噬魂の饗宴」で1回勝利する"
  },
  Task_95841_Desc = {
    Text = "血肉の領域の覚醒体を使用して「噬魂の饗宴」で1回勝利する"
  },
  Task_95842_Desc = {
    Text = "通過「骨肉の剥離」狂気難易度"
  },
  Task_95843_Desc = {
    Text = "「霊龕の盛宴」の癲狂難易度をクリアする"
  },
  Task_95844_Desc = {
    Text = "「亡焰炙魂」の任意難易度をクリアする"
  },
  Task_95845_Desc = {
    Text = "「亡焰炙魂」の任意難易度をクリアする"
  },
  Task_95846_Desc = {
    Text = "デュラサインの同調率が10に達しました"
  },
  Task_95847_Desc = {
    Text = "霊を噛む饗宴・通関"
  },
  Task_95848_Desc = {
    Text = "「噬霊の宴・通関」の全てのタスクを完了"
  },
  Task_95849_Desc = {
    Text = "「沈棺開封」の癲狂難易度をクリアする"
  },
  Task_95850_Desc = {
    Text = "デュレサインを獲得したときに啓霊6"
  },
  Task_95850_Name = {
    Text = "デュレサインを獲得したときに啓霊6"
  },
  Task_95850_UnlockCondDesc = {
    Text = "活動@覚醒体デュレセイン啓霊ギフト2活動"
  },
  Task_95853_Desc = {
    Text = "通過「骨肉の剥離」任意の難易度"
  },
  Task_95854_Desc = {
    Text = "霊を噛む饗宴・癲狂"
  },
  Task_95855_Desc = {
    Text = "「霊龕の盛宴」の任意難易度をクリアする"
  },
  Task_95856_Desc = {
    Text = "深海の領域の覚醒体を使用して「噬魂の饗宴」で1回勝利する"
  },
  Task_95857_Desc = {
    Text = "通過「腐植の調香」任意の難易度"
  },
  Task_95858_Desc = {
    Text = "超次元の領域の覚醒体を使用して「噬魂の饗宴」で1回勝利する"
  },
  Task_95860_Desc = {
    Text = "超次元の領域の覚醒体を使用して「噬魂の饗宴」で2回勝利する"
  },
  Task_95861_Desc = {
    Text = "通過「骨肉の剥離」任意の難易度"
  },
  Task_95862_Desc = {
    Text = "深海の領域の覚醒体を使用して「噬魂の饗宴」で2回勝利する"
  },
  Task_95863_Desc = {
    Text = "「霊龕の盛宴」の任意難易度をクリアする"
  },
  Task_95864_Desc = {
    Text = "混沌の領域の覚醒体を使用して「噬魂の饗宴」で2回勝利する"
  },
  Task_95865_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_95866_UnlockCondDesc = {
    Text = "先に前のギフトを取得してください"
  },
  Task_96333_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_96333_Name = {Text = "10勝"},
  Task_96334_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_96334_Name = {Text = "3勝"},
  Task_96335_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_96335_Name = {Text = "6勝"},
  Task_96336_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_96336_Name = {Text = "1勝"},
  Task_96618_Desc = {
    Text = "商店で金券を使って3回交換する"
  },
  Task_96619_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_96620_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_96621_Desc = {
    Text = "「24」のカオス試遊ステージを1回クリア"
  },
  Task_96622_Desc = {
    Text = "今週の試練を2回完了する"
  },
  Task_96623_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_96624_Desc = {
    Text = "累計ログイン 15 日"
  },
  Task_96625_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_96626_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_96627_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_96628_Desc = {
    Text = "エンフェリンを1800消費"
  },
  Task_96629_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_96630_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_96631_Desc = {
    Text = "商店で金券を使って3回交換する"
  },
  Task_96632_Desc = {
    Text = "エンフェリンを1800消費"
  },
  Task_96633_Desc = {
    Text = "「24」のカオス試遊ステージを1回クリア"
  },
  Task_96840_Desc = {
    Text = "異界図巻·通関"
  },
  Task_96841_Desc = {
    Text = "「地獄の変」を任意の難易度でクリアしてください"
  },
  Task_96842_Desc = {
    Text = "通関「金牛の狂舞」任意難易度"
  },
  Task_96843_Desc = {
    Text = "通関「線魂の肆虐」任意難易度"
  },
  Task_96844_Desc = {
    Text = "通関「狂歓の定格」癲狂難易度"
  },
  Task_96845_Desc = {
    Text = "通関「金牛の狂舞」癲狂難易度"
  },
  Task_96846_Desc = {
    Text = "超次元の領域の覚醒体を使用して「異界図巻」で2回勝利する"
  },
  Task_96847_Desc = {
    Text = "「インスピレーションの侵染」の任意の難易度をクリアする"
  },
  Task_96848_Desc = {
    Text = "通関「血色の蔓延」癲狂難易度"
  },
  Task_96849_Desc = {
    Text = "通関「血色の蔓延」任意難易度"
  },
  Task_96850_Desc = {
    Text = "通関「金牛の狂舞」任意難易度"
  },
  Task_96851_Desc = {
    Text = "通関「血色の蔓延」任意難易度"
  },
  Task_96852_Desc = {
    Text = "混沌の領域の覚醒体を使用して「異界図巻」で2回勝利する"
  },
  Task_96853_Desc = {
    Text = "「異界図巻・通関」のすべての達成を完了する"
  },
  Task_96854_Desc = {
    Text = "通関「線魂の肆虐」任意難易度"
  },
  Task_96855_Desc = {
    Text = "通関「狂歓の定格」任意難易度"
  },
  Task_96856_Desc = {
    Text = "異界図巻·境域"
  },
  Task_96857_Desc = {
    Text = "深海の領域の覚醒体を使用して「異界図巻」で2回勝利する"
  },
  Task_96858_Desc = {
    Text = "通関「線魂の肆虐」癲狂難易度"
  },
  Task_96859_Desc = {
    Text = "血肉の領域の覚醒体を使用して「異界図巻」で1回勝利する"
  },
  Task_96860_Desc = {
    Text = "「地獄の変」を任意の難易度でクリアしてください"
  },
  Task_96861_Desc = {
    Text = "混沌の領域の覚醒体を使用して「異界図巻」で1回勝利する"
  },
  Task_96862_Desc = {
    Text = "通関意識潜航「畸世画」"
  },
  Task_96863_Desc = {
    Text = "通関「夢魘の堆塊」任意難易度"
  },
  Task_96864_Desc = {
    Text = "深海の領域の覚醒体を使用して「異界図巻」で1回勝利する"
  },
  Task_96865_Desc = {
    Text = "「インスピレーション感染」狂気の難易度をクリア"
  },
  Task_96866_Desc = {
    Text = "通関「夢魘の堆塊」任意難易度"
  },
  Task_96867_Desc = {
    Text = "異界図巻·癲狂"
  },
  Task_96868_Desc = {
    Text = "通関「狂歓の定格」任意難易度"
  },
  Task_96869_Desc = {
    Text = "「インスピレーションの侵染」の任意の難易度をクリアする"
  },
  Task_96870_Desc = {
    Text = "血肉の領域の覚醒体を使用して「異界図巻」で2回勝利する"
  },
  Task_96871_Desc = {
    Text = "通関「地獄の変」癲狂難易度"
  },
  Task_96872_Desc = {
    Text = "通関「夢魘の堆塊」癲狂難易度"
  },
  Task_96873_Desc = {
    Text = "超次元の領域の覚醒体を使用して「異界図巻」で1回勝利する"
  },
  Task_97192_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_97193_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_97194_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_97195_Desc = {
    Text = "1回デュレセインのトライアルステージをクリアする"
  },
  Task_97196_Desc = {
    Text = "今週の試練を2回完了する"
  },
  Task_97197_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_97198_Desc = {
    Text = "エンフェリンを1800消費"
  },
  Task_97199_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_97200_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_97201_Desc = {
    Text = "エンフェリンを1800消費"
  },
  Task_97202_Desc = {
    Text = "「日々の訓練」を3回完了する"
  },
  Task_97203_Desc = {
    Text = "1回デュレセインのトライアルステージをクリアする"
  },
  Task_97243_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_97244_Desc = {
    Text = "今週の試練を2回完了する"
  },
  Task_97245_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_97246_Desc = {
    Text = "「日々の訓練」を3回完了する"
  },
  Task_97309_Desc = {
    Text = "調査「@1@2」で6回共鳴する"
  },
  Task_97309_Desc2 = {
    Text = "事件「餍飨」を調査中に6回共鳴する"
  },
  Task_97309_Name2 = {
    Text = "暴食の響きⅢ"
  },
  Task_97310_Desc = {
    Text = "調査「@1@2」で9回共鳴する"
  },
  Task_97310_Desc2 = {
    Text = "調査事件「餍飨」で9回の共鳴をしてください"
  },
  Task_97310_Name2 = {
    Text = "暴食の響きⅣ"
  },
  Task_97311_Desc = {
    Text = "調査事件「@1@2」で2回の共鳴をしてください"
  },
  Task_97311_Desc2 = {
    Text = "調査事件「餍飨」で2回の共鳴をしてください"
  },
  Task_97311_Name2 = {
    Text = "暴食の響き"
  },
  Task_97312_Desc = {
    Text = "調査事件「@1@2」で4回の共鳴をしてください"
  },
  Task_97312_Desc2 = {
    Text = "調査事件「餍飨」で4回の共鳴をしてください"
  },
  Task_97312_Name2 = {
    Text = "暴食の響きⅡ"
  },
  Task_97322_Desc = {
    Text = "溟夢の帷を完璧に守護する際に、「腐潮の傀」を撃破。"
  },
  Task_97322_Name = {
    Text = "ある約束、ひそかな見張り·隠れ"
  },
  Task_97673_Desc = {
    Text = "「第五日」を癲狂難易度でクリアする"
  },
  Task_97674_Desc = {
    Text = "「第一日」を癲狂難易度でクリアする"
  },
  Task_97675_Desc = {
    Text = "「第二日」を任意の難易度でクリアする"
  },
  Task_97676_Desc = {
    Text = "創生の七日間·クリア"
  },
  Task_97677_Desc = {
    Text = "「第七日」を任意の難易度でクリアする"
  },
  Task_97678_Desc = {
    Text = "混沌の領域の覚醒体で「創生七日」を1回勝ちます"
  },
  Task_97679_Desc = {
    Text = "完成「創生七日·通関」すべての実績"
  },
  Task_97680_Desc = {
    Text = "「第二日」を癲狂難易度でクリアする"
  },
  Task_97681_Desc = {
    Text = "「第七日」を癲狂難易度でクリアする"
  },
  Task_97682_Desc = {
    Text = "「第七日」を任意の難易度でクリアする"
  },
  Task_97683_Desc = {
    Text = "「第六日」を任意の難易度でクリアする"
  },
  Task_97684_Desc = {
    Text = "「第一日」を任意の難易度でクリアする"
  },
  Task_97685_Desc = {
    Text = "「第三日」を癲狂難易度でクリアする"
  },
  Task_97686_Desc = {
    Text = "超次元領域の覚醒体で「創生七日」を1回勝ちます"
  },
  Task_97687_Desc = {
    Text = "血肉の領域の覚醒体で「創生七日」を1回勝ちます"
  },
  Task_97688_Desc = {
    Text = "「第四日」を癲狂難易度でクリアする"
  },
  Task_97689_Desc = {
    Text = "「第一日」を任意の難易度でクリアする"
  },
  Task_97690_Desc = {
    Text = "超次元領域の覚醒体で「創生七日」を2回勝ちます"
  },
  Task_97691_Desc = {
    Text = "「第四日」を任意の難易度でクリアする"
  },
  Task_97692_Desc = {
    Text = "深海の領域の覚醒体で「創生七日」を1回勝ちます"
  },
  Task_97693_Desc = {
    Text = "「第三日」を任意の難易度でクリアする"
  },
  Task_97694_Desc = {
    Text = "混沌の領域の覚醒体で「創生七日」を2回勝ちます"
  },
  Task_97695_Desc = {
    Text = "「第六日」を任意の難易度でクリアする"
  },
  Task_97696_Desc = {
    Text = "血肉の領域の覚醒体で「創生七日」を2回勝ちます"
  },
  Task_97697_Desc = {
    Text = "「第六日」を癲狂難易度でクリアする"
  },
  Task_97698_Desc = {
    Text = "創生の七日間·癲狂"
  },
  Task_97699_Desc = {
    Text = "「第四日」を任意の難易度でクリアする"
  },
  Task_97700_Desc = {
    Text = "創生の七日間·界域"
  },
  Task_97701_Desc = {
    Text = "深海の領域の覚醒体で「創生七日」を2回勝ちます"
  },
  Task_97702_Desc = {
    Text = "「第二日」を任意の難易度でクリアする"
  },
  Task_97703_Desc = {
    Text = "「第三日」を任意の難易度でクリアする"
  },
  Task_97704_Desc = {
    Text = "「第五日」を任意の難易度でクリアする"
  },
  Task_97705_Desc = {
    Text = "「第五日」を任意の難易度でクリアする"
  },
  Task_97855_Desc = {
    Text = "血肉界域の覚醒体を使用して「日光下新事」で1回勝利"
  },
  Task_97856_Desc = {
    Text = "累計ログイン 6 日"
  },
  Task_97857_Desc = {
    Text = "累計ログイン 4 日"
  },
  Task_97858_Desc = {
    Text = "「詩的庭園」の狂気難易度をクリアする"
  },
  Task_97859_Desc = {
    Text = "異夢視界「さようなら、永遠の故郷」をクリアする"
  },
  Task_97860_Desc = {
    Text = "累計ログイン 3 日"
  },
  Task_97861_Desc = {
    Text = "「日光の下の新事·通関」すべての実績を完了しました"
  },
  Task_97862_Desc = {
    Text = "混沌界域の覚醒体を使用して「日光下新事」で2回勝利"
  },
  Task_97863_Desc = {
    Text = "深海界域の覚醒体を使用して「日光下新事」で1回勝利"
  },
  Task_97864_Desc = {
    Text = "「故地重游」の狂気難易度をクリアする"
  },
  Task_97865_Desc = {
    Text = "日光の下の新しいこと・通関"
  },
  Task_97866_Desc = {
    Text = "日光の下の新しいこと・界域"
  },
  Task_97867_Desc = {
    Text = "「完璧童話」の狂気難易度をクリアする"
  },
  Task_97868_Desc = {
    Text = "「詩的庭園」の任意の難易度をクリアする"
  },
  Task_97869_Desc = {
    Text = "超維界域の覚醒体を使用して「日光下新事」で1回勝利"
  },
  Task_97870_Desc = {
    Text = "「機械の夢」の任意の難易度をクリアする"
  },
  Task_97871_Desc = {
    Text = "「黒陽と対峙する」の狂気難易度をクリアする"
  },
  Task_97872_Desc = {
    Text = "「黒陽と対峙する」の任意の難易度をクリアする"
  },
  Task_97873_Desc = {
    Text = "「完璧童話」の任意の難易度をクリアする"
  },
  Task_97874_Desc = {
    Text = "血肉界域の覚醒体を使用して「日光下新事」で2回勝利"
  },
  Task_97875_Desc = {
    Text = "累計ログイン 5 日"
  },
  Task_97876_Desc = {
    Text = "「故地重游」の任意の難易度をクリアする"
  },
  Task_97877_Desc = {
    Text = "累計ログイン 7 日"
  },
  Task_97878_Desc = {
    Text = "「機械の夢」の狂気難易度をクリアする"
  },
  Task_97879_Desc = {
    Text = "「黒陽と対峙する」の任意の難易度をクリアする"
  },
  Task_97880_Desc = {
    Text = "累計ログイン 2 日"
  },
  Task_97881_Desc = {
    Text = "「完璧童話」の任意の難易度をクリアする"
  },
  Task_97882_Desc = {
    Text = "「機械の夢」の任意の難易度をクリアする"
  },
  Task_97883_Desc = {
    Text = "混沌界域の覚醒体を使用して「日光下新事」で1回勝利"
  },
  Task_97884_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_97885_Desc = {
    Text = "日光の下の新しいこと・癲狂"
  },
  Task_97886_Desc = {
    Text = "7日間ログイン"
  },
  Task_97887_Desc = {
    Text = "超維界域の覚醒体を使用して「日光下新事」で2回勝利"
  },
  Task_97888_Desc = {
    Text = "「故地重游」の任意の難易度をクリアする"
  },
  Task_97889_Desc = {
    Text = "深海界域の覚醒体を使用して「日光下新事」で2回勝利"
  },
  Task_97890_Desc = {
    Text = "「詩的庭園」の任意の難易度をクリアする"
  },
  Task_97952_Desc = {
    Text = "異夢視界「さようなら、永遠の故郷」をクリアする"
  },
  Task_97953_Desc = {
    Text = "「日々の訓練」を4回完了する"
  },
  Task_97954_Desc = {
    Text = "異夢視界「さようなら、永遠の故郷」をクリアする"
  },
  Task_97955_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_97956_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_97957_Desc = {
    Text = "エンフェリンを1500消費"
  },
  Task_97958_Desc = {
    Text = "「日々の訓練」を4回完了する"
  },
  Task_97959_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_97960_Desc = {
    Text = "エンフェリンを1500消費"
  },
  Task_97961_Desc = {
    Text = "累計消費 100000 蔷薇金券"
  },
  Task_97962_Desc = {
    Text = "派遣を20回完了する"
  },
  Task_97963_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_97964_Desc = {
    Text = "融災禁区の特訓値が100に到達"
  },
  Task_97965_Desc = {
    Text = "累計消費 100000 蔷薇金券"
  },
  Task_97966_Desc = {
    Text = "超越存在を1回クリア"
  },
  Task_97967_Desc = {
    Text = "累計ログイン 1 日"
  },
  Task_98151_Desc = {
    Text = "深海胎動·期間限定専属"
  },
  Task_98347_Desc = {
    Text = "このシーズンで10勝を達成する"
  },
  Task_98347_Name = {Text = "10勝"},
  Task_98348_Desc = {
    Text = "このシーズンで3勝を達成する"
  },
  Task_98348_Name = {Text = "3勝"},
  Task_98349_Desc = {
    Text = "このシーズンで6勝を達成する"
  },
  Task_98349_Name = {Text = "6勝"},
  Task_98350_Desc = {
    Text = "このシーズンで1勝を達成する"
  },
  Task_98350_Name = {Text = "1勝"},
  Task_98505_Desc = {
    Text = "意識潜行「不朽の白夜」をクリア"
  },
  Task_98505_Name = {
    Text = "嬉しさが破壊される日"
  },
  Task_98700_Desc = {
    Text = "累計ログイン 15 日"
  },
  Task_98701_Desc = {
    Text = "今週の試練を2回完了する"
  }
})
return Text_Task
