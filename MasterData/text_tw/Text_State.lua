__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_State = readonly({
  State_100291_Desc = {
    Text = "所有喚醒體造成的狂氣提高 50%。"
  },
  State_100292_Name = {
    Text = "回合開始"
  },
  State_100293_Desc = {
    Text = "所有喚醒體造成的狂氣降低 50%。"
  },
  State_100293_Name = {
    Text = "人格陰影"
  },
  State_100295_Name = {
    Text = "傷害監聽"
  },
  State_100296_Desc = {
    Text = "每有 1 層，回合開始後所有喚醒體獲得 <Energy:5> 狂氣。"
  },
  State_100297_Desc = {
    Text = "所有喚醒體造成的狂氣提高 50%，回合結束時獲得 20% 最大生命的護盾。"
  },
  State_100297_Name = {
    Text = "心靈壁壘"
  },
  State_100298_Desc = {
    Text = "回合開始後失去 10% 當前生命，獲得 [DescArg1] 點<PowerIconKeywords:力量>。所有喚醒體造成的狂氣降低 50%。"
  },
  State_100298_Name = {
    Text = "壁壘崩解"
  },
  State_100299_Desc = {
    Text = "狂氣爆發計數"
  },
  State_100299_Name = {
    Text = "狂氣爆發計數"
  },
  State_100302_Name = {
    Text = "狂氣爆發監聽"
  },
  State_100307_Desc = {
    Text = "隊伍唯一：裝備者釋放狂氣爆發後獲得 1 層「共創」，本回合內下次其他喚醒體的狂氣爆發能夠消耗「共創」，使該次狂氣爆發暴擊率提高 <WeaponEffect_Num:[StateArg1]%>，並使消耗「共創」的喚醒體獲得裝備者狂氣回充 <WeaponEffect_Num:[StateArg1]%> 的狂氣。"
  },
  State_100307_WeaponDesc = {
    Text = "裝備者釋放狂氣爆發後獲得 1 層「共創」，本回合內下次其他喚醒體的狂氣爆發能夠消耗「共創」，使該次狂氣爆發暴擊率提高 <WeaponEffect_Num:[StateArg1]%>，並使消耗「共創」的喚醒體獲得 <WeaponEffect_Num:[DescArg1]> 點狂氣。"
  },
  State_100326_Desc = {
    Text = "每有 1 層，回合開始後所有喚醒體獲得 <Energy:3> 狂氣。"
  },
  State_100327_Desc = {
    Text = "所有喚醒體造成的狂氣提高 50%，回合結束時獲得 20% 最大生命的護盾。"
  },
  State_100327_Name = {
    Text = "<MindWall:心靈壁壘>"
  },
  State_100328_Desc = {
    Text = "所有喚醒體造成的狂氣提高 50%。"
  },
  State_100329_Desc = {
    Text = "所有喚醒體造成的狂氣降低 50%，回合結束後獲得 1 層「<DarkEgo:自我暗面>」：回合開始後，所有喚醒體獲得 3 狂氣。"
  },
  State_100329_Name = {
    Text = "<ShadowSelf:人格陰影>"
  },
  State_100330_Desc = {
    Text = "回合開始後失去 10% 當前生命，獲得 [DescArg1] 點<PowerIconKeywords:力量>。所有喚醒體造成的狂氣降低 50%。"
  },
  State_100330_Name = {
    Text = "<BarrierCrash:壁壘崩解>"
  },
  State_100395_Name = {
    Text = "創構的恩賜之血+"
  },
  State_100396_Name = {
    Text = "創構的恩賜之血"
  },
  State_100527_Desc = {
    Text = "皮克曼觸發「發現」效果時額外增加「靈感迸發！」選項：消耗 1 層「狂想」，選擇所有效果並獲得 1 層「創意」。"
  },
  State_100541_Desc = {
    Text = "若當前擁有 10 層「創意」，皮克曼釋放狂氣爆發後消耗所有「創意」，獲得 1 層狂想並使所有喚醒體獲得 15 點狂氣。創意上限為 10 層，能夠繼承至下場戰鬥。"
  },
  State_100541_Name = {
    Text = "<Chuangyi:創意>"
  },
  State_100542_Desc = {
    Text = "皮克曼觸發「發現」效果時額外增加「靈感迸發！」選項：消耗 1 層「狂想」，選擇所有「發現」效果並獲得 1 層「創意」。"
  },
  State_100544_WeaponDesc = {
    Text = "裝備者造成的護盾與生命回復提高 6%。若裝備者界域精通大於 50，護盾與生命回復額外提高 6%。"
  },
  State_100545_WeaponDesc = {
    Text = "裝備者造成的護盾與生命回復提高 6%。若裝備者界域精通大於 50，護盾與生命回復額外提高 6%。"
  },
  State_100558_Desc = {
    Text = "本回合下次其他喚醒體狂氣爆發暴擊率提高 [StateArg1]％，使用後獲得 [DescArg1] 點狂氣。"
  },
  State_100558_Name = {Text = "共創"},
  State_100559_Desc = {
    Text = "包含以下「星辰篇造物」：惡童、春之祭、重鎖、纏絲瑪瑙、恩賜之血、銹蝕鋼鋸、金色夢鄉、染血鵝卵石。"
  },
  State_100559_Name = {
    Text = "<Chuanggouzaowu:創構的造物>"
  },
  State_100562_Desc = {
    Text = "本回合打出的下 [Layer] 張指令卡算力消耗降低 2。"
  },
  State_100562_Name = {
    Text = "真實,亦是幻想"
  },
  State_100564_Desc = {
    Text = "包含以下「刻印」：籌算、妙手、狂化、催化、蠻力、鐵壁、衰竭、靈感。"
  },
  State_100564_Name = {
    Text = "<Chuanggoukeyin:創構的刻印>"
  },
  State_100566_WeaponDesc = {
    Text = "打出前改變卡牌算力"
  },
  State_100617_Desc = {
    Text = "回合結束時，獲得 1 條觸腕上限。"
  },
  State_100617_Name = {
    Text = "湮塞的執念"
  },
  State_100619_Desc = {
    Text = "力量被降低時，僅會降低 50% 的力量層數。"
  },
  State_100621_Desc = {
    Text = "每有 1 層使玩家造成的基礎傷害降低 15%，能在之後指引航行的方向。"
  },
  State_100621_Name = {
    Text = "微弱燭光"
  },
  State_100623_Desc = {
    Text = "每有 1 層使玩家造成的基礎傷害降低 30%，造成主動或觸腕傷害後，減少自身 [DescArg1] 中毒。"
  },
  State_100639_Desc = {
    Text = "造成的觸腕傷害臨時降低 50%。"
  },
  State_100639_Name = {
    Text = "遺失的久遠之城"
  },
  State_100644_Desc = {
    Text = "永久降低目標力量，獲得等量力量。"
  },
  State_100647_Desc = {
    Text = "免疫一切傷害。"
  },
  State_100647_Name = {
    Text = "免疫一切傷害。"
  },
  State_100694_Desc = {
    Text = "每有 1 層使玩家造成的基礎傷害降低 30%，造成主動或觸腕傷害後，減少自身中毒。"
  },
  State_116342_Desc = {
    Text = "打出<ErosionColorInkKeywords:認知錯亂>卡牌後使「繪者」獲得 1 層<DecayDye:幻世染料>。"
  },
  State_116342_Name = {
    Text = "異象調色盤"
  },
  State_116406_Name = {Text = "進階"},
  State_116407_Name = {Text = "空狀態"},
  State_116858_Desc = {
    Text = "此狀態用的是易傷乘區，假裝是個獨立乘區。__「僅開發用」"
  },
  State_116858_Name = {
    Text = "若擁有某狀態則受到傷害翻倍__「僅開發用」"
  },
  State_116859_Desc = {
    Text = "下回合開始時，獲得破綻。"
  },
  State_116859_Name = {
    Text = "延遲破綻"
  },
  State_116958_Desc = {
    Text = "打出卡牌後，受到對應層數的傷害。"
  },
  State_116958_Name = {
    Text = "<PVPCardLockColour:卡牌封鎖>"
  },
  State_117154_Desc = {
    Text = "該效果在隊伍的所有喚醒體上僅會生效 1 次，無法重複觸發。"
  },
  State_117154_Name = {
    Text = "<TeamUnique: 隊伍唯一>"
  },
  State_117212_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」前和回合結束時，對<HPAndShieldMax:生命與護盾最高>的敵方施加 <Damage:[Damage:StateArg1]> 層<PVPCorrosionKeywords:罪印>。"
  },
  State_117212_Name = {
    Text = "扭曲的騎士詩"
  },
  State_117213_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」和回合結束時，對狂氣最高的敵方造成 [StateArg1] <PVPfengsuoKeywords:爆發封鎖>。"
  },
  State_117213_Name = {
    Text = "聖子尊容"
  },
  State_117346_Desc = {
    Text = "波呂克斯造成的傷害附加 [Layer]％ 出血。"
  },
  State_117355_Desc = {
    Text = "波呂克斯打出的下一張指令卡生效 2 次。"
  },
  State_117355_Name = {
    Text = "神啟新約"
  },
  State_117357_Desc = {
    Text = "隊伍唯一：「融痕」和「灰燼遺跡」刷新後使裝備者獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣。"
  },
  State_117357_WeaponDesc = {
    Text = "「融痕」和「灰燼遺跡」刷新後使裝備者獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣。"
  },
  State_117358_Desc = {
    Text = "每層使波呂克斯造成的傷害附加 1% 出血。"
  },
  State_117744_Desc = {
    Text = "失去 [Layer] <MaxHPKeywords:最大生命值>，被驅散時不會返還失去的最大生命，觸發時受到 [Layer] 點純粹傷害，永續。"
  },
  State_117745_Desc = {
    Text = "施加時失去等量層數的<MaxHPKeywords:最大生命值>，被驅散時不會返還失去的最大生命，觸發時受到等量層數的純粹傷害，永續。"
  },
  State_117755_Desc = {
    Text = "回合結束之前無法進行任何行動。"
  },
  State_117756_Desc = {
    Text = "回合結束之前無法進行任何行動。"
  },
  State_117776_Desc = {
    Text = "本回合下 [Layer] 張指令卡最終傷害和護盾提高 [StateArg1]％。"
  },
  State_117777_Desc = {
    Text = "隊伍唯一：裝備者卡牌造成的基礎傷害與暴擊傷害提高 <WeaponEffect_Num:[StateArg1]%>。回合開始時和裝備者釋放狂氣爆發後獲得 1 層心火，裝備者本回合打出指令卡時消耗 1 層「心火」，使其最終傷害和護盾提高 <WeaponEffect_Num:[StateArg2]%>。超維回合中改為獲得「神焰」，效果翻倍。"
  },
  State_117777_WeaponDesc = {
    Text = "裝備者卡牌造成的基礎傷害與暴擊傷害提高 <WeaponEffect_Num:[StateArg1]%>。回合開始時和裝備者釋放狂氣爆發後獲得 1 層心火，裝備者本回合打出指令卡時消耗 1 層「心火」，使其最終傷害和護盾提高 <WeaponEffect_Num:[StateArg2]%>。超維回合中改為獲得「神焰」，效果翻倍。"
  },
  State_117778_Desc = {
    Text = "本回合下 [Layer] 張指令卡最終傷害和護盾提高 [StateArg1]％。"
  },
  State_117779_Desc = {
    Text = "隊伍唯一：超維回合裝備者獲得 3 層「心火」，裝備者本回合打出指令卡時消耗 1 層，使其最終傷害和護盾提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_117779_WeaponDesc = {
    Text = "超維回合裝備者獲得 3 層「心火」，裝備者本回合打出指令卡時消耗 1 層，使其最終傷害和護盾提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_117851_Desc = {
    Text = "波呂克斯每張指令卡額外享受 50% 「苦痛救贖」效果，持續 [Layer] 回合。"
  },
  State_117851_Name = {
    Text = "照徹白夜之光"
  },
  State_117853_Desc = {
    Text = "波呂克斯本回合打出的下 [Layer] 張指令卡傷害提高 [DescArg1]，護盾提高 [DescArg2] ，獲得 10 點狂氣。"
  },
  State_117853_Name = {
    Text = "苦痛救贖"
  },
  State_117869_Desc = {
    Text = "每次釋放狂氣爆發增加 1 層「呼喚」，每有 1 層「呼喚」獲得 [DescArg1] 點力量，上限為 5 層。"
  },
  State_117870_Desc = {
    Text = "死亡後，擊殺者回復 20% 已損失生命。"
  },
  State_117870_Name = {
    Text = "美味魚生"
  },
  State_117875_Desc = {
    Text = "若後方有空餘位置，則在行動後失去 1 層，召喚 1 個附加「美味魚生」的「幼魚」。"
  },
  State_117875_Name = {
    Text = "互助契約：魚群"
  },
  State_117876_Desc = {
    Text = "造成的 <WeaknessIconKeywords:虛弱>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重創>效果提高為 50%。"
  },
  State_117876_Name = {
    Text = "虛弱&脆弱&重創加深"
  },
  State_117880_Desc = {
    Text = "本場戰鬥中之後的「魚群飛躍」額外觸發 1 次。"
  },
  State_117880_Name = {
    Text = "魚群飛躍額外觸發"
  },
  State_117883_Desc = {
    Text = "達到 5 層後，立即封印全體喚醒體，將意圖更換為：「利莫里亞的榮光！+」。"
  },
  State_117883_Name = {Text = "呼喚"},
  State_117885_Desc = {
    Text = "受到力量降低效果時也會對施加者產生等量力量降低效果。"
  },
  State_117885_Name = {
    Text = "以牙還牙"
  },
  State_117889_Desc = {
    Text = "登場時自身最大生命提高 10% 併為其他友方增加 [DescArg1] 的<PowerIconKeywords:力量>，使本場戰鬥中<FishLeapWords:群序之力>的生命提高和獲取力量效果額外觸發 1 次。"
  },
  State_118112_Desc = {
    Text = "受到的單次傷害上限為 [DescArg1] 點，生命低於 50% 後移除。"
  },
  State_118112_Name = {
    Text = "承痛閾值 I"
  },
  State_118113_Desc = {
    Text = "受到主動傷害並失去生命後，獲得等同於失去生命 15% 的護盾和失去生命 5% 的<AlertIconKeywords: 臨時戒備>。"
  },
  State_118113_Name = {
    Text = "軟體特性I"
  },
  State_118114_Desc = {
    Text = "受到主動傷害並失去生命後，獲得等同於失去生命 35% 的護盾和失去生命 10% 的<AlertIconKeywords: 臨時戒備>。"
  },
  State_118114_Name = {
    Text = "軟體特性III"
  },
  State_118115_Desc = {
    Text = "若前排有空餘位置，則在行動後失去 1 層，召喚 1 個「深海分殖體」。"
  },
  State_118115_Name = {
    Text = "互助契約：深海分殖體"
  },
  State_118116_Desc = {
    Text = "受到的單次傷害上限為 [DescArg1] 點，生命低於 50% 後移除。"
  },
  State_118116_Name = {
    Text = "承痛閾值 II"
  },
  State_118117_Desc = {
    Text = "受到的單次傷害上限為 [DescArg1] 點，生命低於 50% 後移除。"
  },
  State_118117_Name = {
    Text = "承痛閾值III"
  },
  State_118118_Desc = {
    Text = "獲得 1 條<TentacleInjurieIconKeywords:觸腕傷害>為 [TentaclePower:DescArg1] 的觸腕和 5 條觸腕上限。回合結束後獲得 1 條觸腕。受到的力量降低效果縮減 50%。"
  },
  State_118118_Name = {
    Text = "觸腕集結"
  },
  State_118119_Desc = {
    Text = "受到主動傷害並失去生命後，獲得等同於失去生命 25% 的護盾和失去生命 5% 的<AlertIconKeywords: 臨時戒備>。"
  },
  State_118119_Name = {
    Text = "軟體特性II"
  },
  State_118319_Desc = {
    Text = "受到的單次傷害上限為 [DescArg1] 點，生命低於 50% 後移除。"
  },
  State_118319_Name = {
    Text = "海淵之盾傷害限制"
  },
  State_118320_Name = {
    Text = "臨時衰竭反制計數"
  },
  State_118321_Name = {
    Text = "衰竭反制計數"
  },
  State_118322_Name = {
    Text = "預備召喚標記"
  },
  State_118323_Desc = {
    Text = "觸發過魚群飛躍"
  },
  State_118323_Name = {
    Text = "魚群飛躍出場標記"
  },
  State_118324_Desc = {
    Text = "每造成 1 次傷害，生成 1 條臨時觸腕。"
  },
  State_118325_Desc = {
    Text = "造成未被格擋的傷害時將 [DescArg1] 張窒息洗入抽牌堆頂部"
  },
  State_118325_Name = {
    Text = "新世界蛇頭人震顫"
  },
  State_118656_Desc = {
    Text = "打出卡牌時受到 [StateArg1] 點傷害並移除 1 層。層數為 0 時孵化一個較弱的「海中之物」。若回合結束時仍存在被寄生狀態，孵化一個生命隨層數提高的「海中之物」。"
  },
  State_118657_Desc = {
    Text = "打出卡牌時受到 [StateArg1] 點傷害並移除 1 層。層數為 0 時孵化一個較弱的「海中之物」。若回合結束時仍存在被寄生狀態，孵化一個生命隨層數提高的「海中之物」。"
  },
  State_118659_Desc = {
    Text = "打出卡牌時受到 [StateArg1] 點傷害並移除 1 層。層數為 0 時孵化一個較弱的「海中之物」。若回合結束時仍存在被寄生狀態，孵化一個生命隨層數提高的「海中之物」。"
  },
  State_118663_Name = {
    Text = "新世界蛇頭人意圖監聽"
  },
  State_118669_Name = {
    Text = "新世界蛇頭人初始化"
  },
  State_118670_Desc = {
    Text = "檢測是否有衰竭反制"
  },
  State_118670_Name = {
    Text = "衰竭反制檢測"
  },
  State_118671_Desc = {
    Text = "檢測玩家上衰竭的行為"
  },
  State_118671_Name = {
    Text = "衰竭反制監聽"
  },
  State_118672_Name = {
    Text = "新世界蛇頭人意圖監聽冷卻"
  },
  State_118741_Name = {
    Text = "清除臨時觸腕"
  },
  State_118743_Name = {
    Text = "預備召喚前置位需要召喚標記"
  },
  State_118759_Name = {
    Text = "怪物當前永久觸腕數量"
  },
  State_118760_Name = {
    Text = "怪物永久觸腕上限"
  },
  State_118762_Name = {
    Text = "首次腐朽提示語"
  },
  State_118763_Name = {
    Text = "首次神經毒素穿血提示語"
  },
  State_118764_Name = {
    Text = "首次咒怨吹息提示語"
  },
  State_118766_Name = {
    Text = "藍環章魚BOSS意圖監聽"
  },
  State_118769_Name = {
    Text = "銀芯提燈提示語"
  },
  State_118771_Name = {
    Text = "首次試探提示語"
  },
  State_118772_Name = {
    Text = "首次群蛇撕裂提示語"
  },
  State_118935_Name = {
    Text = "怪物墨菲意圖監聽"
  },
  State_118938_Desc = {
    Text = "「深海淑女」已經覺醒，造成的護盾量大大提高！"
  },
  State_118943_Desc = {
    Text = "自身回合受到的傷害翻倍。自身失去生命時，失去等量層數。層數為 0 時使觸腕條數永久降低 1 條並重置層數，最低為 1 條。"
  },
  State_118943_Name = {
    Text = "神母的犧牲"
  },
  State_118973_Name = {
    Text = "隱忍的叛逆管理"
  },
  State_119051_Desc = {
    Text = "回合結束時觸發，觸發時受到等量層數的純粹傷害並移除一半層數，無法驅散。"
  },
  State_119051_Name = {
    Text = "<PVPSacrificeKeyWords:獻祭>"
  },
  State_119052_Desc = {
    Text = "受到主動傷害後獲得傷害 [Layer]% 的獻祭。"
  },
  State_119052_Name = {
    Text = "降生儀式"
  },
  State_119053_Desc = {
    Text = "回合結束時觸發，觸發時受到 [Layer] 點純粹傷害並移除一半層數，無法驅散。"
  },
  State_119053_Name = {Text = "獻祭"},
  State_119058_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，對最少獻祭的敵方施加 [StateArg1] <PVPSacrificeKeyWords:獻祭>，重複 [StateArg2] 次。全體友方不再受到<PVPCapKeywords:算力上限>減少效果影響。"
  },
  State_119059_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使全體敵方本回合受到主動傷害後獲得傷害 [StateArg1]% 的獻祭。"
  },
  State_119059_Name = {
    Text = "藍環毒素"
  },
  State_119060_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提高 [StateArg1]%，任意友方打出「打擊」後抽 [StateArg3] 張牌，每回合最多觸發 [StateArg2] 次（當前已觸發 [DescArg1] 次）。"
  },
  State_119060_Name = {
    Text = "狂戮至世界盡頭"
  },
  State_119061_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：全體友方「打擊」傷害提高 [StateArg1]%。"
  },
  State_119061_Name = {
    Text = "理智明燈"
  },
  State_119063_Desc = {
    Text = "達到 5 層後，將意圖更換為：「利莫里亞的榮光！」。"
  },
  State_119063_Name = {Text = "呼喚"},
  State_119075_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_119075_Name = {
    Text = "尚未覺醒"
  },
  State_119076_Desc = {
    Text = "若前排有空餘位置，則在行動後失去 1 層，隨機召喚 1 個「利莫里亞喚醒體」。"
  },
  State_119076_Name = {
    Text = "互助契約：利莫里亞"
  },
  State_119077_Desc = {
    Text = "「呼喚」達到 5 層後，立即封印所有喚醒體。"
  },
  State_119077_Name = {
    Text = "彌利亞姆覺醒！"
  },
  State_119077_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_119080_Desc = {
    Text = "釋放「混沌記憶」或「未至遺忘的黎明」時，選擇的鑰令額外生效 1 次。"
  },
  State_119080_Name = {
    Text = "來自遺忘"
  },
  State_119082_Desc = {
    Text = "每次喚醒體釋放狂氣爆發後、其基礎狂氣提高 10 點。"
  },
  State_119082_Name = {
    Text = "狂氣衰竭"
  },
  State_119083_Desc = {
    Text = "指令卡從超維空間取出時，算力消耗-1。"
  },
  State_119083_Name = {
    Text = "彼界終途"
  },
  State_119084_Desc = {
    Text = "每次釋放鑰令、使所需銀鑰能量提高 100 點。"
  },
  State_119084_Name = {
    Text = "銀鑰震盪"
  },
  State_119085_Desc = {
    Text = "使用猩紅熔爐後，將 1 個胚胎變為聖潔之子，3 回合冷卻。"
  },
  State_119085_Name = {
    Text = "猩紅哺育"
  },
  State_119086_Desc = {
    Text = "繁育之力冷卻中，剩餘 [Layer] 回合。"
  },
  State_119086_Name = {
    Text = "繁育之力-冷卻"
  },
  State_119104_Desc = {
    Text = "回合開始時獲得 [DescArg1] 層「命契」。"
  },
  State_119104_Name = {
    Text = "海祭典儀"
  },
  State_119105_Desc = {
    Text = "死亡後失去所有「命契」。每層回復 1% 最大生命並使觸腕傷害提高 1%。"
  },
  State_119106_Name = {
    Text = "怪物誕妄墨菲意圖監聽"
  },
  State_119107_Name = {
    Text = "神國秩序管理"
  },
  State_119108_Desc = {
    Text = "失去生命時，每有 1 層獲得失去生命 1% 的<SacrificeKeyWord:獻祭>。"
  },
  State_119108_Name = {
    Text = "降生儀式"
  },
  State_119109_Desc = {
    Text = "受到來自<SacrificeKeyWord:獻祭>以外的傷害時，失去等量「神國秩序」，並獲得傷害 50% 的<SacrificeKeyWord:獻祭>。層數為 0 時獲得 1 層「命契」並重置層數。"
  },
  State_119109_Name = {
    Text = "神國秩序"
  },
  State_119132_Desc = {
    Text = "本回合「打擊」傷害提高 [Layer]%。"
  },
  State_119132_Name = {
    Text = "打擊強化"
  },
  State_119134_Name = {
    Text = "首次虛妄開創者提示語"
  },
  State_119359_Name = {
    Text = "銀鑰儀式計數"
  },
  State_119362_Name = {
    Text = "進行儀式"
  },
  State_119363_Name = {
    Text = "擁有卡牌"
  },
  State_119364_Name = {
    Text = "狂氣儀式計數"
  },
  State_119365_Desc = {
    Text = "所有喚醒體造成的生命回復和護盾提高 40%。"
  },
  State_119365_Name = {
    Text = "鎮定自若"
  },
  State_119366_Desc = {
    Text = "棄置後回到手中"
  },
  State_119366_Name = {
    Text = "棄置後回到手中"
  },
  State_119367_Name = {
    Text = "生命儀式計數"
  },
  State_119368_Desc = {
    Text = "每回合開始時獲得 500 點銀鑰能量。"
  },
  State_119368_Name = {
    Text = "洞若觀火"
  },
  State_119369_Desc = {
    Text = "所有喚醒體造成狂氣提高 50%。"
  },
  State_119373_Name = {
    Text = "敵方施加獻祭"
  },
  State_119567_Name = {
    Text = "完成儀式"
  },
  State_119568_Desc = {
    Text = "受到的打擊傷害提高 [Layer] 點。"
  },
  State_119568_Name = {
    Text = "打擊加深"
  },
  State_119583_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」前、「技能」前、「狂氣爆發」前臨時<StrongEffectKeywords:強效> +[StateArg1]，每回合各效果僅能觸發一次。"
  },
  State_119583_Name = {
    Text = "你我終將重逢"
  },
  State_119589_Name = {Text = "超維cd"},
  State_119590_Desc = {
    Text = "隊伍唯一：主動切換觸腕姿態、使用猩紅熔爐、釋放「湮滅」後，抽 1 張裝備者的指令卡，每個效果各 3 回合冷卻。所有喚醒體探索所獲得的同調率提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_119590_WeaponDesc = {
    Text = "主動切換觸腕姿態(當前剩餘 [DescArg1] 回合冷卻)、使用猩紅熔爐(當前剩餘 [DescArg2] 回合冷卻)、釋放「湮滅」後(當前剩餘 [DescArg3] 回合冷卻)，抽 1 張裝備者的指令卡，每個效果各 3 回合冷卻。完成探索後，所有喚醒體獲得的同調率提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_119741_Desc = {
    Text = "所有喚醒體獲得力量效果降低 50%。"
  },
  State_119741_Name = {
    Text = "聖像詛咒：衰亡之哀"
  },
  State_119742_Desc = {
    Text = "每回合開始時回復已損失生命的 15%。"
  },
  State_119742_Name = {
    Text = "聖像賜福：永恆之夢"
  },
  State_119743_Desc = {
    Text = "所有喚醒體生命回復降低 50%。"
  },
  State_119743_Name = {
    Text = "聖像詛咒：破滅之恨"
  },
  State_119744_Desc = {
    Text = "「聖像詛咒：破滅之恨」失效 1 回合。"
  },
  State_119744_Name = {
    Text = "免疫聖像詛咒：破滅之恨"
  },
  State_119746_Name = {
    Text = "深淵之鎖失去次數"
  },
  State_119747_Desc = {
    Text = "不會受到傷害，持續 1 回合。"
  },
  State_119747_Name = {
    Text = "銀鑰，指引前路"
  },
  State_119748_Desc = {
    Text = "「聖像詛咒：衰亡之哀」失效 1 回合。"
  },
  State_119748_Name = {
    Text = "免疫聖像詛咒：衰亡之哀"
  },
  State_119749_Desc = {
    Text = "在守密人回合開始時對其等同於「<Abyssallock:夢境桎梏>」層數的手牌施加 1 層<SlowIconKeywords:遲緩>。"
  },
  State_119749_Name = {
    Text = "夢境桎梏"
  },
  State_119750_Name = {
    Text = "天之帷幕意圖監聽"
  },
  State_119751_Name = {
    Text = "帷幕重現釋放標誌"
  },
  State_119752_Desc = {
    Text = "每回合開始時獲得最大生命的 5% 的<PowerIconKeywords:力量>，臨時暴擊率 +25%。"
  },
  State_119752_Name = {
    Text = "聖像賜福：威能之夢"
  },
  State_119753_Name = {
    Text = "黯淡海淵之潮計數"
  },
  State_119754_Desc = {
    Text = "所有喚醒體造成的狂氣降低 50%。"
  },
  State_119754_Name = {
    Text = "聖像詛咒：癡愚之歎"
  },
  State_119755_Name = {
    Text = "死亡計數"
  },
  State_119756_Desc = {
    Text = "「聖像詛咒：癡愚之歎」失效 1 回合。"
  },
  State_119756_Name = {
    Text = "免疫聖像詛咒：癡愚之歎"
  },
  State_119757_Desc = {
    Text = "在守密人回合開始時對其等同於「<Abyssallock:夢境桎梏>」層數的手牌施加 1 層<SlowIconKeywords:遲緩>。每次「樂園帷幕」被主動傷害擊破都會降低 1 層、並使擊破的喚醒體「完全封印」 1 回合。"
  },
  State_119757_Name = {
    Text = "夢境桎梏"
  },
  State_119758_Desc = {
    Text = "每回合開始時所有喚醒體獲得 10 點狂氣。"
  },
  State_119758_Name = {
    Text = "聖像賜福：智識之夢"
  },
  State_119760_Name = {
    Text = "死亡監聽"
  },
  State_119789_Desc = {
    Text = "回合開始時，回復 [Layer] 點生命。"
  },
  State_119837_Desc = {
    Text = "拉蒙娜本回合打出的下一張指令卡生效 2 次。"
  },
  State_119837_Name = {
    Text = "再次牽手"
  },
  State_119847_Desc = {
    Text = "打出前改變卡牌算力。__「僅開發用」"
  },
  State_119847_Name = {
    Text = "打出前改變卡牌算力__「僅開發用」"
  },
  State_119928_Desc = {
    Text = "打出後額外生效 [StateArg1] 次，<DepleteIconKeywords:消耗>。<RippleKeywords:餘波>：抽 2 張牌。"
  },
  State_119928_Name = {
    Text = "<Rune_20:淵海回聲>"
  },
  State_119958_Desc = {
    Text = "死亡後立刻召喚一名隨機的「魚群」 ，使其「魚潮洄遊」降低 1 層。"
  },
  State_119958_Name = {
    Text = "魚潮洄遊"
  },
  State_119959_Desc = {
    Text = "死亡後立刻召喚一名隨機的「胎群」 ，使其「生生不息」降低 1 層。"
  },
  State_119960_Desc = {
    Text = "造成的主動和觸腕傷害降低 35%，玩家當前生命高於 50% 時清除。"
  },
  State_120215_Desc = {
    Text = "在守密人回合開始時對其等同於「<Abyssallock:夢境桎梏>」層數的手牌施加 1 層<SlowIconKeywords:遲緩>。每次「樂園帷幕」被主動傷害擊破都會降低 1 層、並使擊破的喚醒體「完全封印」 1 回合。"
  },
  State_120215_Name = {
    Text = "深淵之鎖"
  },
  State_120216_Desc = {
    Text = "在守密人回合開始時對其等同於「<Abyssallock:深淵之鎖>」層數的手牌施加 1 層<SlowIconKeywords:遲緩>。"
  },
  State_120216_Name = {
    Text = "深淵之鎖"
  },
  State_120218_Name = {
    Text = "回合結束選擇墨菲支援"
  },
  State_120222_Name = {
    Text = "回合開始選擇反轉詛咒"
  },
  State_120292_Name = {
    Text = "不被接納之痛"
  },
  State_120293_Desc = {
    Text = "回合結束時回復 [Layer] 點生命。"
  },
  State_120293_Name = {
    Text = "不被接納之痛"
  },
  State_120312_Desc = {
    Text = "死亡後立刻召喚一名隨機的「魚王」 ，使其「魚潮洄遊」降低 1 層。"
  },
  State_120312_Name = {
    Text = "魚潮洄遊"
  },
  State_120320_Desc = {
    Text = "每層使下次「虛妄王女」施加的「降生儀式」提高 20％，最多疊加 5 層，疊加滿 5 層後下次「虛妄王女」傷害次數翻倍。"
  },
  State_120321_Desc = {
    Text = "每層使承受主動或觸腕傷害時附加 1% 傷害的獻祭，回合結束時移除，上限 75 層。"
  },
  State_120321_Name = {
    Text = "<DwmofeiKeywords:降生儀式>"
  },
  State_120322_Desc = {
    Text = "隊伍唯一：手牌上限+2，無法和其他命輪提供的手牌上限疊加。裝備者銀鑰充能、狂氣爆發造成的最終傷害、護盾提高 <WeaponEffect_Num:[StateArg1]%>。切換「靜海」姿態時，裝備者獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣，3 回合冷卻。切換「怒濤」姿態時，對所有敵人施加 <WeaponEffect_Num:[StateArg3]> 層<DwmofeiKeywords:降生儀式>，3 回合冷卻。"
  },
  State_120322_WeaponDesc = {
    Text = "手牌上限+2，無法和其他命輪提供的手牌上限疊加。裝備者銀鑰充能、狂氣爆發造成的最終傷害、護盾提高 <WeaponEffect_Num:[StateArg1]%>。切換「靜海」姿態時，裝備者獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣，3 回合冷卻。切換「怒濤」姿態時，對所有敵人施加 <WeaponEffect_Num:[StateArg3]> 層<DwmofeiKeywords:降生儀式>，3 回合冷卻。"
  },
  State_120324_Desc = {
    Text = "承受主動或觸腕傷害時附加 [Layer]% 傷害的獻祭，回合結束時移除，至多疊加 75 層。"
  },
  State_120324_Name = {
    Text = "降生儀式"
  },
  State_120351_Desc = {
    Text = "[Layer] 回合後能夠再次切換「神國·靜海」。"
  },
  State_120351_Name = {
    Text = "神國·靜海冷卻"
  },
  State_120354_Desc = {
    Text = "[Layer] 回合後能夠再次切換「神國·怒濤」。"
  },
  State_120354_Name = {
    Text = "神國·怒濤冷卻"
  },
  State_120357_Name = {Text = "觸腕"},
  State_120362_Desc = {
    Text = "受到來自<SacrificeKeyWord:獻祭>以外的傷害時，獲得傷害 50% 的<SacrificeKeyWord:獻祭>。"
  },
  State_120362_Name = {
    Text = "通用怪物獻祭管理"
  },
  State_120363_Desc = {
    Text = "回合結束後受到 [Layer] 點傷害並減少 50%<SacrificeKeyWord:獻祭>層數。"
  },
  State_120363_Name = {
    Text = "<BlueKeyWord:獻祭>"
  },
  State_120364_Desc = {
    Text = "自身死亡後召喚「蹈海者近衛」。"
  },
  State_120364_Name = {
    Text = "信念長存"
  },
  State_120401_Desc = {
    Text = "此卡牌算力消耗 -[StateArg5]，打出後抽 [StateArg4] 牌。"
  },
  State_120401_Name = {
    Text = "<OrangeQuality:彌薩格徽章>"
  },
  State_120450_Name = {
    Text = "藍環章魚記錄玩家生命"
  },
  State_120462_Desc = {
    Text = "戰鬥結束後仍然保留在牌庫中，但打出或被消耗後將永久移除。"
  },
  State_120462_Name = {
    Text = "<DestructionKeywords:銷毀>"
  },
  State_120900_Name = {
    Text = "預備召喚「利莫里亞喚醒體」計數"
  },
  State_120907_Desc = {
    Text = "觸腕攻擊時若被格擋，則造成 [DescArg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  State_120908_Desc = {
    Text = "觸腕攻擊時若被格擋，則造成等量層數的<IntoxicationIconKeywords:中毒>。"
  },
  State_120910_Desc = {
    Text = "此卡牌算力消耗 +[StateArg5]，打出後抽 [StateArg4] 牌。"
  },
  State_120910_Name = {
    Text = "<OrangeQuality:彌薩格徽章>"
  },
  State_120924_Desc = {
    Text = "下回合開始時，獲得加固。"
  },
  State_120924_Name = {
    Text = "延遲加固"
  },
  State_120929_Desc = {
    Text = "卡牌獲得保留，但打出後會移除污染並召喚 1 個「深海分殖體」。若無位置召喚則會獲得 1 層「預備召喚：深海分殖體」。"
  },
  State_120930_Desc = {
    Text = "若有空餘位置，則在行動後失去 1 層，召喚 1 個「深海分殖體」。"
  },
  State_120930_Name = {
    Text = "互助契約：深海分殖體"
  },
  State_120934_Desc = {
    Text = "每次受到暴擊傷害，獲得 3％ 的<Baojidikang:臨時暴擊抵抗>。每回合開始時為 2 張卡牌附加「<SeastriderCurse:蹈海者咒怨>」。"
  },
  State_120934_Name = {
    Text = "深海祭禮"
  },
  State_120941_Desc = {
    Text = "會使敵人的技能得到增幅。每當受到傷害時失去一層。"
  },
  State_121006_Desc = {
    Text = "隊伍唯一：裝備者銀鑰充能、狂氣爆發造成的最終傷害、護盾提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_121006_WeaponDesc = {
    Text = "裝備者銀鑰充能、狂氣爆發造成的最終傷害、護盾提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_121014_Name = {
    Text = "聖胎的迴護"
  },
  State_121015_Desc = {
    Text = "回合開始時護盾不會清除。擁有護盾時擁有 50 層<ReinforcePVEKeywords:加固>，護盾被破除時移除<ReinforcePVEKeywords:加固>。"
  },
  State_121015_Name = {
    Text = "聖胎的迴護"
  },
  State_121151_Desc = {
    Text = "卡牌獲得保留，但打出後會移除污染並召喚 1 個「深海分殖體」。若無位置召喚則會獲得 1 層「預備召喚：深海分殖體」。"
  },
  State_121210_Name = {
    Text = "給予全體敵方負面<PVPWonderfulEffectKeywords:奇妙效果>，生效 2 次"
  },
  State_121211_Name = {
    Text = "抽 2 張牌，獲得 2 算力"
  },
  State_121212_Name = {
    Text = "給予全體友方正面<PVPWonderfulEffectKeywords:奇妙效果>，生效 2 次"
  },
  State_121213_Desc = {
    Text = "免疫一切傷害。"
  },
  State_121213_Name = {
    Text = "免疫一切傷害。"
  },
  State_121231_Desc = {
    Text = "每層使下次「虛妄王女」施加的「降生儀式」提高 20%，最多疊加 5 層，疊滿 5 層後下次「虛妄王女」傷害次數翻倍。"
  },
  State_121365_Desc = {
    Text = "額外承受 [Layer]％ 觸腕傷害。"
  },
  State_121377_Name = {
    Text = "<RetainIconKeywords:保留>：每回合開始時獲得 500點銀鑰能量"
  },
  State_121378_Name = {
    Text = "<RetainIconKeywords:保留>：所有喚醒體造成的生命回復和護盾提高40%"
  },
  State_121380_Name = {
    Text = "<RetainIconKeywords:保留>：所有喚醒體造成狂氣提高 50%"
  },
  State_121719_Name = {
    Text = "<RippleKeywords:餘波>：抽 1 張牌，獲得 [DescArg1] 點臨時<PowerIconKeywords:力量>"
  },
  State_121734_Desc = {
    Text = "每打出 1 張指令卡，棄掉 1 張該喚醒體算力消耗最低的卡牌。"
  },
  State_121734_Name = {
    Text = "瘋狂之奔流"
  },
  State_121735_Desc = {
    Text = "所有指令卡算力消耗提高 1。每 3 個回合，回合結束時將 1 張「漸漸石化」置入手中。"
  },
  State_121736_Desc = {
    Text = "回合結束時，恢復 10% 已損生命值，解除自身負面狀態和玩家的正面狀態。"
  },
  State_121736_Name = {
    Text = "誕臨之奔流"
  },
  State_121737_Desc = {
    Text = "戰鬥開始時，獲得 15 層「臨時屏障」。回合結束時，獲得 15 層「臨時屏障」，對隨機 10 張卡牌附加「臨時溶解」。"
  },
  State_121738_Desc = {
    Text = "喚醒體施加的力量效果降低 75%。每當失去生命，獲得 [DescArg1] 點護盾和 1 層臨時加固。"
  },
  State_121739_Desc = {
    Text = "所有喚醒體的狂氣上限提高 50%。每回合結束時，扣除所有喚醒體 10 點狂氣，恢復自身 3％最大生命。"
  },
  State_121739_Name = {
    Text = "恐懼之奔流"
  },
  State_121740_Desc = {
    Text = "戰鬥開始及每回合結束時，獲得 2 層臨時<ResentChainsKeywords:怨恨鎖鏈>。"
  },
  State_121740_Name = {
    Text = "詭譎之奔流"
  },
  State_121797_Desc = {
    Text = "造成的所有傷害、治療與護盾效果降低 10%，上限 2 層，無法驅散，痴醉最後的施加者死亡後會移除被施加者的所有痴醉。"
  },
  State_121797_Name = {
    Text = "<PVPLostSoulKeyWords:癡醉>"
  },
  State_121798_Desc = {
    Text = "造成的傷害、治療與護盾效果降低 [DescArg1]%，無法驅散。上限 2 層。\n擊殺<StatusApplier:>後移除。"
  },
  State_121798_Name = {Text = "癡醉"},
  State_121799_Name = {
    Text = "第四章利莫里亞支援卡"
  },
  State_121850_Desc = {
    Text = "觸腕傷害降低 80%"
  },
  State_121850_Name = {
    Text = "戈利亞·支援"
  },
  State_121863_Name = {
    Text = "<RippleKeywords:餘波>：抽 2 張牌"
  },
  State_121878_Name = {
    Text = "首次選擇反轉詛咒劇情"
  },
  State_122428_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_122428_Name = {
    Text = "尚未覺醒"
  },
  State_122431_Desc = {
    Text = "茉夏造成未被格擋的傷害時、獲得 2 層<Monster_Fervor:臨時狂熱>。"
  },
  State_122431_Name = {
    Text = "霧境遺脈"
  },
  State_122441_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 3 層<PVPReciprocalKeywords:倒數時刻>。"
  },
  State_122441_Name = {
    Text = "倒數時刻"
  },
  State_122442_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 <Block:[Block:StateArg1]> 護盾和 <Energy:[Energy:StateArg1]> 狂氣。回合結束時該命輪自動解除裝備，並使下次裝備「盒中童趣」時獲得的狂氣和護盾提高 [StateArg2]。"
  },
  State_122443_Desc = {
    Text = "回合開始時層數 - 1，層數耗盡後驅散自身負面狀態並獲得 100 狂氣，然後重新獲得 3 層倒數時刻。更換命輪將失去倒數時刻狀態。"
  },
  State_122443_Name = {
    Text = "<PVPFlowerKeywords:倒數時刻>"
  },
  State_122596_Desc = {
    Text = "無法打出卡牌，無法釋放狂氣爆發。"
  },
  State_122636_Desc = {
    Text = "每回合首個打出的「技能」傷害、治療與護盾提高 [StateArg1]% 。"
  },
  State_122636_Name = {
    Text = "紅寶石胸針"
  },
  State_122650_Desc = {
    Text = "造物 <OrangeQuality:魔術手套> 添加了此卡。"
  },
  State_122654_Name = {
    Text = "每次回合開始和行動結束後會試圖重置空的玩家牌庫，若不為空則不重置。__「僅開發用」"
  },
  State_122706_Name = {
    Text = "<CardKeyWord:重逢心願>"
  },
  State_122707_Desc = {
    Text = "視為本回合內上次打出的「技能」，算力消耗 -2，置於第二個抽牌堆的頂部。"
  },
  State_122707_Name = {
    Text = "<CardKeyWord:重逢心願>"
  },
  State_123109_Desc = {
    Text = "隊伍唯一：在「融痕」中首次購買「刻印」，或在「灰燼遺跡」中首次購買打折商品需要的黑印有 <WeaponEffect_Num:[StateArg1]%> 的機會變為 0，每場探索最多生效 1 次。"
  },
  State_123109_WeaponDesc = {
    Text = "在「融痕」中首次購買「刻印」，或在「灰燼遺跡」中首次購買打折商品需要的黑印有 <WeaponEffect_Num:[StateArg1]%> 的機會變為 0，每場探索最多生效 1 次。"
  },
  State_123177_Desc = {
    Text = "回合開始時清除。達到 10 層後、下次打出卡牌後、茉夏立刻行動、移除「臨時狂熱」並追加意圖「人間爆破」。"
  },
  State_123177_Name = {
    Text = "臨時狂熱"
  },
  State_123178_Desc = {
    Text = "<Guaiwusiwangdikang: 死亡抵抗>的回覆生命效果提高為 5 倍。敵方每使用 1 張卡牌、使自身獲得 1 層<Monster_Fervor:臨時狂熱>。"
  },
  State_123178_Name = {Text = "起床氣"},
  State_123243_Desc = {
    Text = "擊殺敵方時移除全部層數並獲得等量狂氣。"
  },
  State_123243_Name = {Text = "漩渦"},
  State_123246_Desc = {
    Text = "擊殺敵方時移除所有層數並獲得等量狂氣。"
  },
  State_123246_Name = {
    Text = "<PVPWaterPowerKeyWords:漩渦>"
  },
  State_123294_Desc = {
    Text = "本回合已通過「打擊」抽 [DescArg1]張牌。"
  },
  State_123507_Desc = {
    Text = "隊伍唯一：探索開始後，將 1 張「倒數時刻：5」加入牌庫：打出後抽 1 張牌，並將下一張「倒數時刻」洗入棄牌堆。「<DestructionKeywords:銷毀>」。「倒數時刻：0」：抽 3 張牌，獲得 3 點算力，並有 <WeaponEffect_Num:[StateArg1]%> 機率將「倒數時刻：5」洗入棄牌堆。保留。「<DestructionKeywords:銷毀>」。"
  },
  State_123507_WeaponDesc = {
    Text = "探索開始後，將 1 張「倒數時刻：5」加入牌庫：打出後抽 1 張牌，並將下一張「倒數時刻」洗入棄牌堆。「<DestructionKeywords:銷毀>」。「倒數時刻：0」：抽 3 張牌，獲得 3 點算力，並有 <WeaponEffect_Num:[StateArg1]%> 機率將「倒數時刻：5」洗入棄牌堆。保留。「<DestructionKeywords:銷毀>」。"
  },
  State_123520_Desc = {
    Text = "隊伍唯一：每回合首次釋放鑰令後 <WeaponEffect_Num:[StateArg1]>% 機率抽 1 張裝備者的「打擊」。"
  },
  State_123520_WeaponDesc = {
    Text = "每回合首次釋放鑰令後 <WeaponEffect_Num:[StateArg1]>% 機率抽 1 張裝備者的「打擊」。"
  },
  State_123521_Desc = {
    Text = "隊伍唯一：裝備者狂氣爆發和追擊基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。 本回合打出任意喚醒體的「打擊」後，裝備者「打擊」傷害臨時提高裝備者攻擊力的 <WeaponEffect_Num:[StateArg2]%>，每回合最多生效 8 次。"
  },
  State_123521_WeaponDesc = {
    Text = "裝備者狂氣爆發和追擊基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。 本回合打出任意喚醒體的「打擊」後，裝備者「打擊」傷害臨時提高 <WeaponEffect_Num:[DescArg2]>，每回合最多生效 8 次。"
  },
  State_123810_Desc = {
    Text = "將敵人當前意圖替換為「無法行動」。"
  },
  State_123812_Desc = {
    Text = "回合結束時，算力消耗降低。"
  },
  State_123812_Name = {
    Text = "<PrepareKeywords:預備>"
  },
  State_123994_Desc = {
    Text = "無法進行任何行動。"
  },
  State_123994_Name = {
    Text = "精緻睡眠"
  },
  State_124010_Desc = {
    Text = "下回合開始時，獲得 [Layer] 算力。"
  },
  State_124010_Name = {
    Text = "延遲算力"
  },
  State_124024_Desc = {
    Text = "本回合已打出 [Layer] 張打擊，觸發過 [DescArg1] 次「戲劇性邂逅」。"
  },
  State_124024_Name = {
    Text = "戲劇性邂逅"
  },
  State_124034_Desc = {
    Text = "所有喚醒體「打擊」傷害提高 [StateArg1]，持續 [Layer] 回合。"
  },
  State_124034_Name = {
    Text = "閃耀☆龍捲風"
  },
  State_124037_Desc = {
    Text = "茉夏傷害次數 +1，所有喚醒體「打擊」傷害提高 [StateArg1]，持續 [Layer] 回合。"
  },
  State_124037_Name = {
    Text = "閃耀☆龍捲風"
  },
  State_124107_Desc = {
    Text = "「星之芽」死亡後，免疫所有傷害並覺醒，最大生命翻倍並獲得等同於剩餘生命的最大生命。覺醒後驅散所有負面狀態。"
  },
  State_124107_Name = {
    Text = "尚未覺醒"
  },
  State_124108_Name = {
    Text = "界外之音計數"
  },
  State_124109_Desc = {
    Text = "自身獲得的<RetaliateIconKeywords:反擊>額外享受 5% <PowerIconKeywords:力量> 加成。 在單回合內失去 [DescArg1] 點生命後，和「歌者」交換位置"
  },
  State_124111_Desc = {
    Text = "死亡抵抗回復生命提高為 25%。 敵方每打出 1 張指令卡，臨時<TouquKeywords:偷取> [DescArg1] 點<PowerIconKeywords:力量> 。"
  },
  State_124111_Name = {
    Text = "無邊星彩"
  },
  State_124112_Desc = {
    Text = "「歌者」死亡後，免疫所有傷害並覺醒，最大生命翻倍並獲得等同於剩餘生命的最大生命。"
  },
  State_124112_Name = {
    Text = "尚未覺醒"
  },
  State_124113_Desc = {
    Text = "對方回合結束不會丟棄手牌。 回合結束時依次施加 2 層<FragileIconKeywords: 脆弱>、 <WeaknessIconKeywords:虛弱>、<HeavyInjuryKeywords:重創>、<VulnerabilityIconKeywords:易傷>狀態。"
  },
  State_124115_Desc = {
    Text = "造成的<FragileIconKeywords: 脆弱>、<HeavyInjuryKeywords:重創>和 <WeaknessIconKeywords:虛弱>加深為 50%。 再打出 [DescArg1] 張<SlowIconKeywords:遲緩>卡牌後，和「星之芽」交換位置。"
  },
  State_124121_Name = {
    Text = "行星旅者計數"
  },
  State_124122_Name = {
    Text = "行星旅者玩家監聽"
  },
  State_124190_Desc = {
    Text = "自身獲得的<RetaliateIconKeywords:反擊>額外享受 5% <PowerIconKeywords:力量> 加成。"
  },
  State_124193_Name = {
    Text = "死亡抵抗回復生命提高為 25%。"
  },
  State_124198_Desc = {
    Text = "造成的<FragileIconKeywords: 脆弱>、<HeavyInjuryKeywords:重創>和 <WeaknessIconKeywords:虛弱>加深為 50%。"
  },
  State_124277_Desc = {
    Text = "執行過程的中間值顯化。"
  },
  State_124278_Desc = {
    Text = "執行過程的中間值顯化。"
  },
  State_124279_Desc = {
    Text = "執行過程的中間值顯化。"
  },
  State_124280_Desc = {
    Text = "執行過程的中間值顯化。"
  },
  State_124282_Desc = {
    Text = "執行過程的中間值顯化。"
  },
  State_124283_Desc = {
    Text = "執行過程的中間值顯化。"
  },
  State_124284_Desc = {
    Text = "執行過程的中間值顯化。"
  },
  State_124285_Desc = {
    Text = "執行過程的中間值顯化。"
  },
  State_124286_Desc = {
    Text = "執行過程的中間值顯化。"
  },
  State_124287_Desc = {
    Text = "執行過程的中間值顯化。"
  },
  State_124736_Desc = {
    Text = "驗證 BEAttachPostAction 接口的參數3是否正確過濾或觸發對應的觸發器。"
  },
  State_124736_Name = {
    Text = "監聽測試1"
  },
  State_124747_Desc = {
    Text = "驗證 BEAttachPostAction 接口的參數3是否正確過濾或觸發對應的觸發器。"
  },
  State_124747_Name = {
    Text = "監聽測試2"
  },
  State_124748_Desc = {
    Text = "敵人打出<BurningKeywords:燃燒>卡牌時，使自身獲得 1 層<MonsterExFlameKeywords:爆炎>，但臨時降低 [DescArg1] <PowerIconKeywords:力量>。"
  },
  State_124752_Desc = {
    Text = "驗證 BEAttachPostAction 接口的參數3是否正確過濾或觸發對應的觸發器。"
  },
  State_124752_Name = {
    Text = "監聽測試3"
  },
  State_124753_Desc = {
    Text = "驗證 BEAttachPostAction 接口的參數3是否正確過濾或觸發對應的觸發器。"
  },
  State_124753_Name = {
    Text = "監聽測試4"
  },
  State_124754_Desc = {
    Text = "驗證 BEAttachPostAction 接口的參數3是否正確過濾或觸發對應的觸發器。"
  },
  State_124754_Name = {
    Text = "監聽測試5"
  },
  State_124765_Desc = {
    Text = "暴擊率提高 [Layer] % 。"
  },
  State_124765_Name = {Text = "暴擊率"},
  State_124766_Desc = {
    Text = "本場戰鬥內暴擊率提高 [Layer] %。"
  },
  State_124766_Name = {Text = "暴擊率"},
  State_124766_WeaponDesc = {
    Text = "本場戰鬥內暴擊率提高 [Layer] %。"
  },
  State_124767_Desc = {
    Text = "暴擊傷害提高 [Layer] %。"
  },
  State_124767_Name = {
    Text = "暴擊傷害"
  },
  State_124811_Desc = {
    Text = "驗證 BEAttachPostAction 接口的參數3是否正確過濾或觸發對應的觸發器。"
  },
  State_124811_Name = {
    Text = "監聽測試8"
  },
  State_124812_Desc = {
    Text = "驗證 BEAttachPostAction 接口的參數3是否正確過濾或觸發對應的觸發器。"
  },
  State_124812_Name = {
    Text = "監聽測試7"
  },
  State_124813_Desc = {
    Text = "驗證 BEAttachPostAction 接口的參數3是否正確過濾或觸發對應的觸發器。"
  },
  State_124813_Name = {
    Text = "監聽測試6"
  },
  State_124826_Desc = {
    Text = "驗證 BEAttachPostAction 接口的參數3是否正確過濾或觸發對應的觸發器。"
  },
  State_124826_Name = {
    Text = "監聽測試9"
  },
  State_124843_Desc = {
    Text = "驗證觸發器 BSTAfterAttachPostAction 和 BSTAfterDoActiveDamage.AttachPostAction 的監聽"
  },
  State_124843_Name = {
    Text = "監聽測試9"
  },
  State_124886_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：打出裝備者的技能卡後，抽 [StateArg1] 張牌，優先抽取其他喚醒體的牌，每回合至多生效 1 次。"
  },
  State_124886_Name = {
    Text = "宿命紡輪"
  },
  State_124887_Desc = {
    Text = "該喚醒體的「紡織」傷害次數提升 [Layer]。"
  },
  State_124887_Name = {Text = "紡織"},
  State_124888_Desc = {
    Text = "每次打出卡牌後變化為敵方手中的隨機「技能」，並使其算力消耗 -2。"
  },
  State_124888_Name = {
    Text = "<CardKeyWord:預言>"
  },
  State_124890_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使自身下 [StateArg1] 張打出的「技能」生效 2 次。"
  },
  State_124890_Name = {
    Text = "永世編織之網"
  },
  State_124892_Name = {
    Text = "<CardKeyWord:預言>"
  },
  State_124916_Desc = {
    Text = "回合結束移除所有層數並造成 [DescArg1] 純粹傷害，無法驅散。"
  },
  State_124916_Name = {
    Text = "命定預兆"
  },
  State_124917_Desc = {
    Text = "回合結束移除所有層數並造成純粹傷害，無法驅散。"
  },
  State_124917_Name = {
    Text = "<PVPDestinedDeathKeyWords:命定預兆>"
  },
  State_124992_Desc = {
    Text = "下 [DescArg1] 張「技能」打出 2 次。"
  },
  State_124992_Name = {Text = "雙發"},
  State_124993_Desc = {
    Text = "造成和受到的致命主動傷害改為施加等量<PVPDestinedDeathKeyWords:命定預兆>，無法驅散。"
  },
  State_124993_Name = {
    Text = "命途，依此諭示"
  },
  State_124997_Desc = {
    Text = "造成和受到的致命主動傷害改為施加等量<PVPDestinedDeathKeyWords:命定預兆>。無法驅散。"
  },
  State_124997_Name = {
    Text = "<PVPEternalDimensionKeyWords:命途，依此諭示>"
  },
  State_125002_Name = {
    Text = "狀態@通用玩家棄牌階段後護盾值監聽"
  },
  State_125003_Name = {Text = "護盾值"},
  State_125004_Name = {
    Text = "狀態@通用施加玩家護盾計數"
  },
  State_125472_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後對<HPAndShieldMax:生命與護盾最高>的敵方施加 [StateArg1] 層<PVPLostSoulKeyWords:痴醉>。"
  },
  State_125472_Name = {
    Text = "玉蘭之餌"
  },
  State_125486_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：其他友方「狂氣爆發」後，使手牌中裝備者的所有「技能」算力消耗 - [StateArg1]。"
  },
  State_125925_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_125925_Name = {
    Text = "尚未覺醒"
  },
  State_125926_Name = {
    Text = "狀態@怪物塔薇切換意圖玩家監聽"
  },
  State_125927_Desc = {
    Text = "再打出 [DescArg1] 張指令卡後，將意圖切換為「六翼滿開」。"
  },
  State_125927_Name = {
    Text = "四翼漸生"
  },
  State_125928_Desc = {
    Text = "打出指令卡後，封印對應喚醒體的狂氣爆發和所有指令卡 2 回合。"
  },
  State_125928_Name = {
    Text = "縱貫時序之翼"
  },
  State_125929_Desc = {
    Text = "單回合內受到 [DescArg1] 點傷害後，獲得 70 層臨時<ReinforceColour:加固>和 1 層<ResentChainsKeywords: 怨恨鎖鏈>。"
  },
  State_125933_Desc = {
    Text = "再打出 [DescArg1] 張指令卡後，將意圖切換為「四翼漸生」。"
  },
  State_125933_Name = {
    Text = "雙翼初張"
  },
  State_125934_Desc = {
    Text = "消耗算力時、獲得的銀鑰能量降低 50%。 塔微造成未被格擋的傷害後、將 1 張「<DerivativeCardKeywords_131:真·輪迴悖論>」置入手中。"
  },
  State_125934_Name = {
    Text = "穿越銀鑰之門"
  },
  State_125935_WeaponDesc = {
    Text = "抽到時使自身虛弱 1 回合。使用後虛弱所有敵人 1 回合。無法出售。"
  },
  State_125937_Desc = {
    Text = "打出指令卡後，封印對應喚醒體的狂氣爆發和所有指令卡 2 回合。"
  },
  State_125937_Name = {
    Text = "縱貫時序之翼"
  },
  State_125964_Desc = {
    Text = "消耗算力時，獲得的銀鑰能量降低 50%。 塔薇造成未被格擋的傷害後，將 1 張「<DerivativeCardKeywords_131:真·輪迴悖論>」置入手中。"
  },
  State_125964_Name = {
    Text = "穿越銀鑰之門"
  },
  State_126010_Desc = {
    Text = "隊伍唯一：裝備者造成的固定中毒和觸發中毒效果提升 <WeaponEffect_Num:[StateArg1]%>、血肉界域自動回覆的<EmbryoFusionIconKeywords:胚胎融合>提升 <WeaponEffect_Num:[StateArg2]%>。裝備者每回合首次觸發「共鳴」時其他喚醒體獲得 <WeaponEffect_Num:[StateArg3]> 點狂氣。"
  },
  State_126010_WeaponDesc = {
    Text = "裝備者造成的固定中毒和觸發中毒效果提升 <WeaponEffect_Num:[StateArg1]%>、血肉界域自動回覆的<EmbryoFusionIconKeywords:胚胎融合>提升 <WeaponEffect_Num:[StateArg2]%>。裝備者每回合首次觸發「共鳴」時其他喚醒體獲得 <WeaponEffect_Num:[StateArg3]> 點狂氣。"
  },
  State_126463_Name = {
    Text = "狀態@怪物莉茲誘蛾之火受傷監聽"
  },
  State_126464_Desc = {
    Text = "上限 10 層，每層使莉茲造成的傷害提高 [DescArg1] 點。"
  },
  State_126464_Name = {
    Text = "<GreenWord:翠綠火種>"
  },
  State_126465_Name = {
    Text = "怪物莉茲意圖監聽"
  },
  State_126466_Desc = {
    Text = "對方回合結束不會丟棄手牌。當意圖切換為綠炎時，若擁有至少 6 層<MonsterLizVerdantSpark:翠綠火種>，消耗 6 層，將意圖升級為造成 <Damage:[Damage:DescArg1]> 傷害 [AttackTimes:DescArg2] 次的「死滅綠炎」；若擁有至少 3 層，消耗 3 層，將意圖升級為造成 <Damage:[Damage:DescArg3]> 傷害 [AttackTimes:DescArg4] 次的「腐化綠炎」。"
  },
  State_126466_Name = {
    Text = "不朽綠炎"
  },
  State_126467_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥，併為「告死之舞」賦予解除負面狀態的能力。"
  },
  State_126467_Name = {
    Text = "尚未覺醒"
  },
  State_126468_Name = {
    Text = "狀態@怪物莉茲翡翠映射管理"
  },
  State_126469_Desc = {
    Text = "每失去 [DescArg1] 點生命獲得 [DescArg2] 層<MonsterLizVerdantSpark:翠綠火種>。"
  },
  State_126469_Name = {
    Text = "翡翠映射"
  },
  State_126470_Name = {
    Text = "狀態@怪物莉茲提示語計數"
  },
  State_126479_Desc = {
    Text = "上限 10 層，使莉茲造成的傷害提高。"
  },
  State_126479_Name = {
    Text = "<GreenWord:翠綠火種>"
  },
  State_126540_Desc = {
    Text = "徐下 [Layer] 次觸發「共鳴」時「共鳴」效果翻倍。"
  },
  State_126540_Name = {
    Text = "夜霧下的情誓"
  },
  State_126568_Desc = {
    Text = "喚醒體每次造成主動傷害，號令 1 條觸腕攻擊目標造成 [Layer]％ 觸腕傷害。"
  },
  State_126568_Name = {
    Text = "怒海狂瀾"
  },
  State_126569_Desc = {
    Text = "喚醒體每次造成主動傷害，號令 1 條觸腕攻擊目標造成 50％ 觸腕傷害。"
  },
  State_126569_Name = {
    Text = "怒海狂瀾"
  },
  State_126643_Desc = {
    Text = "本狀態 MaxLayer=1。來源喚醒體：[DescArg1]"
  },
  State_126643_Name = {Text = "限額1層"},
  State_126644_Desc = {
    Text = "獲得後，清除並重新添加 [Layer] 層演示狀態。\n演示狀態的最大層數為1層。"
  },
  State_126644_Name = {
    Text = "突破最大層數"
  },
  State_126645_Desc = {
    Text = "拉蒙娜造成的基礎傷害提高 [DescArg1]%"
  },
  State_126645_Name = {
    Text = "至臻的淬煉"
  },
  State_126651_Desc = {
    Text = "釋放追擊後的監聽已滿足 [Layer] 次。"
  },
  State_126651_Name = {Text = "計數器"},
  State_126652_Desc = {
    Text = "獲得後，令前排敵方追加後置行動，打出其當前意圖。"
  },
  State_126652_Name = {
    Text = "令怪物追擊"
  },
  State_126653_Desc = {
    Text = "獲得後，令站位為1的喚醒體追加後置行動，打出其打擊卡。"
  },
  State_126653_Name = {
    Text = "令喚醒體追擊"
  },
  State_126654_Desc = {
    Text = "指名監聽被觸發時，打印1次計數。"
  },
  State_126654_Name = {
    Text = "指名監聽"
  },
  State_126655_Desc = {
    Text = "獲得後，令守密人追加後置行動，打出 技能@主角技能@腦中之音。"
  },
  State_126655_Name = {
    Text = "令守密人追擊"
  },
  State_126677_Desc = {
    Text = "本回合下 [Layer] 張「桀驁之刃」生效 2 次。"
  },
  State_126677_Name = {
    Text = "亙古的鯨鳴"
  },
  State_126678_WeaponDesc = {
    Text = "鯨躍的所有傷害次數+1。"
  },
  State_126714_Desc = {
    Text = "艾繼絲的下 [Layer] 張「防禦」生效 3 次。"
  },
  State_126714_Name = {
    Text = "凝刻的眼淚"
  },
  State_126714_WeaponDesc = {
    Text = "鯨躍的所有傷害次數+1。"
  },
  State_126715_WeaponDesc = {
    Text = "鯨躍的所有傷害次數+1。"
  },
  State_126776_Desc = {
    Text = "每擁有 1 層承受的固定中毒提高 5％、造成傷害降低 [DescArg1]％、最大 [DescArg2] 層。"
  },
  State_126776_Name = {
    Text = "<WitherKeywords:癡醉>"
  },
  State_126783_Name = {
    Text = "暫時廢棄了"
  },
  State_126784_Desc = {
    Text = "承受的固定中毒提高 [DescArg1]％、造成傷害降低 [DescArg2]％、最大 [DescArg3] 層。"
  },
  State_126784_Name = {Text = "癡醉"},
  State_126785_Desc = {
    Text = "若其他喚醒體已累積打出 X 張指令卡、打出後觸發後續效果。打出自身指令卡或回合結束後重置自身共鳴計數。"
  },
  State_126785_Name = {
    Text = "<ResonanceKeywords:共鳴X>"
  },
  State_126789_Desc = {
    Text = "對所有敵人施加 2 層<WitherKeywords:痴醉>。"
  },
  State_126789_Name = {
    Text = "<WitherKeywords1:相許>"
  },
  State_126790_Desc = {
    Text = "移除所有敵人的<WitherKeywords:痴醉>，每移除 1 層造成 [DescArg1]％ 目標最大生命的<FixedDamage:純粹傷害>並觸發其 40% 中毒。"
  },
  State_126790_Name = {
    Text = "<WitherKeywords2:奪魄>"
  },
  State_126803_Desc = {
    Text = "接下來打出的 [DescArg1] 張指令卡會被送往 3 回合後的未來。"
  },
  State_126803_Name = {
    Text = "命運紡輪"
  },
  State_126893_Name = {
    Text = "狀態@命運超維至純標識"
  },
  State_126895_Desc = {
    Text = "此卡牌造成的傷害、固定力量和觸腕傷害提高、固定中毒、固定反擊的最終效果提高 [DescArg1]％，造成的固定護盾、固定生命回覆、力量降低效果提高 [DescArg2]％。擁有「奇點信標」的卡牌無法再複製進「超維空間」。"
  },
  State_126895_Name = {
    Text = "<SingularityKeywords:奇點信標 [DescArg2]>"
  },
  State_126896_Name = {
    Text = "狀態@超越之光卡牌減少算力調和層數"
  },
  State_126900_Name = {
    Text = "狀態@命運超維職業初始化2"
  },
  State_126901_Name = {
    Text = "狀態@命運超維職業初始化1"
  },
  State_126903_Name = {
    Text = "狀態@超維空間超距標記"
  },
  State_126927_Desc = {
    Text = "隊伍唯一：裝備者造成的固定中毒和觸發中毒效果提升 <WeaponEffect_Num:[StateArg1]%>。裝備者每回合首次觸發「共鳴」時獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣。"
  },
  State_126927_WeaponDesc = {
    Text = "裝備者造成的固定中毒和觸發中毒效果提高 <WeaponEffect_Num:[StateArg1]%>。裝備者每回合首次觸發「共鳴」時獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣。"
  },
  State_127108_Desc = {
    Text = "對所有敵人施加 5 層<WitherKeywords:痴醉>。"
  },
  State_127108_Name = {
    Text = "<WitherKeywords3:相許>"
  },
  State_127109_Desc = {
    Text = "移除所有敵人的<WitherKeywords:痴醉>，每移除 1 層積攢 20％ 體質的猩紅熔爐、造成 [DescArg1]％ 目標最大生命的<FixedDamage:純粹傷害>並觸發其 40% 中毒。"
  },
  State_127109_Name = {
    Text = "<WitherKeywords4:奪魄>"
  },
  State_127176_Desc = {
    Text = "每擁有 1 層承受的固定中毒提高 5％、造成傷害降低 [DescArg1]％、最大 [DescArg2] 層。"
  },
  State_127264_Desc = {
    Text = "打出此卡牌時、「覺者」獲得 1 層 <MonsterTimeBeacon:回環>。若棄置此卡牌、「覺者」失去 1 層 <MonsterTimeBeacon:回環>。"
  },
  State_127266_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_127266_Name = {
    Text = "尚未覺醒"
  },
  State_127267_Desc = {
    Text = "回合結束後、獲得 1 層 <MonsterTimeBeacon:回環>。"
  },
  State_127267_Name = {
    Text = "熵增逆轉"
  },
  State_127271_Desc = {
    Text = "釋放鑰令後、自身獲得 1 層 <MonsterTimeBeacon:回環>。"
  },
  State_127271_Name = {
    Text = "莫比烏斯囚徒"
  },
  State_127272_Desc = {
    Text = "上限 3 層。「覺者」釋放意圖時若擁有 3 層 <MonsterTimeBeacon:回環>、觸發 <MonsterTimeBeacon:回環>效果、清空 <MonsterTimeBeacon:回環>並清除負面狀態。"
  },
  State_127272_Name = {
    Text = "<WhiteWord:回環>"
  },
  State_127275_Desc = {
    Text = "每擁有 1 層承受的固定中毒提高 5％、造成傷害降低 [DescArg1]％、最大 [DescArg2] 層。"
  },
  State_127275_Name = {
    Text = "<WitherKeywords:癡醉>"
  },
  State_127276_Desc = {
    Text = "打出此卡牌時、「覺者」獲得 1 層 <MonsterTimeBeacon:回環>。若棄置此卡牌、「覺者」失去 1 層 <MonsterTimeBeacon:回環>。"
  },
  State_127312_Desc = {
    Text = "喚醒體人格深化達到 +12 時會激活「最終法則」、激活後可獲得一些獨特的效果。"
  },
  State_127312_Name = {
    Text = "<UltraPotencyKeywords:最終法則>"
  },
  State_127705_Desc = {
    Text = "卡牌被做了手腳！打出後受到 [Layer] 點傷害，並使<CardKeyWord:暗中破壞>層數減半。"
  },
  State_127705_Name = {
    Text = "<CardKeyWord:暗中破壞>"
  },
  State_127705_WeaponDesc = {
    Text = "卡牌打出後受到 [StateArg1] 點傷害。"
  },
  State_127708_Desc = {
    Text = "敵方打出非指令卡後、所有友方獲得 [DescArg1] 層<PowerIconKeywords:力量>。舊日餘燼被擊破後失效。"
  },
  State_127708_Name = {Text = "亂之絲"},
  State_127709_Name = {
    Text = "黑之絲玩家狀態"
  },
  State_127710_Name = {
    Text = "黑之絲觸發"
  },
  State_128026_Name = {
    Text = "白之絲玩家狀態"
  },
  State_128027_Desc = {
    Text = "敵方打出指令卡後、所有友方獲得 [DescArg1] 層臨時<ReinforcePVEKeywords:加固>。舊日餘燼被擊破後失效。"
  },
  State_128027_Name = {Text = "律之絲"},
  State_128028_Desc = {
    Text = "卡牌被做了手腳！打出後受到<FixedDamage:純粹傷害>，並使<BrokenCard:暗中破壞>層數減半。"
  },
  State_128028_Name = {
    Text = "<CardKeyWord:暗中破壞>"
  },
  State_128028_WeaponDesc = {
    Text = "卡牌打出後受到 [StateArg1] 點傷害。"
  },
  State_128029_Name = {
    Text = "白之絲觸發"
  },
  State_128067_Name = {
    Text = "狀態@冷蛛侍女餘燼監聽"
  },
  State_128069_Name = {
    Text = "狀態@冷蛛侍女纏繞命中檢測"
  },
  State_128071_Name = {
    Text = "狀態@冷蛛侍女前置位需要召喚標記"
  },
  State_128073_Desc = {
    Text = "每次行動結束後都會獲得 [DescArg1] 層<ParcloseIconKeywords:屏障>和 [DescArg2] 層<Chapter5_Monster_Fervor1:狂熱>。"
  },
  State_128073_Name = {
    Text = "織母的搖籃"
  },
  State_128082_Desc = {
    Text = "打出後哈姆林獲得 3 點狂氣。"
  },
  State_128082_Name = {
    Text = "<XushiBKeywords:蓄勢樂音>"
  },
  State_128086_Desc = {
    Text = "敵方打出指令卡後、自身獲得 [DescArg1] 層<Chapter5_Monster_Fervor1:狂熱>、擊破「舊日餘燼」後與後列友方交換位置。"
  },
  State_128086_Name = {
    Text = "宿命輪轉"
  },
  State_128087_Name = {
    Text = "狀態@冷蛛侍女白之輪回觸發標記"
  },
  State_128089_Name = {
    Text = "白之輪回觸發"
  },
  State_128216_Name = {
    Text = "白之輪迴玩家狀態"
  },
  State_128245_Desc = {
    Text = "回合開始後清除、達到 10 層後、下次打出卡牌後立刻行動、移除<Chapter5_Monster_Fervor2:狂熱>並將意圖切換為施加<FragileIconKeywords: 脆弱>並隨機附加<BrokenCard:暗中破壞>的「崩解之絲」。"
  },
  State_128245_Name = {
    Text = "臨時狂熱"
  },
  State_128246_Name = {
    Text = "黑之輪迴玩家狀態"
  },
  State_128247_Desc = {
    Text = "死亡後復活、免疫傷害並擁有 100% 生命。將意圖切換為「命定的狂熱」：每次行動結束後都會獲得 [DescArg1] 點<PowerIconKeywords:力量>和 [DescArg2] 層<Chapter5_Monster_Fervor2:狂熱>。"
  },
  State_128247_Name = {
    Text = "破繭新生"
  },
  State_128248_Desc = {
    Text = "回合開始後清除、達到 10 層後、下次打出卡牌後立刻行動、移除<Chapter5_Monster_Fervor1:狂熱>並將意圖切換為施加<WeaknessIconKeywords:虛弱>並隨機封印指令卡的「束縛之網」。"
  },
  State_128248_Name = {
    Text = "臨時狂熱"
  },
  State_128250_Name = {
    Text = "黑之輪迴觸發"
  },
  State_128251_Desc = {
    Text = "敵方打出非指令卡後、自身獲得 [DescArg1] 層<Chapter5_Monster_Fervor2:狂熱>、擊破「舊日餘燼」後與後列友方交換位置。"
  },
  State_128251_Name = {
    Text = "淵獄輪轉"
  },
  State_128253_Desc = {
    Text = "死亡後復活、免疫傷害並擁有 100% 生命。將意圖切換為「命定的狂熱」：每次行動結束後都會獲得 [DescArg1] 層<ParcloseIconKeywords:屏障>和 [DescArg2] 層<Chapter5_Monster_Fervor1:狂熱>。"
  },
  State_128253_Name = {
    Text = "破繭新生"
  },
  State_128257_Desc = {
    Text = "每次行動結束後都會獲得 [DescArg1] 點<PowerIconKeywords:力量>和 [DescArg2] 層<Chapter5_Monster_Fervor2:狂熱>。"
  },
  State_128257_Name = {
    Text = "織母的低語"
  },
  State_128643_Name = {
    Text = "狀態@玩家本回合打出症狀計數"
  },
  State_128644_Desc = {
    Text = "回合開始時清除。達到 10 層後、下次打出卡牌後立刻行動、移除<Chapter5_Monster_Fervor3:狂熱>並隨機切換意圖。"
  },
  State_128644_Name = {
    Text = "臨時狂熱"
  },
  State_128645_Desc = {
    Text = "意圖會從四種意圖中隨機、但不會重複。釋放狂氣爆發後立刻切換意圖。打出指令卡後獲得 1 層<Chapter5_Monster_Fervor3:狂熱>。"
  },
  State_128645_Name = {
    Text = "萬面同調"
  },
  State_128646_Name = {
    Text = "狀態@錯亂的命運失格重擊出牌檢測"
  },
  State_128648_Desc = {
    Text = "直到下回合開始時、每打出 1 張指令卡就獲得 [DescArg1] 的臨時<PowerIconKeywords:力量>。"
  },
  State_128648_Name = {
    Text = "暴怒之繭"
  },
  State_128692_Desc = {
    Text = "承受主動傷害或觸腕傷害後，移除等量的「舊日餘燼」並失去 300% 移除量的生命，承受其它傷害時移除一半。「舊日餘燼」層數每回合重置。"
  },
  State_128692_Name = {
    Text = "<AshesPastKeyWord:舊日餘燼>"
  },
  State_128695_Name = {
    Text = "狀態@錯亂的命運意圖標記"
  },
  State_129297_Desc = {
    Text = "下 [Layer] 場戰鬥開始時使所有敵人生命為 1。"
  },
  State_129297_Name = {
    Text = "小「N」的協助"
  },
  State_129569_Name = {
    Text = "狀態@錯亂的命運歡愉劇場觸發標記"
  },
  State_129570_Name = {
    Text = "狀態@錯亂的命運宿命低語觸發標記"
  },
  State_129571_Name = {
    Text = "狀態@錯亂的命運無盡虛無觸發標記"
  },
  State_129612_Desc = {
    Text = "意圖會從四種意圖中隨機、但不會重複。釋放狂氣爆發後立刻切換意圖。打出指令卡後獲得 1 層<Chapter5_Monster_Fervor3:狂熱>。"
  },
  State_129612_Name = {
    Text = "萬面同調"
  },
  State_129625_Desc = {
    Text = "意圖會從四種意圖中隨機，但不會重複。釋放狂氣爆發後立刻切換意圖。打出指令卡後獲得 1 層<Chapter5_Monster_Fervor3:狂熱>。每次切換意圖獲得 1 層「錯亂命途」。"
  },
  State_129625_Name = {
    Text = "萬面同調"
  },
  State_129643_Desc = {
    Text = "每次切換意圖時獲得 1 層，當擁有 10 層「錯亂命途」時，意圖調整為無法切換並造成大量傷害與削弱的「破繭狂宴」。"
  },
  State_129643_Name = {
    Text = "錯亂命途"
  },
  State_129644_Name = {
    Text = "扭曲融合鎖定意圖"
  },
  State_129650_Desc = {
    Text = "隊伍唯一：若裝備者為喚醒體「環行・拉蒙娜」，其他喚醒體探索關卡所獲得的同調率提高 <WeaponEffect_Num:[StateArg1]%>，但自身不獲得同調率。"
  },
  State_129650_WeaponDesc = {
    Text = "若裝備者為喚醒體「環行·拉蒙娜」，完成關卡時其他喚醒體獲得的同調率提高 <WeaponEffect_Num:[StateArg1]%>，但自身不獲得同調率。"
  },
  State_129761_Desc = {
    Text = "修改介面 玩家局內成長強度 的回傳值、每 1 層提高 1%。"
  },
  State_129761_Name = {
    Text = "局內成長強度修正"
  },
  State_129845_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_129845_Name = {
    Text = "尚未覺醒"
  },
  State_129846_Name = {
    Text = "斷絲震鳴計數"
  },
  State_129848_Desc = {
    Text = "每當 [DescArg1] 張卡牌離開維度裂隙時為其賦予 [DescArg2] 層<BrokenCard:暗中破壞>。"
  },
  State_129848_Name = {
    Text = "木偶戲場揭幕"
  },
  State_129849_Desc = {
    Text = "生成每回合敵方打出的首張指令卡的複製置入維度裂隙。當卡牌進入維度裂隙時、為其賦予<DepleteIconKeywords:消耗>。 每回合首次釋放鑰令會將最左側的卡牌取出並置入抽牌堆頂部。"
  },
  State_129849_Name = {
    Text = "撥弄命運之絲"
  },
  State_129850_Desc = {
    Text = "維度裂隙中每有一張指令卡，玩家手牌上限減少 1。 若其中已滿，下次打出卡牌時，「永恆之網」立刻行動，行動後清空維度裂隙，將意圖調整為「凌駕命運的悲歌」。"
  },
  State_129850_Name = {
    Text = "斷絲震鳴"
  },
  State_129854_Desc = {
    Text = "維度裂隙中每有一張指令卡，玩家手牌上限減少 1。 若其中已滿，下次打出卡牌時，「永恆之網」立刻行動，行動後清空維度裂隙，將意圖調整為「命途，依此諭示」。"
  },
  State_129854_Name = {
    Text = "斷絲震鳴"
  },
  State_129864_Desc = {
    Text = "每當打出卡牌後移除 1 層「困意」。回合開始時回復到 12 層「困意」。"
  },
  State_129865_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_129865_Name = {
    Text = "尚未覺醒"
  },
  State_129872_Desc = {
    Text = "臨時變數。"
  },
  State_129872_Name = {Text = "計數器1"},
  State_129873_Desc = {
    Text = "獲得 [Layer] 層計數狀態 _封裝計數器1_。"
  },
  State_129873_Name = {
    Text = "封裝測試1"
  },
  State_129874_Desc = {
    Text = "臨時變數。"
  },
  State_130358_Desc = {
    Text = "下張打出的指令卡額外生效 2 次。"
  },
  State_130358_Name = {
    Text = "提線木偶"
  },
  State_130387_Desc = {
    Text = "「提線木偶」被消耗後、之後每回合打出的第一張指令卡額外生效 2 次。若為首領戰、所有喚醒體獲得 50 點狂氣、獲得 1000 點銀鑰能量。"
  },
  State_130387_Name = {
    Text = "命運的葬禮"
  },
  State_130388_Name = {
    Text = "<RetainIconKeywords:保留>：獲得 [DescArg1] 銀鑰能量"
  },
  State_130389_Desc = {
    Text = "打出後使所有喚醒體獲得 [DescArg1] 點狂氣"
  },
  State_130389_Name = {
    Text = "打出後使所有喚醒體獲得 [DescArg1] 點狂氣"
  },
  State_130390_Desc = {
    Text = "算力上限與手牌上限提高 1。"
  },
  State_130390_Name = {
    Text = "冗餘的側寫"
  },
  State_130391_Desc = {
    Text = "每打出 1 張「症狀卡」、「提線木偶」算力消耗降低 1。"
  },
  State_130391_Name = {
    Text = "污穢的餘響"
  },
  State_130490_Desc = {
    Text = "本卡牌造成的傷害、護盾、治療、力量、衰竭、觸腕傷害、固定中毒、固定反擊提升、獨立乘算 1+[Layer]%。"
  },
  State_130490_Name = {
    Text = "奇點信標α"
  },
  State_130498_Desc = {
    Text = "下張打出的指令卡額外生效 2 次。"
  },
  State_130498_Name = {
    Text = "命運的葬禮"
  },
  State_130500_Desc = {
    Text = "首領戰中死亡抵抗 +100%。觸發「死亡抵抗」後下回合「提線木偶」不再強制打出指令卡、改為選擇一張手中指令卡。"
  },
  State_130500_Name = {
    Text = "殉難者的回眸"
  },
  State_130501_Desc = {
    Text = "下張指令卡算力消耗降低為 0。"
  },
  State_130501_WeaponDesc = {
    Text = "打出前改變卡牌算力"
  },
  State_130512_Desc = {
    Text = "下張打出的指令卡額外生效 2 次且算力消耗降低 2 點。"
  },
  State_130512_Name = {
    Text = "提線木偶"
  },
  State_130517_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合開始時，隨機觸發以下效果中的一個：獲得 <Energy:[Energy:StateArg1]> 狂氣並<PVPSlowKeywords:遲緩>自身；獲得 <Energy:[Energy:StateArg3]> 狂氣；獲得 <Energy:[Energy:StateArg4]> 和 [StateArg5] 張<PVPDerivativeCardKeywords_17:「靈感」>。"
  },
  State_130517_Name = {
    Text = "豪賭的智慧"
  },
  State_131046_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使自身獲得 <Block:[Block:StateArg1]> 護盾和<DelayKeywords:延遲>：<Energy:[Energy:StateArg2]> 狂氣。"
  },
  State_131046_Name = {
    Text = "渺遠的伊甸園"
  },
  State_131047_Desc = {
    Text = "本回合中下 [Layer] 次使用鑰令將生效 2 次。"
  },
  State_131047_Name = {
    Text = "雙發鑰令"
  },
  State_131048_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：每回合首次打出「技能」後對<HPAndShieldMin:生命與護盾最低>的敵方造成 <Damage:[Damage:StateArg1]> 傷害。"
  },
  State_131048_Name = {
    Text = "被囚禁的瘋狂"
  },
  State_131055_Desc = {
    Text = "每回合抽牌數 -1。所有喚醒體造成護盾和回復生命提高 20%。"
  },
  State_131055_Name = {
    Text = "理順毛髮"
  },
  State_131056_Desc = {
    Text = "失去生命後將等量延遲狂氣轉化為護盾。"
  },
  State_131056_Name = {
    Text = "漩渦護身"
  },
  State_131058_Desc = {
    Text = "所有喚醒體基礎狂氣提高 10 點。釋放狂氣爆發後獲得 1 點算力、每個喚醒體 1 回合只能觸發 1 次。"
  },
  State_131058_Name = {
    Text = "蹭蹭臉頰"
  },
  State_131059_Name = {
    Text = "莫絲大招升級標記"
  },
  State_131061_Desc = {
    Text = "銀鑰能量上限及鑰令消耗銀鑰能量 +350。每回合首次鑰令生效 2 次。"
  },
  State_131061_Name = {
    Text = "投餵零食"
  },
  State_131064_Desc = {
    Text = "釋放狂氣爆發後獲得 1 算力，每個喚醒體 1 回合只能觸發 1 次。"
  },
  State_131064_Name = {
    Text = "蹭蹭臉頰"
  },
  State_131069_Desc = {
    Text = "所有喚醒體造成護盾和回復生命提高 20%。"
  },
  State_131069_Name = {
    Text = "理順毛髮"
  },
  State_131073_Desc = {
    Text = "隊伍唯一：戰鬥開始時獲得等同於 <WeaponEffect_Num:[StateArg1]%> 基礎狂氣的狂氣。裝備者狂氣爆發最終傷害提升、其百分比為基礎狂氣的 <WeaponEffect_Num:[StateArg2]%>。切換至「怒濤」姿態時、獲得等同於當前界域精通 <WeaponEffect_Num:[StateArg3]%> 的臨時界域精通、3 回合冷卻。"
  },
  State_131073_WeaponDesc = {
    Text = "戰鬥開始時獲得 [DescArg1] 點狂氣。裝備者狂氣爆發最終傷害提升 [DescArg2]％。切換至「怒濤」姿態時、獲得 [DescArg3] 點臨時界域精通、3 回合冷卻（當前剩餘 [DescArg4] 回合）。"
  },
  State_131078_Desc = {
    Text = "每回合首次鑰令生效 2 次。"
  },
  State_131078_Name = {
    Text = "投餵零食"
  },
  State_131118_Desc = {
    Text = "每次受到傷害或失去生命時，無法超過最大生命的 3%。"
  },
  State_131118_Name = {
    Text = "千絲之繭"
  },
  State_131123_Desc = {
    Text = "回合開始時清除。達到 10 層後、下次打出卡牌後立刻行動並切換至下一個意圖、移除<Chapter5_Monster_Fervor4:狂熱>。"
  },
  State_131123_Name = {
    Text = "臨時狂熱"
  },
  State_131127_Desc = {
    Text = "受到命運束縛的姿態。對手每打出 1 張「指令卡」，自身獲得 1 層「臨時狂熱」。"
  },
  State_131127_Name = {
    Text = "縛誓契約"
  },
  State_131134_Desc = {
    Text = "死亡後，涅芙蕾亞獲得 [DescArg1] 層臨時狂熱，但失去 3% 最大生命。"
  },
  State_131134_Name = {
    Text = "淵獄之門"
  },
  State_131186_Desc = {
    Text = "打出後額外生效 1 次，但受到 [DescArg1] 點傷害。"
  },
  State_131186_Name = {
    Text = "<ExclamationPointColour:命運殘碎>"
  },
  State_131188_Desc = {
    Text = "打出的「技能」進入「維度裂隙」並為所有同名的技能附加「命運殘碎」，離開維度裂隙後清除。維度裂隙滿時，「背棄之網」涅芙蕾亞行動後清空維度裂隙，將下個意圖轉變為強力的狂氣爆發。"
  },
  State_131188_Name = {
    Text = "維度裂隙"
  },
  State_131191_Name = {
    Text = "認知障礙"
  },
  State_131242_Desc = {
    Text = "本卡牌造成的傷害、護盾、治療、力量、衰竭、觸腕傷害、固定中毒、固定反擊提升、獨立乘算 1+[Layer]%。"
  },
  State_131242_Name = {
    Text = "奇點信標β"
  },
  State_131258_Desc = {
    Text = "轉動紡輪的絲線，擾動錯誤的命運。釋放鑰令或打出「命運殘碎」卡牌後移除 1 層，全部移除後阿拉克涅釋放「命縷各安其位」追擊，造成高額傷害。釋放 3 次後將使敵方的「千絲之繭」徹底破碎！"
  },
  State_131258_Name = {
    Text = "命網擾動"
  },
  State_131261_Name = {
    Text = "破滅戲場"
  },
  State_131351_Desc = {
    Text = "其他喚醒體釋放狂氣爆發後消耗 1 層、莫絲釋放「渦！流！彈！」進行追擊。"
  },
  State_131351_Name = {
    Text = "漩渦裝填"
  },
  State_131439_Desc = {
    Text = "下張打出的指令卡額外生效 2 次且算力消耗降低為 0。"
  },
  State_131439_Name = {
    Text = "提線木偶"
  },
  State_131637_Desc = {
    Text = "死亡後立刻召喚一名隨機的「淵獄蜘群」或「冷蛛群」，使其「集群效應」降低 1 層。"
  },
  State_131637_Name = {
    Text = "集群效應"
  },
  State_131638_Desc = {
    Text = "死亡後立刻召喚一名隨機的「碎相母體」或「纏絲母體」，使其「集群效應」降低 1 層。"
  },
  State_131638_Name = {
    Text = "集群效應"
  },
  State_131645_Desc = {
    Text = "隊伍唯一：切換至「怒濤」姿態時、獲得等同於當前界域精通 <WeaponEffect_Num:[StateArg1]%> 的臨時界域精通、3 回合冷卻。"
  },
  State_131645_WeaponDesc = {
    Text = "切換至「怒濤」姿態時、獲得 [DescArg2] 點臨時界域精通、3 回合冷卻(當前剩餘 [DescArg1] 回合)。"
  },
  State_131657_Desc = {
    Text = "其他喚醒體釋放狂氣爆發後消耗 1 層、莫絲釋放「渦！流！彈！」進行追擊。"
  },
  State_131657_Name = {
    Text = "<WhirlpoolKeywords:漩渦裝填>"
  },
  State_131660_Desc = {
    Text = "每有 1 層提高 1 點釋放狂氣爆發的狂氣需求。"
  },
  State_131660_Name = {
    Text = "狂氣消耗固定值修正"
  },
  State_131675_Desc = {
    Text = "此卡牌在下次打出時有 [StateArg1]% 的機率額外生效 1 次。"
  },
  State_131675_Name = {
    Text = "<CardKeyWord:豪賭>"
  },
  State_131684_Desc = {
    Text = "接下來 [Layer] 次「渦！流！彈！」生效 2 次。"
  },
  State_131684_Name = {
    Text = "默斯克斯！大！轟！炸"
  },
  State_131749_Desc = {
    Text = "隊伍唯一：探索開始後、將 1 張「豪賭的智慧」洗入抽牌堆。「豪賭的智慧」：消耗 1 算力。將手中所有指令卡隨機洗入抽牌堆、洗入的指令卡在下次打出時有 <WeaponEffect_Num:[StateArg1]%> 機率額外生效 1 次、並且每洗入 1 張指令卡就使所有喚醒體獲得 2 點狂氣。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。<GuyouKeywords:固有>。"
  },
  State_131749_WeaponDesc = {
    Text = "探索開始後、將 1 張「豪賭的智慧」洗入抽牌堆。「豪賭的智慧」：消耗 1 算力。將手中所有指令卡隨機洗入抽牌堆、洗入的指令卡在下次打出時有 <WeaponEffect_Num:[StateArg1]%> 機率額外生效 1 次、並且每洗入 1 張指令卡就使所有喚醒體獲得 2 點狂氣。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。<GuyouKeywords:固有>。"
  },
  State_131769_Name = {
    Text = "狀態@繁育血肉職業初始化1"
  },
  State_131779_Desc = {
    Text = "使用 [Layer] 次後才會進入棄牌堆並重置次數、但「刻印」僅在首次使用時生效。"
  },
  State_131789_Desc = {
    Text = "備選手段。將1張tid是[Layer]的卡牌加入手中。"
  },
  State_131807_Name = {
    Text = "狀態＠繁育血肉至純標識"
  },
  State_131824_Name = {
    Text = "狀態@怪物塔薇切換意圖玩家監聽"
  },
  State_131846_Desc = {
    Text = "死亡後立刻召喚一名隨機的「淵獄蜘群」或「冷蛛群」，使其「集群效應」降低 1 層。"
  },
  State_131846_Name = {
    Text = "集群效應"
  },
  State_131908_Desc = {
    Text = "分攤目標的血量護盾狂氣，但不產生戰鬥統計。"
  },
  State_131908_Name = {
    Text = "腐爛盛筵跳板"
  },
  State_131909_Desc = {
    Text = "擁有該狀態則可使用狂氣爆發。"
  },
  State_132366_Desc = {
    Text = "其他喚醒體使用打擊卡後進行追擊"
  },
  State_132366_Name = {Text = "追擊"},
  State_132465_Desc = {
    Text = "本喚醒體造成的傷害、護盾、治療、力量、衰竭、觸腕傷害、固定中毒、固定反擊提高，獨立乘算 1+[Layer]%。"
  },
  State_132465_Name = {
    Text = "強化吞噬α"
  },
  State_132469_Desc = {
    Text = "本喚醒體造成的傷害、護盾、治療、力量、衰竭、觸腕傷害、固定中毒、固定反擊提高，獨立乘算 1+[Layer]%。"
  },
  State_132469_Name = {
    Text = "強化吞噬β"
  },
  State_132539_Desc = {
    Text = "集合測試造物"
  },
  State_132539_Name = {
    Text = "集合測試造物"
  },
  State_132539_WeaponDesc = {Text = "測試"},
  State_132560_WeaponDesc = {
    Text = "翠火每造成 [Damage:StateArg2] 次傷害，就獲得一張消耗【綠炎】。"
  },
  State_132564_WeaponDesc = {
    Text = "翠火每造成 [Damage:StateArg2] 次傷害，就獲得一張消耗【綠炎】。"
  },
  State_132565_WeaponDesc = {
    Text = "翠火每造成 [Damage:StateArg2] 次傷害，就獲得一張消耗【綠炎】。"
  },
  State_132598_Desc = {
    Text = "本回合造成觸腕傷害時，額外造成 [Layer]％ 傷害值的中毒。"
  },
  State_132598_Name = {
    Text = "湮塞的執念"
  },
  State_132609_Desc = {
    Text = "雕砌者施加護盾時，提高 [StateArg1] 觸腕傷害。"
  },
  State_132609_WeaponDesc = {
    Text = "雕砌者施加護盾時，提高 [StateArg1] 觸腕傷害。"
  },
  State_132669_Desc = {
    Text = "本喚醒體的卡牌造成的傷害、護盾、治療、力量、衰竭、觸腕傷害、固定中毒、固定反擊提高，獨立乘算 1+[Layer]%。"
  },
  State_132669_Name = {
    Text = "命定超維α"
  },
  State_132840_Name = {
    Text = "「24」的指令卡人格效果加成翻倍。釋放狂氣爆發後，人格加成翻倍效果本回合失效"
  },
  State_132891_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [StateArg1] <StrongEffectKeywords:強效>，其他友方狂氣爆發後使其獲得<PVPOneMeetingKeywords:一期一會>。"
  },
  State_132891_Name = {
    Text = "櫻花下的迷思"
  },
  State_132892_Desc = {
    Text = "·獲得時移除其他友方的「一期一會」狀態，獲得等同於裝備「櫻花下的迷思」友方的強效效果，最多 3 層。\n·裝備「櫻花下的迷思」的角色無法獲得「一期一會」。"
  },
  State_132892_Name = {
    Text = "一期一會"
  },
  State_133294_Name = {
    Text = "王邸的請柬"
  },
  State_133353_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備後，無法識別裝備者的「打擊」、「技能」、「狂氣爆發」描述，但每次傷害、護盾、治療隨機提升[StateArg1]％～[StateArg2]％。"
  },
  State_133353_Name = {
    Text = "淤泥裡的童話"
  },
  State_133354_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：該命輪死亡後保留。裝備者死亡時和死亡狀態下的後續 [Layer] 回合結束後，其他友方獲得 <Heal:[Heal:StateArg1]> <PVPFeatheredSeedsKeyWords:羽種>和生命。"
  },
  State_133354_Name = {
    Text = "願世界化作芬芳"
  },
  State_133369_Desc = {
    Text = "下 [DescArg1] 張打出的非塔薇的指令卡生效 2 次。"
  },
  State_133369_Name = {
    Text = "穿越銀鑰之門"
  },
  State_133372_Desc = {
    Text = "若當前處於超維回合，觸發奇點折躍效果。「奇點湮滅」也可使本回合下次奇點折躍必定發動。"
  },
  State_133372_Name = {
    Text = "<SingularityKeywords:奇點折躍>"
  },
  State_133391_Desc = {
    Text = "若該狀態層數大於等於目標生命，移除所有命運裁斷並直接擊殺目標。施加的固定命運裁斷受傷害強效加成。"
  },
  State_133391_Name = {
    Text = "<CutKeywords:命運裁斷>"
  },
  State_133395_Desc = {
    Text = "接下來打出的下 [Layer] 張指令卡觸發「維度穿梭」。"
  },
  State_133395_Name = {
    Text = "維度穿梭"
  },
  State_133717_Desc = {
    Text = "當前擁有者為 [Layer]，其所有當前及未來的卡牌將獲得對應屬性（當前：卡牌封印）。"
  },
  State_133717_Name = {
    Text = "卡牌屬性傳播"
  },
  State_133774_Desc = {
    Text = "每擁有 1 層使該卡牌造成的傷害、固定力量和觸腕傷害提高、固定中毒、固定反擊最終效果提高 2％；固定護盾、固定生命回覆、力量降低的最終效果提高 1％。擁有奇點信標的卡牌無法觸發「維度穿梭」。"
  },
  State_133774_Name = {
    Text = "<SingularityKeywords1:奇點信標>"
  },
  State_133775_Desc = {
    Text = "每擁有 1 層使所有喚醒體卡牌造成的傷害、固定力量和觸腕傷害提高、固定中毒、固定反擊最終效果提高 2％；固定護盾、固定生命回覆、力量降低的最終效果提高 1％。"
  },
  State_133775_Name = {
    Text = "<SingularityKeywords2:奇點稜鏡>"
  },
  State_133961_Desc = {
    Text = "隊伍唯一：探索開始後生成一張「春之信」置入牌庫：算力消耗 1，獲得 <WeaponEffect_Num:[StateArg1]> 點銀鑰能量，打出後永久變化為「櫻滿開」：算力消耗 1，獲得 <WeaponEffect_Num:[StateArg2]> 點銀鑰能量，打出後永久變化為「花吹雪」：算力消耗 1，獲得 <WeaponEffect_Num:[StateArg3]> 點銀鑰能量，打出後永久變化為「一期一會」：算力消耗 1，從已解鎖的 3 個隨機鑰令中選擇 1 個立刻釋放並生效 2 次，打出後永久變化為「春之信」。這些卡牌均擁有「保留」。"
  },
  State_133961_WeaponDesc = {
    Text = "探索開始後生成一張「春之信」置入牌庫：算力消耗 1，獲得 <WeaponEffect_Num:[StateArg1]> 點銀鑰能量，打出後永久變化為「櫻滿開」：算力消耗 1，獲得 <WeaponEffect_Num:[StateArg2]> 點銀鑰能量，打出後永久變化為「花吹雪」：算力消耗 1，獲得 <WeaponEffect_Num:[StateArg3]> 點銀鑰能量，打出後永久變化為「一期一會」：算力消耗 1，從已解鎖的 3 個隨機鑰令中選擇 1 個立刻釋放並生效 2 次，打出後永久變化為「春之信」。這些卡牌均擁有「保留」。"
  },
  State_133994_Desc = {
    Text = "所有喚醒體指令卡造成的傷害、固定力量和觸腕傷害提高、固定中毒、固定反擊的最終效果提高 [DescArg1]％，造成的固定護盾、固定生命回覆、力量降低效果提高 [DescArg2]％。"
  },
  State_133994_Name = {
    Text = "奇點稜鏡"
  },
  State_133998_Desc = {
    Text = "此卡牌造成的傷害、護盾、力量變化提高 [DescArg2]％，觸腕傷害、生命回復、固定中毒、固定反擊的最終效果提高 [DescArg1]%，回合結束或打出後移除。"
  },
  State_133998_Name = {
    Text = "<TempPowerKeywords1:臨時強化 [DescArg1]>"
  },
  State_133999_Desc = {
    Text = "每擁有 1 層使該卡牌造成的傷害、固定力量和觸腕傷害提高、固定中毒、固定反擊最終效果提高 2％；固定護盾、固定生命回覆、力量降低的最終效果提高 1％，回合結束或打出後移除。"
  },
  State_133999_Name = {
    Text = "<TempPowerKeywords:臨時強化>"
  },
  State_134100_Desc = {
    Text = "本場戰鬥受到致死傷害時，復活，回復 [Layer] 點生命並使所有喚醒體獲得 [StateArg1] 點狂氣和 [DescArg1] 點臨時觸腕傷害，無法驅散。"
  },
  State_134100_Name = {
    Text = "不死的極樂鳥"
  },
  State_134191_Desc = {
    Text = "隊伍唯一：探索開始後，將 1 張「私密午歇時間」洗入抽牌堆。「私密午歇時間」：消耗 1 算力。臨時暴擊傷害 +<WeaponEffect_Num:[StateArg1]%>。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。"
  },
  State_134191_WeaponDesc = {
    Text = "探索開始後，將 1 張「私密午歇時間」洗入抽牌堆。「私密午歇時間」：消耗 1 算力。臨時暴擊傷害 +<WeaponEffect_Num:[StateArg1]%>。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。"
  },
  State_134195_Desc = {
    Text = "本卡牌造成的固定中毒、固定反擊、固定命運裁斷層數提高，獨立乘算 1+[Layer]%。"
  },
  State_134196_Desc = {
    Text = "本喚醒體指令卡造成的固定中毒、固定反擊、固定命運裁斷層數提高，獨立乘算 1+[StateArg1]%。"
  },
  State_134197_Desc = {
    Text = "本卡牌造成的固定中毒、固定反擊、固定命運裁斷層數提高，獨立乘算 1+[StateArg1]%。"
  },
  State_134198_Desc = {
    Text = "本喚醒體指令卡造成的固定中毒、固定反擊、固定命運裁斷層數提高，獨立乘算 1+[Layer]%。"
  },
  State_134199_Desc = {
    Text = "本喚醒體狂氣爆發造成的固定中毒、固定反擊、固定命運裁斷層數提高，獨立乘算 1+[StateArg1]%。"
  },
  State_134200_Desc = {
    Text = "本喚醒體狂氣爆發造成的固定中毒、固定反擊、固定命運裁斷層數提高，獨立乘算 1+[Layer]%。"
  },
  State_134227_Desc = {
    Text = "阿拉克涅編織命運引出的線縷。最大 [DescArg1] 層，能被狂氣爆發消耗釋放「無盡絲縷」追擊，「織命」會繼承至下場戰鬥。"
  },
  State_134227_Name = {
    Text = "<SilkKeywords:織命>"
  },
  State_134231_Desc = {
    Text = "隊伍唯一：裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>，裝備者造成「追擊」時 + <WeaponEffect_Num:[StateArg2]%> 臨時強效，每回合最多生效 5 次。每當觸發「維度穿梭」時，裝備者獲得 <WeaponEffect_Num:[StateArg3]> 點狂氣。"
  },
  State_134231_WeaponDesc = {
    Text = "裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>，裝備者造成「追擊」時 + <WeaponEffect_Num:[StateArg2]%> 臨時強效，每回合最多生效 5 次。每當觸發「維度穿梭」時，裝備者獲得 <WeaponEffect_Num:[StateArg3]> 點狂氣。"
  },
  State_134237_Desc = {
    Text = "阿拉克涅編織命運引出的線縷，最大 [DescArg1] 層，能被狂氣爆發消耗釋放「<DerivativeCardKeywords_144:無盡線縷>」追擊。「織命」會繼承至下場戰鬥。"
  },
  State_134237_Name = {Text = "織命"},
  State_134240_Desc = {
    Text = "接下來 [Layer] 次「永恆織造」生成額外的「牽絲引命」置入抽牌堆和棄牌堆。"
  },
  State_134240_Name = {
    Text = "縛命羅網"
  },
  State_134261_Desc = {
    Text = "下 [Layer] 次造成的傷害翻倍。"
  },
  State_134261_Name = {
    Text = "私密午歇時間"
  },
  State_134262_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後自身下一次造成的傷害翻倍。"
  },
  State_134262_Name = {
    Text = "私密午歇時間"
  },
  State_134285_Desc = {
    Text = "若該狀態層數大於等於目標生命，移除所有命運裁斷並直接擊殺目標。施加的固定命運裁斷受傷害強效加成。"
  },
  State_134285_Name = {
    Text = "命運裁斷"
  },
  State_134313_Desc = {
    Text = "隊伍唯一：裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>，裝備者造成「追擊」時 + <WeaponEffect_Num:[StateArg2]%> 臨時強效，每回合最多生效 5 次。"
  },
  State_134313_WeaponDesc = {
    Text = "裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>，裝備者造成「追擊」時 + <WeaponEffect_Num:[StateArg2]%> 臨時強效，每回合最多生效 5 次。"
  },
  State_134384_Desc = {
    Text = "接下來打出的下 [Layer] 張指令卡觸發「維度穿梭」。"
  },
  State_134384_Name = {
    Text = "維度穿梭"
  },
  State_134389_Desc = {
    Text = "此卡牌造成的傷害、固定力量和觸腕傷害提高、固定中毒、固定反擊的最終效果提高 [DescArg1]％，造成的固定護盾、固定生命回覆、力量降低效果提高 [DescArg2]％。擁有「奇點信標」的卡牌無法再複製進「超維空間」。"
  },
  State_134389_Name = {
    Text = "<SingularityKeywords:奇點信標 [DescArg2]>"
  },
  State_134391_Desc = {
    Text = "每回合首次打出指令卡後觸發該效果，打出指令卡後將其臨時原始複製置入超維空間，超維回合無法發動該效果。"
  },
  State_134391_Name = {
    Text = "<SingularityKeywords3:維度穿梭>"
  },
  State_135232_Name = {
    Text = "<AwakerCard_24Lost:<SingularityKeywords:奇點折躍>：本回合剩餘時間內其他喚醒體打出指令卡後，消耗 1 層<SilkKeywords:織命>釋放「<DerivativeCardKeywords_144:無盡線縷>」追擊>"
  },
  State_135233_Name = {
    Text = "<SingularityKeywords:奇點折躍>：本回合剩餘時間內其他喚醒體打出指令卡後，消耗 1 層<SilkKeywords:織命>釋放「<DerivativeCardKeywords_144:無盡線縷>」追擊"
  },
  State_135919_Name = {
    Text = "<AwakerCard_24Lost:<SingularityKeywords:奇點折躍>：本回合剩餘時間內其他喚醒體打出指令卡後，消耗 1 層<SilkKeywords:織命>釋放「<DerivativeCardKeywords_144:無盡線縷>」追擊>"
  },
  State_135920_Name = {
    Text = "<SingularityKeywords:奇點折躍>：本回合剩餘時間內其他喚醒體打出指令卡後，消耗 1 層<SilkKeywords:織命>釋放「<DerivativeCardKeywords_144:無盡線縷>」追擊"
  },
  State_135921_Desc = {
    Text = "喚醒體造成的傷害提高 25%。"
  },
  State_135921_Name = {
    Text = "<CardKeyWord:呵斥，以報恩仇>"
  },
  State_138824_Desc = {
    Text = "閃耀的生命正讚頌自由，高奏凱歌，可被沙耶狂氣爆發消耗強化其效果。該狀態至多積攢 4 層，戰鬥結束後會保留。"
  },
  State_138824_Name = {
    Text = "<KaiHuajishu1:羽種>"
  },
  State_139039_Desc = {
    Text = "該喚醒體本回合下次狂氣爆發造成的傷害、固定護盾、固定生命回覆、固定力量、力量降低、觸腕傷害提升、固定中毒、固定反擊的最終效果提高 [Layer]％。"
  },
  State_139039_Name = {
    Text = "<BreedingKeywords2:繁育慶典>"
  },
  State_139687_Desc = {
    Text = "閃耀的生命正讚頌自由，高奏凱歌，可被沙耶狂氣爆發消耗強化其效果。該狀態至多積攢 4 層，戰鬥結束後會保留。"
  },
  State_139687_Name = {
    Text = "<KaiHuajishu:羽種>"
  },
  State_139688_Desc = {
    Text = "隊伍唯一：算力上限 +1，同類效果無法疊加。裝備者每有 10 點基礎狂氣，造成的固定<Corrosion:侵蝕>效果提高 <WeaponEffect_Num:[StateArg1]%>，造成的胚胎融合提高 <WeaponEffect_Num:[Float:StateArg2]％>。"
  },
  State_139688_WeaponDesc = {
    Text = "算力上限 +1，同類效果無法疊加。裝備者每有 10 點基礎狂氣，造成的固定<Corrosion:侵蝕>效果提高 <WeaponEffect_Num:[StateArg1]%>，造成的胚胎融合提高 <WeaponEffect_Num:[Float:StateArg2]％>。"
  },
  State_139689_Desc = {
    Text = "隊伍唯一：使用「猩紅熔爐」後，裝備者獲得 <WeaponEffect_Num:[StateArg1]%> 基礎狂氣的狂氣，3 回合冷卻。"
  },
  State_139689_WeaponDesc = {
    Text = "使用「猩紅熔爐」後，裝備者獲得 <WeaponEffect_Num:[StateArg1]%> 基礎狂氣的狂氣，3 回合冷卻。"
  },
  State_139977_Desc = {
    Text = "本回合若打出「打擊」，則「打擊」+ [DescArg1]％ 傷害貫穿；否則回合結束 +[Layer] 屏障。"
  },
  State_139977_Name = {Text = "星獸"},
  State_140063_Desc = {
    Text = "這是向下回合借算力打下的“欠條”，會在下回合開始後扣除 [Layer] 算力，無法驅散。"
  },
  State_140063_Name = {
    Text = "欠條傍身"
  },
  State_140068_Desc = {
    Text = "下 [DescArg1] 張「技能」消耗的算力 – [StateArg1] 。"
  },
  State_140135_Desc = {
    Text = "每擁有 1 層，該喚醒體本回合下次狂氣爆發造成的傷害、固定護盾、固定生命回覆、固定力量、力量降低、觸腕傷害提升、固定中毒、固定反擊的最終效果提高 1％。"
  },
  State_140135_Name = {
    Text = "<BreedingKeywords1:繁育慶典>"
  },
  State_140186_WeaponDesc = {
    Text = "鯨躍的所有傷害次數+1。"
  },
  State_140454_Desc = {
    Text = "隊伍唯一：裝備者自身、命輪、密契每有 1% 黑印掉落，戰鬥結束後回復 <WeaponEffect_Num:[StateArg1]%> 最大生命，每回合結束就使該回復效果衰減 30%，多次獨立計算。在「灰燼遺跡」中釋放「感應」後，本次「灰燼遺跡」刷新無需消耗黑印。"
  },
  State_140454_WeaponDesc = {
    Text = "隊伍唯一：戰鬥結束後回復 <WeaponEffect_Num:[DescArg2]%> 最大生命([DescArg1])，每回合結束就使該回復效果降低 30%。在「灰燼遺跡」中釋放「感應」後，本次「灰燼遺跡」刷新無需消耗黑印。"
  },
  State_140456_WeaponDesc = {
    Text = "打出後將其永久移除。"
  },
  State_140458_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和任意喚醒體釋放「狂氣爆發」後，自身獲得 <Block:[Block:StateArg1]> 護盾。"
  },
  State_140489_Desc = {
    Text = "獲得等量最大生命，層數不會超過喚醒體的初始最大生命。"
  },
  State_140489_Name = {Text = "羽種"},
  State_140490_Desc = {
    Text = "獲得等量最大生命，層數不會超過該喚醒體的初始最大生命 [DescArg1]。"
  },
  State_140490_Name = {Text = "羽種"},
  State_140495_Desc = {
    Text = "下一張「技能」消耗的算力 - [Layer] 。"
  },
  State_140495_Name = {Text = "改寫"},
  State_140517_Desc = {
    Text = "下一張「技能」消耗的算力 – [DescArg1] 。"
  },
  State_140517_Name = {Text = "改寫"},
  State_140547_Desc = {
    Text = "該效果至多使胚胎融合+ 100，不受胚胎融合提高效果加成。"
  },
  State_140645_Desc = {
    Text = "待機特效"
  },
  State_140645_Name = {
    Text = "待機特效"
  },
  State_140647_Name = {
    Text = "打出認知失調監聽"
  },
  State_140648_Name = {
    Text = "玩家持有認知失調計數"
  },
  State_140650_Desc = {
    Text = "每回合前 3 次打出帶有「認知錯亂」的指令卡使沙耶獲得 [Layer] 點狂氣。"
  },
  State_140650_Name = {
    Text = "認知改造"
  },
  State_140651_Desc = {
    Text = "待機特效"
  },
  State_140651_Name = {
    Text = "待機特效"
  },
  State_140653_Desc = {
    Text = "本卡牌算力消耗有 10% 的幾率 -2，25% 的幾率 -1、30% 的幾率不變、25% 的幾率 +1、10% 的幾率 +2。打出或棄置後移除該狀態"
  },
  State_140653_Name = {
    Text = "<ExclamationPointColour:認知失調>"
  },
  State_140654_Desc = {
    Text = "待機特效"
  },
  State_140654_Name = {
    Text = "待機特效"
  },
  State_140655_Desc = {
    Text = "本卡牌被融蝕遮蓋無法查看其文字，算力消耗有 10% 的幾率 -2，25% 的幾率 -1、30% 的幾率不變、25% 的幾率 +1、10% 的幾率 +2。打出或棄置後移除該狀態。"
  },
  State_140655_Name = {
    Text = "<ErosionColorInkKeywords:認知錯亂>"
  },
  State_140656_Desc = {
    Text = "本卡牌算力消耗有 10% 的幾率 -2，25% 的幾率 -1、30% 的幾率不變、25% 的幾率 +1、10% 的幾率 +2。打出或棄置後移除該狀態"
  },
  State_140656_Name = {
    Text = "<ColorInkKeywords:認知失調>"
  },
  State_140657_Desc = {
    Text = "本卡牌被融蝕遮蓋無法查看其文字，算力消耗有 10% 的幾率 -2，25% 的幾率 -1、30% 的幾率不變、25% 的幾率 +1、10% 的幾率 +2。打出或棄置後移除該狀態。"
  },
  State_140657_Name = {
    Text = "<ExclamationPointColour:認知錯亂>"
  },
  State_140658_Name = {
    Text = "玩家持有認知失調監聽"
  },
  State_140659_Desc = {
    Text = "待機特效"
  },
  State_140659_Name = {
    Text = "待機特效"
  },
  State_140662_Desc = {
    Text = "每回合開始時，都會隨機對 2 張沒有「認知錯亂」的指令卡施加「認知錯亂」。"
  },
  State_140662_Name = {
    Text = "生命重構治療"
  },
  State_140672_Desc = {
    Text = "本回合結束之前，每次造成的傷害、治療、護盾隨機降低15%~35%，無法驅散。"
  },
  State_140672_Name = {
    Text = "<PVPCognitiveDissonanceKeyWords:認知錯亂>"
  },
  State_140673_Desc = {
    Text = "本回合結束之前，每次造成的傷害、治療、護盾隨機降低15%~35%，無法驅散。"
  },
  State_140673_Name = {
    Text = "認知錯亂"
  },
  State_140683_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [StateArg1] <MaxHPKeywords:最大生命值>，回合結束時回復生命 <Heal:[Heal:DescArg1]> 點，回復生命隨裝備者生命降低而提高，最多提升 [StateArg3]%。"
  },
  State_140683_Name = {
    Text = "夢遊仙境"
  },
  State_140724_Name = {Text = "進食"},
  State_140726_Desc = {
    Text = "此卡牌造成的傷害、力量、觸腕傷害、固定中毒、固定反擊、護盾、生命回復、力量降低的最終效果降低 [DescArg1]%。"
  },
  State_140726_Name = {
    Text = "<AdaptKeywords1:適應 [DescArg1]>"
  },
  State_140727_Desc = {
    Text = "飢餓達到 5 層時，回合結束後消耗所有飢餓，將意圖切換為強力攻擊並獲得 [DescArg1] 點力量。"
  },
  State_140727_Name = {Text = "飢餓"},
  State_140728_Desc = {
    Text = "每回合開始時獲得 1 層飢餓，造成未被格擋的傷害時獲得最大生命值 2%([DescArg1]) 點護盾，適應的最高層數提高為 75。"
  },
  State_140728_Name = {Text = "護食"},
  State_140730_Desc = {
    Text = "打出指令卡後，對所屬喚醒體在各處的卡牌施加 10 層<AdaptKeywords:適應>，其他喚醒體的卡牌移除 5 層<AdaptKeywords:適應>。每層<AdaptKeywords:適應>使卡牌造成的傷害、力量、觸腕傷害、固定中毒、固定反擊、護盾、生命回覆、力量降低的最終效果降低 1%，最高 [DescArg1] 層。"
  },
  State_140730_Name = {Text = "擬態"},
  State_140838_Desc = {
    Text = "本回合造成的傷害降低 [Layer]%。"
  },
  State_140838_Name = {
    Text = "蔽日魘牆"
  },
  State_140839_Desc = {
    Text = "本回合所有喚醒體最終傷害提升 [Layer]%。"
  },
  State_140839_Name = {
    Text = "隨行獵從"
  },
  State_140856_Desc = {
    Text = "無法行動，回合結束時移除 1 層意識干涉，全部移除後該喚醒體下 1 次釋放狂氣爆發時視為釋放超限爆發，若釋放時已經為超限爆發則改為返還 100% 基礎狂氣。"
  },
  State_140856_Name = {
    Text = "<Yishiganshe:意識干涉>"
  },
  State_140860_Desc = {
    Text = "無法行動，回合結束時移除 1 層意識干涉，全部移除後該喚醒體下 1 次釋放狂氣爆發時視為釋放超限爆發，若釋放時已經為超限爆發則改為返還 100% 基礎狂氣。"
  },
  State_140860_Name = {
    Text = "<Yishiganshe:意識干涉>"
  },
  State_140861_Desc = {
    Text = "下 1 次釋放狂氣爆發時視為釋放超限爆發，若釋放時已經為超限爆發則改為返還 100% 基礎狂氣。"
  },
  State_140861_Name = {
    Text = "夢遊仙境"
  },
  State_140873_Desc = {
    Text = "每 1 層使此卡牌造成的傷害、力量、觸腕傷害、固定中毒、固定反擊、護盾、生命回覆、力量降低的最終效果降低 1%，最高 [DescArg1] 層。"
  },
  State_140873_Name = {
    Text = "<AdaptKeywords:適應>"
  },
  State_140877_Name = {
    Text = "額外生效 [DescArg1] 次"
  },
  State_141468_Desc = {
    Text = "飢餓達到 5 層時，回合結束後消耗所有飢餓，將意圖切換為強力攻擊並獲得力量。"
  },
  State_141468_Name = {
    Text = "<HungerKeywords:飢餓>"
  },
  State_141504_Desc = {
    Text = "至多積攢 3 具，達到上限後下次「生靈的盛宴」能夠將其食用並強化其效果。殘骸會繼承至下場戰鬥。"
  },
  State_141504_Name = {Text = "殘骸"},
  State_141950_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備和回合結束時，<PVPDiscoveryKeyWords:發現> [StateArg1] 張附加<PVPVoidKeywords:虛無>的「技能」並置入手中。"
  },
  State_141950_Name = {
    Text = "向上墜落"
  },
  State_141988_Desc = {
    Text = "本卡牌造成的傷害、護盾、治療，施加的力量、衰竭、觸腕傷害、中毒、反擊、命運裁斷、固定中毒、固定反擊、固定命運裁斷，效果提升 [Layer]%。"
  },
  State_141989_Desc = {
    Text = "創造出隨機的卡牌。"
  },
  State_141989_Name = {
    Text = "<CardKeyWord:發現>"
  },
  State_141991_Desc = {
    Text = "本喚醒體狂氣爆發造成的傷害、護盾、治療，施加的力量、衰竭、觸腕傷害、中毒、反擊、命運裁斷、固定中毒、固定反擊、固定命運裁斷，效果提升 [Layer]%。"
  },
  State_141991_Name = {
    Text = "狂氣爆發炫彩"
  },
  State_141992_Desc = {
    Text = "本喚醒體的卡牌造成的傷害、護盾、治療，施加的力量、衰竭、觸腕傷害、中毒、反擊、命運裁斷、固定中毒、固定反擊、固定命運裁斷，效果提升 [Layer]%。"
  },
  State_141993_Desc = {
    Text = "本喚醒體指令卡造成的傷害、護盾、治療，施加的力量、衰竭、觸腕傷害、中毒、反擊、命運裁斷、固定中毒、固定反擊、固定命運裁斷，效果提升 [Layer]%。"
  },
  State_141994_Desc = {
    Text = "打出卡牌後、釋放狂氣爆發後造成的傷害，獲得護盾、治療，施加力量、衰竭、觸腕傷害、中毒、反擊、命運裁斷、固定中毒、固定反擊、固定命運裁斷。"
  },
  State_141994_Name = {
    Text = "炫彩觸發指令"
  },
  State_142018_Desc = {
    Text = "回合開始時，獲得1層<Guaiwucanhai:殘骸>"
  },
  State_142018_Name = {
    Text = "王邸的請柬"
  },
  State_142057_Desc = {
    Text = "使用鑰令後切換自身意圖，戰鬥開始後所有喚醒體銀鑰充能等級提高 25%。"
  },
  State_142058_Desc = {
    Text = "造成的基礎傷害、中毒、反擊降低 [DescArg1]%"
  },
  State_142058_Name = {
    Text = "污穢之翼"
  },
  State_142060_Desc = {
    Text = "敵方每次使用指令卡後，自身獲得 1 層臨時狂熱。臨時狂熱達到 10 層時，下次打出指令卡後，自身立刻行動並移除所有臨時狂熱。"
  },
  State_142060_Name = {
    Text = "深淵回音"
  },
  State_142062_Desc = {
    Text = "每次0246初始效果隨機"
  },
  State_142062_Name = {
    Text = "意圖隨機"
  },
  State_142063_Desc = {
    Text = "自身回合內，受到的傷害降低 [DescArg1]%。"
  },
  State_142063_Name = {
    Text = "聖潔之翼"
  },
  State_142065_Desc = {
    Text = "回合開始時清除。達到 10 層時，下次打出指令卡後，自身立刻行動並移除所有臨時狂熱。"
  },
  State_142065_Name = {
    Text = "臨時狂熱"
  },
  State_142066_Desc = {
    Text = "造成的 <WeaknessIconKeywords:虛弱>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重創>效果提高為 50%。"
  },
  State_142066_Name = {
    Text = "本質洞悉"
  },
  State_142067_Desc = {
    Text = "造成的力量、反擊、觸腕傷害降低 [DescArg1]%"
  },
  State_142067_Name = {
    Text = "詛咒之翼"
  },
  State_142072_Desc = {
    Text = "每次受到傷害或失去生命時、無法超過最大生命值的 5%。"
  },
  State_142072_Name = {
    Text = "承痛閾值"
  },
  State_142091_Desc = {
    Text = "六翼翻倍計數"
  },
  State_142091_Name = {
    Text = "六翼翻倍計數"
  },
  State_142092_Desc = {
    Text = "所有喚醒體銀鑰充能等級提高 25%。"
  },
  State_142093_Desc = {
    Text = "六翼翻倍消耗進度：[DescArg1]，當前所需受傷值：[DescArg2]。"
  },
  State_142095_Desc = {
    Text = "六翼翻倍標識"
  },
  State_142095_Name = {
    Text = "六翼翻倍標識"
  },
  State_142166_Desc = {
    Text = "具體效果看通用打擊邏輯。__「僅開發用」"
  },
  State_142215_Desc = {
    Text = "若其在下回合開始依舊死亡，則復活並獲得 [StateArg1] 護盾，無法驅散。"
  },
  State_142215_Name = {
    Text = "永世執念"
  },
  State_142228_Desc = {
    Text = "此卡牌由命輪「向上墜落」創造。"
  },
  State_142228_Name = {
    Text = "向上墜落"
  },
  State_142229_Desc = {
    Text = "隊伍唯一：探索開始後，將 1 張「夢遊仙境」加入牌庫。「夢遊仙境」：消耗 2 點算力，使裝備者獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣與 3 層<Yishiganshe:「意識干涉」>。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。"
  },
  State_142229_Name = {
    Text = "夢遊仙境"
  },
  State_142229_WeaponDesc = {
    Text = "探索開始後，將 1 張「夢遊仙境」加入牌庫。「夢遊仙境」：消耗 2 點算力，使裝備者獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣與 3 層<Yishiganshe:「意識干涉」>。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。"
  },
  State_142452_Desc = {
    Text = "受到的力量降低效果縮減 50%。"
  },
  State_142663_Desc = {
    Text = "下回合開始時，獲得<DelayKeywords:延遲>： [Layer] 狂氣。"
  },
  State_142663_Name = {
    Text = "延遲延遲狂氣"
  },
  State_142688_Desc = {
    Text = "目標所裝備的命輪失效，不可驅散。"
  },
  State_142688_Name = {
    Text = "超級纏繞"
  },
  State_142692_Name = {
    Text = "靈機一動"
  },
  State_142715_Desc = {
    Text = "該「技能」傷害提升 [DescArg1]% ,該技能每需要消耗 1 點算力增加 [StateArg1]%。"
  },
  State_142887_Desc = {
    Text = "若本回合再次受到「麻痺」，其所有「打擊」變為「幻象」，不可驅散，持續到回合結束。"
  },
  State_142887_Name = {
    Text = "有點麻了"
  },
  State_142954_Desc = {
    Text = "算力上限最小為 0 ，每回合開始時若小於 10 會增長 1  。在到達 10 後再獲得算力上限將轉換為抽等量卡牌。"
  },
  State_143002_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143002_Name = {
    Text = "撒托古亞SR(臨時文本)"
  },
  State_143004_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143004_Name = {
    Text = "撒托古亞專武(臨時文本)"
  },
  State_143005_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143005_Name = {
    Text = "蘭提戈斯SR(臨時文本)"
  },
  State_143006_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143006_Name = {
    Text = "黑法老專武(臨時文本)"
  },
  State_143007_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合開始時，對隨機的敵方施加 [StateArg1] 層<PVPCompassKeywords:指向歧路的羅盤>。"
  },
  State_143007_Name = {
    Text = "指向歧路的羅盤"
  },
  State_143008_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143008_Name = {
    Text = "夏塔克鳥專武(臨時文本)"
  },
  State_143009_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143009_Name = {
    Text = "亞弗戈蒙專武(臨時文本)"
  },
  State_143010_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：手牌上限+ [StateArg1] ，裝備者或友方死亡時，其卡牌不再轉換為<PVPDerivativeCardKeywords_2:「幻象」>，而是轉換為<PVPDerivativeCardKeywords_30:「獵魘」>。"
  },
  State_143010_Name = {Text = "活囚籠"},
  State_143011_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143011_Name = {
    Text = "禿鷲SR(臨時文本)"
  },
  State_143012_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143012_Name = {
    Text = "夏塔克鳥SR(臨時文本)"
  },
  State_143013_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143013_Name = {
    Text = "本源奧吉爾SR(臨時文本)"
  },
  State_143014_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」前損失 25% 當前生命；「狂氣爆發」後對全體敵方造成 [StateArg1] 傷害並汲取等量生命。"
  },
  State_143014_Name = {
    Text = "蜜果的謊言"
  },
  State_143016_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143016_Name = {
    Text = "黑法老SR(臨時文本)"
  },
  State_143017_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143017_Name = {
    Text = "蘭提戈斯專武(臨時文本)"
  },
  State_143018_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143018_Name = {
    Text = "本源圖魯SR(臨時文本)"
  },
  State_143019_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使敵方全體施加 [StateArg1] 層<PVPBless:賜福>。"
  },
  State_143020_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143020_Name = {
    Text = "本源奧吉爾專武(臨時文本)"
  },
  State_143022_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143022_Name = {
    Text = "禿鷲專武(臨時文本)"
  },
  State_143023_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_143023_Name = {
    Text = "亞弗戈蒙SR(臨時文本)"
  },
  State_143326_Desc = {
    Text = "銀鑰充能提高 [DescArg1]。"
  },
  State_143331_Desc = {
    Text = "下回合結束前為<StatusApplier:>承受一半傷害的生命損失，此狀態每個隊伍唯一，綁定雙方任意一人死亡時移除該效果，無法驅散。"
  },
  State_143331_Name = {
    Text = "承受傷害"
  },
  State_143333_Desc = {
    Text = "下回合開始前<StatusApplier:>為其承受一半傷害的生命損失，此狀態每個隊伍唯一，綁定雙方任意一人死亡時移除該效果，無法驅散。"
  },
  State_143333_Name = {
    Text = "傷害轉移"
  },
  State_143336_Desc = {
    Text = "為「囚魘」賦予額外生效 1 次。打出「囚魘」時消耗 1 層，上限為 9 層，戰鬥結束時不清除。"
  },
  State_143336_Name = {
    Text = "<BattueKeywords:圍獵>"
  },
  State_143340_Desc = {
    Text = "為「囚魘」賦予額外生效 1 次。打出「囚魘」時消耗 1 層，上限為 9 層，戰鬥結束時不清除。"
  },
  State_143340_Name = {
    Text = "<BattueKeywords1:圍獵>"
  },
  State_143386_Desc = {
    Text = "為<StatusApplier:>承受一半傷害的生命損失，無法驅散。"
  },
  State_143386_Name = {
    Text = "承受傷害"
  },
  State_143387_Desc = {
    Text = "<StatusApplier:>為其承受一半傷害的生命損失，無法驅散。"
  },
  State_143387_Name = {
    Text = "傷害轉移"
  },
  State_143406_Name = {
    Text = "此卡牌額外生效 [DescArg1] 次"
  },
  State_143408_Desc = {
    Text = "受到敵方喚醒體攻擊時將轉換為攻擊者的 [Layer] 狂氣。"
  },
  State_143408_Name = {
    Text = "指向歧路的羅盤"
  },
  State_143409_Desc = {
    Text = "受到敵方喚醒體攻擊時將層數等量轉換為攻擊者的狂氣。"
  },
  State_143409_Name = {
    Text = "<CardKeyWord:指向歧路的羅盤>"
  },
  State_143419_Desc = {
    Text = "這張牌來自<PVPDerivativeCardKeywords_31:「奧瑞塔的寶藏」>。"
  },
  State_143419_Name = {
    Text = "奧瑞塔的寶藏"
  },
  State_143426_Desc = {
    Text = "回合開始後，扣除 [Layer] 算力，無法驅散。"
  },
  State_143426_Name = {
    Text = "延遲扣除算力"
  },
  State_143441_Desc = {
    Text = "第[StateArg1]輪操作時被選中的喚醒體。"
  },
  State_143441_Name = {
    Text = "測試標記1"
  },
  State_143442_Desc = {
    Text = "第[StateArg1]輪操作時被選中的喚醒體。"
  },
  State_143442_Name = {
    Text = "測試標記2"
  },
  State_143444_Desc = {
    Text = "第[StateArg1]輪操作時被選中的喚醒體。"
  },
  State_143444_Name = {
    Text = "測試標記4"
  },
  State_143445_Desc = {
    Text = "第[StateArg1]輪操作時被選中的喚醒體。"
  },
  State_143445_Name = {
    Text = "測試標記3"
  },
  State_143499_Name = {
    Text = "免疫主動傷害__「僅開發用」"
  },
  State_143500_Name = {
    Text = "免疫純粹傷害__「僅開發用」"
  },
  State_143541_Desc = {
    Text = "所有敵人本回合造成的傷害降低 [DescArg1]%，獲得 [DescArg2] 點力量。"
  },
  State_143541_Name = {Text = "護衛"},
  State_143542_Desc = {
    Text = "臨時最終傷害 +[DescArg1]%，並對所有敵人造成 [DescArg2]% 最大生命值的侵蝕。"
  },
  State_143542_Name = {Text = "獵取"},
  State_143548_Desc = {
    Text = "造成護盾並添加狀態，怪物，分支1。"
  },
  State_143548_Name = {
    Text = "怪物盾轉1"
  },
  State_143549_Desc = {
    Text = "造成護盾並添加狀態，喚醒體，分支2。"
  },
  State_143549_Name = {
    Text = "角色盾轉2"
  },
  State_143550_Desc = {
    Text = "造成護盾並添加狀態，喚醒體，分支1。"
  },
  State_143550_Name = {
    Text = "角色盾轉1"
  },
  State_143551_Desc = {
    Text = "造成護盾並添加狀態，怪物，分支2。"
  },
  State_143551_Name = {
    Text = "怪物盾轉2"
  },
  State_143552_Desc = {
    Text = "造成護盾並添加狀態，玩家，分支1。"
  },
  State_143552_Name = {
    Text = "玩家盾轉1"
  },
  State_143553_Desc = {
    Text = "造成護盾並添加狀態，玩家，分支2。"
  },
  State_143553_Name = {
    Text = "玩家盾轉2"
  },
  State_143573_Desc = {
    Text = "囚魘是龐托斯的增益卡，共有 3 種：「擄掠之魘」「滋擾之魘」「獵殺之魘」。生成永久「囚魘」時若永久「囚魘」超出 6 張，將隨機永久「囚魘」升級為算力消耗 +1 但額外生效 1 次的「雙生囚魘」，「雙生囚魘」在牌庫中視為 2 張「囚魘」。若所有「囚魘」均已升級則將 1 張具有<DestructionKeywords:銷毀>的「高級靈感」置入手中。"
  },
  State_143573_Name = {Text = "囚魘"},
  State_143578_Desc = {
    Text = "本回合內，每當受到主動傷害，將 [Layer] 張<PVPDerivativeCardKeywords_30:「獵魘」>置入手牌。"
  },
  State_143578_Name = {
    Text = "領主之儀"
  },
  State_143595_Desc = {
    Text = "該卡牌被添加了<PrepareKeywords:預備> [StateArg1]。"
  },
  State_143595_Name = {
    Text = "黑天鵝的舞步"
  },
  State_143597_Desc = {
    Text = "隊伍唯一：裝備者造成力量降低效果提高 <WeaponEffect_Num:[StateArg1]%>。切換至「怒濤」姿態時 ，臨時暴擊傷害提高，提高量等同於自身基礎暴擊傷害的 <WeaponEffect_Num:[StateArg1]%> ，3 回合冷卻。"
  },
  State_143597_WeaponDesc = {
    Text = "裝備者造成力量降低效果提高 <WeaponEffect_Num:[StateArg1]%>。切換至「怒濤」姿態後臨時暴擊傷害提高 <WeaponEffect_Num:[DescArg1]%> ，3 回合冷卻。"
  },
  State_143598_Desc = {
    Text = "隊伍唯一：裝備者造成的力量降低效果提高 <WeaponEffect_Num:[StateArg1]%>，每擊殺 1 個敵人使裝備者本場探索回合結束固定回覆的狂氣提高 2 點，最多堆疊 <WeaponEffect_Num:[StateArg2]> 次。切換至「怒濤」姿態後臨時暴擊傷害提高，提高量等同於自身基礎暴擊傷害的 <WeaponEffect_Num:[StateArg1]%> ，3 回合冷卻。"
  },
  State_143598_WeaponDesc = {
    Text = "裝備者造成力量降低效果提高 <WeaponEffect_Num:[StateArg1]%>，每擊殺 1 個敵人使裝備者本場探索回合結束固定回覆的狂氣提高 2 點，最多堆疊 <WeaponEffect_Num:[StateArg2]> 次。切換至「怒濤」姿態後臨時暴擊傷害提高 <WeaponEffect_Num:[DescArg1]%> ，3 回合冷卻。"
  },
  State_143683_Desc = {
    Text = "此喚醒體追擊被封印無法使用， [Layer] 回合後封印解除。"
  },
  State_143683_Name = {
    Text = "<Seal1:追擊封印>"
  },
  State_144381_Desc = {
    Text = "無法行動，剩餘 [DescArg1] 回合。"
  },
  State_144381_Name = {
    Text = "<Yishiganshe:意識干涉>"
  },
  State_144441_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：友方死亡時，自身獲得 <Energy:[Energy:StateArg1]> 狂氣。友方復活時，其獲得 <Energy:[Energy:StateArg2]> 狂氣。獲得狂氣效果僅在目標狂氣不滿時生效，剩餘生效 [Layer] 次，次數耗盡後銷毀該命輪。"
  },
  State_144441_Name = {
    Text = "魂靈同調"
  },
  State_144494_Desc = {
    Text = "共有 7 種效果，包括：抽 8 張牌、獲得 6 點算力、獲得銀鑰能量、所有喚醒體獲得固定狂氣、獲得力量、臨時降低所有敵人力量、臨時傷害強效提高。"
  },
  State_144494_Name = {
    Text = "<Blessing:禮物>"
  },
  State_144508_Desc = {
    Text = "「代價」共有 3 種，包括「錯失良機」、「誇大其詞」、「暗藏殺機」。\n「錯失良機」：2 回合後獲得「禮物」效果。\n「誇大其詞」：「禮物」效果減少 50％。\n「暗藏殺機」：給予自身隨機 1 種不同效果：2 回合虛弱 、2 回合脆弱 、2 回合重創、等同於自身最大生命值 1% 的中毒、2 層空虛、手中隨機 2 張卡牌施加 1 層遲緩、生成 2 張臨時症狀卡（不跨戰鬥繼承）置入抽牌堆頂部。"
  },
  State_144508_Name = {
    Text = "<BlessingNegativeEffect:代價>"
  },
  State_144519_Desc = {
    Text = "測試過程量，回合開始後或打出卡牌後刷新。當前擁有 [Layer] 界精。"
  },
  State_145228_Name = {
    Text = "<WormGrowth:飽餐>"
  },
  State_145229_Desc = {
    Text = "你也是賜福的一部分哦~。可被卡拉布狂氣爆發消耗獲得增益，該狀態至多積攢 5 層。戰鬥結束後不清除"
  },
  State_145436_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提升 [DescArg1]% ，每次「打擊」後傷害額外提升 [StateArg2]% ，最多提升至 [StateArg3]% 。"
  },
  State_145436_Name = {
    Text = "不滅的飢骨"
  },
  State_145437_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [StateArg2] 層<EnergyStorageKeywords:蓄力>，「打擊」傷害提升 [StateArg1]% 並改為<PVPPunctureDamagewords:穿刺傷害>。"
  },
  State_145437_Name = {Text = "天之隕"},
  State_145456_Desc = {
    Text = "在選擇目標時會忽略嘲諷、潛行、鎖定。若多名目標條件相等，優先選中靠前喚醒體。"
  },
  State_145456_Name = {
    Text = "生命與護盾最低"
  },
  State_145457_Desc = {
    Text = "在選擇目標時會忽略嘲諷、潛行、鎖定。若多名目標條件相等，優先選中靠前喚醒體。"
  },
  State_145457_Name = {
    Text = "生命與護盾最高"
  },
  State_145495_Desc = {
    Text = "此卡牌由雙發打出。"
  },
  State_145495_Name = {
    Text = "<CardKeyWord:雙發>"
  },
  State_145554_Desc = {
    Text = "隊伍唯一：探索開始後，將 1 張<Falltospace1[StateArg3]:「涉足人間」>加入牌庫。「涉足人間」：消耗 0 算力。對所有敵人造成裝備者攻擊力 <WeaponEffect_Num:[StateArg1]%> 以及其最大生命值 <WeaponEffect_Num:[Float:StateArg4]%> 的固定<Corrosion:侵蝕>，使各處其他喚醒體的指令卡附加<ErosionColorInkKeywords:認知錯亂>並將 1 張<Falltospace2[StateArg3]:「向上墜落」>洗入抽牌堆。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。"
  },
  State_145554_Name = {
    Text = "向上墜落"
  },
  State_145554_WeaponDesc = {
    Text = "探索開始後，將 1 張<Falltospace1[StateArg3]:「涉足人間」>加入牌庫。「涉足人間」：消耗 0 算力。對所有敵人造成裝備者攻擊力 <WeaponEffect_Num:[StateArg1]%> 以及其最大生命值 <WeaponEffect_Num:[Float:StateArg4]%> 的固定<Corrosion:侵蝕>，使各處其他喚醒體的指令卡附加<ErosionColorInkKeywords:認知錯亂>並將 1 張<Falltospace2[StateArg3]:「向上墜落」>洗入抽牌堆。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>"
  },
  State_145572_Desc = {
    Text = "每次回合開始，所有其他喚醒體造成 <Damage:[Damage:Layer]> 穿刺傷害。"
  },
  State_145572_Name = {
    Text = "噬鯨的風暴"
  },
  State_145590_Desc = {
    Text = "相同歸屬的相同卡牌置入到手中時會觸發融合效果並消耗該卡牌。"
  },
  State_145592_Desc = {
    Text = "鎖定一個敵方，將其作為優先攻擊目標，選擇單體目標時僅能選擇鎖定目標，忽略嘲諷和隱匿。"
  },
  State_145592_Name = {
    Text = "<CardKeyWord:鎖定>"
  },
  State_145619_Name = {Text = "重創"},
  State_145620_Name = {Text = "空虛"},
  State_145621_Desc = {
    Text = "「禮物」效果減少 50％。"
  },
  State_145621_Name = {
    Text = "<Bleesing_Exaggerate:誇大其詞>"
  },
  State_145622_Name = {Text = "遲緩"},
  State_145623_Desc = {
    Text = "給予自身隨機 1 種不同效果：2 回合虛弱 、2 回合脆弱 、2 回合重創、施加等同於最大生命值 1% 的中毒、2 層空虛、手中隨機 2 張卡牌施加 1 層遲緩、生成 2 張臨時症狀卡（不跨戰鬥繼承）置入抽牌堆頂部。"
  },
  State_145623_Name = {
    Text = "<Bleesing_Negative:暗藏殺機>"
  },
  State_145624_Name = {Text = "虛弱"},
  State_145625_Name = {
    Text = "2 張相同臨時「症狀卡」"
  },
  State_145628_Desc = {
    Text = "2 回合後獲得「禮物」效果。"
  },
  State_145628_Name = {
    Text = "<Bleesing_Delay:錯失良機>"
  },
  State_145631_Desc = {
    Text = "「打擊」傷害提升 [StateArg1]% 並改為<PVPPunctureDamagewords:穿刺傷害>。"
  },
  State_145631_Name = {Text = "天之隕"},
  State_145632_Desc = {
    Text = "這張牌來自命輪「好運時間」。"
  },
  State_145632_Name = {
    Text = "好運時間"
  },
  State_145638_Name = {
    Text = "殘忍的致意"
  },
  State_145642_Desc = {
    Text = "2 回合後所有喚醒體獲得 [StateArg1] 點狂氣 [Layer] 次。"
  },
  State_145642_Name = {
    Text = "延遲狂氣"
  },
  State_145644_Desc = {
    Text = "2 回合後獲得 <Posse:[StateArg1]> 點銀鑰能量 [Layer] 次。"
  },
  State_145644_Name = {
    Text = "延遲銀鑰能量"
  },
  State_145645_Desc = {
    Text = "2 回合後臨時降低所有敵人 [StateArg1] 點<ExhaustionIconKeywords:力量> [Layer] 次"
  },
  State_145645_Name = {
    Text = "延遲衰竭"
  },
  State_145646_Desc = {
    Text = "2 回合後獲得 [StateArg1] 點算力 [Layer] 次。"
  },
  State_145646_Name = {
    Text = "延遲算力"
  },
  State_145647_Desc = {
    Text = "2 回合後獲得 [StateArg1] 點<PowerIconKeywords:力量> [Layer] 次。"
  },
  State_145647_Name = {
    Text = "延遲力量"
  },
  State_145648_Desc = {
    Text = "2 回合後抽 [StateArg1] 張牌 [Layer] 次。"
  },
  State_145648_Name = {
    Text = "延遲抽牌"
  },
  State_145649_Desc = {
    Text = "2 回合後臨時傷害強效 [StateArg1]％ [Layer] 次。"
  },
  State_145649_Name = {
    Text = "延遲臨時傷害強效"
  },
  State_145654_Desc = {
    Text = "測試。打出後，或脫離手牌後，銷毀。"
  },
  State_145654_Name = {
    Text = "測試。須臾"
  },
  State_145660_Desc = {
    Text = "我方\n1.<AllyPosAwaker1Name:> [DescArg1]\n2.<AllyPosAwaker2Name:> [DescArg2]\n3.<AllyPosAwaker3Name:> [DescArg3]\n4.<AllyPosAwaker4Name:> [DescArg4]\n敵方\n1.<EnemyPosAwaker1Name:> [DescArg5]\n2.<EnemyPosAwaker2Name:> [DescArg6]\n3.<EnemyPosAwaker3Name:> [DescArg7]\n4.<EnemyPosAwaker4Name:> [DescArg8]"
  },
  State_145660_Name = {
    Text = "回溯後生命變化"
  },
  State_145693_Desc = {
    Text = "回合結束後，算力消耗-[Layer]，被棄掉後也會觸發該效果。"
  },
  State_145693_Name = {
    Text = "<PrepareKeypvewordscolour:預備[Layer]>"
  },
  State_145693_WeaponDesc = {
    Text = "卡牌不會在棄牌階段進入棄牌堆，而是保留在手牌中。"
  },
  State_145694_Name = {
    Text = "與黑沼共生"
  },
  State_145698_Desc = {
    Text = "優先攻擊鎖定的<StatusApplier:>，選擇單體目標時僅能選擇鎖定目標，忽略嘲諷和隱匿。"
  },
  State_145698_Name = {Text = "鎖定"},
  State_145699_Desc = {
    Text = "·優先攻擊鎖定的<StatusApplier:>，選擇單體目標時僅能選擇鎖定目標，忽略嘲諷和隱匿。\n·自身死亡後<StatusApplier:>獲得「<PVPDerivativeCardKeywords_32:來戰!>」。"
  },
  State_145699_Name = {Text = "鎖定"},
  State_145709_Desc = {
    Text = "每層提高等同於卡拉布 10% 體質的生命上限，「飽餐」至多積攢 50 層。獲得該狀態時若已到達上限，每超出 1 層則改為回覆 3 倍等量的生命。每場非首領戰至多獲得 10 層「飽餐」。戰鬥結束時不清除。"
  },
  State_145709_Name = {
    Text = "<WormGrowth:飽餐>"
  },
  State_145710_Desc = {
    Text = "你也是賜福的一部分哦~。可被卡拉布狂氣爆發消耗獲得增益，該狀態至多積攢 5 層。戰鬥結束後不清除"
  },
  State_145710_Name = {
    Text = "<SacrificialMark:供奉>"
  },
  State_145901_Name = {
    Text = "回溯後生命變化"
  },
  State_146041_Desc = {
    Text = "該喚醒體感覺脫離了塵世的喧囂。\n·回合結束之前無法進行任何行動，減免99%傷害，若目標沒有抗性則會使目標獲得抗性。\n·效果結束對全體友方其造成 <Damage:[Layer]> 純粹傷害。\n·若施加時目標擁有抗性，則立即結束忽悠且對目標傷害翻倍。"
  },
  State_146043_Desc = {
    Text = "下回合開始時，扣除 [Layer] 狂氣。"
  },
  State_146043_Name = {
    Text = "延遲扣除狂氣"
  },
  State_146058_Desc = {
    Text = "測試過程量，回合開始後或打出卡牌後刷新。當前應有 [Layer]% 攻效。"
  },
  State_146058_Name = {
    Text = "鑰令攻效"
  },
  State_146059_Desc = {
    Text = "測試過程量，回合開始後或打出卡牌後刷新。當前應有 [Layer]% 防效。"
  },
  State_146059_Name = {
    Text = "鑰令防效"
  },
  State_146079_Desc = {
    Text = "此卡牌離開手牌後回到手中。"
  },
  State_146085_Desc = {
    Text = "本回合打出前改變卡牌算力"
  },
  State_146085_Name = {
    Text = "本回合打出前改變卡牌算力"
  },
  State_146085_WeaponDesc = {
    Text = "打出前改變卡牌算力"
  },
  State_146086_Desc = {
    Text = "本回合打出前改變卡牌算力"
  },
  State_146086_Name = {
    Text = "本回合打出前改變卡牌算力"
  },
  State_146086_WeaponDesc = {
    Text = "打出前改變卡牌算力"
  },
  State_146117_Desc = {
    Text = "可被「<DerivativeCardKeywords_157:劍之骨>」消耗獲得增益。該狀態至多積攢 15 層。"
  },
  State_146117_Name = {
    Text = "<Shimieluotanhuodong2:戰意>"
  },
  State_146129_Desc = {
    Text = "所有喚醒體最終傷害 +[Layer]%。"
  },
  State_146129_Name = {
    Text = "鯨天殺意"
  },
  State_146147_Desc = {
    Text = "可被「<DerivativeCardKeywords_157:劍之骨>」消耗獲得增益。該狀態至多積攢 15 層。"
  },
  State_146147_Name = {
    Text = "<Shimieluotanhuodong1:戰意>"
  },
  State_146154_Desc = {
    Text = "讓該喚醒體感覺良好，其會有「技能」被變化為「賜福？」，變化後消耗等量層數。"
  },
  State_146154_Name = {
    Text = "<PVPBlessColour:賜福>"
  },
  State_146155_Desc = {
    Text = "該喚醒體感覺良好。\n·接下來會有 [Layer] 張「技能」被變化為「賜福？」，變化後消耗等量層數。"
  },
  State_146155_Name = {Text = "賜福"},
  State_146202_Desc = {
    Text = "讓該喚醒體感覺脫離了塵世的喧囂。\n·回合結束之前無法進行任何行動，減免99%傷害，若目標沒有抗性則會使目標獲得抗性。\n·效果結束對全體友方其造成等量層數純粹傷害。\n·若施加時目標擁有抗性，則立即結束忽悠且對目標傷害翻倍。"
  },
  State_146352_Desc = {
    Text = "每受到 1 次傷害，積攢 [StateArg1] 層<Shimieluotanhuodong1:戰意>"
  },
  State_146352_Name = {
    Text = "愈戰愈勇"
  },
  State_146363_Desc = {
    Text = "下回合開始時，移除 [Layer] 生命。損失生命時減少等量此狀態層數。"
  },
  State_146363_Name = {
    Text = "並非謊言之物"
  },
  State_146383_Desc = {
    Text = "添加狀態後，打出卡牌後，刷新並打印各喚醒體的銀鑰充能等級。"
  },
  State_146385_Desc = {
    Text = "添加狀態後，打出卡牌後，刷新並打印各喚醒體的銀鑰充能等級。"
  },
  State_146385_Name = {
    Text = "等級入口"
  },
  State_146386_Name = {Text = "等級值"},
  State_146446_Desc = {
    Text = "喚醒體防禦力，P1：[StateArg1]，P2：[StateArg2]，P3：[StateArg3]，P4：[StateArg4]。"
  },
  State_146446_Name = {
    Text = "防禦屬性清單"
  },
  State_146448_Desc = {
    Text = "喚醒體攻擊力，P1：力[StateArg1]強度[StateArg2]，P2：力[StateArg3]強度[StateArg4]，P3：力[StateArg5]強度[StateArg6]，P4：力[StateArg7]強度[StateArg8]。"
  },
  State_146448_Name = {
    Text = "攻擊屬性清單"
  },
  State_146452_Desc = {
    Text = "隊伍唯一：裝備者「打擊」暴擊傷害提高 <WeaponEffect_Num:[StateArg1]%>。回合結束時裝備者下次狂氣爆發暴擊傷害提高，提高百分比等同於其基礎狂氣的 <WeaponEffect_Num:[StateArg2]%>，至多疊加 5 次。"
  },
  State_146452_WeaponDesc = {
    Text = "裝備者「打擊」暴擊傷害提升 <WeaponEffect_Num:[StateArg1]%>。回合結束時裝備者下次狂氣爆發暴擊傷害提升 <WeaponEffect_Num:[DescArg1]%>，至多疊加 5 次（當前享受 [DescArg2]％）。"
  },
  State_146456_Desc = {
    Text = "隊伍唯一：裝備者「打擊」暴擊傷害提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_146456_WeaponDesc = {
    Text = "裝備者「打擊」暴擊傷害提升 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_146534_Desc = {
    Text = "關卡開始後，將原初混沌各機制的容器添加給守密人。"
  },
  State_146535_Desc = {
    Text = "屬性容器。"
  },
  State_146535_Name = {
    Text = "原初混沌標識"
  },
  State_146536_Desc = {
    Text = "機制容器。"
  },
  State_146536_Name = {
    Text = "原初混沌機制"
  },
  State_146644_Desc = {
    Text = "靈知覺醒獲得預備1，每回合首次打出時自動釋放攜帶鑰令。"
  },
  State_146644_Name = {
    Text = "原初回響"
  },
  State_146645_Desc = {
    Text = "新混沌界域每回合首次打出靈知覺醒時自動釋放攜帶鑰令。當前可用。"
  },
  State_146645_Name = {
    Text = "可用標識"
  },
  State_146646_Desc = {
    Text = "基礎銀鑰能量上限改為 2000。獲得銀鑰能量的規則替換為：喚醒體每回合首次打出指令卡時，獲得 3 倍銀鑰充能+ 100 的銀鑰能量。"
  },
  State_146646_Name = {
    Text = "新混沌鑰能規則"
  },
  State_146651_Desc = {
    Text = "提高本喚醒體的攻擊力屬性 [Layer]%。"
  },
  State_146651_Name = {
    Text = "混沌·攻擊"
  },
  State_146652_Desc = {
    Text = "戰鬥開始後僅1次，將各喚醒體的銀鑰充能效率改為銀鑰充能等級的均值。"
  },
  State_146652_Name = {
    Text = "原初均衡__「僅開發用」"
  },
  State_146653_Desc = {
    Text = "提高本喚醒體的防禦力屬性 [Layer]%。"
  },
  State_146653_Name = {
    Text = "混沌·防禦"
  },
  State_146663_Desc = {
    Text = "下 [Layer] 張蝕滅·蘿坦的「打擊」額外生效 1 次。"
  },
  State_146663_Name = {
    Text = "噬鯨的風暴"
  },
  State_147058_Name = {
    Text = "飾品36室之環"
  },
  State_147079_Desc = {
    Text = "此卡無法棄置、無法變化。"
  },
  State_147079_Name = {
    Text = "<RetainIconKeywordsColour:強制保留>"
  },
  State_147545_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：未配置"
  },
  State_147545_Name = {
    Text = "暮星·汀克特SR（臨時文本）"
  },
  State_147546_Name = {Text = "廢棄"},
  State_147584_Desc = {
    Text = "下一張打出的<DerivativeCardKeywords_152:「仙女恩賜」>的<Blessing:恩賜>效果提高 50%"
  },
  State_147737_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [StateArg1] <MaxHPKeywords:最大生命值>。回合開始時，對全體敵方造成 <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:出血>傷害，"
  },
  State_147737_Name = {
    Text = "從黑暗到黑暗"
  },
  State_147764_Name = {
    Text = "狀態@卡拉布活動選錯計數"
  },
  State_147765_Desc = {
    Text = "下回合開始時失去 2 點算力並少抽2張牌。"
  },
  State_147765_Name = {
    Text = "皇家瑪麗巧克力"
  },
  State_147768_Desc = {
    Text = "下回合開始時獲得 [DescArg1] 張高級靈感。"
  },
  State_147768_Name = {
    Text = "皇家瑪麗金幣"
  },
  State_147769_Desc = {
    Text = "本場戰鬥「飽餐」當前已疊加 [Layer] 層。"
  },
  State_147769_Name = {
    Text = "疊層限制"
  },
  State_147772_Name = {
    Text = "狀態@卡拉布活動添加臨時鑰能上限"
  },
  State_147773_Name = {
    Text = "狀態@卡拉布活動添加臨時鑰能上限"
  },
  State_147774_Name = {
    Text = "狀態@卡拉布活動添加臨時鑰能上限_普通混沌"
  },
  State_147797_Desc = {
    Text = "可能獲得或失去狂氣、<PowerIconKeywords:力量>、生命值、銀鑰能量和算力與抽牌。"
  },
  State_147797_Name = {
    Text = "皇家瑪麗巧克力"
  },
  State_147800_Desc = {
    Text = "下回合開始時失去 2 點算力並少抽2張牌。"
  },
  State_147800_Name = {
    Text = "皇家瑪麗巧克力"
  },
  State_147869_Name = {
    Text = "抽 [Layer] 張牌"
  },
  State_147870_Name = {
    Text = "對所有敵人造成 [Layer] 回合虛弱"
  },
  State_147871_Name = {
    Text = "獲得 [Energy:DescArg1] 點狂氣"
  },
  State_147872_Name = {
    Text = "對所有敵人造成 [Layer] 回合易傷"
  },
  State_147873_Name = {
    Text = "獲得 [Layer] 算力"
  },
  State_147874_Name = {
    Text = "獲得 [Block:DescArg1] 護盾"
  },
  State_147962_Desc = {
    Text = "此後玩家打出「<DerivativeCardKeywords_158:代罪>」時只驅散 50%<MonsterSinMarkKeywords:罪印>層數，並且每打出 1 張指令卡「聖子·白夜」獲得 1 層<MonsterSinMarkKeywords:罪印>。"
  },
  State_147962_Name = {
    Text = "淨世之路"
  },
  State_147967_Desc = {
    Text = "「聖子·白夜」造成的傷害附加 [DescArg1]% 的<BleedingIconKeywords:出血>。"
  },
  State_147968_Desc = {
    Text = "上限 3 層，當切換至攻擊意圖時，使「聖子·白夜」造成的傷害提高 25%並消耗 1 層。"
  },
  State_147968_Name = {
    Text = "苦痛救贖"
  },
  State_147969_Desc = {
    Text = "當「聖子·白夜」處於「聖心」意圖時，每打出 1 張指令卡積攢 2 層<MonsterPolluxFever:狂熱>。"
  },
  State_147969_Name = {
    Text = "神啟新約"
  },
  State_147971_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會回復生命並獲得 1 層<InvincibleUntilRoused:銀芯固化>，覺醒後清除<InvincibleUntilRoused:銀芯固化>並以真正的形態開始戰鬥。"
  },
  State_147971_Name = {
    Text = "尚未覺醒"
  },
  State_147972_Desc = {
    Text = "每層使「聖子·白夜」造成的傷害附加 1% <BleedingIconKeywords:出血>。"
  },
  State_147974_Desc = {
    Text = "回合開始後清除。達到 10 層後，下次打出卡牌後立刻行動，移除狂熱並將意圖切換為「聖心」。"
  },
  State_147974_Name = {
    Text = "臨時狂熱"
  },
  State_147975_Desc = {
    Text = "戰鬥開始時，將一張「<DerivativeCardKeywords_158:代罪>」置入手牌，回合結束後，獲得 5 層<MonsterSinMarkKeywords:罪印>。"
  },
  State_147975_Name = {
    Text = "持燈神使"
  },
  State_147993_Desc = {
    Text = "上限 3 層，當切換至攻擊意圖時，使「聖子·白夜」造成的傷害提高 25%並消耗 1 層。"
  },
  State_147993_Name = {
    Text = "苦痛救贖"
  },
  State_148020_Desc = {
    Text = "免疫一切傷害且無法失去生命，覺醒後移除。"
  },
  State_148020_Name = {
    Text = "銀芯固化"
  },
  State_148021_Name = {
    Text = "狀態@怪物通用復活覺醒前免疫清除標識"
  },
  State_148073_Name = {
    Text = "抽 1 張牌"
  },
  State_148074_Desc = {
    Text = "卡牌不會在棄牌階段進入棄牌堆，而是保留在手牌中。"
  },
  State_148074_WeaponDesc = {
    Text = "卡牌不會在棄牌階段進入棄牌堆，而是保留在手牌中。"
  },
  State_148076_Name = {
    Text = "淨世之路出牌監聽"
  },
  State_148116_Desc = {
    Text = "1 回合後抽 [StateArg1] 張牌 [Layer] 次。"
  },
  State_148116_Name = {
    Text = "延遲抽牌1"
  },
  State_148381_Desc = {
    Text = "直到回合結束，自身造成傷害附加 100%<BleedingIconKeywords:出血>。"
  },
  State_148383_Desc = {
    Text = "上限 3 層。若擁有 3 層「恨意」，下一次意圖切換至「鮮血鏈條」時，將意圖切換為「嗜血鏈球」並清除「恨意」。"
  },
  State_148385_Desc = {
    Text = "每當敵方打出指令卡時獲得 2 層<MonsterB05EXFever:臨時狂熱>。"
  },
  State_148385_Name = {
    Text = "不規則形態"
  },
  State_148386_Desc = {
    Text = "無法獲得護盾，直到回合結束。"
  },
  State_148386_Name = {
    Text = "縛身鎖鏈"
  },
  State_148387_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會回復生命並獲得 1 層<InvincibleUntilRoused:銀芯固化>，覺醒後清除<InvincibleUntilRoused:銀芯固化>並以真正的形態開始戰鬥。"
  },
  State_148387_Name = {
    Text = "尚未覺醒"
  },
  State_148391_Desc = {
    Text = "直到回合結束，自身造成傷害附加 100%<BleedingIconKeywords:出血>。"
  },
  State_148391_Name = {
    Text = "縛身鎖鏈"
  },
  State_148392_Desc = {
    Text = "回合開始後清除。達到 10 層後，下次打出卡牌後立刻行動，移除狂熱並將意圖切換為「鮮血鏈條」。"
  },
  State_148392_Name = {
    Text = "臨時狂熱"
  },
  State_148394_Desc = {
    Text = "回合開始時獲得 1 層<ResentChainsKeywords:怨恨鎖鏈>。 意圖切換至「嗜血鏈球」時，直到敵方回合結束後免疫一切傷害和生命損失效果。"
  },
  State_148395_Desc = {
    Text = "免疫一切傷害（包括穿刺傷害）且無法失去生命，敵方回合結束後移除。"
  },
  State_148395_Name = {
    Text = "索魂者宣言-嗜血鏈球"
  },
  State_148421_Desc = {
    Text = "1 回合後臨時降低所有敵人 [StateArg1] 點<ExhaustionIconKeywords:力量> [Layer] 次"
  },
  State_148421_Name = {
    Text = "延遲衰竭1"
  },
  State_148422_Desc = {
    Text = "1 回合後臨時傷害強效 [StateArg1]% [Layer] 次。"
  },
  State_148422_Name = {
    Text = "延遲臨時傷害強效1"
  },
  State_148423_Desc = {
    Text = "1 回合後獲得 <Posse:[StateArg1]> 點銀鑰能量 [Layer] 次。"
  },
  State_148423_Name = {
    Text = "延遲銀鑰能量1"
  },
  State_148426_Desc = {
    Text = "1 回合後獲得 [StateArg1] 點算力 [Layer] 次。"
  },
  State_148426_Name = {
    Text = "延遲算力1"
  },
  State_148427_Desc = {
    Text = "1 回合後所有喚醒體獲得 [StateArg1] 點狂氣 [Layer] 次。"
  },
  State_148427_Name = {
    Text = "延遲狂氣1"
  },
  State_148428_Desc = {
    Text = "1 回合後獲得 [StateArg1] 點<PowerIconKeywords:力量> [Layer] 次。"
  },
  State_148428_Name = {
    Text = "延遲力量1"
  },
  State_148511_Desc = {
    Text = "隊伍唯一：探索開始後，將 1 張<Backupbody[StateArg3]:「魂靈同調」>加入牌庫。「魂靈同調」：算力消耗 0，打出後獲得 1 點算力。<RetainIconKeywords:保留>：積攢裝備者體質 <WeaponEffect_Num:[StateArg1]％> 的固定生命回覆量與 <WeaponEffect_Num:[StateArg2]> 點固定狂氣在此卡牌中。若此卡未被銷毀，可免疫一次死亡並釋放所有積攢的生命回覆量和狂氣，之後<DestructionKeywords:銷毀>此卡牌。"
  },
  State_148511_Name = {
    Text = "魂靈同調"
  },
  State_148511_WeaponDesc = {
    Text = "探索開始後，將 1 張<Backupbody[StateArg3]:「魂靈同調」>加入牌庫。「魂靈同調」：算力消耗 0，打出後獲得 1 點算力。<RetainIconKeywords:保留>：積攢裝備者體質 <WeaponEffect_Num:[StateArg1]％> 的固定生命回覆量與 <WeaponEffect_Num:[StateArg2]> 點固定狂氣在此卡牌中。若此卡未被銷毀，可免疫一次死亡並釋放所有積攢的生命回覆量和狂氣，之後<DestructionKeywords:銷毀>此卡牌。"
  },
  State_148513_Desc = {
    Text = "對方回合結束不會丟棄手牌。 回合結束時依次施加 2 層<FragileIconKeywords: 脆弱>、 <WeaknessIconKeywords:虛弱>、<HeavyInjuryKeywords:重創>、<VulnerabilityIconKeywords:易傷>狀態。"
  },
  State_148520_Desc = {
    Text = "無法獲得護盾，直到回合結束。"
  },
  State_148522_Desc = {
    Text = "隊伍唯一：裝備者「狂氣爆發」造成的護盾和力量提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_148524_Desc = {
    Text = "隊伍唯一：裝備者「狂氣爆發」造成的護盾和力量提高 <WeaponEffect_Num:[StateArg1]%>。裝備者「防禦」造成的護盾提高<WeaponEffect_Num:[StateArg2]%>。裝備者打出「防禦」後獲得裝備者攻擊力 <WeaponEffect_Num:[StateArg3]%> 的力量。"
  },
  State_148540_Desc = {
    Text = "延遲[Layer] ：<AwakerName:[DescArg1]> 算力最高的 [StateArg1] 張指令卡算力消耗降低 [StateArg2]。"
  },
  State_148540_Name = {
    Text = "預見之鏡 – 延遲[Layer]"
  },
  State_148541_Name = {
    Text = "移除手中選擇喚醒體卡牌的「遲緩」效果"
  },
  State_148544_Desc = {
    Text = "延遲[Layer] ：<AwakerName:[DescArg1]> 下次狂氣爆發每消耗 1 點狂氣就獲得 [StateArg1] 點銀鑰能量。"
  },
  State_148544_Name = {
    Text = "惡魔之鑰 – 延遲[Layer]"
  },
  State_148547_Desc = {
    Text = "<AwakerName:[DescArg1]> 下次狂氣爆發視為超限爆發，若已為超限爆發則返還 100% 基礎狂氣。"
  },
  State_148547_Name = {
    Text = "永恆之冠"
  },
  State_148548_Desc = {
    Text = "保留：所有喚醒體獲得 5 點狂氣。"
  },
  State_148548_Name = {
    Text = "斂入倒影"
  },
  State_148549_Name = {
    Text = "觸發手中所有「預備」效果"
  },
  State_148553_Desc = {
    Text = "延遲[Layer] ：<AwakerName:[DescArg1]> 打出的下 [Layer] 張指令卡獲得等同於 [StateArg2]％ 已損失生命的護盾。"
  },
  State_148553_Name = {
    Text = "引誘之果 – 延遲[Layer]"
  },
  State_148554_Desc = {
    Text = "<AwakerName:[DescArg1]> 指令卡造成的傷害附加 [Layer]％ 出血。"
  },
  State_148554_Name = {
    Text = "必滅之眼"
  },
  State_148556_Desc = {
    Text = "位於手中時，所有喚醒體造成主動傷害時附加 10％ 出血。"
  },
  State_148556_Name = {
    Text = "噩夢如期而至"
  },
  State_148557_Desc = {
    Text = "<AwakerName:[DescArg1]> 打出的下 [Layer] 張指令卡獲得等同於 [StateArg1]％ 已損失生命的護盾。"
  },
  State_148557_Name = {
    Text = "引誘之果"
  },
  State_148559_Desc = {
    Text = "<AwakerName:[DescArg1]> 下次狂氣爆發每消耗 1 點狂氣就獲得 [Layer] 點銀鑰能量。"
  },
  State_148559_Name = {
    Text = "惡魔之鑰"
  },
  State_148561_Desc = {
    Text = "此卡打出時，從以下三個負面效果中隨機觸發一個：效果降低 50％/延遲 2 回合生效/隨機獲得 1 個負面效果。"
  },
  State_148561_Name = {
    Text = "<ExclamationPointColour:扭曲心願>"
  },
  State_148562_Name = {
    Text = "選擇的喚醒體獲得 10 點狂氣"
  },
  State_148563_Desc = {
    Text = "延遲[Layer] ：<AwakerName:[DescArg1]> 下次狂氣爆發獲得的護盾和生命回復提高 [StateArg1]％。"
  },
  State_148563_Name = {
    Text = "公正之羽 – 延遲[Layer]"
  },
  State_148566_Desc = {
    Text = "<AwakerName:[DescArg1]> 下次狂氣爆發造成的傷害附加 [Layer]％ 命運裁斷。"
  },
  State_148566_Name = {
    Text = "命運之絲"
  },
  State_148569_Desc = {
    Text = "<AwakerName:[DescArg1]> 下次狂氣爆發獲得的護盾和生命回復提高 [Layer]％。"
  },
  State_148571_Desc = {
    Text = "延遲[Layer] ：<AwakerName:[DescArg1]> 指令卡造成的傷害附加 [StateArg1]％ 出血。"
  },
  State_148571_Name = {
    Text = "必滅之眼 – 延遲[Layer]"
  },
  State_148574_Desc = {
    Text = "延遲[Layer] ：<AwakerName:[DescArg1]> 下次狂氣爆發造成的傷害附加 [StateArg1]％ 命運裁斷。"
  },
  State_148574_Name = {
    Text = "命運之絲 – 延遲[Layer]"
  },
  State_148575_Name = {
    Text = "選擇的喚醒體獲得 20 點狂氣"
  },
  State_149089_Name = {
    Text = "狀態@提燈犬小吞食狂氣標識"
  },
  State_149092_Desc = {
    Text = "吞食了「<AwakerName:[DescArg1]>」 <Energy:[Energy:DescArg2]> 點狂氣，死亡後返還。"
  },
  State_149094_Desc = {
    Text = "隊伍唯一：裝備者狂氣爆發造成基礎的護盾提高 <WeaponEffect_Num:[StateArg1]%>。裝備者打出造成<WeaknessIconKeywords:虛弱>的指令卡後，使下一張裝備者指令卡造成的基礎護盾提高 <WeaponEffect_Num:[StateArg1]%>。使用「猩紅熔爐」時抽一張裝備者算力消耗最高的技能卡，<EmbryoFusionIconKeywords:胚胎融合> +<WeaponEffect_Num: [StateArg1]>，3 回合冷卻。"
  },
  State_149094_WeaponDesc = {
    Text = "裝備者狂氣爆發造成基礎的護盾提高 <WeaponEffect_Num:[StateArg1]%>。裝備者打出造成<WeaknessIconKeywords:虛弱>的指令卡後，使下一張裝備者指令卡造成的基礎護盾提高 <WeaponEffect_Num:[StateArg1]%>。使用「猩紅熔爐」時抽一張裝備者算力消耗最高的技能卡，<EmbryoFusionIconKeywords:胚胎融合> +<WeaponEffect_Num: [StateArg1]>，3 回合冷卻。"
  },
  State_149122_Desc = {
    Text = "死亡後立刻召喚一名隨機的「哈提獵群」或「斯庫爾獵群」，使其「集群效應」降低 1 層。"
  },
  State_149122_Name = {
    Text = "集群效應"
  },
  State_149123_Desc = {
    Text = "受到狂氣爆發的傷害降低 50%。"
  },
  State_149123_Name = {
    Text = "燈芯化·熔"
  },
  State_149124_Desc = {
    Text = "受到指令卡的傷害降低 50%。"
  },
  State_149124_Name = {
    Text = "燈芯化·影"
  },
  State_149125_Desc = {
    Text = "凍結了「<AwakerName:[DescArg1]>」的指令卡，死亡後解除該喚醒體的凍結。"
  },
  State_149126_Desc = {
    Text = "死亡後立刻召喚一名隨機的「斯庫爾獵群」，使其「集群效應」降低 1 層。"
  },
  State_149126_Name = {
    Text = "集群效應"
  },
  State_149128_Name = {
    Text = "狀態@冰雪提燈犬小凍結卡牌標識"
  },
  State_149140_Desc = {
    Text = "會使敵人的技能得到增幅。每當受到傷害時失去一層。"
  },
  State_149143_Desc = {
    Text = "抽牌階段結束後，敵方手中每有 [DescArg1] 張<SlowIconKeywords:遲緩>指令卡，就使自身獲得 [DescArg2] 層<BloodOath_New:血誓>。自身造成未被格擋的傷害後隨機為手牌或抽牌堆中 [DescArg3] 張未被<SlowIconKeywords:遲緩>的指令卡施加 [DescArg4] 層<SlowIconKeywords:遲緩>。"
  },
  State_149143_Name = {
    Text = "凝滯血誓"
  },
  State_149162_Desc = {
    Text = "造成未被格擋的傷害時，移除死亡抵抗"
  },
  State_149162_Name = {
    Text = "極東巫術"
  },
  State_149163_Desc = {
    Text = "最大生命值降低等量層數，戰鬥結束後減半。"
  },
  State_149164_Desc = {
    Text = "造成傷害施加刺骨"
  },
  State_149167_Desc = {
    Text = "最大生命值降低 [Layer] ，戰鬥結束後減半。"
  },
  State_149167_Name = {
    Text = "<BoneHitKeywords:刺骨>"
  },
  State_149169_Desc = {
    Text = "每層提高等同於卡拉布 15% 體質的生命上限，「飽餐」至多積攢 50 層。獲得該狀態時若已到達上限，每超出 1 層則改為回覆 3 倍等量的生命。每場非首領戰至多獲得 10 層「飽餐」。戰鬥結束時不清除。"
  },
  State_149169_Name = {
    Text = "<WormGrowth:飽餐>"
  },
  State_149172_Desc = {
    Text = "隊伍唯一：裝備者打出造成<WeaknessIconKeywords:虛弱>的指令卡後，使下一張裝備者的指令卡造成的基礎護盾提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_149172_WeaponDesc = {
    Text = "裝備者打出造成<WeaknessIconKeywords:虛弱>的指令卡後，使下一張裝備者的指令卡造成的基礎護盾提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_149187_Desc = {
    Text = "測試｜監聽受到固定傷害後、固定傷害造成擊殺後，並打印觸發值、關聯者。"
  },
  State_149187_Name = {
    Text = "測試固定傷害"
  },
  State_149188_Desc = {
    Text = "測試｜固定傷害造成擊殺後，觸發值1，擊殺實際傷害：[Layer]"
  },
  State_149188_Name = {
    Text = "測試固殺觸發值2"
  },
  State_149189_Desc = {
    Text = "測試｜固定傷害造成擊殺後，關聯者2，造成擊殺的來源：[Layer]"
  },
  State_149189_Name = {
    Text = "測試固殺關聯者2"
  },
  State_149190_Desc = {
    Text = "測試｜固定傷害造成擊殺後，觸發值1，擊殺溢出傷害：[Layer]"
  },
  State_149190_Name = {
    Text = "測試固殺觸發值3"
  },
  State_149191_Desc = {
    Text = "測試｜受到固定傷害後，觸發值1，總傷害：[Layer]"
  },
  State_149191_Name = {
    Text = "測試固傷觸發值1"
  },
  State_149192_Desc = {
    Text = "測試｜固定傷害造成擊殺後，關聯者1，被擊殺者：[Layer]"
  },
  State_149192_Name = {
    Text = "測試固殺關聯者1"
  },
  State_149193_Desc = {
    Text = "測試｜受到固定傷害後，關聯者2，受擊者：[Layer]"
  },
  State_149193_Name = {
    Text = "測試固傷關聯者2"
  },
  State_149194_Desc = {
    Text = "測試｜受到固定傷害後，觸發值1，總傷害：[Layer]"
  },
  State_149194_Name = {
    Text = "測試固傷觸發值2"
  },
  State_149195_Desc = {
    Text = "測試｜固定傷害造成擊殺後，觸發值1，擊殺總傷害：[Layer]"
  },
  State_149195_Name = {
    Text = "測試固殺觸發值1"
  },
  State_149196_Desc = {
    Text = "測試｜受到固定傷害後，關聯者1，傷害來源：[Layer]"
  },
  State_149196_Name = {
    Text = "測試固傷關聯者1"
  },
  State_149227_Desc = {
    Text = "回合結束時護盾不會消失。擁有護盾時受到狂氣爆發傷害提高 50％，受到指令卡的傷害降低 50％。"
  },
  State_149227_Name = {
    Text = "雪幕隱蹤"
  },
  State_149228_Desc = {
    Text = "造成傷害施加出血"
  },
  State_149229_Desc = {
    Text = "出場時失去 25% 最大生命值，轉化為 [DescArg1]% 失去值的「霜盾」。"
  },
  State_149229_Name = {
    Text = "霜盾轉化"
  },
  State_149230_Desc = {
    Text = "受到指令卡傷害提高 50％，受到狂氣爆發傷害降低 50％。"
  },
  State_149230_Name = {
    Text = "狀態@黯色外衣增減傷"
  },
  State_149232_Desc = {
    Text = "回合結束時護盾不會消失。擁有護盾時受到指令卡傷害提高 50％，受到狂氣爆發傷害降低 50％。"
  },
  State_149232_Name = {
    Text = "黯影隱蹤"
  },
  State_149233_Desc = {
    Text = "受到狂氣爆發傷害提高 50％，受到指令卡傷害降低 50％。"
  },
  State_149233_Name = {
    Text = "狀態@雪色外衣增減傷"
  },
  State_149234_Desc = {
    Text = "出場時失去 25％ 最大生命值，轉化為 [DescArg1]％ 失去值的「咒盾」。"
  },
  State_149234_Name = {
    Text = "咒盾轉化"
  },
  State_149235_Desc = {
    Text = "造成未被格擋的傷害時，移除死亡抵抗"
  },
  State_149235_Name = {
    Text = "提燈巫術"
  },
  State_149250_Desc = {
    Text = "承受指令卡傷害+50%"
  },
  State_149250_Name = {
    Text = "承受指令卡傷害+50%"
  },
  State_149251_Desc = {
    Text = "承受指令卡傷害-50%"
  },
  State_149251_Name = {
    Text = "承受指令卡傷害-50%"
  },
  State_149252_Desc = {
    Text = "受到的狂氣爆發傷害-50%"
  },
  State_149252_Name = {
    Text = "受到的狂氣爆發傷害-50%"
  },
  State_149253_Desc = {
    Text = "受到的狂氣爆發傷害+50%"
  },
  State_149253_Name = {
    Text = "受到的狂氣爆發傷害+50%"
  },
  State_149265_Desc = {
    Text = "死亡後立刻召喚一名隨機的「溫迪戈」，使其「集群效應」降低 1 層。"
  },
  State_149265_Name = {
    Text = "集群效應"
  },
  State_149268_Desc = {
    Text = "失去所有護盾時，獲得 75 層臨時加固並移除 1 層「沒入風雪」，將意圖替換為會施加<BoneHitKeywords:刺骨>的強力攻擊。"
  },
  State_149268_Name = {
    Text = "沒入風雪"
  },
  State_149269_Desc = {
    Text = "失去所有護盾時，獲得 75 層臨時加固並移除 1 層「沒入暗影」，將意圖替換為會奪取狂氣的強力攻擊。"
  },
  State_149269_Name = {
    Text = "沒入暗影"
  },
  State_149270_Desc = {
    Text = "死亡後立刻召喚一名隨機的「溫迪戈」，使其「集群效應」降低 1 層。"
  },
  State_149270_Name = {
    Text = "集群效應"
  },
  State_149308_Name = {
    Text = "狀態@提燈祈禱者遲緩層數記錄"
  },
  State_149391_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會回復生命並獲得 1 層<InvincibleUntilRoused:銀芯固化>，覺醒後清除<InvincibleUntilRoused:銀芯固化>並以真正的形態開始戰鬥。"
  },
  State_149391_Name = {
    Text = "尚未覺醒"
  },
  State_149398_Desc = {
    Text = "「白雪仙女」意圖切換至「粉雪魔咒」時消耗 1 層，將意圖變化為「奇蹟賜福」。"
  },
  State_149398_Name = {Text = "飽餐"},
  State_149399_Desc = {
    Text = "「白雪仙女」釋放「童話天衣無縫」後下 [DescArg1] 個意圖均為「粉雪魔咒」。每回合將 [DescArg2] 張具有 [DescArg3] 層<SlowIconKeywords:遲緩>的隨機<Blessing:賜福>洗入牌庫。"
  },
  State_149399_Name = {
    Text = "誘人蜜果"
  },
  State_149418_Desc = {
    Text = "無法暴擊，不視為基礎傷害，且不受最終傷害等加成影響。"
  },
  State_149418_Name = {
    Text = "<RealDamage:固定傷害>"
  },
  State_149419_Name = {
    Text = "<Rune_6:鐵壁>"
  },
  State_149421_Name = {
    Text = "<Rune_15:爆發>"
  },
  State_149422_Name = {
    Text = "<Rune_4:籌算>"
  },
  State_149423_Name = {
    Text = "<Rune_11:統御>"
  },
  State_149425_Name = {
    Text = "<Rune_1:易傷>"
  },
  State_149426_Name = {
    Text = "<Rune_14:蠻力>"
  },
  State_149427_Name = {
    Text = "<Rune_2:虛弱>"
  },
  State_149576_Desc = {
    Text = "「白雪仙女」意圖切換至「粉雪魔咒」時消耗 1 層，將意圖變化為「奇蹟賜福」。"
  },
  State_149576_Name = {Text = "飽餐"},
  State_149618_Desc = {
    Text = "2 回合後，觸發以下效果：\n獲得 [DescArg1] 點算力。 \n獲得 [DescArg2] 點力量。 \n獲得 [DescArg3] 點銀鑰能量。 \n獲得 [DescArg5] 點狂氣。 \n抽 [DescArg6] 張牌。\n獲得 [DescArg7] 點臨時傷害強效。\n使所有敵人臨時降低 [DescArg4] 點力量。"
  },
  State_149618_Name = {
    Text = "錯失良機2"
  },
  State_149619_Desc = {
    Text = "1 回合後，觸發以下效果：\n獲得 [DescArg1] 點算力。 \n獲得 [DescArg2] 點力量。 \n獲得 [DescArg3] 點銀鑰能量。 \n獲得 [DescArg5] 點狂氣。 \n抽 [DescArg6] 張牌。\n獲得 [DescArg7] 點臨時傷害強效。\n使所有敵人臨時降低 [DescArg4] 點力量。"
  },
  State_149619_Name = {
    Text = "錯失良機1"
  },
  State_149628_Desc = {
    Text = "若回合結束前敵方擁有至少 1000 點銀鑰能量，吞噬 1000 銀鑰能量。"
  },
  State_149628_Name = {
    Text = "供奉鑰能"
  },
  State_149629_Desc = {
    Text = "若回合結束前狂氣最高喚醒體擁有至少 100 點狂氣，吞噬其 50 點狂氣。"
  },
  State_149629_Name = {
    Text = "供奉狂氣"
  },
  State_149630_Desc = {
    Text = "若回合結束前敵方擁有至少 1000 點銀鑰能量，吞噬 1000 銀鑰能量。"
  },
  State_149630_Name = {
    Text = "供奉鑰能"
  },
  State_149631_Desc = {
    Text = "若回合結束前敵方擁有至少 3 點算力，吞噬 3 點算力。"
  },
  State_149632_Desc = {
    Text = "若回合結束前敵方擁有至少 3 點算力，吞噬 3 點算力。"
  },
  State_149633_Desc = {
    Text = "若棄牌階段前敵方手牌中剩餘至少 4 張指令卡，吞噬隨機 2 張指令卡。"
  },
  State_149634_Desc = {
    Text = "若棄牌階段前敵方手牌中剩餘至少 4 張指令卡，吞噬隨機 2 張指令卡。"
  },
  State_149635_Desc = {
    Text = "若回合結束前狂氣最高喚醒體擁有至少 100 點狂氣，吞噬其 50 點狂氣。"
  },
  State_149635_Name = {
    Text = "供奉狂氣"
  },
  State_149652_Desc = {
    Text = "無法暴擊，不視為對應喚醒體造成的傷害。"
  },
  State_149652_Name = {
    Text = "<FixedDamage:純粹傷害>"
  },
  State_149660_Desc = {
    Text = "此卡牌造成的傷害、護盾、力量變化提高 [DescArg2]％，觸腕傷害、生命回覆、固定中毒、固定反擊的最終效果提高 [DescArg1]%，打出後移除。"
  },
  State_149660_Name = {
    Text = "強化 [DescArg1]"
  },
  State_149664_Desc = {
    Text = "每擁有 1 層使該卡牌造成的傷害、固定力量和觸腕傷害提高、固定中毒、固定反擊最終效果提高 2%；固定護盾、固定生命回覆、力量降低的最終效果提高 1%，打出後移除。"
  },
  State_149664_Name = {Text = "強化"},
  State_149719_Name = {
    Text = "免疫PVP純粹傷害__「僅開發用」"
  },
  State_149736_Desc = {
    Text = "下 [Layer] 張<AwakerName:[DescArg1]>指令卡造成的基礎護盾提高 [StateArg1]%。"
  },
  State_149736_Name = {
    Text = "蜜果的謊言"
  },
  State_149744_Desc = {
    Text = "下 [Layer] 張打出的賜福不會觸發負面效果"
  },
  State_149744_Name = {
    Text = "仙女護佑"
  },
  State_149772_Desc = {
    Text = "每次受到主動傷害就使所有喚醒體失去 3 狂氣，每回合最多生效 5 次。擊破護盾後移除「咒盾」狀態。"
  },
  State_149773_Desc = {
    Text = "每次受到主動傷害就給予手牌中隨機卡牌一層臨時「遲緩」，每回合最多生效 5 次。擊破護盾後移除「霜盾」狀態。"
  },
  State_149782_Desc = {
    Text = "消耗：下回合抽牌後，將 1 張「萬化之果」洗入抽牌堆。"
  },
  State_149782_Name = {
    Text = "萬化之果"
  },
  State_149787_Desc = {
    Text = "每擁有 1 層，負誓·奧吉爾的指令卡最終傷害提高  [DescArg2]%，回合開始時抽牌數-1，暴擊傷害提高 [DescArg3]%，上限 [DescArg1] 層，戰鬥結束時不清除。"
  },
  State_149787_Name = {
    Text = "<KuangNu:暗涌>"
  },
  State_149788_Desc = {
    Text = "打出負誓·奧吉爾的「技能」時，消耗 1 層抽 1 張「防禦」，在下次打出前獲得保留，上限 [DescArg1] 層，戰鬥結束時不清除。"
  },
  State_149788_Name = {
    Text = "<ShuZui:自罪>"
  },
  State_149789_Desc = {
    Text = "每擁有 1 層，負誓·奧吉爾的指令卡最終傷害提高 33%，回合開始時抽牌數-1，上限 [DescArg1] 層，戰鬥結束時不清除。"
  },
  State_149790_Desc = {
    Text = "每擁有 1 層，負誓·奧吉爾的指令卡最終傷害提高  [DescArg2]%，回合開始時抽牌數-1，上限 [DescArg1] 層，戰鬥結束時不清除。"
  },
  State_149790_Name = {
    Text = "<KuangNu:暗涌>"
  },
  State_149791_Desc = {
    Text = "打出負誓·奧吉爾的「技能」時，消耗 1 層抽 1 張「防禦」，在下次打出前獲得保留，上限 [DescArg1] 層，戰鬥結束時不清除。"
  },
  State_149814_Desc = {
    Text = "臨時傷害強效 +[Layer]%。"
  },
  State_149814_Name = {
    Text = "臨時傷害強效"
  },
  State_149819_Desc = {
    Text = "免疫一切傷害"
  },
  State_149892_Desc = {
    Text = "下 [Layer] 張<AwakerName:[DescArg1]>指令卡造成的基礎護盾提高 [StateArg1]%。"
  },
  State_149913_Name = {
    Text = "狀態@巨噬蠕蟲寶物特效_汀克特破損"
  },
  State_149914_Name = {
    Text = "狀態@巨噬蠕蟲寶物特效_威廉破損"
  },
  State_149915_Name = {
    Text = "狀態@巨噬蠕蟲寶物特效_威廉"
  },
  State_149916_Name = {
    Text = "狀態@巨噬蠕蟲寶物特效_卡斯托爾破損"
  },
  State_149917_Name = {
    Text = "狀態@巨噬蠕蟲寶物特效_血鏈希洛破損"
  },
  State_149918_Name = {
    Text = "狀態@巨噬蠕蟲回合開始測試"
  },
  State_149919_Name = {
    Text = "狀態@巨噬蠕蟲寶物特效_汀克特"
  },
  State_149920_Name = {
    Text = "狀態@巨噬蠕蟲寶物特效_阿拉克涅"
  },
  State_149921_Name = {
    Text = "狀態@巨噬蠕蟲寶物特效_阿拉克涅破損"
  },
  State_149922_Name = {
    Text = "狀態@巨噬蠕蟲寶物特效_卡斯托爾"
  },
  State_149923_Name = {
    Text = "狀態@巨噬蠕蟲寶物特效_血鏈希洛"
  },
  State_149930_Desc = {
    Text = "每擁有 1 層，負誓·奧吉爾的指令卡最終傷害提高 50%，回合開始時抽牌數-1，上限 [DescArg1] 層，戰鬥結束時不清除。"
  },
  State_149930_Name = {
    Text = "<KuangNu2:暗湧>"
  },
  State_149931_Desc = {
    Text = "共有 7 種效果，包括：獲得力量、抽牌、獲得算力、獲得銀鑰能量、臨時傷害強效提高、所有喚醒體獲得狂氣、臨時降低所有敵人力量。"
  },
  State_149931_Name = {
    Text = "<Blessing:禮物>"
  },
  State_149933_Name = {
    Text = "狀態@怪物卡拉布供奉氣泡"
  },
  State_149934_Name = {
    Text = "狀態@怪物卡拉布供奉氣泡"
  },
  State_149939_Desc = {
    Text = "無法獲得護盾，直到回合結束。"
  },
  State_149939_Name = {
    Text = "縛身鎖鏈"
  },
  State_19507_Desc = {
    Text = "下回合開始之前承受的主動攻擊傷害和出血層數提高 25 %，施加時與加固抵消。"
  },
  State_19507_Name = {
    Text = "<PVPVulnerabilityIconColour:易傷>"
  },
  State_19508_Desc = {
    Text = "回合結束時，丟棄此牌。"
  },
  State_19508_Name = {
    Text = "<PVPVoidKeyColour:虛無>"
  },
  State_19509_Desc = {
    Text = "臨時改變卡牌算力。__「僅開發用」"
  },
  State_19509_Name = {
    Text = "永久改變卡牌算力__「僅開發用」"
  },
  State_19511_Desc = {
    Text = "死亡後將手牌替換為幻象__「僅開發用」"
  },
  State_19511_Name = {
    Text = "死亡手牌替換幻象觸發器__「僅開發用」"
  },
  State_19513_Name = {
    Text = "施加死鬥__「僅開發用」"
  },
  State_19516_Name = {
    Text = "臨時改變卡牌算力__「僅開發用」"
  },
  State_19517_Desc = {
    Text = "每損失2%生命，獲得1點狂氣__「僅開發用」"
  },
  State_19517_Name = {
    Text = "受到傷害獲得狂氣__「僅開發用」"
  },
  State_19519_Desc = {
    Text = "使用「打擊」後消耗所有層數，每層使本次「打擊」造成的傷害提高 50%，最多可堆疊 5 層。（當前共提高 [DescArg1]% ）"
  },
  State_19521_Desc = {
    Text = "每層使本場戰鬥內造成的所有傷害提高 1 點，無法驅散。"
  },
  State_19522_Name = {
    Text = "臨時改變卡牌算力__「僅開發用」"
  },
  State_19523_Name = {
    Text = "永久改變卡牌算力__「僅開發用」"
  },
  State_19524_Desc = {
    Text = "下回合開始之前，每次受到攻擊對攻擊者造成 [Layer] 點純粹傷害。"
  },
  State_19524_Name = {Text = "反擊"},
  State_19525_Desc = {
    Text = "回合開始前移除喚醒體護盾__「僅開發用」"
  },
  State_19525_Name = {
    Text = "回合開始前移除角色護盾__「僅開發用」"
  },
  State_19527_Desc = {
    Text = "每層使「技能」本回合算力消耗+1，最多3層，打出後若層數大於 1 則層數-1。"
  },
  State_19527_Name = {
    Text = "<SlowColour:遲緩>"
  },
  State_19528_Desc = {
    Text = "擁有強大效果的卡牌。"
  },
  State_19528_Name = {
    Text = "<SilverKeyColour:鑰令>"
  },
  State_19529_Desc = {
    Text = "可以打出 [Layer] 次，每次打出其他牌使此牌下次打出時算力消耗 -1。"
  },
  State_19530_Desc = {
    Text = "·被對手優先攻擊、並且對手在選擇單體目標時只能選擇嘲諷喚醒體\n·在獲得嘲諷時解除自身的潛行和其他友方的嘲諷、同時驅散敵方的潛行。"
  },
  State_19530_Name = {
    Text = "<TauntColour:嘲諷>"
  },
  State_19532_Desc = {
    Text = "本回合結束之前造成的傷害降低 [DescArg1] %，施加時與強化抵消。"
  },
  State_19532_Name = {Text = "虛弱"},
  State_19533_Desc = {
    Text = "本回合結束之前造成的傷害降低 50 %，施加時與強化抵消。"
  },
  State_19533_Name = {
    Text = "<WeaknessColour:虛弱>"
  },
  State_19534_Desc = {
    Text = "下回合開始之前承受的主動攻擊傷害和出血層數提高 [DescArg1] %，施加時與加固抵消。"
  },
  State_19534_Name = {Text = "易傷"},
  State_19535_Desc = {
    Text = "·被對手優先攻擊、並且對手在選擇單體目標時只能選擇嘲諷喚醒體\n·在獲得嘲諷時解除自身的潛行和其他友方的嘲諷、同時驅散敵方的潛行。"
  },
  State_19535_Name = {Text = "嘲諷"},
  State_19536_Desc = {
    Text = "回合結束時獲得 10 狂氣__「僅開發用」"
  },
  State_19536_Name = {
    Text = "回合結束獲得狂氣觸發器__「僅開發用」"
  },
  State_19537_Desc = {
    Text = "本回合結束之前造成的傷害提高 [DescArg1] %，施加時與虛弱抵消。"
  },
  State_19537_Name = {Text = "強化"},
  State_19538_Desc = {
    Text = "·在第 8 和 9 回合開始時各獲得 1 層\n·每層死鬥使受到的護盾和生命回復降低50%同時屏障的可堆疊層數 - 1 \n·死鬥無法驅散且對死亡喚醒體也有效。"
  },
  State_19538_Name = {Text = "死鬥"},
  State_19541_Desc = {
    Text = "回合結束之前無法進行任何行動。"
  },
  State_19544_Desc = {
    Text = "使用「打擊」後消耗所有層數，每消耗一層使本次「打擊」造成的傷害提高 50%，最多可堆疊 5 層。"
  },
  State_19545_Name = {
    Text = "此卡視為「打擊」__「僅開發用」"
  },
  State_19546_Desc = {
    Text = "打出前改變卡牌算力。__「僅開發用」"
  },
  State_19546_Name = {
    Text = "打出前改變卡牌算力__「僅開發用」"
  },
  State_19547_Desc = {
    Text = "回合結束時受到 [Layer] 點純粹傷害，永續。"
  },
  State_19549_Desc = {
    Text = "下回合開始之前承受的主動攻擊傷害降低 50 %，施加時與易傷抵消。"
  },
  State_19552_Desc = {
    Text = "當前擁有 [Layer] 點護盾，護盾不會大於最大生命，持續 1 回合。"
  },
  State_19552_Name = {Text = "護盾"},
  State_19553_Desc = {
    Text = "抽牌階段後獲得後發制人__「僅開發用」"
  },
  State_19553_Name = {
    Text = "後發制人觸發器__「僅開發用」"
  },
  State_19554_Name = {
    Text = "空狀態__「僅開發用」"
  },
  State_19555_Desc = {
    Text = "·本回合「技能」算力消耗+[Layer]，最多 3 層。\n·打出「技能」後若層數大於 1 ，層數-1 。"
  },
  State_19555_Name = {Text = "遲緩"},
  State_19556_Desc = {
    Text = "回合結束時，此牌算力消耗 -[Layer]。"
  },
  State_19556_Name = {
    Text = "<PrepareKeywords:預備 [Layer] >"
  },
  State_19557_Desc = {
    Text = "下回合開始之前承受的主動攻擊傷害降低 [DescArg1] %，施加時與易傷抵消。"
  },
  State_19558_Name = {
    Text = "復活牌庫加牌觸發器__「僅開發用」"
  },
  State_19560_Desc = {
    Text = "回合結束之前無法使用狂氣爆發。"
  },
  State_19990_Desc = {
    Text = "下回合開始時，獲得 [Layer] 狂氣。"
  },
  State_19990_Name = {
    Text = "延遲狂氣"
  },
  State_19992_Desc = {
    Text = "回合結束之前無法進行任何行動，在受到昏迷傷害後會使目標獲得抗性，擁有抗性時再次受到昏迷傷害時抵消昏迷效果並使傷害翻倍，此狀態無法驅散。"
  },
  State_19995_Desc = {
    Text = "回合結束時造成等量於層數的純粹傷害，永續。"
  },
  State_19996_Desc = {
    Text = "本回合結束之前造成的傷害提高25 %，施加時與虛弱抵消。"
  },
  State_19996_Name = {
    Text = "<StrengthenColour:強化>"
  },
  State_19998_Desc = {
    Text = "下回合開始之前，每次受到攻擊對攻擊者造成等量層數的純粹傷害。"
  },
  State_19998_Name = {
    Text = "<RetaliateColour:反擊>"
  },
  State_20012_Desc = {
    Text = "每點剩餘算力使你下回合開始抽 1 張牌；每張剩餘手牌使你下回合開始獲得 1 算力。"
  },
  State_20012_Name = {
    Text = "異化先賢斷章"
  },
  State_20012_WeaponDesc = {
    Text = "每點剩餘算力使你下回合開始抽 1 張牌；每張剩餘手牌使你下回合開始獲得 1 算力。"
  },
  State_20013_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。將每回合打出的第 1 張牌重新置入手中。超維回合開始時，當回合手牌上限 +5 並複製你的手牌。"
  },
  State_20013_Name = {
    Text = "狀態@時靈擺鏡"
  },
  State_20014_Name = {
    Text = "時靈擺「迷失」"
  },
  State_20016_Name = {
    Text = "造物魔術手套"
  },
  State_20017_Desc = {
    Text = "下一次躍遷效果必定觸發。"
  },
  State_20017_Name = {Text = "躍遷"},
  State_20021_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。將每回合打出的第 1 張牌重新置入手中。超維回合開始時，當回合手牌上限 +5 並複製你的手牌。"
  },
  State_20021_Name = {
    Text = "狀態@時靈擺鏡"
  },
  State_20023_Desc = {
    Text = "戰鬥開始後，將兩張狂氣充能塞入牌庫。"
  },
  State_20023_Name = {
    Text = "混沌縫合體"
  },
  State_20023_WeaponDesc = {
    Text = "戰鬥開始後，將兩張狂氣充能塞入牌庫。"
  },
  State_20024_Desc = {
    Text = "每次釋放狂氣爆發，獲得一張能夠施加 [Arg1] 點中毒的「毒性侵染」。回合結束時若手中每 3 張「毒性侵染」可以合成一張觸發中毒的 「毒性發作」。"
  },
  State_20024_Name = {
    Text = "狀態@造物異化異種喉舌"
  },
  State_20026_Desc = {
    Text = "卡牌不會在棄牌階段進入棄牌堆，而是保留在手牌中並觸發後續效果。"
  },
  State_20026_WeaponDesc = {
    Text = "打出後卡牌不會進入棄牌堆，在本場戰鬥中無法再次使用。"
  },
  State_20028_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。每打出 1 張牌胚胎融合 +10，生命低於 25% 時提高為 20，每回合最多生效 10 次。"
  },
  State_20028_Name = {
    Text = "狀態@時靈擺侵蝕"
  },
  State_20029_Desc = {
    Text = "每次釋放狂氣爆發，獲得一張能夠施加 [Arg1] 點中毒的「毒性侵染」。回合結束時若手中每 3 張「毒性侵染」可以合成一張觸發中毒的 「毒性發作」。"
  },
  State_20029_Name = {
    Text = "狀態@造物異化異種喉舌"
  },
  State_20035_Name = {
    Text = "狀態@時靈擺未眠"
  },
  State_20038_Name = {
    Text = "混沌共生體"
  },
  State_20038_WeaponDesc = {
    Text = "當隊伍由混沌與其他職業組成時，回合開始所有喚醒體獲得 20 狂氣。"
  },
  State_20039_Desc = {
    Text = "若棄牌階段仍在手牌中，卡牌將被消耗，本場戰鬥中不再出現。"
  },
  State_20039_Name = {
    Text = "<NothingnessIconKeywords:虛無>"
  },
  State_20039_WeaponDesc = {
    Text = "打出後卡牌不會進入棄牌堆，在本場戰鬥中無法再次使用。"
  },
  State_20040_Name = {
    Text = "狀態@時靈擺未眠計數"
  },
  State_20041_Desc = {
    Text = "回合開始時每有 1 名敵人就獲得 1 算力，抽 1 張牌。主動傷害擊殺敵人時，對其他敵人造成等同於雙倍過量傷害的出血。"
  },
  State_20041_Name = {
    Text = "異化群氓之歌"
  },
  State_20042_Desc = {
    Text = "對處於負面狀態的敵人造成的傷害提高 25%，擊殺敵人後擊殺者獲得 20 狂氣。"
  },
  State_20044_Desc = {
    Text = "造成的虛弱效果提高 10%。每 3 回合對所有敵人添加 1 層虛弱。"
  },
  State_20045_Desc = {
    Text = "下個回合開始後，從牌庫中任選 3 張卡置入手牌。"
  },
  State_20045_Name = {
    Text = "時靈擺飛舞"
  },
  State_20306_Name = {
    Text = "造物魔術手套"
  },
  State_20419_Desc = {
    Text = "每造成 1 次傷害，對目標施加 [Arg1] 層中毒。若本場戰鬥內觸發次數累計達 25 次，立刻觸發全體敵方中毒。"
  },
  State_20425_Desc = {
    Text = "回合開始時，獲得[Layer]點臨時<PowerIconKeywords:力量>和護盾。"
  },
  State_20600_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：每回合前 [StateArg2] 張「技能」消耗的算力 – [StateArg1] 。"
  },
  State_20601_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提高 [StateArg1]%。每受到一次攻擊，獲得 [StateArg2] 層<EnergyStorageKeywords:蓄力>。"
  },
  State_20602_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」可以選擇目標並且造成 [StateArg1] 層<PVPSlowKeywords:遲緩>，每回合對首個目標觸發時效果翻倍。"
  },
  State_20602_Name = {
    Text = "遺忘之手"
  },
  State_20603_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使自身獲得 <Energy:[Energy:StateArg1]> 狂氣。"
  },
  State_20603_Name = {
    Text = "畸體回噬"
  },
  State_20604_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」回復自身 <Heal:[Heal:StateArg1]> 生命。"
  },
  State_20605_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時<ComaKeywords:昏迷>自身。「狂氣爆發」前驅散全體友方的負面狀態。"
  },
  State_20605_Name = {
    Text = "勳爵手杖"
  },
  State_20606_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」使自身獲得 <Energy:[Energy:StateArg1]> 狂氣。"
  },
  State_20606_Name = {Text = "狂亂"},
  State_20607_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」攻擊<HPAndShieldMax:生命與護盾最高>的敵方，並額外造成傷害 [StateArg1]% 的 <PVPBleedingKeywords:出血>。"
  },
  State_20607_Name = {
    Text = "切割與傷害"
  },
  State_20608_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」和回合結束時，自身獲得 <Energy:[Energy:StateArg1]> 狂氣。"
  },
  State_20609_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：因為失去生命而獲得的狂氣翻倍。"
  },
  State_20609_Name = {Text = "海之夢"},
  State_20610_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提升 [DescArg1]% ，「狂氣爆發」後使自身<PVPPowerIconKeywords:力量>+ [StateArg2] 並使「打擊」傷害額外提升  [StateArg3]%，最大為 100%。"
  },
  State_20610_Name = {
    Text = "星天之獸"
  },
  State_20611_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」和回合結束時，回復損失生命最多的友方 <Heal:[Heal:StateArg1]> 生命。"
  },
  State_20612_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，使狂氣最低友方獲得 <Energy:[Energy:StateArg1]> 狂氣並回復損失生命最多的友方 <Heal:[Heal:StateArg2]> 生命。"
  },
  State_20613_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，其他友方獲得 <Block:[Block:StateArg1]> 護盾。"
  },
  State_20614_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，獲得 [StateArg1] 臨時<PVPRetaliateIconKeywords:反擊>。"
  },
  State_20615_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：每回合首次「打擊」額外造成 [StateArg1] 傷害，<PVPMethysisKeywords:中毒>。"
  },
  State_20615_Name = {Text = "苦咒縛"},
  State_20616_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時獲得 <Energy:[Energy:StateArg1]> 狂氣。"
  },
  State_20616_Name = {
    Text = "阿庫特之春"
  },
  State_20617_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，獲得 <Block:[Block:StateArg1]> 護盾。"
  },
  State_20618_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」前使雙方棄掉所有手牌並抽取等量棄牌數 +1 張牌。"
  },
  State_20618_Name = {
    Text = "快樂魔法秀"
  },
  State_20619_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 <Energy:[Energy:StateArg1]> 狂氣。友方喚醒體釋放「狂氣爆發」後，自身獲得<DelayKeywords:延遲>：  <Energy:[Energy:StateArg2]> 狂氣。"
  },
  State_20619_Name = {
    Text = "神王的頌歌"
  },
  State_20620_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：手牌上限 + [StateArg2] 。回合結束時，獲得手牌中隨機 [StateArg1] 張「技能」的複製。"
  },
  State_20620_Name = {
    Text = "聚首時刻"
  },
  State_20621_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」前使自身獲得<StrengthenKeywords:強化>和<ReinforceKeywords:加固>。"
  },
  State_20622_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時自身獲得 <Energy:[Energy:StateArg1]> 狂氣，消耗所有剩餘算力，每消耗 1 算力使獲得狂氣提高 [StateArg3]。"
  },
  State_20622_Name = {
    Text = "隱秘的誕生"
  },
  State_20623_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後抽 [StateArg1] 張牌。"
  },
  State_20623_Name = {Text = "湧現"},
  State_20624_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後抽 [StateArg1] 張「技能」，將其 [StateArg2] 張複製置入手中。"
  },
  State_20624_Name = {
    Text = "好運時間"
  },
  State_20625_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後<DelayKeywords:延遲>：回復全體友方  <Heal:[Heal:StateArg1]>  生命。"
  },
  State_20626_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提高 [StateArg1]% ，並使自身獲得<ReinforceKeywords:加固>。"
  },
  State_20626_Name = {
    Text = "堅韌意志"
  },
  State_20627_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，回復全體友方 <Heal:[Heal:StateArg1]> 生命。"
  },
  State_20627_Name = {Text = "眷顧"},
  State_20628_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使其他友方獲得 <Energy:[Energy:StateArg1]> 狂氣，此效果溢出的狂氣將折半返還給裝備者。"
  },
  State_20628_Name = {
    Text = "職責所在"
  },
  State_20629_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」造成的傷害、治療與護盾效果提高[StateArg1]%。"
  },
  State_20629_Name = {
    Text = "以薔薇之名"
  },
  State_20630_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，獲得 <Block:[Block:StateArg1]> 護盾和 <Energy:[Energy:StateArg2]> 狂氣。"
  },
  State_20630_Name = {
    Text = "冬夜追憶"
  },
  State_20631_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」<PVPVulnerabilityIconKeywords:易傷>目標。裝備和回合結束時獲得 [StateArg1] 層<EnergyStorageKeywords:蓄力>。"
  },
  State_20631_Name = {Text = "臨界點"},
  State_20632_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：手牌上限 +[StateArg1]。"
  },
  State_20632_Name = {
    Text = "記憶螺旋"
  },
  State_20633_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：每回合首次受到敵方主動攻擊後，對其造成 [StateArg1] 傷害，<PVPEntanglementKeywords:纏繞>。"
  },
  State_20633_Name = {
    Text = "蒼白後裔"
  },
  State_20634_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」「技能」「狂氣爆發」造成的傷害、治療與護盾提高 [DescArg1]%，<PVPGrowthKeywords:成長> [StateArg2]%。"
  },
  State_20634_Name = {Text = "隕日"},
  State_20635_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」前使全體友方獲得<StrengthenKeywords:強化>。"
  },
  State_20635_Name = {
    Text = "虔誠的偉力"
  },
  State_20636_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，獲得一張<PVPDerivativeCardKeywords_2:「幻象」> 。每當手牌上擁有兩張<PVPDerivativeCardKeywords_2:「幻象」> 時，將他們合成為一張<PVPDerivativeCardKeywords_12:「小小心願」>。"
  },
  State_20637_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，將 [StateArg1] 張<PVPDerivativeCardKeywords_11:「不平等交換」>洗入抽牌堆。"
  },
  State_20637_Name = {
    Text = "資訊就是生命"
  },
  State_20639_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，裝備者對<HPAndShieldMax:生命與護盾最高>敵方造成 [StateArg1] 傷害，<PVPMethysisKeywords:中毒>。"
  },
  State_20639_Name = {
    Text = "腐朽贈禮"
  },
  State_20640_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時以及回合開始時，對全體敵方造成 <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:出血>傷害，目標每有一張手牌<PVPBleedingKeywords:出血>傷害 +[StateArg2]。"
  },
  State_20641_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：死亡後給予其他友方 [StateArg1] 層<PVPProtectiveKeywords:屏障>。"
  },
  State_20642_Desc = {
    Text = "<PVPHoldingKeywords:持有>：打出卡牌後，此牌變成其他隨機「命輪」，並使其算力消耗 -1 。"
  },
  State_20642_Name = {
    Text = "靈魂誕生"
  },
  State_20643_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後獲得 [StateArg1] 算力，<DelayKeywords:延遲>：扣除 [StateArg2] 算力。"
  },
  State_20643_Name = {
    Text = "記憶症候"
  },
  State_20644_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時對自身造成 [StateArg2] 傷害，<PVPEntanglementKeywords:纏繞>。每有 1 個陣亡友方，<StrongEffectKeywords:強效>+[StateArg1]。"
  },
  State_20644_Name = {
    Text = "至為珍貴的藏品"
  },
  State_20645_Name = {
    Text = "冒險的行囊"
  },
  State_20646_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提高 [StateArg1]% ，「狂氣爆發」後回復自身 <Heal:[Heal:StateArg2]> 生命。"
  },
  State_20646_Name = {
    Text = "吞噬搖籃曲"
  },
  State_20647_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後將 [StateArg1] 張<PVPDerivativeCardKeywords_11:「不平等交換」>置入手中。"
  },
  State_20647_Name = {
    Text = "於暴雨之中"
  },
  State_20648_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合開始時，獲得正面<PVPWonderfulEffectKeywords:奇妙效果>，敵方每回合第一次使用「鑰令」時將 [StateArg1] 張「華麗光景」置入手中。"
  },
  State_20648_Name = {
    Text = "無聲歡宴"
  },
  State_20649_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後將上回合最後打出的「技能」置入手中，並使其算力消耗 -1，若多次觸發該類效果則向前追溯。"
  },
  State_20649_Name = {
    Text = "溯洄時計"
  },
  State_20650_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時<ComaKeywords:昏迷>自身。「狂氣爆發」前驅散全體敵方的正面狀態。"
  },
  State_20650_Name = {Text = "譫妄"},
  State_20651_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，抽 [StateArg1] 張牌。"
  },
  State_20651_Name = {Text = "貪婪"},
  State_20652_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後對全體敵方造成 [StateArg1] 傷害，<DisarmKeywords:麻痺>。"
  },
  State_20652_Name = {Text = "懲戒"},
  State_20653_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」可以選擇目標並且扣除目標 <Energy:[Energy:StateArg1]> 狂氣。"
  },
  State_20654_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合開始時，<PVPSeriousInjuryKeywords:重創>自身並獲得 <Damage:[Damage:StateArg1]> 層<PVPCorrosionKeywords:罪印>。回合結束時，<ReinforceKeywords:加固>自身。"
  },
  State_20655_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提高 [StateArg1]%，「打擊」可以選擇目標。"
  },
  State_20655_Name = {Text = "寵愛"},
  State_20656_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」造成的傷害、治療與護盾效果提高 [StateArg1]% ，使用「技能」後若沒有<PVPProtectiveKeywords:屏障>則獲得 1 層。"
  },
  State_20656_Name = {
    Text = "詩箋的句尾"
  },
  State_20657_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：每回合對手打出第 [StateArg1] 張「技能」時，將其一張算力消耗 - [StateArg2] 的複製置入你的手中。"
  },
  State_20658_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」每攻擊一個目標獲得 [StateArg1] 算力。"
  },
  State_20658_Name = {
    Text = "被縛的歌謠"
  },
  State_20659_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：死亡後，下回合開始時<PVPResurrectionKeywords:復活>自身並獲得 <Heal:[Heal:StateArg1]> 生命和<Block:[Block:StateArg2]> 護盾並摧毀此「命輪」 。"
  },
  State_20660_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使全體友方獲得 <Block:[Block:StateArg1]> 護盾。"
  },
  State_20660_Name = {
    Text = "心之壁壘"
  },
  State_20661_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後對全體敵方造成 <Damage:[Damage:StateArg1]>  <PVPBleedingKeywords:出血>傷害。"
  },
  State_20662_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，每點<PVPCapKeywords:算力上限>對<HPAndShieldMin:生命與護盾最低>敵方造成 [StateArg1] <PVPBleedingKeywords:出血>，一共造成 <Damage:[Damage:DescArg1]> <PVPBleedingKeywords:出血>傷害。"
  },
  State_20662_Name = {
    Text = "伏於夜色"
  },
  State_20663_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」前驅散自身負面狀態，並獲得 [StateArg1] 層<EnergyStorageKeywords:蓄力>。"
  },
  State_20663_Name = {
    Text = "掙脫鎖鏈之日"
  },
  State_20664_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」使自身獲得<ReinforceKeywords:加固>。"
  },
  State_20664_Name = {
    Text = "騎士之心"
  },
  State_20665_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：自身在驅散負面狀態時若無可驅散的負面狀態則回復 <Heal:[Heal:StateArg1]> 生命。回合結束時，<DelayKeywords:延遲>： 驅散自身負面狀態。"
  },
  State_20666_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使<HPAndShieldMin:生命與護盾最低>的友方獲得 [StateArg1] 層<PVPProtectiveKeywords:屏障>。"
  },
  State_20666_Name = {Text = "致摯友"},
  State_20667_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：每回合打出的第一張裝備者的「技能」傷害提高 [StateArg1]%。"
  },
  State_20668_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：我方喚醒體死亡時，對全體敵方造成 <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:出血>傷害。裝備者死亡時額外造成 <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:出血>傷害。"
  },
  State_20669_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合開始時，若自身沒有<PVPProtectiveKeywords:屏障>獲得 [StateArg1] 層<PVPProtectiveKeywords:屏障>，否則使手中自身算力消耗最高的 1 張「技能」算力消耗 -1。"
  },
  State_20670_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」造成<PVPSeriousInjuryKeywords:重創>，傷害提高 [StateArg1]%  ，但使自身損失一半傷害的生命。"
  },
  State_20670_Name = {
    Text = "傷痛之鰭"
  },
  State_20671_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後回復自身 <Heal:[Heal:StateArg1]> 生命。"
  },
  State_20672_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，使一張算力消耗最高的手牌消耗的算力 -[StateArg1]。<PrepareKeywords:預備>。"
  },
  State_20672_Name = {
    Text = "專注精神"
  },
  State_20673_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使自身獲得 <Block:[Block:StateArg1]> 護盾，其他友方獲得 <Energy:[Energy:StateArg2]> 狂氣。"
  },
  State_20673_Name = {
    Text = "無法完成的演算"
  },
  State_20696_Name = {
    Text = "狀態@巨人之畏"
  },
  State_20723_Desc = {
    Text = "打擊卡的傷害提高 [Layer]。__「僅開發用」"
  },
  State_20723_Name = {
    Text = "打擊卡固定傷害提高__「僅開發用」"
  },
  State_20724_Desc = {
    Text = "打擊卡的傷害減少 [Layer]。__「僅開發用」"
  },
  State_20724_Name = {
    Text = "打擊卡固定傷害減少__「僅開發用」"
  },
  State_20749_Desc = {
    Text = "通用追溯計數。__「僅開發用」"
  },
  State_20758_Desc = {
    Text = "下回合開始時，抽 [Layer] 張牌。"
  },
  State_20758_Name = {
    Text = "延遲抽卡"
  },
  State_20766_Desc = {
    Text = "具體效果看通用打擊邏輯。__「僅開發用」"
  },
  State_20802_Desc = {
    Text = "該卡牌無法被打出。__「僅開發用」"
  },
  State_20802_Name = {
    Text = "無法打出__「僅開發用」"
  },
  State_20803_Desc = {
    Text = "此牌 -1 算力消耗使用其他卡牌後，此牌會變化為其他隨機命輪卡。"
  },
  State_20803_Name = {
    Text = "<CardKeyWord:靈魂誕生>"
  },
  State_20805_Desc = {
    Text = "卡牌不會在棄牌階段進入棄牌堆，而是保留在手牌中。"
  },
  State_20806_Desc = {
    Text = "打出後不會進入棄牌堆，而是從牌庫中移除。"
  },
  State_20820_Desc = {
    Text = "下回合開始時復活並獲得 [Layer] 生命和[Layer] 護盾。"
  },
  State_20820_Name = {
    Text = "延遲復活"
  },
  State_20851_Name = {
    Text = "給與卡牌"
  },
  State_20981_Desc = {
    Text = "「猩紅」已經覺醒，造成的傷害會大幅提高。"
  },
  State_20981_Name = {
    Text = "尤烏哈希覺醒！"
  },
  State_20981_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_20982_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_20982_Name = {
    Text = "尚未覺醒"
  },
  State_20988_Desc = {
    Text = "初始狂氣 +80。每回合獲得 20 點狂氣。"
  },
  State_20988_Name = {
    Text = "達芙黛爾·初見"
  },
  State_20989_Desc = {
    Text = "初始狂氣 +80。每回合獲得 2 點算力，20 點狂氣。"
  },
  State_20989_Name = {
    Text = "圖魯·初見"
  },
  State_21306_Desc = {
    Text = "每回合重置連擊"
  },
  State_21306_Name = {
    Text = "連擊重置"
  },
  State_21307_Desc = {
    Text = "每層使攻擊次數加1，受到傷害失去 1 層，最低為 1 層，在回合結束時失去全部。"
  },
  State_21307_Name = {Text = "連擊"},
  State_21342_Desc = {
    Text = "下回合開始時，獲得 [Layer] 治療。"
  },
  State_21342_Name = {
    Text = "延遲治療"
  },
  State_21345_Desc = {
    Text = "在神降儀式開始前，死亡後會復活，解除負面狀態，免疫傷害並恢復 30% 生命。在神降儀式開始後，死亡後會完全復活，解除負面狀態和儀式執念，並呼喚兩名眷族。"
  },
  State_21345_Name = {
    Text = "儀式執念"
  },
  State_21358_Desc = {
    Text = "該玩家手牌沒有上限。__「僅開發用」"
  },
  State_21381_Name = {
    Text = "封印使用次數計數"
  },
  State_21385_Desc = {
    Text = "每失去 1 點生命降低 1 層。層數降低為 0 時，將意圖轉換為高額傷害的狂氣爆發並會解除石化效果。"
  },
  State_21450_Desc = {
    Text = "下回合開始時，驅散自身的負面狀態。"
  },
  State_21450_Name = {
    Text = "延遲淨化"
  },
  State_21488_Desc = {
    Text = "具體效果看通用打擊邏輯。__「僅開發用」"
  },
  State_21492_Desc = {
    Text = "傷害在暴擊時會提高50%。"
  },
  State_21492_Name = {
    Text = "<CardKeyWord:暴擊>"
  },
  State_21546_Desc = {
    Text = "下回合開始時，獲得 [Layer] 護盾。"
  },
  State_21546_Name = {
    Text = "延遲護盾"
  },
  State_21547_Desc = {
    Text = "回合開始時，保留一半護盾。"
  },
  State_21547_Name = {Text = "堅毅"},
  State_21548_Desc = {
    Text = "下回合開始時，獲得強化。"
  },
  State_21548_Name = {
    Text = "延遲強化"
  },
  State_21580_Desc = {
    Text = "獵顱者正在追蹤你行動的痕跡，每抽 1 張牌，獵顱者獲得 [StateArg1] 臨時力量。"
  },
  State_21580_Name = {Text = "尋蹤"},
  State_21587_Name = {
    Text = "本回合已找到新的隨機喚醒體"
  },
  State_21590_Name = {
    Text = "嘗試尋找新喚醒體次數"
  },
  State_21601_Name = {
    Text = "已找到新喚醒體"
  },
  State_21616_Desc = {
    Text = "使用狂氣爆發後封印所有喚醒體一回合。"
  },
  State_21671_Name = {
    Text = "造成範圍傷害__「僅開發用」"
  },
  State_21720_Desc = {
    Text = "對目標身後的喚醒體造成相同效果，若其身後沒有喚醒體，則僅對目標造成效果。"
  },
  State_21720_Name = {
    Text = "<CardKeyWord:貫穿>"
  },
  State_21726_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備者每回合第一次打出「技能」後，將其一張算力消耗 - [StateArg1] 的複製洗入抽牌堆。"
  },
  State_21726_Name = {
    Text = "旋轉，旋轉"
  },
  State_21744_Name = {
    Text = "嘗試尋找新喚醒體次數"
  },
  State_21745_Name = {
    Text = "已找到新喚醒體"
  },
  State_21746_Name = {
    Text = "本回合已找到新的隨機喚醒體"
  },
  State_21747_Desc = {
    Text = "有[Layer]名喚醒體正在被狩獵，被狩獵喚醒體每使用一張卡牌，「暴走獵顱者」疊加1層狩獵印記。"
  },
  State_21747_Name = {
    Text = "狩獵儀式"
  },
  State_21751_Desc = {
    Text = "抽狩獵印記層數一半的牌([DescArg1])，「暴走獵顱者」的狩獵印記層數+1。"
  },
  State_21751_Name = {
    Text = "<CardKeyWord:被狩獵>"
  },
  State_21754_Desc = {
    Text = "死亡後，驅散「暴走獵顱者」的全部臨時力量並將其「狩獵印記」層數減半。"
  },
  State_21754_Name = {
    Text = "短暫解脫"
  },
  State_21765_Desc = {
    Text = "·可以給一名友方喚醒體裝備「命輪」，使其發揮「命輪」效果。\n·為一名喚醒體重複裝備「命輪」時，會摧毀舊的「命輪」保留新的「命輪」。\n·喚醒體死亡後其裝備的「命輪」會被摧毀。\n·若給死亡的喚醒體裝備「命輪」則會摧毀該「命輪」，並獲得一張幻象和返還消耗算力。"
  },
  State_21765_Name = {
    Text = "<PVPWeaponKeywords:命輪>"
  },
  State_21785_Name = {
    Text = "戰鬥喊話"
  },
  State_21787_Name = {
    Text = "添加戰鬥喊話"
  },
  State_21826_Name = {
    Text = "孩子王開場喊話"
  },
  State_21829_Name = {
    Text = "亡語效果"
  },
  State_21838_Name = {
    Text = "開場介紹"
  },
  State_21843_Name = {
    Text = "開場加狀態"
  },
  State_21895_Name = {
    Text = "開場喊話"
  },
  State_21905_Desc = {
    Text = "「打擊」獲得 2 點算力，隨機棄 1 張牌；「防禦」抽 2 張牌，失去 1 點算力。"
  },
  State_22054_Name = {
    Text = "開場喊話"
  },
  State_22055_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_22055_Name = {
    Text = "尚未覺醒"
  },
  State_22067_Desc = {
    Text = "回合結束後，使 1 條觸腕攻擊 [Layer] 次。"
  },
  State_22067_Name = {
    Text = "觸腕集結"
  },
  State_22074_Desc = {
    Text = "存活第七回合轉變意圖為凝視，八回合及以上轉變意圖為褻瀆。"
  },
  State_22134_Desc = {
    Text = "穿刺傷害會同時損傷目標的生命、護盾、屏障。"
  },
  State_22134_Name = {
    Text = "<CardKeyWord:穿刺傷害>"
  },
  State_22157_Desc = {
    Text = "當生命低於 50%([StateArg1]) 時，將會分裂為等量生命的「洋流」和「潮汐」。"
  },
  State_22204_Desc = {
    Text = "回合開始後獲得 [Layer]% 臨時暴擊率和臨時暴擊傷害。"
  },
  State_22204_Name = {
    Text = "綿音漸響"
  },
  State_22204_WeaponDesc = {
    Text = "直到下回合開始前未損失生命，下回合暴擊率 +[StateArg1]%。"
  },
  State_22210_Desc = {
    Text = "算力消耗 + 100，並且無法使用打擊、無法獲得狂氣。"
  },
  State_22210_Name = {
    Text = "超級遲緩"
  },
  State_22238_Name = {
    Text = "玩家死鬥__「僅開發用」"
  },
  State_22239_Name = {
    Text = "施加玩家死鬥__「僅開發用」"
  },
  State_22249_Desc = {
    Text = "下個回合開始後，少抽 [Layer] 張牌。"
  },
  State_22249_Name = {
    Text = "不平等交換"
  },
  State_22300_Desc = {
    Text = "該打擊卡無法打出卡牌。__「僅開發用」"
  },
  State_22300_Name = {
    Text = "打擊卡繳械無法打出__「僅開發用」"
  },
  State_22303_Desc = {
    Text = "每次受到傷害就給予手牌中隨機卡牌一層臨時「遲緩」，擊破護盾後移除「霜盾」狀態。"
  },
  State_22324_Desc = {
    Text = "每有1層，本回合增加1段攻擊"
  },
  State_22324_Name = {
    Text = "怒濤迴響"
  },
  State_22325_Desc = {
    Text = "每次受到攻擊後 , 獲得 [StateArg1] 點臨時力量。"
  },
  State_22325_Name = {
    Text = "巨人血脈"
  },
  State_22326_Desc = {
    Text = "你被鎖定了！打出後蹈海者近衛獲得 1 層臨時瘋狂，移除該指令卡的怒濤印記。"
  },
  State_22326_Name = {
    Text = "<CardKeyWord:怒濤印記>"
  },
  State_22328_Desc = {
    Text = "每使用一次帶有「怒濤印記」的指令卡，本回合攻擊次數+1。"
  },
  State_22328_Name = {
    Text = "怒濤迴響"
  },
  State_22334_Desc = {
    Text = "每打出 1 張「打擊」卡，將 [StateArg1] 張「傷口」放到抽牌堆頂。"
  },
  State_22334_Name = {Text = "創傷"},
  State_22404_Desc = {
    Text = "本場戰鬥內產生的護盾提高 [Layer] 點。"
  },
  State_22404_Name = {Text = "戒備"},
  State_22405_Desc = {
    Text = "本場戰鬥內產生的護盾提高。"
  },
  State_22405_Name = {
    Text = "<PVPAlertKeywords:戒備>"
  },
  State_22702_Desc = {
    Text = "每回合打出的第一張「卡牌」會觸發額外效果。"
  },
  State_22702_Name = {
    Text = "<CardKeyWord:突襲>"
  },
  State_22706_Name = {
    Text = "突襲標記__「僅開發用」"
  },
  State_22707_Desc = {
    Text = "每回合打牌以後給玩家上個突襲狀態進行標記__「僅開發用」"
  },
  State_22707_Name = {
    Text = "突襲觸發器__「僅開發用」"
  },
  State_22721_Name = {
    Text = "時靈擺「迷失」"
  },
  State_23405_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，獲得等同於當前反擊層數的力量，回復生命並以真正的形態開始戰鬥。"
  },
  State_23405_Name = {
    Text = "尚未覺醒"
  },
  State_23406_Desc = {
    Text = "「沉淵者」每個回合結束時都會獲得 [StateArg1] 層反擊。"
  },
  State_23406_Name = {
    Text = "凱刻斯覺醒！"
  },
  State_23512_Name = {
    Text = "給與千面幻象"
  },
  State_23514_Name = {
    Text = "給與千面幻象"
  },
  State_23515_Name = {
    Text = "給與千面幻象"
  },
  State_23516_Name = {
    Text = "給與千面幻象"
  },
  State_23517_Name = {
    Text = "給與玩家BUFF"
  },
  State_23518_Desc = {
    Text = "施加2回合易傷 / 增加1次攻擊 / 施加力量降低。"
  },
  State_23518_Name = {
    Text = "<CardKeyWord:意圖選擇>"
  },
  State_23519_Name = {Text = "意圖2b"},
  State_23520_Name = {Text = "意圖2c"},
  State_23521_Name = {
    Text = "棄掉時消耗、扣除所有喚醒體[StateArg1]狂氣、並將 5 張「症狀」洗入玩家抽牌堆"
  },
  State_23522_Name = {
    Text = "棄掉時消耗、扣除所有喚醒體[StateArg1]狂氣"
  },
  State_23524_Name = {Text = "意圖3a"},
  State_23525_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_23525_Name = {
    Text = "尚未覺醒"
  },
  State_23526_Name = {Text = "意圖2a"},
  State_23527_Name = {Text = "意圖3c"},
  State_23528_Name = {Text = "意圖3b"},
  State_23529_Desc = {
    Text = "提升力量 / 造成額外傷害 / 獲得護盾"
  },
  State_23529_Name = {
    Text = "<CardKeyWord:意圖選擇>"
  },
  State_23530_Desc = {
    Text = "使用「千面幻象」時需要進行兩次意圖選擇。若棄掉，則所有喚醒體失去 20 狂氣，並將 5 張「症狀」洗入玩家抽牌堆。"
  },
  State_23530_Name = {
    Text = "達芙黛爾覺醒！"
  },
  State_23531_Name = {
    Text = "給與千面幻象"
  },
  State_23532_Name = {
    Text = "給與千面幻象"
  },
  State_23533_Desc = {
    Text = "洗入症狀卡 / 施加出血 / 降低狂氣"
  },
  State_23533_Name = {
    Text = "<CardKeyWord:意圖選擇>"
  },
  State_23534_Name = {Text = "意圖1a"},
  State_23535_Name = {Text = "意圖1c"},
  State_23536_Name = {Text = "意圖1b"},
  State_23612_Desc = {
    Text = "每失去 1 點生命降低 1 層。層數降低為 0 時，將意圖轉換為高額傷害的狂氣爆發並會解除石化效果。"
  },
  State_23612_Name = {
    Text = "血之狂暴·終結"
  },
  State_23687_Name = {
    Text = "時靈擺「潮湧」"
  },
  State_23726_Desc = {
    Text = "下回合之前會阻止喚醒體死亡 1 次，最多 1 層。"
  },
  State_23732_Desc = {
    Text = "直到下個回合開始前，每受到 1 次主動傷害獲得 [Layer] 層<PainWord:忍耐>。"
  },
  State_23736_Name = {
    Text = "本回合抽牌數"
  },
  State_23737_Name = {
    Text = "抽牌數記錄"
  },
  State_23741_Name = {
    Text = "施加抽牌記錄"
  },
  State_23744_Desc = {
    Text = "如果場上沒有「死者」，回合開始時召喚 1 名「死者」，每次召喚生命都會提高。"
  },
  State_23744_Name = {
    Text = "死者召喚"
  },
  State_23747_Name = {
    Text = "強化生命"
  },
  State_23748_Name = {
    Text = "召喚計數"
  },
  State_23769_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_23769_Name = {
    Text = "尚未覺醒"
  },
  State_23771_Desc = {
    Text = "「奇術師」已經覺醒，小心她使用「幻影」製造的分身。覺醒後對方每打出 1 張卡牌，卡茜亞獲得 1 層「幻影」。"
  },
  State_23771_Name = {
    Text = "卡茜亞覺醒！"
  },
  State_23771_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_23782_Desc = {
    Text = "獲得 10 層幻影後，清空「幻影」層數並在前方召喚 1 個分身，最多存在 2 個分身。分身在被召喚時會攜帶 3 層<ParcloseIconKeywords:屏障>。"
  },
  State_23786_Name = {
    Text = "狀態@喚醒體卡茜亞隔空取物"
  },
  State_23787_Name = {
    Text = "狀態@喚醒體卡茜亞@隔空取物@抽牌減少"
  },
  State_23788_Desc = {
    Text = "第 3 回合開始時，將 1 張「過往回聲—棄掉所有手牌，當前生命和護盾回到上回合結束時的狀態。保留，消耗。」加入手中。"
  },
  State_23791_Name = {
    Text = "開場提示"
  },
  State_23823_Name = {Text = "炸彈1"},
  State_23825_Name = {
    Text = "狀態@喚醒體卡茜亞@通通消失"
  },
  State_23827_Desc = {
    Text = "打出後，失去 [DescArg1] 點最大生命值，大魔術師在本回合獲得 1 層「洋洋得意」。"
  },
  State_23828_Desc = {
    Text = "大魔術師現在非常享受他的表演，每有 1 層「洋洋得意」，其技能效果將被削弱且力量降低 [DescArg1]，最多可獲得 5 層。"
  },
  State_23871_Desc = {
    Text = "增加最大生命時不會同時增加當前生命，減少最大生命時會移除多餘的當前生命，最大生命最少為 1 ，死亡後不重置。"
  },
  State_23934_Name = {
    Text = "狀態@隔空取物手牌監聽"
  },
  State_23935_Name = {
    Text = "狀態@喚醒體卡茜亞@隔空取物生效"
  },
  State_2393_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_2393_Name = {
    Text = "尚未覺醒"
  },
  State_2394_Name = {
    Text = "猩紅力量啟靈加成"
  },
  State_2395_Name = {
    Text = "飾品遠方的歡宴"
  },
  State_2395_WeaponDesc = {
    Text = "「防禦」造成護盾提高 30%。若裝備者黑印掉落大於 15%，「防禦」造成護盾額外提高 30%。"
  },
  State_2396_Desc = {
    Text = "暴擊傷害提高 20%。對有護盾的敵方造成的傷害必然暴擊。"
  },
  State_2398_Desc = {
    Text = "受到傷害時，獲得 [Layer]護盾，每次受到傷害護盾會不斷增加，回合結束時恢復。"
  },
  State_2398_Name = {
    Text = "維度壁壘"
  },
  State_2398_WeaponDesc = {
    Text = "受到的主動傷害提高[Layer]。每次受到傷害融蝕傷口都會擴大，回合開始時恢復。"
  },
  State_2399_Desc = {
    Text = "造成生命回復後，所有喚醒體獲得 3 點狂氣。每第 5 次造成生命回復後，本場戰鬥狂氣爆發傷害提高 [Arg1]。"
  },
  State_2400_Desc = {
    Text = "觸腕上限提高 1 條。生命低於 50% 時，觸腕傷害提高 [StateArg1]點 。"
  },
  State_2400_Name = {
    Text = "造物過往的貢物"
  },
  State_2400_WeaponDesc = {
    Text = "觸腕上限提高 1 條。生命低於 50% 時，觸腕傷害提高 [StateArg1]點 。"
  },
  State_2401_Desc = {
    Text = "回合開始時，將棄牌堆頂部的卡牌加入手牌。"
  },
  State_2402_Desc = {
    Text = "回合開始時，超維空間每有 1 張卡牌，本回合就獲得 [Arg1] 點臨時力量。"
  },
  State_2403_Desc = {
    Text = "本場戰鬥內造成的護盾提高 [Layer] 點。"
  },
  State_2403_Name = {Text = "戒備"},
  State_2403_WeaponDesc = {
    Text = "本場戰鬥內造成的護盾提高 [Layer] 點。"
  },
  State_2404_Desc = {
    Text = "拾取時刪除 1 張症狀卡。幸運刻印率提高 50%。"
  },
  State_2405_Desc = {
    Text = "臨時改變卡牌算力"
  },
  State_2405_Name = {
    Text = "臨時改變卡牌算力"
  },
  State_2405_WeaponDesc = {
    Text = "臨時改變卡牌算力"
  },
  State_2406_Desc = {
    Text = "耗盡最後 1 點算力時，獲得 2 算力。每回合最多觸發 2 次。"
  },
  State_2407_Name = {Text = "觀測值"},
  State_2409_Desc = {
    Text = "本回合每打出 1 張【打擊】算力消耗 -1 。"
  },
  State_2409_Name = {
    Text = "桀驁之刃"
  },
  State_2409_WeaponDesc = {
    Text = "本回合每打出 1 張【打擊】算力消耗 -1 。"
  },
  State_2410_Desc = {
    Text = "無法行動 1 回合。被石化過的敵人無法再次被施加石化效果。"
  },
  State_2410_WeaponDesc = {
    Text = "使怪物眩暈一回合。"
  },
  State_2411_Desc = {
    Text = "回合結束時，對我方隊伍施加 [Layer] 層出血。"
  },
  State_2411_Name = {Text = "血之燈"},
  State_2411_WeaponDesc = {
    Text = "回合結束時，對我方隊伍施加 [Layer] 層出血。"
  },
  State_2412_Desc = {
    Text = "下一回合造成的傷害翻倍。"
  },
  State_2412_Name = {
    Text = "絕境求生"
  },
  State_2412_WeaponDesc = {
    Text = "下一回合造成的傷害翻倍。"
  },
  State_2413_Desc = {
    Text = "打擊和防禦獲取的狂氣減少 [Layer] %。"
  },
  State_2413_Name = {Text = "空虛"},
  State_2413_WeaponDesc = {
    Text = "打擊和防禦獲取的狂氣[StateArg1]%。"
  },
  State_2415_Desc = {
    Text = "若上回合受到了傷害，回合開始時獲得 1 回合免疫。"
  },
  State_2415_Name = {Text = "適應"},
  State_2415_WeaponDesc = {
    Text = "若上回合受到了傷害，回合開始時獲得 1 回合免疫。"
  },
  State_2416_Desc = {
    Text = "其召喚的怪物生命和傷害翻倍。"
  },
  State_2416_Name = {
    Text = "「蠟像世界」"
  },
  State_2416_WeaponDesc = {
    Text = "其召喚的怪物生命和傷害翻倍。"
  },
  State_24174_Desc = {
    Text = "該喚醒體不再會因為傷害導致生命低於1。"
  },
  State_2418_Desc = {
    Text = "[狂氣爆發]使自身獲得 30 狂氣。"
  },
  State_2418_Name = {
    Text = "異化之神的面紗"
  },
  State_2418_WeaponDesc = {
    Text = "[狂氣爆發]使自身獲得 30 狂氣。"
  },
  State_2419_Name = {
    Text = "造物白色鏡面"
  },
  State_2420_Desc = {
    Text = "本回合每打出 1 張【防禦】算力消耗 -1 。"
  },
  State_2420_WeaponDesc = {
    Text = "本回合每打出 1 張【防禦】算力消耗 -1 。"
  },
  State_24210_Desc = {
    Text = "本回合神王的觸腕攻擊目標變為全體敵人"
  },
  State_24210_Name = {
    Text = "神國腕肢-鑰令"
  },
  State_24211_Desc = {
    Text = "·回合結束後，對前排敵人造成 [DescArg4] 次 [DescArg2] 點傷害，若擊殺敵人，該傷害提高 [DescArg3] 點，最多提高 5 次(當前 [DescArg6] 次)。\n·每當喚醒體使用狂氣爆發，本回合額外發動 1 次攻擊。\n·守密人使用鑰令後，使本回合發動的攻擊目標變為全體敵人，若在首領戰中，「神國腕肢」造成的傷害還會提高 [DescArg5] 點。"
  },
  State_24211_Name = {
    Text = "神國腕肢"
  },
  State_24213_Name = {
    Text = "若此卡在手牌中，回合結束時獲得 150 點銀鑰能量"
  },
  State_24214_Desc = {
    Text = "·回合結束後，對前排敵人造成 [DescArg2] 點傷害。"
  },
  State_24214_Name = {
    Text = "神國腕肢"
  },
  State_24215_Desc = {
    Text = "·回合結束後，對前排敵人造成 [DescArg2] 點傷害，若擊殺敵人，該傷害提高 [DescArg3] 點，最多提高 5 次(當前 [DescArg4] 次)。"
  },
  State_24215_Name = {
    Text = "神國腕肢"
  },
  State_24217_Name = {
    Text = "清除自身<VulnerabilityIconKeywords:易傷>、<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>狀態"
  },
  State_24220_Name = {
    Text = "獲得 [DescArg1] 點護盾"
  },
  State_24222_Desc = {
    Text = "·回合結束後，對前排敵人造成 [DescArg4] 次 [DescArg2] 點傷害，若擊殺敵人，該傷害提高 [DescArg3] 點，最多提高 5 次(當前 [DescArg5] 次)。\n·每當喚醒體使用狂氣爆發，本回合額外發動 1 次攻擊。\n·每當守密人使用鑰令，使本回合發動的攻擊目標變為全體敵人。"
  },
  State_24222_Name = {
    Text = "神國腕肢"
  },
  State_24223_Desc = {
    Text = "·回合結束後，對前排敵人造成 [DescArg2] 點傷害，若擊殺敵人，該傷害提高 [DescArg3] 點，最多提高 5 次(當前 [DescArg4] 次)。\n·每當守密人使用鑰令，使本回合發動的攻擊目標變為全體敵人。"
  },
  State_24223_Name = {
    Text = "神國腕肢"
  },
  State_24224_Desc = {
    Text = "·回合結束後，對前排敵人造成 [DescArg4] 次 [DescArg2] 點傷害，若擊殺敵人，該傷害提高 [DescArg3] 點，最多提高 5 次(當前 [DescArg5] 次)。\n·每當喚醒體使用狂氣爆發，本回合額外發動 1 次攻擊。"
  },
  State_24224_Name = {
    Text = "神國腕肢"
  },
  State_24226_Desc = {
    Text = "·回合結束後，對前排敵人造成 [DescArg4] 次 [DescArg2] 點傷害，若擊殺敵人，該傷害提高 [DescArg3] 點，最多提高 5 次(當前 [DescArg6] 次)。\n·每當喚醒體使用狂氣爆發，本回合額外發動 1 次攻擊。\n·在首領戰中，每當守密人使用鑰令，「神國腕肢」傷害提高 [DescArg5] 點。"
  },
  State_24226_Name = {
    Text = "神國腕肢"
  },
  State_24227_Desc = {
    Text = "·回合結束後，對前排敵人造成 [DescArg2] 點，若擊殺敵人，該傷害提高 [DescArg3] 點，最多提高 5 次(當前 [DescArg5] 次)。\n·守密人使用鑰令後，使本回合發動的攻擊目標變為全體敵人，若在首領戰中，「神國腕肢」造成的傷害還會提高 [DescArg4] 點。"
  },
  State_24227_Name = {
    Text = "神國腕肢"
  },
  State_2422_Desc = {
    Text = "打出後獲得 [StateArg1] 點護盾。"
  },
  State_2422_Name = {
    Text = "<Rune_6:鐵壁>"
  },
  State_24245_Desc = {
    Text = "回合結束時，復甦所有「海德拉」的眷族。每次有眷族死亡後降低 1 層，若層數為 0，「海德拉」將轉換形態進行最終的戰鬥。"
  },
  State_24245_Name = {
    Text = "萬蛇操使"
  },
  State_24247_Desc = {
    Text = "受到的傷害降低 90%。若回合開始時沒有「萬蛇操使」層數，移除此狀態。"
  },
  State_2425_Desc = {
    Text = "打出後被消耗。若為指令卡，其傷害和防護會被提高 2 倍。"
  },
  State_2426_Desc = {
    Text = "你每回合打出的第一張卡牌額外生效 1 次，但每回合最多打出 4 張卡牌。"
  },
  State_2427_Name = {
    Text = "狀態@幻夢銀鑰：血淵之心計數"
  },
  State_2428_Desc = {
    Text = "惡之華的<ParcloseIconKeywords:屏障>數量增加 [Layer] 層。"
  },
  State_2428_WeaponDesc = {
    Text = "惡之華的屏障數量增加 [Layer] 層"
  },
  State_24292_Name = {
    Text = "後排前移"
  },
  State_24293_Name = {
    Text = "前排後移"
  },
  State_2429_Desc = {
    Text = "造成的所有傷害降低 [Layer] %。"
  },
  State_2429_Name = {
    Text = "臨時傷害降低"
  },
  State_2429_WeaponDesc = {
    Text = "造成的所有傷害降低 [Layer] %。"
  },
  State_2430_Desc = {
    Text = "戰鬥開始時，全體友方獲得 3 層【蠟質鎧甲】。回合結束時，對我方隊伍造成[Arg1]層出血。"
  },
  State_2430_Name = {
    Text = "「蠟之紳士」"
  },
  State_2430_WeaponDesc = {
    Text = "戰鬥開始時，全體友方獲得 3 層【蠟質鎧甲】。回合結束時，對我方隊伍造成[Arg1]層出血。"
  },
  State_2431_Desc = {
    Text = "隊伍唯一：裝備者造成的護盾和生命回復提高，提高量為 <WeaponEffect_Num:[StateArg1]%> 裝備者的體質，裝備者造成的反擊提高 <WeaponEffect_Num:[StateArg3]%>，打出「防禦」時還會獲得裝備者防禦力 <WeaponEffect_Num:[StateArg4]%> 的<RetaliateIconKeywords:反擊>。戰鬥開始後，獲得等同於裝備者體質 <WeaponEffect_Num:[StateArg2]%> 的<PowerIconKeywords:力量> 。若當前界域為「深海」，額外獲得等量的觸腕傷害。"
  },
  State_2431_WeaponDesc = {
    Text = "裝備者造成的護盾和生命回復提高 <WeaponEffect_Num:[DescArg1]> 點，裝備者造成的反擊提高 <WeaponEffect_Num:[StateArg3]%>，打出「防禦」時，還會獲得 <WeaponEffect_Num:[Counterattack:DescArg3]> 層<RetaliateIconKeywords:反擊>。戰鬥開始後，獲得 <WeaponEffect_Num:[Power:DescArg2]> 點<PowerIconKeywords:力量>。若當前界域為「深海」，額外獲得等量的觸腕傷害。"
  },
  State_2432_Desc = {
    Text = "承受的主動和觸腕傷害提高 50 ％，回合結束時移除 1 層。"
  },
  State_2432_Name = {
    Text = "<VulnerabilityIconKeywords: 易傷>"
  },
  State_2432_WeaponDesc = {
    Text = "承受的所有傷害提高 50 %。"
  },
  State_2433_Desc = {
    Text = "每個回合結束時獲得[Layer]點力量。"
  },
  State_2433_Name = {Text = "憤怒"},
  State_2434_Name = {
    Text = "飾品36室之環"
  },
  State_2434_WeaponDesc = {
    Text = "抽到裝備者的卡牌時，其算力會在 0-3 間隨機變化。"
  },
  State_2436_Desc = {
    Text = "獲得的力量和護盾降低 50%，持續 [Layer] 回合。"
  },
  State_2436_Name = {
    Text = "臨時詛咒"
  },
  State_2436_WeaponDesc = {
    Text = "回合結束前，免疫對自身施加正面狀態。"
  },
  State_2438_Desc = {
    Text = "狀態@造物銀白差分機計數"
  },
  State_2438_Name = {
    Text = "狀態@造物銀白差分機計數"
  },
  State_2438_WeaponDesc = {
    Text = "狀態@造物銀白差分機計數"
  },
  State_2440_Name = {
    Text = "抽 1 張牌"
  },
  State_2441_Name = {
    Text = "獲得 1 點算力"
  },
  State_2442_Name = {
    Text = "對所有敵人施加 1 層<VulnerabilityIconKeywords:易傷>"
  },
  State_2443_Name = {
    Text = "對所有敵人施加 1 層<WeaknessIconKeywords:虛弱>"
  },
  State_2444_Name = {
    Text = "獲得 <Energy:[DescArg1]> 點狂氣"
  },
  State_2445_Name = {
    Text = "其他喚醒體獲得 <Energy:[DescArg1]> 點狂氣"
  },
  State_2446_Name = {
    Text = "將 1 張<DerivativeCardKeywords_4:「靈感」>加入抽牌堆"
  },
  State_2447_Desc = {
    Text = "隊伍唯一：裝備者指令卡暴擊率和暴擊傷害、指令卡造成的護盾、生命回復、狂氣和力量提高 <WeaponEffect_Num:[StateArg1]%>。若當前界域為「超維」，釋放「湮滅」後獲得 <WeaponEffect_Num:[StateArg2]> 點銀鑰能量。進入超維回合後，本回合下一個鑰令釋放 2 次。"
  },
  State_2447_WeaponDesc = {
    Text = "裝備者指令卡暴擊率和暴擊傷害、指令卡造成的護盾、生命回復、狂氣和力量提高 <WeaponEffect_Num:[StateArg1]%>。若當前界域為「超維」，釋放「湮滅」後獲得 <WeaponEffect_Num:[StateArg2]> 點銀鑰能量。進入超維回合後，本回合下一個鑰令釋放 2 次。"
  },
  State_2448_Desc = {
    Text = "卡牌不會在棄牌階段進入棄牌堆，而是保留在手牌中。"
  },
  State_2449_Desc = {
    Text = "受到實際傷害後，獲得[Layer]護盾。"
  },
  State_2449_Name = {Text = "緩衝"},
  State_2449_WeaponDesc = {
    Text = "受到實際傷害後，獲得[Layer]護盾。"
  },
  State_2450_Desc = {
    Text = "「打擊」必定暴擊。暴擊傷害提高 50%。"
  },
  State_2451_Desc = {
    Text = "回合結束時，其他友方獲得 [Layer] 力量。"
  },
  State_2451_Name = {
    Text = "「啟明之火」"
  },
  State_2452_Desc = {
    Text = "打出後獲得 [StateArg1] 點力量。"
  },
  State_2452_Name = {
    Text = "<Rune_14_High:高級蠻力>"
  },
  State_2453_Name = {
    Text = "飾品光合祭禮"
  },
  State_2453_WeaponDesc = {
    Text = "戰鬥開始後，裝備者所有的卡牌獲得保留。"
  },
  State_2454_Desc = {
    Text = "打出後不會進入棄牌堆，而是從牌庫中移除。"
  },
  State_2454_WeaponDesc = {
    Text = "打出後卡牌不會進入棄牌堆，在本場戰鬥中無法再次使用。"
  },
  State_24556_Name = {
    Text = "狀態@大魔術師胡迪尼@幸運觀眾添加喝彩"
  },
  State_2455_Name = {
    Text = "狀態@青炎舞者啟靈7"
  },
  State_24560_Desc = {
    Text = "每當使用鑰令後，環行·拉蒙娜臨時暴擊率和臨時暴擊傷害 +25%。"
  },
  State_24560_Name = {
    Text = "克萊因旅人"
  },
  State_24562_Desc = {
    Text = "回合結束後，獲得 1 層負熵。"
  },
  State_24562_Name = {
    Text = "彭羅斯行者"
  },
  State_24564_Desc = {
    Text = "每當擁有 3 層負熵時，打出環行·拉蒙娜的指令卡將消耗所有負熵並觸發回環額外效果，負熵最多堆疊 3 層。"
  },
  State_24564_Name = {Text = "負熵"},
  State_2456_Name = {
    Text = "狀態@青炎舞者啟靈15"
  },
  State_2457_Name = {
    Text = "抽 1 張牌"
  },
  State_24584_Name = {
    Text = "狀態@N的分身@呢喃1狀態切換"
  },
  State_2458_Name = {
    Text = "狀態@飾品猩紅之擁效果計數"
  },
  State_24593_Desc = {
    Text = "層數為 0 時，將意圖變更為「黑色召喚」，回合結束時會減少 1 層，至多擁有4層。"
  },
  State_24595_Desc = {
    Text = "死亡後立即減少「N」的 1 層 「混沌」。"
  },
  State_24595_Name = {Text = "彌散"},
  State_24596_Desc = {
    Text = "召喚「N」的分身時，每有 1 層「黑暗」召喚 1 個分身。"
  },
  State_2460_Desc = {
    Text = "隊伍唯一：裝備者造成的基礎傷害、<IntoxicationIconKeywords:中毒>和<RetaliateIconKeywords:反擊>提高 <WeaponEffect_Num:[StateArg1]%>，暴擊率和暴擊傷害提高 <WeaponEffect_Num:[StateArg2]%>。"
  },
  State_2460_WeaponDesc = {
    Text = "裝備者造成的基礎傷害、<IntoxicationIconKeywords:中毒>和<RetaliateIconKeywords:反擊>提高 <WeaponEffect_Num:[StateArg1]%>，暴擊率和暴擊傷害提高 <WeaponEffect_Num:[StateArg2]%>。"
  },
  State_2461_Desc = {
    Text = "本場戰鬥受到致死傷害時，復活，回復 [Layer] 點生命並使所有喚醒體獲得 [StateArg1] 點狂氣，無法驅散。"
  },
  State_2461_Name = {
    Text = "不死的極樂鳥"
  },
  State_2463_Desc = {
    Text = "戰鬥開始時胚胎融合+20%。每有一名喚醒體狂氣已滿，胚胎融合額外+20%。"
  },
  State_24640_Desc = {
    Text = "戰鬥開始後，胚胎融合 +[Blood:DescArg1]，每次觸發死亡抵抗，胚胎融合 +[Blood:DescArg1]。索蕾爾每次造成傷害，使本回合內自身造成傷害提升等同於攻擊力 4% 點。"
  },
  State_24654_Desc = {
    Text = "達芙黛爾以任何方式擊殺敵人後使隊伍在本次關卡中暴擊率永久提高 5%，最多堆疊 5 次。（當前堆疊 [DescArg1] 次）"
  },
  State_24654_Name = {
    Text = "貪婪灰霧"
  },
  State_2466_Desc = {
    Text = "直到下個回合開始，每承受 1 次攻擊傷害，使觸腕反擊攻擊者 1 次，臨時觸腕傷害 +[Layer]。"
  },
  State_2466_Name = {
    Text = "〔已廢棄〕承自異端之血"
  },
  State_24678_Name = {
    Text = "狀態@N的分身@呢喃2狀態切換"
  },
  State_24679_Name = {
    Text = "狀態@N的分身3@呢喃6狀態切換"
  },
  State_2467_Desc = {
    Text = "狀態@序章攻勢推演"
  },
  State_2467_Name = {
    Text = "狀態@序章攻勢推演"
  },
  State_2467_WeaponDesc = {
    Text = "狀態@序章攻勢推演"
  },
  State_24680_Name = {
    Text = "狀態@N的分身2@呢喃1狀態切換"
  },
  State_24681_Name = {
    Text = "狀態@N的分身@呢喃6狀態切換"
  },
  State_24682_Name = {
    Text = "狀態@N的分身3@呢喃3狀態切換"
  },
  State_24683_Name = {
    Text = "狀態@N的分身2@呢喃2狀態切換"
  },
  State_24684_Name = {
    Text = "狀態@N的分身@呢喃4狀態切換"
  },
  State_24685_Name = {
    Text = "狀態@N的分身@呢喃5狀態切換"
  },
  State_24686_Name = {
    Text = "狀態@N的分身3@呢喃5狀態切換"
  },
  State_24687_Name = {
    Text = "狀態@N的分身3@呢喃2狀態切換"
  },
  State_24688_Name = {
    Text = "狀態@N的分身2@呢喃6狀態切換"
  },
  State_24689_Name = {
    Text = "狀態@N的分身3@呢喃4狀態切換"
  },
  State_24690_Name = {
    Text = "狀態@N的分身3@呢喃1狀態切換"
  },
  State_24691_Name = {
    Text = "狀態@N的分身2@呢喃4狀態切換"
  },
  State_24692_Name = {
    Text = "狀態@N的分身2@呢喃3狀態切換"
  },
  State_24693_Name = {
    Text = "狀態@N的分身@呢喃3狀態切換"
  },
  State_24694_Name = {
    Text = "狀態@N的分身2@呢喃5狀態切換"
  },
  State_2470_Desc = {
    Text = "拾取時永久失去 [Arg1] 點戒備，造成的主動傷害額外享受 1 倍力量加成。"
  },
  State_24719_Desc = {
    Text = "「@2」已以解放之姿現世，生命變為原來的 3 倍。"
  },
  State_24719_Name = {
    Text = "命運復甦"
  },
  State_24719_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_2471_Desc = {
    Text = "回合開始時，我方隊伍降低 1 戒備。"
  },
  State_2471_Name = {Text = "腐蝕"},
  State_2471_WeaponDesc = {
    Text = "回合開始時，我方隊伍降低 1 戒備。"
  },
  State_24720_Desc = {
    Text = "未知存在的力量仍蟄伏黑池之下，即將被擊敗前將徹底復甦，回復生命並以解放之姿開始戰鬥。"
  },
  State_24720_Name = {Text = "蟄伏"},
  State_2472_Desc = {
    Text = "同時對護盾和生命造成傷害，且無法被免疫。"
  },
  State_2472_Name = {
    Text = "<PunctureDamagewords:穿刺傷害>"
  },
  State_2472_WeaponDesc = {
    Text = "穿刺傷害無視目標護盾、減傷阻擋，直接造成傷害。"
  },
  State_24730_Desc = {
    Text = "臨時增加超維空間，上限為 10。下次進入超維回合後，臨時超維空間中的卡牌將會置入手中，移除臨時超維空間。"
  },
  State_24730_Name = {
    Text = "<CardKeyWord:臨時超維空間>"
  },
  State_24737_Desc = {
    Text = "回合開始時，對對方造成出血，每 1 層命運會造成 [StateArg1] 點出血"
  },
  State_24737_Name = {Text = "命運"},
  State_24738_Desc = {
    Text = "每 1 層命運在生效時會造成 [StateArg1] 點出血，每打出 1 張卡牌會減少 1 層命運"
  },
  State_24738_Name = {Text = "命運"},
  State_24739_Name = {Text = "命運"},
  State_2473_Desc = {
    Text = "[防禦]失去 1 條觸腕，回復 [StateArg1] 生命。[打擊]失去 [StateArg2] 生命，生成 1 條觸腕。"
  },
  State_2473_Name = {
    Text = "造物長生者血肉"
  },
  State_2473_WeaponDesc = {
    Text = "[防禦]失去 1 條觸腕，回復 [StateArg1] 生命。[打擊]失去 [StateArg2] 生命，生成 1 條觸腕。"
  },
  State_2474_Desc = {
    Text = "提高[Layer]%攻擊力。"
  },
  State_2474_Name = {
    Text = "通用攻擊力百分比提高"
  },
  State_2474_WeaponDesc = {
    Text = "提高[Layer]%攻擊力。"
  },
  State_2475_Desc = {
    Text = "隊伍唯一：裝備者造成的主動傷害提高等同於裝備者攻擊力 <WeaponEffect_Num:[StateArg3]%> 。每打出或棄掉裝備者的 1 張指令卡後、對隨機敵人造成等同於裝備者攻擊力 <WeaponEffect_Num:[StateArg1]%> 的<IntoxicationIconKeywords:中毒>。超維回合結束後、有 <WeaponEffect_Num:[StateArg2]%> 機率觸發所有敵人 100％ 中毒。"
  },
  State_2475_WeaponDesc = {
    Text = "裝備者造成的主動傷害提高 <WeaponEffect_Num:[DescArg2]> 點。每打出或棄掉裝備者的 1 張指令卡後、對隨機敵人造成 <WeaponEffect_Num:[DescArg1]> 層<IntoxicationIconKeywords:中毒>。超維回合結束後、有 <WeaponEffect_Num:[StateArg2]%> 機率觸發所有敵人 [DescArg3]% 中毒。"
  },
  State_2476_Name = {
    Text = "狀態@本源知者啟靈1"
  },
  State_2478_Desc = {
    Text = "鸚鵡螺施加的護盾翻倍。"
  },
  State_2478_Name = {
    Text = "維修大師"
  },
  State_2478_WeaponDesc = {
    Text = "鸚鵡螺施加的護盾翻倍。"
  },
  State_2479_Desc = {
    Text = "翠火每次造成傷害，層數+1"
  },
  State_2479_Name = {
    Text = "翡翠映射計數"
  },
  State_2479_WeaponDesc = {
    Text = "翠火每次造成傷害，層數+1"
  },
  State_2480_Desc = {
    Text = "回復生命時獲得 [StateArg1] 反擊。沉淵者每出 1 張牌，回復 1 點生命。"
  },
  State_2480_Name = {
    Text = "蛻變之軀"
  },
  State_2481_Desc = {
    Text = "狀態@序章重置牌庫0_2_3_1"
  },
  State_2481_Name = {
    Text = "狀態@序章重置牌庫0_2_3_1"
  },
  State_2481_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_2_3_1"
  },
  State_2482_Desc = {
    Text = "生命低於50%召喚1個等量生命的融蝕三角中"
  },
  State_2482_Name = {Text = "召喚"},
  State_2482_WeaponDesc = {
    Text = "生命低於50%召喚1個等量生命的融蝕三角中"
  },
  State_2486_Desc = {
    Text = "回合開始時每有 1 名敵人就獲得 1 算力。主動傷害擊殺敵人時，對其他敵人造成等同於過量傷害的出血。"
  },
  State_24879_Desc = {
    Text = "一千年過去，一萬年過去，它們在永暗的廢墟中靜待蒙寵。死亡後立即減少「N」的 1 層 「混沌」，並使「N」獲得 [DescArg1] 點護盾和 [DescArg2] 點力量。"
  },
  State_24879_Name = {
    Text = "虛妄分身"
  },
  State_2488_Desc = {
    Text = "每使用一張「增益卡」/ 「症狀卡」/「狀態卡」，狂氣最低的喚醒體獲得 10 狂氣。"
  },
  State_2489_Desc = {
    Text = "暴擊率提高 10%。每回合首次暴擊後使暴擊率額外提高 20%，每回合造成第 3 次暴擊後使暴擊傷害額外提高 50%。"
  },
  State_2490_Desc = {
    Text = "每層使攻擊次數加1，受到傷害失去一層，回合結束時失去全部。"
  },
  State_2490_Name = {Text = "祈禱"},
  State_2491_Desc = {
    Text = "回復生命時獲得等量護盾。"
  },
  State_2491_Name = {
    Text = "臨時硬化"
  },
  State_2492_Desc = {
    Text = "每回合免疫首次主動傷害。"
  },
  State_2492_Name = {Text = "堅定"},
  State_2492_WeaponDesc = {
    Text = "每回合免疫首次主動傷害。"
  },
  State_2493_Desc = {
    Text = "造成的主動傷害降低 [Layer] 點。"
  },
  State_2494_Desc = {
    Text = "狀態@序章狂氣0_1_4_1"
  },
  State_2494_Name = {
    Text = "狀態@序章狂氣0_1_4_1"
  },
  State_2494_WeaponDesc = {
    Text = "狀態@序章狂氣0_1_4_1"
  },
  State_2495_Desc = {
    Text = "狀態@序章狂氣0_1_4_2"
  },
  State_2495_Name = {
    Text = "狀態@序章狂氣0_1_4_2"
  },
  State_2495_WeaponDesc = {
    Text = "狀態@序章狂氣0_1_4_2"
  },
  State_24968_Desc = {
    Text = "戰鬥開始後，胚胎融合 +[Blood:DescArg2]，每次觸發死亡抵抗，胚胎融合 +[Blood:DescArg2]。索蕾爾每次造成傷害，使本回合內自身造成傷害提升 [DescArg1] 點。"
  },
  State_2496_Desc = {
    Text = "回合開始時回復 [Arg1] 生命。如果生命低於 50% ，回復生命變為 [Arg2]。"
  },
  State_2496_Name = {
    Text = "恩賜之血"
  },
  State_24976_Desc = {
    Text = "「凸月侍女」已經覺醒，小心特製料理帶來的危害！"
  },
  State_24976_Name = {
    Text = "珈倫覺醒！"
  },
  State_24976_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_24977_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_24977_Name = {
    Text = "尚未覺醒"
  },
  State_2497_Desc = {
    Text = "莉莉會模仿玩家每回合打出的第一張指令卡。若是打擊卡莉莉攻擊次數+1，若是防禦卡莉莉獲得10%生命的護盾，若是其他指令卡，莉莉也不知道發生了什麼會先放一隻膿皰在這裡。"
  },
  State_2497_Name = {
    Text = "莉莉覺醒！"
  },
  State_2497_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_2498_Name = {
    Text = "飾品詛咒兔"
  },
  State_2498_WeaponDesc = {
    Text = "裝備者造成的護盾與生命回復提高 6%。若裝備者界域精通大於 50，護盾與生命回復額外提高 6%。"
  },
  State_2499_Name = {
    Text = "凝滯詛咒"
  },
  State_2500_Desc = {
    Text = "每次造成實際傷害時，附加中毒。"
  },
  State_2501_Desc = {
    Text = "隊伍唯一：隊伍生命上限提高 10%。裝備者造成的治療和護盾提高 <WeaponEffect_Num:[StateArg3]%>。打出裝備者的「打擊」後，回復 <WeaponEffect_Num:[StateArg1]%> 已損失生命。打出裝備者的「防禦」後，獲得 <WeaponEffect_Num:[StateArg2]%> 當前生命的護盾。該效果每回合最多各觸發 1 次。"
  },
  State_2501_Name = {
    Text = "靈魂誕生"
  },
  State_2501_WeaponDesc = {
    Text = "隊伍生命上限提高 10%。裝備者造成的治療和護盾提高 <WeaponEffect_Num:[StateArg3]%>。打出裝備者的「打擊」後，回復 [StateArg1]%(<WeaponEffect_Num:[Heal:DescArg1]>) 已損失生命。打出裝備者的「防禦」後，獲得[StateArg1]%(<WeaponEffect_Num:[Block:DescArg2]>) 當前生命的護盾。該效果每回合最多各觸發 1 次。"
  },
  State_2502_Desc = {
    Text = "造成的主動和觸腕傷害降低 50 %。"
  },
  State_2502_Name = {
    Text = "寂滅虛弱"
  },
  State_2502_WeaponDesc = {
    Text = "造成的所有傷害降低 50 %。"
  },
  State_2503_Desc = {
    Text = "隊伍唯一：裝備者卡牌造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。回合開始時，有 <WeaponEffect_Num:[StateArg2]%> 的幾率生成一張裝備者的隨機卡牌到手牌中，附加消耗。若當前界域為「血肉」，對裝備者使用「胚胎」時，使裝備者本回合下次打擊卡造成傷害的暴擊率 <WeaponEffect_Num:+[StateArg3]%>。"
  },
  State_2503_WeaponDesc = {
    Text = "裝備者卡牌造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。回合開始時，有 <WeaponEffect_Num:[StateArg2]%> 的幾率生成一張裝備者的隨機卡牌到手牌中，附加消耗。若當前界域為「血肉」，對裝備者使用「胚胎」時，使裝備者本回合下次打擊卡造成傷害的暴擊率 <WeaponEffect_Num:+[StateArg3]%>。"
  },
  State_2504_Desc = {
    Text = "「打擊」獲得 2 點算力，隨機棄 1 張牌；「防禦」抽 2 張牌，失去 1 點算力。"
  },
  State_25056_Desc = {
    Text = "每次消耗算力，就使珈倫獲得 [Layer] 點臨時力量"
  },
  State_25056_Name = {
    Text = "吃飽喝足"
  },
  State_25057_Desc = {
    Text = "每次消耗算力，就使珈倫獲得 [StateArg1] 點臨時力量，回合結束時移除 1 層。"
  },
  State_25057_Name = {
    Text = "吃飽喝足"
  },
  State_2505_Name = {
    Text = "飾品四月禮讚"
  },
  State_2505_WeaponDesc = {
    Text = "戰鬥開始後，若裝備者職業為超維，攻擊力提高 25%。"
  },
  State_2507_Desc = {
    Text = "拾取時最大生命提高 100%，回合開始時，失去 [Arg1] 點生命。"
  },
  State_2509_Name = {
    Text = "狀態@通用界域精通"
  },
  State_2511_Desc = {
    Text = "狀態@序章鑰能教學"
  },
  State_2511_Name = {
    Text = "狀態@序章鑰能教學"
  },
  State_2511_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_2_2"
  },
  State_2512_Desc = {
    Text = "打出 1 張算力消耗為 3 或以上的卡牌時，抽 1 張牌並獲得 1 點算力。"
  },
  State_2514_Desc = {
    Text = "本場戰鬥內造成的護盾降低 [Layer] 點。"
  },
  State_2514_Name = {
    Text = "戒備降低"
  },
  State_2514_WeaponDesc = {
    Text = "本場戰鬥內造成的護盾降低 [Layer] 點。"
  },
  State_2515_Desc = {
    Text = "[打擊]對所有敵人施加 [StateArg1] 層中毒。"
  },
  State_2515_Name = {
    Text = "造物神經毒素"
  },
  State_25163_Desc = {
    Text = "祂像霧一般令人難以捉摸。"
  },
  State_25165_Desc = {
    Text = "環行·拉蒙娜指令卡獨有的額外效果，擁有 3 層負熵時觸發。回環會繼承至下場戰鬥。"
  },
  State_25165_Name = {
    Text = "<TimeBeacon:回環>"
  },
  State_25166_Desc = {
    Text = "每當擁有 3 層負熵時，打出環行·拉蒙娜的指令卡將消耗所有負熵並觸發回環額外效果，負熵最多堆疊 3 層。"
  },
  State_25166_Name = {
    Text = "<TimeBeacon2:負熵>"
  },
  State_2516_Desc = {
    Text = "無法被打出。"
  },
  State_2516_Name = {
    Text = "無法打出"
  },
  State_2516_WeaponDesc = {
    Text = "卡牌無法打出。"
  },
  State_25179_Name = {
    Text = "狂氣判斷"
  },
  State_2517_Desc = {
    Text = "我方隊伍釋放狂氣爆發後，自身當回合失去力量。一回合一次。"
  },
  State_2517_Name = {
    Text = "畏懼狂氣"
  },
  State_25181_Name = {
    Text = "輪回保留效果"
  },
  State_2518_Desc = {
    Text = "狀態@序章重置牌庫0_1_1_3"
  },
  State_2518_Name = {
    Text = "狀態@序章重置牌庫0_1_1_3"
  },
  State_2518_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_1_3"
  },
  State_25194_Desc = {
    Text = "死亡後為「N」增加 [DescArg1] 點護盾和 [DescArg2] 點永久力量"
  },
  State_2519_Desc = {
    Text = "狀態@序章重置牌庫0_1_1_3"
  },
  State_2519_Name = {
    Text = "狀態@序章重置牌庫0_1_1_3"
  },
  State_2519_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_1_3"
  },
  State_25204_Name = {
    Text = "狀態@N的分身2@意圖判定"
  },
  State_25205_Name = {
    Text = "狀態@N的分身3@意圖判定"
  },
  State_25206_Name = {
    Text = "狀態@N@添加N的分身判定"
  },
  State_25207_Name = {
    Text = "狀態@N的分身@意圖判定"
  },
  State_2520_Desc = {
    Text = "狀態@序章重置牌庫0_1_1_2"
  },
  State_2520_Name = {
    Text = "狀態@序章重置牌庫0_1_1_2"
  },
  State_2520_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_1_2"
  },
  State_2522_Desc = {
    Text = "希洛已經覺醒，攻擊強度和欲望都會得到提升。"
  },
  State_2522_Name = {
    Text = "希洛覺醒"
  },
  State_2523_Desc = {
    Text = "奇數回合開始時，本回合內獲得 [Arg1] 力量。偶數回合開始時，本回合內獲得 [Arg2] 點戒備。"
  },
  State_2524_Desc = {
    Text = "戰鬥開始時，獲得 1 力量"
  },
  State_2524_Name = {
    Text = "威名遠揚"
  },
  State_2525_Desc = {
    Text = "攻擊次數-1，獲得[Layer]點力量"
  },
  State_2525_Name = {Text = "縱欲"},
  State_2527_Name = {
    Text = "猩紅力量加成"
  },
  State_2528_Desc = {
    Text = "打出 1 張實際算力消耗為 3 的卡牌時，抽 1 張牌並獲得 2 算力"
  },
  State_2529_Desc = {
    Text = "本回合內暴擊傷害提高 [Layer] %。"
  },
  State_2529_Name = {
    Text = "臨時暴擊傷害"
  },
  State_2529_WeaponDesc = {
    Text = "本回合內暴擊傷害提高 [Layer] %。"
  },
  State_2531_Desc = {
    Text = "翠火每造成 [Damage:StateArg2] 次傷害，就獲得一張消耗【綠炎】。"
  },
  State_2531_Name = {
    Text = "翡翠映射"
  },
  State_2531_WeaponDesc = {
    Text = "翠火每造成 [Damage:StateArg2] 次傷害，就獲得一張消耗【綠炎】。"
  },
  State_2532_Name = {
    Text = "飾品猩紅之悸"
  },
  State_2534_Desc = {
    Text = "狀態@序章重置牌庫0_1_3_3"
  },
  State_2534_Name = {
    Text = "狀態@序章重置牌庫0_1_3_3"
  },
  State_2534_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_3_3"
  },
  State_2535_Desc = {
    Text = "狀態@序章重置牌庫0_1_3_2"
  },
  State_2535_Name = {
    Text = "狀態@序章重置牌庫0_1_3_2"
  },
  State_2535_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_3_2"
  },
  State_2536_Name = {
    Text = "狀態@臨時打擊卡暴擊傷害提高"
  },
  State_2537_Desc = {
    Text = "空想利刃施加護盾時，獲得 [StateArg2] 點臨時戒備。"
  },
  State_2537_Name = {
    Text = "戰場的卓識"
  },
  State_2537_WeaponDesc = {
    Text = "空想利刃施加護盾時，獲得 [StateArg2] 點臨時戒備。"
  },
  State_2538_Desc = {
    Text = "打出後獲得 [StateArg1] 層反擊，對所有敵人造成 [StateArg2]% 反擊的<FixedDamage:純粹傷害>。"
  },
  State_2538_Name = {
    Text = "<Rune_9_High:高級尖刺>"
  },
  State_25391_Desc = {
    Text = "隊伍中已有一名喚醒體被選為了「幸運觀眾」，該喚醒體的所有卡牌具有「喝彩」效果。"
  },
  State_25391_Name = {
    Text = "幸運觀眾"
  },
  State_25392_Desc = {
    Text = "打出後，失去 2% 最大生命值，大魔術師在本回合獲得 1 層「洋洋得意」。"
  },
  State_25401_Desc = {
    Text = "此卡牌在手牌中時會使手牌上限 +1。"
  },
  State_25401_Name = {
    Text = "無視手牌上限"
  },
  State_25403_Desc = {
    Text = "觸腕傷害降低 50%，每造成 1 次觸腕傷害獲得 [Layer] 點護盾。"
  },
  State_25403_Name = {Text = "靜海"},
  State_25405_Desc = {
    Text = "此卡牌任何情況下都會在手牌中。"
  },
  State_25406_Desc = {
    Text = "本回合內無法再切換觸腕形態"
  },
  State_25406_Name = {
    Text = "深海瘋狂·限制"
  },
  State_25407_Desc = {
    Text = "觸腕傷害提高 25%，回合結束時觸腕數量 -1。"
  },
  State_25407_Name = {
    Text = "深海瘋狂"
  },
  State_25415_Desc = {
    Text = "釋放鑰令後，獲得 [Layer] 點鑰能。"
  },
  State_25415_Name = {
    Text = "混沌臨時鑰能滿溢"
  },
  State_25417_Name = {Text = "炸彈3"},
  State_25418_Name = {Text = "炸彈2"},
  State_2542_Name = {
    Text = "造物無名附肢計數"
  },
  State_2543_Name = {
    Text = "狀態@關卡2_14戰鬥8氣泡1"
  },
  State_2544_Desc = {
    Text = "狀態@序章怪物被動"
  },
  State_2544_Name = {
    Text = "狀態@序章怪物被動"
  },
  State_2544_WeaponDesc = {
    Text = "狀態@序章怪物被動"
  },
  State_2545_Desc = {
    Text = "戰鬥開始時胚胎融合+20%。每有一名喚醒體狂氣已滿，胚胎融合額外+20%。"
  },
  State_2547_Desc = {
    Text = "回合開始時，將一張本回合內獲得 [Arg1] 力量「漁叉」加入手中。釋放狂氣爆發後，使手牌中所有的「漁叉」力量提高 [Arg2]。"
  },
  State_2548_Desc = {
    Text = "免疫一次死亡，觸發後回復 50 生命並使該造物永久失效。"
  },
  State_2548_WeaponDesc = {
    Text = "免疫一次死亡，觸發後回復 50 生命並使該造物永久失效。"
  },
  State_2549_Desc = {
    Text = "降低造成的主動和觸腕傷害。"
  },
  State_2549_WeaponDesc = {
    Text = "每層衰竭使造成的傷害和觸腕傷害降低 1 點。"
  },
  State_2550_Desc = {
    Text = "抽到時使自身脆弱 1 回合。使用後易傷所有敵人 1 回合。無法出售。"
  },
  State_2550_Name = {
    Text = "狀態詛咒崩潰"
  },
  State_2550_WeaponDesc = {
    Text = "抽到時使自身脆弱 1 回合。使用後易傷所有敵人 1 回合。無法出售。"
  },
  State_2552_Desc = {
    Text = "卡牌不會在棄牌階段進入棄牌堆，而是保留在手牌中。"
  },
  State_2552_WeaponDesc = {
    Text = "卡牌不會在棄牌階段進入棄牌堆，而是保留在手牌中。"
  },
  State_2553_Desc = {
    Text = "回合開始時，獲得一點算力"
  },
  State_2553_Name = {
    Text = "造物阿爾卡納算力"
  },
  State_2553_WeaponDesc = {
    Text = "回合開始時，獲得一點算力"
  },
  State_2554_Name = {
    Text = "普特尼晨報"
  },
  State_2556_Desc = {
    Text = "血量降低後，獲得護盾，等同於降低值的 [Layer] %。"
  },
  State_2556_Name = {
    Text = "鮮血護盾"
  },
  State_2556_WeaponDesc = {
    Text = "血量降低後，獲得護盾，等同於降低值的 [Layer] %"
  },
  State_2557_Desc = {
    Text = "下個回合開始時，獲得 [Layer] 點護盾。"
  },
  State_2557_Name = {
    Text = "苦痛與歡愉護盾"
  },
  State_2558_Desc = {
    Text = "當生命低於 50%([StateArg1]) 時，將會分裂為 2 只等量生命的「干涉型融蝕體」。"
  },
  State_2558_WeaponDesc = {
    Text = "當生命低於 50%([StateArg1]) 時，將會分裂為2只等量生命的「II型融蝕體」。"
  },
  State_2559_Desc = {
    Text = "每次受到攻擊後，失去 [Layer] 點臨時力量。"
  },
  State_2559_Name = {
    Text = "衝動的代價"
  },
  State_2560_Desc = {
    Text = "下回合開始後獲得 [Layer] 護盾。"
  },
  State_2560_Name = {
    Text = "封閉創作"
  },
  State_2560_WeaponDesc = {
    Text = "下回合開始後獲得 [Layer] 護盾。"
  },
  State_2561_Desc = {
    Text = "憂鬱才華"
  },
  State_2561_Name = {
    Text = "憂鬱才華"
  },
  State_2561_WeaponDesc = {
    Text = "憂鬱才華"
  },
  State_2562_Name = {
    Text = "狀態@章三_共鳴1_標誌"
  },
  State_2563_Desc = {
    Text = "每打出第 10 張牌時，提高 2 觸腕傷害，使所有觸腕攻擊 1 次。"
  },
  State_2563_Name = {
    Text = "造物漁叉"
  },
  State_2563_WeaponDesc = {
    Text = "每打出第 10 張牌時，提高 2 觸腕傷害，使所有觸腕攻擊 1 次。"
  },
  State_2564_Desc = {
    Text = "獲得的所有護盾降低 [DescArg1] %。"
  },
  State_2564_WeaponDesc = {
    Text = "獲得的所有護盾降低 33 %。"
  },
  State_2565_Name = {
    Text = "飾品猩紅之擁"
  },
  State_2565_WeaponDesc = {
    Text = "裝備者造成傷害時獲得 20 點銀鑰能量，若造成暴擊傷害，改為獲得 50 點銀鑰能量，每回合最多觸發 3 次。"
  },
  State_2566_Desc = {
    Text = "一回合內受到 3 次攻擊後，獲得 1 層臨時<MadnessColour:瘋狂>。"
  },
  State_2567_Desc = {
    Text = "已受到 [Layer] 次傷害，達到 3 次後 「甜蜜惡鬼」本回合內獲得 1 層<MadnessColour:瘋狂>。"
  },
  State_2567_Name = {
    Text = "「甜蜜痛楚」次數"
  },
  State_2567_WeaponDesc = {
    Text = "已受到 [Layer] 次傷害，達到 3 次後 「甜蜜惡鬼」本回合內獲得 1 層瘋狂。"
  },
  State_2569_Desc = {
    Text = "界域推薦加成效果提升為 50%，關卡開始時你的界域精通提高 100。"
  },
  State_2569_Name = {
    Text = "狀態@幻夢銀鑰：適性分離"
  },
  State_2570_Desc = {
    Text = "打出後抽 [StateArg1] 張牌。"
  },
  State_2571_Desc = {
    Text = "隊伍中每有一名【混沌】職業喚醒體，全隊最大生命(未完成)、防禦、攻擊提高 50%"
  },
  State_2571_WeaponDesc = {
    Text = "隊伍中每有一名【混沌】職業喚醒體，全隊最大生命(未完成)、防禦、攻擊提高 50%"
  },
  State_2572_Desc = {
    Text = "打出後胚胎融合 +[StateArg1]。"
  },
  State_2573_Desc = {
    Text = "擁有 5 層【導火線】。打出卡牌後層數減少 1。當層數變為 0 時自爆，造成攻擊力*2.5 的傷害。"
  },
  State_2573_Name = {Text = "爆彈"},
  State_2573_WeaponDesc = {
    Text = "擁有 5 層【導火線】。打出卡牌後層數減少 1。當層數變為 0 時自爆，造成攻擊力*2.5 的傷害。"
  },
  State_2574_Desc = {
    Text = "暴擊傷害+50%。如果某回合沒有進行攻擊，下回合必定暴擊。"
  },
  State_2574_Name = {
    Text = "狀態@幻夢銀鑰：輪舞"
  },
  State_2575_Desc = {
    Text = "隊伍唯一：戰鬥開始時，每擁有一個造物就使裝備者指令卡暴擊率提高 [StateArg1]%。裝備者釋放狂氣爆發後投一顆 4 面骰子，裝備者獲得 <WeaponEffect_Num:[StateArg2]> 倍骰子點數的狂氣和臨時暴擊傷害，若其投出 4 或以上，其他喚醒體也獲得一半。"
  },
  State_2575_WeaponDesc = {
    Text = "戰鬥開始時，每擁有一個造物就使裝備者指令卡暴擊率提高 [StateArg1]%。裝備者釋放狂氣爆發後投一顆 4 面骰子，裝備者獲得 <WeaponEffect_Num:[StateArg2]> 倍骰子點數的狂氣和臨時暴擊傷害，若其投出 4 或以上，其他喚醒體也獲得一半。"
  },
  State_2576_Desc = {
    Text = "每當一張卡牌進入超維空間，使其算力消耗 -1。"
  },
  State_2579_Desc = {
    Text = "本回合內造成的主動傷害次數提高[Layer] 。"
  },
  State_2579_Name = {
    Text = "<MadnessColour:臨時瘋狂>"
  },
  State_2580_Desc = {
    Text = "每當獵顱魔女的卡牌進入或離開超維空間，獲得 1算力。"
  },
  State_2580_Name = {
    Text = "維度投射"
  },
  State_2581_Desc = {
    Text = "所有喚醒體銀鑰充能提高 30。釋放鑰令後，將 3 張<DerivativeCardKeywords_4:「靈感」>洗入你的牌庫。"
  },
  State_2581_Name = {
    Text = "狀態@時靈擺洞悉"
  },
  State_2582_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_2582_Name = {
    Text = "狀態@試作鐳射炮狂氣"
  },
  State_2583_Desc = {
    Text = "每次收到主動傷害給我方隊伍增加一層計數"
  },
  State_2583_Name = {
    Text = "狀態@復仇巨刃斬首重創計數"
  },
  State_2583_WeaponDesc = {
    Text = "每次收到主動傷害給我方隊伍增加一層計數"
  },
  State_2584_Desc = {
    Text = "每次牌庫重置，獲得 [Arg1] 力量。"
  },
  State_2586_Desc = {
    Text = "獲得的所有護盾降低 25 %，回合結束時移除 1 層。"
  },
  State_2586_WeaponDesc = {
    Text = "獲得的所有護盾降低 25 %。"
  },
  State_2587_Desc = {
    Text = "傷口傷害翻倍。每次造成實際傷害，都會獲得[Layer]點護盾。"
  },
  State_2587_Name = {
    Text = "「噬天利齒」"
  },
  State_2587_WeaponDesc = {
    Text = "傷口傷害翻倍。每次造成實際傷害，都會獲得[Layer]點護盾。"
  },
  State_2588_Desc = {
    Text = "回合結束後，受到 [Layer] 點<FixedDamage:純粹傷害>並移除該狀態。回復生命時移除雙倍回覆量的出血層數。"
  },
  State_2588_WeaponDesc = {
    Text = "回合結束後，受到[Layer]點傷害並移除該狀態，每次治療可使層數減半。"
  },
  State_2589_Name = {
    Text = "飾品扭曲雙子黑"
  },
  State_2589_WeaponDesc = {
    Text = "奇數回合開始後，將一張附加虛無和消耗的裝備者的「打擊」加入手牌。"
  },
  State_2590_Desc = {
    Text = "移動時獲得 10 黑印"
  },
  State_2590_Name = {
    Text = "造物無底袋"
  },
  State_2590_WeaponDesc = {
    Text = "移動時獲得 10 黑印"
  },
  State_2592_Desc = {
    Text = "每失去 1 點生命移除 1 層，層數為 0 時獲得 [DescArg1] 的護盾。"
  },
  State_2592_Name = {
    Text = "維度壁障"
  },
  State_2593_Name = {
    Text = "狀態@猩紅血與沙的讚歌"
  },
  State_2594_Desc = {
    Text = "造成實際傷害獲得護盾"
  },
  State_2594_Name = {
    Text = "「噬天利齒」"
  },
  State_2594_WeaponDesc = {
    Text = "造成實際傷害獲得護盾"
  },
  State_2595_Desc = {
    Text = "每造成 1 次傷害，就獲得 [StateArg2] 點臨時力量。"
  },
  State_2595_Name = {
    Text = "知者女王之劍啟"
  },
  State_2597_Desc = {
    Text = "回合開始後，獲得 [Layer] 點護盾。"
  },
  State_2597_Name = {
    Text = "延遲護盾"
  },
  State_2597_WeaponDesc = {
    Text = "回合開始後，獲得 [Layer] 點護盾。"
  },
  State_2600_Desc = {
    Text = "每當你失去生命時，狂氣最低的喚醒體獲得 10 狂氣。每當你失去 5 次生命時，獲得 1 層屏障。"
  },
  State_2600_Name = {
    Text = "時靈擺「解析」"
  },
  State_2601_Desc = {
    Text = "偶數回合受傷降低 50%，傷害提高 33%。"
  },
  State_2601_Name = {Text = "善變"},
  State_2601_WeaponDesc = {
    Text = "偶數回合受傷降低 50%，傷害提高 33%。"
  },
  State_2602_Desc = {
    Text = "你被鎖定了！打出後永恆狂熱者獲得 [StateArg1] 點臨時力量，移除該指令的深潛印記。"
  },
  State_2602_Name = {
    Text = "<CardKeyWord:深潛印記>"
  },
  State_2602_WeaponDesc = {
    Text = "卡牌打出後深潛者精英獲得 [StateArg1] 點臨時力量。"
  },
  State_2603_Desc = {
    Text = "若手牌中存在「胚胎」，消耗所有「胚胎」，每 1 張胚胎觸發 1 次後續效果。"
  },
  State_2603_Name = {
    Text = "<UnlimitedDevouredIconKeywords:無限吞噬>"
  },
  State_2604_Desc = {
    Text = "本回合內暴擊率提高 [Layer] %。"
  },
  State_2604_Name = {
    Text = "臨時暴擊率"
  },
  State_2604_WeaponDesc = {
    Text = "本回合內暴擊率提高 [Layer] %。"
  },
  State_2605_Desc = {
    Text = "當生命低於95%([StateArg1]) 時，將會分裂為2只等量生命的「實驗習作」。"
  },
  State_2605_WeaponDesc = {
    Text = "當生命低於 30%([StateArg1]) 時，將會分裂為3只等量生命的「II型融蝕體蠟像」。"
  },
  State_2606_Desc = {
    Text = "當生命低於90%([StateArg1]) 時，將會分裂為2只等量生命的「實驗習作」。"
  },
  State_2606_WeaponDesc = {
    Text = "當生命低於 30%([StateArg1]) 時，將會分裂為3只等量生命的「II型融蝕體蠟像」。"
  },
  State_2607_Desc = {
    Text = "戰鬥結束時，回復 5 生命。"
  },
  State_2607_Name = {
    Text = "凸月侍女啟靈3"
  },
  State_2607_WeaponDesc = {
    Text = "戰鬥結束時，回復 5 生命。"
  },
  State_2609_Desc = {
    Text = "當生命低於30%([StateArg1]) 時，將會分裂為2只等量生命的「實驗習作」。"
  },
  State_2609_WeaponDesc = {
    Text = "當生命低於 30%([StateArg1]) 時，將會分裂為3只等量生命的「II型融蝕體蠟像」。"
  },
  State_2610_Desc = {
    Text = "當生命低於70%([StateArg1]) 時，將會分裂為2只等量生命的「實驗習作」。"
  },
  State_2610_WeaponDesc = {
    Text = "當生命低於 30%([StateArg1]) 時，將會分裂為3只等量生命的「II型融蝕體蠟像」。"
  },
  State_2611_Desc = {
    Text = "當生命低於50%([StateArg1]) 時，將會分裂為2只等量生命的「實驗習作」。"
  },
  State_2611_WeaponDesc = {
    Text = "當生命低於 30%([StateArg1]) 時，將會分裂為3只等量生命的「II型融蝕體蠟像」。"
  },
  State_2612_Desc = {
    Text = "遠古者模仿"
  },
  State_2612_Name = {
    Text = "遠古者模仿"
  },
  State_2612_WeaponDesc = {
    Text = "遠古者模仿"
  },
  State_2614_Desc = {
    Text = "隊伍唯一：打出裝備者的指令卡後，有 <WeaponEffect_Num:[StateArg1]%> 的機率將其從棄牌堆重新加入手牌，該效果單個回合只生效 1 次。"
  },
  State_2614_WeaponDesc = {
    Text = "打出裝備者的指令卡後，有 <WeaponEffect_Num:[StateArg1]%> 的機率將其從棄牌堆重新加入手牌。該效果單個回合只生效 1 次。"
  },
  State_2617_Desc = {
    Text = "下回合開始時、額外抽 [DescArg1] 張牌。"
  },
  State_2617_Name = {
    Text = "症狀：興奮"
  },
  State_2619_Desc = {
    Text = "本場戰鬥內造成的主動傷害降低 [Layer] 點。"
  },
  State_2619_WeaponDesc = {
    Text = "本場戰鬥內造成的傷害降低 [Layer] 點。"
  },
  State_2620_Desc = {
    Text = "造物銹蝕柳葉刀"
  },
  State_2620_Name = {
    Text = "銹蝕柳葉刀"
  },
  State_2623_Desc = {
    Text = "回合開始時獲得 1 算力。"
  },
  State_2624_Desc = {
    Text = "打出後使所有敵人失去 [StateArg1] 點臨時力量。"
  },
  State_2625_Desc = {
    Text = "你的躍遷效果觸發兩次。進入超維回合時，所有敵人獲得 5 點臨時力量。"
  },
  State_2625_Name = {
    Text = "造物噩夢魂燈"
  },
  State_2626_Desc = {
    Text = "觸腕上限減少 1 條。回合結束時額外使所有觸腕攻擊 1 次。"
  },
  State_2627_Name = {
    Text = "獲得 [StateArg1] 鑰能"
  },
  State_2627_WeaponDesc = {
    Text = "在“未完的蠟像”節點選擇的卡牌獲得鑰能"
  },
  State_2628_Desc = {
    Text = "在“未完的蠟像”處複製的卡牌獲得刻印效果"
  },
  State_2628_Name = {
    Text = "狀態@章二_共鳴3"
  },
  State_2628_WeaponDesc = {
    Text = "在“未完的蠟像”節點複製的卡牌獲得刻印效果"
  },
  State_2629_Desc = {
    Text = "在“未完的蠟像”處發現可複製卡牌範圍增加"
  },
  State_2629_Name = {
    Text = "狀態@章二_共鳴2"
  },
  State_2629_WeaponDesc = {
    Text = "在“未完的蠟像”節點複製的卡牌及其本體獲得“固有”效果"
  },
  State_2630_Desc = {
    Text = "在“未完的蠟像”處複製的卡牌及其本體獲得“保留”效果"
  },
  State_2630_Name = {
    Text = "狀態@章二_共鳴4"
  },
  State_2630_WeaponDesc = {
    Text = "在“未完的蠟像”節點複製的卡牌及其本體獲得“保留”效果"
  },
  State_2631_Desc = {
    Text = "在“未完的蠟像”處多複製一張卡牌"
  },
  State_2631_Name = {
    Text = "狀態@章二_共鳴6"
  },
  State_2631_WeaponDesc = {
    Text = "在“未完的蠟像”節點多複製一張卡牌"
  },
  State_2633_Desc = {
    Text = "每受到 1 次主動傷害，將 1 張【綠炎】置入手中並使其獲得「消耗」，持續 [Layer] 回合。"
  },
  State_2633_Name = {
    Text = "誘蛾之火"
  },
  State_2633_WeaponDesc = {
    Text = "下回合前每次被攻擊就將一張消耗【綠炎】加入手牌。"
  },
  State_2634_Desc = {
    Text = "打出卡牌時受到 [StateArg1] 點傷害並移除 1 層。層數為 0 時孵化一個較弱的「海中之物」。若回合結束時仍存在被寄生狀態，孵化一個生命隨層數提高的「海中之物」。"
  },
  State_2635_Desc = {
    Text = "狀態@序章攻勢推演標識"
  },
  State_2635_Name = {
    Text = "狀態@序章攻勢推演標識"
  },
  State_2635_WeaponDesc = {
    Text = "狀態@序章攻勢推演標識"
  },
  State_2636_Name = {
    Text = "狀態@第四章共鳴@生效下回合抽牌數1"
  },
  State_2637_Desc = {
    Text = "回合開始時獲得 [StateArg1] 算力。"
  },
  State_2637_WeaponDesc = {
    Text = "回合開始時獲得 [StateArg1] 算力。"
  },
  State_2639_Desc = {
    Text = "在戰鬥中受到致命傷害時有機率保留 1 點生命。觸發後在本次調查中機率減半，獲得的死亡抵抗減半。"
  },
  State_2640_Name = {
    Text = "通用重複生效1次"
  },
  State_2645_Desc = {
    Text = "狀態@序章怪物被動1"
  },
  State_2645_Name = {
    Text = "狀態@序章怪物被動1"
  },
  State_2645_WeaponDesc = {
    Text = "狀態@序章怪物被動1"
  },
  State_2646_Desc = {
    Text = "狀態@序章怪物被動2"
  },
  State_2646_Name = {
    Text = "狀態@序章怪物被動2"
  },
  State_2646_WeaponDesc = {
    Text = "狀態@序章怪物被動2"
  },
  State_2647_Desc = {
    Text = "狀態@序章怪物被動3"
  },
  State_2647_Name = {
    Text = "狀態@序章怪物被動3"
  },
  State_2647_WeaponDesc = {
    Text = "狀態@序章怪物被動3"
  },
  State_2648_Desc = {
    Text = "狀態@序章怪物被動4"
  },
  State_2648_Name = {
    Text = "狀態@序章怪物被動4"
  },
  State_2648_WeaponDesc = {
    Text = "狀態@序章怪物被動4"
  },
  State_2649_Desc = {
    Text = "狀態@序章怪物被動5"
  },
  State_2649_Name = {
    Text = "狀態@序章怪物被動5"
  },
  State_2649_WeaponDesc = {
    Text = "狀態@序章怪物被動5"
  },
  State_2650_Desc = {
    Text = "狀態@序章怪物被動6"
  },
  State_2650_Name = {
    Text = "狀態@序章怪物被動6"
  },
  State_2650_WeaponDesc = {
    Text = "狀態@序章怪物被動6"
  },
  State_2651_Desc = {
    Text = "狀態@序章怪物被動7"
  },
  State_2651_Name = {
    Text = "狀態@序章怪物被動7"
  },
  State_2651_WeaponDesc = {
    Text = "狀態@序章怪物被動7"
  },
  State_2652_Desc = {
    Text = "狀態@序章怪物被動8"
  },
  State_2652_Name = {
    Text = "狀態@序章怪物被動8"
  },
  State_2652_WeaponDesc = {
    Text = "狀態@序章怪物被動8"
  },
  State_2653_Desc = {
    Text = "狀態@序章怪物被動9"
  },
  State_2653_Name = {
    Text = "狀態@序章怪物被動9"
  },
  State_2653_WeaponDesc = {
    Text = "狀態@序章怪物被動9"
  },
  State_2655_Desc = {
    Text = "造成未被格擋的傷害時，回復等量生命，造成傷害時移除。"
  },
  State_2656_Desc = {
    Text = "下回合開始就溜！！！！！！"
  },
  State_2660_Desc = {
    Text = "戰鬥開始時，獲得力量，但每次受到的傷害提高 5。"
  },
  State_2661_Desc = {
    Text = "戰鬥開始時，所有敵人失去 [Arg1] 點力量。"
  },
  State_2662_Name = {
    Text = "狀態@章三_測試狀態"
  },
  State_2663_Desc = {
    Text = "抽到時使自身虛弱 1 回合。使用後虛弱所有敵人 1 回合。無法出售。"
  },
  State_2663_Name = {
    Text = "狀態詛咒衰弱"
  },
  State_2663_WeaponDesc = {
    Text = "抽到時使自身虛弱 1 回合。使用後虛弱所有敵人 1 回合。無法出售。"
  },
  State_2666_Name = {
    Text = "輪回匕首暴擊率"
  },
  State_2667_Desc = {
    Text = "打擊牌傷害提高 [Layer] %。"
  },
  State_2667_Name = {
    Text = "打擊牌傷害提高"
  },
  State_2667_WeaponDesc = {
    Text = "打擊牌傷害提高 [Layer] %。"
  },
  State_2668_Desc = {
    Text = "提高[Layer]%攻擊力。"
  },
  State_2668_Name = {
    Text = "通用永久攻擊力百分比提高"
  },
  State_2668_WeaponDesc = {
    Text = "提高[Layer]%攻擊力。"
  },
  State_2669_Desc = {
    Text = "本場戰鬥內暴擊傷害提高 [Layer] %。"
  },
  State_2669_Name = {
    Text = "暴擊傷害"
  },
  State_2670_Desc = {
    Text = "你造成虛弱時，獲得 [Arg1] 點護盾；造成易傷時，獲得 [Arg2] 點力量。若在 1 回合內觸發了這兩個效果，額外獲得 [Arg1] 點護盾和 [Arg2] 點力量。"
  },
  State_2670_Name = {
    Text = "沉重畫框"
  },
  State_2671_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_2671_Name = {
    Text = "尚未覺醒"
  },
  State_2672_Desc = {
    Text = "每回合開始時，對我方隊伍施加層【束縛】。"
  },
  State_2672_Name = {Text = "束縛"},
  State_2672_WeaponDesc = {
    Text = "每回合開始時，對我方隊伍施加層【束縛】。"
  },
  State_2674_Desc = {
    Text = "本回合內暴擊率提高 [Layer] %。"
  },
  State_2674_Name = {
    Text = "臨時暴擊率"
  },
  State_2676_Name = {
    Text = "飾品猩紅之悸"
  },
  State_2676_WeaponDesc = {
    Text = "釋放鑰令後，裝備者獲得 15% 臨時暴擊率。若裝備者當前暴擊傷害大於 80%，額外獲得 15% 臨時暴擊率。"
  },
  State_2677_Desc = {
    Text = "每回合前3次受到主動/觸腕的傷害降低75%。"
  },
  State_2677_Name = {
    Text = "「不滅殘軀」"
  },
  State_2677_WeaponDesc = {
    Text = "每回合前3次受到主動/觸腕的傷害降低75%。"
  },
  State_2679_Name = {
    Text = "狀態@章三_共鳴7_標誌"
  },
  State_2680_Desc = {
    Text = "暴擊率提高 20%。回合開始時若生命低於 25%，本回合必定暴擊。"
  },
  State_2681_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_2681_Name = {
    Text = "尚未覺醒"
  },
  State_2682_Desc = {
    Text = "護盾和治療強效提高 50%。"
  },
  State_2682_Name = {
    Text = "異化花園守護者"
  },
  State_2682_WeaponDesc = {
    Text = "護盾和治療強效提高 50%。"
  },
  State_2683_Desc = {
    Text = "抽狀態層數的牌。"
  },
  State_2684_Desc = {
    Text = "隊伍唯一：裝備者的「打擊」有 <WeaponEffect_Num:[StateArg1]%> 機率獲得 1 隻算力並觸發所有敵人 10％ 的<IntoxicationIconKeywords:中毒>、若當前界域為「深海」、觸發該效果時使 1 條觸腕攻擊 1 次。該效果單個回合只生效 1 次。"
  },
  State_2684_WeaponDesc = {
    Text = "裝備者的「打擊」有 <WeaponEffect_Num:[StateArg1]%> 機率獲得 1 點算力並觸發所有敵人 [DescArg1]% 的<IntoxicationIconKeywords:中毒>、若當前界域為「深海」、觸發該效果時使 1 條觸腕攻擊 1 次。該效果每回合最多觸發 1 次。"
  },
  State_2685_Desc = {
    Text = "免疫虛弱、脆弱和易傷狀態，回合結束時移除 1 層。"
  },
  State_2685_WeaponDesc = {
    Text = "本回合內免疫對己方施加的負面狀態。"
  },
  State_2686_Desc = {
    Text = "戰鬥中給予的臨時卡牌。"
  },
  State_2686_Name = {
    Text = "<CardKeyWord:狀態卡>"
  },
  State_2687_Desc = {
    Text = "本回合內暴擊率提升100%"
  },
  State_2687_Name = {
    Text = "臨時必爆"
  },
  State_2687_WeaponDesc = {
    Text = "本回合內暴擊率提升100%"
  },
  State_2688_Desc = {
    Text = "每回合打出第 3 張卡牌後，將 1 張「靈感」置入棄牌堆。每回合打出第 6 張卡牌後，從棄牌堆中將 1 張「靈感」置入手牌。"
  },
  State_2689_Desc = {
    Text = "回合開始時抽 2 張牌。超維卡槽容量提高 2。"
  },
  State_2689_Name = {
    Text = "造物詭術師的禮帽"
  },
  State_2689_WeaponDesc = {
    Text = "回合開始時抽 2 張牌。超維卡槽容量提高 2。"
  },
  State_2690_Desc = {
    Text = "美德騎士打出卡牌時，獲得 [StateArg1] 點力量。"
  },
  State_2690_Name = {
    Text = "騎士熱誠"
  },
  State_2691_Desc = {
    Text = "隊伍唯一：裝備者釋放狂氣爆發後，獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣與 <WeaponEffect_Num:[StateArg2]> 點銀鑰能量，每有 4 張手牌就重複 1 次。若當前界域為「超維」時，裝備者的卡牌進入超維空間後，獲得等同於裝備者攻擊力 <WeaponEffect_Num:[StateArg3]%> 的臨時力量，每回合最多觸發 2 次。"
  },
  State_2691_WeaponDesc = {
    Text = "裝備者釋放狂氣爆發後，獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣與 <WeaponEffect_Num:[StateArg2]> 點銀鑰能量，每有 4 張手牌就重複 1 次。若當前界域為「超維」時，裝備者的卡牌進入超維空間後，獲得 <WeaponEffect_Num:[Power:DescArg1]> 點臨時力量，每回合最多觸發 2 次。"
  },
  State_2693_Desc = {
    Text = "狀態@序章狂氣0_1_2效果"
  },
  State_2693_Name = {
    Text = "狀態@序章狂氣0_1_2效果"
  },
  State_2693_WeaponDesc = {
    Text = "狀態@序章狂氣0_1_2效果"
  },
  State_2694_Desc = {
    Text = "每消費 1 黑印所有喚醒體獲得 1 狂氣"
  },
  State_2694_Name = {
    Text = "造物逆生花狀態"
  },
  State_2694_WeaponDesc = {
    Text = "每消費 1 黑印所有喚醒體獲得 1 狂氣"
  },
  State_2695_Desc = {
    Text = "每當一張喚醒體的卡進入超維空間後，使對應喚醒體獲得 15 狂氣。"
  },
  State_2696_Desc = {
    Text = "狀態@序章狂氣0_1_2生效"
  },
  State_2696_Name = {
    Text = "狀態@序章狂氣0_1_2生效"
  },
  State_2696_WeaponDesc = {
    Text = "狀態@序章狂氣0_1_2生效"
  },
  State_2698_Name = {
    Text = "下一回合開始時算力+1"
  },
  State_2699_Name = {
    Text = "下一回合開始時算力+2"
  },
  State_2701_Desc = {
    Text = "深海淑女獲得護盾時，提高 [StateArg1] 臨時觸腕傷害。"
  },
  State_2701_WeaponDesc = {
    Text = "深海淑女獲得護盾時，提高 [StateArg1] 臨時觸腕傷害。"
  },
  State_2702_Desc = {
    Text = "拾取時獲得 100% 死亡抵抗。觸發死亡抵抗後，本場戰鬥每回合開始時回復 [Arg1] 點生命。"
  },
  State_2703_Desc = {
    Text = "每回合打出的第一張喚醒體牌的臨時複製會進入維度裂隙中，它們能用於在危險時刻保護自己！"
  },
  State_2703_Name = {
    Text = "維度裂隙"
  },
  State_2705_Name = {
    Text = "復仇宣言"
  },
  State_2706_Desc = {
    Text = "漸漸石化檢測"
  },
  State_2706_Name = {
    Text = "漸漸石化檢測"
  },
  State_2706_WeaponDesc = {
    Text = "漸漸石化檢測"
  },
  State_2707_Desc = {
    Text = "本回合內觸腕攻擊全體敵方"
  },
  State_2707_Name = {
    Text = "觸腕全體攻擊"
  },
  State_2707_WeaponDesc = {
    Text = "本回合內觸腕攻擊全體敵方"
  },
  State_2708_Desc = {
    Text = "觸腕上限提高 1 條。生命低於 50% 時，觸腕傷害提高 [StateArg1]點 。"
  },
  State_2708_Name = {
    Text = "異化過往的貢物"
  },
  State_2708_WeaponDesc = {
    Text = "觸腕上限提高 1 條。生命低於 50% 時，觸腕傷害提高 [StateArg1]點 。"
  },
  State_2709_Desc = {
    Text = "造物銹蝕柳葉刀計數"
  },
  State_2710_Desc = {Text = "印記"},
  State_2710_Name = {Text = "印記"},
  State_2710_WeaponDesc = {Text = "印記"},
  State_2711_Desc = {
    Text = "臨時改變卡牌算力"
  },
  State_2711_Name = {
    Text = "臨時改變卡牌算力"
  },
  State_2711_WeaponDesc = {
    Text = "臨時改變卡牌算力"
  },
  State_2712_Desc = {
    Text = "提高造成的護盾。"
  },
  State_2712_Name = {
    Text = "<AlertIconKeywords: 戒備>"
  },
  State_2712_WeaponDesc = {
    Text = "獲得的護盾提高。"
  },
  State_2713_Desc = {
    Text = "復仇巨刃每回合都會獲得力量。"
  },
  State_2713_Name = {
    Text = "復仇巨刃覺醒"
  },
  State_2713_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_2715_Desc = {
    Text = "本次關卡內造成的護盾提高 [Layer] 點。"
  },
  State_2715_Name = {
    Text = "永久戒備"
  },
  State_2715_WeaponDesc = {
    Text = "本次關卡內造成的護盾提高 [Layer] 點。"
  },
  State_2718_Desc = {
    Text = "隊伍唯一：回合結束時裝備者獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣，獲得等同於裝備者銀鑰充能的銀鑰能量。"
  },
  State_2718_WeaponDesc = {
    Text = "回合結束時裝備者獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣，獲得等同於裝備者銀鑰充能的銀鑰能量。"
  },
  State_2720_Desc = {
    Text = "造成實際傷害時，降低狂氣最高的喚醒體 10 狂氣。"
  },
  State_2720_Name = {Text = "虛無"},
  State_2720_WeaponDesc = {
    Text = "造成實際傷害時，降低狂氣最高的喚醒體 10 狂氣。"
  },
  State_2721_Name = {
    Text = "狀態@關卡2_9戰鬥5氣泡1"
  },
  State_2722_Desc = {
    Text = "打出後將 [StateArg1] 張 「靈感」 洗入抽牌堆。「靈感」：獲得 1 算力，抽 1 張牌，保留，消耗。"
  },
  State_2722_Name = {
    Text = "<Rune_17_High:高級靈感>"
  },
  State_2723_Desc = {
    Text = "打出後易傷所有敵人 [StateArg1] 回合。"
  },
  State_2723_Name = {
    Text = "<Rune_1_High:高級易傷>"
  },
  State_2724_Desc = {
    Text = "攻擊次數提高 1。"
  },
  State_2724_Name = {
    Text = "幻夢之核反攻"
  },
  State_2726_Desc = {
    Text = "打出後對所有敵人施加 [StateArg1] 層中毒，使所有敵人觸發 [StateArg2]% 中毒。"
  },
  State_2726_Name = {
    Text = "<Rune_10_High:高級毒素>"
  },
  State_2727_Desc = {
    Text = "即將死亡時，回復 1 生命並移除該狀態。"
  },
  State_2727_WeaponDesc = {
    Text = "即將死亡時，回復 1 生命並移除該狀態。"
  },
  State_2728_Desc = {
    Text = "回合開始時每有一個其他友方，獲得 1 層<ParcloseIconKeywords:屏障>。"
  },
  State_2728_Name = {
    Text = "連結障壁"
  },
  State_2728_WeaponDesc = {
    Text = "回合開始時每有一個其他友方，獲得最大生命值百分之 [Layer] 的護盾。"
  },
  State_2729_Desc = {
    Text = "觸發時抽一張對應喚醒體的牌。"
  },
  State_2729_Name = {
    Text = "異化空間偏折儀抽牌"
  },
  State_2729_WeaponDesc = {
    Text = "觸發時抽一張對應喚醒體的牌。"
  },
  State_2730_Desc = {
    Text = "自身死亡後，海德拉減少 1 層「萬蛇操使」狀態。"
  },
  State_2730_Name = {Text = "眷屬"},
  State_2732_Desc = {
    Text = "狀態@序章狂氣初始化0_2_3"
  },
  State_2732_Name = {
    Text = "狀態@序章狂氣初始化0_2_3"
  },
  State_2732_WeaponDesc = {
    Text = "狀態@序章狂氣初始化0_2_3"
  },
  State_2734_Name = {
    Text = "下一回合開始時抽牌數+1"
  },
  State_2735_Desc = {
    Text = "若此卡打出後觸發「維度穿梭」或當前處於超維回合，觸發後續效果。"
  },
  State_2735_Name = {
    Text = "<TransitionIconKeywords:躍遷>"
  },
  State_2735_WeaponDesc = {
    Text = "若當前處於超維回合，可觸發躍遷效果。"
  },
  State_2737_Desc = {
    Text = "當我方隊伍牌庫重置時，獲得 [Layer] 點力量。"
  },
  State_2737_Name = {
    Text = "永遠凝結"
  },
  State_2738_Name = {
    Text = "虛弱效果提高"
  },
  State_2740_Desc = {
    Text = "在“未完的蠟像”處複製的卡牌及其本體算力消耗-1，同時獲得一張症狀卡"
  },
  State_2740_Name = {
    Text = "狀態@章二_共鳴5_2"
  },
  State_2740_WeaponDesc = {
    Text = "在“未完的蠟像”節點複製的卡牌及其本體算力消耗-1"
  },
  State_2741_Desc = {
    Text = "在“未完的蠟像”處複製的卡牌及其本體算力消耗-1，同時獲得一張症狀卡"
  },
  State_2741_Name = {
    Text = "狀態@章二_共鳴5_1"
  },
  State_2741_WeaponDesc = {
    Text = "在“未完的蠟像”節點複製的卡牌及其本體算力消耗-1"
  },
  State_2742_Desc = {
    Text = "滴答人每造成 1 次傷害，獲得 [StateArg2] 臨時力量， 每獲得 1 次護盾，獲得 [StateArg3] 臨時戒備。"
  },
  State_2742_Name = {
    Text = "參數擬合"
  },
  State_2744_Desc = {
    Text = "每當一張喚醒體的卡進入超維空間後，使其獲得 15 狂氣。"
  },
  State_2744_Name = {
    Text = "造物躍遷裝置"
  },
  State_2744_WeaponDesc = {
    Text = "每當一張喚醒體的卡進入超維空間後，使其獲得 15 狂氣。"
  },
  State_2746_Desc = {
    Text = "攻擊次數+1，失去[Layer]點力量"
  },
  State_2747_Desc = {
    Text = "打出後其他喚醒體獲得 [StateArg1] 狂氣。"
  },
  State_2748_Desc = {
    Text = "狀態@提燈儀式"
  },
  State_2748_Name = {
    Text = "狀態@提燈儀式"
  },
  State_2748_WeaponDesc = {
    Text = "狀態@提燈儀式"
  },
  State_2749_Desc = {
    Text = "本回合內造成觸腕傷害後，對目標施加 [Layer] 層中毒。"
  },
  State_2750_Desc = {
    Text = "與我一同沉入大海吧·········"
  },
  State_2750_Name = {
    Text = "寧菲亞覺醒"
  },
  State_2752_Desc = {
    Text = "睡蓮造成傷害時，獲得 [StateArg2] 狂氣。"
  },
  State_2752_WeaponDesc = {
    Text = "睡蓮造成傷害時，獲得 [StateArg2] 狂氣。"
  },
  State_2753_Desc = {
    Text = "回合開始時若生命大於 [Arg1]，失去 [Arg1] 點生命，當回合內獲得 [Arg2] 點力量和 [Arg3] 點戒備。"
  },
  State_2754_Name = {
    Text = "狀態@臨時打擊卡暴擊率提高"
  },
  State_2757_Desc = {
    Text = "下回合開始時、額外獲得 [DescArg1] 點算力。"
  },
  State_2757_Name = {
    Text = "症狀：多疑"
  },
  State_2758_Desc = {
    Text = "你的所有生命回復效果提高 [Arg1] 點，超額回復的生命會轉化為等量護盾。"
  },
  State_2758_Name = {
    Text = "蝴蝶標本"
  },
  State_2760_Desc = {
    Text = "每當一名喚醒體進行過 1 次吞噬，其他喚醒體獲得 10 狂氣。"
  },
  State_2762_Desc = {
    Text = "打出後額外生效 [StateArg1] 次，獲得 [StateArg2] 點黑印，消耗，固有。"
  },
  State_2762_Name = {
    Text = "<Rune_7_High:高級回聲>"
  },
  State_2762_WeaponDesc = {
    Text = "打出後額外生效 [StateArg1] 次，消耗。"
  },
  State_2763_Desc = {
    Text = "沉睡之主每消耗 1 算力時，提高 [StateArg1] 觸腕傷害。"
  },
  State_2763_Name = {
    Text = "不朽威儀"
  },
  State_2763_WeaponDesc = {
    Text = "沉睡之主每消耗 1 算力時，提高 [StateArg1] 觸腕傷害。"
  },
  State_2764_Desc = {
    Text = "造成未被格擋的傷害時，附加 [StateArg1] 層出血。"
  },
  State_2764_Name = {
    Text = "惡意放血"
  },
  State_2765_Name = {
    Text = "狀態@喬治@死亡時治療"
  },
  State_2767_Name = {
    Text = "狀態@黑印和銀鑰充能效率"
  },
  State_2769_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_2769_Name = {
    Text = "尚未覺醒"
  },
  State_2772_Name = {
    Text = "狀態@關卡2_5戰鬥3氣泡1"
  },
  State_2773_Desc = {
    Text = "戰鬥開始時，將 1 張「美麗瞬間 - 將手中所有喚醒體的牌更換為」打擊「，直到回合結束。保留，消耗。」加入手中。"
  },
  State_2775_Desc = {
    Text = "回歸抽牌數"
  },
  State_2775_Name = {
    Text = "抽牌數回歸"
  },
  State_2776_Name = {
    Text = "石之眼凝滯詛咒強化"
  },
  State_2777_Name = {
    Text = "狀態@章三_空狀態"
  },
  State_2778_Desc = {
    Text = "戰鬥開始時獲得 [Arg1] 點護盾。在本場戰鬥內打出 7 次「防禦」後，立刻獲得 [Arg2] 點護盾。"
  },
  State_2778_Name = {
    Text = "普特尼晨報"
  },
  State_2779_Desc = {
    Text = "當生命低於 50%([StateArg1]) 時，將會分裂為 3 只等量生命的「干涉型融蝕體」。"
  },
  State_2779_WeaponDesc = {
    Text = "當生命低於 50%([StateArg1]) 時，將會分裂為2只等量生命的「II型融蝕體」。"
  },
  State_2780_Desc = {
    Text = "打出後獲得 [StateArg1] 點算力。"
  },
  State_2780_Name = {
    Text = "<Rune_4:籌算>"
  },
  State_2781_Desc = {
    Text = "每打出 [Layer] 張牌，自身若沒有屏障，添加一層<ParcloseIconKeywords:屏障>。"
  },
  State_2781_WeaponDesc = {
    Text = "我方隊伍每打出 [Layer] 張牌，怪物刷新一層屏障"
  },
  State_2784_Desc = {
    Text = "即使不在超維回合，每回合也能夠觸發一次躍遷效果。超維空間容量提高 2。"
  },
  State_2785_Desc = {
    Text = "隊伍唯一：裝備者打出卡牌後，裝備者獲得 1 點狂氣。戰鬥開始時，獲得等同於裝備者攻擊力 <WeaponEffect_Num:[StateArg1]%> 的<PowerIconKeywords:力量> ，若當前界域為「深海」，額外獲得 <WeaponEffect_Num:[StateArg2]%> 的<CardKeyWord:觸腕傷害>，後續的每個回合開始後，獲得等同於裝備者攻擊力 <WeaponEffect_Num:[StateArg3]%> 的<PowerIconKeywords:力量> ，若當前界域為「深海」，額外獲得 <WeaponEffect_Num:[StateArg4]%> 的<CardKeyWord:觸腕傷害>。"
  },
  State_2785_WeaponDesc = {
    Text = "裝備者打出卡牌後，裝備者獲得 1 點狂氣。戰鬥開始時，獲得 <WeaponEffect_Num:[Power:DescArg1]> 點<PowerIconKeywords:力量> 。若當前界域為「深海」，額外獲得 <WeaponEffect_Num:[DescArg2]> 點<CardKeyWord:觸腕傷害>，後續每個回合開始後，獲得 <WeaponEffect_Num:[Power:DescArg3]> 點<PowerIconKeywords:力量> 。若當前界域為「深海」，額外獲得 <WeaponEffect_Num:[DescArg4]> 點<CardKeyWord:觸腕傷害>."
  },
  State_2786_Name = {
    Text = "造物染血鵝卵石計數"
  },
  State_2787_Desc = {
    Text = "回復生命，將 1 張【虛無終結】洗入棄牌堆。永續，銷毀。"
  },
  State_2787_Name = {
    Text = "<CardKeyWord:真理追尋>"
  },
  State_2787_WeaponDesc = {
    Text = "回復生命，將 1 張【虛無終結】洗入棄牌堆。永續，銷毀。"
  },
  State_2788_Desc = {
    Text = "回合開始時抽 [StateArg1] 張牌。"
  },
  State_2788_Name = {
    Text = "造物先知的許願燈1"
  },
  State_2788_WeaponDesc = {
    Text = "回合開始時抽 [StateArg1] 張牌。"
  },
  State_2789_Desc = {
    Text = "卡牌被詹金做了手腳！打出後受到 [Layer] 點<FixedDamage:純粹傷害>。"
  },
  State_2789_Name = {
    Text = "<CardKeyWord:打出後受到 [Layer] 點傷害>"
  },
  State_2789_WeaponDesc = {
    Text = "卡牌打出後受到 [StateArg1] 點傷害。"
  },
  State_2790_Desc = {
    Text = "回合結束時可以選擇保留 [StateArg1] 張手牌。"
  },
  State_2790_Name = {
    Text = "造物先知的許願燈2"
  },
  State_2790_WeaponDesc = {
    Text = "回合結束時可以選擇保留 [StateArg1] 張手牌。"
  },
  State_2792_Desc = {
    Text = "戰鬥開始時，全體友方獲得 3 層【蠟質鎧甲】。回合開始時，將一張驚厥洗入我方隊伍抽牌堆。"
  },
  State_2792_Name = {
    Text = "「蠟之淑女」"
  },
  State_2792_WeaponDesc = {
    Text = "戰鬥開始時，全體友方獲得 3 層【蠟質鎧甲】。回合開始時，將一張驚厥洗入我方隊伍抽牌堆。"
  },
  State_2793_Desc = {
    Text = "狀態@石之眼垂死之掙"
  },
  State_2793_Name = {
    Text = "狀態@石之眼垂死之掙"
  },
  State_2793_WeaponDesc = {
    Text = "狀態@石之眼垂死之掙"
  },
  State_2796_Desc = {
    Text = "每當你失去生命，對所有敵人添加 [Arg1] 層中毒。每回合使中毒值提高 [Arg2] 點"
  },
  State_2797_Desc = {
    Text = "回合開始時，將一張本回合內獲得 [Arg1] 戒備的「陽傘」加入手中，打出 6 張卡牌後，使手牌中所有的「陽傘」戒備提高 [Arg2]。"
  },
  State_2798_Desc = {
    Text = "仁愛主祭施加護盾時，使 1 張隨機手牌直到打出前算力消耗 -1。"
  },
  State_2798_WeaponDesc = {
    Text = "仁愛主祭施加護盾時，使 1 張隨機手牌直到打出前算力消耗 -1。"
  },
  State_2799_Desc = {
    Text = "海月造成主動傷害時，使 [StateArg1] 條觸腕攻擊該目標。"
  },
  State_2799_WeaponDesc = {
    Text = "海月造成傷害時，使 [StateArg1] 條觸腕攻擊該目標。"
  },
  State_2800_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_2800_Name = {
    Text = "狀態@試作小刀爆傷"
  },
  State_2801_Desc = {
    Text = "受到實際傷害提升深度融蝕層數"
  },
  State_2801_Name = {
    Text = "受到傷害提升深度融蝕層數"
  },
  State_2801_WeaponDesc = {
    Text = "受到實際傷害提升深度融蝕層數"
  },
  State_2802_Desc = {
    Text = "回合開始增加臨時力量"
  },
  State_2802_Name = {
    Text = "加臨時力量"
  },
  State_2804_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_2804_Name = {
    Text = "狀態@試作鐳射炮爆傷"
  },
  State_2805_Desc = {
    Text = "回合結束時，其他友方獲得力量"
  },
  State_2805_Name = {
    Text = "「啟明之火」"
  },
  State_2807_Desc = {
    Text = "回合開始時，將一張本回合內獲得 [Arg1] 戒備的「陽傘」加入手中，打出 6 張卡牌後，使手牌中所有的「陽傘」戒備提高 [Arg2]。"
  },
  State_2808_Desc = {
    Text = "回合結束時生成 1 個胚胎融合度，如果手牌中有胚胎，回復 15 生命。"
  },
  State_2808_Name = {
    Text = "異化止血鉗"
  },
  State_2808_WeaponDesc = {
    Text = "回合結束時生成 1 個胚胎融合度，如果手牌中有胚胎，回復 15 生命。"
  },
  State_2809_Desc = {
    Text = "拾取時永久失去 [Arg1] 力量。每當造成傷害時，回復 [Arg2] 點生命，每回合最多觸發 6 次。"
  },
  State_2809_Name = {
    Text = "七鰓鰻之吻"
  },
  State_2810_Desc = {
    Text = "回合結束時，回復 [Layer] %最大生命值。"
  },
  State_2810_WeaponDesc = {
    Text = "怪物回合結束時，回復最大生命值的 [Layer] %"
  },
  State_2811_Desc = {
    Text = "抽到症狀卡時獲得 [Arg1] 點力量。你每擁有 1 個詛咒刻印或詛咒造物，暴擊率和暴擊傷害就提高 10%。"
  },
  State_2812_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_2812_Name = {
    Text = "尚未覺醒"
  },
  State_2813_Desc = {
    Text = "回合開始時失去算力"
  },
  State_2814_Desc = {
    Text = "戰鬥勝利時獲得的刻印變為強大而危險的詛咒刻印。"
  },
  State_2817_Desc = {
    Text = "每層使受到的傷害降低 [StateArg1]，每次被暴擊後減少 1 層。"
  },
  State_2817_Name = {
    Text = "蠟質鎧甲"
  },
  State_2817_WeaponDesc = {
    Text = "免疫異常狀態，被暴擊後移除。"
  },
  State_2818_Desc = {
    Text = "分裂為融蝕三角小和融蝕三角小B。"
  },
  State_2818_WeaponDesc = {
    Text = "分裂為融蝕三角小和融蝕三角小B。"
  },
  State_2820_Desc = {
    Text = "打出後獲得 [StateArg1] 點臨時力量，該刻印卡牌也能享受力量加成。"
  },
  State_2820_Name = {
    Text = "<Rune_15:爆發>"
  },
  State_2821_Name = {
    Text = "臨時免疫易傷"
  },
  State_2823_Desc = {
    Text = "隊伍唯一：戰鬥開始時對前排敵人施加 2 層<VulnerabilityIconKeywords:易傷>。回合開始時，處於易傷狀態的敵人失去等同於裝備者攻擊力 <WeaponEffect_Num:[StateArg1]%> 的臨時<PowerIconKeywords:力量>。若當前界域為「血肉」，裝備者釋放「狂氣爆發」後，胚胎融合 +<WeaponEffect_Num:[Blood:StateArg2]>。"
  },
  State_2823_WeaponDesc = {
    Text = "戰鬥開始時，對前排敵人施加 2 層<VulnerabilityIconKeywords:易傷>。回合開始時，處於易傷狀態的敵人失去 <WeaponEffect_Num:[Power:DescArg1]> 點臨時<PowerIconKeywords:力量>。若當前界域為「血肉」，裝備者釋放「狂氣爆發」後，胚胎融合 +<WeaponEffect_Num:[Blood:StateArg2]>。"
  },
  State_2825_Desc = {
    Text = "怪物超維卡槽上限"
  },
  State_2825_Name = {
    Text = "怪物超維卡槽上限"
  },
  State_2825_WeaponDesc = {
    Text = "怪物超維卡槽上限"
  },
  State_2826_Desc = {
    Text = "連續 2 次打出比上一張算力消耗更低的卡牌時，當前狂氣最低的喚醒體獲得 50 狂氣。"
  },
  State_2826_Name = {
    Text = "造物阿爾卡納遺物"
  },
  State_2827_Desc = {
    Text = "傷害次數和傷害提高。"
  },
  State_2827_Name = {
    Text = "<CardKeyWord:升級>"
  },
  State_2829_Desc = {
    Text = "造成實際傷害時，獲得 [Layer] 點力量。"
  },
  State_2829_Name = {
    Text = "「紛亂人格」"
  },
  State_2830_Desc = {
    Text = "隊伍中每有一名【深海】職業喚醒體，全隊最大生命(未完成)、防禦、攻擊提高 50%"
  },
  State_2830_WeaponDesc = {
    Text = "隊伍中每有一名【深海】職業喚醒體，全隊最大生命(未完成)、防禦、攻擊提高 50%"
  },
  State_2832_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_2832_Name = {
    Text = "狀態@試作鐳射炮死抗"
  },
  State_2833_Desc = {
    Text = "回合開始時抽 1 張牌。每當你抽到 1 張牌時，隨機變化其算力消耗（0-4）。"
  },
  State_2835_Desc = {
    Text = "每進行 1 次吞噬，偷取所有敵人 [Arg1] 臨時力量。"
  },
  State_2836_Name = {
    Text = "狀態@詛咒盲從"
  },
  State_2837_Name = {
    Text = "狀態@詛咒盲從"
  },
  State_2838_Name = {
    Text = "狀態@詛咒盲從"
  },
  State_2840_Desc = {
    Text = "回合結束後，受到 [Layer] 點<FixedDamage:純粹傷害>並移除 [DescArg1]% 層數。回復生命時移除雙倍回覆量的出血層數。"
  },
  State_2840_WeaponDesc = {
    Text = "回合結束後，受到[Layer]點傷害並移除該狀態，每次治療可使層數減半。"
  },
  State_2842_Desc = {
    Text = "打出後獲得 [StateArg1] 層反擊，對所有敵人造成 [StateArg2]% 反擊的<FixedDamage:純粹傷害>。"
  },
  State_2843_Desc = {
    Text = "我方隊伍每打出 1 張牌，獲得 [StateArg1] 層護盾。持續 1 回合。"
  },
  State_2843_Name = {
    Text = "飛羽漫天"
  },
  State_2843_WeaponDesc = {
    Text = "我方隊伍每打出 1 張牌，獲得 [StateArg1] 層護盾。持續 1 回合。"
  },
  State_2844_Desc = {
    Text = "每場戰鬥中第 1 次失去生命時，獲得 1 層免疫一次傷害的屏障。"
  },
  State_2845_Name = {
    Text = "飾品埋骨地絮語"
  },
  State_2845_WeaponDesc = {
    Text = "關卡開始時死亡抵抗提高 25%。觸發死亡抵抗後，裝備者獲得 50 點狂氣。"
  },
  State_2846_Desc = {
    Text = "免疫一次死亡，觸發後回復 [Arg1] 生命並使該造物永久失效。"
  },
  State_2847_Desc = {
    Text = "被狩獵喚醒體每使用一張卡牌，疊加1層狩獵印記，並抽取狩獵印記層數一半的卡牌。"
  },
  State_2847_Name = {
    Text = "狩獵儀式"
  },
  State_2849_Desc = {
    Text = "每當你失去生命，就獲得 [Arg1] 點力量，最多堆疊 10 次。層數滿時，回復已損失生命值 25% 的生命。"
  },
  State_2849_Name = {
    Text = "無上榮寵"
  },
  State_2853_Desc = {
    Text = "造物長眠安樂椅計數"
  },
  State_2854_Desc = {
    Text = "死亡後不為喚醒體提供狂氣。"
  },
  State_2854_WeaponDesc = {
    Text = "死亡後不為喚醒體提供狂氣。"
  },
  State_2855_Desc = {
    Text = "打擊卡傷害提高 [StateArg1]%，持續 [Layer] 回合。"
  },
  State_2855_Name = {
    Text = "絕境求生·打擊"
  },
  State_2855_WeaponDesc = {
    Text = "本回合你的打擊卡傷害提高 [Layer]%。"
  },
  State_2856_Desc = {
    Text = "隊伍唯一：裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]％>，並且造成護盾時，己方全員獲得 <WeaponEffect_Num:[StateArg3]％> 臨時暴擊率和 <WeaponEffect_Num:[StateArg4]%> 裝備者銀鑰充能的銀鑰能量，每回合最多生效 2 次。若當前界域為「深海」，每當有 1 條觸腕攻擊時，裝備者獲得 1 點狂氣，每回合最多獲得 <WeaponEffect_Num:[StateArg2]> 點。"
  },
  State_2856_WeaponDesc = {
    Text = "裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]％>，並且造成護盾時，己方全員獲得 <WeaponEffect_Num:[StateArg3]％> 臨時暴擊率和 <WeaponEffect_Num:[StateArg4]%> 裝備者銀鑰充能的銀鑰能量，每回合最多生效 2 次。若當前界域為「深海」，每當有 1 條觸腕攻擊時，裝備者獲得 1 點狂氣，每回合最多獲得 <WeaponEffect_Num:[StateArg2]> 點。"
  },
  State_2857_Desc = {
    Text = "每回合開始時所有喚醒體獲得 10 狂氣。最大生命降低 50%。"
  },
  State_2858_Name = {
    Text = "打出時額外獲得兩層屏障"
  },
  State_2859_Desc = {
    Text = "戰鬥開始後該卡固定在手牌中。"
  },
  State_2860_Desc = {
    Text = "抽到時使自身最大生命降低 10%。使用後使所有喚醒體本回合暴擊傷害提高 100%。無法出售。"
  },
  State_2860_Name = {
    Text = "狀態詛咒融蝕"
  },
  State_2860_WeaponDesc = {
    Text = "抽到時使自身最大生命降低 10%。使用後使所有喚醒體本回合暴擊傷害提高 100%。無法出售。"
  },
  State_2861_Name = {
    Text = "(剩餘：[Layer])"
  },
  State_2862_Desc = {
    Text = "回合結束時額外受到一次中毒傷害"
  },
  State_2862_Name = {
    Text = "體質衰弱"
  },
  State_2863_Desc = {
    Text = "進化層數"
  },
  State_2863_Name = {
    Text = "進化層數"
  },
  State_2863_WeaponDesc = {
    Text = "進化層數"
  },
  State_2864_Desc = {
    Text = "「24」 已經覺醒，使用最後的「救救我」找到機會吧！"
  },
  State_2864_Name = {
    Text = "「24」覺醒！"
  },
  State_2864_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_2866_Desc = {
    Text = "隊伍唯一：手牌上限 +2，回合結束時獲得等同於裝備者 <WeaponEffect_Num:[StateArg1]%> 銀鑰充能的銀鑰能量。每次釋放鑰令後，所有喚醒體獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣，若當前界域為「血肉」，還會使胚胎融合 <WeaponEffect_Num:+[Blood:StateArg3]> 。"
  },
  State_2866_WeaponDesc = {
    Text = "手牌上限 +2，回合結束時獲得 <WeaponEffect_Num:[DescArg1]> 點銀鑰能量。每次釋放鑰令後，所有喚醒體獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣，若當前界域為「血肉」，還會使胚胎融合 <WeaponEffect_Num:+[Blood:StateArg3]> 。"
  },
  State_2868_Desc = {
    Text = "回合結束時手中每有 1 張未打出的卡牌，就使所有喚醒體獲得 2 狂氣。"
  },
  State_2871_Desc = {
    Text = "生命低於50%([StateArg1])召喚1個等量生命的融蝕三角中"
  },
  State_2871_Name = {Text = "召喚"},
  State_2871_WeaponDesc = {
    Text = "生命低於50%([StateArg1])召喚1個等量生命的融蝕三角中"
  },
  State_2874_Desc = {
    Text = "喚醒體在被獵顱者注視，使用其卡牌可以額外抽 2 張牌。"
  },
  State_2875_Desc = {
    Text = "打出後胚胎融合 +[StateArg1]。"
  },
  State_2875_Name = {
    Text = "<Rune_12_High:高級嗜血>"
  },
  State_2875_WeaponDesc = {
    Text = "打出後胚胎融合+ [Blood:StateArg1]。"
  },
  State_2876_Desc = {
    Text = "戰鬥結束後，額外獲得 50 黑印和 1 張症狀卡。"
  },
  State_2877_Desc = {
    Text = "紅夫人每造成 1 次傷害，就獲得 [StateArg2] 點臨時力量。"
  },
  State_2877_Name = {
    Text = "迎客特權"
  },
  State_2878_Desc = {
    Text = "傷害次數提高 1，但傷害減少 25%。"
  },
  State_2878_Name = {Text = "狂亂"},
  State_2878_WeaponDesc = {
    Text = "傷害次數提高 1，但傷害減少 25%。"
  },
  State_2879_WeaponDesc = {
    Text = "使用「湮滅」後，若本回合處於靜海姿態，裝備者本回合護盾與治療效果提高 30%。"
  },
  State_2880_Name = {
    Text = "狀態@海之使徒啟靈7"
  },
  State_2881_Desc = {
    Text = "每當將 1 張「聖禮」轉化為「執妄」後，本場戰鬥彌利亞姆造成的基礎傷害提高 15%。"
  },
  State_2881_Name = {
    Text = "泡影幻滅"
  },
  State_2883_Desc = {
    Text = "隊伍唯一：裝備者造成主動傷害後，有  <WeaponEffect_Num:[StateArg1]%> 的機率抽 1 張裝備者的指令卡並使其算力消耗降低 1。該效果單個回合只生效 1 次。"
  },
  State_2883_WeaponDesc = {
    Text = "裝備者造成主動傷害後，有  <WeaponEffect_Num:[StateArg1]%> 的機率抽 1 張裝備者的指令卡並使其算力消耗降低 1。該效果單個回合只生效 1 次。"
  },
  State_2884_Name = {
    Text = "造成的傷害為<PunctureDamagewords:穿刺傷害>。使手中算力最高的 1 張牌算力消耗降低 1"
  },
  State_2885_Name = {
    Text = "狀態@回合開始後抽牌加2"
  },
  State_2887_Desc = {
    Text = "隊伍唯一：裝備者釋放狂氣爆發後，其本回合暴擊傷害提高 <WeaponEffect_Num:[StateArg1]%>，手中所有裝備者的卡牌都有 <WeaponEffect_Num:[StateArg2]%> 機率本回合內算力消耗降低 1 點。"
  },
  State_2887_WeaponDesc = {
    Text = "裝備者釋放狂氣爆發後，其本回合暴擊傷害提高 <WeaponEffect_Num:[StateArg1]%>，手中所有裝備者的卡牌都有 <WeaponEffect_Num:[StateArg2]%> 機率本回合內算力消耗降低 1 點。"
  },
  State_2888_Desc = {
    Text = "若手牌中存在「胚胎」，消耗 1 張並觸發後續效果。"
  },
  State_2888_WeaponDesc = {
    Text = "消耗手牌中的胚胎，觸發強大的吞噬效果。"
  },
  State_2889_Name = {
    Text = "選擇一名喚醒體獲得 <Energy:[DescArg1]> 點狂氣"
  },
  State_2890_Desc = {
    Text = "戰鬥開始時，對我方隊伍造成 1 層脆弱。"
  },
  State_2890_WeaponDesc = {
    Text = "戰鬥開始時，對我方隊伍造成 1 層脆弱。"
  },
  State_2891_Name = {
    Text = "狂氣開場回復提升"
  },
  State_2892_Desc = {
    Text = "回合結束時，回復 [Layer] 點生命。"
  },
  State_2892_Name = {
    Text = "延遲生命回復"
  },
  State_2892_WeaponDesc = {
    Text = "直到回合結束，每次造成擊殺，回復 [Layer] 點生命。"
  },
  State_2897_Desc = {
    Text = "釋放本源降臨時，降低敵人的臨時力量。"
  },
  State_2897_Name = {
    Text = "畏懼狂氣"
  },
  State_2899_Desc = {
    Text = "若對方手牌數大於等於 4，受到傷害時，就獲得 [StateArg1] 點護盾。"
  },
  State_2900_Desc = {
    Text = "本場戰鬥內造成的傷害提高 [Layer] 點。"
  },
  State_2900_WeaponDesc = {
    Text = "本場戰鬥內造成的傷害提高 [Layer] 點。"
  },
  State_2901_Desc = {
    Text = "[狂氣爆發]使自身獲得 20 點狂氣。"
  },
  State_2901_Name = {
    Text = "造物無名之神的面紗"
  },
  State_2901_WeaponDesc = {
    Text = "[狂氣爆發]使自身獲得 20 點狂氣。"
  },
  State_2902_Desc = {
    Text = "缸中之腦回復生命翻倍。"
  },
  State_2902_Name = {
    Text = "靈肉兩分"
  },
  State_2902_WeaponDesc = {
    Text = "缸中之腦回復生命翻倍。"
  },
  State_2903_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_2903_Name = {
    Text = "狀態@試作小刀暴擊"
  },
  State_2904_Desc = {
    Text = "每次受到實際傷害後，獲得 10 護盾。"
  },
  State_2904_Name = {Text = "緩衝"},
  State_2904_WeaponDesc = {
    Text = "每次受到實際傷害後，獲得 10 護盾。"
  },
  State_2905_Desc = {
    Text = "隊伍唯一：裝備者的「狂氣爆發」造成的護盾提高 <WeaponEffect_Num:[StateArg2]%>。裝備者釋放「狂氣爆發」後，獲得等同於裝備者防禦力 <WeaponEffect_Num:[StateArg1]%> 層數的臨時<PowerIconKeywords:力量>。若我方隊伍處於<FragileIconKeywords:脆弱>狀態，效果翻倍。"
  },
  State_2905_WeaponDesc = {
    Text = "裝備者的「狂氣爆發」造成的護盾提高 <WeaponEffect_Num:[StateArg2]%>。裝備者釋放「狂氣爆發」後，獲得 [Power:DescArg1] 點臨時<PowerIconKeywords:力量>。若我方隊伍處於<FragileIconKeywords:脆弱>狀態，效果翻倍。"
  },
  State_2906_Desc = {
    Text = "造成實際傷害後，使我方隊伍臨時降低[Layer]點力量。"
  },
  State_2906_Name = {
    Text = "麻痺電擊"
  },
  State_2909_Desc = {
    Text = "擁有 [Layer] 點狂氣。若狂氣大於等於 5，意圖變為 「扭曲的死體狂宴」，狂氣降低後恢復。"
  },
  State_2909_Name = {
    Text = "狀態@怪物24扭曲的死體狂宴計數"
  },
  State_2909_WeaponDesc = {
    Text = "擁有 [Layer] 點狂氣。若狂氣大於等於 5，意圖變為 「扭曲的死體狂宴」，狂氣降低後恢復。"
  },
  State_2910_Desc = {
    Text = "隊伍唯一：探索開始時將一張「靈感」和裝備者的「打擊」加入牌庫，裝備者「打擊」基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，打出後有 <WeaponEffect_Num:[StateArg2]%> 機率抽 1 張牌。該效果每回合最多觸發 1 次。若當前界域為「超維」並在超維回合中，「打擊」將 1 張「靈感」置入手中，當回合最多觸發 1 次。"
  },
  State_2910_WeaponDesc = {
    Text = "探索開始時將一張「靈感」和裝備者的「打擊」加入牌庫，裝備者「打擊」基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，打出後有 <WeaponEffect_Num:[StateArg2]%> 機率抽 1 張牌。該效果每回合最多觸發 1 次。若當前界域為「超維」並在超維回合中，「打擊」將 1 張「靈感」置入手中，當回合最多觸發 1 次。"
  },
  State_2911_Desc = {
    Text = "狀態@純白的空想世界改計數"
  },
  State_2911_Name = {
    Text = "狀態@純白的空想世界計數"
  },
  State_2911_WeaponDesc = {
    Text = "狀態@純白的空想世界改計數"
  },
  State_2912_Desc = {
    Text = "你被鎖定了！打出後蹈海者親衛獲得 [StateArg1] 點臨時力量，移除該指令的深潛印記。"
  },
  State_2912_Name = {
    Text = "<CardKeyWord:深潛印記>"
  },
  State_2912_WeaponDesc = {
    Text = "卡牌打出後深潛者親衛獲得 [StateArg1] 點臨時力量。"
  },
  State_2913_Desc = {
    Text = "戰鬥開始時脆弱自身 3 回合。"
  },
  State_2913_Name = {
    Text = "造物古怪鉤爪2"
  },
  State_2913_WeaponDesc = {
    Text = "戰鬥開始時脆弱自身 3 回合。"
  },
  State_2914_Desc = {
    Text = "生命低於 50% 時，意圖變為召喚一個等量生命的 【融蝕三角中】。"
  },
  State_2914_Name = {Text = "裂變"},
  State_2914_WeaponDesc = {
    Text = "生命低於 50% 時，意圖變為召喚一個等量生命的 【融蝕三角中】。"
  },
  State_2915_Desc = {
    Text = "使「綿綿恨怨」的傷害次數 +[Layer] 次。"
  },
  State_2915_WeaponDesc = {
    Text = "使「綿綿恨怨」的傷害次數 +[Layer] 次。"
  },
  State_2917_Desc = {
    Text = "回合結束時，每有 1 張剩餘手牌，下回合開始時獲得 1 點算力。"
  },
  State_2917_Name = {
    Text = "狀態@幻夢銀鑰：演算"
  },
  State_2918_Desc = {
    Text = "受到的傷害降低 99%。受到主動傷害後移除 1 層，回合開始時恢復至 3 層。"
  },
  State_2918_Name = {
    Text = "「不滅殘軀」"
  },
  State_2918_WeaponDesc = {
    Text = "受到的傷害降低 99%。受到主動傷害後移除 1 層，回合開始時恢復至 3 層。"
  },
  State_2919_Desc = {
    Text = "狀態@翠火翡翠映射提前"
  },
  State_2919_Name = {
    Text = "狀態@翠火翡翠映射提前"
  },
  State_2919_WeaponDesc = {
    Text = "狀態@翠火翡翠映射提前"
  },
  State_2922_Desc = {
    Text = "每消耗 1 點算力，使對應的喚醒體獲得 2 點狂氣。"
  },
  State_2923_Desc = {
    Text = "回合結束時，力量提高 [Layer] 。"
  },
  State_2923_Name = {
    Text = "神降儀式"
  },
  State_2923_WeaponDesc = {
    Text = "每個回合結束時獲得[Layer]點力量。"
  },
  State_2925_Desc = {
    Text = "翠火每次造成傷害，層數+1"
  },
  State_2925_Name = {
    Text = "翡翠映射計數"
  },
  State_2925_WeaponDesc = {
    Text = "翠火每次造成傷害，層數+1"
  },
  State_2927_Name = {
    Text = "狀態@詛咒譫妄變化"
  },
  State_2929_Desc = {
    Text = "隊伍唯一：裝備者每造成 1 次傷害，有 <WeaponEffect_Num:[StateArg3]%> 幾率使裝備者獲得 2% 臨時暴擊傷害。裝備者釋放狂氣爆發後對隨機敵人造成 3 次等同於裝備者攻擊力 <WeaponEffect_Num:[StateArg1]%> 的主動傷害。若當前界域為「血肉」，裝備者每吞噬一個胚胎，就使胚胎融合 +<WeaponEffect_Num:[Blood:StateArg2]> 。"
  },
  State_2929_WeaponDesc = {
    Text = "裝備者每造成 1 次傷害，有 <WeaponEffect_Num:[StateArg3]%> 幾率使裝備者獲得 2% 臨時暴擊傷害。裝備者釋放狂氣爆發後對隨機敵人造成 3 次 [DescArg1] 點主動傷害。若當前界域為「血肉」，裝備者每吞噬一個胚胎，就使胚胎融合 +<WeaponEffect_Num:[Blood:StateArg2]> 。"
  },
  State_2930_Name = {
    Text = "狀態@喬治@死亡時獲得力量"
  },
  State_2931_Desc = {
    Text = "每進行 1 次吞噬，偷取所有敵人 4 臨時力量。"
  },
  State_2931_Name = {
    Text = "異化蠶絲瑪瑙"
  },
  State_2933_Name = {
    Text = "飾品扭曲雙子白"
  },
  State_2933_WeaponDesc = {
    Text = "偶數回合開始後，將一張附加虛無和消耗的裝備者的「防禦」加入手牌。"
  },
  State_2934_Desc = {
    Text = "承受的主動和觸腕傷害提高 [DescArg1] %。"
  },
  State_2934_Name = {
    Text = "<VulnerabilityColour: 易傷>"
  },
  State_2934_WeaponDesc = {
    Text = "承受的所有傷害提高 50 %。"
  },
  State_2937_Desc = {
    Text = "每第 3 次獲得護盾時，同時獲得等量的反擊。"
  },
  State_2938_Desc = {
    Text = "回合開始時抽 1 張牌，回合結束時可以選擇保留 1 張手牌。"
  },
  State_2940_Name = {
    Text = "承受異端之血漸強"
  },
  State_2941_Desc = {
    Text = "打出後對所有敵人施加 [StateArg1] 層中毒，使所有敵人觸發 [StateArg2]% 中毒。"
  },
  State_2942_Desc = {
    Text = "回合結束時為其他友方恢復  [Layer] % 生命並清除持續傷害。"
  },
  State_2942_Name = {
    Text = "戰場救護"
  },
  State_2946_Desc = {
    Text = "瘋狂連擊獲得極高額的護盾。"
  },
  State_2946_Name = {
    Text = "「不動要塞」"
  },
  State_2946_WeaponDesc = {
    Text = "瘋狂連擊獲得極高額的護盾。"
  },
  State_2948_Desc = {
    Text = "打出前改變卡牌算力"
  },
  State_2948_Name = {
    Text = "打出前改變卡牌算力"
  },
  State_2948_WeaponDesc = {
    Text = "打出前改變卡牌算力"
  },
  State_2949_Name = {
    Text = "命輪戰鬥放棄刻印"
  },
  State_2951_Desc = {
    Text = "造物長眠安樂椅"
  },
  State_2951_Name = {
    Text = "緘默手套"
  },
  State_2952_Desc = {
    Text = "回合結束後，回復 [Layer] 點生命。每失去 5 點生命時移除 1 層。"
  },
  State_2954_Name = {
    Text = "狀態@2-8怪物24@救救我"
  },
  State_2955_Desc = {
    Text = "所有敵人失去生命。永續，銷毀。"
  },
  State_2955_Name = {
    Text = "<CardKeyWord:虛無終結>"
  },
  State_2955_WeaponDesc = {
    Text = "所有敵人失去生命。永續，銷毀。"
  },
  State_2956_Desc = {
    Text = "每受到一次傷害，所有喚醒體獲得 [StateArg1] 點狂氣。"
  },
  State_2956_WeaponDesc = {
    Text = "每受到一次傷害，所有喚醒體獲得 [StateArg1] 點狂氣。"
  },
  State_2957_Desc = {
    Text = "死亡後，原地召喚一個自身生命值 1/3 的【融蝕三角中】"
  },
  State_2957_Name = {Text = "融蝕"},
  State_2957_WeaponDesc = {
    Text = "死亡後，原地召喚一個自身生命值 1/3 的【融蝕三角中】"
  },
  State_2960_Desc = {
    Text = "偶數回合，當你的算力為 0 時，獲得 2 算力。"
  },
  State_2960_Name = {
    Text = "異化老舊拼圖"
  },
  State_2960_WeaponDesc = {
    Text = "偶數回合，當你的算力為 0 時，獲得 2 算力。"
  },
  State_2961_Desc = {
    Text = "隊伍唯一：裝備者造成的<IntoxicationIconKeywords:中毒>提高 <WeaponEffect_Num:[StateArg1]%>，裝備者釋放狂氣爆發前，先對所有敵人施加等同於裝備者攻擊力 <WeaponEffect_Num:[StateArg2]%> 的中毒。使用鑰令後，裝備者獲得 <WeaponEffect_Num:[StateArg3]> 點狂氣。"
  },
  State_2961_WeaponDesc = {
    Text = "裝備者造成的<IntoxicationIconKeywords:中毒>提高 <WeaponEffect_Num:[StateArg1]%>，裝備者釋放狂氣爆發前，先對所有敵人施加 <WeaponEffect_Num:[Poison:DescArg1]> 層中毒。使用鑰令後，裝備者獲得 <WeaponEffect_Num:[StateArg3]> 點狂氣。"
  },
  State_2962_Desc = {
    Text = "打出後虛弱所有敵人 [StateArg1] 回合。"
  },
  State_2962_Name = {
    Text = "<Rune_2:虛弱>"
  },
  State_2965_Name = {
    Text = "狀態@凸月侍女啟靈7"
  },
  State_2967_Desc = {
    Text = "使用症狀卡時，潘迪婭的狀態會在「焦躁」和「縱慾」之間變化。焦躁：造成的主動傷害次數+1，力量減少。縱慾：造成的主動傷害次數-1，力量增加。"
  },
  State_2967_Name = {
    Text = "潘迪婭覺醒！"
  },
  State_2967_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_2968_Name = {
    Text = "狀態@關卡2_14戰鬥8氣泡4"
  },
  State_2969_Name = {
    Text = "狀態@關卡2_14戰鬥8氣泡5"
  },
  State_2971_Desc = {
    Text = "狀態@序章扣半血"
  },
  State_2971_Name = {
    Text = "狀態@序章扣半血"
  },
  State_2971_WeaponDesc = {
    Text = "狀態@序章扣半血"
  },
  State_2972_Name = {
    Text = "狀態@關卡2_14戰鬥8氣泡2"
  },
  State_2973_Name = {
    Text = "狀態@關卡2_14戰鬥8氣泡3"
  },
  State_2975_Desc = {
    Text = "每場戰鬥的前 5 次躍遷效果額外生效 1 次。"
  },
  State_2976_Desc = {
    Text = "回合結束時，若你的護盾為 0 或 10 的倍數，獲得 [Arg1] 點護盾。若你的生命為 10 的倍數，獲得 [Arg2] 點力量。"
  },
  State_2976_Name = {
    Text = "求救信號"
  },
  State_2977_Desc = {
    Text = "奇數回合，當你的手牌為 0 時，抽 2 張牌"
  },
  State_2977_Name = {
    Text = "異化老舊拼圖"
  },
  State_2977_WeaponDesc = {
    Text = "奇數回合，當你的手牌為 0 時，抽 2 張牌"
  },
  State_2978_Desc = {
    Text = "每受到 1 點傷害後降低 1 層。層數為 0 後，切換為防禦模式。"
  },
  State_2978_Name = {
    Text = "卡牌計數"
  },
  State_2978_WeaponDesc = {
    Text = "每受到 1 點傷害後降低 1 層。層數為 0 後，切換為防禦模式。"
  },
  State_2979_Desc = {
    Text = "隊伍唯一：裝備者造成的中毒和護盾提高 <WeaponEffect_Num:[StateArg3]%>。裝備者的「打擊」暴擊率和暴擊傷害提高 <WeaponEffect_Num:[StateArg1]%>，並獲得最大生命 <WeaponEffect_Num:[StateArg2]%> 的護盾，護盾效果每回合最多生效 1 次。"
  },
  State_2979_WeaponDesc = {
    Text = "裝備者造成的中毒和護盾提高 <WeaponEffect_Num:[StateArg3]%>。裝備者的「打擊」暴擊率和暴擊傷害提高 <WeaponEffect_Num:[StateArg1]%>，並獲得最大生命 [StateArg2]%([DescArg1]) 的護盾，護盾效果每回合最多生效 1 次。"
  },
  State_2983_Desc = {
    Text = "若棄牌階段仍在手牌中，卡牌將被消耗，本場戰鬥中不再出現。"
  },
  State_2983_Name = {
    Text = "<NothingnessIconKeywords:虛無>"
  },
  State_2983_WeaponDesc = {
    Text = "若棄牌階段仍然在手牌中，則不進入棄牌堆，而是在本場戰鬥中無法再次使用。"
  },
  State_2985_Desc = {
    Text = "直到回合結束，每次造成傷害，回合結束時回復 [Layer] 點生命。"
  },
  State_2985_WeaponDesc = {
    Text = "直到回合結束，每次造成傷害，回復 [Layer] 點生命。"
  },
  State_2988_Desc = {
    Text = "當吞噬胚胎時，從棄牌堆回到手牌堆，算力變為0."
  },
  State_2988_WeaponDesc = {
    Text = "當吞噬胚胎時，從棄牌堆回到手牌堆，算力變為0."
  },
  State_2989_Desc = {
    Text = "出喚醒體的卡牌後，將費用降低 1 的該卡牌的臨時複製洗入牌庫。"
  },
  State_2990_Desc = {
    Text = "打出後使所有敵人失去 [StateArg1] 點臨時力量。"
  },
  State_2990_Name = {
    Text = "<Rune_18_High:高級衰竭>"
  },
  State_2992_Desc = {
    Text = "抽到「空虛」後，本回合內使所有喚醒體獲取的狂氣降低50%。"
  },
  State_2992_Name = {Text = "空虛"},
  State_2992_WeaponDesc = {
    Text = "抽到「空虛」後，本回合內使所有喚醒體獲取的狂氣降低50%。"
  },
  State_2993_Name = {
    Text = "造物怪蛇殘蛻計數"
  },
  State_2994_Desc = {
    Text = "觸腕滿溢時觸腕傷害提高 [StateArg1]。"
  },
  State_2994_WeaponDesc = {
    Text = "觸腕滿溢時觸腕傷害提高 [StateArg1]。"
  },
  State_2996_Desc = {
    Text = "打出後使1條觸腕攻擊 [StateArg1] 次。"
  },
  State_2996_Name = {
    Text = "<Rune_11:統御>"
  },
  State_2997_Desc = {
    Text = "每回合造成第 3 次傷害後，獲得 [Arg1] 點護盾。每回合造成第 6 次傷害後，獲得 [Arg2] 點力量。"
  },
  State_3001_Desc = {
    Text = "受到攻擊時獲得的狂氣提高 2 點。"
  },
  State_3002_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_3002_Name = {
    Text = "狀態@試作鐳射炮幸運"
  },
  State_3003_Desc = {
    Text = "打出後不會進入棄牌堆，而是從牌庫中移除。"
  },
  State_3003_WeaponDesc = {
    Text = "打出後卡牌不會進入棄牌堆，在本場戰鬥中無法再次使用。"
  },
  State_3004_Desc = {
    Text = "[Layer] 回合內免疫被施加的中毒狀態。"
  },
  State_3008_Desc = {
    Text = "每回合開始時，對手牌中剩餘牌添加 1 層遲緩。對於算力消耗超過 5 的牌，將其變成石頭。"
  },
  State_3008_Name = {
    Text = "艾繼絲覺醒！"
  },
  State_3008_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_3011_Desc = {
    Text = "隊伍唯一：裝備者的「狂氣爆發」暴擊率和暴擊傷害提高  <WeaponEffect_Num:[StateArg2]%>。裝備者釋放「狂氣爆發」後，獲得等同於裝備者體質 <WeaponEffect_Num:[StateArg1]%> 的<PowerIconKeywords:力量>。若本次狂氣爆發觸發了<CardKeyWord:吞噬>效果，額外獲得 1 次<PowerIconKeywords:力量>。"
  },
  State_3011_WeaponDesc = {
    Text = "裝備者的「狂氣爆發」暴擊率和暴擊傷害提高  <WeaponEffect_Num:[StateArg2]%>。裝備者釋放「狂氣爆發」後，獲得 <WeaponEffect_Num:[Power:DescArg1]> 點力量。若本次狂氣爆發觸發了<CardKeyWord:吞噬>效果，額外獲得 1 次<PowerIconKeywords:力量>。"
  },
  State_3012_Desc = {
    Text = "無用空狀態"
  },
  State_3012_Name = {
    Text = "無用空狀態"
  },
  State_3012_WeaponDesc = {
    Text = "無用空狀態"
  },
  State_3013_Desc = {
    Text = "渴血患者使胚胎融合提高時，獲得 [StateArg1]  點力量。"
  },
  State_3014_Desc = {
    Text = "若對方手牌數大於等於 4，受到傷害時，就獲得 [StateArg1] 點護盾。"
  },
  State_3015_Desc = {
    Text = "狀態@蠟質鎧甲我方隊伍"
  },
  State_3015_Name = {
    Text = "狀態@蠟質鎧甲我方隊伍"
  },
  State_3015_WeaponDesc = {
    Text = "狀態@蠟質鎧甲我方隊伍"
  },
  State_3016_Desc = {
    Text = "被召喚的怪物生命翻倍。"
  },
  State_3016_Name = {
    Text = "「橫流愧意」"
  },
  State_3016_WeaponDesc = {
    Text = "被召喚的怪物生命翻倍。"
  },
  State_3017_Name = {
    Text = "狀態@詛咒譫妄"
  },
  State_3018_Desc = {
    Text = "「梭行維度之犬」每失去 1 點生命移除 1 層，層數為 0 時，獲得 [StateArg1] 護盾，並重新獲得 [StateArg2] 層維度壁障。"
  },
  State_3018_Name = {
    Text = "維度壁障"
  },
  State_3019_Desc = {
    Text = "每消費 10 黑印回復 1% 生命"
  },
  State_3019_Name = {
    Text = "造物逆生根狀態"
  },
  State_3019_WeaponDesc = {
    Text = "每消費 10 黑印回復 1% 生命"
  },
  State_3020_Desc = {
    Text = "若上回合受到了傷害，回合開始時獲得 1 回合免疫。"
  },
  State_3020_Name = {Text = "適應"},
  State_3020_WeaponDesc = {
    Text = "若上回合受到了傷害，回合開始時獲得 1 回合免疫。"
  },
  State_3021_Desc = {
    Text = "回合開始時獲得 1 算力。"
  },
  State_3021_Name = {
    Text = "狀態@最大算力-2"
  },
  State_3023_Desc = {
    Text = "本回合每次承受主動傷害時，對傷害來源造成 [Layer] 點<FixedDamage:純粹傷害>。"
  },
  State_3023_Name = {
    Text = "臨時反擊"
  },
  State_3023_WeaponDesc = {
    Text = "每次承受主動傷害時，對攻擊者造成 [Layer] 點<FixedDamage:純粹傷害>。"
  },
  State_3024_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_3024_Name = {
    Text = "狀態@試作小刀死抗"
  },
  State_3025_Desc = {
    Text = "每打出 1 張牌，使本回合內的暴擊率提高 10%。"
  },
  State_3026_Desc = {
    Text = "戰鬥開始後將 [StateArg1] 張臨時複製洗入抽牌堆，原始卡牌和鏡像卡牌均獲得保留。"
  },
  State_3026_Name = {
    Text = "<Rune_8_High:高級鏡像>"
  },
  State_3026_WeaponDesc = {
    Text = "戰鬥開始後將 [StateArg1] 張臨時複製洗入抽牌堆。"
  },
  State_3027_Desc = {
    Text = "戰鬥結束後，額外獲得 50 黑印和 1 張症狀卡。"
  },
  State_3028_Name = {
    Text = "狀態@回合開始後算力加2"
  },
  State_3029_Desc = {
    Text = "每受到 1 點傷害後降低 1 層。層數為 0 後，切換為防禦模式。"
  },
  State_3029_Name = {
    Text = "卡牌計數"
  },
  State_3029_WeaponDesc = {
    Text = "每受到 1 點傷害後降低 1 層。層數為 0 後，切換為防禦模式。"
  },
  State_3033_Desc = {
    Text = "每打出 10 張牌，就獲得 1 層抵擋任意傷害的屏障。若你已擁有屏障，改為回復 [Arg1] 點生命。"
  },
  State_3034_Desc = {
    Text = "隊伍唯一：每打出 1 張裝備者的卡牌，就獲得 <WeaponEffect_Num:[StateArg1]> 銀鑰能量。該效果單個回合最多生效 3 次。"
  },
  State_3034_WeaponDesc = {
    Text = "每打出 1 張裝備者的卡牌，就獲得 <WeaponEffect_Num:[StateArg1]> 銀鑰能量。該效果單個回合最多生效 3 次。"
  },
  State_3035_Desc = {
    Text = "打出後使1條觸腕攻擊 [StateArg1] 次。"
  },
  State_3035_Name = {
    Text = "<Rune_11_High:高級統御>"
  },
  State_3035_WeaponDesc = {
    Text = "打出後使1條觸腕攻擊所有敵人 [StateArg1] 次。"
  },
  State_30364_Desc = {
    Text = "此卡牌在手牌中時會使手牌上限 +1。"
  },
  State_30364_Name = {
    Text = "無視手牌上限"
  },
  State_3036_Desc = {
    Text = "造成的脆弱和虛弱效果由 33% 變為 50%。"
  },
  State_3036_Name = {
    Text = "「寂滅餘波」"
  },
  State_3036_WeaponDesc = {
    Text = "造成的脆弱和虛弱效果由 33% 變為 50%。"
  },
  State_3038_Desc = {
    Text = "隊伍唯一：釋放鑰令後，裝備者獲得 <WeaponEffect_Num:[StateArg1]> 狂氣。"
  },
  State_3038_WeaponDesc = {
    Text = "釋放鑰令後，裝備者獲得 <WeaponEffect_Num:[StateArg1]> 狂氣。"
  },
  State_3040_Desc = {
    Text = "每回合開始時，對我方隊伍施加 [Layer] 層【束縛】。"
  },
  State_3040_Name = {Text = "束縛"},
  State_3040_WeaponDesc = {
    Text = "每回合開始時，對我方隊伍施加 [Layer] 層【束縛】。"
  },
  State_3041_Desc = {
    Text = "永久保留在牌庫中。"
  },
  State_3041_Name = {
    Text = "<CardKeyWord:症狀卡>"
  },
  State_3042_Desc = {
    Text = "每次造成傷害時，本回合內獲得 [Arg1] 力量，最多堆疊 3 次。層數滿時效果翻倍。"
  },
  State_3043_Desc = {
    Text = "偶數回合受傷降低 50%，傷害提高 33%。"
  },
  State_3043_Name = {Text = "善變"},
  State_3043_WeaponDesc = {
    Text = "偶數回合受傷降低 50%，傷害提高 33%。"
  },
  State_3045_Desc = {
    Text = "釋放狂氣爆發後，對應喚醒體獲得 20 狂氣。"
  },
  State_3045_Name = {
    Text = "無名之神的面紗"
  },
  State_3046_Desc = {
    Text = "隊伍唯一：每有一個敵人死亡時獲得 [StateArg1] 黑印。裝備者擊殺敵人後，本次關卡中裝備者的暴擊傷害永久提高 <WeaponEffect_Num:[StateArg2]%>，至多疊加 5 層。裝備者每次觸發躍遷效果，使裝備者本回合造成的最終傷害提高 <WeaponEffect_Num:[StateArg3]%> ，至多疊加 3 層。"
  },
  State_3046_WeaponDesc = {
    Text = "每有一個敵人死亡時獲得 [StateArg1] 黑印。裝備者擊殺敵人後，本次關卡中裝備者的暴擊傷害永久提高 <WeaponEffect_Num:[StateArg2]%> ，至多疊加 5 層。裝備者每次觸發躍遷效果，使裝備者本回合造成的最終傷害提高 <WeaponEffect_Num:[StateArg3]%> ，至多疊加 3 層。"
  },
  State_3047_Desc = {
    Text = "回合開始時獲得 [Arg1] 護盾，每過 1 回合就使這個護盾值提高 [Arg2]。"
  },
  State_3047_Name = {
    Text = "守護之手"
  },
  State_3048_Desc = {
    Text = "蘿坦的戰意永不停歇。每回合結束時，蘿坦解除 3 層虛弱和易傷狀態。"
  },
  State_3048_Name = {
    Text = "蘿坦覺醒"
  },
  State_3049_Desc = {
    Text = "使喬治的下次攻擊傷害次數提高 1 。"
  },
  State_3049_WeaponDesc = {
    Text = "使喬治的下次攻擊傷害次數提高 1 。"
  },
  State_3050_Desc = {
    Text = "戰鬥開始時，將 1 張【驚厥】洗入抽牌堆。"
  },
  State_3050_Name = {Text = "驚懼"},
  State_3050_WeaponDesc = {
    Text = "戰鬥開始時，將 1 張【驚厥】洗入抽牌堆。"
  },
  State_3051_Desc = {
    Text = "造成未被格擋的傷害時，將一張哭喊洗入抽牌堆。"
  },
  State_3051_Name = {
    Text = "灼燃蠟滴之欲"
  },
  State_3051_WeaponDesc = {
    Text = "造成實際傷害時，將一張哭喊洗入抽牌堆。"
  },
  State_3054_Name = {
    Text = "狀態@詛咒休克"
  },
  State_3055_Desc = {
    Text = "戰鬥開始時，對我方隊伍造成 1 層脆弱。"
  },
  State_3055_Name = {Text = "貫通"},
  State_3055_WeaponDesc = {
    Text = "戰鬥開始時，對我方隊伍造成 1 層脆弱。"
  },
  State_3056_Desc = {
    Text = "回合結束時，移除 1 層虛弱和易傷。"
  },
  State_3056_Name = {Text = "威壓"},
  State_3058_Desc = {
    Text = "每有 1 條觸腕，回合結束時獲得 [Arg1] 護盾。"
  },
  State_3058_Name = {
    Text = "無名附肢"
  },
  State_3060_Desc = {
    Text = "下回合開始時獲得 [Layer] 點護盾。"
  },
  State_3060_WeaponDesc = {
    Text = "下回合開始時抽 [Layer] 張牌。"
  },
  State_3063_Desc = {
    Text = "每次造成實際傷害時，附加[Layer]中毒。"
  },
  State_3064_Desc = {
    Text = "打出卡牌前就受到等量層數的傷害。回合結束後解除。"
  },
  State_3064_Name = {Text = "束縛"},
  State_3064_WeaponDesc = {
    Text = "打出卡牌前就受到等量層數的傷害。回合結束後解除。"
  },
  State_3065_Name = {
    Text = "狀態@造物過往的貢物2"
  },
  State_3068_Desc = {
    Text = "回合結束後，受到 [Layer] 點<FixedDamage:純粹傷害>。"
  },
  State_3068_WeaponDesc = {
    Text = "回合結束後，受到 [Layer] 點<FixedDamage:純粹傷害>。"
  },
  State_3069_Name = {
    Text = "飾品機械降神"
  },
  State_3069_WeaponDesc = {
    Text = "每場戰鬥的首個回合獲得 1 點額外算力。"
  },
  State_3070_Desc = {
    Text = "隊伍唯一：裝備者的「打擊」使目標敵人失去等同於裝備者攻擊力 <WeaponEffect_Num:[StateArg1]%> 的臨時<PowerIconKeywords:力量>。該效果一個回合內最多觸發3次。"
  },
  State_3070_WeaponDesc = {
    Text = "裝備者的「打擊」使目標敵人臨時降低 <WeaponEffect_Num:[Power:DescArg1]> 點<PowerIconKeywords:力量>。該效果一個回合內最多觸發3次。"
  },
  State_3071_Desc = {
    Text = "隊伍唯一：打出裝備者的「防禦」後，獲得等同於裝備者攻擊力 <WeaponEffect_Num:[StateArg1]%> 的臨時<PowerIconKeywords:力量>。"
  },
  State_3071_WeaponDesc = {
    Text = "打出裝備者的「防禦」後，獲得  <WeaponEffect_Num:[Power:DescArg1]> 點臨時<PowerIconKeywords:力量>。"
  },
  State_3072_Desc = {
    Text = "隊伍唯一：裝備者擊殺敵方後，獲得 <WeaponEffect_Num:[StateArg1]> 狂氣，獲得 1% 暴擊傷害，整場探索有效。"
  },
  State_3072_WeaponDesc = {
    Text = "裝備者擊殺敵方後，獲得 <WeaponEffect_Num:[StateArg1]> 狂氣，獲得 1% 暴擊傷害，整場探索有效。"
  },
  State_3073_Desc = {
    Text = "隊伍唯一：裝備者釋放狂氣爆發後，全體友方本回合暴擊率提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_3073_WeaponDesc = {
    Text = "裝備者釋放狂氣爆發後，全體友方本回合暴擊率提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_3074_Desc = {
    Text = "隊伍唯一：打出一張症狀卡後，裝備者獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣。該效果一個回合內最多觸發 2 次。裝備者打出 1 張指令卡後，獲得 1 點狂氣。"
  },
  State_3074_WeaponDesc = {
    Text = "打出一張症狀卡後，裝備者獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣。該效果一個回合內最多觸發 2 次。裝備者打出 1 張指令卡後，獲得 1 點狂氣。"
  },
  State_3075_Desc = {
    Text = "隊伍唯一：裝備者釋放狂氣爆發後，獲得等同於裝備者防禦力 <WeaponEffect_Num:[StateArg1]%> 的護盾。"
  },
  State_3075_Name = {
    Text = "心之壁壘"
  },
  State_3075_WeaponDesc = {
    Text = "裝備者釋放狂氣爆發後，獲得 <WeaponEffect_Num:[Block:DescArg1]> 點護盾。"
  },
  State_3076_Desc = {
    Text = "隊伍唯一：裝備者造成主動傷害後使其暴擊率提高 <WeaponEffect_Num:[StateArg1]%>，造成暴擊後清空該效果獲得的暴擊率。"
  },
  State_3076_WeaponDesc = {
    Text = "裝備者造成主動傷害後使其暴擊率提高 <WeaponEffect_Num:[StateArg1]%>，造成暴擊後清空該效果獲得的暴擊率。"
  },
  State_3078_Desc = {
    Text = "本回合內造成傷害必定暴擊。"
  },
  State_3078_Name = {
    Text = "臨時必爆"
  },
  State_3078_WeaponDesc = {
    Text = "本回合內暴擊率提升100%"
  },
  State_3082_Desc = {
    Text = "釋放狂氣爆發後，將一張對應喚醒體的隨機卡牌置入手中，該卡牌獲得消耗與虛無。"
  },
  State_3082_Name = {
    Text = "醫生手提箱"
  },
  State_3084_Desc = {
    Text = "打出後將卡牌的 [StateArg1] 張複製加入臨時<DimensionalSpaceIconKeywords:超維空間>。"
  },
  State_3084_Name = {
    Text = "<Rune_13_High:高級折躍>"
  },
  State_3084_WeaponDesc = {
    Text = "打出後消耗，但是會將 [StateArg1] 張臨時原始複製進入超維空間。"
  },
  State_3087_Desc = {
    Text = "打擊牌傷害提高 [Layer] %。"
  },
  State_3087_Name = {
    Text = "打擊牌傷害臨時提高"
  },
  State_3087_WeaponDesc = {
    Text = "打擊牌傷害提高 [Layer] %。"
  },
  State_3088_Desc = {
    Text = "受到的主動傷害提高 [Layer] 。每次受到傷害融蝕傷口都會擴大，回合開始時恢復。"
  },
  State_3088_Name = {
    Text = "深度融蝕"
  },
  State_3088_WeaponDesc = {
    Text = "受到的主動傷害提高[Layer]。每次受到傷害融蝕傷口都會擴大，回合開始時恢復。"
  },
  State_3092_Name = {
    Text = "若是首領戰，所有喚醒體獲得 30 狂氣並解除封印狀態"
  },
  State_3093_Name = {
    Text = "狀態@奇術師模仿秀計數"
  },
  State_3094_Desc = {
    Text = "抽到時使自身脆弱 1 回合。使用後易傷所有敵人 1 回合。無法出售。"
  },
  State_3094_Name = {
    Text = "狀態詛咒崩潰"
  },
  State_3094_WeaponDesc = {
    Text = "抽到時使自身脆弱 1 回合。使用後易傷所有敵人 1 回合。無法出售。"
  },
  State_3095_Desc = {
    Text = "本次關卡內造成的傷害提高 [Layer] 點。"
  },
  State_3095_WeaponDesc = {
    Text = "本次關卡內造成的傷害提高 [Layer] 點。"
  },
  State_3096_Desc = {
    Text = "說服蘿坦的路還有很長一段要走。"
  },
  State_3096_Name = {
    Text = "蘿坦覺醒"
  },
  State_3098_Desc = {
    Text = "拾取後選擇一張卡牌，使其算力消耗永久變為 1。"
  },
  State_3099_Desc = {
    Text = "釋放狂氣爆發後，本回合內獲得 [Arg1] 力量。"
  },
  State_3100_Desc = {
    Text = "每回合開始時死亡抵抗提高 10%。死亡抵抗在 100% 以上時，額外獲得 30 點界域精通。"
  },
  State_3104_Desc = {
    Text = "本回合內，每受到 1 次主動傷害，就使「甜蜜惡鬼」傷害次數+1。"
  },
  State_3104_WeaponDesc = {
    Text = "本回合內，每受到 1 次主動傷害，就使「甜蜜惡鬼」傷害次數+1。"
  },
  State_3106_Desc = {
    Text = "當生命低於50%([StateArg1]) 時，將會分裂為2只等量生命的「實驗習作」。"
  },
  State_3106_WeaponDesc = {
    Text = "當生命低於 50%([StateArg1]) 時，將會分裂為3只等量生命的「II型融蝕體蠟像」。"
  },
  State_3108_Name = {
    Text = "飾品環形詩篇"
  },
  State_3108_WeaponDesc = {
    Text = "偶數回合開始後，獲得 1 點算力。"
  },
  State_3109_Name = {
    Text = "狀態@第四章共鳴@算力減1"
  },
  State_3109_WeaponDesc = {
    Text = "“天真的回禮”算力消耗減1"
  },
  State_3110_Name = {
    Text = "狀態@第四章共鳴@算力減1"
  },
  State_3110_WeaponDesc = {
    Text = "“天真的回禮”算力消耗減1"
  },
  State_3111_Desc = {
    Text = "下回合開始時，將剩餘的護盾轉化為2倍生命"
  },
  State_3111_Name = {
    Text = "不滅之花"
  },
  State_3112_Desc = {
    Text = "隊伍唯一：裝備者造成的中毒提高 <WeaponEffect_Num:[StateArg3]%>。裝備者釋放狂氣爆發後，回復等同於裝備者體質 <WeaponEffect_Num:[StateArg1]%> 的生命，每剩餘 1 點算力就額外回復裝備者體質的 <WeaponEffect_Num:[StateArg2]%> 的生命。"
  },
  State_3112_Name = {
    Text = "無聲歡宴"
  },
  State_3112_WeaponDesc = {
    Text = "裝備者造成的中毒提高 <WeaponEffect_Num:[StateArg3]%>。裝備者釋放狂氣爆發後，回復 <WeaponEffect_Num:[Heal:DescArg1]> 點生命，每剩餘 1 點算力額外回復 <WeaponEffect_Num:[Heal:DescArg2]> 點生命。"
  },
  State_3113_Desc = {
    Text = "狀態@序章狂氣0_1_4"
  },
  State_3113_Name = {
    Text = "狀態@序章狂氣0_1_4"
  },
  State_3113_WeaponDesc = {
    Text = "狀態@序章狂氣0_1_4"
  },
  State_3114_Desc = {
    Text = "狀態@序章狂氣0_1_2"
  },
  State_3114_Name = {
    Text = "狀態@序章狂氣0_1_2"
  },
  State_3114_WeaponDesc = {
    Text = "狀態@序章狂氣0_1_2"
  },
  State_3115_Desc = {
    Text = "狀態@序章狂氣0_1_2"
  },
  State_3115_Name = {
    Text = "狀態@序章狂氣0_1_2"
  },
  State_3115_WeaponDesc = {
    Text = "狀態@序章狂氣0_1_2"
  },
  State_3116_Name = {
    Text = "狀態@序章狂氣0_1_1"
  },
  State_3117_Desc = {
    Text = "隊伍唯一：裝備者「打擊」和「狂氣爆發」基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。裝備者打出「打擊」後，裝備者獲得 5% 臨時暴擊率，每回合最多 3 次，達到 3 次時獲得 15% 臨時暴擊傷害。"
  },
  State_3117_WeaponDesc = {
    Text = "裝備者「打擊」和「狂氣爆發」基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。裝備者打出「打擊」後，裝備者獲得 5% 臨時暴擊率，每回合最多 3 次，達到 3 次時獲得 15% 臨時暴擊傷害。"
  },
  State_3118_Desc = {
    Text = "回合開始時回覆 [Layer]% 已損失生命。"
  },
  State_3118_Name = {
    Text = "引舵之帆的庇護"
  },
  State_3120_Desc = {
    Text = "[防禦]獲得 [Arg1] 層反擊。"
  },
  State_3121_Desc = {
    Text = "若敵人的意圖不為攻擊，對其造成主動或觸腕傷害後，附加等同於一半傷害層數的出血。"
  },
  State_3123_Desc = {
    Text = "隊伍唯一：裝備者造成的<RetaliateIconKeywords: 反擊>提高 <WeaponEffect_Num:[StateArg3]%>。每受到 1 次攻擊，就獲得等同於裝備者攻擊力 <WeaponEffect_Num:[StateArg1]%> 的臨時<PowerIconKeywords:力量>。裝備者使用狂氣爆發後，獲得等同於裝備者攻擊力 <WeaponEffect_Num:[StateArg2]%> 的<RetaliateIconKeywords: 反擊>。"
  },
  State_3123_WeaponDesc = {
    Text = "裝備者造成的反擊提高 <WeaponEffect_Num:[StateArg3]%>。每受到 1 次攻擊，就獲得 <WeaponEffect_Num:[Power:DescArg1]> 點臨時<PowerIconKeywords:力量>。裝備者使用狂氣爆發後，獲得 <WeaponEffect_Num:[Counterattack:DescArg2]> 點反擊。"
  },
  State_3124_Desc = {
    Text = "幸運偵探獲得的黑印翻倍。"
  },
  State_3124_Name = {
    Text = "絕佳運氣"
  },
  State_3124_WeaponDesc = {
    Text = "幸運偵探獲得的黑印翻倍。"
  },
  State_3127_Name = {
    Text = "狀態@關卡2_10戰鬥3氣泡1"
  },
  State_3128_Desc = {
    Text = "所有喚醒體造成的護盾和生命回復提高 [StateArg1]%。"
  },
  State_3128_Name = {Text = "搖籃"},
  State_3129_Desc = {
    Text = "下回合開始前每次承受主動傷害額外觸發 [Layer] 次反擊和觸腕反擊，造成 50% 傷害。"
  },
  State_3129_Name = {
    Text = "逆鱗之護"
  },
  State_3130_Desc = {
    Text = "本回合內造成的傷害提高 [Layer] 點。"
  },
  State_3130_Name = {
    Text = "臨時力量"
  },
  State_3130_WeaponDesc = {
    Text = "本回合內造成的傷害提高 [Layer] 點。"
  },
  State_3135_Desc = {
    Text = "每擁有 1 層，造成的主動傷害次數+1。"
  },
  State_3135_Name = {
    Text = "<MadnessIconKeywords:瘋狂>"
  },
  State_3136_Name = {Text = "狂氣"},
  State_3137_Desc = {
    Text = "戰鬥開始時，獲得 1 條觸腕，觸腕傷害永久提高 [Arg1]。"
  },
  State_3138_Name = {
    Text = "飾品二律背反"
  },
  State_3138_WeaponDesc = {
    Text = "裝備者使用狂氣爆發後，己方基於裝備者防禦力的 100% 獲得<RetaliateIconKeywords:反擊>。並使自身當前<RetaliateIconKeywords:反擊>提高 10%。"
  },
  State_3139_Desc = {
    Text = "進入超維回合後解除自身虛弱和脆弱狀態，並虛弱和易傷所有敵人 2 回合。"
  },
  State_3140_Desc = {
    Text = "戰鬥開始時，將「幻覺」置入超維空間，直到你的超維空間達到 4 張。"
  },
  State_3143_Desc = {
    Text = "造成實際傷害時，使我方隊伍失去 [Layer] 臨時力量。"
  },
  State_3143_Name = {Text = "麻痺"},
  State_3144_Name = {
    Text = "我方隊伍\"中毒\"與\"出血\"層數減半"
  },
  State_3145_Desc = {
    Text = "在 [Layer] 回合內，不可使用卡牌。"
  },
  State_3145_Name = {
    Text = "無法打出卡牌"
  },
  State_3146_Desc = {
    Text = "海之使徒打出 1 張牌時，生成 [StateArg1] 條臨時觸腕，該觸腕可以無視觸腕上限。"
  },
  State_3146_Name = {
    Text = "代行權能"
  },
  State_3146_WeaponDesc = {
    Text = "海之使徒打出 1 張牌時，生成 [StateArg1] 條臨時觸腕，該觸腕可以無視觸腕上限。"
  },
  State_3149_Desc = {
    Text = "下回合開始時，承受的主動和觸腕傷害提高 50 %。"
  },
  State_3149_Name = {
    Text = "延遲易傷"
  },
  State_3149_WeaponDesc = {
    Text = "承受的所有傷害提高 50 %。"
  },
  State_3150_Desc = {
    Text = "一回合內受到 3 次攻擊後，獲得 1 層臨時<MadnessColour:瘋狂>。"
  },
  State_3151_Desc = {
    Text = "拾取時永久獲得 [Arg1] 點力量。"
  },
  State_3152_Name = {
    Text = "狀態@飾品再衍化"
  },
  State_3152_WeaponDesc = {
    Text = "裝備者回合結束後獲得 3 點狂氣。若裝備者狂氣回充大於 10 ，額外獲得 2 點狂氣。"
  },
  State_3153_Name = {
    Text = "狀態@詛咒譫妄還原"
  },
  State_3154_Name = {Text = "暴擊率"},
  State_3155_Desc = {
    Text = "每回合回復 10% 已損失生命。"
  },
  State_3155_Name = {Text = "醫濟"},
  State_3155_WeaponDesc = {
    Text = "每回合回復 10% 已損失生命。"
  },
  State_3156_Desc = {
    Text = "每回合受到的第一段傷害變為5倍。"
  },
  State_3156_Name = {
    Text = "驚慌失措"
  },
  State_3160_Desc = {
    Text = "回合開始時，將一張本回合內獲得 [Arg1] 戒備的「陽傘」加入手中，打出 6 張卡牌後，使手牌中所有的「陽傘」戒備提高 [Arg2]。"
  },
  State_3161_Desc = {
    Text = "對手抽牌數量減少 [Layer] ，但所有牌獲得保留。"
  },
  State_3161_WeaponDesc = {
    Text = "我方隊伍抽牌數量減少 [Layer] ，所有牌獲得保留"
  },
  State_3163_Desc = {
    Text = "觸發死亡抵抗後，回復 [Layer] 點生命。"
  },
  State_3163_Name = {
    Text = "星之搖籃"
  },
  State_3163_WeaponDesc = {
    Text = "觸發死亡抵抗後，回復 [Layer] 點生命。"
  },
  State_3164_Name = {
    Text = "綿綿恨怨計數"
  },
  State_3165_Name = {
    Text = "竄行者啟靈3"
  },
  State_3166_Name = {
    Text = "本場戰鬥已觸發"
  },
  State_3168_Desc = {
    Text = "回合開始時給全體怪物加攻擊次數計數"
  },
  State_3168_Name = {
    Text = "狀態@復仇巨刃斬首重創"
  },
  State_3168_WeaponDesc = {
    Text = "回合開始時給全體怪物加攻擊次數計數"
  },
  State_3170_Desc = {
    Text = "施加衝動的代價"
  },
  State_3170_Name = {
    Text = "施加衝動的代價"
  },
  State_3170_WeaponDesc = {
    Text = "施加衝動的代價"
  },
  State_3171_Name = {
    Text = "狀態@關卡2_1戰鬥3氣泡1"
  },
  State_3172_Desc = {
    Text = "每次造成傷害時，獲得 [StateArg1] 點臨時力量，最多堆疊 [StateArg2] 次。層數滿時效果翻倍。"
  },
  State_3172_Name = {
    Text = "造物染血鵝卵石"
  },
  State_3174_Name = {
    Text = "造物六分儀2"
  },
  State_3175_Desc = {
    Text = "每回合開始時所有喚醒體獲得 10 狂氣。"
  },
  State_3175_Name = {
    Text = "造物六分儀1"
  },
  State_3175_WeaponDesc = {
    Text = "每回合開始時所有喚醒體獲得 10 狂氣。"
  },
  State_3176_Desc = {
    Text = "序章重置牌庫0_1_1_1"
  },
  State_3176_Name = {
    Text = "序章重置牌庫0_1_1_1_2"
  },
  State_3176_WeaponDesc = {
    Text = "序章重置牌庫0_1_1_1"
  },
  State_3177_Desc = {
    Text = "「警覺」達到 3 層時進行後退，並召喚一個「替身蠟像」。回合開始時清空層數。"
  },
  State_3177_Name = {Text = "警覺"},
  State_3177_WeaponDesc = {
    Text = "「警覺」達到 3 層時進行後退，並召喚一個「替身蠟像」。回合開始時清空層數。"
  },
  State_3178_Name = {
    Text = "<SlowIconKeywords: 遲緩>"
  },
  State_3178_WeaponDesc = {
    Text = "每層遲緩使卡牌的算力消耗增加 1 點。"
  },
  State_3179_Desc = {
    Text = "戰鬥開始時獲得 20 護盾。每回合開始時若有護盾，當回合護盾和治療強效提高 50%。"
  },
  State_3179_Name = {
    Text = "異化花園守護者"
  },
  State_3179_WeaponDesc = {
    Text = "戰鬥開始時獲得 20 護盾。每回合開始時若有護盾，當回合護盾和治療強效提高 50%。"
  },
  State_3180_Desc = {
    Text = "暴擊率提高 25%。造成生命回復後，有幾率額外造成 1 次生命回復，機率等於造成回復者的暴擊率。"
  },
  State_3180_Name = {
    Text = "狀態@幻夢銀鑰：暴擊治療"
  },
  State_3181_Name = {Text = "暴擊率"},
  State_3183_Desc = {
    Text = "本回合內暴擊傷害提高 [Layer] %。"
  },
  State_3183_Name = {
    Text = "臨時暴擊傷害"
  },
  State_3185_Desc = {
    Text = "移動時增加額外壓力"
  },
  State_3185_Name = {
    Text = "造物無底袋2"
  },
  State_3185_WeaponDesc = {
    Text = "移動時增加額外壓力"
  },
  State_3189_Name = {
    Text = "怪物延遲力量"
  },
  State_3190_Name = {
    Text = "造物鑰匙"
  },
  State_3193_Desc = {
    Text = "下回合開始後獲得 [Layer] 護盾。"
  },
  State_3193_Name = {
    Text = "失落的藝術"
  },
  State_3193_WeaponDesc = {
    Text = "下回合開始後獲得 [Layer] 護盾。"
  },
  State_3196_Desc = {
    Text = "打出後獲得 [StateArg1] 點算力。"
  },
  State_3196_Name = {
    Text = "<Rune_4_High:高級籌算>"
  },
  State_3196_WeaponDesc = {
    Text = "打出後獲得 [StateArg1] 點算力。"
  },
  State_3197_Desc = {
    Text = "「打擊」回復 [Arg1] 點生命，並減半自身出血和中毒層數。"
  },
  State_3197_Name = {Text = "止血鉗"},
  State_3200_Desc = {
    Text = "隊伍唯一：裝備者造成的基礎傷害和護盾提高 <WeaponEffect_Num:[StateArg1]%>。探索開始時將一張裝備者的「打擊」和「防禦」加入牌庫。裝備者打出「防禦」後，使裝備者下一張「打擊」暴擊率與暴擊傷害提高 15%，裝備者打出「打擊」後，使裝備者下一張「防禦」護盾提高 15%，可堆疊 3 次。"
  },
  State_3200_WeaponDesc = {
    Text = "裝備者造成的基礎傷害和護盾提高 <WeaponEffect_Num:[StateArg1]%>。探索開始時將一張裝備者的「打擊」和「防禦」加入牌庫。裝備者打出「防禦」後，使裝備者下一張「打擊」暴擊率與暴擊傷害提高 15%，裝備者打出「打擊」後，使裝備者下一張「防禦」護盾提高 15%，可堆疊 3 次。"
  },
  State_3201_Name = {
    Text = "綿綿恨怨"
  },
  State_3203_Desc = {
    Text = "隊伍唯一：裝備者造成的護盾提升 <WeaponEffect_Num:[StateArg3]%>。裝備者的「防禦」對生命最高敵人造成裝備者防禦力  <WeaponEffect_Num:[StateArg1]%> 的<IntoxicationIconKeywords:中毒>。若當前界域為「血肉」，施加<IntoxicationIconKeywords:中毒>時<EmbryoFusionIconKeywords:胚胎融合> + <WeaponEffect_Num:[Blood:StateArg2]>，該效果每回合最多觸發 3 次。"
  },
  State_3203_WeaponDesc = {
    Text = "裝備者造成的護盾提升 <WeaponEffect_Num:[StateArg3]%>。裝備者的「防禦」對生命最高敵人造成 <WeaponEffect_Num:[Poison:DescArg1]> 層<IntoxicationIconKeywords:中毒>。若當前界域為「血肉」，施加<IntoxicationIconKeywords:中毒>時<EmbryoFusionIconKeywords:胚胎融合> +<WeaponEffect_Num:[Blood:StateArg2]>，該效果每回合最多觸發 3 次。"
  },
  State_3204_Desc = {
    Text = "造成實際傷害時，將[StateArg1] 張 「傷口」 洗入抽牌堆。"
  },
  State_3204_Name = {Text = "裂傷"},
  State_3204_WeaponDesc = {
    Text = "抽到時使自身虛弱 1 回合。使用後虛弱所有敵人 1 回合。無法出售。"
  },
  State_3206_Desc = {
    Text = "每打出 1 張牌，使本回合內的暴擊率提高 [StateArg1]%，最多堆疊 [StateArg2] 次。層數滿時效果翻倍。"
  },
  State_3206_Name = {
    Text = "造物孟菲斯儀式鏡"
  },
  State_3206_WeaponDesc = {
    Text = "每打出 1 張牌，使本回合內的暴擊率提高 [StateArg1]%，最多堆疊 [StateArg2] 次。層數滿時效果翻倍。"
  },
  State_3207_Desc = {
    Text = "每失去 1 點生命移除 1 層，層數為 0 時獲得 [DescArg1] 的護盾。"
  },
  State_3207_Name = {
    Text = "維度壁障"
  },
  State_3208_Desc = {
    Text = "石化中，無法行動，回合結束後移除。"
  },
  State_3209_Name = {
    Text = "飾品生機榨取"
  },
  State_3209_WeaponDesc = {
    Text = "戰鬥開始後，若裝備者職業為血肉，攻擊力提高 25%。"
  },
  State_3210_Name = {
    Text = "狀態@復仇巨刃啟靈1"
  },
  State_3211_Desc = {
    Text = "手牌上限提高 2，回合結束時不再棄掉手牌。每當失去生命時，隨機棄掉 2 張手牌。"
  },
  State_3212_Desc = {
    Text = "造成的主動和觸腕傷害降低 25 ％，回合結束時移除 1 層。"
  },
  State_3212_Name = {
    Text = "<WeaknessIconKeywords: 虛弱>"
  },
  State_3212_WeaponDesc = {
    Text = "造成的所有傷害降低 25 %。"
  },
  State_3213_Desc = {
    Text = "護盾和治療的效果提高[Layer] %"
  },
  State_3213_Name = {
    Text = "臨時護盾和治療強效"
  },
  State_3213_WeaponDesc = {
    Text = "護盾和治療的效果提高[Layer] %"
  },
  State_3215_Name = {
    Text = "時靈擺「隱秘」"
  },
  State_3216_Desc = {
    Text = "戰鬥結束後，額外獲得 100 黑印，但得到一張症狀卡。"
  },
  State_3216_Name = {
    Text = "造物好運戒指"
  },
  State_3216_WeaponDesc = {
    Text = "戰鬥結束後，額外獲得 100 黑印，但得到一張症狀卡。"
  },
  State_3220_Desc = {
    Text = "釋放狂氣爆發後，抽 1 張牌。若生命低於 25%，額外抽 1 張牌。"
  },
  State_3223_Desc = {
    Text = "造成的虛弱效果提高 10%。每 3 回合對所有敵人添加 1 層虛弱。"
  },
  State_3224_Name = {
    Text = "造物阿爾卡納記錄算力"
  },
  State_3225_Name = {
    Text = "斷頸一擊"
  },
  State_3226_Desc = {
    Text = "打出後卡牌不會進入棄牌堆，在本場戰鬥中無法再次使用。"
  },
  State_3226_WeaponDesc = {
    Text = "打出後卡牌不會進入棄牌堆，在本場戰鬥中無法再次使用。"
  },
  State_3227_Desc = {
    Text = "所有造物價格降低 50%。"
  },
  State_3227_Name = {
    Text = "造物貿易勳章"
  },
  State_3227_WeaponDesc = {
    Text = "所有造物價格降低 50%。"
  },
  State_3228_Desc = {
    Text = "回合開始時，狂氣最低喚醒體獲得25狂氣"
  },
  State_3228_Name = {
    Text = "造物阿爾卡納狂氣"
  },
  State_3228_WeaponDesc = {
    Text = "回合開始時，狂氣最低喚醒體獲得25狂氣"
  },
  State_3229_Desc = {
    Text = "序章重置牌庫0_1_1_1"
  },
  State_3229_Name = {
    Text = "序章重置牌庫0_1_1_1"
  },
  State_3229_WeaponDesc = {
    Text = "序章重置牌庫0_1_1_1"
  },
  State_3230_Name = {
    Text = "狀態@通用延遲算力"
  },
  State_3232_Desc = {
    Text = "狀態@怪物超維卡槽觸發器"
  },
  State_3232_Name = {
    Text = "狀態@怪物超維卡槽觸發器"
  },
  State_3232_WeaponDesc = {
    Text = "狀態@怪物超維卡槽觸發器"
  },
  State_3234_Desc = {
    Text = "戰鬥開始時，獲得 3 力量，但每次受到的傷害提高 5。"
  },
  State_3235_Desc = {
    Text = "戰鬥開始時，獲得 [Layer] 力量，但每次受到的傷害提高 5。"
  },
  State_3236_Desc = {
    Text = "打出後其他喚醒體獲得 [StateArg1] 狂氣。"
  },
  State_3236_Name = {
    Text = "<Rune_16_High:高級催化>"
  },
  State_3237_Desc = {
    Text = "每 3 個回合獲得 3 條觸腕，該觸腕無視觸腕上限，回合結束時移除。"
  },
  State_3238_Desc = {
    Text = "戰鬥開始時給予怪物受到的所有傷害提高的狀態"
  },
  State_3238_Name = {
    Text = "戰鬥開始時給予怪物受到的所有傷害提高的狀態"
  },
  State_3238_WeaponDesc = {
    Text = "戰鬥開始時給予怪物受到的所有傷害提高的狀態"
  },
  State_3239_Desc = {
    Text = "提高[Layer]點攻擊力。"
  },
  State_3239_Name = {
    Text = "通用攻擊力提高"
  },
  State_3239_WeaponDesc = {
    Text = "提高[Layer]點攻擊力。"
  },
  State_3242_Name = {
    Text = "將 2 張<DerivativeCardKeywords_4:「靈感」>置入抽牌堆"
  },
  State_3244_Desc = {
    Text = "被召喚的怪物生命翻倍。"
  },
  State_3244_Name = {
    Text = "「橫流愧意」"
  },
  State_3244_WeaponDesc = {
    Text = "被召喚的怪物生命翻倍。"
  },
  State_3245_Desc = {
    Text = "戰鬥開始時，我方隊伍暴擊率下降 30%，暴擊傷害提高 30%。"
  },
  State_3245_WeaponDesc = {
    Text = "戰鬥開始時，我方隊伍暴擊率下降 30%，暴擊傷害提高 30%。"
  },
  State_3246_Desc = {
    Text = "戰鬥開始時普通敵人的生命增加 30 %，戰鬥勝利後額外提供25黑印。"
  },
  State_3246_Name = {
    Text = "造物殘破戰旗"
  },
  State_3246_WeaponDesc = {
    Text = "戰鬥開始時普通敵人的生命增加 30 %，戰鬥勝利後額外提供25黑印。"
  },
  State_3247_Desc = {
    Text = "【狂氣爆發】使所有手牌算力消耗 -1。"
  },
  State_3247_Name = {
    Text = "異化文明之光"
  },
  State_3247_WeaponDesc = {
    Text = "【狂氣爆發】使所有手牌算力消耗 -1。"
  },
  State_3249_Desc = {
    Text = "其他友方獲得 1 層<MadnessColour:瘋狂>，自身死亡後解除。"
  },
  State_3249_Name = {Text = "躁動"},
  State_3249_WeaponDesc = {
    Text = "其他友方獲得 1 層瘋狂，自身死亡後解除。"
  },
  State_3250_Desc = {
    Text = "戰鬥結束後仍然保留在牌庫中，但打出或被消耗後將永久移除。"
  },
  State_3250_Name = {
    Text = "<DestructionKeywords:銷毀>"
  },
  State_3250_WeaponDesc = {
    Text = "打出後將其永久移除。"
  },
  State_3251_Desc = {
    Text = "承受主動或觸腕傷害時，免疫傷害並減少 1 層，回合開始時移除。"
  },
  State_3251_Name = {
    Text = "<ParcloseColour: 臨時屏障>"
  },
  State_3252_Desc = {
    Text = "淤泥之花施加護盾時，最大生命提高 [StateArg2]。"
  },
  State_3252_Name = {
    Text = "黏液彙集"
  },
  State_3252_WeaponDesc = {
    Text = "淤泥之花施加護盾時，最大生命提高 [StateArg2]。"
  },
  State_3253_Desc = {
    Text = "獲得[StateArg1]點臨時戒備。"
  },
  State_3253_Name = {
    Text = "<CardKeyWord:機械武裝-盾>"
  },
  State_3253_WeaponDesc = {
    Text = "獲得[StateArg1]點臨時戒備"
  },
  State_3255_Name = {Text = "反擊"},
  State_3256_Name = {
    Text = "狀態@詛咒興奮"
  },
  State_3259_Desc = {
    Text = "造成的主動傷害次數提高[Layer] 。"
  },
  State_3259_Name = {
    Text = "<MadnessColour:瘋狂>"
  },
  State_3260_Desc = {
    Text = "超維空間達到上限時，獲得一個額外回合，此回合不再抽牌，而是將超維空間卡牌置入手牌。"
  },
  State_3260_Name = {
    Text = "<DimensionalSpaceIconKeywords:超維空間>"
  },
  State_3260_WeaponDesc = {
    Text = "超維空間達到上限時，獲得一個額外的超維回合，將所有超維空間卡牌加入手牌。"
  },
  State_3261_Desc = {
    Text = "其召喚的怪物傷害翻倍。"
  },
  State_3261_Name = {
    Text = "「蠟像軍團」"
  },
  State_3261_WeaponDesc = {
    Text = "其召喚的怪物傷害翻倍。"
  },
  State_3262_Desc = {
    Text = "狀態@蠟質鍍層我方隊伍"
  },
  State_3262_Name = {
    Text = "狀態@蠟質鍍層我方隊伍"
  },
  State_3262_WeaponDesc = {
    Text = "狀態@蠟質鍍層我方隊伍"
  },
  State_3263_Name = {
    Text = "狀態@鸚鵡螺螺殼回擊"
  },
  State_3265_Name = {
    Text = "棄掉時將其移除"
  },
  State_3266_Desc = {
    Text = "死夢之都的強化躍遷"
  },
  State_3266_Name = {
    Text = "狀態@死夢之都強化躍遷"
  },
  State_3267_Desc = {
    Text = "戰鬥開始時，獲得 5 層【蠟質鎧甲】。"
  },
  State_3267_Name = {
    Text = "「蠟之紳士」"
  },
  State_3267_WeaponDesc = {
    Text = "戰鬥開始時，獲得 5 層【蠟質鎧甲】。"
  },
  State_3268_Desc = {
    Text = "回合開始時抽 1 張牌。每當你抽到 1 張牌時，隨機變化其算力消耗（0-4）。"
  },
  State_3268_Name = {
    Text = "造物萬花筒"
  },
  State_3268_WeaponDesc = {
    Text = "回合開始時抽 1 張牌。每當你抽到 1 張牌時，隨機變化其算力消耗（0-4）。"
  },
  State_3269_Desc = {
    Text = "每回合獲得第 2 次護盾後，獲得 [Arg1] 層反擊。每回合獲得第 4 次護盾後，對所有敵人造成 1 次反擊傷害。"
  },
  State_3269_Name = {
    Text = "知無不言"
  },
  State_3270_Name = {
    Text = "狀態@章二共鳴複製"
  },
  State_3271_Desc = {
    Text = "[打擊]對所有敵人施加 [Arg1] 層中毒。"
  },
  State_3272_Desc = {
    Text = "造成未被格擋的傷害時，回復 3 倍實際傷害值的生命，造成傷害時移除。"
  },
  State_3273_Desc = {
    Text = "隊伍唯一：打出裝備者的卡牌後，獲得等同於裝備者 <WeaponEffect_Num:[StateArg1]%> 防禦力的護盾，每有 1 條觸腕就使護盾提高裝備者防禦力的 <WeaponEffect_Num:[StateArg2]%>。該效果單個回合只生效 1 次。"
  },
  State_3273_WeaponDesc = {
    Text = "打出裝備者的卡牌後，獲得 <WeaponEffect_Num:[Block:DescArg1]> 護盾，每有 1 條觸腕就使護盾提高 <WeaponEffect_Num:[DescArg2]>。該效果單個回合只生效 1 次。"
  },
  State_3274_Desc = {
    Text = "每次收到主動傷害給我方隊伍增加一層計數"
  },
  State_3274_Name = {
    Text = "狀態@復仇巨刃斬首重創我方隊伍計數"
  },
  State_3274_WeaponDesc = {
    Text = "每次收到主動傷害給我方隊伍增加一層計數"
  },
  State_3277_Desc = {
    Text = "打出後所屬喚醒體獲得 [StateArg1] 點狂氣。"
  },
  State_3280_Name = {
    Text = "命定之劍"
  },
  State_3281_Desc = {
    Text = "提高造成的主動傷害。"
  },
  State_3281_WeaponDesc = {
    Text = "造成的傷害提高。"
  },
  State_3282_Desc = {
    Text = "傷害次數和傷害提高。"
  },
  State_3282_Name = {
    Text = "<CardKeyWord:升級>"
  },
  State_3282_WeaponDesc = {
    Text = "增加一次傷害"
  },
  State_3283_Desc = {
    Text = "每回合開始時，回復 [StateArg1] 生命。如果生命低於 50% ，回復生命變為 [StateArg2]。"
  },
  State_3283_Name = {
    Text = "造物乳香製劑"
  },
  State_3283_WeaponDesc = {
    Text = "每回合開始時，回復 [StateArg1] 生命。如果生命低於 50% ，回復生命變為 [StateArg2]。"
  },
  State_3287_Desc = {
    Text = "戰鬥開始時，將 2 張「靈感」洗入你的牌庫。每通過 1 場戰鬥都會使這個造物升級，最多 3 次。"
  },
  State_3288_Desc = {
    Text = "狀態@空狀態"
  },
  State_3288_Name = {
    Text = "狀態@空狀態"
  },
  State_3288_WeaponDesc = {
    Text = "狀態@空狀態"
  },
  State_3289_Desc = {
    Text = "每受到 1 點傷害降低 1 層。層數為 0 後，將意圖替換為不滅之花，並使用偏向防禦的技能組。"
  },
  State_3289_Name = {
    Text = "不滅之花"
  },
  State_3289_WeaponDesc = {
    Text = "每受到 1 點傷害後降低 1 層。層數為 0 後，切換為防禦模式。"
  },
  State_3290_Desc = {
    Text = "曾為「彌利亞姆」的異怪陷入了極度的偏執與絕望，擊碎她最後的妄執，終結這數千年的瘋狂。"
  },
  State_3290_Name = {Text = "妄執"},
  State_3291_Desc = {
    Text = "造成實際傷害時，使我方隊伍失去 3 臨時力量。"
  },
  State_3291_Name = {Text = "麻痺"},
  State_3292_Desc = {
    Text = "釋放狂氣爆發時，敵人每將要造成 1 次傷害，就對其施加 [Arg1] 層中毒"
  },
  State_3293_Desc = {
    Text = "本次關卡內造成的傷害降低 [Layer] 點。"
  },
  State_3293_WeaponDesc = {
    Text = "本次關卡內造成的傷害和觸腕傷害降低 [Layer] 點。"
  },
  State_3294_Name = {
    Text = "狀態@詛咒多疑"
  },
  State_3296_Desc = {
    Text = "棄掉或打出時將其移除。"
  },
  State_3296_Name = {
    Text = "棄掉或打出時將其移除"
  },
  State_3296_WeaponDesc = {
    Text = "抽到時使自身虛弱 1 回合。使用後虛弱所有敵人 1 回合。無法出售。"
  },
  State_3297_Desc = {
    Text = "狀態@荊棘女王啟明_形"
  },
  State_3297_Name = {
    Text = "狀態@荊棘女王啟明_形"
  },
  State_3297_WeaponDesc = {
    Text = "狀態@荊棘女王啟明_形"
  },
  State_3298_Desc = {
    Text = "本回合內下一次躍遷效果必定觸發。"
  },
  State_3298_Name = {
    Text = "躍遷必定觸發"
  },
  State_3298_WeaponDesc = {
    Text = "本回合內躍遷效果無需條件。"
  },
  State_3301_Name = {
    Text = "群星之酒計數"
  },
  State_3302_Desc = {
    Text = "施加永遠凝結"
  },
  State_3302_Name = {
    Text = "施加永遠凝結"
  },
  State_3302_WeaponDesc = {
    Text = "施加永遠凝結"
  },
  State_3304_Desc = {
    Text = "每回合打出最後一張指令卡的對應喚醒體，在回合結束時獲得 15 狂氣，若同時擁有「母親造像」，使其他喚醒體也獲得 5 狂氣。"
  },
  State_3305_Desc = {
    Text = "打出後將 [StateArg1] 張 「靈感」 洗入抽牌堆。「靈感」：獲得 1 算力，抽 1 張牌，保留，消耗。"
  },
  State_3305_Name = {
    Text = "<Rune_17:靈感>"
  },
  State_3307_Name = {
    Text = "(剩餘：[Layer])"
  },
  State_3308_Desc = {
    Text = "回合開始時，如果上個回合剩餘的手牌數超過 2 張，獲得 2 算力。"
  },
  State_3309_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_3309_Name = {
    Text = "狀態@試作長劍死抗"
  },
  State_3310_Desc = {
    Text = "遷移者施加護盾時，獲得 [Energy:StateArg2] 狂氣。"
  },
  State_3310_Name = {
    Text = "自我封鎖"
  },
  State_3310_WeaponDesc = {
    Text = "遷移者施加護盾時，獲得 [Energy:StateArg2] 狂氣。"
  },
  State_3312_Desc = {
    Text = "每當你回復生命時獲得 [Arg1] 點反擊，若生命值大於 75%，額外獲得 [Arg2] 點反擊。"
  },
  State_3313_Desc = {
    Text = "回合開始時使本回合內獲得 [Arg1] 點力量，每打出 1 張卡牌就使本回合內失去 [Arg2] 點力量。"
  },
  State_3314_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_3314_Name = {
    Text = "尚未覺醒"
  },
  State_3315_Desc = {
    Text = "每回合打出第一張卡牌後，使隨機 2 張手牌變為其原始版複製，回合結束時恢復。"
  },
  State_3315_Name = {
    Text = "造物蠱惑風鈴"
  },
  State_3316_Desc = {
    Text = "回合結束時護盾會保留。"
  },
  State_3316_Name = {
    Text = "守護防壁"
  },
  State_3316_WeaponDesc = {
    Text = "回合結束時護盾會保留。"
  },
  State_3317_Desc = {
    Text = "回合結束時失去所有護盾"
  },
  State_3317_Name = {
    Text = "枷鎖：生父"
  },
  State_3318_Name = {
    Text = "狀態@渴血者獻媚者之擁吞噬標識"
  },
  State_3323_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_3323_Name = {
    Text = "狀態@試作長劍狂氣"
  },
  State_3324_Desc = {
    Text = "本回合內暴擊傷害提高 [Layer] %。"
  },
  State_3324_Name = {
    Text = "臨時暴擊傷害"
  },
  State_3324_WeaponDesc = {
    Text = "本回合內暴擊傷害提高 [Layer] %。"
  },
  State_3325_Desc = {
    Text = "每次重置牌庫時，將 2 張本回合內獲得 [Arg1] 點力量的「漁叉」和 1 張本回合內獲得 [Arg2] 點戒備的 「陽傘」加入手牌。"
  },
  State_3326_Desc = {
    Text = "每回合免疫首次主動傷害。"
  },
  State_3326_Name = {Text = "堅定"},
  State_3326_WeaponDesc = {
    Text = "每回合免疫首次主動傷害。"
  },
  State_3328_Desc = {
    Text = "本場戰鬥受到致死傷害時，復活一次並回復 [Layer] 點生命，無法驅散。"
  },
  State_3328_Name = {
    Text = "不死的極樂鳥"
  },
  State_3329_Desc = {
    Text = "每打出 5 張牌，獲得一張你手中最左側卡牌的複製，但附加虛無和消耗。"
  },
  State_3330_Desc = {
    Text = "卡牌算力消耗增加 [Layer] 點。打出卡牌後該負面效果會被移除。"
  },
  State_3330_Name = {
    Text = "<SlowColour:遲緩 [Layer]>"
  },
  State_3330_WeaponDesc = {
    Text = "卡牌算力消耗增加 [Layer]點。"
  },
  State_3332_Desc = {
    Text = "承受主動或觸腕傷害時，免疫傷害並減少 1 層。"
  },
  State_3335_Desc = {
    Text = "戰鬥開始時，對所有敵人施加 1 層易傷。「凝滯詛咒」額外使敵人受到的易傷效果提高 25%。"
  },
  State_3335_Name = {
    Text = "石之眼啟靈6"
  },
  State_3336_Name = {
    Text = "狀態@喬治@死亡時治療"
  },
  State_3337_Name = {Text = "紅祭禮"},
  State_3339_Desc = {
    Text = "提高[Layer]點攻擊力。"
  },
  State_3339_Name = {
    Text = "臨時攻擊力提高"
  },
  State_3339_WeaponDesc = {
    Text = "提高[Layer]點攻擊力。"
  },
  State_3340_Desc = {
    Text = "釋放狂氣爆發後，本場戰鬥內狂氣爆發傷害提高 [Arg1]，最多堆疊 5 次。堆疊滿時釋放該狂氣爆發的喚醒體獲得 100 狂氣。"
  },
  State_3341_Desc = {
    Text = "狀態@序章重置牌庫0_1_2_1"
  },
  State_3341_Name = {
    Text = "狀態@序章重置牌庫0_1_2_1"
  },
  State_3341_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_2_1"
  },
  State_3342_Desc = {
    Text = "狀態@序章重置牌庫0_1_2_2"
  },
  State_3342_Name = {
    Text = "狀態@序章重置牌庫0_1_2_2"
  },
  State_3342_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_2_2"
  },
  State_3343_Desc = {
    Text = "狀態@序章重置牌庫0_1_2_3"
  },
  State_3343_Name = {
    Text = "狀態@序章重置牌庫0_1_2_3"
  },
  State_3343_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_2_3"
  },
  State_3344_Desc = {
    Text = "狀態@序章重置牌庫0_1_2_4"
  },
  State_3344_Name = {
    Text = "狀態@序章重置牌庫0_1_2_4"
  },
  State_3344_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_2_4"
  },
  State_3345_Desc = {
    Text = "狀態@序章重置牌庫0_1_2_5"
  },
  State_3345_Name = {
    Text = "狀態@序章重置牌庫0_1_2_5"
  },
  State_3345_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_2_5"
  },
  State_3346_Desc = {
    Text = "狀態@序章重置牌庫0_1_2_5"
  },
  State_3346_Name = {
    Text = "狀態@序章重置牌庫0_1_2_5"
  },
  State_3346_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_2_6"
  },
  State_3347_Desc = {
    Text = "狀態@序章重置牌庫0_1_2_5"
  },
  State_3347_Name = {
    Text = "狀態@序章重置牌庫0_1_2_5"
  },
  State_3347_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_2_7"
  },
  State_3348_Desc = {
    Text = "打出後抽 [StateArg1] 張牌。"
  },
  State_3348_Name = {
    Text = "<Rune_3_High:高級妙手>"
  },
  State_3348_WeaponDesc = {
    Text = "打出後抽 [StateArg1] 張牌。"
  },
  State_3350_Desc = {
    Text = "釋放狂氣爆發後，失去 10% 當前生命，本回合內偷取所有敵人 [Arg1] 點力量。"
  },
  State_3351_Name = {
    Text = "狀態@加入卡組後"
  },
  State_3352_Name = {
    Text = "造物秘典星象儀1"
  },
  State_3354_Name = {
    Text = "造物秘典星象儀2"
  },
  State_3356_Name = {
    Text = "回合結束窒息中毒"
  },
  State_3357_Desc = {
    Text = "下回合開始後，觸腕傷害 +[Layer]。"
  },
  State_3357_Name = {
    Text = "延遲觸腕傷害"
  },
  State_3358_Desc = {
    Text = "下回合開始後，獲得 [Layer] 點護盾。"
  },
  State_3358_Name = {
    Text = "失落的藝術-護盾"
  },
  State_3359_Desc = {
    Text = "你每打出的第 3 張牌會生效 2 次。"
  },
  State_3359_WeaponDesc = {
    Text = "你每打出的第 3 張牌會生效 2 次。"
  },
  State_3360_Desc = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3360_Name = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3360_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3362_Desc = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3362_Name = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3362_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3364_Desc = {
    Text = "拾取時選擇一張卡牌，將兩個三選一強化效果賦予其上。（注：類似千面幻象捏卡）"
  },
  State_3365_Desc = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3365_Name = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3365_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3366_Desc = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3366_Name = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3366_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3368_Desc = {
    Text = "若棄牌階段前算力消耗大於5，則變為石頭。"
  },
  State_3368_WeaponDesc = {
    Text = "棄牌階段前將手牌變成石頭"
  },
  State_3369_Desc = {
    Text = "你的所有吞噬效果均變為無限吞噬。"
  },
  State_3369_Name = {
    Text = "無限吞噬"
  },
  State_3369_WeaponDesc = {
    Text = "你的所有吞噬效果均變為無限吞噬。"
  },
  State_3370_Desc = {
    Text = "本次關卡內造成的護盾降低 [Layer] 點。"
  },
  State_3370_Name = {
    Text = "永久戒備降低"
  },
  State_3370_WeaponDesc = {
    Text = "本次關卡內造成的護盾降低 [Layer] 點。"
  },
  State_3372_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_3372_Name = {
    Text = "尚未覺醒"
  },
  State_3373_Desc = {
    Text = "造成實際傷害時，將[StateArg1] 張 「傷口」 洗入抽牌堆。"
  },
  State_3373_WeaponDesc = {
    Text = "抽到時使自身虛弱 1 回合。使用後虛弱所有敵人 1 回合。無法出售。"
  },
  State_3374_Desc = {
    Text = "回合結束後，獲得等量層數的力量。"
  },
  State_3374_Name = {Text = "憤怒"},
  State_3376_Desc = {
    Text = "本場戰鬥內狂氣爆發造成的傷害提高 [Layer] 點。"
  },
  State_3376_Name = {
    Text = "狂氣爆發傷害提高"
  },
  State_3378_Desc = {
    Text = "釋放狂氣爆發後，下一張打出的卡牌生效 2 次。"
  },
  State_3378_Name = {
    Text = "狀態@幻夢銀鑰：爆發"
  },
  State_3379_Desc = {
    Text = "生命低於 50% 時，破鏈者將會狂暴。"
  },
  State_3379_Name = {
    Text = "復仇之刻"
  },
  State_3379_WeaponDesc = {
    Text = "生命低於 50% 時，破鏈者將會狂暴。"
  },
  State_3380_Desc = {
    Text = "戰鬥開始時，將 1 張【迷惑】洗入抽牌堆。"
  },
  State_3380_WeaponDesc = {
    Text = "戰鬥開始時，將 1 張【迷惑】洗入抽牌堆。"
  },
  State_3381_Name = {
    Text = "超維職業初始化"
  },
  State_3382_Desc = {
    Text = "獲得一個任務。完成任務後，獲得獎勵。【任務事件佔位】"
  },
  State_3383_Name = {
    Text = "超維職業初始化"
  },
  State_3385_Desc = {
    Text = "受到的主動和觸腕傷害降低33%。"
  },
  State_3385_Name = {Text = "鏡盾"},
  State_3385_WeaponDesc = {
    Text = "受到的主動和觸腕傷害降低33%。"
  },
  State_3386_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_3386_Name = {
    Text = "狀態@試作長劍暴擊"
  },
  State_3387_Name = {
    Text = "狀態@關卡2_3戰鬥3氣泡1"
  },
  State_3388_Desc = {
    Text = "打出後獲得 [StateArg1] 點力量。"
  },
  State_3388_Name = {
    Text = "<Rune_14:蠻力>"
  },
  State_3389_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_3389_Name = {
    Text = "尚未覺醒"
  },
  State_3390_Desc = {
    Text = "戰鬥開始時，虛弱和易傷所有敵人 1 回合。"
  },
  State_3392_Desc = {
    Text = "拾取時獲得 [Arg1] 力量。每當有「胚胎」被融合，本回合內獲得 [Arg2] 點力量。"
  },
  State_3393_Desc = {
    Text = "回合開始時胚胎融合+30%。你的所有吞噬效果均變為無限吞噬。"
  },
  State_3394_Name = {
    Text = "將 1 張<DerivativeCardKeywords_4:「靈感」>置入抽牌堆"
  },
  State_3395_Desc = {
    Text = "隊伍唯一：裝備者的「打擊」基礎傷害提高 25%，「防禦」基礎護盾提高 25%。打出裝備者「打擊」時獲得裝備者攻擊力 <WeaponEffect_Num:[StateArg1]%> 的臨時<PowerIconKeywords:力量>，打出裝備者「防禦」時獲得裝備者防禦力 <WeaponEffect_Num:[StateArg2]%> 的臨時<AlertIconKeywords:戒備>。若當前界域為「超維」，進入超維回合時獲得一次臨時<PowerIconKeywords:力量>與臨時<AlertIconKeywords:戒備>。"
  },
  State_3395_WeaponDesc = {
    Text = "裝備者的「打擊」基礎傷害提高 25%，「防禦」基礎護盾提高 25%。打出裝備者「打擊」時獲得 <WeaponEffect_Num:[Power:DescArg1]> 點臨時<PowerIconKeywords:力量>，打出裝備者「防禦」時獲得<WeaponEffect_Num:[DescArg2]> 點臨時<AlertIconKeywords:戒備>。若當前界域為「超維」，進入超維回合時獲得一次臨時<PowerIconKeywords:力量>與臨時<AlertIconKeywords:戒備>。"
  },
  State_3397_Desc = {
    Text = "每打出第 10 張牌時，提高 [Arg1] 觸腕傷害，使所有觸腕攻擊 1 次。"
  },
  State_3400_Desc = {
    Text = "精英敵人和首領敵人的生命上限降低 20%。"
  },
  State_3401_Desc = {
    Text = "打出後額外生效 [StateArg1] 次，獲得 [StateArg2] 點黑印，消耗，固有。"
  },
  State_3401_Name = {
    Text = "<Rune_7:回聲>"
  },
  State_3402_Desc = {
    Text = "「鐵鎬」盧森重擊傷害提高 [Layer] %。"
  },
  State_3402_Name = {
    Text = "重擊傷害提高"
  },
  State_3402_WeaponDesc = {
    Text = "鐵鎬盧森重擊傷害提高 [Layer] %"
  },
  State_3403_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_3403_Name = {
    Text = "尚未覺醒"
  },
  State_3405_Name = {
    Text = "所有敵人臨時降低 [Power:StateArg1] 點<PowerIconKeywords:力量>， 1 回合內獲得的護盾和<PowerIconKeywords:力量>降低 50%"
  },
  State_3406_Name = {
    Text = "獲得 [StateArg1] 點<PowerIconKeywords:力量>"
  },
  State_3407_Name = {
    Text = "選擇 1 張抽牌堆的卡牌置入手牌並使其算力消耗 -1"
  },
  State_3408_Name = {
    Text = "獲得  <Posse:[DescArg1]>  點銀鑰能量。在本場戰鬥中「斷頸一擊」和「千面幻象」的基礎傷害提高 10%"
  },
  State_3409_Name = {
    Text = "選擇一名喚醒體獲得 <Energy:[DescArg1]> 點狂氣"
  },
  State_3410_Name = {
    Text = "此卡牌暴擊率和暴擊傷害提高 50%，造成穿刺傷害"
  },
  State_3411_Name = {
    Text = "自身免疫<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虛弱>、<VulnerabilityIconKeywords:易傷> 1 回合。獲得 <Block:[Block:StateArg1]> 點護盾"
  },
  State_3412_Desc = {
    Text = "免疫負面狀態，回合結束或被暴擊後減少 1 層。"
  },
  State_3412_Name = {
    Text = "蠟質鍍層"
  },
  State_3412_WeaponDesc = {
    Text = "每層使受到的傷害降低 10%，每次被暴擊後減少 1 層。"
  },
  State_3415_Desc = {
    Text = "拾取時從 3 個腐化刻印中選擇獲得 1 個。腐化刻印比普通刻印更強大，但打出時消耗卡牌。"
  },
  State_3415_WeaponDesc = {
    Text = "拾取時從 3 個腐化刻印中選擇獲得 1 個。腐化刻印比普通刻印更強大，但打出時消耗卡牌。"
  },
  State_3416_Desc = {
    Text = "隊伍唯一：戰鬥開始後，獲得等同於裝備者防禦力 <WeaponEffect_Num:[StateArg1]%> 的反擊。觸發<DeathResistanceIconKeywords: 死亡抵抗>後，獲得至多總計 2 層「搖籃」：全體友方造成的護盾和生命回覆提升 <WeaponEffect_Num:[StateArg2]%> ，回合結束時移除 1 層，若當前界域為「血肉」，觸發<DeathResistanceIconKeywords: 死亡抵抗>後胚胎融合 <WeaponEffect_Num:+[Blood:StateArg3]> 。"
  },
  State_3416_WeaponDesc = {
    Text = "戰鬥開始後，獲得 <WeaponEffect_Num:[Counterattack:DescArg1]> 層反擊。觸發<DeathResistanceIconKeywords: 死亡抵抗>後，獲得至多總計 2 層「搖籃」：全體友方造成的護盾和生命回覆提升 <WeaponEffect_Num:[StateArg2]%> ，回合結束時移除 1 層，若當前界域為「血肉」，觸發<DeathResistanceIconKeywords: 死亡抵抗>後胚胎融合 <WeaponEffect_Num:+[Blood:StateArg3]> 。"
  },
  State_3418_Desc = {
    Text = "回合結束後，失去臨時力量"
  },
  State_3418_Name = {
    Text = "延遲衰竭"
  },
  State_3419_Desc = {
    Text = "拾取時展示 3 張具有高級或詛咒刻印的卡牌，選擇一張賦予其對應刻印。"
  },
  State_3420_Desc = {
    Text = "每次行動造成出血，治療可減半出血層數。"
  },
  State_3420_Name = {Text = "血濺"},
  State_3420_WeaponDesc = {
    Text = "每次行動造成出血，治療可減半出血層數。"
  },
  State_3421_Desc = {
    Text = "回合開始時，將一張本回合內獲得 [Arg1] 力量「漁叉」加入手中。釋放狂氣爆發後，使手牌中所有的「漁叉」力量提高 [Arg2]。"
  },
  State_3422_Name = {
    Text = "狀態@飾品無垢啟示錄"
  },
  State_3422_WeaponDesc = {
    Text = "釋放鑰令後，回復 [DescArg1] 生命。若裝備者銀鑰充能等級大於 20，額外回復 [DescArg1] 生命。同類效果無法重複生效。"
  },
  State_3423_Desc = {
    Text = "界域精通100，造成傷害加臨時觸腕傷害。"
  },
  State_3423_Name = {
    Text = "時靈擺「夢魘」"
  },
  State_3424_Desc = {
    Text = "回合開始時，如果上個回合打出卡牌數超過 3 張，抽 2 張牌。"
  },
  State_3425_Desc = {
    Text = "生命低於 50%([StateArg1]) 時，將意圖變為「絕境求生」：移除脆弱、虛弱和中毒狀態，對我方隊伍造成 99 層虛弱和脆弱"
  },
  State_3425_Name = {
    Text = "復仇之刻"
  },
  State_3425_WeaponDesc = {
    Text = "生命低於 50%([StateArg1]) 時，將意圖變為「絕境求生」：移除脆弱、虛弱和中毒狀態，對我方隊伍造成 99 層虛弱和脆弱"
  },
  State_3429_Desc = {
    Text = "每次行動附加出血，治療可移除出血效果"
  },
  State_3429_Name = {Text = "重傷"},
  State_3429_WeaponDesc = {
    Text = "每次行動附加出血，治療可移除出血效果"
  },
  State_3430_Desc = {
    Text = "釋放狂氣爆發後，獲得 [Arg1] 點反擊。若本場戰鬥內第 6 次觸發，則使你的反擊翻倍。"
  },
  State_3432_Desc = {
    Text = "棄掉時將其消耗"
  },
  State_3432_Name = {
    Text = "棄牌消耗"
  },
  State_3432_WeaponDesc = {
    Text = "抽到時使自身虛弱 1 回合。使用後虛弱所有敵人 1 回合。無法出售。"
  },
  State_3434_Name = {
    Text = "狀態@通用造成易傷修正"
  },
  State_3436_Desc = {
    Text = "有 [Layer] 名喚醒體正在被狩獵。"
  },
  State_3436_Name = {Text = "被狩獵"},
  State_3437_Desc = {
    Text = "狀態@怪物鯨躍幻影星球初子_混沌之獸"
  },
  State_3437_Name = {
    Text = "狀態@怪物鯨躍幻影星球初子_混沌之獸"
  },
  State_3437_WeaponDesc = {
    Text = "狀態@怪物鯨躍幻影星球初子_混沌之獸"
  },
  State_3438_Desc = {
    Text = "獲得[StateArg1]點臨時力量。"
  },
  State_3438_Name = {
    Text = "<CardKeyWord:機械武裝-劍>"
  },
  State_3439_Desc = {
    Text = "回合結束時圖魯獲得 5 點狂氣。"
  },
  State_3439_Name = {
    Text = "群星歸位"
  },
  State_3440_Name = {
    Text = "黃金嚮導"
  },
  State_3441_Desc = {
    Text = "奇數回合，當你的手牌為 0 時，抽 2 張牌；偶數回合，當你的算力為 0 時，獲得 2 算力。"
  },
  State_3441_Name = {
    Text = "異化老舊拼圖"
  },
  State_3441_WeaponDesc = {
    Text = "奇數回合，當你的手牌為 0 時，抽 2 張牌；偶數回合，當你的算力為 0 時，獲得 2 算力。"
  },
  State_3442_Desc = {
    Text = "拾取時永久失去 [Arg1] 力量。每當造成傷害時，回復 [Arg2] 點生命，每回合最多觸發 6 次。"
  },
  State_3442_Name = {
    Text = "七鰓鰻之吻"
  },
  State_3444_Desc = {
    Text = "回合開始時抽 1 張牌。"
  },
  State_3445_Desc = {
    Text = "提高[Layer]%防禦力。"
  },
  State_3445_Name = {
    Text = "通用防禦力百分比提高"
  },
  State_3445_WeaponDesc = {
    Text = "提高[Layer]%防禦力。"
  },
  State_3446_Desc = {
    Text = "擁有 5 層【導火線】。打出卡牌後層數減少 1。當層數變為 0 時自爆，造成攻擊力*2.5 的傷害。"
  },
  State_3446_Name = {Text = "爆彈"},
  State_3446_WeaponDesc = {
    Text = "擁有 5 層【導火線】。打出卡牌後層數減少 1。當層數變為 0 時自爆，造成攻擊力*2.5 的傷害。"
  },
  State_3447_Desc = {
    Text = "擁有 5 層【導火線】。打出卡牌後層數減少 1。當層數變為 0 時自爆，造成攻擊力*2.5 的傷害。"
  },
  State_3447_Name = {Text = "爆彈"},
  State_3447_WeaponDesc = {
    Text = "擁有 5 層【導火線】。打出卡牌後層數減少 1。當層數變為 0 時自爆，造成攻擊力*2.5 的傷害。"
  },
  State_3448_Desc = {
    Text = "每回合結束後，激發所有觸腕"
  },
  State_3448_Name = {
    Text = "觸腕自動激發"
  },
  State_3448_WeaponDesc = {
    Text = "每回合結束後，激發所有觸腕"
  },
  State_3449_Desc = {
    Text = "狀態@序章狂氣0_1_1生效"
  },
  State_3449_Name = {
    Text = "狀態@序章狂氣0_1_1生效"
  },
  State_3449_WeaponDesc = {
    Text = "狀態@序章狂氣0_1_1生效"
  },
  State_3450_Desc = {
    Text = "承受主動或觸腕傷害時，免疫傷害並移除 1 層。"
  },
  State_3450_WeaponDesc = {
    Text = "承受的傷害降低 99%，承受傷害後降低 1 層。"
  },
  State_3451_Desc = {
    Text = "死亡時所有喚醒體獲得 10 狂氣。"
  },
  State_3451_Name = {
    Text = "彌留的銀屑"
  },
  State_3451_WeaponDesc = {
    Text = "死亡時所有喚醒體獲得 10 狂氣。"
  },
  State_3452_Desc = {
    Text = "每次打出卡牌時受到 [StateArg1] 傷害並移除 1 層。回合結束時若仍存在，孵化一個「海中之物」，每有 1 層生命就提高 10%。"
  },
  State_3452_Name = {
    Text = "深淵侵蝕"
  },
  State_3453_Name = {
    Text = "狀態@復仇巨刃力量倍數"
  },
  State_3455_Desc = {
    Text = "狀態@序章狂氣初始化0_2_3效果"
  },
  State_3455_Name = {
    Text = "狀態@序章狂氣初始化0_2_3效果"
  },
  State_3455_WeaponDesc = {
    Text = "狀態@序章狂氣初始化0_2_3效果"
  },
  State_3456_Desc = {
    Text = "[防禦]獲得 [StateArg1] 層反擊。"
  },
  State_3456_Name = {
    Text = "造物刺蕁麻背心"
  },
  State_3457_Name = {
    Text = "免疫易傷"
  },
  State_3458_Desc = {
    Text = "打出 [打擊] 與 [防禦] 後，對應喚醒體獲得 35 狂氣。但是它們的算力消耗+1。"
  },
  State_3459_Desc = {
    Text = "本場戰鬥內狂氣爆發造成的傷害提高 [Layer] 點。"
  },
  State_3459_Name = {
    Text = "狂氣爆發傷害提高"
  },
  State_3461_Desc = {
    Text = "你每造成的第 5 次傷害必定暴擊。"
  },
  State_3462_Name = {
    Text = "狀態@復仇巨刃力量倍數3"
  },
  State_3463_Name = {
    Text = "狀態@復仇巨刃力量倍數2"
  },
  State_3464_Desc = {
    Text = "觸腕上限提高 1 條。生命低於 50% 時，觸腕傷害提高 [Arg1] 。"
  },
  State_3465_Desc = {
    Text = "該卡牌將攜帶出戰鬥，關卡內有效。"
  },
  State_3465_Name = {
    Text = "<CardKeyWord:永續>"
  },
  State_3465_WeaponDesc = {
    Text = "該卡牌能攜帶出戰鬥，關卡內有效。"
  },
  State_3466_Desc = {
    Text = "拾取時選擇一名喚醒體將其覺醒，其覺醒卡算力消耗永久降低 1。"
  },
  State_34671_Desc = {
    Text = "打出後返回手牌。"
  },
  State_34685_Name = {
    Text = "炸彈2玩家"
  },
  State_34689_Desc = {
    Text = "每失去 1 點生命，獲得 1 層<PainWord:忍耐>，上限為最大生命的 100%。忍耐會繼承至下場戰鬥。"
  },
  State_3468_Desc = {
    Text = "狀態@殘次品的怨念"
  },
  State_3468_Name = {
    Text = "狀態@殘次品的怨念"
  },
  State_3468_WeaponDesc = {
    Text = "狀態@殘次品的怨念"
  },
  State_34691_Desc = {
    Text = "每失去 1 點生命，獲得 1 層<PainWord:忍耐>。上限為 [DescArg1] 層。忍耐會繼承至下場戰鬥。"
  },
  State_34696_Desc = {
    Text = "此卡牌任何情況下都會在手牌中並使手牌上限 +1。"
  },
  State_34696_Name = {
    Text = "永久保留並無視手牌上限"
  },
  State_3469_Desc = {
    Text = "造成的主動和觸腕傷害降低 [DescArg1] %。"
  },
  State_3469_Name = {
    Text = "<WeaknessColour:虛弱>"
  },
  State_3469_WeaponDesc = {
    Text = "造成的所有傷害降低 [DescArg1] %。"
  },
  State_3470_Desc = {
    Text = "施加漸漸石化檢測"
  },
  State_3470_Name = {
    Text = "施加漸漸石化檢測"
  },
  State_3470_WeaponDesc = {
    Text = "施加漸漸石化檢測"
  },
  State_3471_Desc = {
    Text = "你每打出的第 [StateArg1] 張牌會生效 2 次。"
  },
  State_3471_Name = {
    Text = "群星之酒計數"
  },
  State_3471_WeaponDesc = {
    Text = "你每打出的第 [StateArg1] 張牌會生效 2 次。"
  },
  State_3473_Desc = {
    Text = "生命低於 50% 時，「提燈教牧」將會祈求「神降」，吸收所有教眾後狂暴。"
  },
  State_3473_Name = {
    Text = "燈芯的烙印"
  },
  State_3473_WeaponDesc = {
    Text = "生命低於 50% 時，「提燈教牧」將會祈求「神降」，吸收所有教眾後狂暴。"
  },
  State_3475_Desc = {
    Text = "[打擊]與[防禦]算力消耗+1。"
  },
  State_3475_Name = {
    Text = "造物詛咒石碑"
  },
  State_3475_WeaponDesc = {
    Text = "[打擊]與[防禦]算力消耗+1。"
  },
  State_3476_Desc = {
    Text = "每當你損失生命，胚胎融合+10%。若生命低於 50% 時效果翻倍。"
  },
  State_3477_Desc = {
    Text = "受到攻擊時恢復 [Layer] %最大生命值，受到超過最大生命值 15 %的傷害時，眩暈並移除此狀態"
  },
  State_3478_Name = {
    Text = "狀態@飾品標準密契"
  },
  State_3479_Desc = {
    Text = "每消費 1 黑印所有喚醒體獲得 1 狂氣"
  },
  State_3479_WeaponDesc = {
    Text = "每消費 1 黑印所有喚醒體獲得 1 狂氣"
  },
  State_3480_Desc = {
    Text = "直到回合結束，生命值不會降為0."
  },
  State_3480_WeaponDesc = {
    Text = "直到回合結束，生命值不會降為0."
  },
  State_3481_Desc = {
    Text = "關卡開始時，將你的死亡抵抗率和幸運刻印率翻倍。"
  },
  State_3481_Name = {
    Text = "狀態@幻夢銀鑰：雙倍幸運"
  },
  State_3482_Desc = {
    Text = "造成的易傷效果提高 25%。每 3 回合對所有敵人添加 1 層易傷。"
  },
  State_3483_Desc = {
    Text = "每次行動附加出血，治療可移除出血效果"
  },
  State_3483_Name = {Text = "重傷"},
  State_3483_WeaponDesc = {
    Text = "每次行動附加出血，治療可移除出血效果"
  },
  State_3484_Desc = {
    Text = "造成實際傷害時，獲得力量。"
  },
  State_3484_Name = {
    Text = "「紛亂人格」"
  },
  State_3485_Desc = {
    Text = "狀態@提燈儀式生效"
  },
  State_3485_Name = {
    Text = "狀態@提燈儀式生效"
  },
  State_3485_WeaponDesc = {
    Text = "狀態@提燈儀式生效"
  },
  State_3486_Name = {
    Text = "命定之劍"
  },
  State_3488_Desc = {
    Text = "打出卡牌時受到 [StateArg1] 點傷害並移除 1 層。層數為 0 時孵化一個較弱的「海中之物」。若回合結束時仍存在被寄生狀態，孵化一個生命隨層數提高的「海中之物」。"
  },
  State_3489_Name = {
    Text = "回合結束時若在手牌或<DimensionalSpaceIconKeywords:超維空間>，升級為「腐化綠炎」"
  },
  State_3489_WeaponDesc = {
    Text = "回合結束時若在手牌或超維空間會得到強化"
  },
  State_3490_Desc = {
    Text = "打出卡牌時受到 [StateArg1] 點傷害並移除 1 層。層數為 0 時孵化一個較弱的「海中之物」。若回合結束時仍存在被寄生狀態，孵化一個生命隨層數提高的「海中之物」。"
  },
  State_3492_Desc = {
    Text = "每個偶數回合使我方隊伍力量減少[Layer]。"
  },
  State_3495_Desc = {
    Text = "每次行動附加[Layer]出血"
  },
  State_3495_Name = {Text = "重傷"},
  State_3495_WeaponDesc = {
    Text = "每次行動附加[Layer]出血，治療可移除出血效果"
  },
  State_34964_Desc = {
    Text = "回合開始後，獲得 10% 最大生命的<PainWord:忍耐>。"
  },
  State_34964_Name = {
    Text = "永不遺忘"
  },
  State_3496_Name = {
    Text = "回合結束時若在手牌或<DimensionalSpaceIconKeywords:超維空間>，升級為「死滅綠炎」"
  },
  State_3496_WeaponDesc = {
    Text = "回合結束時若在手牌或超維空間會得到強化"
  },
  State_3497_Desc = {
    Text = "隊伍由不同職業的喚醒體組成時，隊伍生命與所有喚醒體的攻擊與防禦提高 200%"
  },
  State_3497_WeaponDesc = {
    Text = "隊伍由不同職業的喚醒體組成時，隊伍生命與所有喚醒體的攻擊與防禦提高 200%"
  },
  State_3499_Desc = {
    Text = "隊伍唯一：裝備者產生的狂氣提高 <WeaponEffect_Num:[StateArg1]%> 。裝備者釋放狂氣爆發後，獲得 <WeaponEffect_Num:[StateArg2]> 點銀鑰能量。"
  },
  State_3499_WeaponDesc = {
    Text = "裝備者產生的狂氣提高 <WeaponEffect_Num:[StateArg1]%> 。裝備者釋放狂氣爆發後，獲得 <WeaponEffect_Num:[StateArg2]> 點銀鑰能量。"
  },
  State_3502_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_3502_Name = {
    Text = "狀態@試作小刀狂氣"
  },
  State_3504_Desc = {
    Text = "每回合開始時，抽 [StateArg1] 張牌。"
  },
  State_3504_Name = {
    Text = "造物定向羅盤"
  },
  State_3504_WeaponDesc = {
    Text = "每回合開始時，抽 [StateArg1] 張牌。"
  },
  State_3507_Name = {
    Text = "飾品有機形態"
  },
  State_3507_WeaponDesc = {
    Text = "裝備者使用狂氣爆發後，本回合內自身護盾和治療強效翻倍。"
  },
  State_3508_Name = {
    Text = "飾品少女之蛹"
  },
  State_3508_WeaponDesc = {
    Text = "戰鬥開始後，若裝備者職業為混沌，攻擊力提高 25%。"
  },
  State_3510_Desc = {
    Text = "喚醒體造成的護盾提高 [Layer] 點。"
  },
  State_3510_Name = {
    Text = "<AlertColour: 戒備>"
  },
  State_3511_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_3511_Name = {
    Text = "狀態@試作長劍幸運"
  },
  State_35120_Desc = {
    Text = "每受到 1 次主動傷害，對傷害來源施加 [StateArg1] 層中毒，持續 [Layer] 回合。"
  },
  State_35120_Name = {
    Text = "淤泥上的不滅之花"
  },
  State_3512_Name = {
    Text = "臨時免疫脆弱"
  },
  State_3514_Desc = {
    Text = "回合結束時受到等量層數的<FixedDamage:純粹傷害>並移除該狀態。"
  },
  State_3514_WeaponDesc = {
    Text = "回合開始時受到傷害。"
  },
  State_35158_Name = {
    Text = "時靈擺「入迷」"
  },
  State_3515_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_3515_Name = {
    Text = "尚未覺醒"
  },
  State_35161_Name = {
    Text = "時靈擺「積蓄」"
  },
  State_3516_Name = {
    Text = "狀態@詛咒頹喪"
  },
  State_3518_Desc = {
    Text = "奇術師每打出 1 張卡牌，就獲得 [StateArg2] 臨時力量。"
  },
  State_3519_Desc = {
    Text = "即使不在超維回合，每回合也能夠觸發一次躍遷效果。"
  },
  State_3519_Name = {
    Text = "空間偏折儀"
  },
  State_3519_WeaponDesc = {
    Text = "即使不在超維回合，每回合也能夠觸發一次躍遷效果。"
  },
  State_3520_Desc = {
    Text = "戰鬥開始時，選擇一名喚醒體，給予其 50 狂氣。"
  },
  State_35228_Name = {
    Text = "時靈擺「積蓄」"
  },
  State_3522_Name = {
    Text = "造物漁叉計數"
  },
  State_35238_Desc = {
    Text = "隊伍唯一：裝備者造成的護盾和中毒提高  <WeaponEffect_Num:[StateArg1]%>。每當觸發死亡抵抗，所有喚醒體獲得  <WeaponEffect_Num:[StateArg2]%> 臨時暴擊率和暴擊傷害。"
  },
  State_35238_WeaponDesc = {
    Text = "裝備者造成的護盾和中毒提高  <WeaponEffect_Num:[StateArg1]%>。每當觸發死亡抵抗，所有喚醒體獲得  <WeaponEffect_Num:[StateArg2]%> 臨時暴擊率和暴擊傷害。"
  },
  State_3523_Desc = {
    Text = "打出後虛弱所有敵人 [StateArg1] 回合。"
  },
  State_3523_Name = {
    Text = "<Rune_1_High:高級虛弱>"
  },
  State_3524_Desc = {
    Text = "承受的傷害提高 [Layer] 點。"
  },
  State_3524_Name = {
    Text = "融蝕傷口"
  },
  State_3524_WeaponDesc = {
    Text = "承受的傷害提高 [Layer] 點。"
  },
  State_3525_Desc = {
    Text = "我方隊伍每打出 1 張卡牌，就對其施加 2 層【束縛】。"
  },
  State_3525_Name = {
    Text = "「東區特供」"
  },
  State_3525_WeaponDesc = {
    Text = "我方隊伍每打出 1 張卡牌，就對其施加 2 層【束縛】。"
  },
  State_35264_Desc = {
    Text = "本回合每打出1張牌後「奇術師」獲得 1 層幻影。"
  },
  State_35264_Name = {
    Text = "移形換影記錄"
  },
  State_35277_Name = {
    Text = "卡茜亞的魔術防禦"
  },
  State_3527_Desc = {
    Text = "每回合打出第一張指令卡的對應喚醒體，在回合結束時獲得 15 狂氣，若同時擁有「奉獻精神」，使其他喚醒體也獲得 5 狂氣。"
  },
  State_3528_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_3528_Name = {
    Text = "狀態@試作鐳射炮界域"
  },
  State_3529_Desc = {
    Text = "免疫一切傷害，回合開始後移除。"
  },
  State_3529_Name = {
    Text = "免疫傷害"
  },
  State_3530_Desc = {
    Text = "狀態@幸運偵探肆意豪賭標識8"
  },
  State_3530_Name = {
    Text = "狀態@幸運偵探肆意豪賭標識8"
  },
  State_3530_WeaponDesc = {
    Text = "狀態@幸運偵探肆意豪賭標識8"
  },
  State_3531_Desc = {
    Text = "隊伍唯一：戰鬥開始時，裝備者獲得 <WeaponEffect_Num:[StateArg1]> 狂氣。每當其他喚醒體釋放狂氣爆發時，裝備者獲得 <WeaponEffect_Num:[StateArg2]> 狂氣。若當前界域為「深海」，裝備者釋放狂氣爆發後，獲得等同於攻擊力 <WeaponEffect_Num:[StateArg3]%> 的觸腕傷害。"
  },
  State_3531_WeaponDesc = {
    Text = "戰鬥開始時，裝備者獲得 <WeaponEffect_Num:[StateArg1]> 狂氣。每當其他喚醒體釋放狂氣爆發時，裝備者獲得 <WeaponEffect_Num:[StateArg2]> 狂氣。若當前界域為「深海」，裝備者釋放狂氣爆發後，觸腕傷害 <WeaponEffect_Num:+[DescArg1]>。"
  },
  State_3532_Desc = {
    Text = "回合開始時獲得 [StateArg1] 算力。"
  },
  State_3532_Name = {
    Text = "造物黑燭1"
  },
  State_3533_Desc = {
    Text = "一定在起始手牌中出現。"
  },
  State_3533_WeaponDesc = {
    Text = "戰鬥開始後該卡固定在手牌中。"
  },
  State_3535_Desc = {
    Text = "卡牌算力消耗增加 [Layer] 點。回合結束或打出卡牌後該負面效果會被移除。"
  },
  State_3535_Name = {
    Text = "<SlowColour:臨時遲緩 [Layer]>"
  },
  State_3535_WeaponDesc = {
    Text = "卡牌算力消耗增加 [Layer]點。"
  },
  State_3536_Name = {
    Text = "首領戰可使用 3 次"
  },
  State_3537_Desc = {
    Text = "獲得\"天真的回禮\"時可進行一次刻印"
  },
  State_3537_Name = {
    Text = "狀態@章一_共鳴4"
  },
  State_3537_WeaponDesc = {
    Text = "獲得\"天真的回禮\"時可進行一次刻印"
  },
  State_3538_Desc = {
    Text = "使用“天真的回禮”回復狂氣增加"
  },
  State_3538_Name = {
    Text = "狀態@章一_共鳴1"
  },
  State_3538_WeaponDesc = {
    Text = "使用“天真的回禮”回復狂氣增加"
  },
  State_3539_Desc = {
    Text = "“天真的回禮”算力消耗減1"
  },
  State_3539_Name = {
    Text = "狀態@章一_共鳴3"
  },
  State_3539_WeaponDesc = {
    Text = "“天真的回禮”算力消耗減1"
  },
  State_3540_Desc = {
    Text = "“天真的回禮”可指定目標"
  },
  State_3540_Name = {
    Text = "狀態@章一_共鳴2"
  },
  State_3540_WeaponDesc = {
    Text = "“天真的回禮”可指定目標"
  },
  State_3541_Desc = {
    Text = "庫姆落入了你們佈設的陷阱。"
  },
  State_3542_Desc = {
    Text = "戰鬥開始時，卡組中每擁有 1 個刻印，獲得 [Arg1] 點力量，每擁有 1 個造物，回復 [Arg2] 點生命。"
  },
  State_3542_Name = {
    Text = "☆商會勳章☆"
  },
  State_3545_Name = {
    Text = "無邊星彩抵抗"
  },
  State_3545_WeaponDesc = {
    Text = "每出 1 張牌獲得 [StateArg1]% 死亡抵抗。獲得死亡抵抗時，回復 [StateArg2] 生命。"
  },
  State_3546_Desc = {
    Text = "我方隊伍每打出 1 張卡牌，就對其施加 [Layer] 層【束縛】。"
  },
  State_3546_Name = {
    Text = "「東區特供」"
  },
  State_3546_WeaponDesc = {
    Text = "我方隊伍每打出 1 張卡牌，就對其施加 [Layer] 層【束縛】。"
  },
  State_3547_Desc = {
    Text = "我方隊伍每打出 1 張卡牌，就對其施加 [Layer] 層【束縛】。"
  },
  State_3547_Name = {
    Text = "「東區特供」"
  },
  State_3547_WeaponDesc = {
    Text = "我方隊伍每打出 1 張卡牌，就對其施加 [Layer] 層【束縛】。"
  },
  State_3548_Desc = {
    Text = "抽到時使自身虛弱 1 回合。使用後虛弱所有敵人 1 回合。無法出售。"
  },
  State_3548_Name = {
    Text = "狀態詛咒衰弱"
  },
  State_3548_WeaponDesc = {
    Text = "抽到時使自身虛弱 1 回合。使用後虛弱所有敵人 1 回合。無法出售。"
  },
  State_3549_Name = {
    Text = "狀態飾品荒原狼"
  },
  State_3549_WeaponDesc = {
    Text = "裝備者造成的基礎傷害提高 10%。若裝備者傷害強效大於 20%，基礎傷害額外提高 10%。"
  },
  State_35503_Name = {
    Text = "時靈擺「蔓延」"
  },
  State_3551_Desc = {
    Text = "回合開始時，如果上個回合剩餘的手牌數超過 [StateArg1] 張，獲得 [StateArg2] 點算力。"
  },
  State_3551_Name = {
    Text = "造物銀白差分機"
  },
  State_3551_WeaponDesc = {
    Text = "回合開始時，如果上個回合剩餘的手牌數超過 [StateArg1] 張，獲得 [StateArg2] 點算力。"
  },
  State_35539_Desc = {
    Text = "受到的傷害翻倍，持續 [Layer] 回合。"
  },
  State_3553_Desc = {
    Text = "暴擊率提高 25%。造成生命回復後，有幾率額外造成 1 次生命回復，機率等於造成回復者的暴擊率。"
  },
  State_3553_Name = {
    Text = "狀態@幻夢銀鑰：暴擊治療"
  },
  State_3554_Desc = {
    Text = "護盾和治療的效果提高[Layer] %"
  },
  State_3554_Name = {
    Text = "護盾和治療強效"
  },
  State_3554_WeaponDesc = {
    Text = "護盾和治療的效果提高[Layer] %"
  },
  State_3555_Desc = {
    Text = "拾取時獲得 100% 死亡抵抗。觸發死亡抵抗後，本場戰鬥每回合開始時回復 [Arg1] 點生命。"
  },
  State_3556_Desc = {
    Text = "拾取該造物時選擇一張卡牌，將一張它的複製加入牌庫。"
  },
  State_3558_Desc = {
    Text = "回合開始時若黑印大於 10，消耗 10 黑印，當回合造成的傷害翻倍。"
  },
  State_3559_Desc = {
    Text = "造成未被格擋的傷害時，造成 1 層脆弱。"
  },
  State_3559_WeaponDesc = {
    Text = "造成實際傷害時，將[StateArg1] 張 「傷口」 洗入抽牌堆。"
  },
  State_3561_Name = {
    Text = "狀態@幻夢銀鑰：亂斬計數"
  },
  State_3562_Desc = {
    Text = "死亡後，其他友方力量提高[Layer]。"
  },
  State_3562_Name = {Text = "死語"},
  State_35635_Name = {
    Text = "狀態@喚醒體卡茜亞隔空取物允許發動"
  },
  State_35636_Name = {
    Text = "狀態@喚醒體卡茜亞添加隔空取物"
  },
  State_3563_Desc = {
    Text = "造成未被格擋的傷害時，將[StateArg1] 張 「傷口」 洗入抽牌堆。"
  },
  State_3563_WeaponDesc = {
    Text = "造成實際傷害時，將[StateArg1] 張 「傷口」 洗入抽牌堆。"
  },
  State_35645_Desc = {
    Text = "本回合抽牌數量減少 [Layer] 。"
  },
  State_35646_Desc = {
    Text = "本回合抽牌數量減少 [Layer] 。"
  },
  State_3564_Desc = {
    Text = "打出後獲得 [StateArg1] 點臨時力量，該刻印卡牌也能享受力量加成。"
  },
  State_3564_Name = {
    Text = "<Rune_15_High:高級爆發>"
  },
  State_3565_Desc = {
    Text = "雕砌者施加護盾時，提高 [StateArg1] 觸腕傷害。"
  },
  State_3565_WeaponDesc = {
    Text = "雕砌者施加護盾時，提高 [StateArg1] 觸腕傷害。"
  },
  State_3566_Desc = {
    Text = "回合開始時獲得 3 臨時力量，[狂氣爆發]將這個臨時力量翻倍，最多堆疊 2 次。"
  },
  State_3566_Name = {
    Text = "造物怪蛇殘蛻"
  },
  State_3567_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_3567_Name = {
    Text = "狀態@試作鐳射炮暴擊"
  },
  State_35684_Desc = {
    Text = "我方隊伍釋放狂氣爆發後，自身當回合失去力量。一回合一次。"
  },
  State_35684_Name = {
    Text = "畏懼狂氣"
  },
  State_35685_Desc = {
    Text = "釋放本源降臨時，降低敵人的臨時力量。"
  },
  State_35685_Name = {
    Text = "畏懼狂氣"
  },
  State_3568_Desc = {
    Text = "拉蒙娜造成傷害時，獲得 [StateArg1] 算力。"
  },
  State_3568_Name = {
    Text = "第一哲學"
  },
  State_3568_WeaponDesc = {
    Text = "拉蒙娜造成傷害時，獲得 [StateArg1] 算力。"
  },
  State_3570_Name = {
    Text = "下一回合開始時抽牌數+2"
  },
  State_3571_Name = {
    Text = "臨時免疫虛弱"
  },
  State_3572_Desc = {
    Text = "其召喚的怪物傷害翻倍。"
  },
  State_3572_Name = {Text = "號令者"},
  State_3572_WeaponDesc = {
    Text = "其召喚的怪物傷害翻倍。"
  },
  State_3573_Desc = {
    Text = "每個回合首次受到的傷害翻5倍。"
  },
  State_3573_WeaponDesc = {
    Text = "每個回合首次受到的傷害翻倍。"
  },
  State_3574_Desc = {
    Text = "每當連續打出同一個喚醒體的牌，該喚醒體獲得 10 狂氣。"
  },
  State_35768_Name = {
    Text = "獲得 300 點銀鑰能量"
  },
  State_35769_Name = {
    Text = "獲得 1 點算力"
  },
  State_35770_Name = {
    Text = "驅散自身<IntoxicationIconKeywords:中毒>、封印、<SlowIconKeywords:遲緩>狀態"
  },
  State_35771_Name = {
    Text = "獲得 [DescArg1]%(<Block:[DescArg2]>) 最大生命的護盾"
  },
  State_35772_Name = {
    Text = "首領戰可額外使用 [StateArg1] 次"
  },
  State_35774_Desc = {
    Text = "死亡前呼喚一次希萊斯特的援助，回復所有生命、狂氣、銀鑰能量。"
  },
  State_35774_Name = {
    Text = "烏托邦帷幕"
  },
  State_3577_Name = {
    Text = "狂氣自動回復提升"
  },
  State_35809_Desc = {
    Text = "造成的傷害降低 [StateArg1]%，持續 [Layer] 回合。"
  },
  State_35809_Name = {
    Text = "虛妄繼承者"
  },
  State_35809_WeaponDesc = {
    Text = "狀態@深海淑女紅茶與蛋糕"
  },
  State_3580_Desc = {
    Text = "[Layer] 回合內觸腕造成的傷害為穿刺傷害。"
  },
  State_3580_Name = {
    Text = "穿刺觸腕"
  },
  State_35811_Desc = {
    Text = "受到主動或觸腕傷害時，獲得傷害一半的<SacrificeKeyWord:獻祭>，持續 [Layer] 回合。"
  },
  State_35811_Name = {
    Text = "虛妄繼承者"
  },
  State_35819_Desc = {
    Text = "回合結束時墨菲獲得 5 點狂氣。釋放鑰令後，移除 2% 最大生命的<SacrificeKeyWord:獻祭>。"
  },
  State_35819_Name = {
    Text = "紅茶與蛋糕"
  },
  State_3581_Desc = {
    Text = "狀態@紅夫人權欲輪舞計數"
  },
  State_3581_Name = {
    Text = "狀態@紅夫人權欲輪舞計數"
  },
  State_3582_Desc = {
    Text = "即使不在超維回合，每回合也能夠觸發一次躍遷效果。觸發時抽一張對應喚醒體的牌。"
  },
  State_3582_Name = {
    Text = "異化空間偏折儀"
  },
  State_3582_WeaponDesc = {
    Text = "即使不在超維回合，每回合也能夠觸發一次躍遷效果。觸發時抽一張對應喚醒體的牌。"
  },
  State_3584_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_3584_Name = {
    Text = "狀態@試作小刀界域"
  },
  State_35858_Desc = {
    Text = "回合結束時墨菲獲得 5 點狂氣。釋放鑰令後，獲得墨菲 3% 攻擊力的觸腕傷害。"
  },
  State_35858_Name = {
    Text = "紅茶與蛋糕"
  },
  State_3585_Desc = {
    Text = "生命低於 50%([StateArg1]) 時，「提燈教牧」將會祈求「神降」，吸收所有教眾後狂暴。"
  },
  State_3585_Name = {
    Text = "燈芯的烙印"
  },
  State_3585_WeaponDesc = {
    Text = "生命低於 50%([StateArg1]) 時，「提燈教牧」將會祈求「神降」，吸收所有教眾後狂暴。"
  },
  State_3588_Name = {
    Text = "造物阿爾卡納遺物算力"
  },
  State_3589_Desc = {
    Text = "承受主動或觸腕傷害時，免疫傷害並減少 1 層。"
  },
  State_3591_Desc = {
    Text = "隊伍唯一：裝備者造成的<RetaliateIconKeywords:反擊>提高 <WeaponEffect_Num:[StateArg1]%>。「防禦」獲得等同於裝備者防禦力  <WeaponEffect_Num:[StateArg2]%> 的臨時反擊，在首領戰中，改為獲得 3 倍臨時反擊。死亡抵抗觸發後，對所有敵人觸發 [StateArg3]％ <RetaliateIconKeywords:反擊>。"
  },
  State_3591_Name = {
    Text = "伏於夜色"
  },
  State_3591_WeaponDesc = {
    Text = "裝備者造成的<RetaliateIconKeywords:反擊>提高 <WeaponEffect_Num:[StateArg1]%>。打出「防禦」後獲得 <WeaponEffect_Num:[Counterattack:DescArg1]> 層臨時反擊，在首領戰中，改為獲得 3 倍臨時反擊。死亡抵抗觸發後，對所有敵人觸發 [StateArg3]％ <RetaliateIconKeywords:反擊>。"
  },
  State_3592_Desc = {
    Text = "提高觸腕造成的傷害。"
  },
  State_3592_Name = {
    Text = "<TentacleInjurieIconKeywords:觸腕傷害>"
  },
  State_3592_WeaponDesc = {
    Text = "增加觸腕造成的傷害量。"
  },
  State_3593_Desc = {
    Text = "隊伍唯一：裝備者造成的<IntoxicationIconKeywords:中毒>提高<WeaponEffect_Num:[StateArg1]%>。「打擊」對目標敵人造成等同於攻擊力 <WeaponEffect_Num:[StateArg2]%> 的<IntoxicationIconKeywords:中毒>。該效果每回合最多生效 3 次。"
  },
  State_3593_WeaponDesc = {
    Text = "裝備者造成的<IntoxicationIconKeywords:中毒>提高<WeaponEffect_Num:[StateArg1]%>。「打擊」對目標敵人造成 <WeaponEffect_Num:[Poison:DescArg1]> 層<IntoxicationIconKeywords:中毒>。該效果每回合最多生效 3 次。"
  },
  State_3596_Name = {
    Text = "殘留的銀芯"
  },
  State_35970_Desc = {
    Text = "死亡後，對玩家施加 1 回合的<VulnerabilityIconKeywords:易傷>。"
  },
  State_35971_Desc = {
    Text = "登場時，獲得等同於最大生命 50% 的護盾。"
  },
  State_35971_Name = {Text = "卵殼"},
  State_3597_Name = {
    Text = "殘留的銀芯"
  },
  State_3598_Name = {
    Text = "殘留的銀芯"
  },
  State_3599_Desc = {
    Text = "打出 1 張實際算力消耗為 4 或以上的卡牌時，其他手牌算力消耗降低 1"
  },
  State_36006_Desc = {
    Text = "死亡後會在原地生成「睡夢之子」。"
  },
  State_3600_Name = {
    Text = "殘留的銀芯"
  },
  State_36013_Desc = {
    Text = "此狀態也視為<SacrificeKeyWord:獻祭>，下個回合開始時獲得 [Layer] 層<SacrificeKeyWord:獻祭>狀態。"
  },
  State_36013_Name = {
    Text = "<BlueKeyWord:延遲獻祭>"
  },
  State_36014_Desc = {
    Text = "回合結束時受到 [Layer] 點傷害並減少 50% <SacrificeKeyWord:獻祭>層數。"
  },
  State_36014_Name = {
    Text = "<BlueKeyWord:獻祭>"
  },
  State_3601_Name = {
    Text = "狀態@幻夢銀鑰：輪舞計數"
  },
  State_36022_Desc = {
    Text = "受到來自<SacrificeKeyWord:獻祭>以外的傷害時，獲得傷害 50% 的<SacrificeKeyWord:獻祭>。"
  },
  State_36022_Name = {Text = "拜謁"},
  State_36023_Desc = {
    Text = "死亡後若存在其他友方，生成「水之子」。"
  },
  State_36024_Desc = {
    Text = "死亡後若存在其他友方，生成「睡夢之子」。"
  },
  State_3603_Name = {
    Text = "首領戰中可使用2次且首次使用後回手"
  },
  State_3604_Desc = {
    Text = "隊伍由不同職業的喚醒體組成時，隊伍生命與所有喚醒體的攻擊與防禦提高 200%"
  },
  State_3604_Name = {
    Text = "狀態@混搭加成"
  },
  State_3604_WeaponDesc = {
    Text = "隊伍由不同職業的喚醒體組成時，隊伍生命與所有喚醒體的攻擊與防禦提高 200%"
  },
  State_3607_Desc = {
    Text = "打出後使喚醒體在本場戰鬥中獲得特殊的能力提升。重複打出靈知覺醒無法疊加生效。"
  },
  State_3607_Name = {
    Text = "<ExaltIconKeywords:靈知覺醒>"
  },
  State_3607_WeaponDesc = {
    Text = "靈知覺醒打出後可以讓喚醒體在本場戰鬥中獲得特殊的能力提升。但重複打出的靈知覺醒不可疊加生效。"
  },
  State_3608_Name = {
    Text = "所有友方獲得[StateArg1]點狂氣"
  },
  State_36092_Desc = {
    Text = "死亡後若存在其他友方，則在原地生成「水之子」。"
  },
  State_36093_Desc = {
    Text = "每失去 1 點生命降低 1 層，當層數為 0 時，在怪物回合結束後，將會召喚 1 個「水之子」並重新獲得 [DescArg1] 層「水之寄主」，最多存在 4 個「水之子」。"
  },
  State_36094_Desc = {
    Text = "每失去 1 點生命降低 1 層，當層數為0時，召喚 1 個「靈覺之子」，並重新獲得 [DescArg1] 層「珊瑚寄主」，最多存在 4 個。"
  },
  State_36094_Name = {
    Text = "靈覺寄主"
  },
  State_3609_Name = {
    Text = "首領戰中可使用2次且首次使用後回到手牌，重新抽取的牌本回合算力消耗降低 1"
  },
  State_36111_Desc = {
    Text = "死亡後，將 1 張「珊瑚贅生」加入玩家手中。"
  },
  State_36111_Name = {
    Text = "珊瑚贅生"
  },
  State_3611_Desc = {
    Text = "狀態@序章怪物被動12"
  },
  State_3611_Name = {
    Text = "狀態@序章怪物被動12"
  },
  State_3611_WeaponDesc = {
    Text = "狀態@序章怪物被動12"
  },
  State_36124_Desc = {
    Text = "回合結束後受到 [Layer] 點傷害並減少 50% 「獻祭」層數。"
  },
  State_36124_Name = {
    Text = "<BlueKeyWord:獻祭>"
  },
  State_3612_Desc = {
    Text = "狀態@序章怪物被動13"
  },
  State_3612_Name = {
    Text = "狀態@序章怪物被動13"
  },
  State_3612_WeaponDesc = {
    Text = "狀態@序章怪物被動13"
  },
  State_36136_Name = {
    Text = "在手中時，每打出 1 張其他卡牌，就受到 [StateArg1] 點<FixedDamage:純粹傷害>。"
  },
  State_3613_Desc = {
    Text = "狀態@序章怪物被動10"
  },
  State_3613_Name = {
    Text = "狀態@序章怪物被動10"
  },
  State_3613_WeaponDesc = {
    Text = "狀態@序章怪物被動10"
  },
  State_3614_Desc = {
    Text = "狀態@序章怪物被動11"
  },
  State_3614_Name = {
    Text = "狀態@序章怪物被動11"
  },
  State_3614_WeaponDesc = {
    Text = "狀態@序章怪物被動11"
  },
  State_36152_Desc = {
    Text = "回合結束時受到等量層數的傷害，然後移除 50% <SacrificeKeyWord:獻祭>層數。獻祭會繼承至下場戰鬥。"
  },
  State_36152_Name = {
    Text = "<SacrificeKeyWord:獻祭>"
  },
  State_3615_Desc = {
    Text = "狀態@序章怪物被動16"
  },
  State_3615_Name = {
    Text = "狀態@序章怪物被動16"
  },
  State_3615_WeaponDesc = {
    Text = "狀態@序章怪物被動16"
  },
  State_3616_Desc = {
    Text = "狀態@序章怪物被動14"
  },
  State_3616_Name = {
    Text = "狀態@序章怪物被動14"
  },
  State_3616_WeaponDesc = {
    Text = "狀態@序章怪物被動14"
  },
  State_36173_Name = {
    Text = "首領戰可使用 [DescArg1] 次"
  },
  State_36174_Name = {
    Text = "（還剩 [Layer] 次）"
  },
  State_3617_Desc = {
    Text = "狀態@序章怪物被動15"
  },
  State_3617_Name = {
    Text = "狀態@序章怪物被動15"
  },
  State_3617_WeaponDesc = {
    Text = "狀態@序章怪物被動15"
  },
  State_36182_Name = {
    Text = "獲得 [DescArg1]%(<Block:[DescArg2]>) 最大生命的護盾並回復等量的生命，護盾隨已損生命提高"
  },
  State_3618_Desc = {
    Text = "受到實際傷害時獲得護盾。"
  },
  State_3618_Name = {Text = "緩衝"},
  State_3618_WeaponDesc = {
    Text = "受到實際傷害時獲得護盾。"
  },
  State_36196_Desc = {
    Text = "蘿坦的「打擊」傷害提高 30%。"
  },
  State_36196_Name = {
    Text = "不羈的劍風"
  },
  State_3619_Desc = {
    Text = "狀態@青炎舞者打擊防禦"
  },
  State_3619_Name = {
    Text = "狀態@青炎舞者打擊防禦"
  },
  State_3619_WeaponDesc = {
    Text = "狀態@青炎舞者打擊防禦"
  },
  State_3620_Desc = {
    Text = "每當獲得症狀卡後，使最大生命提高 [Arg1] 點。"
  },
  State_3621_Desc = {
    Text = "原初信徒每打出 1 張牌，抽 [StateArg1] 張牌，觸發所有敵人 5% 的中毒。"
  },
  State_3621_Name = {
    Text = "湮塞的執念"
  },
  State_3621_WeaponDesc = {
    Text = "原初信徒每打出 1 張牌，抽 [StateArg1] 張牌"
  },
  State_3622_Desc = {
    Text = "強化「暴走獵顱者」和「死者」的技能效果，每回合開始時獲得 [StateArg1] 點臨時力量，每層「狩獵印記」再提高 [StateArg1] 點。"
  },
  State_3622_Name = {
    Text = "狩獵印記"
  },
  State_36242_Desc = {
    Text = "戰鬥開始後獲得 [StateArg1] 點護盾。失去生命後，「聖嬰」將會結束酣睡，開始啼哭。"
  },
  State_3624_Desc = {
    Text = "狀態@知者攻勢推演力量降低"
  },
  State_3624_Name = {
    Text = "狀態@知者攻勢推演力量降低"
  },
  State_3625_Desc = {
    Text = "當你擁有護盾時，造成的傷害提高 [Arg1]。在你的護盾高於當前生命時，造成的傷害額外提高 [Arg2]。"
  },
  State_36263_Desc = {
    Text = "不再受到傷害，準備釋放「受誕之種」。"
  },
  State_3628_Name = {
    Text = "狀態@打出後破防"
  },
  State_3629_Name = {
    Text = "抽 2 張牌"
  },
  State_3630_Name = {
    Text = "對所有敵人施加 2 層<VulnerabilityIconKeywords:易傷>"
  },
  State_36315_Desc = {
    Text = "回合結束時獲得 [Layer] 點力量。"
  },
  State_3631_Name = {
    Text = "獲得 2 點算力"
  },
  State_3632_Name = {
    Text = "獲得 <Energy:[DescArg1]> 點狂氣"
  },
  State_36332_Desc = {
    Text = "每回合開始時，選擇獲得 1 層神母權能或者消耗神母權能獲得墨菲的 1 次幫助。"
  },
  State_36332_Name = {
    Text = "神母權能"
  },
  State_36334_Desc = {
    Text = "每回合結束時獲得 1 條觸腕。"
  },
  State_36334_Name = {
    Text = "螺湮呼喚"
  },
  State_3633_Name = {
    Text = "對所有敵人施加 2 層<WeaknessIconKeywords:虛弱>"
  },
  State_36346_Desc = {
    Text = "當生命降低至 0 時，使生命變為 1 點，不再受到傷害，準備釋放「受誕之種」。"
  },
  State_36346_Name = {
    Text = "受誕之種"
  },
  State_3634_Name = {
    Text = "將 2 張<DerivativeCardKeywords_4:「靈感」>加入抽牌堆"
  },
  State_3635_Name = {
    Text = "其他喚醒體獲得 <Energy:[DescArg1]> 點狂氣"
  },
  State_36360_Desc = {
    Text = "回合開始後有 [DescArg1]% 機率獲得 1 層觸腕集結，超過 100% 時可獲得多層。"
  },
  State_36360_Name = {Text = "海歸線"},
  State_36361_Desc = {
    Text = "登場時，其他友方獲得 [Layer] 點力量。"
  },
  State_36361_Name = {
    Text = "神降畸變"
  },
  State_3636_Desc = {
    Text = "狀態@造物蠱惑風鈴生效"
  },
  State_3636_Name = {
    Text = "狀態@造物蠱惑風鈴生效"
  },
  State_3637_Desc = {
    Text = "當你的生命低於 25% 且未死亡時，立刻回復 [Arg1] 點生命。觸發 3 次後永久失效。"
  },
  State_3637_Name = {
    Text = "☆應急食品☆"
  },
  State_3638_Desc = {
    Text = "承受主動或觸腕傷害時，免疫傷害並減少 1 層。"
  },
  State_3638_WeaponDesc = {
    Text = "承受的傷害降低 99%，每承受 1 次傷害減少 1 層。"
  },
  State_3639_Desc = {
    Text = "拉蒙娜造成傷害時，獲得 [StateArg1] 算力。"
  },
  State_3639_Name = {
    Text = "第三哲學"
  },
  State_3639_WeaponDesc = {
    Text = "拉蒙娜造成傷害時，獲得 [StateArg1] 算力。"
  },
  State_3641_Desc = {
    Text = "在“未完的蠟像”處選擇一張卡算力減1"
  },
  State_3641_Name = {
    Text = "狀態@章二_共鳴_基本效果"
  },
  State_3641_WeaponDesc = {
    Text = "在“未完的蠟像”節點複製卡牌的等級+1"
  },
  State_3642_Desc = {
    Text = "每當你失去生命，就獲得 [Arg1] 層反擊。若為單個回合內的第 3 次觸發，對所有敵人造成 1 次反擊傷害。"
  },
  State_3642_Name = {
    Text = "故人的懷錶"
  },
  State_3646_Desc = {
    Text = "生命值無法降低值1以下，受到致命傷害時，將意圖替換為絕境求生。【絕境求生】：恢復最大生命100%，力量翻倍，強化後續技能。"
  },
  State_3646_Name = {
    Text = "絕境求生"
  },
  State_3647_Name = {
    Text = "造物阿爾卡納記錄計數"
  },
  State_3648_Desc = {
    Text = "隊伍唯一：裝備者生命回復效果提高 <WeaponEffect_Num:[StateArg2]%> 。回合開始時，獲得等同於上回合損失生命 <WeaponEffect_Num:[StateArg1]%> 的臨時<PowerIconKeywords:力量>和護盾。"
  },
  State_3648_WeaponDesc = {
    Text = "裝備者生命回復效果提高 <WeaponEffect_Num:[StateArg2]%> 。回合開始時，獲得等同於上回合損失生命 <WeaponEffect_Num:[StateArg1]%> 的臨時<PowerIconKeywords:力量>和護盾。"
  },
  State_3649_Desc = {
    Text = "隊伍中每有一名【超維】職業喚醒體，全隊最大生命(未完成)、防禦、攻擊提高 50%"
  },
  State_3649_Name = {
    Text = "超維加成"
  },
  State_3649_WeaponDesc = {
    Text = "隊伍中每有一名【超維】職業喚醒體，全隊最大生命(未完成)、防禦、攻擊提高 50%"
  },
  State_3651_Desc = {
    Text = "打出前改變卡牌算力"
  },
  State_3651_Name = {
    Text = "打出前改變卡牌算力"
  },
  State_3651_WeaponDesc = {
    Text = "打出前改變卡牌算力"
  },
  State_3652_Desc = {
    Text = "回合開始時，如果上個回合打出卡牌數超過 [StateArg1] 張，抽 [StateArg2] 張牌。"
  },
  State_3652_Name = {
    Text = "造物魔術手套"
  },
  State_3652_WeaponDesc = {
    Text = "回合開始時，如果上個回合打出卡牌數超過 [StateArg1] 張，抽 [StateArg2] 張牌。"
  },
  State_3653_Name = {
    Text = "造物殘破戰旗2"
  },
  State_3654_Desc = {
    Text = "回合開始後獲得 [Layer]% 臨時暴擊率。"
  },
  State_3654_Name = {
    Text = "綿音漸響"
  },
  State_3654_WeaponDesc = {
    Text = "直到下回合開始前未損失生命，下回合暴擊率 +[StateArg1]%。"
  },
  State_3656_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_3656_Name = {
    Text = "尚未覺醒"
  },
  State_3658_Desc = {
    Text = "打出手牌中最後 1 張牌時，抽 2 張牌。每回合最多觸發 2 次。"
  },
  State_3659_Name = {
    Text = "狀態@打擊卡暴擊率暴擊傷害提高"
  },
  State_36613_Name = {
    Text = "狀態@飾品機械降神計數"
  },
  State_3661_Desc = {
    Text = "受到實際傷害提升深度融蝕層數"
  },
  State_3661_Name = {
    Text = "受到傷害提升深度融蝕層數"
  },
  State_3661_WeaponDesc = {
    Text = "受到實際傷害提升深度融蝕層數"
  },
  State_3662_Desc = {
    Text = "本場戰鬥內暴擊傷害提高 [Layer] %。"
  },
  State_3662_Name = {
    Text = "暴擊傷害"
  },
  State_3662_WeaponDesc = {
    Text = "本場戰鬥內暴擊傷害提高 [Layer] %。"
  },
  State_36631_Desc = {
    Text = "每次釋放狂氣爆發增加 1 層「孕育」，每層孕育獲得 [StateArg1] 點力量，上限為 5 層。"
  },
  State_36635_Desc = {
    Text = "每次釋放狂氣爆發增加 1 層「孕育」，每層孕育獲得 [StateArg1] 點力量，上限為 5 層。"
  },
  State_36635_Name = {
    Text = "利莫里亞的最終降神"
  },
  State_36636_Desc = {
    Text = "當達到 5 層時，將會釋放「利莫里亞的榮光！」，造成高額傷害並呼喚眷族。"
  },
  State_36637_Desc = {
    Text = "當達到 5 層時，將會釋放「為了利莫里亞！」，造成高額傷害並呼喚眷族。"
  },
  State_3663_Desc = {
    Text = "每回合第一次打出卡牌後，將對應喚醒體的一張「打擊」置入手中。"
  },
  State_3664_Desc = {
    Text = "打出後獲得5點狂氣。"
  },
  State_3664_WeaponDesc = {
    Text = "打出後獲得5點狂氣。"
  },
  State_3665_Desc = {
    Text = "當胚胎融合達到上限後，將一張「胚胎」置入手中。"
  },
  State_3666_Desc = {
    Text = "暴擊率提高 [Layer] %。"
  },
  State_3666_Name = {Text = "暴擊率"},
  State_3666_WeaponDesc = {
    Text = "暴擊率提高 [Layer] %。"
  },
  State_36670_Name = {
    Text = "狀態@飾品再衍化計數"
  },
  State_36670_WeaponDesc = {
    Text = "裝備者回合結束後獲得 3 點狂氣。若裝備者狂氣回充大於 10 ，額外獲得 2 點狂氣。"
  },
  State_3667_Desc = {
    Text = "隊伍唯一：裝備者造成的<RetaliateIconKeywords:反擊>提高 <WeaponEffect_Num:[StateArg4]%> 。裝備者打出卡牌後獲得等同於裝備者防禦力 <WeaponEffect_Num:[StateArg1]%> 的<RetaliateIconKeywords:反擊>，每回合最多 2 次，若其進入超維空間，裝備者還會獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣。釋放狂氣爆發後，所有敵人失去等同於裝備者防禦力 <WeaponEffect_Num:[StateArg3]%> 的臨時力量。"
  },
  State_3667_WeaponDesc = {
    Text = "裝備者造成的<RetaliateIconKeywords:反擊>提高 <WeaponEffect_Num:[StateArg4]%>。裝備者打出卡牌後獲得 <WeaponEffect_Num:[Counterattack:DescArg1]> 點<RetaliateIconKeywords:反擊>，每回合最多觸發 2 次，若其進入超維空間，裝備者還會獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣。釋放狂氣爆發後，所有敵人臨時降低 <WeaponEffect_Num:[Power:DescArg2]> 點力量。"
  },
  State_3668_Desc = {
    Text = "狀態@異化花園守護者標識"
  },
  State_3668_Name = {
    Text = "狀態@異化花園守護者標識"
  },
  State_3668_WeaponDesc = {
    Text = "狀態@異化花園守護者標識"
  },
  State_3669_Desc = {
    Text = "免疫虛弱、脆弱和易傷狀態、持續[Layer]回合。"
  },
  State_3669_WeaponDesc = {
    Text = "[Layer] 回合內免疫被施加的負面狀態。"
  },
  State_3673_Desc = {
    Text = "拾取時選擇 2 張卡牌刪除，獲得 [StateArg1] 力量。"
  },
  State_3673_Name = {
    Text = "造物黑星燃燒之燼"
  },
  State_3674_Desc = {
    Text = "回合結束時，降低所有喚醒體 10 狂氣。"
  },
  State_3674_Name = {Text = "寂滅"},
  State_3674_WeaponDesc = {
    Text = "回合結束時，降低所有喚醒體 10 狂氣。"
  },
  State_3675_Name = {
    Text = "抽取棄牌數+ 1 張牌"
  },
  State_3676_Desc = {
    Text = "在對手回合時，受到傷害降低 [Layer] %。"
  },
  State_3676_Name = {Text = "機警"},
  State_3676_WeaponDesc = {
    Text = "我方隊伍回合時怪物獲得 [Layer] %減傷"
  },
  State_3677_Desc = {
    Text = "提高[Layer]%防禦力。"
  },
  State_3677_Name = {
    Text = "臨時防禦力百分比提高"
  },
  State_3677_WeaponDesc = {
    Text = "提高[Layer]%防禦力。"
  },
  State_36781_Desc = {
    Text = "力量被降低時，僅會降低 50% 的力量層數。"
  },
  State_3678_Name = {
    Text = "狀態@事件造物1"
  },
  State_36797_Desc = {
    Text = "本回合內，觸腕傷害降低 [Layer] 點。"
  },
  State_36797_Name = {
    Text = "觸腕傷害降低"
  },
  State_3679_Name = {
    Text = "狀態@事件造物2"
  },
  State_3680_Desc = {
    Text = "每造成 1 次傷害，對目標施加 [Arg1] 層中毒。若本場戰鬥內觸發次數累計達 25 次，立刻觸發全體敵方中毒。"
  },
  State_3681_Desc = {
    Text = "造成未被格擋的傷害時，對隨機 2 張「指令卡」上施加 [DescArg1] 層<BrokenCard:暗中破壞>。"
  },
  State_3681_Name = {
    Text = "詹金覺醒！"
  },
  State_3681_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_3682_Desc = {
    Text = "生命每下降 10%，所有喚醒體獲得 10 狂氣，死亡後加觸腕傷害。"
  },
  State_3682_Name = {
    Text = "深埋的銀芯"
  },
  State_3682_WeaponDesc = {
    Text = "生命每下降 10%，所有喚醒體獲得 10 狂氣，死亡後加觸腕傷害。"
  },
  State_3683_Desc = {
    Text = "隊伍唯一：裝備者指令卡造成的治療提高 <WeaponEffect_Num:[StateArg2]%>。裝備者釋放「狂氣爆發」前，其他喚醒體獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣。若我方隊伍處於<VulnerabilityIconKeywords:易傷>狀態，效果翻倍。"
  },
  State_3683_WeaponDesc = {
    Text = "裝備者指令卡造成的治療提高 <WeaponEffect_Num:[StateArg2]%>。裝備者釋放狂氣爆發前，其他喚醒體獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣。若我方隊伍處於<VulnerabilityIconKeywords:易傷>狀態，效果翻倍。"
  },
  State_3684_Desc = {
    Text = "每受到 1 點傷害降低 1 層。層數為 0 後，將意圖替換為不滅之花，並使用偏向防禦的技能組。"
  },
  State_3684_Name = {
    Text = "不滅之花"
  },
  State_3684_WeaponDesc = {
    Text = "每受到 1 點傷害後降低 1 層。層數為 0 後，切換為防禦模式。"
  },
  State_3685_Desc = {
    Text = "抽到時失去 1 算力，抽 1 張牌。"
  },
  State_3685_WeaponDesc = {
    Text = "抽到時失去 1 算力，抽 1 張牌。"
  },
  State_3686_Desc = {
    Text = "抽到時失去 1 算力，抽 1 張牌。"
  },
  State_3686_Name = {
    Text = "維度封印"
  },
  State_3686_WeaponDesc = {
    Text = "抽到時失去 1 算力，抽 1 張牌。"
  },
  State_36884_Desc = {
    Text = "本場戰鬥最後的誓言不再可以通過主動觸發死亡抵抗獲得護盾。"
  },
  State_36884_Name = {
    Text = "最後的誓言"
  },
  State_3688_Desc = {
    Text = "連續 2 次打出比上一張算力消耗更高的卡牌時，獲得 2 算力。"
  },
  State_3688_Name = {
    Text = "造物阿爾卡納記錄"
  },
  State_3688_WeaponDesc = {
    Text = "連續 2 次打出比上一張算力消耗更高的卡牌時，獲得 2 算力。"
  },
  State_3689_Desc = {
    Text = "回合開始時界域精通提高 30。當不處於負面狀態時，界域精通提高變為 100。"
  },
  State_3692_Desc = {
    Text = "擁有千種姿態的神秘卡牌。從中選擇你最需要的吧！"
  },
  State_3692_WeaponDesc = {
    Text = "擁有千種姿態的神秘卡牌。從中選擇你最需要的吧！"
  },
  State_3693_Desc = {
    Text = "暴擊率提高 25%。造成生命回復後，有幾率額外造成 1 次生命回復，機率等於造成回復者的暴擊率。"
  },
  State_3693_Name = {
    Text = "狀態@幻夢銀鑰：暴擊治療"
  },
  State_3696_Desc = {
    Text = "每造成 1 次傷害，本回合內獲得 [Arg1] 點戒備。回合開始時每有 3 點剩餘護盾，本回合內獲得 1 點力量。"
  },
  State_3696_Name = {
    Text = "時靈擺「隱秘」"
  },
  State_3697_Desc = {
    Text = "回合開始時抽 1 張牌。連續 2 次打出和上一張卡牌算力相同的牌時，額外抽 1 張牌。"
  },
  State_3698_Desc = {
    Text = "打出後將卡牌的 [StateArg1] 張複製加入臨時<DimensionalSpaceIconKeywords:超維空間>。"
  },
  State_3698_Name = {
    Text = "<Rune_13:折躍>"
  },
  State_3699_Name = {
    Text = "殘留的銀芯"
  },
  State_3700_Desc = {
    Text = "提高[Layer]%攻擊力。"
  },
  State_3700_Name = {
    Text = "臨時攻擊力百分比提高"
  },
  State_3700_WeaponDesc = {
    Text = "提高[Layer]%攻擊力。"
  },
  State_3702_Desc = {
    Text = "狀態@通用改變最大生命"
  },
  State_3702_Name = {
    Text = "狀態@通用改變最大生命"
  },
  State_3702_WeaponDesc = {
    Text = "狀態@通用改變最大生命"
  },
  State_3703_Name = {
    Text = "狀態@第四章共鳴@生效下回合抽牌數2"
  },
  State_3704_Desc = {
    Text = "界域精通提高 30。拾取時選擇一個造物，將其更換為隨機造物。"
  },
  State_3705_Name = {
    Text = "海月啟靈3"
  },
  State_3707_Desc = {
    Text = "戰鬥開始後將 [StateArg1] 張臨時複製洗入抽牌堆，原始卡牌和鏡像卡牌均獲得保留。"
  },
  State_3707_Name = {
    Text = "<Rune_8:鏡像>"
  },
  State_3708_Desc = {
    Text = "偶數回合結束時，每張剩餘手牌使你下回合開始獲得 1 算力。"
  },
  State_3708_Name = {
    Text = "造物先賢斷章2"
  },
  State_3708_WeaponDesc = {
    Text = "偶數回合結束時，每張剩餘手牌使你下回合開始獲得 1 算力。"
  },
  State_3709_Desc = {
    Text = "奇數回合結束時，每點剩餘算力使你下回合開始抽 1 張牌。"
  },
  State_3709_Name = {
    Text = "造物先賢斷章1"
  },
  State_3709_WeaponDesc = {
    Text = "奇數回合結束時，每點剩餘算力使你下回合開始抽 1 張牌。"
  },
  State_3711_Desc = {
    Text = "每次行動造成 [Layer] 出血"
  },
  State_3711_Name = {Text = "血濺"},
  State_3711_WeaponDesc = {
    Text = "每次行動造成 [Layer] 出血，治療可減半出血層數。"
  },
  State_3712_Desc = {
    Text = "打出卡牌後將其消耗，指令卡產生 3 倍傷害和防護，持續 1 回合。"
  },
  State_3714_Desc = {
    Text = "打出後獲得 [StateArg1] 點護盾。"
  },
  State_3714_Name = {
    Text = "<Rune_6:鐵壁>"
  },
  State_3716_Desc = {
    Text = "本場戰鬥內暴擊率提高 [Layer] %。"
  },
  State_3716_Name = {Text = "暴擊率"},
  State_3719_Desc = {
    Text = "承受主動傷害時，使觸腕反擊傷害來源，持續 [Layer] 回合。"
  },
  State_3719_Name = {
    Text = "承自異端之血"
  },
  State_3720_Desc = {
    Text = "提高[Layer]點防禦力。"
  },
  State_3720_Name = {
    Text = "通用防禦力提高"
  },
  State_3720_WeaponDesc = {
    Text = "提高[Layer]點防禦力。"
  },
  State_3721_Desc = {
    Text = "打出後不會進入棄牌堆，而是從牌庫中移除。"
  },
  State_3721_WeaponDesc = {
    Text = "打出後卡牌不會進入棄牌堆，在本場戰鬥中無法再次使用。"
  },
  State_3722_Desc = {
    Text = "每次造成傷害時，臨時提高 [StateArg1] 觸腕傷害，最多堆疊 5 次。層數滿時生成 1 條觸腕。"
  },
  State_3722_Name = {
    Text = "造物祭司權杖"
  },
  State_3722_WeaponDesc = {
    Text = "每次造成傷害時，臨時提高 [StateArg1] 觸腕傷害，最多堆疊 5 次。層數滿時生成 1 條觸腕。"
  },
  State_3723_Name = {
    Text = "造物黑色鏡面"
  },
  State_3724_Desc = {
    Text = "拾取時失去所有其他造物，隨機獲得 2 個黃金造物。"
  },
  State_3726_Name = {
    Text = "扭曲的死體狂宴"
  },
  State_3728_Desc = {
    Text = "戰鬥開始時，獲得一張[打擊]。"
  },
  State_3728_Name = {
    Text = "鯨躍啟靈1"
  },
  State_3728_WeaponDesc = {
    Text = "戰鬥開始時，獲得一張[打擊]。"
  },
  State_3730_Desc = {
    Text = "狀態@怪物甜蜜惡鬼蜜糖色悲慘幻象"
  },
  State_3730_Name = {
    Text = "狀態@怪物甜蜜惡鬼蜜糖色悲慘幻象"
  },
  State_3730_WeaponDesc = {
    Text = "狀態@怪物甜蜜惡鬼蜜糖色悲慘幻象"
  },
  State_3731_Desc = {
    Text = "每當我方隊伍在商店購物後，下一場戰鬥每回合額外抽 1 張牌，獲得 1 點算力。"
  },
  State_3732_Desc = {
    Text = "每 3 個回合，獲得 3 條臨時觸腕，該觸腕無視觸腕上限。"
  },
  State_3732_Name = {
    Text = "造物無名附肢"
  },
  State_3732_WeaponDesc = {
    Text = "每 3 個回合，獲得 3 條臨時觸腕，該觸腕無視觸腕上限。"
  },
  State_3733_Desc = {
    Text = "奇數回合結束時，剩餘算力轉換為下回合額外抽牌；偶數回合結束時，剩餘手牌轉換為下回合額外算力。"
  },
  State_3735_Name = {
    Text = "我方隊伍\"中毒\"層數減半。"
  },
  State_3738_Desc = {
    Text = "回合結束時胚胎融合 +15%，若手牌中有「胚胎」，回復 [Arg1] 生命。"
  },
  State_3738_Name = {
    Text = "瘟疫診斷書"
  },
  State_3739_Name = {
    Text = "飾品有機形態效果"
  },
  State_3739_WeaponDesc = {
    Text = "裝備者使用狂氣爆發後，本回合內自身護盾和治療強效翻倍。"
  },
  State_3740_Name = {
    Text = "狀態@甜蜜惡鬼暴擊記數"
  },
  State_3741_Desc = {
    Text = "第 3 回合開始時，將 1 張「過往回聲—棄掉所有手牌，當前生命和護盾回到上回合結束時的狀態。保留，消耗。」加入手中。"
  },
  State_3742_Desc = {
    Text = "打出後易傷所有敵人 [StateArg1] 回合。"
  },
  State_3742_Name = {
    Text = "<Rune_1:易傷>"
  },
  State_3743_Desc = {
    Text = "你每打出的第 6 張牌會生效 2 次。"
  },
  State_3744_Name = {
    Text = "造物孟菲斯儀式鏡計數"
  },
  State_3747_Name = {
    Text = "選擇 1 張抽牌堆的卡牌置入手牌"
  },
  State_3748_Name = {
    Text = "造成的傷害暴擊率提高 [DescArg1]%，暴擊傷害提高 [DescArg2]%"
  },
  State_3750_Name = {
    Text = "臨時暴擊率 +[DescArg1]%。在本場戰鬥中「斷頸一擊」和「千面幻象」的基礎傷害提高 5%"
  },
  State_3751_Name = {
    Text = "獲得 [StateArg1] 點<PowerIconKeywords:力量>"
  },
  State_3752_Name = {
    Text = "獲得  <Posse:[DescArg1]>  點銀鑰能量。獲得 <Block:[Block:StateArg1]> 點護盾"
  },
  State_3753_Desc = {
    Text = "卡牌不會在棄牌階段進入棄牌堆，而是保留在手牌中。"
  },
  State_3753_WeaponDesc = {
    Text = "卡牌不會在棄牌階段進入棄牌堆，而是保留在手牌中。"
  },
  State_3754_Desc = {
    Text = "造成主動傷害時，本回合內提高 [Arg1] 觸腕傷害，最多堆疊 3 次。層數滿時生成 1 條觸腕，回合結束後移除。"
  },
  State_3755_Desc = {
    Text = "隊伍唯一：裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>，生命回復提高 <WeaponEffect_Num:[StateArg1]%>。奇數回合結束時裝備者暴擊率 + <WeaponEffect_Num:[StateArg2]%>，獲得  <WeaponEffect_Num:[StateArg3]> 點狂氣；偶數回合結束時裝備者暴擊傷害  +<WeaponEffect_Num:[StateArg2]%>，獲得  <WeaponEffect_Num:[StateArg4]> 銀鑰能量。若當前界域為「血肉」使猩紅熔爐積攢上限提高  <WeaponEffect_Num:[StateArg5]%>。"
  },
  State_3755_WeaponDesc = {
    Text = "裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>，生命回復提高 <WeaponEffect_Num:[StateArg1]%>。奇數回合結束時裝備者暴擊率 +<WeaponEffect_Num:[StateArg2]%>，獲得  <WeaponEffect_Num:[StateArg3]> 點狂氣；偶數回合結束時裝備者暴擊傷害  +<WeaponEffect_Num:[StateArg2]%>，獲得  <WeaponEffect_Num:[StateArg4]> 銀鑰能量。若當前界域為「血肉」使猩紅熔爐積攢上限提高  <WeaponEffect_Num:[StateArg5]%>。"
  },
  State_3757_Desc = {
    Text = "我方隊伍每打出 1 張牌，獲得 [StateArg1] 層護盾。持續 1 回合。"
  },
  State_3757_Name = {
    Text = "飛羽漫天"
  },
  State_3757_WeaponDesc = {
    Text = "我方隊伍每打出 1 張牌，獲得 [StateArg1] 層護盾。持續 1 回合。"
  },
  State_3759_Name = {
    Text = "機械武裝1"
  },
  State_3760_Desc = {
    Text = "如果至少擁有 [StateArg1] 黑印，[狂氣爆發]失去 [StateArg1] 黑印，易傷並虛弱所有敵人 1 回合。"
  },
  State_3760_Name = {
    Text = "造物厄運儀式鳥"
  },
  State_3760_WeaponDesc = {
    Text = "如果至少擁有 [StateArg1] 黑印，[狂氣爆發]失去 [StateArg1] 黑印，易傷並虛弱所有敵人 1 回合。"
  },
  State_3761_Desc = {
    Text = "每當我方隊伍抽到 1 張蹣跚，獲得 [Layer] 點力量。"
  },
  State_3761_Name = {
    Text = "提燈儀式"
  },
  State_3761_WeaponDesc = {
    Text = "每當我方隊伍抽到 1 張蹣跚，獲得 [Layer] 點力量。"
  },
  State_3763_Desc = {
    Text = "竄行者每造成 1 次傷害，本回合暴擊傷害提高 [StateArg3]%。"
  },
  State_3763_Name = {
    Text = "通道折疊"
  },
  State_3763_WeaponDesc = {
    Text = "竄行者每造成 1 次傷害，本回合暴擊傷害提高 [StateArg3]%。"
  },
  State_3764_Name = {
    Text = "機械武裝2"
  },
  State_3766_Name = {
    Text = "添加猩紅力量倍數"
  },
  State_3767_Desc = {
    Text = "回合開始時對隨機一名敵人造成 [Arg1] 點傷害。在本場戰鬥內打出 7 次「打擊」後，造成傷害變為 [Arg2]。"
  },
  State_3767_Name = {
    Text = "老舊拼圖"
  },
  State_3768_Desc = {
    Text = "受到的主動傷害必定暴擊，回合結束後移除。"
  },
  State_3768_Name = {Text = "破綻"},
  State_3768_WeaponDesc = {
    Text = "受到的主動傷害必定暴擊，回合結束後移除。"
  },
  State_3770_Name = {
    Text = "造物阿爾卡納遺物計數"
  },
  State_3771_Desc = {
    Text = "戰鬥開始時，獲得 3 點算力。"
  },
  State_3772_Desc = {
    Text = "復仇巨刃每造成 1 次傷害，提高等同於當前觸腕傷害的臨時力量。"
  },
  State_3772_Name = {
    Text = "復仇預行"
  },
  State_3773_Desc = {
    Text = "回合結束時受到等量層數的<FixedDamage:純粹傷害>。"
  },
  State_3773_WeaponDesc = {
    Text = "回合開始時受到傷害。"
  },
  State_3774_Desc = {
    Text = "每次釋放狂氣爆發，獲得一張能夠施加 [Arg1] 點中毒的「毒性侵染」。回合結束時若手中每 3 張「毒性侵染」可以合成一張觸發中毒的 「毒性發作」。"
  },
  State_3776_Desc = {
    Text = "每次受到主動傷害，增加一層「警覺」。「警覺」達到 3 層時進行後退。"
  },
  State_3776_Name = {
    Text = "膽怯娃娃"
  },
  State_3776_WeaponDesc = {
    Text = "每次受到主動傷害，增加一層「警覺」。「警覺」達到 3 層時進行後退。"
  },
  State_3777_Desc = {
    Text = "打出後所屬喚醒體獲得 [StateArg1] 點狂氣。"
  },
  State_3777_Name = {
    Text = "<Rune_5_High:高級狂化>"
  },
  State_3777_WeaponDesc = {
    Text = "打出後所屬喚醒體獲得 [StateArg1] 點狂氣。"
  },
  State_3778_Desc = {
    Text = "對處於負面狀態的敵人造成的傷害提高 25%，擊殺敵人後擊殺者獲得 20 狂氣。"
  },
  State_3779_Desc = {
    Text = "觸腕上限減少 2 條。回合結束時額外使所有觸腕攻擊 1 次。"
  },
  State_3779_Name = {
    Text = "造物苦痛聖腕"
  },
  State_3779_WeaponDesc = {
    Text = "觸腕上限減少 2條。回合結束時額外使所有觸腕攻擊 1 次。"
  },
  State_3781_Desc = {
    Text = "回合開始時，對牌堆頂 2 張卡牌施加「凝滯詛咒」。"
  },
  State_3781_Name = {
    Text = "「深淵咒眼」"
  },
  State_3781_WeaponDesc = {
    Text = "回合開始時，對牌堆頂 2 張卡牌施加「凝滯詛咒」。"
  },
  State_3782_Desc = {
    Text = "隊伍唯一：探索開始時，將一張裝備者的「防禦」加入牌庫，裝備者「防禦」護盾提高  <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_3782_WeaponDesc = {
    Text = "探索開始時，將一張裝備者的「防禦」加入牌庫，裝備者「防禦」護盾提高  <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_3783_Desc = {
    Text = "隊伍唯一：裝備者狂氣爆發基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，護盾和生命回復提高 <WeaponEffect_Num:[StateArg2]%>。"
  },
  State_3783_WeaponDesc = {
    Text = "裝備者狂氣爆發基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，護盾和生命回復提高 <WeaponEffect_Num:[StateArg2]%>。"
  },
  State_3784_Desc = {
    Text = "隊伍唯一：裝備者指令卡基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，護盾和生命回復提高 <WeaponEffect_Num:[StateArg2]%>。"
  },
  State_3784_WeaponDesc = {
    Text = "裝備者指令卡基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，護盾和生命回復提高 <WeaponEffect_Num:[StateArg2]%>。"
  },
  State_3786_Desc = {
    Text = "你被鎖定了！打出後所有怪物獲得 [StateArg1] 點臨時力量，移除該指令的深潛印記。"
  },
  State_3786_Name = {
    Text = "<CardKeyWord:深潛印記>"
  },
  State_3786_WeaponDesc = {
    Text = "卡牌打出後深潛者獲得 [StateArg1] 點臨時力量。"
  },
  State_3787_Desc = {
    Text = "隊伍唯一：裝備者釋放狂氣爆發後，所有友方獲得 <WeaponEffect_Num:[StateArg1]> 狂氣。"
  },
  State_3787_WeaponDesc = {
    Text = "裝備者釋放狂氣爆發後，所有友方獲得 <WeaponEffect_Num:[StateArg1]> 狂氣。"
  },
  State_3788_Desc = {
    Text = "隊伍唯一：探索開始時，將一張裝備者的「打擊」加入牌庫，裝備者「打擊」基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_3788_WeaponDesc = {
    Text = "探索開始時，將一張裝備者的「打擊」加入牌庫，裝備者「打擊」基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_3790_Desc = {
    Text = "狀態@不定性物質計數"
  },
  State_3790_Name = {
    Text = "狀態@不定性物質計數"
  },
  State_3790_WeaponDesc = {
    Text = "狀態@不定性物質計數"
  },
  State_3791_Desc = {
    Text = "每當造成傷害時獲得 [Arg1] 點護盾，每回合最多堆疊 5 次，層數滿時將一張 「靈感」 置入手中。"
  },
  State_3792_Desc = {
    Text = "不再受到石化影響。"
  },
  State_3792_WeaponDesc = {
    Text = "不再受到石化作用，改為受到三倍傷害"
  },
  State_3793_Desc = {
    Text = "本次關卡內暴擊傷害提高 [Layer] %。"
  },
  State_3793_Name = {
    Text = "永久暴擊傷害"
  },
  State_3793_WeaponDesc = {
    Text = "本次關卡內暴擊傷害提高 [Layer] %。"
  },
  State_3794_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_3794_Name = {
    Text = "狀態@試作長劍爆傷"
  },
  State_3796_Desc = {
    Text = "生命每下降 20%，所有喚醒體獲得 10 狂氣，死亡後加觸腕傷害"
  },
  State_3796_Name = {
    Text = "析出的銀粒"
  },
  State_3796_WeaponDesc = {
    Text = "生命每下降 20%，所有喚醒體獲得 10 狂氣，死亡後加觸腕傷害"
  },
  State_3797_Desc = {
    Text = "每次受到傷害時獲得 [StateArg1] 點臨時力量，回合開始時移除。"
  },
  State_3797_Name = {
    Text = "鼠群的憤怒！"
  },
  State_37980_Desc = {
    Text = "本場戰鬥內界域精通提高 [Layer] 。"
  },
  State_3798_Desc = {
    Text = "造成實際傷害後將會恢復生命。"
  },
  State_3798_WeaponDesc = {
    Text = "造成實際傷害後將會恢復生命。"
  },
  State_3799_Desc = {
    Text = "隊伍中每有一名【血肉】職業喚醒體，全隊最大生命(未完成)、防禦、攻擊提高 50%"
  },
  State_3799_WeaponDesc = {
    Text = "隊伍中每有一名【血肉】職業喚醒體，全隊最大生命(未完成)、防禦、攻擊提高 50%"
  },
  State_3800_Desc = {
    Text = "對所有敵人造成傷害。<CardKeyWord:力量>在此傷害上發揮多倍效果。"
  },
  State_3801_Desc = {
    Text = "造成未被格擋的傷害時，附加 [StateArg1] 層出血。"
  },
  State_3802_Desc = {
    Text = "在手牌中時，每使用 1 張指令卡就變為其算力為 0 的複製。"
  },
  State_3802_Name = {
    Text = "<CardKeyWord:聖潔之子>"
  },
  State_3802_WeaponDesc = {
    Text = "在手牌中時，每使用 1 張牌就變為其算力為 0 的複製。"
  },
  State_3803_Desc = {
    Text = "戰鬥開始時，使你所有當前算力消耗為 1 的卡牌在本場戰鬥內傷害、護盾和治療提高 [Arg1] 點。"
  },
  State_3804_Desc = {
    Text = "異化漁叉計數"
  },
  State_3804_Name = {
    Text = "異化漁叉計數"
  },
  State_3804_WeaponDesc = {
    Text = "異化漁叉計數"
  },
  State_3807_Name = {
    Text = "飾品入藥之夢"
  },
  State_3807_WeaponDesc = {
    Text = "戰鬥開始後，額外將裝備者一套卡牌洗入抽牌堆中。"
  },
  State_3808_Desc = {
    Text = "狀態@通用改變當前生命"
  },
  State_3808_Name = {
    Text = "狀態@通用改變當前生命"
  },
  State_3808_WeaponDesc = {
    Text = "狀態@通用改變當前生命"
  },
  State_3810_Desc = {
    Text = "死亡後，其他友方力量提高。"
  },
  State_3810_Name = {Text = "死語"},
  State_3811_Desc = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3811_Name = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3811_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_4_1"
  },
  State_3813_Name = {
    Text = "免疫虛弱"
  },
  State_3815_Desc = {
    Text = "回合結束時所有喚醒體失去 [Layer] 點狂氣。"
  },
  State_3815_Name = {
    Text = "<EnergyColour:空虛>"
  },
  State_3815_WeaponDesc = {
    Text = "獲取狂氣降低 [Layer]%。"
  },
  State_3817_Desc = {
    Text = "回合開始時，對對手造成 [DescArg1] 點衰竭。"
  },
  State_3817_WeaponDesc = {
    Text = "回合開始時，我方隊伍獲得 [DescArg1*Layer*0.01] 層衰竭"
  },
  State_3818_Name = {
    Text = "狀態@知者啟靈1"
  },
  State_3819_Name = {
    Text = "破鏈者啟靈1"
  },
  State_3819_WeaponDesc = {
    Text = "遠古者模仿"
  },
  State_3821_Desc = {
    Text = "回合開始時，獲得上回合損失生命一半的護盾。"
  },
  State_3821_Name = {
    Text = "苦痛與歡愉"
  },
  State_3821_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_3824_Desc = {
    Text = "隊伍唯一：裝備者的狂氣爆發基礎傷害提高 [StateArg1]%。探索開始時，裝備者進入學者人格狀態。裝備者釋放狂氣爆發後在學者人格和小丑人格之間切換。\n學者人格：回合結束時，裝備者獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣。\n小丑人格：回合結束時，裝備者暴擊率和暴擊傷害 <WeaponEffect_Num:+[StateArg3]%>。"
  },
  State_3824_WeaponDesc = {
    Text = "裝備者的狂氣爆發基礎傷害提高 [StateArg1]%。探索開始時，裝備者進入學者人格狀態。裝備者釋放狂氣爆發後在學者人格和小丑人格之間切換。\n學者人格：回合結束時，裝備者獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣。\n小丑人格：回合結束時，裝備者暴擊率和暴擊傷害 <WeaponEffect_Num:+[StateArg3]%>。"
  },
  State_3825_Desc = {
    Text = "承受主動傷害時，對傷害來源造成等量層數的<FixedDamage:純粹傷害>。"
  },
  State_3825_Name = {
    Text = "<RetaliateIconKeywords: 反擊>"
  },
  State_3825_WeaponDesc = {
    Text = "每次承受主動傷害時，對攻擊者造成<FixedDamage:純粹傷害>。"
  },
  State_3826_Name = {
    Text = "狀態@幻夢銀鑰：爆發計數"
  },
  State_3827_Desc = {
    Text = "隊伍唯一：裝備者生命回復提高 <WeaponEffect_Num:[StateArg1]%>。釋放狂氣爆發後，下回合開始時回復 <WeaponEffect_Num:[StateArg2]%> 已損失生命。"
  },
  State_3827_WeaponDesc = {
    Text = "裝備者生命回復提高 <WeaponEffect_Num:[StateArg1]%>。釋放狂氣爆發後，下回合開始時回復 <WeaponEffect_Num:[DescArg1]%> 已損失生命。"
  },
  State_3830_Name = {
    Text = "額外生效 1 次"
  },
  State_3834_Desc = {
    Text = "迷宮蛛造成的中毒翻倍。"
  },
  State_3835_Desc = {
    Text = "本回合內暴擊傷害提高 [Layer] %。"
  },
  State_3835_Name = {
    Text = "臨時暴擊傷害"
  },
  State_3835_WeaponDesc = {
    Text = "本回合內暴擊傷害提高 [Layer] %。"
  },
  State_3836_Desc = {Text = "測試123"},
  State_3836_Name = {Text = "測試123"},
  State_3837_Desc = {
    Text = "隊伍唯一：裝備者造成的狂氣提高 <WeaponEffect_Num:[StateArg1]%>，造成的中毒提高 <WeaponEffect_Num:[StateArg2]%>。裝備者造成主動傷害後，所有喚醒體臨時暴擊傷害提高，數值等同於裝備者基礎暴擊傷害的 <WeaponEffect_Num:[StateArg3]%>，每回合最多生效 1 次。若當前界域為「深海」，戰鬥開始時，觸腕上限和觸腕數量 +1。"
  },
  State_3837_WeaponDesc = {
    Text = "裝備者造成的狂氣提高 <WeaponEffect_Num:[StateArg1]%>，造成的中毒提高 <WeaponEffect_Num:[StateArg2]%>。裝備者造成主動傷害後所有喚醒體臨時暴擊傷害 +<WeaponEffect_Num:[DescArg1]%> ，每回合最多生效 1 次。若當前界域為「深海」，戰鬥開始時，觸腕上限和觸腕數量 +1。"
  },
  State_3839_Desc = {
    Text = "戰鬥開始時，卡組中每有 1 張症狀卡就獲得 [Arg1] 力量。你的所有症狀卡獲得虛無。"
  },
  State_3840_Desc = {
    Text = "生命值每次降低時，獲得 [StateArg1] 的戒備。"
  },
  State_3840_Name = {Text = "警覺"},
  State_3842_Desc = {
    Text = "造成的主動和觸腕傷害降低 [DescArg1] %。"
  },
  State_3842_Name = {Text = "虛弱"},
  State_3842_WeaponDesc = {
    Text = "造成的所有傷害降低 [DescArg1] %。"
  },
  State_3843_Desc = {
    Text = "每次行動附加[Layer]出血"
  },
  State_3843_Name = {Text = "重傷"},
  State_3843_WeaponDesc = {
    Text = "每次行動附加[Layer]出血，治療可移除出血效果"
  },
  State_3844_Desc = {
    Text = "鯨躍的所有傷害次數+1。"
  },
  State_3844_Name = {
    Text = "戰欲難平"
  },
  State_3844_WeaponDesc = {
    Text = "鯨躍的所有傷害次數+1。"
  },
  State_3848_Desc = {
    Text = "本場戰鬥內，隨機一個喚醒體的狂氣爆發被封印，不可使用。"
  },
  State_3850_Desc = {
    Text = "每打出第 [StateArg1] 張牌時，提高 [StateArg2] 觸腕傷害，使所有觸腕攻擊 1 次。"
  },
  State_3850_Name = {
    Text = "異化漁叉"
  },
  State_3850_WeaponDesc = {
    Text = "每打出第 [StateArg1] 張牌時，提高 [StateArg2] 觸腕傷害，使所有觸腕攻擊 1 次。"
  },
  State_3851_Name = {
    Text = "飾品劇院貓"
  },
  State_3851_WeaponDesc = {
    Text = "造成的所有傷害提高，提高值等於裝備者最大生命的 10%"
  },
  State_3852_Desc = {
    Text = "撕咬傷害次數提高[Layer]。"
  },
  State_3852_Name = {
    Text = "漸強撕咬"
  },
  State_3852_WeaponDesc = {
    Text = "撕咬傷害次數提高[Layer]。"
  },
  State_3853_Desc = {
    Text = "回合開始時隨機變形為抽牌堆中一張指令卡的複製，其算力消耗固定為 3，回合結束時變回。"
  },
  State_3853_Name = {
    Text = "<CardKeyWord:譫妄>"
  },
  State_3853_WeaponDesc = {
    Text = "卡牌不會在棄牌階段進入棄牌堆，而是保留在手牌中。"
  },
  State_3854_Desc = {
    Text = "抽 2 張牌，同時會引起獵顱者的注意。"
  },
  State_3854_Name = {
    Text = "<CardKeyWord:被狩獵>"
  },
  State_3856_Desc = {
    Text = "狀態@序章重置牌庫0_1_3_1"
  },
  State_3856_Name = {
    Text = "狀態@序章重置牌庫0_1_3_1"
  },
  State_3856_WeaponDesc = {
    Text = "狀態@序章重置牌庫0_1_3_1"
  },
  State_3859_Desc = {
    Text = "豐穰之息提供的狂氣翻倍。"
  },
  State_3859_Name = {
    Text = "目見母親"
  },
  State_3859_WeaponDesc = {
    Text = "豐穰之息提供的狂氣翻倍。"
  },
  State_3860_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_3860_Name = {
    Text = "狀態@試作小刀幸運"
  },
  State_3862_Name = {
    Text = "狀態@關卡2_15戰鬥4氣泡1"
  },
  State_3863_Desc = {
    Text = "每釋放 3 次狂氣爆發後，所有手牌算力消耗降低 1。"
  },
  State_3866_Desc = {
    Text = "在本回合內，手牌上限 +[Layer]。"
  },
  State_3867_Name = {
    Text = "超維職業計數器"
  },
  State_3868_Desc = {
    Text = "本回合內造成的護盾提高 [Layer] 點。"
  },
  State_3868_Name = {
    Text = "臨時戒備"
  },
  State_3868_WeaponDesc = {
    Text = "本回合內造成的護盾提高 [Layer] 點。"
  },
  State_3872_Desc = {
    Text = "受到傷害會取消臨時力量。"
  },
  State_3872_Name = {Text = "破綻"},
  State_38730_Desc = {
    Text = "回合開始後有 [DescArg1]% 機率獲得 1 層觸腕集結，超過 100% 時可獲得多層。"
  },
  State_38730_Name = {Text = "海歸線"},
  State_38735_Desc = {
    Text = "造成的主動傷害減少 [StateArg1]% ，攻擊次數翻倍，持續 [Layer] 回合。"
  },
  State_38735_Name = {Text = "囈語"},
  State_38738_Desc = {
    Text = "上限為 10 層，可繼承到下場戰鬥。"
  },
  State_38738_Name = {Text = "夢引"},
  State_3873_Desc = {
    Text = "本場戰鬥內界域精通提高 [Layer] 點。"
  },
  State_3874_Name = {
    Text = "狀態@風鈴卡牌還原"
  },
  State_3876_Desc = {
    Text = "每個偶數回合使我方隊伍力量減少。"
  },
  State_3876_Name = {
    Text = "「死夢之孔」"
  },
  State_3878_Desc = {
    Text = "每損失 2 點生命，下回合開始時獲得 [Layer] 點護盾。"
  },
  State_3878_Name = {
    Text = "苦痛與歡愉"
  },
  State_3878_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_3879_Desc = {
    Text = "拾取時最大生命提高 [Arg1] 點。若拾取時生命低於 25%，最大生命提高變為 [Arg2] 點。"
  },
  State_3881_Desc = {
    Text = "狀態@怪物喬治吃蠟像小怪"
  },
  State_3881_Name = {
    Text = "狀態@怪物喬治吃蠟像小怪"
  },
  State_3881_WeaponDesc = {
    Text = "狀態@怪物喬治吃蠟像小怪"
  },
  State_3882_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_3882_Name = {
    Text = "尚未覺醒"
  },
  State_3883_Desc = {
    Text = "本次關卡內暴擊率提高 [Layer] % 。"
  },
  State_3883_Name = {
    Text = "永久暴擊率"
  },
  State_3883_WeaponDesc = {
    Text = "本次關卡內暴擊率提高 [Layer] % 。"
  },
  State_3884_Desc = {
    Text = "每回合額外生成 1 個胚胎融合度。你的所有吞噬效果均變為無限吞噬。"
  },
  State_3884_Name = {
    Text = "造物蠕動的臍帶"
  },
  State_3884_WeaponDesc = {
    Text = "每回合額外生成 1 個胚胎融合度。你的所有吞噬效果均變為無限吞噬。"
  },
  State_3888_Desc = {
    Text = "無法釋放狂氣爆發，回合結束時移除 1 層。"
  },
  State_3888_WeaponDesc = {
    Text = "所有喚醒體的狂氣爆發不可使用。"
  },
  State_3890_Name = {
    Text = "抽取棄牌數+ [DescArg1] 張牌"
  },
  State_3893_Desc = {
    Text = "造成傷害時獲得 [Arg1] 點護盾。回復生命時，獲得 [Arg2] 點臨時力量。"
  },
  State_3893_Name = {
    Text = "我們的家"
  },
  State_3894_Desc = {
    Text = "棄牌階段前將手牌變成石頭"
  },
  State_3894_WeaponDesc = {
    Text = "棄牌階段前將手牌變成石頭"
  },
  State_3895_Desc = {
    Text = "本回合內暴擊率提高 [Layer] %。"
  },
  State_3895_Name = {
    Text = "臨時暴擊率"
  },
  State_3895_WeaponDesc = {
    Text = "本回合內暴擊率提高 [Layer] %。"
  },
  State_3898_Desc = {
    Text = "下回合開始時獲得 [Layer] 點護盾。"
  },
  State_3898_Name = {
    Text = "苦痛與歡愉護盾"
  },
  State_3900_Name = {
    Text = "卡牌被封印，無法打出，棄掉時解除"
  },
  State_3901_Name = {
    Text = "造物祭司權杖計數"
  },
  State_3902_Desc = {
    Text = "本回合內造成的主動傷害降低 [Layer] 點。"
  },
  State_3902_WeaponDesc = {
    Text = "本回合內造成的傷害降低 [Layer] 點。"
  },
  State_3904_Desc = {
    Text = "每失去 1 點生命移除 1 層，層數為 0 時，獲得 [StateArg1] 護盾，並重新獲得 [StateArg2] 層血之屏障。"
  },
  State_3904_Name = {
    Text = "覺醒-血之屏障"
  },
  State_3905_Desc = {
    Text = "每次承受主動傷害時，對傷害來源造成 [Layer] 點<FixedDamage:純粹傷害>。"
  },
  State_3905_Name = {Text = "反擊"},
  State_3905_WeaponDesc = {
    Text = "每次承受主動傷害時，對攻擊者造成 [Layer] 點<FixedDamage:純粹傷害>。"
  },
  State_3906_Name = {
    Text = "殘留的銀芯"
  },
  State_3907_Name = {
    Text = "殘留的銀芯"
  },
  State_3908_Desc = {
    Text = "缸中之腦施加回復時，抽 [Arg2] 張牌。"
  },
  State_3908_Name = {
    Text = "虛實二象"
  },
  State_3908_WeaponDesc = {
    Text = "缸中之腦施加回復時，抽 [Arg2] 張牌。"
  },
  State_3909_Name = {
    Text = "殘留的銀芯"
  },
  State_3910_Name = {
    Text = "殘留的銀芯"
  },
  State_3911_Name = {
    Text = "殘留的銀芯"
  },
  State_3912_Name = {
    Text = "殘留的銀芯"
  },
  State_3913_Desc = {
    Text = "隊伍唯一：裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>。回合開始時，保留 <WeaponEffect_Num:[StateArg2]%> 剩餘護盾，保留的護盾至多為 <WeaponEffect_Num:[StateArg3]%> 最大生命護盾。"
  },
  State_3913_WeaponDesc = {
    Text = "裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>。回合開始時，保留 <WeaponEffect_Num:[StateArg2]%> 剩餘護盾，保留的護盾至多為 <WeaponEffect_Num:[StateArg3]%> 最大生命護盾。"
  },
  State_3914_Desc = {
    Text = "每回合釋放第 2 次狂氣爆發後，所有喚醒體獲得 10 點狂氣。每回合釋放第 3 次狂氣爆發後，所有喚醒體狂氣冷卻重置，並獲得 10 點狂氣。"
  },
  State_3915_Name = {
    Text = "殘留的銀芯"
  },
  State_3916_Name = {
    Text = "殘留的銀芯"
  },
  State_3917_Desc = {
    Text = "下回合加臨時力量"
  },
  State_3918_Desc = {
    Text = "每個回合開始時獲得首次受到傷害翻倍的狀態"
  },
  State_3918_WeaponDesc = {
    Text = "每個回合開始時獲得首次受到傷害翻倍的狀態"
  },
  State_3921_Desc = {
    Text = "本回合卡牌不會在棄牌階段進入棄牌堆，而是保留在手牌中。"
  },
  State_3921_WeaponDesc = {
    Text = "卡牌不會在棄牌階段進入棄牌堆，而是保留在手牌中。"
  },
  State_3925_Name = {
    Text = "狀態@第四章共鳴@我方隊伍回合開始算力2"
  },
  State_3926_Desc = {
    Text = "「扭曲死體狂宴」增加 [Layer] 點傷害。"
  },
  State_3926_WeaponDesc = {
    Text = "增加「狂躁」傷害。"
  },
  State_3927_Desc = {
    Text = "抽到「空虛」後，本回合內使所有喚醒體獲取的狂氣降低[Layer]%。"
  },
  State_3927_Name = {Text = "空虛"},
  State_3927_WeaponDesc = {
    Text = "抽到「空虛」後，本回合內使所有喚醒體獲取的狂氣降低[Layer]%。"
  },
  State_3928_Desc = {
    Text = "甜蜜惡鬼造成傷害時，獲得 [StateArg2] 反擊。"
  },
  State_3928_Name = {Text = "施與受"},
  State_3929_Desc = {
    Text = "獲得的力量和護盾降低 50%，回合結束時移除 1 層。"
  },
  State_3929_Name = {
    Text = "<CardKeyWord:詛咒>"
  },
  State_3929_WeaponDesc = {
    Text = "本回合內免疫對己方施加的正面狀態"
  },
  State_3930_Name = {
    Text = "狀態@第四章共鳴@我方隊伍回合開始算力1"
  },
  State_3931_Name = {
    Text = "狀態@猩紅血與沙的讚歌"
  },
  State_3932_Desc = {
    Text = "使卡牌獲得保留，每層凝滯詛咒使卡牌費用提高1點，打出後移除凝滯詛咒。"
  },
  State_3932_Name = {
    Text = "凝滯詛咒([Layer])"
  },
  State_3932_WeaponDesc = {
    Text = "使卡牌獲得保留，每層凝滯詛咒使卡牌費用提高1點，打出後移除凝滯詛咒。"
  },
  State_3933_Desc = {
    Text = "提高[Layer]點防禦力。"
  },
  State_3933_Name = {
    Text = "臨時防禦力提高"
  },
  State_3933_WeaponDesc = {
    Text = "提高[Layer]點防禦力。"
  },
  State_3934_Desc = {
    Text = "獲得的所有護盾降低 50 %。"
  },
  State_3934_Name = {
    Text = "寂滅脆弱"
  },
  State_3934_WeaponDesc = {
    Text = "獲得的所有護盾降低 50 %。"
  },
  State_3935_Desc = {
    Text = "我方隊伍每使用一張手牌，獲得一層「觀測」，達到十層時自身眩暈。"
  },
  State_3935_Name = {Text = "觀測"},
  State_3936_Desc = {
    Text = "裝備者造成傷害、護盾、治療提高 [StateArg1]%。（臨時）"
  },
  State_3936_Name = {
    Text = "狀態@試作長劍界域"
  },
  State_3937_Desc = {
    Text = "荊棘女王施加反擊時，獲得一半反擊的護盾。"
  },
  State_3937_Name = {
    Text = "活屍之牆"
  },
  State_3938_Name = {
    Text = "生成蠟像"
  },
  State_3941_Desc = {
    Text = "當吞噬胚胎時，從棄牌堆回到手牌堆"
  },
  State_3941_Name = {
    Text = "蒼白迴旋"
  },
  State_3941_WeaponDesc = {
    Text = "當吞噬胚胎時，從棄牌堆回到手牌堆"
  },
  State_3942_Name = {
    Text = "飾品海歸線"
  },
  State_3942_WeaponDesc = {
    Text = "戰鬥開始後，若裝備者職業為深海，攻擊力提高 25%。"
  },
  State_3943_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_3943_Name = {
    Text = "尚未覺醒"
  },
  State_3944_Desc = {
    Text = "回合結束後所有喚醒體獲得 5 狂氣。每剩餘 1 點算力，所有喚醒體就額外獲得 3 狂氣。"
  },
  State_3945_Desc = {
    Text = "所有造物價格降低 50%。"
  },
  State_39547_Desc = {
    Text = "戰鬥結束後額外獲得 5 黑印，該效果受黑印掉落加成。旺達打出卡牌後，獲得 1 層夢引，該效果每回合至多觸發2次。當前還剩 [DescArg1] 次。"
  },
  State_39547_Name = {
    Text = "裘皮與維納斯"
  },
  State_40484_Desc = {
    Text = "旺達技能觸發躍遷效果時，若存在 5 層，消耗 5 層並獲得額外效果。夢引上限為 10 層，會繼承到下場戰鬥。"
  },
  State_40484_Name = {
    Text = "<PurpleKeyWord:夢引>"
  },
  State_41337_Desc = {
    Text = "回合結束時回復 [Layer] 點生命。"
  },
  State_41337_Name = {
    Text = "玫瑰的勝利-回復"
  },
  State_41340_Desc = {
    Text = "隊伍唯一：裝備者造成的護盾和反擊提高 <WeaponEffect_Num:[StateArg1]%>。每當受到攻擊時，有 <WeaponEffect_Num:[StateArg2]%> 機率使所有喚醒體獲得 1 點狂氣。"
  },
  State_41340_WeaponDesc = {
    Text = "裝備者造成的護盾和反擊提高 <WeaponEffect_Num:[StateArg1]%>。每當受到攻擊時，有 <WeaponEffect_Num:[StateArg2]%> 機率使所有喚醒體獲得 1 點狂氣。"
  },
  State_41342_Name = {
    Text = "變化效果__「僅開發用」"
  },
  State_41344_Name = {
    Text = "變化效果"
  },
  State_41360_Desc = {
    Text = "消耗 5 層<DreamGuide:夢引>，旺達獲得 <Energy:[StateArg1]> 點狂氣，獲得等同於 [StateArg2]% 永久<RetaliateIconKeywords:反擊>的臨時<RetaliateIconKeywords:反擊>。"
  },
  State_41360_Name = {
    Text = "深眠反擊"
  },
  State_41361_Desc = {
    Text = "消耗 10 層<DreamGuide:夢引>，使所有敵人進入 1 回合「喃喃自語」狀態：造成的主動傷害減少 [StateArg3]% ，攻擊次數翻倍。"
  },
  State_41361_Name = {
    Text = "囈語回音"
  },
  State_43818_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_43818_Name = {
    Text = "尚未覺醒"
  },
  State_44398_Desc = {
    Text = "每回合第一次打出卡牌後，將對應喚醒體的一張「防禦」置入手中。"
  },
  State_44484_Name = {
    Text = "首領戰中可使用3次"
  },
  State_44485_Name = {
    Text = "(剩餘：[Layer])"
  },
  State_44491_Name = {
    Text = "禁用效果__「僅開發用」"
  },
  State_44575_Desc = {
    Text = "本回合剩餘的護盾不會移除，將保留至下 1 回合。"
  },
  State_44575_Name = {
    Text = "護盾保留"
  },
  State_44653_Desc = {
    Text = "每回合開始時所有喚醒體獲得 20 狂氣。拾取時最大生命降低 50%。"
  },
  State_44665_Desc = {
    Text = "本回合「打擊」暴擊率提高 [Layer] % 。"
  },
  State_44665_Name = {
    Text = "打擊暴擊率"
  },
  State_44667_Desc = {
    Text = "「打擊」獲得 [DescArg1] 點算力。若當前姿態為「怒濤」，不再獲得算力，而是使 1 條觸腕攻擊 [DescArg2] 次。"
  },
  State_44671_Desc = {
    Text = "每回合開始時所有喚醒體獲得 25 狂氣。拾取時最大生命變為 3 倍。"
  },
  State_44672_Name = {
    Text = "受祝·蟲群意識"
  },
  State_44711_Desc = {
    Text = "造物上限+5, [融痕]中刷新次數+1。戰鬥結束後，獲得 125 黑印，拾取時可以選擇最多 6 張症狀卡刪除。"
  },
  State_44713_Desc = {
    Text = "戰鬥結束後，額外獲得 100 黑印和 2 張症狀卡。"
  },
  State_44730_Desc = {
    Text = "回合開始時，積攢 <Heal:[Heal:StateArg1]> 點猩紅熔爐回復量。"
  },
  State_44730_Name = {
    Text = "予以救贖"
  },
  State_44731_Desc = {
    Text = "以苦消苦。消耗所有猩紅熔爐剩餘的回復量，每消耗 1 點就使傷害提高 3 點，若為首領戰，則改為每消耗 1 點傷害提高 9 點。每消耗 1％ 最大生命的猩紅熔爐就提高 [DescArg1]% 最終傷害。"
  },
  State_44732_Desc = {
    Text = "以血施救。造成傷害後，失去 10% 當前生命，積攢與失去生命等量的猩紅熔爐回復量。"
  },
  State_44732_Name = {Text = "奉獻"},
  State_44739_Desc = {
    Text = "拾取時永久失去 [Arg1] 力量。每當造成傷害時，回復 [Arg2] 點生命，每回合最多觸發 6 次。"
  },
  State_44739_Name = {
    Text = "負罪·七鰓鰻之吻"
  },
  State_44740_Name = {
    Text = "受祝·七鰓鰻之吻"
  },
  State_44741_Desc = {
    Text = "拾取時永久失去 [Arg1] 力量。每當造成傷害時，回復 [Arg2] 點生命，每回合最多觸發 6 次。"
  },
  State_44741_Name = {
    Text = "負罪·七鰓鰻之吻"
  },
  State_44742_Desc = {
    Text = "拾取時永久失去 [Arg1] 力量。每當造成傷害時，回復 [Arg2] 點生命，每回合最多觸發 6 次。"
  },
  State_44742_Name = {
    Text = "受祝·七鰓鰻之吻"
  },
  State_44743_WeaponDesc = {
    Text = "戰鬥開始時脆弱自身 3 回合。"
  },
  State_44744_WeaponDesc = {
    Text = "戰鬥開始時脆弱自身 3 回合。"
  },
  State_44750_Desc = {
    Text = "回合開始時獲得 [StateArg1] 算力。"
  },
  State_44750_Name = {
    Text = "造物黑燭1"
  },
  State_44751_Desc = {
    Text = "回合開始時獲得 [StateArg1] 算力。"
  },
  State_44751_Name = {
    Text = "造物黑燭1"
  },
  State_44752_Desc = {
    Text = "每當「索菲亞」失去 1 點生命值就下降 1 層，層數為 0 後，將意圖替換為 「以牙還牙」並獲得 [StateArg2] 護盾。第一次觸發時會恢復所有層數。"
  },
  State_44752_Name = {
    Text = "埋藏的衝動"
  },
  State_44762_Desc = {
    Text = "打出「防禦」時，將 1 張傷口洗入抽牌堆。"
  },
  State_44763_Desc = {
    Text = "所有喚醒體暴擊傷害屬性減半。"
  },
  State_44764_Desc = {
    Text = "打出「打擊」時，將 1 張傷口洗入抽牌堆。"
  },
  State_44764_Name = {Text = "創傷"},
  State_44807_Desc = {
    Text = "當第一次即將被擊敗時，回復生命並轉變意圖為 「鏡中判決」，強化自身。當第二次即將被擊敗時，回復生命並轉變意圖為 「癲狂撕咬」，造成超高額單次傷害。"
  },
  State_44807_Name = {
    Text = "埋藏的殺戮"
  },
  State_44819_Desc = {
    Text = "若沒有<ParcloseIconKeywords:屏障>，則獲得 1 層臨時<ParcloseIconKeywords:屏障>，否則獲得 10% 暴擊率和暴擊傷害。"
  },
  State_44819_Name = {
    Text = "<CardKeyWord:父神守護>"
  },
  State_44828_Desc = {
    Text = "隊伍唯一：回合結束時，裝備者獲得 [StateArg1] 點狂氣。承受主動和觸腕傷害時，下回合開始時獲得 <WeaponEffect_Num:[StateArg2]%> 傷害的護盾。若當前界域為血肉，不再獲得延遲護盾，而是積攢 <WeaponEffect_Num:[StateArg2]%> 傷害的回覆量到猩紅熔爐。"
  },
  State_44828_WeaponDesc = {
    Text = "回合結束時，裝備者獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣。承受主動或觸腕傷害時，下回合開始時獲得 <WeaponEffect_Num:[Float:StateArg2]%> 傷害的護盾。若當前界域為血肉，不再獲得延遲護盾，而是積攢 <WeaponEffect_Num:[Float:StateArg2]%> 傷害的回覆量到猩紅熔爐。"
  },
  State_44889_Name = {
    Text = "狀態@人面犬BOSS@終焉之鏡1"
  },
  State_44890_Name = {
    Text = "狀態@人面犬BOSS@終焉之鏡2"
  },
  State_44891_Name = {
    Text = "狀態@人面犬BOSS@終焉之鏡3"
  },
  State_44903_Desc = {
    Text = "承受主動或觸腕傷害後，會將 [StateArg1]% 傷害轉化為猩紅熔爐回覆量，持續 [Layer] 回合。"
  },
  State_45018_Desc = {
    Text = "回合結束之前無法使用「打擊」。"
  },
  State_45018_Name = {Text = "麻痺"},
  State_45025_Desc = {
    Text = "具體效果看通用打擊邏輯。__「僅開發用」"
  },
  State_45029_Desc = {
    Text = "具體效果看通用打擊邏輯。__「僅開發用」"
  },
  State_45032_Desc = {
    Text = "下回合結束時，受到 [Layer] 傷害。"
  },
  State_45039_Desc = {
    Text = "直到下個回合開始時，每當承受主動或觸腕傷害，下個回合開始時獲得 [Layer]% 傷害的護盾。"
  },
  State_45039_Name = {
    Text = "神跡降臨"
  },
  State_45040_Desc = {
    Text = "直到下個回合開始時，每當承受主動或觸腕傷害，積攢 [Layer]% 傷害的回覆量到猩紅熔爐。"
  },
  State_45040_Name = {
    Text = "神跡降臨"
  },
  State_45049_Desc = {
    Text = "抵消下次主動攻擊傷害造成的生命損失，最多可堆疊 3 層，每層死鬥會使屏障的可堆疊層數 -1 ，已獲得的屏障不會因可堆疊層數減少而減少。"
  },
  State_45050_Desc = {
    Text = "抵消下次主動攻擊傷害造成的生命損失，最多可堆疊 3 層，每層死鬥會使屏障的可堆疊層數 -1 ，已獲得的屏障不會因可堆疊層數減少而減少。"
  },
  State_45064_Name = {
    Text = "無聲歡宴的計數器__「僅開發用」"
  },
  State_45069_Desc = {
    Text = "具體效果看通用打擊邏輯。__「僅開發用」"
  },
  State_45072_Name = {
    Text = "聖化計數"
  },
  State_45076_Desc = {
    Text = "施加時驅散目標身上的護盾和延遲治療，回合結束之前，受到的治療和護盾效果降低 50% 。"
  },
  State_45076_Name = {Text = "重創"},
  State_45137_Desc = {
    Text = "使用狂氣爆發後封印所有喚醒體一回合，且獲得一回合易傷。"
  },
  State_45139_Desc = {
    Text = "使用狂氣爆發後，隨機驅散 1 種負面狀態。"
  },
  State_45148_Desc = {
    Text = "所有喚醒體暴擊傷害屬性減半。"
  },
  State_45166_Desc = {
    Text = "回合結束之前所裝備的命輪失效。"
  },
  State_45166_Name = {Text = "纏繞"},
  State_45206_Desc = {
    Text = "以信濟世。消耗所有猩紅熔爐剩餘的回復量，獲得 150% 消耗量的護盾，該護盾不受護盾加成和減益影響，但無視護盾上限。"
  },
  State_45206_Name = {Text = "救贖"},
  State_45248_Name = {
    Text = "計數器__「僅開發用」"
  },
  State_45328_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使自身獲得<TauntKeywords:嘲諷>與 <Block:[Block:StateArg1]> 護盾。"
  },
  State_45329_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」可以選擇目標，「打擊」前<PVPRepelKeywords:擊退>目標所有可驅散的正面狀態到其身後喚醒體。"
  },
  State_45329_Name = {
    Text = "深海的呼喚"
  },
  State_45331_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時以及「打擊」後、將手牌中裝備者的非衍生「技能」會按順序變成裝備者的其他「技能」[ShowIfState:、 <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]。"
  },
  State_45331_Name = {
    Text = "往昔的花與詩"
  },
  State_45332_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：每受到一次主動傷害使其他友方獲得  <Energy:[Energy:StateArg1]>  狂氣。"
  },
  State_45332_Name = {
    Text = "伊薩拉烏的目光"
  },
  State_45333_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：手牌上限 +[StateArg1]，「狂氣爆發」後使自身獲得 <Energy:[Energy:StateArg2]> 狂氣。"
  },
  State_45333_Name = {
    Text = "灼熱的吻別"
  },
  State_45334_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」使本回合下一次「打擊」改為隨機目標並且額外攻擊 [StateArg1] 名隨機目標。"
  },
  State_45334_Name = {Text = "鏡中人"},
  State_45345_Desc = {
    Text = "用於記錄使用了幾次1階段生育技能"
  },
  State_45345_Name = {
    Text = "生育標識1"
  },
  State_45346_Desc = {
    Text = "用於記錄使用了幾次2階段生育技能"
  },
  State_45346_Name = {
    Text = "生育標識2"
  },
  State_45354_Desc = {
    Text = "該卡牌無法被打出。__「僅開發用」"
  },
  State_45354_Name = {
    Text = "無法打出__「僅開發用」"
  },
  State_45356_Desc = {
    Text = "回合結束時，變為你最後打出的「技能」牌，使其算力消耗 -2，打出後「灰霧真容」洗入牌庫。"
  },
  State_45356_Name = {
    Text = "<CardKeyWord:灰霧真容>"
  },
  State_45364_Desc = {
    Text = "下回合開始時，該喚醒體獲得 [Layer] 張「打擊」。"
  },
  State_45364_Name = {
    Text = "延遲獲得打擊"
  },
  State_45385_Desc = {
    Text = "本場戰鬥內造成的所有傷害降低 [Layer] 點，無法驅散，其中有 [DescArg1]  層臨時力量降低，會在回合結束後移除。"
  },
  State_45387_Desc = {
    Text = "本場戰鬥內造成的所有傷害提高 [Layer] 點，無法驅散，其中有 [DescArg1] 層臨時力量，會在回合結束後移除。"
  },
  State_45397_Desc = {
    Text = "回合開始時，將 1 層屏障轉化為力量。"
  },
  State_45397_Name = {
    Text = "玫瑰的勝利"
  },
  State_45403_Desc = {
    Text = "下回合開始時，獲得 [Layer] 層蓄力。"
  },
  State_45403_Name = {
    Text = "延遲蓄力"
  },
  State_45407_Desc = {
    Text = "獲得的狂氣和延遲狂氣降低 50%，並立即移除所有延遲狂氣。"
  },
  State_45407_Name = {Text = "空虛"},
  State_45656_Desc = {
    Text = "母樹第三次復活，啟動生育2技能"
  },
  State_45658_Desc = {
    Text = "母樹第一次復活，啟動生育技能"
  },
  State_45661_Desc = {
    Text = "當生命降低至 0 時，使生命變為 1 點，不再受到傷害，準備釋放「多重融合」。"
  },
  State_45715_Desc = {
    Text = "獲得等同於 [StateArg1]% 觸腕傷害的臨時力量。"
  },
  State_45715_Name = {Text = "篡奪"},
  State_45716_Desc = {
    Text = "獲得等同於 [StateArg1]% 觸腕傷害的臨時力量。戈利亞獲得 25% 臨時暴擊率。"
  },
  State_45716_Name = {Text = "篡奪"},
  State_45717_Desc = {
    Text = "使「巨刃之威」和「斬首重創」基礎傷害在本場戰鬥中提高 25%。戈利亞獲得 <Energy:[Energy:StateArg2]> 點狂氣。"
  },
  State_45717_Name = {Text = "蟄伏"},
  State_45718_Desc = {
    Text = "使「巨刃之威」和「斬首重創」基礎傷害在本場戰鬥中提高 25%。"
  },
  State_45718_Name = {Text = "蟄伏"},
  State_46079_Desc = {
    Text = "本回合內，每當目標被主動傷害，就回復損失生命最多的友方 [Layer] 生命。"
  },
  State_46079_Name = {
    Text = "聖血指引"
  },
  State_46119_Desc = {
    Text = "下次被攻擊時對攻擊者施加纏繞。"
  },
  State_46119_Name = {
    Text = "迷宮陷阱"
  },
  State_46124_Desc = {
    Text = "回合結束之前無法進行任何行動。"
  },
  State_46138_Desc = {
    Text = "變為對手打出的上一張「技能」，且使其費用 - 1。"
  },
  State_46138_Name = {
    Text = "<CardKeyWord:星彩擬態>"
  },
  State_46139_Desc = {
    Text = "每當被主動攻擊使自身獲得 [Layer] 層蓄力並對攻擊者造成 [Layer] 層遲緩。"
  },
  State_46139_Name = {
    Text = "異常引力"
  },
  State_46155_Desc = {
    Text = "自身的「技能」後獲得 [StateArg1] 層蓄力並使層數 - 1。回合結束時消耗所有層數，每層回復 [StateArg2] 生命。"
  },
  State_46155_Name = {
    Text = "異端之血"
  },
  State_46243_Name = {
    Text = "洞悉計數器__「僅開發用」"
  },
  State_46255_Desc = {
    Text = "具體效果看通用打擊邏輯。__「僅開發用」"
  },
  State_46256_Desc = {
    Text = "具體效果看通用打擊邏輯。__「僅開發用」"
  },
  State_46322_Desc = {
    Text = "回合開始時獲得 30 胚胎融合。"
  },
  State_46322_Name = {
    Text = "尤烏哈希試玩"
  },
  State_46323_Desc = {
    Text = "超維回合開始後，獲得 100 點狂氣，回合開始後獲得 7 點力量。"
  },
  State_46323_Name = {
    Text = "莉茲試玩"
  },
  State_46324_Desc = {
    Text = "每回合獲得 1 張「靈感」。"
  },
  State_46324_Name = {
    Text = "詹金試玩"
  },
  State_46329_Desc = {
    Text = "戰鬥開始後，獲得 600 點銀鑰能量，蘿坦獲得 50 點狂氣，蘿坦釋放狂氣爆發後，額外獲得 44 點狂氣。"
  },
  State_46329_Name = {
    Text = "試玩增益"
  },
  State_46330_Desc = {
    Text = "回合開始時獲得 30 胚胎融合，10 點狂氣，[DescArg1] 點力量，將 3 張「打擊」加入抽牌堆。"
  },
  State_46330_Name = {
    Text = "希洛試玩"
  },
  State_46333_Name = {
    Text = "雷婭試玩"
  },
  State_46334_Desc = {
    Text = "第 4 回合開始後，獲得 100 點狂氣。"
  },
  State_46334_Name = {
    Text = "法洛思試玩"
  },
  State_46336_Desc = {
    Text = "回合開始時獲得 30 胚胎融合，10 點狂氣。"
  },
  State_46336_Name = {
    Text = "阿格里帕試玩"
  },
  State_46337_Desc = {
    Text = "回合開始時獲得 10 點狂氣。"
  },
  State_46337_Name = {
    Text = "凱刻斯試玩"
  },
  State_46338_Desc = {
    Text = "回合開始時獲得 30 胚胎融合，10 點狂氣。"
  },
  State_46338_Name = {
    Text = "菲茵特試玩"
  },
  State_46427_Desc = {
    Text = "具體效果看通用打擊邏輯。__「僅開發用」"
  },
  State_46428_Desc = {
    Text = "具體效果看通用打擊邏輯。__「僅開發用」"
  },
  State_46429_Desc = {
    Text = "具體效果看通用打擊邏輯。__「僅開發用」"
  },
  State_46441_Desc = {
    Text = "免疫非穿刺傷害，回合開始後移除。"
  },
  State_46441_Name = {
    Text = "免疫傷害"
  },
  State_46442_Name = {
    Text = "卡牌禁止修改打擊目標類型__「僅開發用」"
  },
  State_46500_Desc = {
    Text = "具體效果看通用打擊邏輯。__「僅開發用」"
  },
  State_46505_Desc = {
    Text = "本回合內，每當受到主動傷害，獲得 [Layer] 狂氣。"
  },
  State_46505_Name = {
    Text = "疼痛轉化"
  },
  State_46508_Desc = {
    Text = "受到昏迷後獲得抗性，擁有抗性時再次受到昏迷傷害時抵消昏迷效果並使傷害翻倍，此狀態無法驅散。"
  },
  State_46511_Desc = {
    Text = "該喚醒體的「千面重疊」傷害提升 [Layer]。"
  },
  State_46511_Name = {
    Text = "千面重疊"
  },
  State_46512_Desc = {
    Text = "回合結束之前，該喚醒體打出卡牌後受到 [Layer] 傷害。"
  },
  State_46512_Name = {
    Text = "卡牌封鎖"
  },
  State_46513_Desc = {
    Text = "增幅下一個詩篇，使其獲得額外效果，無法被驅散。"
  },
  State_46513_Name = {
    Text = "哀慟濃墨"
  },
  State_46536_Desc = {
    Text = "若狀態參數1為0則抽牌，否則僅漂字"
  },
  State_46538_Desc = {
    Text = "探索開始時，獲得 [StateArg1] 點狂氣。"
  },
  State_46538_Name = {
    Text = "瘋狂預兆"
  },
  State_47072_Desc = {
    Text = "本回合打擊卡暴擊率 +[Layer]%。"
  },
  State_47072_Name = {
    Text = "打擊暴擊"
  },
  State_47089_Name = {
    Text = "測試效果__「僅開發用」"
  },
  State_47096_Desc = {
    Text = "每打出 1 張「靈感」就使達芙黛爾獲得 [StateArg1] 點狂氣，獲得 [StateArg2] 點力量，每回合最多觸發 5 次。（當前還剩 [DescArg1] 次）"
  },
  State_47096_Name = {
    Text = "原質沉澱"
  },
  State_47189_Name = {
    Text = "切換為躁狂人格。血肉·抑郁：<EmbryoFusionIconKeywords:胚胎融合> +[Blood:StateArg5]，積攢 [StateArg6] 點猩紅熔爐回覆量"
  },
  State_47192_Name = {
    Text = "抑鬱人格：也會使其他喚醒體獲得 [DescArg1] 倍的狂氣。躁狂人格：額外獲得 [DescArg2] 倍狂氣"
  },
  State_47199_Name = {
    Text = "切換為抑鬱人格。血肉·躁狂：傷害享受 [DescArg1] 倍<PowerIconKeywords:力量>加成並對目標施加 200％ 傷害的<BleedingIconKeywords:出血>，獲得 [StateArg7] 點<PowerIconKeywords:力量>"
  },
  State_47204_Name = {
    Text = "切換為躁狂人格。混沌·抑鬱：獲得 <Posse:[StateArg1]> 點銀鑰能量，下次鑰令生效 2 次"
  },
  State_47206_Name = {
    Text = "切換為躁狂人格。深海·抑鬱：<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>目標 2 回合，生成 1 條觸腕, <TentacleInjurieIconKeywords:觸腕傷害>+ [TentaclePower:StateArg3]"
  },
  State_47209_Name = {
    Text = "切換為憂鬱人格。超維·躁狂：獲得 15% 造成傷害的<RetaliateIconKeywords:反擊>，然後對其他敵人造成等量<FixedDamage:純粹傷害>。本回合每打出 1 張「靈感」，使該傷害在本回合內提高 [StateArg9] 點，最多提高 [StateArg10] 點"
  },
  State_47211_Name = {
    Text = "抑鬱人格：使手牌中 [DescArg1] 張算力最高的卡牌算力消耗降低 1 點，並獲得臨時<RetainIconKeywords:保留>。躁狂人格：額外造成 [DescArg2] 次傷害"
  },
  State_47212_Name = {
    Text = "使「24」在抑鬱與躁狂人格之間切換，並根據當前界域與人格，觸發額外的效果"
  },
  State_47216_Name = {
    Text = "切換為抑鬱人格。深海·躁狂：該傷害享受 [StateArg4]% <TentacleInjurieIconKeywords:觸腕傷害>加成，並對所有敵人造成 30% 傷害的<IntoxicationIconKeywords:中毒>"
  },
  State_47217_Name = {
    Text = "切換為抑鬱人格。混沌·躁狂：造成 3 次傷害，使「24」造成的所有傷害提高 [StateArg2] 點"
  },
  State_47218_Name = {
    Text = "切換為躁狂人格。超維·抑鬱：將 2 張「靈感」加入手中，使目標臨時降低 [Power:StateArg8] 點<PowerIconKeywords:力量>"
  },
  State_47222_Name = {
    Text = "抑鬱人格：使手牌中 [DescArg1] 張算力最高的卡牌算力消耗降低 1 點，並獲得臨時<RetainIconKeywords:保留>。<AwakerCard_24Lost:躁狂人格：額外造成 [DescArg2] 次傷害>"
  },
  State_47224_Name = {
    Text = "抑鬱人格：也會使其他喚醒體獲得 [DescArg1] 倍的狂氣。<AwakerCard_24Lost:躁狂人格：額外獲得 [DescArg2] 倍狂氣>"
  },
  State_47228_Name = {
    Text = "<AwakerCard_24Lost:抑鬱人格：也會使其他喚醒體獲得 [DescArg1] 倍的狂氣。>躁狂人格：額外獲得 [DescArg2] 倍狂氣"
  },
  State_47229_Name = {
    Text = "<AwakerCard_24Lost:抑鬱人格：使手牌中 [DescArg1] 張算力最高的卡牌算力消耗降低 1 點，並獲得臨時<RetainIconKeywords:保留>。>躁狂人格：額外造成 [DescArg2] 次傷害"
  },
  State_47451_Name = {
    Text = "萊克鑰令禁用命輪效果__「僅開發用」"
  },
  State_47485_Name = {
    Text = "抑鬱人格：使手牌中 [DescArg1] 張算力最高的卡牌算力消耗降低 2 點，並獲得臨時<RetainIconKeywords:保留>。躁狂人格：額外造成 [DescArg2] 次傷害"
  },
  State_47486_Name = {
    Text = "抑鬱人格：使手牌中 [DescArg1] 張算力最高的卡牌算力消耗降低 2 點，並獲得臨時<RetainIconKeywords:保留>。<AwakerCard_24Lost:躁狂人格：額外造成 [DescArg2] 次傷害>"
  },
  State_47488_Name = {
    Text = "抑鬱人格：額外獲得 <Energy: [DescArg1]> 點狂氣。躁狂人格：額外獲得 [DescArg2] 次護盾"
  },
  State_47489_Name = {
    Text = "<AwakerCard_24Lost:抑鬱人格：使手牌中 [DescArg1] 張算力最高的卡牌算力消耗降低 2 點，並獲得臨時<RetainIconKeywords:保留>。>躁狂人格：額外造成 [DescArg2] 次傷害"
  },
  State_47492_Name = {
    Text = "抑鬱人格：額外獲得 <Energy: [DescArg1]> 點狂氣。<AwakerCard_24Lost:躁狂人格：額外造成 [DescArg2] 次傷害>"
  },
  State_47493_Name = {
    Text = "抑鬱人格：額外獲得 <Energy: [DescArg1]> 點狂氣。躁狂人格：額外造成 [DescArg2] 次傷害"
  },
  State_47494_Name = {
    Text = "抑鬱人格：也會使其他喚醒體獲得 [DescArg1] 倍的狂氣，<WeaknessIconKeywords:虛弱>所有敵人 [DescArg3] 回合。躁狂人格：額外獲得 [DescArg2] 倍狂氣，<VulnerabilityIconKeywords:易傷>所有敵人 [DescArg3] 回合"
  },
  State_47495_Name = {
    Text = "抑鬱人格：也會使其他喚醒體獲得 [DescArg1] 倍的狂氣，<WeaknessIconKeywords:虛弱>所有敵人 [DescArg3] 回合。<AwakerCard_24Lost:躁狂人格：額外獲得 [DescArg2] 倍狂氣，易傷所有敵人 [DescArg3] 回合>"
  },
  State_47496_Name = {
    Text = "<AwakerCard_24Lost:抑鬱人格：也會使其他喚醒體獲得 [DescArg1] 倍的狂氣，虛弱所有敵人 [DescArg3] 回合。>躁狂人格：額外獲得 [DescArg2] 倍狂氣，<VulnerabilityIconKeywords:易傷>所有敵人 [DescArg3] 回合"
  },
  State_47498_Name = {
    Text = "<AwakerCard_24Lost:抑鬱人格：額外獲得 [DescArg1] 點狂氣。>躁狂人格：額外造成 [DescArg2] 次傷害"
  },
  State_47499_Name = {
    Text = "<AwakerCard_24Lost:抑鬱人格：額外獲得 [DescArg1] 點狂氣。>躁狂人格：額外獲得 [DescArg2] 次護盾"
  },
  State_47500_Name = {
    Text = "抑鬱人格：額外獲得 <Energy: [DescArg1] > 點狂氣。<AwakerCard_24Lost:躁狂人格：額外獲得 [DescArg2] 次護盾>"
  },
  State_47517_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，棄掉其他喚醒體的 [StateArg1] 張卡牌，若成功棄牌則抽  [StateArg2]  張牌。"
  },
  State_47517_Name = {
    Text = "銀鱈魚的決心"
  },
  State_47518_Name = {
    Text = "銀鱈魚的決心的計數器__「僅開發用」"
  },
  State_47528_Desc = {
    Text = "本回合「打擊」+ [DescArg1]％ 傷害<PVPPenetrateKeywords:貫穿>。"
  },
  State_47528_Name = {Text = "餘威"},
  State_47530_Desc = {
    Text = "視為本回合內上次打出的「技能」。"
  },
  State_47530_Name = {
    Text = "<CardKeyWord:模擬演繹>"
  },
  State_47557_Desc = {
    Text = "隊伍唯一：探索開始後，裝備者進入銀鱈魚人格狀態。裝備者釋放狂氣爆發後將在銀鱈魚人格和貓咪人格之間切換。\n銀鱈魚人格：裝備者造成主動傷害後獲得 <WeaponEffect_Num:[StateArg1]> 銀鑰能量。貓咪人格：裝備者造成主動傷害後，裝備者的臨時暴擊傷害 <WeaponEffect_Num:+[StateArg2]%> 。這兩個效果共享每回合最多觸發 5 次的機會。"
  },
  State_47557_WeaponDesc = {
    Text = "探索開始後，裝備者進入銀鱈魚人格狀態。裝備者釋放狂氣爆發後將在銀鱈魚人格和貓咪人格之間切換。\n銀鱈魚人格：裝備者造成主動傷害後獲得 <WeaponEffect_Num:[StateArg1]> 銀鑰能量。貓咪人格：裝備者造成主動傷害後，裝備者的臨時暴擊傷害 <WeaponEffect_Num:+[StateArg2]%> 。這兩個效果共享每回合最多觸發 5 次的機會。"
  },
  State_47822_Desc = {
    Text = "若下回合再次受到「麻痺」，其所有「打擊」變為「幻象」，不可驅散，持續到下回合結束。"
  },
  State_47822_Name = {
    Text = "有點麻了"
  },
  State_47825_Desc = {
    Text = "回合開始時會觸發對應的技能效果。"
  },
  State_47825_Name = {
    Text = "<CardKeyWord:延遲>"
  },
  State_47826_Desc = {
    Text = "·目標處於「麻痺」時傷害翻倍，否則本回合其「打擊」無法使用。\n·連續 2 回合處於「麻痺」，其所有「打擊」變為「幻象」。"
  },
  State_47826_Name = {
    Text = "<WeaknessColour:麻痺>"
  },
  State_47827_Desc = {
    Text = "每層使本場戰鬥內造成的所有傷害降低 1 點，無法驅散。"
  },
  State_47828_Desc = {
    Text = "·施加時造成等量傷害，若目標處於「纏繞」，則傷害翻倍，否則使目標在回合結束之前所裝備的命輪失效。"
  },
  State_47828_Name = {
    Text = "<WeaknessColour:纏繞>"
  },
  State_47830_Desc = {
    Text = "施加時驅散目標身上的護盾和延遲治療，回合結束之前，受到的治療和護盾效果降低 50% 。"
  },
  State_47830_Name = {
    Text = "<PVPVulnerabilityIconColour:重創>"
  },
  State_47831_Desc = {
    Text = "回合結束之前無法進行任何行動，在受到昏迷傷害後會使目標獲得抗性，擁有抗性時再次受到昏迷傷害時抵消昏迷效果並使傷害翻倍，此狀態無法驅散。"
  },
  State_47832_Desc = {
    Text = "包括染疫小鼠、帶電小鼠、失智小鼠。"
  },
  State_47833_Desc = {
    Text = "包括白鴿手帕、反向分體魔術盒、心靈感應話筒。"
  },
  State_47833_Name = {
    Text = "<CardKeyWord:驚人魔術>"
  },
  State_47841_Desc = {
    Text = "本場戰鬥中下 [Layer] 次使用鑰令將生效 2 次。"
  },
  State_47841_Name = {
    Text = "雙發鑰令"
  },
  State_47842_Desc = {
    Text = "獲得的狂氣和延遲狂氣降低 50%，並立即移除所有延遲狂氣。"
  },
  State_47842_Name = {
    Text = "<PVPEmptinessColour:空虛>"
  },
  State_47843_Desc = {
    Text = "使喚醒體脫離死亡狀態，並將其整套卡牌置入抽牌堆。"
  },
  State_47843_Name = {
    Text = "<PVPResurrectionColour:復活>"
  },
  State_47844_Desc = {
    Text = "隨機產生一個讓人摸不著頭腦的效果。"
  },
  State_47845_Desc = {
    Text = "卡牌在手牌中時便會產生效果。"
  },
  State_47873_Desc = {
    Text = "下回合結束時，造成等量於層數的傷害。"
  },
  State_47887_Name = {
    Text = "根據當前隊伍界域獲得不同的效果"
  },
  State_47888_Name = {
    Text = "血肉：「24」每消耗 1 點算力<EmbryoFusionIconKeywords:胚胎融合> +[Blood:DescArg1]，獲得 [StateArg3] 點<PowerIconKeywords:力量>，「24」狂氣爆發額外享受 300% 力量加成"
  },
  State_47889_Name = {
    Text = "深海：「24」造成的傷害享受 [StateArg2]% <TentacleInjurieIconKeywords:觸腕傷害>加成、並造成 10% 傷害的<IntoxicationIconKeywords:中毒>。「24」的狂氣爆發能觸發敵人 [StateArg6]％ 的<IntoxicationIconKeywords:中毒>"
  },
  State_47892_Name = {
    Text = "混沌：「24」的暴擊率和暴擊傷害 +[StateArg4]%。每次使用鑰令後，使「24」狂氣爆發最終傷害提升 [StateArg1]%"
  },
  State_47894_Name = {
    Text = "超維：「24」造成的傷害享受 [StateArg5]% <RetaliateIconKeywords:反擊>傷害加成，回合結束時往棄牌堆洗入 1 張「靈感」，手牌上限 +2"
  },
  State_48009_Desc = {
    Text = "每回合第一次打出時額外生效 [StateArg1] 次。"
  },
  State_48010_Desc = {
    Text = "合奏標記"
  },
  State_48010_Name = {
    Text = "合奏標記"
  },
  State_48011_Desc = {
    Text = "每回合第一次打出時額外生效 [StateArg1] 次。"
  },
  State_48011_Name = {
    Text = "<Rune_19_High:高級合奏>"
  },
  State_48011_WeaponDesc = {
    Text = "打出後額外生效 [StateArg1] 次，消耗。"
  },
  State_48012_Desc = {
    Text = "使被刻印的卡牌在每回合第一次打出時生效 2 次。"
  },
  State_48013_Desc = {
    Text = "使被刻印的卡牌在每回合第一次打出時生效 3 次。"
  },
  State_48013_Name = {
    Text = "<CardKeyWord:刻印：高級合奏>"
  },
  State_48019_Name = {
    Text = "<CardKeyWord:模擬演繹>"
  },
  State_48020_Name = {
    Text = "<CardKeyWord:靈魂誕生>"
  },
  State_48021_Name = {
    Text = "<CardKeyWord:灰霧真容>"
  },
  State_48078_Name = {
    Text = "<CardKeyWord:星彩擬態>"
  },
  State_48099_Desc = {
    Text = "回合結束時 「24」 獲得 [DescArg1] 點狂氣，每次 「24」 釋放狂氣爆發，這個效果獲得的狂氣提高 1。"
  },
  State_48099_Name = {
    Text = "巴甫洛夫行為研究"
  },
  State_48099_WeaponDesc = {
    Text = "裝備者回合結束後獲得 3 點狂氣。若裝備者狂氣回充大於 10 ，額外獲得 2 點狂氣。"
  },
  State_48100_Name = {
    Text = "狀態@24巴甫洛夫行為研究計數"
  },
  State_48100_WeaponDesc = {
    Text = "裝備者回合結束後獲得 3 點狂氣。若裝備者狂氣回充大於 10 ，額外獲得 2 點狂氣。"
  },
  State_48107_Desc = {
    Text = "每回合打出的第一張裝備者的「技能」傷害提高 [StateArg1]%。"
  },
  State_48108_Desc = {
    Text = "裝備者每回合第一次打出「技能」後，將其一張算力消耗 - [StateArg1] 的複製洗入抽牌堆。"
  },
  State_48108_Name = {
    Text = "旋轉，旋轉"
  },
  State_48110_Desc = {
    Text = "「技能」使本回合下一次「打擊」改為隨機目標並且額外攻擊 [StateArg1] 名隨機目標。"
  },
  State_48110_Name = {Text = "鏡中人"},
  State_48140_Desc = {
    Text = "探索開始時，「24」進入憂鬱人格狀態。\n<School_1:混沌·抑郁>：獲得 <Posse:[StateArg1]> 點銀鑰能量，下次鑰令生效 2 次。\n<School_1:混沌·躁狂>：造成 3 次傷害，使「24」造成的所有傷害提高 [StateArg2] 點。\n<School_2:深海·抑郁>：<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>目標 2 回合，生成 1 條觸腕，<TentacleInjurieIconKeywords:觸腕傷害>+ [StateArg3]。\n<School_2:深海·躁狂>：該傷害享受 [StateArg4]% <TentacleInjurieIconKeywords:觸腕傷害>加成，並對所有敵人造成 30% 造成傷害的<IntoxicationIconKeywords:中毒>。\n<School_3:血肉·抑郁>：<EmbryoFusionIconKeywords:胚胎融合> +[Blood:StateArg5]，積攢 [StateArg6] 點猩紅熔爐回覆量。\n<School_3:血肉·躁狂>：傷害享受 6 倍<PowerIconKeywords:力量>加成並對目標施加 200% 造成傷害的<BleedingIconKeywords:出血>，獲得 [StateArg7] 點<PowerIconKeywords:力量>。\n<School_4:超維·抑郁>：將 2 張「靈感」加入手中，使目標<PowerIconKeywords:力量>臨時降低 [StateArg8] 點。\n<School_4:超維·躁狂>：獲得 15% 造成傷害的<RetaliateIconKeywords:反擊>，然後對其他敵人造成等量<FixedDamage:純粹傷害>。本回合每打出 1 張「靈感」，使該傷害在本回合內提高 [StateArg9] 點，最多提高 [StateArg10] 點。"
  },
  State_48140_Name = {
    Text = "界域與人格效果"
  },
  State_48141_Desc = {
    Text = "<School_1:混沌>：「24」的暴擊率和暴擊傷害 +[StateArg4]%。每次使用鑰令後，使「24」狂氣爆發最終傷害提升 [StateArg1]%。\n<School_2:深海>：「24」造成的傷害享受 [StateArg2]% <TentacleInjurieIconKeywords:觸腕傷害>加成，並造成 10% 傷害的<IntoxicationIconKeywords:中毒>。「24」的狂氣爆發能觸發敵人 50% 的<IntoxicationIconKeywords:中毒>。\n<School_3:血肉>：「24」每消耗 1 點算力<EmbryoFusionIconKeywords:胚胎融合> +[Blood:DescArg1]，獲得 [StateArg3] 點<PowerIconKeywords:力量>。「24」的狂氣爆發額外享受 300% 力量加成\n<School_4:超維>：「24」造成的傷害享受 [StateArg5]% <RetaliateIconKeywords:反擊>傷害加成，回合結束時往棄牌堆洗入 1 張「靈感」，手牌上限 +2。"
  },
  State_48149_Name = {
    Text = "不可打出卡面特效__「僅開發用」"
  },
  State_48176_Desc = {
    Text = "在本次試玩中，每回合獲得 1 點算力，「24」每消耗 1 點算力，獲得 30 點銀鑰能量。"
  },
  State_48176_Name = {
    Text = "「24」試玩"
  },
  State_48198_Desc = {
    Text = "在本次試玩中，每回合獲得 1 張「靈感」。"
  },
  State_48198_Name = {
    Text = "「24」試玩"
  },
  State_48199_Desc = {
    Text = "在本次試玩中，每回合獲得 1 點算力。"
  },
  State_48199_Name = {
    Text = "「24」試玩"
  },
  State_48589_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命且變為原來的 2 倍並以真正的形態開始戰鬥。"
  },
  State_48589_Name = {
    Text = "尚未覺醒"
  },
  State_48607_Name = {
    Text = "通用卡牌原始算力降低__「僅開發用」"
  },
  State_48822_Desc = {
    Text = "血肉界域機制回合開始時，獲得的胚胎融合提高 50%。"
  },
  State_48923_Desc = {
    Text = "影子「24」 已經覺醒，使用最後的「救救我」找到機會吧！"
  },
  State_48923_Name = {
    Text = "影子「24」覺醒！"
  },
  State_48923_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_49063_Desc = {
    Text = "蘿坦的「打擊」傷害提高 30%。"
  },
  State_49063_Name = {
    Text = "昂揚的戰意"
  },
  State_49109_Desc = {
    Text = "卡牌獲得保留，回合結束時若在手中，則獲得 1 張該指令卡的帶有消耗的原始複製。"
  },
  State_49109_WeaponDesc = {
    Text = "打出後額外生效 [StateArg1] 次，消耗。"
  },
  State_49148_Desc = {
    Text = "死亡後，給 1 張算力消耗不為 0 的卡牌附加「畸變 1」。畸變：卡牌狀態，戰鬥結束後仍然保留。每層使算力消耗降低 1，但打出後每層會將 1 張隨機畸變加入手中（無視手牌上限），移除所有的畸變。"
  },
  State_49148_Name = {
    Text = "畸變之胎"
  },
  State_49149_Desc = {
    Text = "每層使卡牌算力消耗降低 1。打出後，每有 1 層畸變，將一張隨機畸變卡牌加入手中，移除該狀態。該狀態在戰鬥結束後會保留。"
  },
  State_49149_Name = {
    Text = "<ExclamationPointColour:畸變 [Layer]>"
  },
  State_49149_WeaponDesc = {
    Text = "打出後將其永久移除。"
  },
  State_49207_Name = {
    Text = "獲得 100 鑰能"
  },
  State_49225_Desc = {
    Text = "回合結束後，使 1 條觸腕攻擊 [Layer] 次。"
  },
  State_49225_Name = {
    Text = "<CardKeyWord:觸腕集結>"
  },
  State_49226_Desc = {
    Text = "回合結束時，每有 1 張手牌，觸發所有敵人 3% 的中毒，並獲得 3 點狂氣。"
  },
  State_49226_Name = {
    Text = "微弱燭光"
  },
  State_49260_Desc = {
    Text = "回合結束時回復等同於體質 7.5% 的生命。"
  },
  State_49260_Name = {
    Text = "不被接納之痛"
  },
  State_49270_Desc = {
    Text = "打擊牌傷害提高 [Layer] %。"
  },
  State_49270_Name = {
    Text = "打擊牌傷害提高"
  },
  State_49270_WeaponDesc = {
    Text = "打擊牌傷害提高 [Layer] %。"
  },
  State_49278_Desc = {
    Text = "回合結束時，回復等同於已損失生命 5% 的生命。若生命低於 50%([StateArg1])，還會獲得 [StateArg2] 力量。"
  },
  State_49278_Name = {
    Text = "猩紅聖壇"
  },
  State_49430_Desc = {
    Text = "受到的傷害降低，每層降低 1 %。其他友方死亡後移除該狀態。"
  },
  State_49430_Name = {
    Text = "<AberrationColour:隱匿>"
  },
  State_49500_Desc = {
    Text = "每層使攻擊次數加1，受到傷害失去一層，回合結束時失去全部。"
  },
  State_49500_Name = {Text = "祈禱"},
  State_49524_Desc = {
    Text = "回合結束時，回復等同於已損失生命 5% 的生命。每當玩家抽到 1 張狀態卡或症狀卡，所有「努比亞」獲得 [StateArg1] 點臨時力量。"
  },
  State_49526_Desc = {
    Text = "死亡後立刻回復至 [StateArg2] 點生命並免疫傷害 1 回合 ，將意圖調整為「穢亂播撒」。"
  },
  State_49542_Desc = {
    Text = "隊伍唯一：戰鬥開始後，獲得裝備者攻擊力 <WeaponEffect_Num:[StateArg1]%> 的力量，若當前界域為「深海」，還會提高裝備者攻擊力 <WeaponEffect_Num:[StateArg2]%> 的觸腕傷害。"
  },
  State_49542_WeaponDesc = {
    Text = "戰鬥開始後，獲得 <WeaponEffect_Num:[Power:DescArg1]> 點力量，若當前界域為「深海」，還會獲得 <WeaponEffect_Num:[DescArg2]> 點觸腕傷害。"
  },
  State_49546_Desc = {
    Text = "總是和 2 名精英護衛一起出現。自身死亡後它們也會死亡。"
  },
  State_49546_Name = {Text = "列陣"},
  State_49547_Desc = {
    Text = "死亡後，使亞蘭衛隊長獲得 [StateArg1] 點力量，和 50% 最大生命的護盾。"
  },
  State_49547_Name = {Text = "忠誠"},
  State_49558_Desc = {
    Text = "每回合力量提高 [StateArg1] 點。"
  },
  State_49558_Name = {
    Text = "沙之禱祝"
  },
  State_49582_Desc = {
    Text = "本場戰鬥中每回合剩餘的護盾不會移除，將一直保留。"
  },
  State_49582_Name = {
    Text = "護盾永久保留"
  },
  State_49583_Desc = {
    Text = "回合結束時，獲得 [StateArg1] 點護盾，受戒備加成。"
  },
  State_49583_Name = {
    Text = "亞蘭之盾"
  },
  State_49595_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_49595_Name = {
    Text = "尚未覺醒"
  },
  State_49596_Desc = {
    Text = "「空想利刃」已經覺醒，她將獲得更多的護盾及力量。"
  },
  State_49596_Name = {
    Text = "艾爾瓦覺醒！"
  },
  State_49596_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_49597_Name = {
    Text = "本回合已經麻過了__「僅開發用」"
  },
  State_49600_Desc = {
    Text = "虛弱所有敵人 2 回合。"
  },
  State_49600_Name = {
    Text = "恐懼之血"
  },
  State_49601_Desc = {
    Text = "易傷所有敵人 2 回合。"
  },
  State_49601_Name = {
    Text = "潰爛之血"
  },
  State_49602_Desc = {
    Text = "易傷所有敵人 1 回合。"
  },
  State_49602_Name = {
    Text = "潰爛之血"
  },
  State_49605_Desc = {
    Text = "虛弱所有敵人 1 回合。"
  },
  State_49605_Name = {
    Text = "恐懼之血"
  },
  State_49623_Desc = {
    Text = "受到的生命回復降低 [DescArg1]%。回合結束時移除 1 層。"
  },
  State_49623_Name = {
    Text = "<BaseDamageColour:重創>"
  },
  State_49623_WeaponDesc = {
    Text = "造成的所有傷害降低 [DescArg1] %。"
  },
  State_49627_Desc = {
    Text = "初始擁有 2 層<ParcloseIconKeywords:屏障>。死亡時，所有「努比亞」獲得 [StateArg1] 點力量。"
  },
  State_49627_Name = {
    Text = "血脈奔湧"
  },
  State_49628_Desc = {
    Text = "死亡時，所有「努比亞」獲得 [StateArg1] 點力量。"
  },
  State_49628_Name = {
    Text = "血脈連結"
  },
  State_49638_Desc = {
    Text = "識別是否為黑山羊系列怪物的狀態"
  },
  State_49833_Desc = {
    Text = "回合結束時，對所有敵人施加 1 回合「致盲」狀態。若自身護盾被擊破，則取消「致盲」狀態。"
  },
  State_49833_Name = {
    Text = "沙塵壁障"
  },
  State_49844_Desc = {
    Text = "隊伍唯一：回合結束後獲得 <WeaponEffect_Num:[StateArg1]> 點銀鑰能量。觸發死亡抵抗後獲得 <WeaponEffect_Num:[StateArg2]> 點銀鑰能量。使用應急靈知體後，算力上限提高 3，每回合抽牌數提高 3。"
  },
  State_49844_WeaponDesc = {
    Text = "回合結束後獲得 <WeaponEffect_Num:[StateArg1]> 點銀鑰能量。觸發死亡抵抗後獲得 <WeaponEffect_Num:[StateArg2]> 點銀鑰能量。使用應急靈知體後，算力上限提高 3，每回合抽牌數提高 3。"
  },
  State_49877_Desc = {
    Text = "使卡牌算力消耗降低。打出後，每有 1 層畸變，將一張隨機畸變卡牌加入手中，移除該狀態。該狀態在戰鬥結束後會保留。"
  },
  State_49877_Name = {
    Text = "<AberrationKeywords:畸變>"
  },
  State_49877_WeaponDesc = {
    Text = "每層遲緩使卡牌的算力消耗增加 1 點。"
  },
  State_49954_Desc = {
    Text = "所有喚醒體暴擊傷害屬性減半。"
  },
  State_49954_WeaponDesc = {
    Text = "每層遲緩使卡牌的算力消耗增加 1 點。"
  },
  State_49957_Desc = {
    Text = "承受主動傷害時封印攻擊喚醒體的狂氣爆發和所有卡牌 1 回合，移除 1 層<ResentChainsKeywords:怨恨鎖鏈>。回合結束時清空。"
  },
  State_49957_Name = {
    Text = "<ResentChainsKeywords: 怨恨鎖鏈>"
  },
  State_49957_WeaponDesc = {
    Text = "每層遲緩使卡牌的算力消耗增加 1 點。"
  },
  State_49958_Desc = {
    Text = "承受主動和觸腕傷害時，封印攻擊喚醒體的狂氣爆發和所有卡牌 1 回合，移除 1 層<ResentChainsKeywords:怨恨鎖鏈>。"
  },
  State_49958_Name = {
    Text = "<ResentChainsKeywords1:怨恨鎖鏈>"
  },
  State_49959_Desc = {
    Text = "每回合開始時，獲得 1 層<ResentChainsKeywords:怨恨鎖鏈>。"
  },
  State_49959_Name = {
    Text = "多維之鎖"
  },
  State_50010_Desc = {
    Text = "受到的生命回復降低 25%。回合結束時移除 1 層。"
  },
  State_50010_Name = {
    Text = "<HeavyInjuryKeywords:重創>"
  },
  State_50021_Desc = {
    Text = "隊伍唯一：裝備者釋放狂氣爆發後，獲得等同於裝備者攻擊力 <WeaponEffect_Num:[StateArg1]%> 的<PowerIconKeywords:力量>。若當前界域為「血肉」，釋放狂氣爆發後，胚胎融合 <WeaponEffect_Num:+[Blood:StateArg2]> 。"
  },
  State_50021_WeaponDesc = {
    Text = "裝備者釋放狂氣爆發後，獲得 <WeaponEffect_Num:[Power:DescArg1]> 點<PowerIconKeywords:力量>。若當前界域為「血肉」，釋放狂氣爆發後，胚胎融合 <WeaponEffect_Num:+[Blood:StateArg2]> 。"
  },
  State_50302_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：抵抗 1 次致死傷害並摧毀此「命輪」，獲得 [StateArg1] 層<PVPProtectiveKeywords:屏障>，生效時若為唯一生存友方，使下回合開始時獲得 [StateArg2] 張隨機「鑰令」。"
  },
  State_50302_Name = {
    Text = "極夜與破曉"
  },
  State_50323_Desc = {
    Text = "下回合開始前，獲得 [Layer] 張隨機鑰令。"
  },
  State_50323_Name = {
    Text = "延遲鑰令"
  },
  State_50333_Desc = {
    Text = "回合結束時所有喚醒體失去狂氣。"
  },
  State_50333_Name = {
    Text = "<EmptinessKeywords: 空虛>"
  },
  State_50333_WeaponDesc = {
    Text = "每層遲緩使卡牌的算力消耗增加 1 點。"
  },
  State_50352_Name = {
    Text = "泰旖絲試玩"
  },
  State_50353_Name = {
    Text = "泰旖絲試玩"
  },
  State_50358_Desc = {
    Text = "受到的傷害降低，每層降低 1 %。其他友方死亡後移除該狀態。"
  },
  State_50358_Name = {
    Text = "<ConcealmentKeywords:隱匿>"
  },
  State_50375_Desc = {
    Text = "這些效果包括：自身獲得 10 點狂氣、其它友方獲得 5 點狂氣、對全體敵方施加 1 層易傷、對全體敵方施加 1 層虛弱、 抽 1 張牌、獲得 200 點銀鑰能量。"
  },
  State_50389_Desc = {
    Text = "回合開始時，將一張「萊克的幸運骰子」置入手中。"
  },
  State_50389_Name = {
    Text = "萊克的支援"
  },
  State_50390_Desc = {
    Text = "回合開始時，獲得 [StateArg1] 點力量。"
  },
  State_50390_Name = {
    Text = "戰地卓識"
  },
  State_50491_Name = {
    Text = "時靈擺「均衡」"
  },
  State_50735_Desc = {
    Text = "當第一次即將被擊敗時，回復生命並轉變意圖為 「撕裂哀慟」，造成超高額單次傷害。"
  },
  State_50735_Name = {
    Text = "無謂的堅毅"
  },
  State_50854_Desc = {
    Text = "戰鬥開始時，獲得 [StateArg1] 點<RetaliateIconKeywords:反擊>。回合結束後獲得 [StateArg2] 點護盾，每回合這個護盾提高  [StateArg3] 。"
  },
  State_50854_Name = {
    Text = "強韌樹皮"
  },
  State_50861_Desc = {
    Text = "不再受到傷害，準備釋放「萬千子嗣之母」。"
  },
  State_50862_Desc = {
    Text = "不再受到傷害，準備釋放「繁育」。"
  },
  State_50863_Desc = {
    Text = "不再受到傷害，準備釋放「狂野樹漿」。"
  },
  State_50864_Desc = {
    Text = "不再受到傷害，準備釋放「樹漿」。"
  },
  State_50891_Desc = {
    Text = "不再受到傷害，準備釋放「多重融合」。"
  },
  State_51016_Desc = {
    Text = "受到的中毒效果變為 1000%。"
  },
  State_51017_Desc = {
    Text = "受到的中毒效果變為 500%。"
  },
  State_51607_Desc = {
    Text = "免疫一切傷害，回合開始後移除。"
  },
  State_51607_Name = {
    Text = "免疫傷害"
  },
  State_51695_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_51695_Name = {
    Text = "尚未覺醒"
  },
  State_51696_Desc = {
    Text = "「海之使徒」已經覺醒，她對於狂氣爆發有更強的反制。"
  },
  State_51696_Name = {
    Text = "彌利亞姆覺醒！"
  },
  State_51696_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_51739_Desc = {
    Text = "回合結束時隨機獲得 1 張「神國幻影」，無法驅散。"
  },
  State_51739_Name = {
    Text = "信仰的終結"
  },
  State_51740_Desc = {
    Text = "戰鬥開始時，將 1 張「執妄」置入手中。"
  },
  State_51740_Name = {
    Text = "不滅虔誠"
  },
  State_51741_Desc = {
    Text = "回合開始時獲得 [Layer] 點護盾，無法驅散。"
  },
  State_51741_Name = {
    Text = "堅守自我"
  },
  State_51742_Desc = {
    Text = "回合開始時獲得 [Layer] 點觸腕傷害和力量，無法驅散。"
  },
  State_51742_Name = {
    Text = "投身啟示"
  },
  State_51743_Desc = {
    Text = "本回合觸腕每次攻擊時，根據觸腕姿態獲得以下效果：潮湧：所有喚醒體獲得 <Energy:[Energy:StateArg1]> 點狂氣；靜海：對所有敵人造成 [StateArg2] 點<IntoxicationIconKeywords:中毒>；怒濤：臨時<TentacleInjurieIconKeywords:觸腕傷害> +[StateArg3]。"
  },
  State_51743_Name = {
    Text = "母神的祝禱"
  },
  State_51745_Desc = {
    Text = "海之使徒打出 1 張牌時，生成 [StateArg1] 條臨時觸腕，該觸腕可以無視觸腕上限。"
  },
  State_51745_Name = {
    Text = "代行權能"
  },
  State_51745_WeaponDesc = {
    Text = "海之使徒打出 1 張牌時，生成 [StateArg1] 條臨時觸腕，該觸腕可以無視觸腕上限。"
  },
  State_51811_Name = {
    Text = "引舵之帆治療效果__「僅開發用」"
  },
  State_51813_Desc = {
    Text = "回合結束後，算力消耗-[Layer]，被棄掉後也會觸發該效果。"
  },
  State_51813_Name = {
    Text = "<PrepareKeypvewordscolour:預備[Layer]>"
  },
  State_51820_Desc = {
    Text = "「孕育」獲得額外效果：5 層時立刻召喚1名「水之子」，最多存在2名「水之子」。"
  },
  State_51820_Name = {
    Text = "彌利亞姆覺醒"
  },
  State_51822_Desc = {
    Text = "每次釋放狂氣爆發增加 1 層「孕育」，每層孕育獲得 [StateArg1] 點力量，上限為 5 層。"
  },
  State_51822_Name = {
    Text = "利莫里亞的最終降神"
  },
  State_52068_Desc = {
    Text = "將手中最多 3 張「聖禮」轉化為「執妄」，根據轉化的數量獲得不同階段的額外效果。"
  },
  State_52068_Name = {
    Text = "<CardKeyWord:祭儀>"
  },
  State_52087_Desc = {
    Text = "「不死的極樂鳥」在 [Layer] 回合後，才能再次施加可復活狀態。"
  },
  State_52087_Name = {
    Text = "復活冷卻"
  },
  State_52116_Desc = {
    Text = "回合結束之前，該喚醒體使用狂氣爆發後受到 [Layer] 傷害。"
  },
  State_52116_Name = {
    Text = "爆發封鎖"
  },
  State_52369_Desc = {
    Text = "打出 [DescArg1] 張症狀卡後，獲得圖魯的支援卡「王權」：造成大量傷害，並昏迷目標 1 回合。"
  },
  State_52369_Name = {
    Text = "神國必將再臨"
  },
  State_53115_Desc = {
    Text = "本回合彌利亞姆下一次觸發的「祭儀」效果提高 50%。"
  },
  State_53115_Name = {
    Text = "向深淵祝禱"
  },
  State_53144_Desc = {
    Text = "每個回合開始時獲得 <Block:[Block:StateArg1]> 點護盾。"
  },
  State_53144_Name = {
    Text = "<CardKeyWord:堅守自我>"
  },
  State_53145_Desc = {
    Text = "每個回合開始時<PowerIconKeywords:力量>和<TentacleInjurieIconKeywords:觸腕傷害> +[StateArg2]。"
  },
  State_53145_Name = {
    Text = "<CardKeyWord:投身啟示>"
  },
  State_53673_Desc = {
    Text = "腺體分裂的數量最多擁有 10 張。"
  },
  State_53673_Name = {
    Text = "腺體分裂限制"
  },
  State_53674_Desc = {
    Text = "手牌上限 +2。回合開始時，彌利亞姆獲得 20 點狂氣。"
  },
  State_53674_Name = {
    Text = "彌利亞姆試玩"
  },
  State_53755_Desc = {
    Text = "所有喚醒體施加的<PowerIconKeywords:力量>、<RetaliateIconKeywords:反擊>、<IntoxicationIconKeywords:中毒>提高 [DescArg1]%。「紛華篇章」施加的<PowerIconKeywords:力量>提高。"
  },
  State_53755_Name = {
    Text = "詭譎詩篇·懼"
  },
  State_53756_Desc = {
    Text = "所有喚醒體造成的狂氣提高 [DescArg1]%，回合結束時的算力和指令卡可保留至下回合。「紛華篇章」造成的狂氣提高 。"
  },
  State_53756_Name = {
    Text = "幻夢詩篇·喜"
  },
  State_53758_Desc = {
    Text = "所有喚醒體造成的最終傷害提高 [DescArg1]%，「紛華篇章」增加的暴擊率和暴擊傷害提高。"
  },
  State_53758_Name = {
    Text = "狂想詩篇·怒"
  },
  State_53759_Desc = {
    Text = "所有喚醒體造成護盾與回復生命、施加的<PowerIconKeywords:力量>降低效果提高 [DescArg1]%，「紛華篇章」造成回復提高。"
  },
  State_53759_Name = {
    Text = "哀慟詩篇·哀"
  },
  State_53772_Name = {
    Text = "飾品二律背反"
  },
  State_53772_WeaponDesc = {
    Text = "裝備者使用狂氣爆發後，己方基於裝備者防禦力的 100% 獲得<RetaliateIconKeywords:反擊>。並使自身當前<RetaliateIconKeywords:反擊>提高 10%。"
  },
  State_53870_Name = {
    Text = "飾品36室之環"
  },
  State_53870_WeaponDesc = {
    Text = "抽到裝備者的卡牌時，其算力會在 0-3 間隨機變化。"
  },
  State_53981_Name = {
    Text = "飾品入藥之夢黑印修正"
  },
  State_53981_WeaponDesc = {
    Text = "戰鬥開始後，額外將裝備者一套卡牌洗入抽牌堆中。"
  },
  State_54002_Name = {
    Text = "狀態@飾品入藥之夢篩選標記"
  },
  State_54002_WeaponDesc = {
    Text = "裝備者使用狂氣爆發後，己方基於裝備者防禦力的 100% 獲得<RetaliateIconKeywords:反擊>。並使自身當前<RetaliateIconKeywords:反擊>提高 10%。"
  },
  State_54011_Name = {
    Text = "狀態@飾品入藥之夢複製1可用"
  },
  State_54011_WeaponDesc = {
    Text = "裝備者使用狂氣爆發後，己方基於裝備者防禦力的 100% 獲得<RetaliateIconKeywords:反擊>。並使自身當前<RetaliateIconKeywords:反擊>提高 10%。"
  },
  State_54012_Name = {
    Text = "狀態@飾品入藥之夢複製2可用"
  },
  State_54012_WeaponDesc = {
    Text = "裝備者使用狂氣爆發後，己方基於裝備者防禦力的 100% 獲得<RetaliateIconKeywords:反擊>。並使自身當前<RetaliateIconKeywords:反擊>提高 10%。"
  },
  State_54013_Desc = {
    Text = "本回合內界域精通提高 [Layer] 點。"
  },
  State_54013_Name = {
    Text = "臨時界域精通"
  },
  State_54014_Desc = {
    Text = "界域精通提高 [Layer] 點。"
  },
  State_54043_WeaponDesc = {
    Text = "裝備者使用狂氣爆發後，本回合內自身護盾和治療強效翻倍。"
  },
  State_54044_Desc = {
    Text = "造成雙倍傷害並額外獲得 600% 等同於環行拉蒙娜銀鑰充能的銀鑰能量，但打出後<DepleteIconKeywords:消耗>。"
  },
  State_54044_Name = {
    Text = "未來謳歌"
  },
  State_54045_Desc = {
    Text = "獲得 3 點算力。"
  },
  State_54045_Name = {
    Text = "輪回之庭"
  },
  State_54046_Desc = {
    Text = "回合開始時，回復 [StateArg1] 點生命，持續 [Layer] 回合。"
  },
  State_54046_Name = {
    Text = "理性，真理與現實"
  },
  State_54071_Desc = {
    Text = "奧吉爾造成的主動傷害次數 +1，持續 [Layer] 回合。"
  },
  State_54071_Name = {
    Text = "七藝，八美德"
  },
  State_54121_Desc = {
    Text = "本場戰鬥中「混沌之獸」造成的基礎傷害提高 [Layer]%。"
  },
  State_54121_Name = {
    Text = "混沌之獸"
  },
  State_54138_Desc = {
    Text = "索蕾爾下 [Layer] 張打出的指令卡生效 2 次。"
  },
  State_54138_Name = {
    Text = "權欲輪舞"
  },
  State_54384_Desc = {
    Text = "使寧菲亞造成的<IntoxicationIconKeywords:中毒>提高 50%，持續 [Layer] 回合。"
  },
  State_54384_Name = {
    Text = "自我的葬儀"
  },
  State_54416_Desc = {
    Text = "喚醒體最大積攢狂氣翻倍。若狂氣達到雙倍基礎狂氣可釋放超限爆發、釋放狂氣爆發後剩餘狂氣減半。"
  },
  State_54416_Name = {
    Text = "<OverLimitUtlSkillKeywords:超限爆發>"
  },
  State_54416_WeaponDesc = {
    Text = "消耗手牌中的胚胎，觸發強大的吞噬效果。"
  },
  State_54561_Desc = {
    Text = "隊伍唯一：裝備者造成的傷害數值提高裝備者攻擊力的 <WeaponEffect_Num:[StateArg1]%>。若當前界域為「血肉」，裝備者每當觸發了吞噬效果，額外使裝備者造成的傷害數值提高裝備者攻擊力的 3%。"
  },
  State_54561_WeaponDesc = {
    Text = "裝備者造成的傷害提高 [DescArg1] 點。若當前界域為「血肉」，裝備者每當觸發了吞噬效果，額外使裝備者造成的傷害提高 [DescArg2] 點。"
  },
  State_54568_Name = {
    Text = "直至星球終結"
  },
  State_54597_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：敵方喚醒體死亡後，獲得 [StateArg1] <StrongEffectKeywords:強效>，將其算力消耗最高並附帶<PVPVoidKeywords:虛無>的「技能」置入手中。"
  },
  State_54597_Name = {
    Text = "百萬蒙寵之眼"
  },
  State_54704_Desc = {
    Text = "「24」的下一張指令卡生效 3 次。"
  },
  State_54704_Name = {
    Text = "扭曲的死體狂宴"
  },
  State_54798_Desc = {
    Text = "所有喚醒體造成護盾、生命回復、力量降低效果提高 [StateArg1]%，紛華篇章回復效果提高。"
  },
  State_54799_Desc = {
    Text = "所有喚醒體造成反擊、中毒、力量獲取效果提高 [StateArg1]%。紛華篇章的力量提高。"
  },
  State_54799_Name = {Text = "「懼」"},
  State_54800_Desc = {
    Text = "所有喚醒體造成的最終傷害提高 [StateArg1]%，紛華篇章的暴擊率和暴擊傷害提高。"
  },
  State_55108_Desc = {
    Text = "回合開始時將手中的「綠炎」或「腐化綠炎」升級為「死滅綠炎」，持續 [Layer] 回合。"
  },
  State_55108_Name = {
    Text = "死兆降臨"
  },
  State_55108_WeaponDesc = {
    Text = "回合開始時若在手牌或超維空間會得到強化"
  },
  State_55113_Desc = {
    Text = "奧爾拉每回合打出第一張詩篇後，獲得 10 點狂氣。"
  },
  State_55113_Name = {
    Text = "花與詩的重逢"
  },
  State_55465_Name = {
    Text = "消耗 [Layer] 層隱喻「怒」，額外造成 [DescArg1] 次傷害"
  },
  State_55466_Name = {
    Text = "消耗 [Layer] 層隱喻「哀」，回復 <Heal:[Heal:DescArg1]> 點生命"
  },
  State_55467_Name = {
    Text = "消耗 [Layer] 層隱喻「懼」，額外獲得 [Power:DescArg1] 點<PowerIconKeywords:力量>"
  },
  State_55469_Name = {
    Text = "消耗 [Layer] 層隱喻「喜」，額外獲得 <Energy:[Energy:DescArg1]> 點狂氣"
  },
  State_55470_Name = {
    Text = "斷頸一擊"
  },
  State_55485_Desc = {
    Text = "卡茜亞打出的下 [Layer] 張卡牌獲得自身攻擊力 10％ 的力量。"
  },
  State_55485_Name = {
    Text = "縱情歡笑"
  },
  State_55486_Name = {
    Text = "死夢之都超限爆發免除夢引消耗"
  },
  State_55487_Desc = {
    Text = "艾瑞卡的「打擊」額外造成 2 次傷害，「防禦」額外獲得 2 次護盾，持續  [Layer] 回合。"
  },
  State_55487_Name = {
    Text = "多重計算"
  },
  State_55489_Name = {
    Text = "時空折躍"
  },
  State_55806_Name = {
    Text = "<PoetryKeywords:獻詩>：給予全體敵方負面<PVPWonderfulEffectKeywords:奇妙效果> 或 給予全體友方正面<PVPWonderfulEffectKeywords:奇妙效果> 或 抽 1 張牌，獲得 1 算力。最後一次獻詩生效 2 次"
  },
  State_55807_Name = {
    Text = "抽 1 張牌，獲得 1 算力"
  },
  State_55808_Name = {
    Text = "<PoetryKeywords:獻詩>：給予全體友方正面<PVPWonderfulEffectKeywords:奇妙效果> 或 抽 1 張牌，獲得 1 算力。最後一次獻詩生效 2 次"
  },
  State_55809_Name = {
    Text = "給予全體敵方負面<PVPWonderfulEffectKeywords:奇妙效果>"
  },
  State_55811_Desc = {
    Text = "從列出的選項中選擇一項生效。"
  },
  State_55811_Name = {
    Text = "<ComaColour:抉擇>"
  },
  State_55813_Name = {
    Text = "<PoetryKeywords:獻詩>：給予全體敵方負面<PVPWonderfulEffectKeywords:奇妙效果> 或 抽 1 張牌，獲得 1 算力。最後一次獻詩生效 2 次"
  },
  State_55814_Name = {
    Text = "<PoetryKeywords:獻詩>：給予全體敵方負面<PVPWonderfulEffectKeywords:奇妙效果> 或 給予全體友方正面<PVPWonderfulEffectKeywords:奇妙效果> 。最後一次獻詩生效 2 次"
  },
  State_55816_Name = {
    Text = "給予全體友方正面<PVPWonderfulEffectKeywords:奇妙效果>"
  },
  State_55824_Desc = {
    Text = "從列出的選項中選擇一項生效，選擇後移除選擇的選項，若有剩餘選項則將此牌置入對手手牌。"
  },
  State_55824_Name = {
    Text = "<ComaColour:獻詩>"
  },
  State_55836_Desc = {
    Text = "回合結束時，手中奧爾拉的指令卡算力消耗 -1。"
  },
  State_55836_Name = {
    Text = "墨染成詩"
  },
  State_55839_Desc = {
    Text = "拾取時失去所有其他造物，隨機獲得 2 個黃金造物。"
  },
  State_55866_Desc = {
    Text = "隊伍唯一：戰鬥開始時抽 1 張裝備者的指令卡，並有 <WeaponEffect_Num:[StateArg1]%> 的幾率使其算力消耗降低 1。每當觸發死亡抵抗，都會重複觸發 1 次該效果。"
  },
  State_55866_WeaponDesc = {
    Text = "戰鬥開始時抽 1 張裝備者的指令卡，並有 <WeaponEffect_Num:[StateArg1]%> 的幾率使其算力消耗降低 1。每當觸發死亡抵抗，都會重複觸發 1 次該效果。"
  },
  State_55992_Desc = {
    Text = "算力不足時會給卡牌施加消耗和標記。"
  },
  State_55992_Name = {Text = "餘燼"},
  State_55993_Name = {
    Text = "餘燼標記"
  },
  State_56018_Desc = {
    Text = "本場戰鬥中，最大生命值提高 [Layer]%。"
  },
  State_56018_Name = {
    Text = "繆斯的眷顧-命"
  },
  State_56020_Desc = {
    Text = "本場戰鬥中，傷害提高 [Layer]%。"
  },
  State_56020_Name = {
    Text = "繆斯的眷顧-力"
  },
  State_56030_Desc = {
    Text = "本回合喚醒體造成的護盾和治療提高 [Layer]%。"
  },
  State_56031_Desc = {
    Text = "本回合每造成 1 次傷害，臨時暴擊率 +[Layer]%。"
  },
  State_56034_Desc = {
    Text = "每種「隱喻」最多 3 層。不同「隱喻」會增幅詩篇的不同效果：\n<D06CardKeyWordnu:狂想詩篇>：消耗所有隱喻「怒」，每層隱喻額外造成 2 次傷害。\n<D06CardKeyWordai:哀慟詩篇>：消耗所有隱喻「哀」，每層隱喻額外回復生命。\n<D06CardKeyWordxi:幻夢詩篇>：消耗所有隱喻「喜」，每層隱喻額外獲得 10 點狂氣。\n<D06CardKeyWordju:詭譎詩篇>：消耗所有隱喻「懼」，每層隱喻額外獲得<PowerIconKeywords:力量>。"
  },
  State_56034_Name = {Text = "隱喻"},
  State_56208_Desc = {
    Text = "雨頌：回覆 <Heal:[DescArg1]> 點生命。\n風頌：獲得 [DescArg2] 點<PowerIconKeywords:力量>。\n花頌：所有喚醒體獲得 [DescArg3] 點狂氣。\n月頌：臨時暴擊率提高 [DescArg4]%。"
  },
  State_56208_Name = {Text = "詩頁"},
  State_56330_Desc = {
    Text = "獲得 [DescArg1] 點護盾，若本回合內釋放過 3 次狂氣爆發，此卡額外生效 1 次。"
  },
  State_56330_Name = {
    Text = "高級意象"
  },
  State_56331_Desc = {
    Text = "從抽牌堆和棄牌堆選擇 1 張指令卡置入手中，並使其算力消耗 -2。"
  },
  State_56331_Name = {
    Text = "高級意象"
  },
  State_56332_Desc = {
    Text = "獲得 [DescArg1] 點臨時<PowerIconKeywords:力量>。打出後本回合每造成 1 次傷害，臨時暴擊率 +3%。"
  },
  State_56332_Name = {
    Text = "高級意象"
  },
  State_56333_Desc = {
    Text = "回復 10% 已損失生命。若當前生命低於 25%，此卡額外生效 1 次。"
  },
  State_56333_Name = {
    Text = "高級意象"
  },
  State_56334_Desc = {
    Text = "下一個鑰令生效 2 次。"
  },
  State_56334_Name = {
    Text = "高級意象"
  },
  State_56335_Desc = {
    Text = "造成等同於自身最大生命值 150% 的<FixedDamage:純粹傷害>，該傷害享受 10 倍<PowerIconKeywords:力量>加成。"
  },
  State_56335_Name = {
    Text = "高級意象"
  },
  State_56336_Desc = {
    Text = "抽 5 張牌。"
  },
  State_56336_Name = {
    Text = "高級意象"
  },
  State_56337_Desc = {
    Text = "獲得 [DescArg1] 點臨時<AlertIconKeywords:戒備>。打出後本回合造成的護盾和回復提高 [DescArg2]%。"
  },
  State_56337_Name = {
    Text = "高級意象"
  },
  State_56338_Desc = {
    Text = "獲得 3 點算力。"
  },
  State_56338_Name = {
    Text = "高級意象"
  },
  State_56339_Desc = {
    Text = "驅散隨機 1 個負面狀態。此卡額外生效 3 次，消耗。"
  },
  State_56339_Name = {
    Text = "高級意象"
  },
  State_56340_Desc = {
    Text = "對所有敵人施加 3 回合<VulnerabilityIconKeywords:易傷>。每當有敵人死亡時，將此卡從牌堆置入手中。"
  },
  State_56340_Name = {
    Text = "高級意象"
  },
  State_56341_Desc = {
    Text = "界域精通 +25 點，臨時界域精通 +125 點。"
  },
  State_56341_Name = {
    Text = "高級意象"
  },
  State_56342_Desc = {
    Text = "所有喚醒體獲得 15 點狂氣。"
  },
  State_56342_Name = {
    Text = "高級意象"
  },
  State_56343_Desc = {
    Text = "對所有敵人施加 3 回合<WeaknessIconKeywords:虛弱>，將 1 張此卡的複製置入棄牌堆，附加<DepleteIconKeywords:消耗>，<NothingnessIconKeywords:虛無>。"
  },
  State_56343_Name = {
    Text = "高級意象"
  },
  State_56372_Desc = {
    Text = "死亡時清除玩家最後獲得的 1 種負面狀態。"
  },
  State_56372_Name = {Text = "花與詩"},
  State_56400_Desc = {
    Text = "「打擊」後、將手牌中自身的「技能」會按順序變成其他「技能」 [ShowIfState:、 <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]。"
  },
  State_56400_Name = {
    Text = "往昔的花與詩"
  },
  State_56402_Desc = {
    Text = "擁有隱喻<D06CardKeyWordnu:「怒」> [DescArg2] 層：「狂想詩篇」觸發躍遷時將額外造成傷害。\n擁有隱喻<D06CardKeyWordai:「哀」> [DescArg3] 層：「哀慟詩篇」觸發躍遷時將額外回復生命。\n擁有隱喻<D06CardKeyWordxi:「喜」> [DescArg1] 層：「幻夢詩篇」觸發躍遷時將額外使喚醒體獲得狂氣。\n擁有隱喻<D06CardKeyWordju:「懼」> [DescArg4] 層：「詭譎詩篇」觸發躍遷時將額外獲得力量。"
  },
  State_56402_Name = {Text = "隱喻"},
  State_57166_Desc = {
    Text = "喚醒體造成的傷害提高 25%。"
  },
  State_57170_Desc = {
    Text = "手牌上限+2，回合結束時選擇 1 張手牌獲得保留並使其算力消耗 -1，持續 3 回合。"
  },
  State_57316_Desc = {
    Text = "每回合開始時將 1 張「胚胎」轉化為「聖潔之子」，若沒有「胚胎」則<EmbryoFusionIconKeywords:胚胎融合> +[Blood:DescArg1]，不受胚胎融合提高效果影響。持續 [Layer] 回合。"
  },
  State_57316_Name = {
    Text = "永續聖骸的傳承"
  },
  State_57317_Desc = {
    Text = "當此命輪在卡組中時，將可以看到手中的技能即將產生的變化。"
  },
  State_57317_Name = {
    Text = "<PVPFlowerKeywords:往昔的花與詩>"
  },
  State_57324_Desc = {
    Text = "若此喚醒體觸發了「往昔的花與詩」，此牌將變化成 <CardKeyWord:<SkillName1:>> 。"
  },
  State_57324_Name = {
    Text = "往昔的花與詩"
  },
  State_57325_Desc = {
    Text = "若此喚醒體觸發了「往昔的花與詩」，此牌將變化成 <CardKeyWord:<SkillName2:>> 。"
  },
  State_57325_Name = {
    Text = "往昔的花與詩"
  },
  State_57326_Desc = {
    Text = "若此喚醒體觸發了「往昔的花與詩」，此牌將變化成 <CardKeyWord:<SkillName3:>> 。"
  },
  State_57326_Name = {
    Text = "往昔的花與詩"
  },
  State_57335_Name = {
    Text = "此卡傷害額外享受 [DescArg1] 倍力量加成"
  },
  State_57356_Name = {
    Text = "狀態@沉淵者反擊計算"
  },
  State_57368_Name = {
    Text = "狀態@沉淵者反擊跳板"
  },
  State_57413_Name = {
    Text = "每點護盾使此卡傷害提高 [DescArg1] 點"
  },
  State_57417_Desc = {
    Text = "每次觸發死亡抵抗時，造成 100% 反擊的<FixedDamage:純粹傷害>，本場戰鬥中每次觸發死亡抵抗，就使<FixedDamage:純粹傷害>提高 25%。"
  },
  State_57417_Name = {
    Text = "愛之搖籃"
  },
  State_57566_Name = {
    Text = "絕境求生"
  },
  State_57587_Desc = {
    Text = "打出「腺體分裂」時抽 1 張牌，剩餘 [Layer] 次。"
  },
  State_57665_Name = {
    Text = "神母的庇護"
  },
  State_57728_Desc = {
    Text = "尤烏哈希的傷害次數提高 1。"
  },
  State_57728_Name = {
    Text = "血湧的饋贈"
  },
  State_57751_Desc = {
    Text = "隊伍唯一：裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>。釋放鑰令後所有喚醒體獲得 <WeaponEffect_Num:[StateArg2]%> 臨時暴擊率和暴擊傷害，但附加最大生命 3% 的獻祭。若當前界域為「深海」，釋放鑰令後還會使觸腕傷害提高裝備者攻擊力的 <WeaponEffect_Num:[StateArg3]%>。"
  },
  State_57751_WeaponDesc = {
    Text = "裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>。釋放鑰令後所有喚醒體獲得 <WeaponEffect_Num:[StateArg2]%> 臨時暴擊率和暴擊傷害，但附加 [DescArg1] 點獻祭。若當前界域為「深海」，釋放鑰令後還會使觸腕傷害提高 [DescArg2] 點。"
  },
  State_57753_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [StateArg1] 層<PVPSleepKeywords:精緻睡眠>。"
  },
  State_57766_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：每回合首次「狂氣爆發」後臨時<StrongEffectKeywords:強效> +[StateArg1]。"
  },
  State_57767_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，扣除 <Energy:[Energy:StateArg1]> 狂氣轉換為<PVPDerivativeCardKeywords_12:「小小心願」>，若轉換失敗則獲得 <Energy:[Energy:StateArg2]> 狂氣。"
  },
  State_57768_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」傷害提高 [StateArg1]%。「狂氣爆發」後恢復自身已損生命的 [StateArg2]%。"
  },
  State_57769_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：打出裝備者的技能卡後，抽 1 張裝備者的技能卡，每回合至多生效 1 次。"
  },
  State_57769_Name = {
    Text = "真理之門"
  },
  State_57770_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」造成的傷害、治療與護盾效果提升 [StateArg1]~[StateArg2]%(目前是  [Layer] %)，<PhantomKeywords:幻影>。"
  },
  State_57770_Name = {
    Text = "命運輪盤賭"
  },
  State_57814_Name = {
    Text = "當此標記存在時，表示正在更換命輪。部分邏輯會需要此標記識別。__「僅開發用」"
  },
  State_57817_Desc = {
    Text = "無法行動，回合結束時層數 - 1，層數耗盡後 <StrongEffectKeywords:強效> +5，無法被驅散，更換命輪將失去精緻睡眠狀態。"
  },
  State_57817_Name = {
    Text = "精緻睡眠"
  },
  State_57854_Desc = {
    Text = "回合開始時獲得 [StateArg1] 點護盾和 [StateArg2] 點觸腕傷害，生成 2 條臨時觸腕，持續 [Layer] 回合。"
  },
  State_57854_Name = {
    Text = "自由誓願"
  },
  State_57854_WeaponDesc = {
    Text = "狀態@深海淑女紅茶與蛋糕"
  },
  State_57864_Name = {
    Text = "刷新力量加成__「僅開發用」"
  },
  State_57942_Desc = {
    Text = "當前融合度 [Layer]%。融合度達到 100% 時，敵人會強制進入下一階段，且釋放更強大的轉階段技能。"
  },
  State_57952_Desc = {
    Text = "力量被降低時，僅會降低 50% 的力量層數。"
  },
  State_57952_Name = {Text = "深潛"},
  State_57953_Desc = {
    Text = "回合結束時，生成 1 條觸腕。覺醒後移除該狀態。"
  },
  State_57955_Desc = {
    Text = "希洛造成的傷害提高 [StateArg1]%，持續 [Layer] 回合。"
  },
  State_57955_Name = {
    Text = "絕境求生·傷害"
  },
  State_57968_Desc = {
    Text = "受到了於麗埃特的影響，每個回合結束後雙子融合度提高 10%，並將 1 張「畸變」洗入抽牌堆。"
  },
  State_57968_Name = {
    Text = "「於麗埃特之詠」"
  },
  State_57970_Name = {
    Text = "神母的庇護"
  },
  State_57976_Desc = {
    Text = "「暗之子」進行強行融合後，對「遺忘的伊始」造成等同於自身當前生命 3 倍的<FixedDamage:純粹傷害>。"
  },
  State_57976_Name = {Text = "犧牲"},
  State_58051_Desc = {
    Text = "暴擊傷害 +[Layer]%。"
  },
  State_58051_Name = {
    Text = "暴擊傷害"
  },
  State_58052_Desc = {
    Text = "探索中每消耗 1 點黑印，就使「肆意豪賭」的基礎傷害提高 0.5%。（已提高 [DescArg1]%）"
  },
  State_58052_Name = {
    Text = "穩賺不賠"
  },
  State_58063_Desc = {
    Text = "喚醒體造成的傷害提高 25%，持續 [Layer] 回合。"
  },
  State_58063_Name = {
    Text = "超越萬古的凝視"
  },
  State_58144_Desc = {
    Text = "本次關卡內暴擊率提高 [Layer] % 。"
  },
  State_58144_Name = {
    Text = "永久暴擊率"
  },
  State_58144_WeaponDesc = {
    Text = "本次關卡內暴擊率提高 [Layer] % 。"
  },
  State_58259_Desc = {
    Text = "隊伍唯一：裝備者暴擊率提高 <WeaponEffect_Num:[StateArg1]%>。裝備者擊殺敵人後獲得 <WeaponEffect_Num:[StateArg2]> 點黑印，在探索中最多觸發 3 次。觸發 3 次後本次探索中裝備者永久提高 <WeaponEffect_Num:[StateArg3]%> 暴擊率。"
  },
  State_58259_WeaponDesc = {
    Text = "裝備者暴擊率提高 <WeaponEffect_Num:[StateArg1]%>。裝備者擊殺敵人後獲得 <WeaponEffect_Num:[DescArg2]> 點黑印，在探索中最多觸發 3 次([DescArg1]/3)。觸發 3 次後本次探索中裝備者永久提高 <WeaponEffect_Num:[StateArg3]%> 暴擊率。"
  },
  State_58297_Desc = {
    Text = "萊克擊殺敵人時獲得 [DescArg3] 黑印，每場探索最多生效 5 次。（[DescArg1]/5）\n通過戰鬥獲取 50/125/250 黑印後，造物上限提高 1，戰鬥結束時選擇一個「混沌的遺贈」加入造物列表。（已獲取 [DescArg2] 點黑印）"
  },
  State_58297_Name = {
    Text = "贏家通吃"
  },
  State_58447_Desc = {
    Text = "包括了以下三個造物：\n「幸運風衣」：所有喚醒體暴擊率提高 10%。所有萊克和骰子的隨機結果不會出現最小值。\n<TentacleInjurieIconKeywords:升級>： 暴擊率提高改為 15%，使隨機結果最大值提高 1。\n「偏方骰子」：每當釋放鑰令後，將 1 張「<C05_yansheng1:偏方骰子>」置入手中。\n<TentacleInjurieIconKeywords:升級>： 改為將 1 張「<C05_yansheng2:閃耀偏方骰子>」置入手中。\n「大嘴紐扣」：回合開始時以及萊克或骰子的隨機效果觸發時，獲得 50 點銀鑰能量和 2% 暴擊傷害，最多獲得 30% 暴擊傷害。\n<TentacleInjurieIconKeywords:升級>： 改為獲得 100 點銀鑰能量和 4% 暴擊傷害，最多獲得 50% 暴擊傷害。"
  },
  State_58447_Name = {
    Text = "<CardKeyWord:混沌的遺贈>"
  },
  State_58490_Desc = {
    Text = "當困意被全部移除時，將封印所有喚醒體和卡牌，並將「沉睡之主」意圖調整為「王權之威」。"
  },
  State_58491_Desc = {
    Text = "每當打出卡牌後移除 1 層「困意」。回合開始時回復到 12 層「困意」。"
  },
  State_58492_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_58492_Name = {
    Text = "尚未覺醒"
  },
  State_58493_Desc = {
    Text = "每當打出卡牌後移除 1 層「困意」。回合開始時回復到 12 層「困意」。"
  },
  State_58947_Desc = {
    Text = "本次關卡內暴擊率提高 [Layer] % 。"
  },
  State_59117_Desc = {
    Text = "暴擊傷害 +[Layer]%。"
  },
  State_59117_Name = {
    Text = "暴擊傷害"
  },
  State_59160_Desc = {
    Text = "造成的所有傷害、治療與護盾效果提高 10 %，無法驅散。"
  },
  State_59160_Name = {
    Text = "<CardKeyWord:強效>"
  },
  State_59161_Desc = {
    Text = "造成的傷害、治療與護盾效果提高 [DescArg1] %，無法驅散。"
  },
  State_59161_Name = {Text = "強效"},
  State_59169_Desc = {
    Text = "此牌基礎算力消耗不會大於算力上限。__「僅開發用」"
  },
  State_59169_Name = {
    Text = "均衡__「僅開發用」"
  },
  State_59173_Name = {
    Text = "當此標記存在時，表示正在進行多重打擊，不會再次觸發多重打擊。__「僅開發用」"
  },
  State_59208_Desc = {
    Text = "造成的所有傷害、治療與護盾效果降低 10 %，無法驅散。"
  },
  State_59208_Name = {
    Text = "<WeaknessColour:強效降低>"
  },
  State_59209_Desc = {
    Text = "造成的傷害、治療與護盾效果降低 [DescArg1] %，無法驅散。"
  },
  State_59209_Name = {
    Text = "強效降低"
  },
  State_59423_Desc = {
    Text = "萊克擊殺敵人時獲得 5 黑印，萊克每有 1% 黑印掉落就使獲得量提高 1%，每場探索最多生效 5 次。\n通過戰鬥獲取 50/125/250 黑印後，造物上限提高 1，戰鬥結束時選擇一個「混沌的遺贈」加入造物列表。"
  },
  State_59423_Name = {
    Text = "贏家通吃"
  },
  State_59424_Desc = {
    Text = "探索中每消耗 1 點黑印，就使「肆意豪賭」的基礎傷害提高 0.5%。"
  },
  State_59424_Name = {
    Text = "穩賺不賠"
  },
  State_59439_Desc = {
    Text = "此狀態用的是易傷乘區，假裝是個獨立乘區。__「僅開發用」"
  },
  State_59439_Name = {
    Text = "若擁有某狀態則受到傷害翻倍__「僅開發用」"
  },
  State_59519_Name = {
    Text = "選擇 1 張抽牌堆或棄牌堆的指令卡置入手中，使其算力消耗變為 0"
  },
  State_59520_Desc = {
    Text = "打出後抽 2 張牌，使它們算力消耗降低刻印卡牌的實際算力消耗，每場戰鬥僅生效 1 次。"
  },
  State_59520_Name = {
    Text = "<WhiteQuality:智識之理>"
  },
  State_59521_Name = {
    Text = "失去 10% 當前生命([DescArg1])"
  },
  State_59522_Desc = {
    Text = "打出後棄掉所有該喚醒體以外的卡牌，獲得 5 張隨機非喚醒體卡牌，每場戰鬥僅生效 1 次。"
  },
  State_59522_Name = {
    Text = "<WhiteQuality:歡愉之理>"
  },
  State_59525_Name = {
    Text = "指令卡對應的喚醒體獲得 50 點狂氣"
  },
  State_59526_Desc = {
    Text = "打出後獲得 3 張附加<RetainIconKeywords:保留>和<DepleteIconKeywords:消耗>的原始複製，每場戰鬥僅生效 1 次。"
  },
  State_59534_Name = {
    Text = "當此標記存在時，表示此牌禁止觸發幻影。__「僅開發用」"
  },
  State_59560_Name = {
    Text = "選擇一張獲得過三大質體刻印的卡牌加入手中"
  },
  State_59671_Desc = {
    Text = "本回合所有喚醒體最終傷害提高 15%。"
  },
  State_59671_Name = {
    Text = "超弦懷錶"
  },
  State_59678_Desc = {
    Text = "拾取時失去所有其他造物，隨機獲得 2 個黃金造物。"
  },
  State_59878_Desc = {
    Text = "回合結束時，額外減少 1 層「混沌」並獲得 [StateArg1] <PowerIconKeywords:力量>。後續召喚的「N」的分身血量提高 200%，死亡後不再使「N」減少「混沌」層數與獲取<PowerIconKeywords:力量>。"
  },
  State_59878_Name = {
    Text = "混沌降臨"
  },
  State_59991_Name = {
    Text = "，此牌打出時最多消耗 5 層<EnergyStorageKeywords:蓄力>"
  },
  State_59993_Name = {
    Text = "回復 10% 已損失生命([DescArg1])"
  },
  State_60000_Desc = {
    Text = "每當承受主動傷害時，獲得 1 層臨時<MadnessIconKeywords:瘋狂>。"
  },
  State_60000_Name = {Text = "積怒"},
  State_60028_Desc = {
    Text = "玩家回合開始時，隨機使其一張手牌算力消耗在本回合中變化為 3。死亡後該效果失效，並使擊殺者所有卡牌算力消耗本回合降低 1。"
  },
  State_60028_Name = {
    Text = "譫妄樊籠"
  },
  State_60044_Name = {
    Text = "使用 [Layer] 次後消耗"
  },
  State_60083_Desc = {
    Text = "本回合承受的傷害降低 [Layer] %。"
  },
  State_60083_WeaponDesc = {
    Text = "造成的所有傷害降低 [DescArg1] %。"
  },
  State_60085_Desc = {
    Text = "戰鬥開始和回合開始時獲得臨時加固，玩家生命越高獲得越多層數，最大為 50 層。"
  },
  State_60085_Name = {
    Text = "終極蛹化"
  },
  State_60085_WeaponDesc = {
    Text = "造成的所有傷害降低 [DescArg1] %。"
  },
  State_60086_Desc = {
    Text = "戰鬥開始和回合開始時獲得臨時加固，玩家生命越高獲得越多層數，最大為 25 層。"
  },
  State_60086_WeaponDesc = {
    Text = "造成的所有傷害降低 [DescArg1] %。"
  },
  State_60087_Desc = {
    Text = "造成的重創效果變為降低 [Layer]% 生命回復。"
  },
  State_60087_Name = {
    Text = "<Rune_14_High:重創加深>"
  },
  State_60087_WeaponDesc = {
    Text = "造成的所有傷害降低 [DescArg1] %。"
  },
  State_60088_Desc = {
    Text = "每層使承受的所有傷害降低 1%。"
  },
  State_60088_WeaponDesc = {
    Text = "獲得的所有護盾降低 25 %。"
  },
  State_60089_Desc = {
    Text = "承受的所有傷害降低 [Layer] %。"
  },
  State_60089_WeaponDesc = {
    Text = "造成的所有傷害降低 [DescArg1] %。"
  },
  State_60106_Desc = {
    Text = "回合開始後，隨機其一張手牌算力消耗變化為 3，回合結束時恢復。"
  },
  State_60106_Name = {
    Text = "譫妄樊籠"
  },
  State_60112_Desc = {
    Text = "本回合內每打出一張指令卡，就使所有喚醒體獲得 1 點狂氣。"
  },
  State_60112_Name = {Text = "協奏曲"},
  State_60115_Desc = {
    Text = "本回合釋放狂氣爆發後，降低雙子融合度 3%。"
  },
  State_60118_Desc = {
    Text = "本回合造成的傷害、中毒、反擊提高 [Layer]%。"
  },
  State_60128_Desc = {
    Text = "打出前改變卡牌算力"
  },
  State_60128_WeaponDesc = {
    Text = "打出前改變卡牌算力"
  },
  State_60129_Desc = {
    Text = "你打出的下 [Layer] 張非衍生指令卡算力消耗-2。"
  },
  State_60130_Desc = {
    Text = "你打出的下 [Layer] 張非衍生指令卡算力消耗+2，生效 2 次。"
  },
  State_60148_Desc = {
    Text = "回合結束時根據狀態獲得不同效果：放-獲得 1 層臨時<MadnessIconKeywords:瘋狂>。斂-獲得 50 層臨時<ReinforcePVEKeywords:加固>。"
  },
  State_60148_Name = {
    Text = "參數擬合"
  },
  State_60150_Desc = {
    Text = "每當感知到玩家釋放鑰令後，立刻在放和斂兩個形態間切換。切換至放時，立刻獲得[StateArg1] 點臨時力量。切換至斂時，立刻獲得 [StateArg2] 點護盾。"
  },
  State_60150_Name = {
    Text = "機能感應"
  },
  State_60151_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_60151_Name = {
    Text = "尚未覺醒"
  },
  State_60154_Desc = {
    Text = "當前為形態-斂。機械武裝將獲得護盾和戒備，且意圖會以防禦為主。"
  },
  State_60154_Name = {
    Text = "機械武裝-斂"
  },
  State_60155_Desc = {
    Text = "當前為形態-放。機械武裝將獲得力量，且意圖會以攻擊為主。"
  },
  State_60155_Name = {
    Text = "機械武裝-放"
  },
  State_60167_Desc = {
    Text = "打出前改變卡牌算力"
  },
  State_60167_WeaponDesc = {
    Text = "打出前改變卡牌算力"
  },
  State_60184_Desc = {
    Text = "每當打出卡牌後，「矛盾雙子」都會變化意圖。"
  },
  State_60187_Desc = {
    Text = "對玩家造成的虛弱、脆弱、重創狀態均為 50%。"
  },
  State_60187_Name = {
    Text = "終結即是開始"
  },
  State_60201_Name = {
    Text = "怪物延遲力量"
  },
  State_60263_Desc = {
    Text = "造成的脆弱效果變為降低 [Layer]% 獲得護盾。"
  },
  State_60264_Desc = {
    Text = "造成的出血效果回合結束只會自動移除 50%。"
  },
  State_60265_Desc = {
    Text = "出血效果回合結束只會自動移除 50%。"
  },
  State_60279_Name = {
    Text = "回合結束時此卡將被消耗"
  },
  State_60284_Desc = {
    Text = "戰鬥開始和回合開始時獲得臨時加固，玩家生命越低獲得越多層數，最大為 50 層。"
  },
  State_60284_Name = {
    Text = "不破劍陣"
  },
  State_60284_WeaponDesc = {
    Text = "造成的所有傷害降低 [DescArg1] %。"
  },
  State_60297_Desc = {
    Text = "「@2」以解放之姿現世，生命變為原來的 3 倍。且每回合都會對守密人提出疑問，將一張「回答塔薇」置入手中。"
  },
  State_60297_Name = {
    Text = "真理問詢"
  },
  State_60297_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_60298_Desc = {
    Text = "未知存在的力量仍蟄伏黑池之下，即將被擊敗前將徹底復甦，回復生命並以解放之姿開始戰鬥。"
  },
  State_60298_Name = {Text = "蟄伏"},
  State_60312_Desc = {
    Text = "每回合累計受到 10% 生命的傷害時，獲得 [Layer] 層臨時「加固」。"
  },
  State_60312_Name = {
    Text = "融蝕霧盾"
  },
  State_60315_Desc = {
    Text = "本回合釋放狂氣爆發後，回復已損失生命 5% ([DescArg1])。"
  },
  State_60336_Name = {
    Text = "打出後獲得 1 點算力和抽 1 張牌，但此卡將被消耗"
  },
  State_60339_Name = {
    Text = "本回合打出後獲得 1 點算力和抽 1 張牌，但此卡牌將被消耗"
  },
  State_60367_Desc = {
    Text = "玩家回合開始時，隨機使其一張手牌算力消耗在本回合中變化為 3。死亡後該效果失效，並使擊殺者所有卡牌算力消耗本回合降低 1。"
  },
  State_60367_Name = {
    Text = "譫妄樊籠"
  },
  State_60386_Desc = {
    Text = "效果包括：造成 150% 傷害的出血、造成 75% 傷害的中毒、施加 1 層虛弱、施加 1 層易傷、臨時降低 [DescArg1] 點力量。"
  },
  State_60386_Name = {
    Text = "<MysterydebuffKeywords:奇妙負面效果>"
  },
  State_60404_Desc = {
    Text = "每受到 1 次傷害，獲得 2 層臨時加固。"
  },
  State_60404_Name = {
    Text = "終焉蛻變"
  },
  State_60408_Desc = {
    Text = "每當生命降低至 33% 時(還差 [DescArg1] 點)，本回合將不再受到傷害，釋放「鬼面撕咬」。"
  },
  State_60409_Desc = {
    Text = "每當生命降低至 66% 時(還差 [DescArg1] 點)，本回合將不再受到傷害，釋放「終焉蛻變」。"
  },
  State_60409_Name = {
    Text = "終焉之鏡"
  },
  State_60429_Name = {
    Text = "狀態@喚醒體哈姆林@原初的樂音"
  },
  State_60430_Desc = {
    Text = "打出實際算力消耗和意圖展示一致的卡牌時會將其消耗，並使所有敵人失去 [DescArg1] 點臨時力量。"
  },
  State_60431_Name = {
    Text = "狀態@喚醒體哈姆林@上行音"
  },
  State_60432_Name = {
    Text = "狀態@喚醒體哈姆林@靈魂序曲"
  },
  State_60433_Name = {
    Text = "狀態@喚醒體哈姆林@下行音"
  },
  State_60434_Name = {
    Text = "狀態@喚醒體哈姆林@追憶迴旋曲"
  },
  State_60435_Name = {
    Text = "狀態@喚醒體哈姆林@靈魂序曲計數"
  },
  State_60436_Desc = {
    Text = "造成未被格擋的傷害時，將[StateArg1] 張 「傷口」 洗入抽牌堆。"
  },
  State_60436_Name = {
    Text = "靈魂序曲"
  },
  State_60438_Name = {
    Text = "狀態@喚醒體哈姆林@上行音監聽"
  },
  State_60439_Name = {
    Text = "狀態@喚醒體哈姆林@下行音監聽"
  },
  State_60440_Name = {
    Text = "狀態@喚醒體哈姆林@靈魂序曲監聽"
  },
  State_60441_Name = {
    Text = "狀態@喚醒體哈姆林@追憶迴旋曲監聽"
  },
  State_60442_Name = {
    Text = "狀態@喚醒體哈姆林@原初的樂音監聽"
  },
  State_60486_Desc = {
    Text = "戰鬥開始時，所有喚醒體狂氣減半。"
  },
  State_60487_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，最大生命提高 200%，回復生命並以真正的形態開始戰鬥。"
  },
  State_60487_Name = {
    Text = "尚未覺醒"
  },
  State_60490_Desc = {
    Text = "死亡後所有喚醒體獲得 30 點狂氣。"
  },
  State_60490_Name = {Text = "生之慾"},
  State_60491_Desc = {
    Text = "所有喚醒體造成的狂氣降低 50%。"
  },
  State_60491_Name = {
    Text = "母樹之儀"
  },
  State_60493_Desc = {
    Text = "生命每累計降低 [Layer] 點後，召喚一個擬態喚醒體。若場上擬態喚醒體數量已達 2 個，則使所有擬態喚醒體最大生命提高 50%。"
  },
  State_60500_Desc = {
    Text = "當前若存在擬態喚醒體時，自身獲得 50 層「隱匿」。"
  },
  State_60500_Name = {
    Text = "隱於林中"
  },
  State_60511_Desc = {
    Text = "一定在起始手牌中出現。"
  },
  State_60511_WeaponDesc = {
    Text = "打出後卡牌不會進入棄牌堆，在本場戰鬥中無法再次使用。"
  },
  State_60522_Desc = {
    Text = "造成的脆弱和重創效果提高至 50%。"
  },
  State_60522_Name = {Text = "破滅"},
  State_60523_Desc = {
    Text = "每層使攻擊次數加1，受到傷害失去一層，回合結束時失去全部。"
  },
  State_60523_Name = {Text = "祈禱"},
  State_60524_Desc = {
    Text = "戰鬥開始和回合開始時獲得 [Layer] 層加固，最大為 50 層。"
  },
  State_60524_Name = {Text = "聖化"},
  State_60524_WeaponDesc = {
    Text = "造成的所有傷害降低 [DescArg1] %。"
  },
  State_60527_Desc = {
    Text = "打出後被消耗，但會降低敵人的臨時力量。"
  },
  State_60527_Name = {
    Text = "<CardKeyWord:旋律天國>"
  },
  State_60543_Desc = {
    Text = "回合結束時獲得 10 層「血誓」，「血誓」在受到傷害後會移除 1 層。"
  },
  State_60543_Name = {
    Text = "燈心之火"
  },
  State_60554_Name = {
    Text = "<HuihuanbKeywords:回環樂音>"
  },
  State_60558_Name = {
    Text = "<HuihuanbKeywords:回環樂音>"
  },
  State_60562_Desc = {
    Text = "打出後生效 2 次，改為「蓄勢樂音」"
  },
  State_60562_Name = {
    Text = "<HuihuanaKeywords:回環樂音>"
  },
  State_60564_Desc = {
    Text = "當第一次即將被擊敗時，回復生命並轉變意圖為 「終焉進化」，獲得力量和加固。當第二次即將被擊敗時，回復生命並轉變意圖為 「鬼面撕咬」，造成超高額單次傷害。"
  },
  State_60564_Name = {
    Text = "陰影的惡鬼"
  },
  State_60567_Desc = {
    Text = "打出後哈姆林獲得 3 點狂氣。"
  },
  State_60567_Name = {
    Text = "<XushiAKeywords:蓄勢樂音>"
  },
  State_60568_Name = {
    Text = "<XushiAKeywords:蓄勢樂音>"
  },
  State_60569_Name = {
    Text = "<XushiBKeywords:蓄勢樂音>"
  },
  State_60570_Desc = {
    Text = "打出後哈姆林獲得 3 點狂氣。"
  },
  State_60570_Name = {
    Text = "<XushiBKeywords:蓄勢樂音>"
  },
  State_60571_Name = {
    Text = "<HuihuanaKeywords:回環樂音>"
  },
  State_60576_Desc = {
    Text = "玩家回合開始時，隨機使其一張手牌算力消耗在本回合中變化為 3。死亡後該效果失效，並使擊殺者所有卡牌算力消耗本回合降低 1。"
  },
  State_60576_Name = {
    Text = "譫妄樊籠"
  },
  State_60578_Desc = {
    Text = "受到致命傷害時將會回復 50% 生命，免疫傷害 1 回合，意圖變為「破蛹」。"
  },
  State_60592_Desc = {
    Text = "隊伍唯一：探索開始時，將 1 張「銀鑰曦光」洗入抽牌堆並附加<DestructionKeywords:銷毀>。釋放鑰令後，裝備者暴擊傷害提高 <WeaponEffect_Num:[StateArg1]%>。裝備者造成主動傷害時，獲得等同於裝備者銀鑰充能 <WeaponEffect_Num:[StateArg2]%> 的銀鑰能量和 <WeaponEffect_Num:[StateArg3]%> 臨時暴擊率，每回合最多生效 5 次。"
  },
  State_60592_WeaponDesc = {
    Text = "探索開始時，將 1 張「銀鑰曦光」洗入抽牌堆並附加<DestructionKeywords:銷毀>。釋放鑰令後，裝備者暴擊傷害提高 <WeaponEffect_Num:[StateArg1]%>。裝備者造成主動傷害時，獲得 <WeaponEffect_Num:[DescArg1]> 點銀鑰能量和 <WeaponEffect_Num:[StateArg3]%> 臨時暴擊率，每回合最多生效 5 次。"
  },
  State_60594_Desc = {
    Text = "隊伍唯一：回合結束後，裝備者獲得 5 點狂氣。裝備者釋放狂氣爆發後，本回合打出的下一張裝備者的指令卡暴擊率、暴擊傷害、護盾、回復生命提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_60594_WeaponDesc = {
    Text = "回合結束後，裝備者獲得 5 點狂氣。裝備者釋放狂氣爆發後，本回合打出的下一張裝備者的指令卡暴擊率、暴擊傷害、護盾、回復生命提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_60898_Desc = {
    Text = "承受主動和觸腕傷害時，封印攻擊喚醒體的狂氣爆發和所有卡牌 1 回合，移除 1 層<ResentChainsKeywords:怨恨鎖鏈>。"
  },
  State_60898_Name = {
    Text = "<ResentChainsKeywords1:怨恨鎖鏈>"
  },
  State_60925_Desc = {
    Text = "回合結束時，回復 5% 已損失生命。每當玩家抽到 1 張症狀或狀態卡時，全體友方獲得 [Layer] 點力量。"
  },
  State_60925_Name = {
    Text = "血之提燈"
  },
  State_60926_Desc = {
    Text = "回合結束時若當前生命低於 50%，則獲得 [Layer] 點力量和 [StateArg1] 層屏障。"
  },
  State_60926_Name = {
    Text = "提燈聖壇"
  },
  State_60953_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」前對全體敵方造成 [StateArg1] 層<PVPSlowKeywords:遲緩>。"
  },
  State_60953_Name = {
    Text = "永恆安魂曲"
  },
  State_60962_Desc = {
    Text = "本場戰鬥中，最大生命值提高 [Layer]%。"
  },
  State_60964_Desc = {
    Text = "本場戰鬥中，傷害提高 [Layer]%。"
  },
  State_60964_Name = {
    Text = "傷害提高"
  },
  State_61038_Name = {
    Text = "哈姆林試玩"
  },
  State_61050_Desc = {
    Text = "觸發「樂音」效果或打出 「協樂的交響」後，哈姆林獲得 1% 暴擊率和暴擊傷害(當前已獲得 [DescArg1]% ) 。該效果每觸發 10 次，本場戰鬥「靈魂序曲」和「原初的樂音」傷害次數提高 1，最多提高 3 次。"
  },
  State_61051_Desc = {
    Text = "觸發「樂音」效果或打出 「協樂的交響」後，哈姆林獲得 1% 暴擊率和暴擊傷害。該效果每觸發 10 次，本場戰鬥「靈魂序曲」和「原初的樂音」傷害次數提高 1，最多提高 3 次。"
  },
  State_61056_Desc = {
    Text = "首回合獲得 100 點臨時力量。"
  },
  State_61084_Desc = {
    Text = "本回合打出的下 [Layer] 張卡牌：若算力消耗大於等於 3，獲得 2 點算力，否則抽 2 張牌。"
  },
  State_61084_Name = {
    Text = "第四樂章"
  },
  State_61085_Desc = {
    Text = "算力消耗- 2，打出後生效 2 次，改為「蓄勢樂音」"
  },
  State_61085_Name = {
    Text = "<HuihuanbKeywords:回環樂音>"
  },
  State_61089_Desc = {
    Text = "打出的下 1 張指令卡生效 2 次。"
  },
  State_61089_Name = {
    Text = "樂團指揮棒"
  },
  State_61174_Desc = {
    Text = "無法獲得護盾。"
  },
  State_61174_Name = {
    Text = "餘孽送葬"
  },
  State_61180_Desc = {
    Text = "血鏈·希洛的基礎傷害在本場戰鬥中提高 [DescArg1] %。"
  },
  State_61180_Name = {
    Text = "復仇之刃"
  },
  State_61185_Desc = {
    Text = "會使敵人的技能得到增幅。每當受到傷害時失去一層。"
  },
  State_62213_Desc = {
    Text = "造成的虛弱效果變為降低 [Layer]% 造成的主動和觸腕傷害。"
  },
  State_62213_Name = {
    Text = "<Rune_14_High:虛弱加深>"
  },
  State_62309_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [StateArg1] <StrongEffectKeywords:強效>。每當失去生命後，若當前生命低於 [StateArg2]%，獲得<ReinforceKeywords:加固>和<StrengthenKeywords:強化>。"
  },
  State_62309_Name = {
    Text = "沉入殷紅"
  },
  State_62317_Desc = {
    Text = "免疫一切傷害，回合開始後移除。"
  },
  State_62317_Name = {
    Text = "完全免疫傷害"
  },
  State_62336_Desc = {
    Text = "每打出 3 張卡牌(還剩 [Layer] 張)，抽 1 張卡並隨機凍結手牌中的 1 張指令卡。"
  },
  State_62336_Name = {
    Text = "凜冬之寒"
  },
  State_62337_Desc = {
    Text = "每打出 3 張卡牌(還剩 [Layer] 張)，抽 1 張牌並隨機凍結手牌中的 1 張指令卡。"
  },
  State_62337_Name = {
    Text = "凜冬之寒"
  },
  State_62338_Desc = {
    Text = "此卡不可打出，回合結束時不會丟棄，並使所屬喚醒體獲得 5 點狂氣，所屬喚醒體釋放狂氣爆發後，解除凍結。"
  },
  State_62338_Name = {
    Text = "<CardKeyWord:凍結>"
  },
  State_65332_Desc = {
    Text = "死亡後所有喚醒體獲得 30 點狂氣。"
  },
  State_65342_Desc = {
    Text = "被擊敗後將會復活，額外增加 100% 最大生命並釋放「霜寒徹骨」。"
  },
  State_65346_Desc = {
    Text = "死亡後，凍結手牌堆的 2 張指令卡。"
  },
  State_65358_Desc = {
    Text = "隊伍唯一：裝備者造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。裝備者釋放狂氣爆發前，臨時手牌上限 +1，抽 1 張裝備者的指令卡。若當前界域為 「血肉」，裝備者觸發吞噬時臨時暴擊傷害提高 <WeaponEffect_Num:[StateArg1]%>，每回合最多生效 1 次。"
  },
  State_65358_WeaponDesc = {
    Text = "裝備者造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。裝備者釋放狂氣爆發前，臨時手牌上限 +1，抽 1 張裝備者的指令卡。若當前界域為 「血肉」，裝備者觸發吞噬時臨時暴擊傷害提高 <WeaponEffect_Num:[StateArg1]%>，每回合最多生效 1 次。"
  },
  State_65360_Desc = {
    Text = "隊伍唯一：裝備者造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。戰鬥開始時，裝備者獲得 25 層「冰雪」，裝備者打出卡牌後獲得 2 點狂氣並移除 1 層。「冰雪」被完全移除後，裝備者獲得 <WeaponEffect_Num:[StateArg2]%> 暴擊率。"
  },
  State_65360_WeaponDesc = {
    Text = "裝備者造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。戰鬥開始時，裝備者獲得 25 層「冰雪」，裝備者打出卡牌後獲得 2 點狂氣並移除 1 層。「冰雪」被完全移除後，裝備者獲得 <WeaponEffect_Num:[StateArg2]%> 暴擊率(當前剩餘 [DescArg1] 層冰雪)"
  },
  State_65362_Desc = {
    Text = "每累計受到 [StateArg1] 次主動傷害後（還剩 [Layer]）次，隨機凍結手牌中 1 張指令卡。"
  },
  State_65463_Name = {
    Text = "獲得 5 點黑印"
  },
  State_65490_Desc = {
    Text = "回合結束時獲得 [StateArg1] 層霜盾和  [StateArg2]  點力量。"
  },
  State_65490_Name = {
    Text = "絕對零度"
  },
  State_65497_Name = {
    Text = "血鏈·希洛試玩"
  },
  State_65553_Desc = {
    Text = "回合結束時，根據剩餘手牌數獲得力量，每張獲得 [Layer] 點。"
  },
  State_65553_Name = {
    Text = "冰之鋒刃"
  },
  State_65557_Desc = {
    Text = "受到致命傷害後將回復所有生命，意圖轉化為「真·深空注目」，獲得 80 層臨時加固並移除自身負面狀態和玩家正面狀態。回合結束時，自身移除 20 層加固。"
  },
  State_65557_Name = {
    Text = "亙古混沌"
  },
  State_65558_Desc = {
    Text = "受到致命傷害後意圖轉化為「深空注目」並獲得 80 層臨時加固，回復所有生命，可觸發 [DescArg1] 次。觸發次數用盡後受到致命傷害後會保留 1 點生命，將意圖變為「萬千世界之眼」。回合結束時，自身移除 20 層加固。"
  },
  State_65559_Desc = {
    Text = "全部死亡後託乎瓦波將再度出現。"
  },
  State_65559_Name = {
    Text = "亙古碎屑"
  },
  State_65564_Name = {
    Text = "\n<D05EX_Relic:科考團成員們對希洛的懷疑不斷加深，你必須在敵人逼近前做出選擇，安撫混亂的團隊>"
  },
  State_65565_Name = {
    Text = "\n<D05EX_Relic:無視團員的猜疑，繼續前進>"
  },
  State_65566_Name = {
    Text = "\n<D05EX_Relic:和科考團員解釋情況>"
  },
  State_65567_Name = {
    Text = "\n<D05EX_Relic:約束希洛來進一步保護團員>"
  },
  State_65568_Name = {
    Text = "\n<D05EX_Relic:約束希洛，並使用喚醒體的力量全力保護團員>"
  },
  State_65585_Desc = {
    Text = "此卡牌打出後會回到手牌中、直到回合結束前刻印失效。"
  },
  State_65585_Name = {
    Text = "<CardKeyWord:迴響>"
  },
  State_66305_Desc = {
    Text = "回合結束時，獲得 1 層臨時<ResentChainsKeywords:怨恨鎖鏈>。"
  },
  State_66305_Name = {
    Text = "亙古穿今之鎖"
  },
  State_66306_Desc = {
    Text = "承受主動和觸腕傷害時，封印攻擊喚醒體的狂氣爆發和所有卡牌 1 回合，移除 1 層<ResentChainsKeywords:怨恨鎖鏈>。"
  },
  State_66306_Name = {
    Text = "<ResentChainsKeywords1:怨恨鎖鏈>"
  },
  State_66308_Desc = {
    Text = "受到致命傷害後鎖定生命為 1。"
  },
  State_66308_Name = {
    Text = "亙古混沌"
  },
  State_66311_Desc = {
    Text = "與喚醒體們的記憶從你腦海邊緣湧出，在你腦中扎根、生長。無論你將它們斬斷多少次，無論融蝕將它們傾覆多少次，它們從未離開過。"
  },
  State_66311_Name = {
    Text = "破碎的記憶"
  },
  State_66313_Desc = {
    Text = "每打出 1 張指令卡，棄掉 1 張該喚醒體算力消耗最低的卡牌。"
  },
  State_66313_Name = {
    Text = "無上意志之威壓"
  },
  State_66314_Desc = {
    Text = "免疫一切傷害。"
  },
  State_66314_Name = {
    Text = "完全免疫傷害"
  },
  State_66317_Desc = {
    Text = "與喚醒體們的記憶從你腦海邊緣湧出，在你腦中扎根、生長。無論你將它們斬斷多少次，無論融蝕將它們傾覆多少次，它們從未離開過。每回合開始時回復 1 點算力上限與 2 張手牌上限。"
  },
  State_66317_Name = {
    Text = "記憶碎片"
  },
  State_66325_Desc = {
    Text = "與喚醒體們的記憶從你腦海邊緣湧出，在你腦中扎根、生長。無論你將它們斬斷多少次，無論融蝕將它們傾覆多少次，它們從未離開過。每回合開始時回復 1 點算力上限與 2 張手牌上限。"
  },
  State_66325_Name = {
    Text = "記憶碎片"
  },
  State_66358_Desc = {
    Text = "探索中首次觸發死亡抵抗時，將一張「<DerivativeCardKeywords_39:過往回聲>」置入手中。"
  },
  State_66359_Desc = {
    Text = "隨機產生若干個選項來進行選擇。"
  },
  State_66359_Name = {
    Text = "<FaxianKeywords:發現>"
  },
  State_66360_Desc = {
    Text = "本場戰鬥內暴擊率提高 [Layer] %。"
  },
  State_66360_Name = {Text = "暴擊率"},
  State_66362_Desc = {
    Text = "本場戰鬥內暴擊傷害提高 [Layer] %。"
  },
  State_66362_Name = {
    Text = "暴擊傷害"
  },
  State_66410_Desc = {
    Text = "下 [DescArg1] 張打出的塔薇的指令卡生效 2 次。"
  },
  State_66410_Name = {
    Text = "萬物歸一"
  },
  State_66414_Desc = {
    Text = "在手牌中時，若抽牌堆頂部的卡牌為指令卡，變為其複製。"
  },
  State_66414_Name = {
    Text = "通曉萬物之理"
  },
  State_66454_Desc = {
    Text = "技能卡算力消耗降低「隱匿」層數，最多可堆疊 5 層，受到傷害或打出技能後移除 1 層。"
  },
  State_66454_Name = {Text = "隱匿"},
  State_66456_Desc = {
    Text = "技能卡算力消耗降低「隱匿」層數，最多可堆疊 5 層，受到傷害或打出技能後移除 1 層。"
  },
  State_66456_Name = {
    Text = "<YinniColour:隱匿>"
  },
  State_66465_Desc = {
    Text = "使用狂氣爆發後，受到對應層數的傷害。"
  },
  State_66465_Name = {
    Text = "<PVPfengsuoColour:爆發封鎖>"
  },
  State_66522_Desc = {
    Text = "你每打出的第 8 張牌會生效 2 次。"
  },
  State_66553_Desc = {
    Text = "打出「打擊」與「防禦」後，對應喚醒體獲得 35 狂氣。但是它們的算力消耗+1。"
  },
  State_66553_Name = {
    Text = "殘缺面孔"
  },
  State_66554_Desc = {
    Text = "拾取時，將 1 張<DerivativeCardKeywords_1:「遺影迴響」>置入手中。"
  },
  State_66554_Name = {
    Text = "通訊設備"
  },
  State_66556_Desc = {
    Text = "每當連續打出同一個喚醒體的牌，該喚醒體獲得 8 狂氣。"
  },
  State_66556_Name = {
    Text = "精密計時器"
  },
  State_66557_Desc = {
    Text = "每當你失去生命，就獲得 [DescArg1] 點<PowerIconKeywords:力量>，每場戰鬥最多堆疊 10 次。層數滿時，回復已損失生命值 25% 的生命。"
  },
  State_66557_Name = {
    Text = "無上榮寵"
  },
  State_66558_Desc = {
    Text = "每 3 回合對所有敵人添加 1 層<WeaknessIconKeywords:虛弱>。對<WeaknessIconKeywords:虛弱>敵人造成傷害後獲得  [DescArg1] 點臨時<PowerIconKeywords:力量>，每回合最多觸發 3 次。"
  },
  State_66558_Name = {Text = "惡童"},
  State_66559_Desc = {
    Text = "打出 1 張算力消耗為 3 或以上的卡牌時，抽 1 張牌並獲得 1 點算力。"
  },
  State_66560_Desc = {
    Text = "「打擊」獲得 2 點算力，隨機棄 1 張牌；「防禦」抽 2 張牌，失去 1 點算力。每回合最多觸發 3 次。"
  },
  State_66560_Name = {
    Text = "快樂唱片"
  },
  State_66561_Desc = {
    Text = "每 3 回合對所有敵人添加 1 層<VulnerabilityIconKeywords:易傷>。對<VulnerabilityIconKeywords:易傷>敵人造成傷害後，使其失去 [DescArg1] 點臨時<PowerIconKeywords:力量>，每回合最多觸發 3 次。"
  },
  State_66562_Desc = {
    Text = "每 4 回合使所有敵人本回合受到的傷害翻倍，但在該回合中釋放狂氣爆發後，封印所有喚醒體 1 回合。"
  },
  State_66563_Desc = {
    Text = "回合開始時，如果上個回合打出卡牌數超過 3 張，抽 2 張牌。"
  },
  State_66563_Name = {
    Text = "嶄新的錢包"
  },
  State_66564_Desc = {
    Text = "拾取時，獲得 3 點算力。"
  },
  State_66564_Name = {Text = "懷錶鏡"},
  State_66565_Desc = {
    Text = "拾取時，對所有敵人施加 1 回合<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。"
  },
  State_66565_Name = {
    Text = "變色拘束服"
  },
  State_66566_Desc = {
    Text = "每回合開始時<DeathResistanceIconKeywords:死亡抵抗>提高 10%（本次關卡內每觸發 1 次死亡抵抗，獲得的死亡抵抗減半）。<DeathResistanceIconKeywords:死亡抵抗>在 100% 以上時，<ProficientInRealmsIconKeywords:界域精通>提高 100。"
  },
  State_66566_Name = {
    Text = "人魚淚珠"
  },
  State_66703_Desc = {
    Text = "隊伍唯一：銀鑰積攢上限提高 100%。手牌上限+2，無法和其他命輪提供的手牌上限疊加。裝備者銀鑰充能提高 <WeaponEffect_Num:[StateArg1]%>。裝備者打出卡牌後，本回合裝備者指令卡暴擊率和暴擊傷害、造成的護盾、狂氣和力量獲取效果提高 <WeaponEffect_Num:[StateArg2]%>，至多疊加 5 層。"
  },
  State_66703_WeaponDesc = {
    Text = "銀鑰積攢上限提高 100%。手牌上限+2，無法和其他命輪提供的手牌上限疊加。裝備者銀鑰充能提高 <WeaponEffect_Num:[DescArg2]>。裝備者打出卡牌後，本回合裝備者指令卡暴擊率和暴擊傷害、造成的護盾、狂氣和力量提高 <WeaponEffect_Num:[StateArg2]%>，至多疊加 5 層(當前 [DescArg1] 層)。"
  },
  State_66722_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合開始時，若自身沒有<PVPProtectiveKeywords:屏障>獲得 [StateArg1] 層<PVPProtectiveKeywords:屏障>，否則獲得<StrengthenKeywords:強化>。"
  },
  State_66722_Name = {
    Text = "隱世的轉輪"
  },
  State_66872_Desc = {
    Text = "塔薇造成的傷害、護盾、生命回復臨時提高 [StateArg1]%，持續 [Layer] 回合。"
  },
  State_66872_Name = {
    Text = "無限億萬光輝"
  },
  State_66884_Desc = {
    Text = "回合結束時，算力消耗降低，被棄掉時也會觸發該效果。"
  },
  State_66884_Name = {
    Text = "<PrepareKeypvewords:預備1>"
  },
  State_66888_Desc = {
    Text = "隊伍唯一：釋放鑰令後，獲得裝備者攻擊力 <WeaponEffect_Num:[StateArg1]%> 的<PowerIconKeywords:力量>和防禦力 <WeaponEffect_Num:[StateArg2]%> 的護盾。使用應急靈知體後，回合結束時所有喚醒體獲得 <WeaponEffect_Num:[StateArg3]> 點狂氣。"
  },
  State_66888_Name = {
    Text = "純銀的初心"
  },
  State_66888_WeaponDesc = {
    Text = "釋放鑰令後，獲得 <WeaponEffect_Num:[Power:DescArg1]> 點<PowerIconKeywords:力量>和 <WeaponEffect_Num:[Block:DescArg2]> 點護盾。使用應急靈知體後，回合結束時所有喚醒體獲得 <WeaponEffect_Num:[StateArg3]> 點狂氣。"
  },
  State_66893_Desc = {
    Text = "隊伍唯一：戰鬥開始後，獲得等同於裝備者 <WeaponEffect_Num:[StateArg1]%> 銀鑰充能的銀鑰能量。每場戰鬥首次釋放鑰令後，重複一次該效果。"
  },
  State_66893_WeaponDesc = {
    Text = "戰鬥開始後，獲得 <WeaponEffect_Num:[DescArg1]> 點銀鑰能量。每場戰鬥首次釋放鑰令後，重複一次該效果。"
  },
  State_66896_WeaponDesc = {
    Text = "打出前改變卡牌算力"
  },
  State_66900_Desc = {
    Text = "此卡牌傷害、治療、護盾提高 [StateArg1]%"
  },
  State_66900_Name = {
    Text = "純銀的初心"
  },
  State_66901_Desc = {
    Text = "造成的傷害、治療與護盾效果提高 [DescArg1] %，持續 1 回合"
  },
  State_66901_Name = {
    Text = "臨時強效"
  },
  State_66902_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：其他友方喚醒體死亡後，獲得 <Block:[Block:StateArg1]> 護盾，將其算力消耗最低的「技能」置入手中。"
  },
  State_66902_Name = {
    Text = "純銀的初心"
  },
  State_66971_Desc = {
    Text = "當生命降低至 0 時，使生命變為 1 點，不再受到傷害。"
  },
  State_66971_Name = {
    Text = "世界斷絕"
  },
  State_67234_Desc = {
    Text = "回合結束時，召喚一名「缸中之腦分體」，持續 [Layer] 回合。"
  },
  State_67234_Name = {Text = "分離"},
  State_67235_Desc = {
    Text = "死亡時回復所有生命，生命上限+100%，釋放「靈魂瘟疫」。"
  },
  State_67235_Name = {
    Text = "尚未覺醒"
  },
  State_67237_Desc = {
    Text = "達到 10 層時，意圖改變為「虛無終結」：將對手的生命上限變為 1 。"
  },
  State_67237_Name = {Text = "終末"},
  State_67238_Desc = {
    Text = "回合結束時，獲得 1 層「終末」。受到致死傷害後移除該狀態並免疫 1 回合傷害，回復 15% 生命並獲得 10 層「終末」。"
  },
  State_67238_Name = {
    Text = "靈魂瘟疫"
  },
  State_67240_Desc = {
    Text = "「知者」獲得 25 層臨時<ReinforcePVEKeywords:加固>和 [Power:StateArg1] 點臨時<PowerIconKeywords:力量> ，移除該狀態。"
  },
  State_67241_Desc = {
    Text = "死亡時回復所有生命，生命上限+100%，釋放「騎士熱誠」。"
  },
  State_67241_Name = {
    Text = "尚未覺醒"
  },
  State_67242_Desc = {
    Text = "死亡時回復所有生命，生命上限+100%，釋放「靈肉@1分」。"
  },
  State_67242_Name = {
    Text = "尚未覺醒"
  },
  State_67243_Desc = {
    Text = "回合結束時，召喚一名「缸中之腦分體」。缸中之腦分體觸發「靈質分離」時，額外偷取玩家 5% 的力量。"
  },
  State_67243_Name = {
    Text = "靈肉@1分"
  },
  State_67245_Desc = {
    Text = "回合結束時，獲得 [StateArg1] 點<PowerIconKeywords:力量>。"
  },
  State_67245_Name = {
    Text = "騎士熱誠"
  },
  State_67246_Desc = {
    Text = "每回合首次被擊破護盾時，失去 25％最大生命，獲得 [Power:DescArg1] 點<PowerIconKeywords:臨時力量>和 [Layer] 層臨時加固。下回合開始時，重新獲得 <Block:[Block:DescArg2]> 層護盾，每觸發一次「騎士的信仰」額外獲得 1 次護盾。"
  },
  State_67246_Name = {
    Text = "騎士的信仰"
  },
  State_67247_Desc = {
    Text = "每回合結束時都會補充敵人，至多同時存在 2 個敵人。敵人死亡後，「腐壞之腦」失去 5% 最大生命。"
  },
  State_67247_Name = {
    Text = "深淵之門"
  },
  State_67252_Desc = {
    Text = "受到致命傷害時，移動到後排並保留 1 點生命，之後無法再次受到任何傷害，<PowerIconKeywords:力量>提高 [DescArg1] 。自爆不會觸發該效果。"
  },
  State_67252_Name = {
    Text = "靈質分離"
  },
  State_67253_Desc = {
    Text = "打出 [Layer] 張卡牌後，在前方生成 1 名「缸中之腦分體」，最多同時存在 3 個分體。"
  },
  State_67253_Name = {
    Text = "缸中之腦"
  },
  State_67255_Desc = {
    Text = "死亡時回復所有生命，生命上限+100%，釋放「第一哲學」。"
  },
  State_67255_Name = {
    Text = "尚未覺醒"
  },
  State_67256_Desc = {
    Text = "抽牌階段後，從手牌中隨機展示三張指令卡，選擇一張賦予「回聲」刻印，棄掉其它卡牌。"
  },
  State_67256_Name = {
    Text = "第一哲學"
  },
  State_67257_Desc = {
    Text = "每回合首次釋放鑰令後，所有喚醒體獲得 10 狂氣，但釋放鑰令消耗永久提高 10%。"
  },
  State_67257_Name = {
    Text = "逐漸斷裂的連結"
  },
  State_67258_Desc = {
    Text = "戰鬥開始時，獲得 <Block:[Block:DescArg1]> 層護盾。回合結束時，護盾不會消失。"
  },
  State_67258_Name = {
    Text = "騎士的決心"
  },
  State_67347_Desc = {
    Text = "在手牌中時，若抽牌堆頂部的卡牌為指令卡，變為其算力消耗-1 的複製。"
  },
  State_67347_Name = {
    Text = "通曉萬物之理"
  },
  State_67353_Desc = {
    Text = "死亡後「腐壞之腦」失去 5% 最大生命。"
  },
  State_67353_Name = {Text = "熔燬"},
  State_67358_Desc = {
    Text = "每當玩家消耗 1 點算力，立刻獲得 <Block:[Block:StateArg1]> 點護盾和 3 層臨時加固。"
  },
  State_67358_Name = {
    Text = "不定壁壘"
  },
  State_67414_Desc = {
    Text = "不可直視的眼目。不可違逆的氣息。做到一切的碎片也只是碎片。現在，迎接註定毀滅的結局吧……"
  },
  State_67414_Name = {
    Text = "直面萬千本源"
  },
  State_67418_Desc = {
    Text = "打出後棄掉所有該喚醒體以外的卡牌，獲得 5 張隨機非喚醒體卡牌，每場戰鬥僅生效 1 次。"
  },
  State_67418_Name = {
    Text = "<WhiteQuality:高級歡愉之理>"
  },
  State_67419_Desc = {
    Text = "打出後獲得 3 張附加<RetainIconKeywords:保留>和<DepleteIconKeywords:消耗>的原始複製並使它們算力消耗-1，每場戰鬥僅生效 1 次。"
  },
  State_67419_Name = {
    Text = "<WhiteQuality:高級繁育之理>"
  },
  State_67420_Desc = {
    Text = "打出後抽 4 張牌，使它們算力消耗降低刻印卡牌的實際算力消耗，每場戰鬥僅生效 1 次。"
  },
  State_67420_Name = {
    Text = "<WhiteQuality:高級智識之理>"
  },
  State_67598_Desc = {
    Text = "釋放狂氣爆發後，將一張對應喚醒體的隨機卡牌置入手中，該卡牌獲得<DepleteIconKeywords:消耗>與<NothingnessIconKeywords:虛無>。戰鬥結束後，回復 [DescArg1] 點生命。"
  },
  State_67598_Name = {
    Text = "醫生手提箱"
  },
  State_67599_Desc = {
    Text = "非「打擊」「防禦」的指令卡打出後，對應喚醒體獲得 15 點狂氣，每回合最多觸發 5 次。每回合第 1 次觸發時，還會將打出的卡牌移回手中。"
  },
  State_67599_Name = {
    Text = "時靈擺·投射"
  },
  State_67600_Desc = {
    Text = "最大算力提高 4，每次重置牌庫時將 4 張<DerivativeCardKeywords_4:「靈感」>加入抽牌堆。"
  },
  State_67600_Name = {
    Text = "受祝·黑燭"
  },
  State_67602_Name = {Text = "廢棄"},
  State_67603_Desc = {
    Text = "對處於負面狀態的敵人造成的傷害提高 20%，擊殺敵人後擊殺者獲得 20 狂氣。"
  },
  State_67603_Name = {
    Text = "祭司權杖"
  },
  State_67604_Desc = {
    Text = "每打出一張與上一張所屬喚醒體不同的指令卡，其所屬喚醒體獲得 3 點狂氣，並積攢 1 層「活性」。積攢 10 層時將所有「活性」清空，將所有喚醒體各一張算力消耗減1且具備「消耗」的隨機指令卡置入手中，每回合最多生效 1 次。"
  },
  State_67604_Name = {
    Text = "時靈擺·衍化"
  },
  State_67605_Desc = {
    Text = "當你擁有護盾時，該造物提供 [DescArg1] 點臨時<PowerIconKeywords:力量>。在你的護盾高於當前生命時，額外提供 [DescArg2] 點臨時<PowerIconKeywords:力量>。"
  },
  State_67605_Name = {Text = "鴿羽扇"},
  State_67606_Desc = {
    Text = "回合開始時每有 1 名敵人就獲得 1 算力。主動傷害擊殺敵人時，對其他敵人造成等同於過量傷害的<BleedingIconKeywords:出血>。"
  },
  State_67607_Desc = {
    Text = "每釋放 5 次狂氣爆發後，使釋放狂氣爆發的喚醒體獲得 100 狂氣。"
  },
  State_67608_Name = {Text = "廢棄"},
  State_67609_Desc = {
    Text = "釋放狂氣爆發後，失去 8% 當前生命，偷取所有敵人 [DescArg1] 點臨時<PowerIconKeywords:力量>，若只有 1 名敵人，額外偷取 [DescArg2] 點臨時<PowerIconKeywords:力量>。"
  },
  State_67609_Name = {
    Text = "厄運儀式鳥"
  },
  State_67611_Desc = {
    Text = "每 2 回合使所有敵人受到的傷害翻倍，在本回合每釋放 1 次狂氣爆發，隨機驅散 1 種負面狀態。"
  },
  State_67612_Desc = {
    Text = "所有「打擊」造成的暴擊傷害提高 20%。拾取時，將 1 張<DerivativeCardKeywords_40:「美麗瞬間 」>加入手中。"
  },
  State_67612_Name = {
    Text = "美麗瞬間β"
  },
  State_67614_Desc = {
    Text = "每回合開始時所有喚醒體獲得 25 狂氣。拾取時，最大生命變為 1.5 倍。"
  },
  State_67614_Name = {
    Text = "受祝·噩夢表像β"
  },
  State_67615_Desc = {
    Text = "每打出的第 6 張指令卡使其從棄牌堆回到手中。"
  },
  State_67615_Name = {
    Text = "在夕光裡"
  },
  State_67616_Name = {Text = "廢棄"},
  State_67618_Desc = {
    Text = "每回合開始時所有喚醒體獲得 25 狂氣。拾取時最大生命變為 1.5 倍。"
  },
  State_67619_Desc = {
    Text = "手牌上限提高 5。拾取時，補充手牌至上限。回合開始時額外抽 1 張牌，回合結束時棄掉手中所有症狀卡和狀態卡，保留其他卡牌。"
  },
  State_67619_Name = {
    Text = "受祝·意識銘刻β"
  },
  State_67620_Desc = {
    Text = "每回合打出第 3 張卡牌後，將 1 張<DerivativeCardKeywords_4:「靈感」>置入棄牌堆。每回合打出第 6 張卡牌後，從棄牌堆中將 1 張<DerivativeCardKeywords_4:「靈感」>置入手牌。"
  },
  State_67621_Desc = {
    Text = "釋放狂氣爆發後，獲得 [DescArg1] 點臨時力量，並偷取所有敵人 [DescArg1] 點臨時<PowerIconKeywords:力量>，若只有 1 名敵人，額外偷取 [DescArg2] 點臨時<PowerIconKeywords:力量>。"
  },
  State_67621_Name = {
    Text = "受祝·厄運儀式鳥"
  },
  State_67622_Desc = {
    Text = "耗盡最後 1 點算力時，獲得 2 算力。每回合最多觸發 2 次。"
  },
  State_67622_Name = {
    Text = "銀白差分機"
  },
  State_67623_Desc = {
    Text = "拾取後永久獲得 [DescArg1] <PowerIconKeywords:力量> 。每當造成傷害時，回復 [DescArg2] 點生命，每回合最多觸發 6 次。"
  },
  State_67623_Name = {
    Text = "受祝·七鰓鰻之吻"
  },
  State_67624_Name = {Text = "廢棄"},
  State_67625_Desc = {
    Text = "每回合首次打出指令卡進入棄牌堆後，將算力消耗降低 1 的該卡牌臨時複製洗入抽牌堆。"
  },
  State_67625_Name = {
    Text = "失聲唱機"
  },
  State_67626_Desc = {
    Text = "最大算力提高 1 。連續 2 次打出比上一張算力消耗更高的卡牌時，獲得 1 算力。"
  },
  State_67626_Name = {
    Text = "阿爾卡納記錄"
  },
  State_67628_Name = {Text = "廢棄"},
  State_67630_Name = {Text = "廢棄"},
  State_67631_Desc = {
    Text = "最大算力提高 2。每次重置牌庫時將 1 張<DerivativeCardKeywords_9:「蹣跚」>加入抽牌堆。"
  },
  State_67631_Name = {Text = "黑燭"},
  State_67632_Name = {Text = "廢棄"},
  State_67634_Desc = {
    Text = "回合結束時手中每有 1 張未打出的卡牌，就使所有喚醒體獲得 2 狂氣。"
  },
  State_67635_Desc = {
    Text = "拾取時，所有喚醒體獲得 50 點狂氣，將 2 張<DerivativeCardKeywords_1:「遺影迴響」>洗入抽牌堆。"
  },
  State_67635_Name = {
    Text = "通訊設備+β"
  },
  State_67636_Desc = {
    Text = "暴擊傷害提高 15%。對有護盾的敵方造成的傷害必然暴擊。"
  },
  State_67636_Name = {
    Text = "美學原理"
  },
  State_67637_Desc = {
    Text = "回合開始時抽 2 張牌，獲得 2 點算力。每當你抽到 1 張指令卡或靈知覺醒時，隨機變化其算力消耗。（0-4）"
  },
  State_67637_Name = {
    Text = "詭術禮帽"
  },
  State_67638_Desc = {
    Text = "對處於負面狀態的敵人造成的傷害提高 50%，擊殺敵人後擊殺者獲得 100 狂氣。"
  },
  State_67638_Name = {
    Text = "祭司權杖+"
  },
  State_67639_Desc = {
    Text = "暴擊率提高 50%，暴擊傷害提高 100%。"
  },
  State_67639_Name = {
    Text = "受祝·古怪鉤爪"
  },
  State_67640_Desc = {
    Text = "暴擊率、暴擊傷害提高100%。每造成 1 次傷害/觸腕傷害，本回合：所有喚醒體暴擊暴傷降低 10%，至多降低 50%。造成的中毒和反擊提高 10%，至多提高 50%。"
  },
  State_67640_Name = {
    Text = "時靈擺·移湧"
  },
  State_67641_Desc = {
    Text = "釋放狂氣爆發後，獲得 [DescArg1] 點臨時<PowerIconKeywords:力量>。"
  },
  State_67641_Name = {Text = "重鎖"},
  State_67643_Desc = {
    Text = "造成主動傷害時獲得 [DescArg1] 點護盾。回復生命時，獲得 [DescArg2] 點臨時<PowerIconKeywords:力量>。"
  },
  State_67643_Name = {
    Text = "我們的家"
  },
  State_67645_Desc = {
    Text = "暴擊率提高 10%。每回合首次暴擊後使暴擊率額外提高 20%，每回合造成第 3 次暴擊後使暴擊傷害額外提高 50%。"
  },
  State_67645_Name = {
    Text = "節日祝福"
  },
  State_67646_Desc = {
    Text = "奇數回合結束時，若有剩餘算力，下回合額外抽 2 張牌；偶數回合結束時，若有剩餘手牌，下回合額外獲得 2 算力。"
  },
  State_67646_Name = {
    Text = "日月輪盤"
  },
  State_67647_Desc = {
    Text = "你每打出的第 5 張指令卡會生效 2 次，打出後回到手中。"
  },
  State_67649_Desc = {
    Text = "隱藏怪物意圖。每回合獲得 1 點算力，抽 1 張牌。"
  },
  State_67649_Name = {
    Text = "蠱惑風鈴"
  },
  State_67650_Desc = {
    Text = "「打擊」和 「防禦」額外獲得 50 點銀鑰能量。每當你打出 1 張算力消耗為 2 或以上的卡牌，抽 1 張算力消耗為 1 的牌並使其算力消耗變為 0，每回合最多生效 3 次。"
  },
  State_67650_Name = {
    Text = "時靈擺·雙生"
  },
  State_67651_Desc = {
    Text = "拾取時隊伍界域精通變為原始值的 150%。每回合打出第 5 張指令卡後，所有喚醒體獲得 20 狂氣。"
  },
  State_67651_Name = {
    Text = "時靈擺·不潔"
  },
  State_67653_Desc = {
    Text = "每回合釋放狂氣爆發 2 次後，所有喚醒體獲得 8 點狂氣，釋放 3 次後，所有喚醒體再獲得 8 點狂氣。"
  },
  State_67653_Name = {
    Text = "被遺忘者之血"
  },
  State_67654_Name = {
    Text = "額外生效 [DescArg1] 次"
  },
  State_67656_Desc = {
    Text = "暴擊率提高 50%，<FragileIconKeywords:脆弱>自身 3 回合。"
  },
  State_67656_Name = {
    Text = "古怪鉤爪"
  },
  State_67657_Desc = {
    Text = "回合開始時抽 1 張牌。連續 2 次打出和上一張卡牌算力相同的牌時，額外抽 1 張牌，每回合最多生效 3 次。"
  },
  State_67657_Name = {
    Text = "萬象靈知秘儀"
  },
  State_67658_Desc = {
    Text = "打出 1 張實際算力消耗為 3 的卡牌時，抽 1 張牌並獲得 2 算力；打出 1 張實際算力消耗為 4 或以上的卡牌時，其他手牌算力消耗降低 1。"
  },
  State_67658_Name = {
    Text = "時靈擺·眼"
  },
  State_67659_Desc = {
    Text = "回合開始時每有 1 名敵人就獲得 2 算力。主動傷害擊殺敵人時，對其他敵人造成雙倍過量傷害的<BleedingIconKeywords:出血>。"
  },
  State_67660_Desc = {
    Text = "每第 3 次打出「打擊」後，對全體敵方造成 [DescArg1] 點傷害，對應喚醒體獲得 15 狂氣。"
  },
  State_67660_Name = {
    Text = "銹蝕柳葉刀"
  },
  State_67661_Desc = {
    Text = "每次消耗算力時，抽 1 張牌，每回合至多生效 5 次。每當牌庫重置時，獲得 2 點算力。"
  },
  State_67661_Name = {
    Text = "時靈擺·不眠"
  },
  State_67662_Desc = {
    Text = "每當你打出一張非喚醒體的卡牌時，狂氣最低的喚醒體獲得 10 狂氣。"
  },
  State_67662_Name = {
    Text = "異鄉郵票夾"
  },
  State_67665_Desc = {
    Text = "最大算力提高 2。打出「打擊」或「防禦」後，對應喚醒體獲得 5 狂氣。釋放狂氣爆發後，獲得 1 張對應喚醒體附帶消耗虛無的「打擊」，釋放鑰令後，隨機獲得 1 張附帶消耗虛無的「防禦」。"
  },
  State_67665_Name = {
    Text = "時靈擺·羽翼"
  },
  State_67666_Desc = {
    Text = "每次造成傷害時，獲得 [DescArg1] 點臨時<PowerIconKeywords:力量>，最多堆疊 3 次。層數滿時效果翻倍。"
  },
  State_67666_Name = {
    Text = "纏絲瑪瑙"
  },
  State_67667_Desc = {
    Text = "回合結束後所有喚醒體獲得 5 狂氣。每剩餘 1 點算力，所有喚醒體就額外獲得 3 狂氣。"
  },
  State_67667_Name = {
    Text = "原型電池"
  },
  State_67668_Desc = {
    Text = "暴擊傷害提高 15%。「打擊」暴擊率提高 40%。"
  },
  State_67668_Name = {Text = "白鴉喙"},
  State_67669_Name = {Text = "廢棄"},
  State_67670_Desc = {
    Text = "釋放狂氣爆發後，抽 1 張牌。若生命低於 25%，額外抽 1 張牌。"
  },
  State_67670_Name = {
    Text = "求知讀書輪"
  },
  State_67671_Desc = {
    Text = "每造成 1 次主動傷害，回復 [DescArg1] 生命，對傷害目標施加 [DescArg2] 層<BleedingIconKeywords:出血>。"
  },
  State_67671_Name = {
    Text = "受祝·蟲群意識"
  },
  State_67672_Desc = {
    Text = "造成的<WeaknessIconKeywords:虛弱>效果提高 8%，<VulnerabilityIconKeywords:易傷>效果提高 25%。施加<WeaknessIconKeywords:虛弱>或<VulnerabilityIconKeywords:易傷>時，臨時偷取目標 [DescArg1] 點<PowerIconKeywords:力量>。"
  },
  State_67673_Desc = {
    Text = "回合開始時抽 1 張牌。"
  },
  State_67673_Name = {
    Text = "定向羅盤"
  },
  State_67674_Desc = {
    Text = "每打出 1 張指令卡就獲得 [DescArg2]% <DeathResistanceIconKeywords:死亡抵抗>（本次關卡內每觸發 1 次死亡抵抗，獲得的死亡抵抗減半）。若你<DeathResistanceIconKeywords:死亡抵抗>大於等於 100%，改為獲得 [DescArg1] 點臨時<PowerIconKeywords:力量>。"
  },
  State_67674_Name = {
    Text = "怪蛇殘蛻"
  },
  State_67675_Desc = {
    Text = "回合結束時若有剩餘算力，下回合額外抽 2 張牌；若有剩餘手牌，下回合額外獲得 2 點算力。"
  },
  State_67675_Name = {
    Text = "日月輪盤+"
  },
  State_67677_Desc = {
    Text = "你造成<WeaknessIconKeywords:虛弱>時，獲得 [DescArg1] 點護盾；造成<VulnerabilityIconKeywords:易傷>時，獲得 [DescArg2] 點臨時<PowerIconKeywords:力量>。若在 1 回合內觸發了這兩個效果，額外獲得 [DescArg1] 點護盾和 [DescArg2] 點臨時<PowerIconKeywords:力量>。"
  },
  State_67677_Name = {
    Text = "沉重畫框"
  },
  State_67703_Desc = {
    Text = "回合開始時，如果上個回合剩餘的手牌數超過 3 張，獲得 2 算力。"
  },
  State_67703_Name = {
    Text = "彌薩格徽章"
  },
  State_67704_Desc = {
    Text = "釋放狂氣爆發後，對應喚醒體獲得 10 狂氣，獲得 [DescArg1] 點護盾。"
  },
  State_67704_Name = {
    Text = "無名之神的面紗"
  },
  State_67796_Name = {
    Text = "<TongxiaoKeywords:通曉萬物之理>：打出後還原，獲得 <Energy:[StateArg1]> 點狂氣"
  },
  State_67841_WeaponDesc = {
    Text = "打出前改變卡牌算力"
  },
  State_67844_Desc = {
    Text = "受到致命傷害後回復所有生命，可觸發@1次，當前已觸發 [DescArg1] 次。"
  },
  State_67844_Name = {
    Text = "亙古混沌"
  },
  State_68298_Desc = {
    Text = "受到致命傷害後意圖轉化為「深空注目」並獲得 80 層臨時加固，回復所有生命，可觸發 [DescArg1] 次。回合結束時，自身移除 20 層加固。"
  },
  State_68554_Desc = {
    Text = "受到致命傷害後回復所有生命，其他敵人全部死亡後移除該狀態。可觸發@1次，當前已觸發 [DescArg1] 次。"
  },
  State_68554_Name = {
    Text = "亙古混沌碎屑"
  },
  State_68621_Desc = {
    Text = "戰鬥開始及每回合結束時，獲得 2 層臨時<ResentChainsKeywords:怨恨鎖鏈>。"
  },
  State_68621_Name = {
    Text = "詭譎之奔流"
  },
  State_68622_Desc = {
    Text = "喚醒體施加的力量效果降低 75%。每當失去生命，獲得 [DescArg1] 點護盾和 1 層臨時加固。"
  },
  State_68623_Desc = {
    Text = "每打出 1 張指令卡，棄掉 1 張該喚醒體算力消耗最低的卡牌。"
  },
  State_68623_Name = {
    Text = "瘋狂之奔流"
  },
  State_68624_Desc = {
    Text = "回合結束時，恢復 10% 已損生命值，解除自身負面狀態和玩家的正面狀態。"
  },
  State_68624_Name = {
    Text = "誕臨之奔流"
  },
  State_68626_Desc = {
    Text = "所有喚醒體的基礎狂氣提高 50%。每回合結束時、扣除所有喚醒體 10 點狂氣、恢復自身 3％最大生命值。"
  },
  State_68626_Name = {
    Text = "恐懼之奔流"
  },
  State_68627_Desc = {
    Text = "戰鬥開始時，獲得 15 層「臨時屏障」。回合結束時，獲得 15 層「臨時屏障」，對隨機 10 張卡牌附加「臨時溶解」。"
  },
  State_68632_Desc = {
    Text = "所有指令卡算力消耗提高 1。每 3 個回合，回合結束時將 1 張「漸漸石化」置入手中。"
  },
  State_68635_Name = {
    Text = "「純銀之芯· 恐懼」"
  },
  State_68637_Desc = {
    Text = "失去生命時，減少對應層數。層數為 0 時，使玩家獲得 2 層臨時屏障，自身獲得 [DescArg1] 層護盾和 [DescArg2] 層臨時加固，並重新獲得 [DescArg3] 層維度壁障。"
  },
  State_68637_Name = {
    Text = "維度壁障"
  },
  State_68638_Name = {
    Text = "「純銀之芯· 邪信」"
  },
  State_68646_Desc = {
    Text = "基礎傷害和護盾值提高 200％，但打出後會被消耗。"
  },
  State_68646_Name = {
    Text = "<RedQuality1:臨時溶解>"
  },
  State_68647_Name = {
    Text = "「純音之芯·瘋狂」"
  },
  State_68680_Desc = {
    Text = "移除亙古碎屑"
  },
  State_68680_Name = {
    Text = "移除亙古碎屑"
  },
  State_68704_Desc = {
    Text = "距離託乎瓦波真正降臨還有 [DescArg1] 回合……"
  },
  State_68704_Name = {Text = "降臨"},
  State_68829_Desc = {
    Text = "承受主動或觸腕傷害時，免疫傷害並減少 1 層，回合開始時移除。"
  },
  State_68829_Name = {
    Text = "<ParcloseColour: 臨時屏障>"
  },
  State_68829_WeaponDesc = {
    Text = "承受的傷害降低 99%，每承受 1 次傷害減少 1 層。"
  },
  State_70026_Desc = {
    Text = "此卡牌擁有「保留」，打出後所有喚醒體臨時暴擊率提高 [StateArg1]％ 並移除「不朽支配」。若當前界域為深海，「不朽支配」移除後獲得 1 點算力。"
  },
  State_70031_Desc = {
    Text = "隊伍唯一：戰鬥開始時，賦予抽牌堆中裝備者所有算力消耗大於等於 3 的指令卡「不朽支配」效果：此卡牌擁有「保留」，打出後所有喚醒體臨時暴擊率提高 <WeaponEffect_Num:[StateArg1]%> 並移除「不朽支配」。若當前界域為深海，「不朽支配」移除後獲得 1 點算力。"
  },
  State_70031_WeaponDesc = {
    Text = "戰鬥開始時，賦予抽牌堆中裝備者所有算力消耗大於等於 3 的指令卡「不朽支配」效果：此卡牌擁有「保留」，打出後所有喚醒體臨時暴擊率提高 <WeaponEffect_Num:[StateArg1]%> 並移除「不朽支配」。若當前界域為深海，「不朽支配」移除後獲得 1 點算力。"
  },
  State_70182_Desc = {
    Text = "獲得的所有護盾降低 [DescArg1] %。"
  },
  State_70182_WeaponDesc = {
    Text = "獲得的所有護盾降低 33 %。"
  },
  State_70277_Desc = {
    Text = "承受主動或觸腕傷害後，會將 [StateArg1]% 傷害轉化為猩紅熔爐回覆量，持續 [Layer] 回合。"
  },
  State_70277_Name = {
    Text = "創生之祭"
  },
  State_70287_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，使手牌中裝備者所有「技能」造成的傷害、治療與護盾提高 [StateArg1]%。"
  },
  State_70288_Desc = {
    Text = "此卡牌造成的傷害、治療和護盾提高 [DescArg1]%。"
  },
  State_70313_Desc = {
    Text = "在首領戰中，回合開始時及「熔燬朵爾」釋放狂氣爆發後，獲得 1 層「<Zhongmowuqiling:終末>」。「終末」至多擁有 10 層，達到 10 層時，將 1 張「虛無終結」置入手中。"
  },
  State_70313_Name = {
    Text = "湮滅之路"
  },
  State_70318_Desc = {
    Text = "對所有敵人施加 [StateArg1] 回合<VulnerabilityIconKeywords:易傷>，獲得 1 回合「興奮」狀態：傷害強效 +[StateArg2]％。"
  },
  State_70318_Name = {Text = "興奮"},
  State_70322_Desc = {
    Text = "擁有 10 層終末時，將 1 張「虛無終結」置入手中。"
  },
  State_70322_Name = {Text = "終末"},
  State_70330_Desc = {
    Text = "獲得 1 回合「興奮」狀態：傷害強效 +[StateArg2]％。"
  },
  State_70330_Name = {Text = "興奮"},
  State_70346_Desc = {
    Text = "對所有敵人施加 [StateArg1] 回合 <WeaknessIconKeywords:虛弱>，並使它們在本回合中降低 [Exhaustion:StateArg3] 點<PowerIconKeywords:力量> 。"
  },
  State_70346_Name = {Text = "詛咒"},
  State_70347_Desc = {
    Text = "使所有敵人在本回合中降低 [Exhaustion:StateArg3] 點<PowerIconKeywords:力量> 。"
  },
  State_70347_Name = {Text = "詛咒"},
  State_70374_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備者每回合前 [StateArg1] 次受到攻擊時，對攻擊者造成<PVPEmptinessKeywords:空虛>。"
  },
  State_70374_Name = {
    Text = "墜入虛無的人偶"
  },
  State_70379_Desc = {
    Text = "對攻擊者造成<PVPEmptinessKeywords:空虛>。在受到攻擊後移除此狀態。"
  },
  State_70379_Name = {
    Text = "空虛反擊"
  },
  State_70443_Desc = {
    Text = "擁有 10 層終末時，將 1 張「虛無終結」置入手中。"
  },
  State_70443_Name = {Text = "終末"},
  State_70539_Name = {
    Text = "靈魂瘟疫"
  },
  State_70589_Desc = {
    Text = "連續 2 次打出比上一張算力消耗更低的卡牌時，對所有敵人施加 40/80 中毒，每回合至多觸發 5 次。"
  },
  State_70590_Desc = {
    Text = "每回合首次直接使用胚胎後，本回合內主動傷害會造成 15/30% 傷害等量的出血。"
  },
  State_70593_Desc = {
    Text = "打出非衍生指令卡後，將算力消耗降低 2 的該卡牌 1/2 張臨時複製洗入抽牌堆，3 回合冷卻。"
  },
  State_70594_Desc = {
    Text = "回合結束時，如果處於潮湧姿態，獲得 32/64 觸腕傷害，3 回合冷卻。"
  },
  State_70595_Desc = {
    Text = "戰鬥開始時對所有敵人施加 1280 中毒，首領戰效果翻倍。"
  },
  State_70598_Desc = {
    Text = "每當一張卡進入超維空間時，若這張卡與其他超維空間的卡牌歸屬者不同，則將 1/2 張靈感置入手中。"
  },
  State_70600_Desc = {
    Text = "回合結束時回復 32 點生命。"
  },
  State_70600_Name = {
    Text = "恩賜之血"
  },
  State_70602_Desc = {
    Text = "使用銀鑰覺醒後抽 4 張牌。"
  },
  State_70603_Desc = {
    Text = "使用銀鑰覺醒後所有喚醒體獲得 10 狂氣。"
  },
  State_70605_Desc = {
    Text = "使用銀鑰覺醒後獲得 32 力量。"
  },
  State_70607_Desc = {
    Text = "連續 2 次打出比上一張算力消耗更高的卡牌時，獲得 24/48 反擊，每回合至多觸發 5 次。"
  },
  State_70609_Desc = {
    Text = "使用銀鑰覺醒後獲得 96 護盾。"
  },
  State_70609_Name = {
    Text = "蝴蝶標本"
  },
  State_70611_Desc = {
    Text = "使用銀鑰覺醒後使所有喚醒體造成的基礎傷害提高 25%/50%。"
  },
  State_70614_Name = {
    Text = "鐳射頜骨+"
  },
  State_70617_Desc = {
    Text = "每回合前五次造成的傷害提高 15%/30%。"
  },
  State_70618_Desc = {
    Text = "回合開始時抽 1 張牌。"
  },
  State_70619_Desc = {
    Text = "「打擊」造成傷害 10%/20% 的中毒，每回合至多造成 320/640 點。"
  },
  State_70620_Desc = {
    Text = "受到敵人攻擊時使其受到 1次 25%/50% 我方最大生命值的<FixedDamage:純粹傷害>，該傷害享受 100%/200% 反擊加成，每個敵人每回合最多觸發 1 次。"
  },
  State_70620_Name = {
    Text = "遺落的祭祀刀"
  },
  State_70621_Desc = {
    Text = "使用銀鑰覺醒後獲得 192 護盾。"
  },
  State_70621_Name = {
    Text = "蝴蝶標本+"
  },
  State_70623_Desc = {
    Text = "每回合開始時所有喚醒體獲得 10 狂氣。"
  },
  State_70624_Desc = {
    Text = "使用銀鑰覺醒後所有喚醒體獲得 20 狂氣。"
  },
  State_70628_Desc = {
    Text = "回合開始時抽 2 張牌。"
  },
  State_70629_Desc = {
    Text = "每回合首次吞噬時，其他喚醒體獲得 10/20 狂氣。"
  },
  State_70635_Desc = {
    Text = "使用銀鑰覺醒後獲得 416 反擊。"
  },
  State_70636_Desc = {
    Text = "失去生命時獲得 10%/20% 生命損失量的猩紅熔爐。"
  },
  State_70637_Desc = {
    Text = "戰鬥開始時，觸婉上限+1/2，獲得 1/2 條觸腕。"
  },
  State_70641_Desc = {
    Text = "湮滅獲得 160/320 護盾，3 回合冷卻。"
  },
  State_70641_Name = {
    Text = "超弦懷錶"
  },
  State_70643_Desc = {
    Text = "回合開始時獲得 1 算力。"
  },
  State_70644_Desc = {
    Text = "釋放狂氣爆發後，獲得 16/32 臨時力量。"
  },
  State_70645_Desc = {
    Text = "回合開始時獲得 2 算力。"
  },
  State_70646_Name = {
    Text = "遺落的祭祀刀+"
  },
  State_70647_Desc = {
    Text = "所有喚醒體造成的基礎傷害提高 30%。"
  },
  State_70648_Desc = {
    Text = "戰鬥開始時對所有敵人施加 640 中毒，首領戰效果翻倍。"
  },
  State_70656_Desc = {
    Text = "「打擊」額外造成 1/2 次 60% 喚醒體攻擊力的傷害，每回合至多觸發 3 次。"
  },
  State_70657_Desc = {
    Text = "戰鬥開始時獲得 32 力量。"
  },
  State_70660_Desc = {
    Text = "戰鬥開始時獲得 64 力量。"
  },
  State_70661_Desc = {
    Text = "回合結束時回復 64 點生命。"
  },
  State_70661_Name = {
    Text = "恩賜之血+"
  },
  State_70662_Desc = {
    Text = "使用銀鑰覺醒後獲得 2 算力。"
  },
  State_70664_Desc = {
    Text = "使用銀鑰覺醒後獲得 16 力量。"
  },
  State_70666_Desc = {
    Text = "戰鬥開始後，獲得 100/200 界域精通。所有喚醒體造成的基礎中毒與造物造成的中毒提高 10%/20%。"
  },
  State_70667_Desc = {
    Text = "使用銀鑰覺醒後獲得 4 算力。"
  },
  State_70670_Desc = {
    Text = "戰鬥開始時獲得 320 反擊，首領戰效果翻倍。"
  },
  State_70671_Desc = {
    Text = "進入超維回合後，第一張打出的非衍生指令卡額外生效 1/2 次。"
  },
  State_70678_Desc = {
    Text = "戰鬥開始時獲得 640 反擊，首領戰效果翻倍。"
  },
  State_70681_Desc = {
    Text = "所有喚醒體造成的基礎傷害提高 60%。"
  },
  State_70682_Desc = {
    Text = "當手牌數小於等於 2 時，抽 1/2 張牌，每回合最多觸發 2 次。"
  },
  State_70683_Desc = {
    Text = "湮滅使狂氣最低的喚醒體獲得 50/100 狂氣，3 回合冷卻。"
  },
  State_70684_Desc = {
    Text = "回合開始時，若生命低於 25%，獲得 72/144 臨時力量。"
  },
  State_70685_Desc = {
    Text = "使用銀鑰覺醒後對所有敵人施加 416 中毒。"
  },
  State_70686_Desc = {
    Text = "釋放狂氣爆發後，使所有敵人受到 1 次 15%/30% 我方最大生命值的<FixedDamage:純粹傷害>，並觸發 10%/20% 中毒。"
  },
  State_70687_Name = {
    Text = "超限懷錶+"
  },
  State_70689_Desc = {
    Text = "使用銀鑰覺醒後對所有敵人施加 832 中毒。"
  },
  State_70690_Desc = {
    Text = "戰鬥開始後，獲得 100/200 界域精通。所有喚醒體造成的基礎反擊與造物造成的反擊提高 10%/20%。"
  },
  State_70691_Desc = {
    Text = "每次造成傷害時獲得 4/8 臨時力量，每回合至多觸發 15 次。"
  },
  State_70693_Desc = {
    Text = "胚胎融合自動獲得量提高 100%/200%。"
  },
  State_70694_Desc = {
    Text = "使用銀鑰覺醒後抽 2 張牌。"
  },
  State_70695_Desc = {
    Text = "每回合開始時所有喚醒體獲得 5 狂氣。"
  },
  State_70696_Desc = {
    Text = "使用銀鑰覺醒後獲得 208 反擊。"
  },
  State_70698_Desc = {
    Text = "防禦獲得 200/400 臨時反擊，每回合至多觸發 3 次。"
  },
  State_70804_Name = {
    Text = "生死時限"
  },
  State_70805_Desc = {
    Text = "戰鬥開始後，對所有敵人施加 1/2 層虛弱，對首領效果翻倍。所有喚醒體造成的基礎傷害提高 15%/30%。"
  },
  State_70806_Name = {
    Text = "守護之手+"
  },
  State_70808_Desc = {
    Text = "使用靜海姿態對所有敵人施加 64/128 衰竭，3 回合冷卻。"
  },
  State_70809_Desc = {
    Text = "回合開始時，若生命低於 25%，獲得 100/200 護盾。"
  },
  State_70809_Name = {
    Text = "守護之手"
  },
  State_70810_Desc = {
    Text = "使用怒濤姿態立即激發所有觸腕攻擊敵人 1/2 次，3 回合冷卻。"
  },
  State_70812_Desc = {
    Text = "戰鬥開始後，對所有敵人施加 1/2 層易傷，對首領效果翻倍。所有喚醒體造成的基礎傷害提高 15%/30%。"
  },
  State_70832_Desc = {
    Text = "隊伍唯一：戰鬥開始時，裝備者獲得等同於 <WeaponEffect_Num:[StateArg1]%> 裝備者狂氣回充的狂氣。裝備者每場戰鬥首次釋放狂氣爆發後，重複一次該效果。"
  },
  State_70832_WeaponDesc = {
    Text = "戰鬥開始時，裝備者獲得等同於 <WeaponEffect_Num:[StateArg1]%> 裝備者狂氣回充的狂氣（<WeaponEffect_Num:[DescArg1]>）。裝備者每場戰鬥首次釋放狂氣爆發後，重複一次該效果。"
  },
  State_70835_Desc = {
    Text = "隊伍唯一：裝備者造成的狂氣、中毒、生命回復提高 <WeaponEffect_Num:[StateArg1]%>。裝備者釋放狂氣爆發後，獲得等同於本次狂氣消耗 <WeaponEffect_Num:[StateArg2]%> 的狂氣。"
  },
  State_70835_WeaponDesc = {
    Text = "裝備者造成的狂氣、中毒、生命回復提高 <WeaponEffect_Num:[StateArg1]%>。裝備者釋放狂氣爆發後，獲得等同於本次狂氣消耗 <WeaponEffect_Num:[StateArg2]%> 的狂氣。"
  },
  State_70989_Desc = {
    Text = "在一回合釋放 4 次狂氣爆發後，獲得 3/6 算力，3 回合冷卻。"
  },
  State_71001_Desc = {
    Text = "在一回合內打出 4 張歸屬於不同喚醒體的指令卡後，所有喚醒體獲得 20/40 狂氣，3 回合冷卻。"
  },
  State_71153_Desc = {
    Text = "回合開始時凱刻斯獲得 15 狂氣。凱刻斯獲得護盾時回復 50% 護盾量的生命。"
  },
  State_71154_Desc = {
    Text = "回合開始時艾繼絲獲得 15 狂氣。艾繼絲對具有易傷的敵人造成傷害時還會偷取其 10 點臨時力量，每回合最多生效 5 次。"
  },
  State_71155_Desc = {
    Text = "回合開始時雷婭獲得 15 狂氣。每當失去生命後獲得 8 點力量，每場戰鬥最多疊加 10 次。疊加 10 次後，「苦痛與歡愉」算力消耗變為 1，傷害次數提高 1。"
  },
  State_71156_Desc = {
    Text = "回合開始時阿格里帕獲得 15 狂氣。「不耐的施捨」還會使阿格里帕在本回合中算力消耗降低 1，每回合最多生效 1 次。"
  },
  State_71157_Desc = {
    Text = "回合開始時珊獲得 15 狂氣。戰鬥開始時對珊的所有指令卡賦予保留、預備 1、獲得 24 點護盾。"
  },
  State_71157_Name = {
    Text = "維度影像·珊"
  },
  State_71158_Desc = {
    Text = "回合開始時朵爾獲得 15 狂氣。戰鬥開始後使朵爾的「等價交換」算力消耗變為 0，打出後下回合額外抽 2 張牌。"
  },
  State_71159_Desc = {
    Text = "回合開始時法洛思獲得 15 狂氣。每造成 1 次觸腕傷害，就使法洛思本場戰鬥造成的中毒提高 1%，最大為 100%。"
  },
  State_71160_Desc = {
    Text = "回合開始時「24」獲得 15 狂氣。回合開始時「24」若處於「抑鬱人格」則額外獲得 25 狂氣，若處於「躁狂人格」則使「24」臨時暴擊率和臨時暴擊傷害提高 35%。"
  },
  State_71161_Desc = {
    Text = "回合開始時菲茵特獲得 15 狂氣。每當觸發死亡抵抗就使菲茵特本場探索中造成的護盾、反擊、生命回復提高 20%，最多生效 5 次。"
  },
  State_71162_Desc = {
    Text = "回合開始時戈利亞獲得 15 狂氣。若戈利亞 1 回合內造成了 3 次傷害，戈利亞造成的傷害本場戰鬥中額外享受 1 倍力量加成，3 回合冷卻。"
  },
  State_71163_Desc = {
    Text = "回合開始時血鏈希洛獲得 15 狂氣。血鏈·希洛主動傷害附加 20% 出血，擊殺敵人後對其他敵人造成等同於過量傷害的出血。"
  },
  State_71164_Desc = {
    Text = "回合開始時奧瑞塔獲得 15 狂氣。「腺體分裂」傷害次數提高 1，打出奧瑞塔的「防禦」後將 1 張「腺體分裂」置入手中。"
  },
  State_71166_Desc = {
    Text = "回合開始時莉莉獲得 15 狂氣。莉莉忍耐上限提高 100%，釋放「淤泥上的不滅之花」或「報償打擊」時，回復「忍耐」層數 8% 的生命。"
  },
  State_71167_Desc = {
    Text = "回合開始時蘿坦獲得 15 狂氣。每回合首次打出蘿坦的「防禦」後，將 2 張附加消耗與虛無的「桀驁之刃」置入手中。"
  },
  State_71168_Desc = {
    Text = "回合開始時潘狄婭獲得 15 狂氣。回合開始時獲得 64 點反擊。每有 4 點非臨時的反擊「潘迪婭」指令卡造成的傷害就提高 1。"
  },
  State_71169_Desc = {
    Text = "回合開始時希洛獲得 15 狂氣。每當有 1 張牌被棄掉，都會使「希洛」獲得 5 點狂氣。"
  },
  State_71170_Desc = {
    Text = "回合開始時塔薇獲得 15 狂氣。若一回合內打出了 6 張塔薇的指令卡，將 1 張「銀鑰曦光」置入手中，冷卻 3 回合。"
  },
  State_71171_Desc = {
    Text = "回合開始時彌利亞姆獲得 15 狂氣，並將 1 張「聖禮」置入手中。"
  },
  State_71172_Desc = {
    Text = "回合開始時熔燬·朵爾獲得 15 狂氣。熔燬朵爾釋放狂氣爆發後，每消耗 20 點狂氣其他喚醒體就獲得 1 點狂氣。"
  },
  State_71173_Desc = {
    Text = "回合開始時薩爾瓦多獲得 15 狂氣。每次積攢猩紅熔爐時還會獲得積攢量 5% 的力量。薩爾瓦多的「打擊」與「應消之苦」額外享受 1 倍力量加成。"
  },
  State_71175_Desc = {
    Text = "回合開始時諾諦拉獲得 15 狂氣。釋放諾諦拉的「狂氣爆發」後獲得等同於當前護盾 50% 的反擊，每回合最多觸發 1 次。"
  },
  State_71177_Desc = {
    Text = "回合開始時莉茲獲得 15 狂氣。「告死之舞」棄掉的卡牌額外生效 1 次，3 回合冷卻。"
  },
  State_71178_Desc = {
    Text = "回合開始時拉蒙娜獲得 15 狂氣。每第 3 張打出拉蒙娜的指令卡時，該指令卡額外生效 1 次。"
  },
  State_71179_Desc = {
    Text = "回合開始時尤烏哈希獲得 15 狂氣。尤烏哈希狂氣消耗降低 10 點，每次釋放狂氣爆發狂氣消耗額外降低 5 點，每回合能夠釋放 2 次狂氣爆發。"
  },
  State_71180_Desc = {
    Text = "回合開始時艾爾瓦獲得 15 狂氣。上回合艾爾瓦若打出過 2 張「防禦」，將一張消耗的「心眼利刃」置入手中；若打出過 2 張「打擊」，將 1 張消耗的「臨戰體勢」置入手中。"
  },
  State_71181_Desc = {
    Text = "回合開始時索蕾爾獲得 15 狂氣。索蕾爾每造成 1 次傷害胚胎融合+10，每回合最多生效 10 次。生效 10 次後使索蕾爾本場戰鬥暴擊傷害+ 20%。"
  },
  State_71182_Desc = {
    Text = "回合開始時哈姆林獲得 15 狂氣。「靈魂序曲」算力消耗降低 1，基礎傷害次數提高 1。"
  },
  State_71183_Desc = {
    Text = "回合開始時泰旖絲獲得 15 狂氣。泰旖絲在 1 回合內打出 2 張指令卡後，獲得一張「聖潔之子」和 72 點臨時力量，3 回合冷卻。"
  },
  State_71187_Desc = {
    Text = "回合開始時希萊斯特獲得 15 狂氣。回合結束前手牌中每有 1 張希萊斯特的指令卡就使 1 條觸腕攻擊敵人並回復 8 點生命。"
  },
  State_71188_Desc = {
    Text = "回合開始時墨菲獲得 15 狂氣。墨菲的「打擊」和「防禦」能夠將 25% 的「獻祭」轉化為臨時觸腕傷害，但每回合最多生效 1 次。"
  },
  State_71189_Desc = {
    Text = "回合開始時寧菲亞獲得 15 狂氣。打出寧菲亞的 「打擊」後使「寧菲亞」本場戰鬥造成的中毒提高 20%，打出寧菲亞的 「防禦」後觸發所有敵人 50% 中毒。每回合最多各生效 1 次。"
  },
  State_71190_Desc = {
    Text = "回合開始時奧吉爾獲得 15 狂氣。每回合首次打出奧吉爾的「穿刺之槍」或「打擊」後，使奧吉爾本回合內造成的護盾和力量提高 50%。"
  },
  State_71191_Desc = {
    Text = "回合開始時萊克獲得 15 狂氣。每回合首次骰子結果總是為 6。"
  },
  State_71192_Desc = {
    Text = "回合開始時環行·拉蒙娜獲得 15 狂氣。每回合首次觸發「回環」時，獲得 500 點銀鑰能量和 1 層「負熵」。"
  },
  State_71193_Desc = {
    Text = "回合開始時圖魯獲得 15 狂氣。圖魯的狂氣消耗降低 10 點，釋放狂氣爆發後立刻生成 2 條臨時觸腕。"
  },
  State_71194_Desc = {
    Text = "回合開始時珈倫獲得 15 狂氣。打出「靜默守望」會返還雙倍消耗的算力，冷卻 3 回合。"
  },
  State_71271_Desc = {
    Text = "回合開始時奧爾拉獲得 15 狂氣。戰鬥開始時獲得所有情緒的隱喻各 1 層。「隱喻」效果提高 50％。"
  },
  State_71272_Desc = {
    Text = "回合開始時詹金獲得 15 狂氣，最終傷害+5%。「布朗出動」的基礎傷害和造成的傷害成長提高 200%。"
  },
  State_71273_Desc = {
    Text = "回合開始時達芙黛爾獲得 15 狂氣和 1 張「靈感」。每次打出「異質潮汐」都會使其獲得的力量在本場探索中永久提高 25%，最大為 300%。"
  },
  State_71274_Desc = {
    Text = "回合開始時汀克特獲得 15 狂氣。汀克特的指令卡觸發躍遷後將其返回手中，每回合最多生效 3 次。"
  },
  State_71275_Desc = {
    Text = "回合開始時旺達獲得 15 狂氣並獲得 1 層「夢引」。若當前為超維回合額外將 1 張臨時的「脊刺鎖鏈」和「迷途之守」置入手中。"
  },
  State_71276_Desc = {
    Text = "回合開始時艾瑞卡獲得 15 狂氣。艾瑞卡在 1 回合內打出 3 張指令卡後，獲得 1 張「靈感」並使本場戰鬥「電磁爆破」享受的力量和戒備加成提高 1 倍。"
  },
  State_71277_Desc = {
    Text = "回合開始時卡茜亞獲得 15 狂氣。每抽 1 張牌就使卡茜亞獲得 1 點狂氣。卡茜亞釋放狂氣爆發時所有敵人失去 32 點力量。"
  },
  State_71278_Desc = {
    Text = "回合開始時溫柯爾獲得 15 狂氣。每當其他喚醒體釋放狂氣爆發就會使溫柯爾獲得 5 點狂氣，並使手中的「精神重建」算力消耗降低 1。"
  },
  State_71279_Desc = {
    Text = "傷害強效 +[StateArg1]％，持續 [Layer] 回合。"
  },
  State_71279_Name = {Text = "興奮"},
  State_71503_Name = {
    Text = "「終末形態」：額外抽 3 張牌，獲得 3 點算力，觸發所有敵人 [DescArg1]％ <IntoxicationIconKeywords:中毒>，「熔燬·朵爾」的狂氣上限提高 50 點，至多提高 3 次"
  },
  State_71581_Name = {
    Text = "靈塑適性"
  },
  State_71589_Name = {
    Text = "激發 1 條觸腕攻擊敵人並回復8。"
  },
  State_71605_Name = {
    Text = "獲得 [StateArg1] 點護盾"
  },
  State_71650_Desc = {
    Text = "死亡後復活並召喚不同數量的分身，但它復活後居然不會獲得任何加固和免疫。還能生效 [Layer] 次。"
  },
  State_71650_Name = {
    Text = "萬千維度之獸"
  },
  State_71651_Desc = {
    Text = "每當失去生命就失去 [StateArg1] 點臨時力量。還能生效 [Layer] 次，每回合重置生效次數。"
  },
  State_71651_Name = {
    Text = "紳士禮帽"
  },
  State_71707_Desc = {
    Text = "每受到 1 次主動傷害，回覆 [StateArg1] 點生命，持續 [Layer] 回合。"
  },
  State_71707_Name = {
    Text = "凱刻斯·支援"
  },
  State_71708_Desc = {
    Text = "回合結束時，每有 1 張卡牌在手中，所有喚醒體獲得 [DescArg1] 點狂氣。"
  },
  State_71708_Name = {
    Text = "卡茜亞·支援"
  },
  State_71709_Desc = {
    Text = "回合結束時，獲得 35 點狂氣，持續 [Layer] 回合。"
  },
  State_71709_Name = {
    Text = "溫柯爾·支援"
  },
  State_71711_Desc = {
    Text = "喚醒體造成的傷害提高 25%，持續 [Layer] 回合。"
  },
  State_71712_Desc = {
    Text = "造成主動傷害時，使 1 條觸腕攻擊 1 次，持續 [Layer] 回合。"
  },
  State_71712_Name = {
    Text = "奧瑞塔·支援"
  },
  State_71712_WeaponDesc = {
    Text = "海月造成傷害時，使 [StateArg1] 條觸腕攻擊該目標。"
  },
  State_71713_Desc = {
    Text = "每次進行「吞噬」，都會抽 2 張「打擊」並使它們算力消耗降低 1，持續 [Layer] 回合。"
  },
  State_71740_Desc = {
    Text = "下回合開始時獲得 [Layer] 點護盾。"
  },
  State_71740_Name = {
    Text = "雷婭·支援護盾"
  },
  State_71741_Desc = {
    Text = "下回合開始時，獲得等同於本回合損失生命的護盾，持續 [Layer] 回合。"
  },
  State_71741_Name = {
    Text = "雷婭·支援"
  },
  State_71741_WeaponDesc = {
    Text = "下回合開始獲得上回合損失生命等量的護盾。"
  },
  State_71742_Desc = {
    Text = "打擊卡傷害提高 [Layer]％。"
  },
  State_71742_WeaponDesc = {
    Text = "本回合你的打擊卡傷害提高 [Layer]%。"
  },
  State_71837_Desc = {
    Text = "下回合開始時，獲得易傷。"
  },
  State_71837_Name = {
    Text = "延遲易傷"
  },
  State_71839_Desc = {
    Text = "使用「甦醒」時，獲得 [Layer] 點算力。若當前界域為「深海」，額外生成 [Layer] 條臨時觸腕。"
  },
  State_71856_Desc = {
    Text = "每當失去生命就失去 [StateArg1] 點臨時力量。還能生效 [Layer] 次，每回合重置生效次數。"
  },
  State_71856_Name = {
    Text = "紳士禮帽"
  },
  State_72018_WeaponDesc = {
    Text = "每受到1次傷害，全體喚醒體增加 1 點狂氣。"
  },
  State_72033_Name = {Text = "觸腕"},
  State_72036_Name = {
    Text = "混沌職業初始化"
  },
  State_72079_Name = {Text = "怒濤"},
  State_72102_Desc = {
    Text = "經典的「忘卻前夜」遊玩體驗。"
  },
  State_72102_Name = {Text = "忘卻篇"},
  State_72137_Name = {
    Text = "算力滿盈"
  },
  State_72206_Name = {
    Text = "研究進度「[DescArg1] / 15」"
  },
  State_72208_Name = {
    Text = "研究進度「[DescArg1] / 2」"
  },
  State_72212_Name = {
    Text = "研究進度「[DescArg1] / 10」"
  },
  State_72213_Name = {
    Text = "研究進度「[DescArg1] / 30」"
  },
  State_72220_Name = {
    Text = "研究進度「[DescArg1] / 5」"
  },
  State_73518_Desc = {
    Text = "造成的傷害提高 100％，失去生命後解除該狀態，但獲得 50％ 最大生命的護盾。"
  },
  State_73518_Name = {
    Text = "「暗殺者」"
  },
  State_73520_Desc = {
    Text = "死亡時，保留 1 點生命並免疫所有傷害，將意圖轉化為「連結解除」。"
  },
  State_73520_Name = {
    Text = "「連結者」"
  },
  State_73533_Desc = {
    Text = "玩家回合結束時不再丟棄手牌。戰鬥開始時，將玩家手牌上限變為 8。"
  },
  State_73533_Name = {
    Text = "巢群感應"
  },
  State_73535_Desc = {
    Text = "自身回合內，受到的傷害降低 75％。力量被降低時，僅會降低 50% 的力量層數。"
  },
  State_73535_Name = {
    Text = "自體保護"
  },
  State_73566_Desc = {
    Text = "每打出 1 張非指令卡，獲得 [Power:StateArg1] 點<PowerIconKeywords:力量> 和 <Block:[Block:StateArg2]> 點護盾。"
  },
  State_73566_Name = {
    Text = "「通訊者」"
  },
  State_73567_Desc = {
    Text = "每打出 1 張非指令卡，獲得 [Power:StateArg1] 點<PowerIconKeywords:力量> 和 <Block:[Block:StateArg2]> 點護盾。"
  },
  State_73567_Name = {
    Text = "「通訊者」"
  },
  State_73570_Desc = {
    Text = "每打出 1 張非指令卡，獲得 [Power:StateArg1] 點<PowerIconKeywords:力量> 和 <Block:[Block:StateArg2]> 點護盾。"
  },
  State_73570_Name = {
    Text = "「通訊者」"
  },
  State_73573_Desc = {
    Text = "每打出 1 張非指令卡，獲得 [Power:StateArg1] 點<PowerIconKeywords:力量> 和 <Block:[Block:StateArg2]> 點護盾。"
  },
  State_73573_Name = {
    Text = "「通訊者」"
  },
  State_73649_Desc = {
    Text = "隊伍傷害強效提高 [Layer]％。"
  },
  State_73649_Name = {
    Text = "墜入虛無的人偶"
  },
  State_73655_Name = {
    Text = "有機形態標識"
  },
  State_73664_Name = {
    Text = "飾品有機形態效果"
  },
  State_73664_WeaponDesc = {
    Text = "裝備者使用狂氣爆發後，本回合內自身護盾和治療強效翻倍。"
  },
  State_74012_Desc = {
    Text = "對所有敵人造成其最大生命 [StateArg1]％ 的<FixedDamage:純粹傷害>(最低為[DescArg1])，使用後「熔毀·朵爾」的特定技能變更為「終末形態」。"
  },
  State_74012_Name = {
    Text = "虛無終結"
  },
  State_74013_Desc = {
    Text = "對所有敵人造成其最大生命 [StateArg1]％ 的<FixedDamage:純粹傷害>，該傷害不會低於自身最大生命的 500％，使用後「熔毀·朵爾」的特定技能變更為「終末形態」。"
  },
  State_74013_Name = {
    Text = "虛無終結"
  },
  State_74014_Desc = {
    Text = "對所有敵人造成其最大生命 [StateArg1]％ 的<FixedDamage:純粹傷害>（該傷害不會低於自身最大生命的 500％），恢復 30％已損生命，使用後「熔毀·朵爾」的特定技能變更為「終末形態」。"
  },
  State_74014_Name = {
    Text = "虛無終結"
  },
  State_74015_Desc = {
    Text = "對所有敵人造成其最大生命 [StateArg1]％ 的<FixedDamage:純粹傷害>(最低為[DescArg1])，恢復 <Heal:[Heal:DescArg2]> 點生命，使用後「熔毀·朵爾」的特定技能變更為「終末形態」。"
  },
  State_74015_Name = {
    Text = "虛無終結"
  },
  State_74019_Desc = {
    Text = "所有喚醒體造成的中毒、反擊、基礎傷害提高 [Layer]％。"
  },
  State_74019_Name = {
    Text = "癲狂感染"
  },
  State_74142_Desc = {
    Text = "探索開始後，體質、攻擊、防禦提升 [StateArg1] %"
  },
  State_74142_Name = {
    Text = "靈塑適性"
  },
  State_74219_Name = {
    Text = "打出後將其返還手中"
  },
  State_74273_Desc = {
    Text = "血鏈·希洛造成的主動傷害時，附加 [StateArg1]% 出血，持續 [Layer] 回合。"
  },
  State_74273_Name = {
    Text = "縛身鎖鏈"
  },
  State_74771_Desc = {
    Text = "釋放 1 次狂氣爆發所需要的狂氣值。"
  },
  State_74771_Name = {
    Text = "狂氣上限"
  },
  State_74788_Desc = {
    Text = "\n·存在悖論：探索開始時、死亡抵抗的 75％ 轉換為最大生命值加成、至多轉換 300％ 死亡抵抗、至多提升 10％ 最大生命。每次觸發死亡抵抗額外將 1 張「銀鑰微光」置入手中。\n·無底創痕：首領戰中、我方受到的生命回覆量每達到生命上限的 100%、就降低後續受到的生命回覆效果 25%、但使當前死亡抵抗總量提高 25%、最多觸發 3 次。\n·稜彩透鏡：回合開始時、若反擊超過 750％ 生命上限、將超出部分層數減半、且永久反擊至多堆疊 2250％ 生命上限；若敵人中毒超過 1000％ 生命上限、將超出部分層數減半、且中毒至多堆疊至 3000％ 生命上限。喚醒體根據反擊獲得的傷害加成量降低 70%、但造成的所有中毒與反擊提高 10%。敵方回合開始時、每有一個靈知覺醒被激活、獲得 25％ 當前永久反擊的臨時反擊、並觸發所有敵人 25％ 中毒。\n·命運光錐：普通怪物釋放「凝視」的回合數變為 6 回合。所有戰鬥擁有 15 回合的限制、但 15 回合開始時、將 1 張「光錐界限」置入手中：將銀鑰能量和所有的喚醒體的狂氣填充至最大值。"
  },
  State_74788_Name = {
    Text = "（暫時棄用）"
  },
  State_74791_Desc = {
    Text = "\n·算力調和：單回合內出牌達到 10 張指令卡時，每打出 1 張指令卡獲得 1 層「算力調和」。「算力調和」使本回合內每次打出指令卡算力消耗+1，因此消耗的每點額外算力轉換為 100% 喚醒體銀鑰充能的銀鑰能量，可疊加。發動超維空間後，重置算力調和效果。\n·算力滿盈：打出卡牌後移除其本回合內算力消耗降低效果。戰鬥中當前算力超過 12 時，自動將超出的每點算力轉化為 300% 隊伍平均銀鑰充能的銀鑰能量。\n·狂氣調和：造成狂氣百分比提高效果減半。喚醒體每次釋放狂氣爆發後，其基礎狂氣 +10。回合結束時每有 1 名喚醒體未釋放狂氣爆發，就獲得 200％ 隊伍平均銀鑰充能的銀鑰能量。"
  },
  State_74791_Name = {
    Text = "鑰能調和"
  },
  State_74809_Name = {
    Text = "「終末形態」：額外抽 3 張牌，獲得 3 點算力，觸發所有敵人 [DescArg1]％ <IntoxicationIconKeywords:中毒>，「熔燬·朵爾」的狂氣上限提高 50 點，至多提高 3 次"
  },
  State_74826_Name = {
    Text = "隨機造成 [DescArg1] 點<FixedDamage:純粹傷害> [DescArg2] 次（該傷害受到1倍力量加成）"
  },
  State_74827_Name = {
    Text = "本回合所有喚醒體暴擊和暴擊傷害提高 [DescArg1]%"
  },
  State_74828_Name = {
    Text = "對全體敵方造成 [DescArg1] 點中毒"
  },
  State_74829_Name = {
    Text = "對全體敵方造成已損失生命 [DescArg1]% 的<FixedDamage:純粹傷害>"
  },
  State_74830_Name = {
    Text = "獲得 [DescArg1] 點力量"
  },
  State_74831_Name = {
    Text = "所有喚醒體獲得 [DescArg1] 點狂氣"
  },
  State_74847_Desc = {
    Text = "隊伍唯一：裝備者每回合使用的第一張指令卡造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。若其進入了超維空間，裝備者獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣。"
  },
  State_74847_WeaponDesc = {
    Text = "裝備者每回合使用的第一張指令卡造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。若其進入了超維空間，裝備者獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣。"
  },
  State_74879_Name = {
    Text = "獲得 [DescArg1] 點算力"
  },
  State_74881_Name = {
    Text = "選擇一名喚醒體獲得 [DescArg1] 點狂氣"
  },
  State_74882_Name = {
    Text = "獲得 [DescArg1] 點界域精通"
  },
  State_74883_Name = {
    Text = "下 [DescArg1] 張打出的指令卡額外獲得 [DescArg2] 點鑰能"
  },
  State_74884_Name = {
    Text = "本回合造成的中毒、反擊、出血提高 [DescArg1]%"
  },
  State_74885_Name = {
    Text = "所有喚醒體獲得 [DescArg1] 點狂氣"
  },
  State_74887_Name = {
    Text = "獲得 [DescArg1] 點護盾"
  },
  State_74888_Name = {
    Text = "獲得 [DescArg1] 點死亡抵抗"
  },
  State_74889_Name = {
    Text = "獲得 [DescArg1] 層反擊"
  },
  State_74890_Name = {
    Text = "偷取所有敵人 [DescArg1] 點臨時力量"
  },
  State_74891_Name = {
    Text = "隨機造成 [DescArg1] 點<FixedDamage:純粹傷害> [DescArg2] 次（該傷害受到1倍力量加成）"
  },
  State_74910_Desc = {
    Text = "隊伍唯一：若裝備者為喚醒體「拉蒙娜」，探索關卡所獲得的同調率提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_74910_WeaponDesc = {
    Text = "若裝備者為喚醒體「拉蒙娜」，完成關卡時獲得的同調率提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_74932_Desc = {
    Text = "打出「打擊」卡、「防禦」卡、「技能」卡時會升級「禁忌的交易」中的對應效果。"
  },
  State_74947_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合開始時，對<HPAndShieldMin:生命與護盾最低>敵方附加 [StateArg1] 層行動封鎖。裝備者造成擊殺後，立刻觸發一次該效果。"
  },
  State_74947_Name = {
    Text = "魔女寬簷帽"
  },
  State_74948_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使狂氣最高的敵方失去 [StateArg1] 狂氣並獲得<PVPEmptinessKeywords:空虛>。"
  },
  State_74948_Name = {
    Text = "催眠靈擺"
  },
  State_76236_Desc = {
    Text = "\n·銀鑰覺醒：銀鑰能量滿時，可以額外選擇「銀鑰覺醒」來將指定喚醒體的靈知覺醒牌置入手中並使其獲得「保留」，本場戰鬥有效。「銀鑰覺醒」每回合只能觸發 1 次，與「鑰令」獨立冷卻。\n·鑰能超載：使用「銀鑰覺醒」時，每有一個已解鎖靈知覺醒的喚醒體，就額外扣除 1000 點銀鑰能量，這個效果可能使銀鑰能量變為負數。\n·歸檔刻痕：守密人每擁有 1 個鑰令，就使「物象研究深度」與「靈識研究深度」提高 1％，至多提高 50％。所有 R 命輪的效果變更為使裝備者的維度影像造物出現的可能性提高 100%。"
  },
  State_76236_Name = {
    Text = "璀璨銀輝"
  },
  State_76277_Desc = {
    Text = "隊伍唯一：首領戰開始後，消耗最多 50 黑印，每消耗 1 點黑印獲得 <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords: 死亡抵抗>。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76277_WeaponDesc = {
    Text = "首領戰開始後，消耗最多 50 黑印，每消耗 1 點黑印獲得 <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords: 死亡抵抗>。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76278_Desc = {
    Text = "隊伍唯一：每走過一個新的格子，回復 <WeaponEffect_Num:[StateArg1]%> 已損失血量。使用應急靈知體後，所有喚醒體的暴擊率和暴擊傷害提高 100%。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76278_WeaponDesc = {
    Text = "每走過一個新的格子，回復[StateArg1]% 已損失血量([DescArg1])。使用應急靈知體後，所有喚醒體的暴擊率和暴擊傷害提高 100%。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76279_Desc = {
    Text = "隊伍唯一：融痕中覺醒喚醒體的價格降低 <WeaponEffect_Num:[StateArg1]> 點黑印。裝備者的靈知覺醒獲得固有。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76279_WeaponDesc = {
    Text = "融痕中覺醒喚醒體的價格降低 <WeaponEffect_Num:[StateArg1]> 點黑印。裝備者的靈知覺醒獲得固有。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76280_Desc = {
    Text = "隊伍唯一：休息處的回復量提高 <WeaponEffect_Num:[StateArg1]%>，選擇回復生命後，將 2 張「靈感」加入牌庫。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76280_WeaponDesc = {
    Text = "休息處的回復量提高 <WeaponEffect_Num:[StateArg1]%>，選擇回復生命後，將 2 張「靈感」加入牌庫。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76281_Desc = {
    Text = "隊伍唯一：戰鬥結束後，狂氣最低的喚醒體獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76281_WeaponDesc = {
    Text = "戰鬥結束後，狂氣最低的喚醒體獲得 <WeaponEffect_Num:[Energy:StateArg1]> 點狂氣。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76282_Desc = {
    Text = "隊伍唯一：融痕刷新次數 +1 ，刷新價格減少 <WeaponEffect_Num:[StateArg1]> 點黑印。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76282_WeaponDesc = {
    Text = "融痕刷新次數 +1，刷新價格減少 <WeaponEffect_Num:[StateArg1]> 點黑印。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76283_Desc = {
    Text = "隊伍唯一：融痕造物欄變為 3 個，其中一個為詛咒造物。購買詛咒造物後獲得 <WeaponEffect_Num:[StateArg1]> 點黑印。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76283_WeaponDesc = {
    Text = "融痕造物欄變為 3 個，其中一個為詛咒造物。購買詛咒造物後獲得 <WeaponEffect_Num:[StateArg1]> 點黑印。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76284_Desc = {
    Text = "隊伍唯一：關卡開始後，所有喚醒體獲得 <WeaponEffect_Num:[StateArg1]> 點狂氣。首領戰開始後，抽 2 張牌。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76284_WeaponDesc = {
    Text = "關卡開始後，所有喚醒體獲得 <WeaponEffect_Num:[Energy:StateArg1]> 點狂氣。首領戰開始後，抽 2 張牌。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76285_Desc = {
    Text = "隊伍唯一：關卡開始後，獲得 <WeaponEffect_Num:[StateArg1]> 點銀鑰能量。首領戰開始後，獲得 2 點算力。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76285_WeaponDesc = {
    Text = "關卡開始後，獲得 <WeaponEffect_Num:[StateArg1]> 點銀鑰能量。首領戰開始後，獲得 2 點算力。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76286_Desc = {
    Text = "隊伍唯一：休息處額外提供一個選項：消除至多 3 張症狀，獲得 <WeaponEffect_Num:[StateArg1]> 點黑印。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76286_WeaponDesc = {
    Text = "休息處額外提供一個選項：消除至多 3 張症狀，獲得 <WeaponEffect_Num:[StateArg1]> 點黑印。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76287_Desc = {
    Text = "隊伍唯一：普通戰鬥結束後可選擇的刻印數量變為 4 個，裝備者卡牌的刻印有 <WeaponEffect_Num:[StateArg1]%> 機率升級為高級刻印。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76287_WeaponDesc = {
    Text = "普通戰鬥結束後可選擇的刻印數量變為 4 個，裝備者卡牌的刻印有 <WeaponEffect_Num:[StateArg1]%> 機率升級為高級刻印。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76288_Desc = {
    Text = "隊伍唯一：戰鬥結束後，獲得 <WeaponEffect_Num:[StateArg1]> 點銀鑰能量。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76288_WeaponDesc = {
    Text = "戰鬥結束後，獲得 <WeaponEffect_Num:[StateArg1]> 點銀鑰能量。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76289_Desc = {
    Text = "隊伍唯一：探索中視野+1，地圖視野全開後獲得 <WeaponEffect_Num:[StateArg1]> 點黑印。首領戰開始時，<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76289_WeaponDesc = {
    Text = "探索中視野+1，地圖視野全開後獲得 <WeaponEffect_Num:[StateArg1]> 點黑印。首領戰開始時，<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76290_Desc = {
    Text = "隊伍唯一：普通戰鬥結束後，可以選擇放棄刻印，生命上限提高 <WeaponEffect_Num:[StateArg1]%>。該效果最多生效 2 次。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76290_WeaponDesc = {
    Text = "普通戰鬥結束後，可以選擇放棄刻印，生命上限提高 <WeaponEffect_Num:[DescArg1]>。該效果最多生效 2 次。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76291_Desc = {
    Text = "隊伍唯一：關卡開始後，獲得 <WeaponEffect_Num:[StateArg1]> 點黑印。造物上限 +2。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76291_WeaponDesc = {
    Text = "關卡開始後，獲得 <WeaponEffect_Num:[StateArg1]> 點黑印。造物上限 +2。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76292_Desc = {
    Text = "隊伍唯一：融痕售賣卡牌處允許售賣症狀卡，賣出症狀卡後獲得 <WeaponEffect_Num:[StateArg1]> 點黑印。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76292_WeaponDesc = {
    Text = "融痕售賣卡牌處允許售賣症狀卡，賣出症狀卡後獲得 <WeaponEffect_Num:[StateArg1]> 點黑印。在星辰篇中，效果改為「使裝備者的維度影像造物出現的可能性提高 100％」。"
  },
  State_76321_Name = {
    Text = "棱彩透鏡"
  },
  State_76323_Name = {
    Text = "狂氣調和"
  },
  State_76324_Name = {
    Text = "算力調和"
  },
  State_76325_Desc = {
    Text = "打出 [DescArg1] 張指令卡後，進入「算力調和」狀態。"
  },
  State_76325_Name = {
    Text = "算力調和"
  },
  State_76326_Name = {
    Text = "存在悖論"
  },
  State_76328_Name = {
    Text = "命運光錐"
  },
  State_76337_Name = {
    Text = "無底創痕"
  },
  State_76338_Desc = {
    Text = "玩家受到的治療減少 [Layer]％。"
  },
  State_76338_Name = {
    Text = "無底創痕"
  },
  State_76430_Name = {
    Text = "維度影像·莉莉"
  },
  State_76433_Name = {
    Text = "算力調和"
  },
  State_76434_Desc = {
    Text = "每當打出指令卡時，若因算力調和額外消耗了算力，額外獲得 100% 喚醒體銀鑰充能的銀鑰能量，可疊加。"
  },
  State_76434_Name = {
    Text = "算力調和"
  },
  State_76435_Name = {
    Text = "棱彩透鏡"
  },
  State_76528_Name = {
    Text = "此卡視為「打擊」"
  },
  State_76529_Desc = {
    Text = "拾取時選擇一張喚醒體的卡牌，使其算力消耗降低 1，打出後抽 1 張牌，並將其視為「打擊」。"
  },
  State_76533_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合結束時，賦予對手的隨機 [StateArg1] 張手牌 [StateArg2]層<PVPAcheKeywords:隱沒的痛楚>。"
  },
  State_76533_Name = {
    Text = "隱沒的痛楚"
  },
  State_76553_Name = {
    Text = "百萬蒙寵之眼"
  },
  State_77686_Name = {
    Text = "半機械形態"
  },
  State_77688_Desc = {
    Text = "第五回合開始或即將死亡時，免疫死亡並將意圖調整為「機械飛昇」。"
  },
  State_77688_Name = {
    Text = "肉體孱弱"
  },
  State_77690_Desc = {
    Text = "切換為「半機械形態」後，每有 1 層終末，額外獲得 10％ 最大生命。「半機械形態」下「熔燬·朵爾」會隨著「終末」層數的增加釋放更具威脅性的技能。"
  },
  State_77690_Name = {Text = "終末"},
  State_77692_Desc = {
    Text = "回合結束時，召喚 2 個融蝕怪物，至多同時存在 2 個。召喚的融蝕怪物死亡後，「熔燬·朵爾」失去 5% 最大生命。"
  },
  State_77692_Name = {
    Text = "深淵之門"
  },
  State_77693_Desc = {
    Text = "死亡後「熔燬·朵爾」失去 5% 最大生命。"
  },
  State_77693_Name = {Text = "熔燬"},
  State_78102_Desc = {
    Text = "造成的傷害降低 15％，承受傷害提高 30％，持續至戰鬥結束。"
  },
  State_78102_Name = {
    Text = "超頻癱瘓"
  },
  State_78694_Desc = {
    Text = "戰鬥開始時獲得 [Arg1] 點力量。回合開始每有 [Arg2] 點永久力量獲得 [Arg3] 點臨時力量，最多獲得 [Arg4] 點臨時力量，並在回合結束時失去由該造物獲得臨時力量一半的護盾。"
  },
  State_78696_Desc = {
    Text = "使用銀鑰覺醒後選擇對應喚醒體的 [Arg1] 張「技能」將其消耗，並把 [Arg2] 張附加消耗的複製洗入抽牌堆。"
  },
  State_78697_Desc = {
    Text = "回合開始時，被施加 [Arg2] 層中毒，超維空間每有 1 個空位就獲得 [Arg1] 點力量。"
  },
  State_78698_Desc = {
    Text = "算力上限 -[Arg1]。每打出 1 張算力消耗大於等於 [Arg2] 的牌獲得一點算力，每回合最多觸發 [Arg3] 次。"
  },
  State_78699_Desc = {
    Text = "抽牌後額外抽 [Arg1] 張牌，但選擇 [Arg2] 張手牌棄掉。"
  },
  State_78700_Desc = {
    Text = "所有喚醒體的基礎傷害提高 [Arg1]%，每次重置牌庫額外提高 [Arg2]%，但將 1 張「蹣跚」置入手中，提高值最多為 [Arg3]%。"
  },
  State_78701_Desc = {
    Text = "回合開始時若有超過 [Arg1] 條的永久觸腕，失去 [Arg2] 條觸腕獲得 [Arg3] 條臨時觸腕，否則獲得 [Arg4] 條臨時觸腕。"
  },
  State_78702_Desc = {
    Text = "銀鑰覺醒後額外消耗 [Arg1] 點銀鑰能量，使獲得的靈知覺醒卡算力消耗變為 0，打出後使對應喚醒體額外獲得 [Arg2] 點狂氣。"
  },
  State_78703_Desc = {
    Text = "戰鬥開始時對所有敵人造成 [Arg1] 點中毒。回合開始前移除敵人 [Arg2]% 的中毒，對其施加 [Arg3]% 移除量的出血。"
  },
  State_78710_Desc = {
    Text = "每打出一張指令卡使對應喚醒體當回合造成最終傷害提高 [Arg1]%，但使其失去 [Arg2] 點狂氣，每回合最多觸發 [Arg3] 次。"
  },
  State_78712_Desc = {
    Text = "回合開始時胚胎融合度+ [Arg1]，你的胚胎會在回合結束時被棄掉。"
  },
  State_78713_Desc = {
    Text = "回合開始時獲得 [Arg1] 點反擊。在一回合內釋放 [Arg2] 次狂氣爆發後，移除自身 [Arg3]% 永久反擊，獲得 [Arg4]% 移除量的臨時反擊，[Arg5] 回合冷卻。"
  },
  State_78781_Desc = {
    Text = "臨時降低目標力量，獲得等量臨時力量。"
  },
  State_79405_Desc = {
    Text = "打出後「清明之憶」提高 1，達到 10 時將其鎖定 1 回合並獲得 3 張「靈感」，下回合開始時重置為 5。"
  },
  State_79405_Name = {
    Text = "真實的往昔"
  },
  State_79406_Desc = {
    Text = "打出後「清明之憶」降低 1，達到 0 時將其鎖定 1 回合並使所有喚醒體獲得 30 點狂氣，下回合開始時重置為 5。"
  },
  State_79406_Name = {
    Text = "浮華的迷夢"
  },
  State_80052_Desc = {Text = "測試"},
  State_80052_Name = {Text = "測試123"},
  State_80052_WeaponDesc = {Text = "測試"},
  State_80161_Desc = {
    Text = "隊伍唯一：裝備者狂氣爆發造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，銀鑰充能提高 <WeaponEffect_Num:[StateArg2]%>。進入超維回合後，所有喚醒體獲得 <WeaponEffect_Num:[StateArg4]> 點狂氣。釋放「湮滅」後，裝備者獲得 <WeaponEffect_Num:[StateArg3]> 點狂氣。"
  },
  State_80161_WeaponDesc = {
    Text = "裝備者狂氣爆發造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，銀鑰充能提高 <WeaponEffect_Num:[DescArg1]>。進入超維回合後，所有喚醒體獲得 <WeaponEffect_Num:[StateArg4]> 點狂氣。釋放「湮滅」後，裝備者獲得 <WeaponEffect_Num:[StateArg3]> 點狂氣。"
  },
  State_80174_Desc = {
    Text = "隊伍唯一：裝備者銀鑰充能提高 <WeaponEffect_Num:[StateArg1]%>。首場戰鬥開始後，對所有敵人施加 1 層虛弱和易傷。"
  },
  State_80174_WeaponDesc = {
    Text = "裝備者銀鑰充能提高 <WeaponEffect_Num:[DescArg1]>。首場戰鬥開始後，對所有敵人施加 1 層虛弱和易傷。"
  },
  State_80207_Desc = {
    Text = "若此卡打出後觸發「維度穿梭」則觸發後續效果，從超維空間取出時算力消耗 -1。"
  },
  State_80328_Desc = {
    Text = "她的情感、認知乃至一切，都與巢群意志永恆連結。至多堆疊 15 層。「共感」能夠被克萊門汀的狂氣爆發「生命重構治療」轉化為減益效果。"
  },
  State_80331_Desc = {
    Text = "巢群侵蝕下，你的弱點展露無遺。本回合承受的主動和觸腕傷害提高 [DescArg1]％。"
  },
  State_80331_Name = {
    Text = "<D13Colour:精神創傷>"
  },
  State_80332_Desc = {
    Text = "她的情感、認知乃至一切，都與巢群意志永恆連結，至多堆疊 10 層。「共感」能夠被克萊門汀的狂氣爆發「生命重構治療」轉化為減益效果。"
  },
  State_80335_Desc = {
    Text = "巢群侵蝕下，你的弱點展露無遺。本回合承受的主動和觸腕傷害提高 [DescArg1]％。"
  },
  State_80335_Name = {
    Text = "<D13Colour:精神創傷>"
  },
  State_80336_Desc = {
    Text = "巢群侵蝕下，你的恐懼無所遁形。本回合造成的主動和觸腕傷害降低 [DescArg1]％。"
  },
  State_80336_Name = {
    Text = "<D13Colour:恐懼固著>"
  },
  State_80338_Desc = {
    Text = "巢群侵蝕下，你的恐懼無所遁形。本回合造成的主動和觸腕傷害降低 [DescArg1]％。"
  },
  State_80338_Name = {
    Text = "<D13Colour:恐懼固著>"
  },
  State_80575_Desc = {
    Text = "承受主動傷害或觸腕傷害後，移除等量的「舊日餘燼」並失去 300％ 移除量的生命，承受其它傷害時移除一半。「舊日餘燼」層數每回合重置。"
  },
  State_80575_Name = {
    Text = "舊日餘燼"
  },
  State_80644_Name = {
    Text = "狀態@超越之光中"
  },
  State_80773_Desc = {
    Text = "承受力量降低效果時，僅會降低 50% 的力量層數。自身回合內，承受的非主動和觸腕傷害提高 100％。"
  },
  State_80773_Name = {
    Text = "異維抗體"
  },
  State_80774_Desc = {
    Text = "承受主動傷害或觸腕傷害後，移除等量的「舊日餘燼」並失去 300％ 移除量的生命，承受其它傷害時移除一半。「舊日餘燼」層數每回合重置。「舊日餘燼」被全部移除後，獲得 50 層「加固」。"
  },
  State_80774_Name = {
    Text = "舊日餘燼"
  },
  State_80777_Desc = {
    Text = "戰鬥開始時，降低所有喚醒體暴擊率 10％。死亡後，其它友方獲得 [DescArg1] 點力量和 [DescArg2] 層「舊日餘燼」。"
  },
  State_80777_Name = {
    Text = "巢群共感-傳承"
  },
  State_80778_Desc = {
    Text = "死亡後，其他友方獲得 1 層臨時<MadnessIconKeywords:瘋狂>。"
  },
  State_80782_Desc = {
    Text = "本場戰鬥中，所有喚醒體暴擊率降低 [Layer]％。"
  },
  State_80782_Name = {
    Text = "暴擊率降低"
  },
  State_80783_Desc = {
    Text = "回合結束時，獲得 1 層<MadnessIconKeywords:瘋狂>。"
  },
  State_80783_Name = {
    Text = "同族羈絆"
  },
  State_80784_Desc = {
    Text = "生命低於 50％ 後，召喚一名「初變者」在後方，每場戰鬥僅觸發 1 次。"
  },
  State_80784_Name = {
    Text = "巢群共感-裂變"
  },
  State_80785_Desc = {
    Text = "力量被降低時，僅會降低 50% 的力量層數。每當玩家釋放狂氣爆發，獲得 1 層臨時<MadnessIconKeywords:瘋狂>。"
  },
  State_80785_Name = {
    Text = "巢群共感-異維"
  },
  State_80788_Desc = {
    Text = "力量被降低時，僅會降低 25% 的力量層數。每當玩家釋放狂氣爆發，獲得 1 層臨時<MadnessIconKeywords:瘋狂>。"
  },
  State_80788_Name = {
    Text = "巢群共感-異維"
  },
  State_80789_Desc = {
    Text = "承受主動和觸腕傷害提高 100％，持續 1 回合。"
  },
  State_80789_Name = {Text = "蟄伏"},
  State_80790_Desc = {
    Text = "在蛻變後，每層宇宙幽能會使其變得完美……"
  },
  State_80792_Desc = {
    Text = "每當玩家釋放狂氣爆發，獲得 1 層臨時<MadnessIconKeywords:瘋狂>。"
  },
  State_80792_Name = {
    Text = "巢群共感-異維"
  },
  State_80794_Desc = {
    Text = "卡牌無法打出，且回合結束時依然保留在手中。"
  },
  State_80794_Name = {
    Text = "<Boundkeywords:縛身>"
  },
  State_80807_Desc = {
    Text = "第五回合開始或即將死亡時，移除所有其他敵人，將意圖切換為「蛻變之刻」。"
  },
  State_80807_Name = {
    Text = "蛻變之刻"
  },
  State_80809_Desc = {
    Text = "回合結束時，手中帶有虛無的牌會被丟棄。"
  },
  State_80809_Name = {
    Text = "<PVPVoidKeyColour:虛無>"
  },
  State_80810_Desc = {
    Text = "承受主動傷害或觸腕傷害後，移除等量的「舊日餘燼」並失去 300％ 移除量的生命，承受其它傷害時移除一半。「舊日餘燼」層數每回合重置。"
  },
  State_80810_Name = {
    Text = "舊日餘燼"
  },
  State_80827_Desc = {
    Text = "每累計打出 15 張卡牌，將當前的意圖替換為「創傷猛擊」（當前還剩 [Layer] 張)。"
  },
  State_80827_Name = {
    Text = "憤怒的懲罰"
  },
  State_81022_WeaponDesc = {
    Text = "每受到1次傷害，全體喚醒體增加 1 點狂氣。"
  },
  State_81027_Desc = {
    Text = "此卡牌的所屬者為「蟲族」，算力消耗-1，打出後會被「消耗」。"
  },
  State_81027_Name = {
    Text = "生命儀式"
  },
  State_81054_Desc = {
    Text = "巢群侵蝕下，你的恐懼無所遁形。每擁有 1 層本回合造成的主動和觸腕傷害傷害降低 3％，至多堆疊 15 層。"
  },
  State_81054_Name = {
    Text = "<D13AFKeyWordQ1:恐懼固著>"
  },
  State_81055_Desc = {
    Text = "巢群侵蝕下，你的恐懼無所遁形。每擁有 1 層本回合承受的主動和觸腕傷害傷害提高 3％，至多堆疊 10 層。"
  },
  State_81055_Name = {
    Text = "<D13AFKeyWord2:精神創傷>"
  },
  State_81056_Desc = {
    Text = "巢群侵蝕下，你的恐懼無所遁形。每擁有 1 層本回合承受的主動和觸腕傷害傷害提高 3％，至多堆疊 15 層。"
  },
  State_81056_Name = {
    Text = "<D13AFKeyWordQ2:精神創傷>"
  },
  State_81057_Desc = {
    Text = "巢群侵蝕下，你的恐懼無所遁形。每擁有 1 層本回合造成的主動和觸腕傷害傷害降低 3％，至多堆疊 10 層。"
  },
  State_81057_Name = {
    Text = "<D13AFKeyWord1:恐懼固著>"
  },
  State_81058_Desc = {
    Text = "她的情感、認知乃至一切，都與巢群意志永恆連結。「共感」能夠被克萊門汀的狂氣爆發「生命重構治療」轉化為減益效果，至多堆疊 15 層。"
  },
  State_81059_Desc = {
    Text = "她的情感、認知乃至一切，都與巢群意志永恆連結。「共感」能夠被克萊門汀的狂氣爆發「生命重構治療」轉化為減益效果，至多堆疊 10 層。"
  },
  State_81073_Desc = {
    Text = "受到致命傷害後立刻回復所有生命並獲得 80％ 臨時加固，召喚一名「初變者」在後方，可觸發 2 次。"
  },
  State_81073_Name = {
    Text = "巢群共感-裂變"
  },
  State_81278_Desc = {
    Text = "每回合首次釋放鑰令後，所有喚醒體獲得 10 狂氣，但釋放鑰令消耗永久提高 10%。"
  },
  State_81278_Name = {
    Text = "銀鑰抑制"
  },
  State_81312_Desc = {
    Text = "受到致命傷害後，回復所有生命並獲得 50 層臨時加固。還能夠觸發 [Layer] 次。"
  },
  State_81312_Name = {
    Text = "宇宙輪回"
  },
  State_81331_Desc = {
    Text = "回合開始時，選擇 1 名喚醒體，封印其所有卡牌和狂氣爆發 3 回合。"
  },
  State_81331_Name = {
    Text = "意識幽禁"
  },
  State_81340_Desc = {
    Text = "此卡牌被封印無法打出， [Layer] 回合後封印解除。"
  },
  State_81341_Desc = {
    Text = "此喚醒體狂氣爆發被封印無法使用， [Layer] 回合後封印解除。"
  },
  State_81341_Name = {
    Text = "<Seal1:狂氣封印>"
  },
  State_81354_Desc = {
    Text = "打出後受到 [DescArg1] 點傷害，若回合結束時未打出會被消耗。"
  },
  State_81354_Name = {
    Text = "<BurningKeywords:燃燒>"
  },
  State_81356_Desc = {
    Text = "使卡牌燃燒，打出後受到 [DescArg1] 點傷害，若回合結束仍在手中將其消耗。"
  },
  State_81356_Name = {
    Text = "<BurningKeywords:燃燒>"
  },
  State_81356_WeaponDesc = {
    Text = "每層遲緩使卡牌的算力消耗增加 1 點。"
  },
  State_83587_Desc = {
    Text = "能夠提升選擇「破浪啟航」時的效果，上限10層。"
  },
  State_83587_Name = {
    Text = "「揚帆」"
  },
  State_83589_Desc = {
    Text = "能夠提升選擇「攏岸暫息」時的效果，上限10層。"
  },
  State_83589_Name = {
    Text = "「泊錨」"
  },
  State_83593_Desc = {
    Text = "本回合所有喚醒體造成的最終傷害提高"
  },
  State_83593_Name = {
    Text = "最終傷害"
  },
  State_83596_Desc = {
    Text = "手牌上限+1。回合開始時若牌庫沒有「引航員的抉擇」，將其置入手中。每當首領失去 10% 最大生命，獲得 1 層「揚帆」；每當自身失去 10% 最大生命，獲得 1 層「泊錨」。"
  },
  State_83596_Name = {
    Text = "伊拉斯莫的指引-「揚帆」"
  },
  State_83607_Desc = {
    Text = "首領累積損失百分之十生命標識"
  },
  State_83607_Name = {
    Text = "狀態@首領累積損失百分之十生命標識"
  },
  State_83609_Desc = {
    Text = "玩家累積損失百分之十生命標識"
  },
  State_83609_Name = {
    Text = "狀態@玩家累積損失百分之十生命標識"
  },
  State_83614_Name = {
    Text = "狀態@玩家百分之十血量值"
  },
  State_83615_Desc = {
    Text = "失去 [Layer] 點生命後，獲得 1 層「揚帆」。"
  },
  State_83615_Name = {
    Text = "「揚帆」進度"
  },
  State_83616_Desc = {
    Text = "失去 [Layer] 點生命後，獲得 1 層「泊錨」。"
  },
  State_83616_Name = {
    Text = "「泊錨」進度"
  },
  State_83617_Desc = {
    Text = "首領10%血量值"
  },
  State_83617_Name = {
    Text = "狀態@首領百分之十血量值"
  },
  State_83618_Desc = {
    Text = "測試時當前生命為 [Layer] 點。"
  },
  State_83618_Name = {
    Text = "敵人當前生命計數"
  },
  State_83619_Desc = {
    Text = "測試時最大生命為 [Layer] 點。"
  },
  State_83619_Name = {
    Text = "敵人最大生命計數"
  },
  State_83620_Desc = {
    Text = "當前參數4的值乘100為 [Layer] 點。"
  },
  State_83620_Name = {
    Text = "參數打印"
  },
  State_83621_Desc = {
    Text = "首領百分之十血量損失計數中間值"
  },
  State_83621_Name = {
    Text = "狀態@首領百分之十血量損失計數中間值"
  },
  State_83622_Desc = {
    Text = "玩家百分之十血量損失計數中間值"
  },
  State_83622_Name = {
    Text = "狀態@玩家百分之十血量損失計數中間值"
  },
  State_83627_Desc = {
    Text = "失去[DescArg1]點生命後，獲得1層「揚帆」"
  },
  State_83627_Name = {
    Text = "「揚帆」進度"
  },
  State_83805_Name = {Text = "餘波"},
  State_83807_Name = {
    Text = "沉沒於遠海"
  },
  State_83808_Desc = {
    Text = "此卡牌被棄置時，觸發「餘波」效果。"
  },
  State_83808_Name = {
    Text = "<RippleKeywords:餘波>"
  },
  State_83811_Desc = {
    Text = "額外承受 [Layer]％ 觸腕傷害。"
  },
  State_83812_Desc = {
    Text = "額外承受 [Layer]％ 觸腕傷害。"
  },
  State_83814_Desc = {
    Text = "首領10%血量值"
  },
  State_83814_Name = {
    Text = "首領百分之十血量值"
  },
  State_84140_Desc = {
    Text = "本場戰鬥已通過「喧囂海洋」消耗了 [Layer] 張「腺體分裂」。"
  },
  State_84140_Name = {
    Text = "喧囂海洋"
  },
  State_84184_Name = {
    Text = "該技能額外享受 [Layer]％ 力量加成"
  },
  State_84255_Desc = {
    Text = "隊伍唯一：戰鬥開始時，獲得等同於裝備者防禦力 <WeaponEffect_Num:[StateArg1]%> 的護盾。觸發死亡抵抗後，下回合開始時再次觸發該效果。"
  },
  State_84255_Name = {
    Text = "海上領航者"
  },
  State_84255_WeaponDesc = {
    Text = "戰鬥開始時，獲得 <WeaponEffect_Num:[Block:DescArg1]> 點護盾。觸發死亡抵抗後，下回合開始時再次觸發該效果。"
  },
  State_84257_Desc = {
    Text = "隊伍唯一：裝備者狂氣爆發造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>，釋放狂氣爆發後所有喚醒體臨時暴擊傷害提高 <WeaponEffect_Num:[StateArg2]%>，每有 1 條觸腕額外提高 1％。每次探索首次觸發死亡抵抗後，下回合開始時回復最大生命的 <WeaponEffect_Num:[StateArg3]%>"
  },
  State_84257_WeaponDesc = {
    Text = "裝備者狂氣爆發造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>，釋放狂氣爆發後所有喚醒體臨時暴擊傷害提高 <WeaponEffect_Num:[StateArg2]%>，每有 1 條觸腕額外提高 1％。每次探索首次觸發死亡抵抗後，下回合開始時回復最大生命的 <WeaponEffect_Num:[StateArg3]%>。"
  },
  State_84272_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，回復損失生命最多的友方 <Heal:[Heal:StateArg1]> 生命。"
  },
  State_84272_Name = {
    Text = "海上領航者"
  },
  State_84273_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合開始時，若自身沒有<PVPProtectiveKeywords:屏障>獲得 [StateArg1] 層<PVPProtectiveKeywords:屏障>，否則獲得 <Energy:[Energy:StateArg2]> 狂氣。"
  },
  State_84273_Name = {
    Text = "聖火中的指引"
  },
  State_84364_Desc = {
    Text = "暴擊傷害 +[Layer]%。"
  },
  State_84364_Name = {
    Text = "暴擊傷害"
  },
  State_84368_Desc = {
    Text = "剩餘 [Layer] 回合冷卻。"
  },
  State_84368_Name = {
    Text = "沉沒於遠海"
  },
  State_84375_Desc = {
    Text = "回合開始時，獲得 [Layer] 點護盾。"
  },
  State_84375_Name = {
    Text = "海上領航者"
  },
  State_84376_Desc = {
    Text = "回合開始時，治療 [Layer] 點生命。"
  },
  State_84376_Name = {
    Text = "聖火中的指引"
  },
  State_84399_Desc = {
    Text = "每回合結束時承受傷害提高 5% ，自身獲得 2 層屏障。"
  },
  State_84399_Name = {
    Text = "沉沒於遠海"
  },
  State_84400_Desc = {
    Text = "下回合開始時每層屏障轉化為 1 層<ReinforcePVEKeywords:加固>。"
  },
  State_84400_Name = {
    Text = "「領航」"
  },
  State_84402_Desc = {
    Text = "承受的所有傷害提高 [Layer]%。"
  },
  State_89340_Desc = {
    Text = "額外承受 [Layer]％ 觸腕傷害。"
  },
  State_89340_Name = {
    Text = "觸腕易傷"
  },
  State_89422_Desc = {
    Text = "所有喚醒體產生的狂氣提高 100%，每回合能夠釋放 2 次狂氣爆發。"
  },
  State_89447_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：手牌上限 + [StateArg3]。「狂氣爆發」後手中基礎算力消耗為 [StateArg1] 的「技能」算力消耗減少 [StateArg2]。"
  },
  State_89448_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時使生命和護盾最低的友方獲得  [StateArg1]  張<PVPDerivativeCardKeywords_16:「黑羽」>。"
  },
  State_89554_Name = {
    Text = "命運光錐"
  },
  State_89555_Desc = {
    Text = "隊伍唯一：裝備者釋放狂氣爆發後，使狂氣爆發基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，護盾和生命回覆提高 <WeaponEffect_Num:[StateArg2]%>，至多疊加 5 次。裝備者探索所獲得的同調率提高 <WeaponEffect_Num:[StateArg3]%>。"
  },
  State_89555_WeaponDesc = {
    Text = "裝備者釋放狂氣爆發後，使狂氣爆發基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，護盾和生命回復提高 <WeaponEffect_Num:[StateArg2]%>，至多疊加 5 次。完成探索後，裝備者獲得的同調率提高 <WeaponEffect_Num:[StateArg3]%>。"
  },
  State_89557_Name = {
    Text = "棱彩透鏡"
  },
  State_89559_Desc = {
    Text = "\n·存在悖論：探索開始時，死亡抵抗的 75％ 轉換為最大生命值加成，至多轉換 300％ 死亡抵抗，至多提升 10％ 最大生命值。每次觸發死亡抵抗額外將 1 張「銀鑰微光」置入手中。\n·無底創痕：首領戰中，我方受到的生命回覆量每達到生命上限的 100%，就降低後續受到的生命回覆效果 25%，但使當前死亡抵抗總量提高 25%，最多觸發 3 次。\n·稜彩透鏡：回合開始時，若反擊超過 2000％ 生命上限，將超出部分層數減半，且永久反擊至多堆疊 6000％ 生命上限；若敵人中毒超過 3000％ 生命上限，將超出部分層數減半，且中毒至多堆疊至 9000％ 生命上限。喚醒體根據反擊獲得的傷害加成量降低 70%，但造成的所有中毒與反擊提高 10%。每覺醒一個喚醒體：回合結束後獲得 25% 當前永久反擊的臨時反擊，敵方回合結束時額外觸發所有敵人 25% 中毒。\n·命運光錐：普通怪物釋放「凝視」的回合數變為 6 回合。第 15 回合開始時，將 1 張「光錐界限」置入手中：將銀鑰能量和所有喚醒體的狂氣填充至最大值。"
  },
  State_89559_Name = {
    Text = "時空扭曲"
  },
  State_89567_Name = {
    Text = "重生於湮土"
  },
  State_89568_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備者死亡後，將自身算力消耗 -[StateArg1] 的所有「技能」洗入抽牌堆，所屬者改為剩餘生命最高友方。"
  },
  State_89568_Name = {
    Text = "重生於湮土"
  },
  State_89571_Name = {
    Text = "「燃燒的劇場」"
  },
  State_89572_Desc = {
    Text = "回合開始時，對手牌堆隨機 [DescArg1] 張牌附加<BurningKeywords:燃燒>，並獲得 [DescArg2] 點臨時力量。每過 2 個回合，附加燃燒的卡牌數提高 1，獲得的臨時力量提高 [DescArg3] 點。"
  },
  State_89572_Name = {
    Text = "「燃燒的劇場」"
  },
  State_89626_Desc = {
    Text = "使用銀鑰覺醒後，將 1 張「銀鑰微光」置入手中。所有喚醒體覺醒完成後，每回合開始時發現隨機 1 張喚醒體的支援。"
  },
  State_89631_Desc = {
    Text = "額外 [Layer] 次躍遷"
  },
  State_89634_Desc = {
    Text = "靈知覺醒4"
  },
  State_89634_Name = {
    Text = "靈知覺醒4"
  },
  State_89637_Desc = {
    Text = "每回合第 1 張指令卡額外生效 1 次。湮滅時生成 1 條觸腕。切換觸腕為「怒濤」姿態後，本回合下 2 張指令卡躍遷效果必定發動並進入超維空間，3 回合冷卻。"
  },
  State_89640_Desc = {
    Text = "界域精通提高 200 點。消耗猩紅熔爐時，提高消耗量 15% 的觸腕傷害。每次觸腕攻擊時，積累 [Arg3] 點猩紅熔爐。"
  },
  State_89642_Desc = {
    Text = "手牌上限 +2 ，釋放狂氣爆發後臨時最終傷害提高 10% 。卡牌進入超維空間後，手中 1 個「胚胎」轉化為「聖潔之子」。每生成 1 個「胚胎」，超維空間一張隨機卡牌算力消耗降低 1。"
  },
  State_89669_Desc = {
    Text = "銀鑰覺醒4"
  },
  State_89669_Name = {
    Text = "銀鑰覺醒4"
  },
  State_89759_Desc = {
    Text = "釋放鑰令後，拉蒙娜獲得 50％ 臨時暴擊率。"
  },
  State_89759_Name = {
    Text = "珍貴的羈絆"
  },
  State_90023_Name = {
    Text = "常量表配置用的狀態，暫時廢棄了。"
  },
  State_90059_Desc = {
    Text = "本回合承受主動或觸腕傷害時，移除等量侵蝕並失去移除量的 [DescArg1]％ 生命，承受其它傷害時移除 50% 傷害量的侵蝕。"
  },
  State_90059_Name = {Text = "侵蝕"},
  State_90218_Desc = {
    Text = "隊伍唯一：手牌上限+2，同類效果無法疊加。裝備者造成的護盾和基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，進入超維回合後獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣。釋放「湮滅」後所有喚醒體臨時暴擊傷害+<WeaponEffect_Num:[StateArg3]%>，3 回合冷卻。"
  },
  State_90218_WeaponDesc = {
    Text = "手牌上限+2，同類效果無法疊加。裝備者造成的護盾和基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，進入超維回合後獲得 <WeaponEffect_Num:[StateArg2]> 點狂氣。釋放「湮滅」後所有喚醒體臨時暴擊傷害+<WeaponEffect_Num:[StateArg3]%>，3 回合冷卻。"
  },
  State_90221_Desc = {
    Text = "隊伍唯一：裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>，回合結束時獲得裝備者防禦力 <WeaponEffect_Num:[StateArg2]%> 的護盾，每回合提高防禦力的 2％。"
  },
  State_90221_WeaponDesc = {
    Text = "裝備者造成的護盾提高 <WeaponEffect_Num:[StateArg1]%>，回合結束時獲得 <WeaponEffect_Num:[Block:DescArg1]> 點護盾。"
  },
  State_90294_Desc = {
    Text = "本回合承受主動或觸腕傷害時，移除等量侵蝕並失去移除量的 [DescArg1]％ 生命，承受其它傷害時移除 50% 傷害量的侵蝕。"
  },
  State_90294_Name = {
    Text = "<Corrosion:侵蝕>"
  },
  State_90591_Name = {
    Text = "將 [Layer] 張「靈感」置入手中"
  },
  State_90594_Name = {
    Text = "和 [Layer] 點臨時戒備"
  },
  State_90599_Name = {
    Text = "使所有喚醒體獲得 [Layer] 點狂氣"
  },
  State_90600_Name = {
    Text = "獲得 [Layer] 點銀鑰能量"
  },
  State_90601_Name = {
    Text = "(剩餘 [DescArg1] 次<harmonyKeyWord:「調和」>)"
  },
  State_90603_Name = {
    Text = "獲得 [Layer] 點臨時力量"
  },
  State_90604_Name = {
    Text = "回復 [Layer] 點生命，隨已損生命提升。"
  },
  State_90696_Desc = {
    Text = "打出前發現 1 味「調料」置入其中並觸發其效果，首領戰中增加 1 次調和次數。"
  },
  State_90696_Name = {
    Text = "<harmonyKeyWord:調和>"
  },
  State_91106_Desc = {
    Text = "每層狂熱使造成的主動傷害和觸腕傷害附帶 10% 傷害等量的<BleedingIconKeywords:出血>。"
  },
  State_91106_Name = {Text = "狂熱"},
  State_91165_Name = {
    Text = "蒼白之卵"
  },
  State_91235_Desc = {
    Text = "失去生命時減少等量數層，傷勢歸 0 時，所有喚醒體獲得 10 狂氣，重置傷勢層數。"
  },
  State_91235_Name = {Text = "傷勢"},
  State_91236_Name = {
    Text = "羅馬活動施加首領生命計數"
  },
  State_91329_Name = {Text = "珍饈"},
  State_91521_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，將 [StateArg1] 張<PVPDerivativeCardKeywords_17:「靈感」>置入手牌。"
  },
  State_91521_Name = {
    Text = "搭檔特訓"
  },
  State_91522_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時與回合結束時、裝備者對後排敵方造成 <Damage:[Damage:StateArg1]> 傷害。"
  },
  State_91522_Name = {Text = "開學日"},
  State_91676_Desc = {
    Text = "具體效果看通用打擊邏輯。__「僅開發用」"
  },
  State_91706_Desc = {
    Text = "在下回合開始時獲得等量層數算力。"
  },
  State_91717_Desc = {
    Text = "至多積攢 3 具，達到上限後下次「生靈的盛宴」能夠將其食用並強化其效果。殘骸會繼承至下場戰鬥。"
  },
  State_91717_Name = {Text = "殘骸"},
  State_91759_Desc = {
    Text = "黑羽能夠加強「聖子·黑羽」的能力。"
  },
  State_91761_Desc = {
    Text = "「聖子·黑羽」未被擊破護盾的 50% 會保留至下回合，回合結束後獲得 1 層<Guaiwuheiyu:黑羽>。"
  },
  State_91761_Name = {
    Text = "翱翔夙願"
  },
  State_91797_Desc = {
    Text = "此牌打出後和被棄置後為前排敵方施加等量層數護盾。"
  },
  State_91797_Name = {
    Text = "<PVPredKeyword:隱沒的痛楚>"
  },
  State_91799_Desc = {
    Text = "此牌打出後為前排敵方施加 [Layer] 護盾。"
  },
  State_91799_Name = {
    Text = "<PVPredKeyword:隱沒的痛楚 [Layer] >"
  },
  State_91809_Name = {
    Text = "專注精神"
  },
  State_91819_Desc = {
    Text = "根據戰鬥當前的回合數獲得對應變化。"
  },
  State_91819_Name = {
    Text = "<CardKeyWord:成長>"
  },
  State_91827_Desc = {
    Text = "「打擊」可以選擇目標，「打擊」前擊退目標所有正面狀態到其身後喚醒體。"
  },
  State_91827_Name = {
    Text = "<CardKeyWord:深海的呼喚>"
  },
  State_94410_Name = {
    Text = "每次回合開始和行動結束後會試圖重置空的玩家牌庫，若不為空則不重置。__「僅開發用」"
  },
  State_94411_Name = {
    Text = "每次回合開始和行動結束後會試圖重置空的玩家牌庫，若不為空則不重置。__「僅開發用」"
  },
  State_94426_Name = {
    Text = "被動護盾__「僅開發用」"
  },
  State_94540_Desc = {
    Text = "若目標背後沒有其他喚醒體，則驅散目標正面狀態。"
  },
  State_94540_Name = {
    Text = "<CardKeyWord:擊退正面狀態>"
  },
  State_94600_Desc = {
    Text = "受到致死傷害後移除 1 層並回復最大生命的 5%，本回合內每次觸發使恢復量提高 1%。"
  },
  State_94603_Name = {
    Text = "食屍鬼標記"
  },
  State_94608_Name = {
    Text = "死亡抵抗承觸發次數"
  },
  State_94623_Desc = {
    Text = "每層狂熱使造成的主動傷害和觸腕傷害附帶 10% 傷害等量的<BleedingIconKeywords:出血>。"
  },
  State_94623_Name = {
    Text = "<Kuangre:狂熱>"
  },
  State_94657_Desc = {
    Text = "擊殺或觸發敵人復活效果時，觸發對應效果"
  },
  State_94657_Name = {
    Text = "<KillKeywords:擊破>"
  },
  State_94692_Desc = {
    Text = "受到致死傷害後移除 1 層並回復最大生命的 5%，本回合內每次觸發使恢復量提高 1%。"
  },
  State_94693_Desc = {
    Text = "回合開始時，若存在其他友方，失去 [DescArg1] 點生命，為生命最高友方增加 1 層<Guaiwusiwangdikang: 死亡抵抗>和 [DescArg2] 點 <PowerIconKeywords:力量>。"
  },
  State_94693_Name = {
    Text = "腐屍的分食"
  },
  State_94708_Desc = {
    Text = "回合開始時，若存在其他友方，失去 [DescArg1] 點生命，為生命最高友方增加 1 層<Guaiwusiwangdikang: 死亡抵抗>和 [DescArg2] 點<Duren:毒刃>。"
  },
  State_94730_Desc = {
    Text = "造成未被格擋的主動傷害時，施加 [Layer] 點<IntoxicationIconKeywords: 中毒>。"
  },
  State_94993_Desc = {
    Text = "每回合重置驚天怒濤次數。"
  },
  State_94993_Name = {
    Text = "驚天怒濤次數重置"
  },
  State_94994_Desc = {
    Text = "每層使攻擊次數加1，受到暴擊傷害失去 1 層，最低為 1 層，在回合結束時失去全部。"
  },
  State_94994_Name = {
    Text = "驚天怒濤次數"
  },
  State_94995_Desc = {
    Text = "每次受到暴擊傷害，獲得 3％ 的<Baojidikang:臨時暴擊抵抗>。每次造成傷害都會對一張隨機卡牌附加「深潛印記」。"
  },
  State_94995_Name = {
    Text = "深海祭禮"
  },
  State_94996_Desc = {
    Text = "受到攻擊時，獲得等量層數的臨時力量。"
  },
  State_94997_Desc = {
    Text = "每次受到暴擊傷害，獲得 5％ 的<Baojidikang:臨時暴擊抵抗>。每次造成傷害都會對一張隨機卡牌附加「深潛印記」。"
  },
  State_94997_Name = {
    Text = "深海祭禮"
  },
  State_94998_Desc = {
    Text = "觸發<Guaiwusiwangdikang: 死亡抵抗>時，對抽牌堆或手牌堆一張隨機卡牌施加<SlowIconKeywords:遲緩>。"
  },
  State_94998_Name = {
    Text = "絕望化身"
  },
  State_94999_Desc = {
    Text = "每回合重置噬天巨浪次數。"
  },
  State_94999_Name = {
    Text = "噬天巨浪次數重置"
  },
  State_95000_Desc = {
    Text = "免疫負面狀態。"
  },
  State_95000_Name = {
    Text = "負面狀態免疫"
  },
  State_95001_Desc = {
    Text = "每層使攻擊次數加1，受到暴擊傷害失去 1 層，最低為 1 層，在回合結束時失去全部。"
  },
  State_95001_Name = {
    Text = "噬天巨浪次數"
  },
  State_95002_Desc = {
    Text = "本回合內受到暴擊機率降低 [Layer]%。"
  },
  State_95002_Name = {
    Text = "臨時暴擊抵抗"
  },
  State_95002_WeaponDesc = {
    Text = "本回合內受到暴擊機率降低 [Layer]%。"
  },
  State_95035_Desc = {
    Text = "造成未被格擋的主動傷害時，每有 1 層施加 1 點<IntoxicationIconKeywords: 中毒>。"
  },
  State_95038_Desc = {
    Text = "受到攻擊時，獲得等量層數的臨時力量。"
  },
  State_95040_Desc = {
    Text = "記錄已損失生命"
  },
  State_95040_Name = {
    Text = "記錄已損失生命"
  },
  State_95932_Name = {
    Text = "吸取食屍鬼等待"
  },
  State_95937_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後抽 [StateArg1] 張牌，優先抽取自身「技能」，並其算力消耗 - [StateArg2] 。"
  },
  State_95937_Name = {Text = "珍饈"},
  State_95938_Desc = {
    Text = "每移除一張牌，饜足層數+1，上限10層"
  },
  State_95938_Name = {Text = "饜足"},
  State_95943_Desc = {
    Text = "造成的傷害臨時降低 30%。"
  },
  State_95943_Name = {
    Text = "正面干擾"
  },
  State_95944_Desc = {
    Text = "隊伍唯一：裝備者造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，每造成 1 次擊殺就使裝備者本次探索內暴擊率提高 2％ 且狂氣爆發造成的基礎傷害提高 <WeaponEffect_Num:[StateArg2]%>，至多疊加 10 次。若當前界域為「血肉」，對裝備者直接使用「胚胎」時額外獲得 <WeaponEffect_Num:[StateArg4]> 點狂氣，3 回合冷卻。"
  },
  State_95944_WeaponDesc = {
    Text = "裝備者造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，每造成 1 次擊殺就使裝備者本次探索內暴擊率提高 2％ 且狂氣爆發造成的基礎傷害提高 <WeaponEffect_Num:[StateArg2]%>，至多疊加 10 次。若當前界域為「血肉」，對裝備者直接使用「胚胎」時額外獲得 <WeaponEffect_Num:[StateArg4]> 點狂氣，3 回合冷卻。"
  },
  State_95948_Name = {
    Text = "吸取食屍鬼"
  },
  State_95949_Desc = {
    Text = "打出後使杜勒賽因失去一半<Guaiwucanhai:殘骸>。"
  },
  State_95949_Name = {
    Text = "偷襲儲備"
  },
  State_95953_Desc = {
    Text = "死亡抵抗的回復生命效果提高為 5 倍。"
  },
  State_95953_Name = {
    Text = "溟夢之帷"
  },
  State_95954_Name = {
    Text = "吸取食屍鬼覺醒版"
  },
  State_95960_Desc = {
    Text = "殘骸數量會提高「殘骸收取」的效果。"
  },
  State_95960_Name = {Text = "殘骸"},
  State_95962_Name = {
    Text = "擊殺數__「僅開發用」"
  },
  State_95964_Desc = {
    Text = "隊伍唯一：裝備者造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。若當前界域為「血肉」，裝備者擊殺敵方時積攢裝備者攻擊力 <WeaponEffect_Num:[StateArg2]%> 的猩紅熔爐。"
  },
  State_95964_WeaponDesc = {
    Text = "裝備者造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。若當前界域為「血肉」，裝備者擊殺敵方時積攢 <WeaponEffect_Num:[DescArg1]> 點猩紅熔爐。"
  },
  State_95966_Desc = {
    Text = "下回合開始時，抽 [Layer] 張牌該喚醒體卡牌。"
  },
  State_95966_Name = {
    Text = "殘忍的致意"
  },
  State_95967_Desc = {
    Text = "殘骸數量會提高「殘骸收取」的效果。"
  },
  State_95967_Name = {
    Text = "<Guaiwucanhai:殘骸>"
  },
  State_95968_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [StateArg1] <StrongEffectKeywords:強效>。擊殺敵方時溢出的傷害將向後方喚醒體傳遞。"
  },
  State_96167_Desc = {
    Text = "不可驅散，喚醒體被擊殺後，其他友方獲得 [StateArg1] <StrongEffectKeywords:強效>。"
  },
  State_96167_Name = {
    Text = "黑星燃燒之燼"
  },
  State_96183_Desc = {
    Text = "回合結束時，若場上沒有其他友方，切換意圖為自爆"
  },
  State_96183_Name = {
    Text = "食屍鬼自爆"
  },
  State_96193_Name = {
    Text = "餐前禮儀"
  },
  State_96330_Desc = {
    Text = "自身每損失 1％ 生命，杜勒賽因指令卡造成的基礎傷害、護盾、狂氣提高 1％。"
  },
  State_96330_Name = {
    Text = "幽魂絮語"
  },
  State_96352_Name = {
    Text = "最初的食屍鬼計數"
  },
  State_96355_Desc = {
    Text = "受到暴擊機率降低 [Layer]%。"
  },
  State_96355_Name = {
    Text = "暴擊抵抗"
  },
  State_96355_WeaponDesc = {
    Text = "本場戰鬥內受到暴擊機率降低 [Layer]%。"
  },
  State_96356_Desc = {
    Text = "每失去 [DescArg1] 點生命，獲得 [DescArg2] 層<ReinforcePVEKeywords:加固>，最大為 [DescArg3]  層。觸發「<Guaiwusiwangdikang:死亡抵抗>」後自身最大生命提高 [DescArg4] %。"
  },
  State_96356_Name = {
    Text = "伊萊娜的庇佑"
  },
  State_96357_Desc = {
    Text = "回合結束後，獲得等量層數的力量。"
  },
  State_96357_Name = {
    Text = "<Fennu: 憤怒>"
  },
  State_96358_Desc = {
    Text = "受到暴擊機率降低 [Layer] %。"
  },
  State_96358_Name = {
    Text = "<Baojidikang:暴擊抵抗>"
  },
  State_96412_Name = {
    Text = "饕餮監聽"
  },
  State_96416_Desc = {
    Text = "受到暴擊機率降低 [Layer]%。"
  },
  State_96416_Name = {
    Text = "暴擊抵抗"
  },
  State_96603_Name = {
    Text = "若本回合未打出，下回合開始時觸發 1 次「調和」效果"
  },
  State_96613_Name = {
    Text = "巨浪監聽"
  },
  State_96650_Desc = {
    Text = "每層使所有喚醒體暴擊率提高 [DescArg1]%。"
  },
  State_96719_Desc = {
    Text = "本回合打出<BurningKeywords:燃燒>的卡牌時，消耗 1 層<Heat:深暗之焰>使其生效 2 次，回合結束後清空<Heat:深暗之焰>。"
  },
  State_96719_Name = {
    Text = "無盡的爆炎"
  },
  State_96731_Desc = {
    Text = "本回合打出<BurningKeywords:燃燒>的卡牌時，消耗 1 層<Heat:深暗之焰>使其生效 2 次，回合結束後清空<Heat:深暗之焰>。"
  },
  State_96731_Name = {
    Text = "<Overload:無盡的爆炎>"
  },
  State_96732_Desc = {
    Text = "每層使所有喚醒體暴擊率提高 [DescArg1]%。"
  },
  State_96740_Desc = {
    Text = "受到的主動攻擊傷害和出血層數提高 50%，受到傷害和回合開始時移除。"
  },
  State_96740_Name = {
    Text = "<CardKeyWord:破綻>"
  },
  State_96741_Desc = {
    Text = "打出後若剩餘算力大於 [StateArg1] ，額外消耗 [StateArg1] 算力觸發後續效果。__「僅開發用」"
  },
  State_96741_Name = {
    Text = "<CardKeyWord:算力超載>__「僅開發用」"
  },
  State_96742_Name = {
    Text = "算力超載觸發標記__「僅開發用」"
  },
  State_96743_Desc = {
    Text = "打出後若剩餘算力大於算力超載所需算力，額外消耗算力觸發後續效果。"
  },
  State_96743_Name = {
    Text = "<CardKeyWord:算力超載>"
  },
  State_96744_Desc = {
    Text = "受到的主動攻擊傷害和出血層數提高 50%，受到傷害和回合開始時移除。"
  },
  State_96744_Name = {Text = "破綻"},
  State_96774_Desc = {
    Text = "每次受到暴擊傷害，獲得 3% 的臨時暴擊抵抗。"
  },
  State_96774_Name = {
    Text = "深海怨靈"
  },
  State_96780_Desc = {
    Text = "卡牌獲得保留，但打出或棄掉後會移除污染並召喚 1 個「深海分殖體」，最多 2 個。若無位置召喚會立刻使腐潮之傀獲得 [DescArg1] 點力量和 [DescArg2] 點生命。"
  },
  State_96780_Name = {
    Text = "<Kuangluan:蹈海者狂亂>"
  },
  State_96783_Desc = {
    Text = "每回合為 2 張卡牌附加「<Kuangluan:蹈海者狂亂>」。"
  },
  State_96783_Name = {
    Text = "蹈海者祭儀"
  },
  State_96784_Desc = {
    Text = "能夠降低腐潮之傀的攻勢，最大為 5 層。"
  },
  State_96784_Name = {Text = "混亂"},
  State_96808_Desc = {
    Text = "每失去 [DescArg1] 生命就獲得 15 層「<ReinforcePVEKeywords:加固>」，上限為 75 層，被擊破後清空並獲得 1 層「<Chaos:混亂>」。 若未釋放過「骨血重組」，受到致命傷害後將意圖切換為「骨血重組」並免疫一切傷害。"
  },
  State_96809_Name = {
    Text = "嵌合之傀計數"
  },
  State_96810_Desc = {
    Text = "造成的傷害降低 25%。"
  },
  State_96810_Name = {
    Text = "溟夢之帷"
  },
  State_96813_Name = {
    Text = "重組標記"
  },
  State_97114_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」獲得 [StateArg1] 算力，「技能」傷害提高 [StateArg2]%。"
  },
  State_97114_Name = {
    Text = "迫近的太陽"
  },
  State_97118_Name = {
    Text = "嵌合之傀擊破"
  },
  State_97119_Desc = {
    Text = "卡牌獲得保留，但打出或棄掉後會移除污染並召喚 1 個「深海分殖體」，最多 2 個。若無位置召喚會立刻使腐潮之傀獲得 [DescArg1] 點力量和 [DescArg2] 點生命。"
  },
  State_97119_Name = {
    Text = "<Kuangluan:蹈海者狂亂>"
  },
  State_97120_Desc = {
    Text = "受到法陣保護，所有敵人造成的傷害降低 25%。"
  },
  State_97120_Name = {
    Text = "溟夢之帷"
  },
  State_97131_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」每需要消耗 1 算力傷害提升 [StateArg1]%。造成擊殺後「狂氣爆發」造成傷害提升 [StateArg2]%，目前加成 [DescArg1]%。"
  },
  State_97134_Desc = {
    Text = "造成的最終傷害提高 50%。"
  },
  State_97134_Name = {
    Text = "賽琳涅的吟唱"
  },
  State_97135_Desc = {
    Text = "造成的最終傷害提高 25%。"
  },
  State_97135_Name = {
    Text = "賽琳涅的低語"
  },
  State_97136_Desc = {
    Text = "造成的最終傷害提高 100%。"
  },
  State_97136_Name = {
    Text = "賽琳涅的高歌"
  },
  State_97137_Desc = {
    Text = "棄掉後回到手中。"
  },
  State_97137_Name = {
    Text = "棄掉後回到手中"
  },
  State_97137_WeaponDesc = {
    Text = "抽到時使自身虛弱 1 回合。使用後虛弱所有敵人 1 回合。無法出售。"
  },
  State_97219_Desc = {
    Text = "旺達打出的下 [Layer] 張牌額外生效 1 次。"
  },
  State_97219_Name = {
    Text = "荊棘女王"
  },
  State_97251_Desc = {
    Text = "·不會成為對手優先攻擊的目標，且當對手選擇單體目標時無法選中潛行喚醒體\n·在獲得潛行效果時，會解除其他友方單位的潛行狀態。若無其他友方單位，則自身解除潛行"
  },
  State_97251_Name = {Text = "潛行"},
  State_97252_Desc = {
    Text = "·不會成為對手優先攻擊的目標，且當對手選擇單體目標時無法選中潛行喚醒體\n·在獲得潛行效果時，會解除其他友方單位的潛行狀態。若無其他友方單位，則自身解除潛行"
  },
  State_97252_Name = {
    Text = "<PVPSneakKeywords:潛行>"
  },
  State_97339_Name = {
    Text = "彌薩格奪冠金盃"
  },
  State_97742_Desc = {
    Text = "每次承受主動傷害時，對傷害來源造成 [Layer] 點<FixedDamage:純粹傷害>。"
  },
  State_97742_Name = {Text = "反擊"},
  State_97743_Desc = {
    Text = "造成的主動傷害提高 [Layer] 點。"
  },
  State_97744_Desc = {
    Text = "承受的所有傷害降低 [Layer] %。"
  },
  State_97744_WeaponDesc = {
    Text = "造成的所有傷害降低 [DescArg1] %。"
  },
  State_97938_Desc = {
    Text = "最終傷害提高 [DescArg1]%。"
  },
  State_97938_Name = {
    Text = "彌薩格奪冠金盃"
  },
  State_97939_Desc = {
    Text = "造成的最終傷害提高 50%。"
  },
  State_97939_Name = {
    Text = "彌薩格奪冠金盃"
  },
  State_97941_Desc = {
    Text = "基礎傷害提高 100%。"
  },
  State_97941_Name = {
    Text = "彌薩格奪冠金盃"
  },
  State_97942_Desc = {
    Text = "釋放狂氣爆發時獲得 35 點狂氣。"
  },
  State_97942_Name = {
    Text = "彌薩格奪冠金盃"
  },
  State_97943_Name = {
    Text = "算力保留計數"
  },
  State_98055_Desc = {
    Text = "回合結束時，生成 1 條觸腕。覺醒後移除該狀態。"
  },
  State_98060_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，回復生命並以真正的形態開始戰鬥。"
  },
  State_98060_Name = {
    Text = "尚未覺醒"
  },
  State_98068_Desc = {
    Text = "擁有 10 層「爆炎」時，獲得 2 點算力並將所有「千兆耀斑」升級為「億兆耀斑」。"
  },
  State_98139_Desc = {
    Text = "對方回合開始後隨機<BurningKeywords:燃燒> 1 張手牌。"
  },
  State_98139_Name = {
    Text = "業火重燃"
  },
  State_98140_Desc = {
    Text = "積攢 10 層<MonsterExFlameKeywords:爆炎>後將意圖切換為極高傷害的「億兆耀斑」！"
  },
  State_98147_Desc = {
    Text = "敵人打出<BurningKeywords:燃燒>卡牌時，使自身獲得 1 層<MonsterExFlameKeywords:爆炎>，但臨時降低 [DescArg1] <PowerIconKeywords:力量>。"
  },
  State_98148_Desc = {
    Text = "這位喚醒體還未覺醒…即將被擊倒時會覺醒，棄置所有剩餘手牌並賦予<BurningKeywords:燃燒>，回復生命並以真正的形態開始戰鬥。"
  },
  State_98148_Name = {
    Text = "尚未覺醒"
  },
  State_98302_Desc = {
    Text = "隊伍唯一：裝備者造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，力量獲取效果提高 <WeaponEffect_Num:[StateArg2]%>。打出裝備者指令卡後獲得裝備者攻擊力 <WeaponEffect_Num:[StateArg3]%> 的臨時力量，每回合最多觸發 5 次。"
  },
  State_98302_WeaponDesc = {
    Text = "裝備者造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>，造成的力量提高 <WeaponEffect_Num:[StateArg2]%>。打出裝備者的指令卡後獲得 <WeaponEffect_Num:[Power:DescArg1]> 點臨時力量，每回合最多觸發 5 次(當前已觸發 [DescArg2]/5 次)。"
  },
  State_98323_Desc = {
    Text = "卡牌被棄置後會重新回到手中。"
  },
  State_98323_Name = {
    Text = "棄置後回到手中"
  },
  State_98341_Desc = {
    Text = "可與其他原色進行調和，變成新的顏色。"
  },
  State_98341_Name = {
    Text = "<Yellow:原色·黃>"
  },
  State_98344_Desc = {
    Text = "可與其他原色進行調和，變成新的顏色。"
  },
  State_98344_Name = {
    Text = "<Red:原色·紅>"
  },
  State_98345_Desc = {
    Text = "可與其他原色進行調和，變成新的顏色。"
  },
  State_98345_Name = {
    Text = "<Blue:原色·藍>"
  },
  State_98366_Desc = {
    Text = "回合開始時，若銀鑰能量大於 [Arg1] ，則消耗 [Arg1] 點銀鑰能量將 1 張<DerivativeCardKeywords_115:「高級靈感」>置入手中。"
  },
  State_98435_Desc = {
    Text = "由紅色與藍色調和而來，每造成 1 次主動傷害，獲得 <Block: [DescArg1]> 點護盾。"
  },
  State_98435_Name = {
    Text = "<PurpleKeyWord:異象·紫>"
  },
  State_98436_Desc = {
    Text = "由紅色與黃色調和而來，釋放狂氣爆發後，對應喚醒體獲得 <Energy:15> 點狂氣。"
  },
  State_98436_Name = {
    Text = "<ExclamationPointColour:異象·橙>"
  },
  State_98437_Desc = {
    Text = "造成的最終傷害提高 10%。"
  },
  State_98437_Name = {
    Text = "<Red:原色·紅>"
  },
  State_98438_Desc = {
    Text = "由黃色與藍色調和而來，打出「防禦」後，回復 <Heal:[DescArg1]> 點生命。"
  },
  State_98438_Name = {
    Text = "<GreenWord:異象·綠>"
  },
  State_98439_Desc = {
    Text = "由黃色與藍色調和而來，打出「防禦」後，回復 <Heal:[DescArg1]> 點生命。"
  },
  State_98439_Name = {
    Text = "<GreenWord:異象·綠>"
  },
  State_98440_Desc = {
    Text = "由紅色與藍色調和而來，每造成 1 次主動傷害，獲得 <Block: [DescArg1]> 點護盾。"
  },
  State_98440_Name = {
    Text = "<PurpleKeyWord:異象·紫>"
  },
  State_98441_Desc = {
    Text = "由紅色與黃色調和而來，釋放狂氣爆發後，對應喚醒體獲得 <Energy:15> 點狂氣。"
  },
  State_98441_Name = {
    Text = "<ExclamationPointColour:異象·橙>"
  },
  State_98444_Desc = {
    Text = "隊伍唯一：裝備者造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。打出 5 張裝備者的指令卡後，裝備者獲得 <WeaponEffect_Num:[StateArg2]%> 臨時暴擊率。該效果每回合只能觸發 1 次。"
  },
  State_98444_WeaponDesc = {
    Text = "裝備者造成的基礎傷害提高 <WeaponEffect_Num:[StateArg1]%>。打出 5 張裝備者的指令卡後，裝備者獲得 <WeaponEffect_Num:[StateArg2]%> 臨時暴擊率，該效果每回合只能觸發 1 次(當前已打出 [DescArg1]/5 張)。"
  },
  State_98474_Desc = {
    Text = "能混合調配出其他顏色的基本色，由紅色、黃色、藍色組成。"
  },
  State_98485_Desc = {
    Text = "此卡牌造成的護盾、狂氣提高 [DescArg2]％，最終傷害、力量提高 [DescArg1]％，獲得「保留」，打出後消耗所有「活焰」並將 1 層「活焰」傳導到手中其它 1 張凱蒂古拉的指令卡上。"
  },
  State_98486_Desc = {
    Text = "此卡牌造成的護盾、狂氣提高 [DescArg2]％，最終傷害、力量提高 [DescArg1]％，獲得「保留」，打出後消耗所有「活焰」並將 1 層「活焰」傳導到手中其它 1 張凱蒂古拉的指令卡上。"
  },
  State_98487_Desc = {
    Text = "此卡牌造成的護盾、狂氣提高 [DescArg2]％，最終傷害、力量提高 [DescArg1]％，獲得「保留」，打出後消耗所有「活焰」並將 1 層「活焰」傳導到手中其它 1 張凱蒂古拉的指令卡上。"
  },
  State_98488_Desc = {
    Text = "每層「活焰」使卡牌造成的最終傷害、護盾、狂氣、力量提高 30%，至多疊加 3 層。擁有「活焰」的卡牌獲得「保留」，打出後消耗所有「活焰」並將 1 層「活焰」傳導到手中其它 1 張凱蒂古拉的指令卡上。"
  },
  State_98492_Desc = {
    Text = "探索開始後，體質、攻擊、防禦提升 [StateArg1] %"
  },
  State_98492_Name = {
    Text = "靈塑適性"
  },
  State_98495_Desc = {
    Text = "探索開始後，體質、攻擊、防禦提升 [StateArg1] %"
  },
  State_98495_Name = {
    Text = "靈塑適性"
  },
  State_98507_Desc = {
    Text = "探索開始後，體質、攻擊、防禦提升 [StateArg1] %"
  },
  State_98507_Name = {
    Text = "靈塑適性"
  },
  State_98511_Name = {
    Text = "獲取衍生卡"
  },
  State_98551_Desc = {
    Text = "戰鬥開始時界域精通 +[Arg1]。奇數回合開始時抽 1 張牌，偶數回合開始時獲得 1 點算力。"
  },
  State_98553_Desc = {
    Text = "每當生成 1 個「胚胎」，獲得 [Arg1] 點猩紅熔爐，每回合最多觸發 3 次。"
  },
  State_98555_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 強效。每回合首次施加中毒後，抽 [Arg2] 張牌。"
  },
  State_98556_Desc = {
    Text = "所有喚醒體造成生命回復和護盾的基礎效果提高 [Arg1]%。"
  },
  State_98557_Desc = {
    Text = "每當生成 1 個「胚胎」，獲得 [Arg1] 點猩紅熔爐，每回合最多觸發 3 次。"
  },
  State_98559_Desc = {
    Text = "每抽一張牌或棄一張牌獲得 [Arg1] 臨時力量 ，最多獲得 [Arg2] 臨時力量。"
  },
  State_98560_Desc = {
    Text = "所有喚醒體造成的基礎傷害提高 [Arg1]%。釋放狂氣爆發前，使釋放狂氣爆發的喚醒體造成的基礎傷害臨時提高 [Arg2]%。"
  },
  State_98561_Desc = {
    Text = "回合開始時，若生命低於 50% 臨時傷害強效 +[Arg1]%。若生命低於 25%，額外抽 [Arg2] 張牌並獲得 [Arg2] 算力。"
  },
  State_98562_Desc = {
    Text = "造成主動或觸腕傷害後，使目標當回合受到的觸腕傷害提高 [Arg1]%，每回合最多觸發 20 次。"
  },
  State_98563_Desc = {
    Text = "戰鬥開始時獲得 [Arg1] 力量。每打出一張 「消耗」 的牌就獲得 [Arg2] 臨時力量，最多觸發 [Arg3] 次。"
  },
  State_98564_Desc = {
    Text = "「狂氣爆發」獲得 [Arg1] 銀鑰能量，每回合最多觸發 3 次。"
  },
  State_98565_Desc = {
    Text = "每當一張卡進入超維空間時，從抽牌堆抽 [Arg1] 張此卡歸屬者的指令卡，若無法抽取改為獲得等量算力。每回合最多生效 2 次。"
  },
  State_98567_Desc = {
    Text = "回合結束前，手中每張指令卡的所屬喚醒體獲得 [Arg1] 狂氣。"
  },
  State_98568_Desc = {
    Text = "戰鬥開始時獲得傷害強效 +[Arg1]%。造成主動傷害後對所有敵人造成 [Arg2] 中毒，每回合最多額外觸發 5 次。"
  },
  State_98569_Desc = {
    Text = "每回合首次「鑰令」後對所有敵人施加 [Arg1] 層中毒，並獲得 [Arg2] 層反擊。"
  },
  State_98571_Desc = {
    Text = "使用銀鑰覺醒後回復 [Arg1] 生命，獲得 [Arg2] 點銀鑰能量。"
  },
  State_98571_Name = {
    Text = "旅行陽傘"
  },
  State_98572_Desc = {
    Text = "每回合釋放第二次「鑰令」後獲得 [Arg1] 點銀鑰能量，所有喚醒體獲得 [Arg2] 點狂氣。"
  },
  State_98575_Desc = {
    Text = "戰鬥開始時獲得傷害強效 +[Arg1]%。造成主動傷害後對所有敵人造成 [Arg2] 中毒，每回合最多額外觸發 5 次。"
  },
  State_98576_Desc = {
    Text = "戰鬥開始對所有敵人造成 [Arg1] 層虛弱和易傷。「湮滅」後也會觸發這個效果，但具有 3 回合冷卻。"
  },
  State_98577_Desc = {
    Text = "所有喚醒體造成的基礎傷害提高 [Arg1]%。釋放狂氣爆發前，使釋放狂氣爆發的喚醒體造成的基礎傷害臨時提高 [Arg2]%。"
  },
  State_98579_Desc = {
    Text = "回合開始時，若生命低於 50% 臨時傷害強效 +[Arg1]%。若生命低於 25%，額外抽 [Arg2] 張牌並獲得 [Arg2] 算力。"
  },
  State_98581_Desc = {
    Text = "所有喚醒體每回合首次「指令卡」獲得 [Arg1] 點銀鑰能量。"
  },
  State_98582_Desc = {
    Text = "每釋放 5 次「狂氣爆發」後，下 [Arg1] 張非衍生指令卡額外生效 1 次。"
  },
  State_98583_Desc = {
    Text = "所有喚醒體每回合首次「指令卡」獲得 [Arg1] 點銀鑰能量。"
  },
  State_98586_Desc = {
    Text = "回合開始時，所有狂氣不足以釋放狂氣爆發的喚醒體獲得 [Arg1] 點狂氣。"
  },
  State_98587_Desc = {
    Text = "每抽一張牌或棄一張牌獲得 [Arg1] 臨時力量 ，最多獲得 [Arg2] 臨時力量。"
  },
  State_98588_Desc = {
    Text = "回合結束前，手中每張指令卡的所屬喚醒體獲得 [Arg1] 狂氣。"
  },
  State_98589_Desc = {
    Text = "戰鬥開始時使所有敵人臨時失去 [Arg1] 力量。使用「猩紅熔爐」也會觸發這個效果，但具有 3 回合冷卻。"
  },
  State_98590_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 強效。每回合首次施加中毒後，抽 [Arg2] 張牌。"
  },
  State_98591_Desc = {
    Text = "每回合首次「鑰令」後對所有敵人施加 [Arg1] 層中毒，並獲得 [Arg2] 層反擊。"
  },
  State_98596_Desc = {
    Text = "每回合首次「鑰令」返還消耗 [Arg1]% 消耗的銀鑰能量。"
  },
  State_98597_Desc = {
    Text = "使用銀鑰覺醒後回復 [Arg1] 生命，獲得 [Arg2] 點銀鑰能量。"
  },
  State_98597_Name = {
    Text = "旅行陽傘+"
  },
  State_98598_Desc = {
    Text = "戰鬥開始時獲得 [Arg1] 力量。每打出一張 「消耗」 的牌就獲得 [Arg2] 臨時力量，最多觸發 [Arg3] 次。"
  },
  State_98600_Desc = {
    Text = "戰鬥開始時使所有敵人臨時失去 [Arg1] 力量。使用「猩紅熔爐」也會觸發這個效果，但具有 3 回合冷卻。"
  },
  State_98602_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。每回合首次獲得反擊後，獲得 1/2 算力。"
  },
  State_98603_Desc = {
    Text = "戰鬥開始時獲得傷害強效 +[Arg1]%。受到主動或觸腕傷害後獲得 [Arg2] 反擊，每回合最多觸發 3 次。"
  },
  State_98604_Desc = {
    Text = "戰鬥開始時獲得傷害強效 +[Arg1]%。受到主動或觸腕傷害後獲得 [Arg2] 反擊，每回合最多觸發 3 次。"
  },
  State_98606_Desc = {
    Text = "每當一張卡進入超維空間時，從抽牌堆抽 [Arg1] 張此卡歸屬者的指令卡，若無法抽取改為獲得等量算力。每回合最多生效 2 次。"
  },
  State_98607_Desc = {
    Text = "每回合首次「鑰令」激發所有觸腕攻擊 [Arg1] 次敵方，造成 50% 傷害。"
  },
  State_98608_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效，每打出一張不同喚醒體的指令卡額外獲得 15/30% 臨時傷害強效。"
  },
  State_98610_Desc = {
    Text = "使用銀鑰覺醒後使手中算力最高的 2/4 張卡牌在下次打出前獲得保留和預備，獲得 100/200 點銀鑰能量。"
  },
  State_98611_Desc = {
    Text = "戰鬥開始時界域精通 +[Arg1]。奇數回合開始時抽 1 張牌，偶數回合開始時獲得 1 點算力。"
  },
  State_98612_Desc = {
    Text = "每回合首次「鑰令」使臨時傷害強效 +[Arg1]%，生命越低則效果越強。"
  },
  State_98613_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效，每打出一張不同喚醒體的指令卡額外獲得 15/30% 臨時傷害強效。"
  },
  State_98614_Desc = {
    Text = "每釋放 5 次「狂氣爆發」後，下 [Arg1] 張非衍生指令卡額外生效 1 次。"
  },
  State_98615_Desc = {
    Text = "每回合首次「鑰令」返還消耗 [Arg1]% 消耗的銀鑰能量。"
  },
  State_98616_Desc = {
    Text = "所有喚醒體造成生命回復和護盾的基礎效果提高 [Arg1]%。"
  },
  State_98617_Desc = {
    Text = "造成主動或觸腕傷害後，使目標當回合受到的觸腕傷害提高 [Arg1]%，每回合最多觸發 20 次。"
  },
  State_98619_Desc = {
    Text = "回合結束時若銀鑰能量已滿，消耗 [Arg1] 點銀鑰能量將一張「銀鑰微光」置入手牌。"
  },
  State_98621_Desc = {
    Text = "回合結束時若銀鑰能量已滿，消耗 [Arg1] 點銀鑰能量將一張「銀鑰曦光」置入手牌。"
  },
  State_98623_Desc = {
    Text = "回合開始時，所有狂氣不足以釋放狂氣爆發的喚醒體獲得 [Arg1] 點狂氣。"
  },
  State_98624_Desc = {
    Text = "戰鬥開始時和觸發死亡抵抗後，獲得 [Arg1] 點銀鑰能量。"
  },
  State_98625_Desc = {
    Text = "戰鬥開始對所有敵人造成 [Arg1] 層虛弱和易傷。「湮滅」後也會觸發這個效果，但具有 3 回合冷卻。"
  },
  State_98626_Desc = {
    Text = "每回合首次「鑰令」使臨時傷害強效 +[Arg1]%，生命越低則效果越強。"
  },
  State_98627_Desc = {
    Text = "「狂氣爆發」獲得 [Arg1] 銀鑰能量，每回合最多觸發 3 次。"
  },
  State_98628_Desc = {
    Text = "每回合首次「鑰令」激發所有觸腕攻擊 [Arg1] 次敵方，造成 50% 傷害。"
  },
  State_98629_Desc = {
    Text = "每回合釋放第二次「鑰令」後獲得 [Arg1] 點銀鑰能量，所有喚醒體獲得 [Arg2] 點狂氣。"
  },
  State_98630_Desc = {
    Text = "戰鬥開始時和觸發死亡抵抗後，獲得 [Arg1] 點銀鑰能量。"
  },
  State_98632_Desc = {
    Text = "戰鬥開始時獲得 [Arg1]% 傷害強效。每回合首次獲得反擊後，獲得 1/2 算力。"
  },
  State_98686_Desc = {
    Text = "下 [Layer] 張非衍生指令卡額外生效 1 次。"
  },
  State_98686_Name = {
    Text = "非衍生指令卡雙發"
  },
  State_98739_Desc = {
    Text = "當意圖轉換為蒼白迴旋時，根據狀態層數增加等量傷害次數，並在回合結束後清空狀態。達到 3 層後，立刻將意圖轉換為蒼白迴旋。"
  },
  State_98742_Desc = {
    Text = "施加的中毒提高100%，每個回合結束後獲得 <Block:[Block:DescArg1]> 護盾。"
  },
  State_98743_Desc = {
    Text = "在回合內受到 [DescArg1] 點傷害後，獲得 75 層臨時加固，將意圖轉換為「不耐的施捨」並會解除石化效果，獲得 1 層「蜘蛛女之吻」。"
  },
  State_98752_Desc = {
    Text = "使卡牌燃燒，打出後受到最大生命 5% 的傷害，若回合結束仍在手中將其消耗。"
  },
  State_98752_Name = {
    Text = "<BurningKeywords2:燃燒>"
  },
  State_98752_WeaponDesc = {
    Text = "每層遲緩使卡牌的算力消耗增加 1 點。"
  },
  State_98887_Name = {
    Text = "救世聖燈"
  },
  State_98889_Desc = {
    Text = "每回合首次打出帶有<DepleteIconKeywords:消耗>的指令卡時將其置入棄牌堆。"
  },
  State_98889_Name = {
    Text = "救世聖燈"
  },
  State_98912_Desc = {
    Text = "每層使所有喚醒體造成的護盾和生命回復降低 10%。"
  },
  State_98913_Desc = {
    Text = "每層使所有喚醒體造成的護盾和生命回復降低 10%。"
  },
  State_99007_Desc = {
    Text = "打出後不會進入棄牌堆，而是從牌庫中移除。"
  },
  State_99007_WeaponDesc = {
    Text = "打出後卡牌不會進入棄牌堆，在本場戰鬥中無法再次使用。"
  },
  State_99053_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：其他友方每回合首次「狂氣爆發」後抽 [StateArg1] 張牌。"
  },
  State_99053_Name = {
    Text = "渴求的畫筆"
  },
  State_99055_Desc = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後隨機將 [StateArg1] 張裝備者的「技能」置入手牌並使其算力消耗變為 0。"
  },
  State_99055_Name = {
    Text = "寫實主義悖謬"
  },
  State_99056_Desc = {
    Text = "隊伍唯一：釋放鑰令後，裝備者的暴擊率臨時提高 <WeaponEffect_Num:[StateArg1]%> 。"
  },
  State_99056_WeaponDesc = {
    Text = "釋放鑰令後，裝備者的暴擊率臨時提高 <WeaponEffect_Num:[StateArg1]%> 。"
  },
  State_99134_Desc = {
    Text = "「繪者」用於作畫的染料，能加強技能效果，上限 10 層。"
  },
  State_99237_Name = {
    Text = "狀態飾品飛昇"
  },
  State_99237_WeaponDesc = {
    Text = "裝備者造成的基礎傷害提高 10%。若裝備者傷害強效大於 20%，基礎傷害額外提高 10%。"
  },
  State_99238_Name = {
    Text = "狀態飾品腐殖質"
  },
  State_99238_WeaponDesc = {
    Text = "裝備者造成的基礎傷害提高 10%。若裝備者傷害強效大於 20%，基礎傷害額外提高 10%。"
  },
  State_99239_Name = {
    Text = "狀態飾品斯提克斯"
  },
  State_99239_WeaponDesc = {
    Text = "裝備者造成的基礎傷害提高 10%。若裝備者傷害強效大於 20%，基礎傷害額外提高 10%。"
  },
  State_99258_Desc = {
    Text = "隊伍唯一：每回合釋放第 2 次鑰令後，有 <WeaponEffect_Num:[StateArg1]%> 的幾率抽 1 張裝備者的指令卡。每回合打出第 3 張裝備者的指令卡後，獲得 <WeaponEffect_Num:[StateArg2]> 點銀鑰能量。"
  },
  State_99258_WeaponDesc = {
    Text = "每回合釋放第 2 次鑰令後，有 <WeaponEffect_Num:[StateArg1]%> 的幾率抽 1 張裝備者的指令卡。每回合打出第 3 張裝備者的指令卡後，獲得 <WeaponEffect_Num:[StateArg2]> 點銀鑰能量。"
  },
  State_99294_Desc = {
    Text = "所有喚醒體造成的狂氣提高 [DescArg1]%，回合結束時的算力和指令卡可保留至下回合。紛華篇章的狂氣提高。"
  },
  State_99295_Desc = {
    Text = "所有喚醒體造成的狂氣提高 [StateArg1]%，回合結束時的算力和指令卡可保留至下回合。紛華篇章的狂氣提高。"
  },
  State_99336_Desc = {
    Text = "「繪者」用於作畫的染料，能加強技能效果，上限 10 層。"
  },
  State_99533_Name = {
    Text = "飾品少女之蛹"
  },
  State_99533_WeaponDesc = {
    Text = "戰鬥開始後，若裝備者職業為混沌，攻擊力提高 25%。"
  },
  State_99534_WeaponDesc = {
    Text = "裝備者造成的護盾與生命回復提高 6%。若裝備者界域精通大於 50，護盾與生命回復額外提高 6%。"
  },
  State_99640_Desc = {
    Text = "若當前擁有 10 層創意，皮克曼釋放狂氣爆發後消耗所有創意，使所有喚醒體獲得 15 點狂氣並獲得 1 層「狂想」。創意上限為 10層，能夠繼承至下場戰鬥。"
  },
  State_99640_Name = {Text = "創意"},
  State_99723_Desc = {
    Text = "隊伍唯一：裝備者造成的狂氣和力量獲取效果提高 <WeaponEffect_Num:[StateArg1]%>。釋放狂氣爆發後本回合下次其他喚醒體狂氣爆發最終傷害、護盾、生命回復提高 <WeaponEffect_Num:[StateArg2]%>，若本次狂氣爆發觸發了「吞噬」，裝備者獲得 <WeaponEffect_Num:[StateArg3]> 點狂氣。"
  },
  State_99723_WeaponDesc = {
    Text = "裝備者造成的狂氣和力量提高 <WeaponEffect_Num:[StateArg1]%>。釋放狂氣爆發後本回合下次其他喚醒體狂氣爆發最終傷害、護盾、生命回復提高 <WeaponEffect_Num:[StateArg2]%>，若本次狂氣爆發觸發了「吞噬」，裝備者獲得 <WeaponEffect_Num:[StateArg3]> 點狂氣。"
  }
})
return Text_State
