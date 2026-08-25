__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_AwakerTalent = readonly({
  AwakerTalent_117311_TalentDesc_1 = {
    Text = "·波吕克斯每回合打出首张指令卡时，使其伤害提高自身攻击力 200％、护盾提高自身防御力 50％，并使波吕克斯获得 10 点狂气。\n·战斗结束后，波吕克斯造成的基础伤害和「苦痛救赎」伤害效果在探索中提高 20%，首领战「苦痛救赎」伤害效果翻倍。"
  },
  AwakerTalent_117311_TalentName_1 = {
    Text = "苦痛救赎"
  },
  AwakerTalent_120347_TalentDesc_1 = {
    Text = "·该角色在队伍中时，将替换「深海」界域为「晦瞑·深海」界域。\n·基础触腕伤害变更为队伍最大生命的 5%。\n·探索开始后队伍伤害强效+50%，如果队伍仅由深海或混沌唤醒体组成，该效果获得的伤害强效翻倍，但战斗开始不再获得额外触腕。\n·不再拥有「触腕集结」效果。\n·触腕姿态变更为「晦瞑·触腕姿态」。\n·「晦瞑·静海」：获得 25% 最大生命的护盾，回合结束后触腕不再攻击，3 回合冷却。\n·「晦瞑·怒涛」：使本回合触腕伤害变成 125%，造成主动伤害后使 1 条触腕攻击，但回合结束后失去 1 条触腕，3 回合冷却。\n·界域精通变更为「晦瞑·深海精通」，每点界域精通使「晦瞑·静海」的护盾提高 0.025% 最大生命，使「晦瞑·怒涛」的触腕伤害额外提高 0.025%。\n·如果队伍仅由深海或混沌唤醒体组成，「晦瞑·界域精通」效果翻倍。"
  },
  AwakerTalent_120347_TalentName_1 = {
    Text = "永黯之地"
  },
  AwakerTalent_122481_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·茉夏对「主宰」敌人造成的最终伤害提高 [Arg5]％。\n·所有唤醒体「打击」基础伤害提高 [Arg3]％。\n·触发死亡抵抗后茉夏获得 [Arg4] 点狂气。"
  },
  AwakerTalent_122481_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·茉夏对「主宰」敌人造成的最终伤害提高 [Arg5]％。\n·所有唤醒体「打击」基础伤害提高 [Arg3]％。\n·触发死亡抵抗后茉夏获得 [Arg4] 点狂气。"
  },
  AwakerTalent_122481_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·茉夏对「主宰」敌人造成的最终伤害提高 [Arg5]％。\n·所有唤醒体「打击」基础伤害提高 [Arg3]％。\n·触发死亡抵抗后茉夏获得 [Arg4] 点狂气。"
  },
  AwakerTalent_122481_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·茉夏对「主宰」敌人造成的最终伤害提高 [Arg5]％。\n·所有唤醒体「打击」基础伤害提高 [Arg3]％。\n·触发死亡抵抗后茉夏获得 [Arg4] 点狂气。"
  },
  AwakerTalent_122481_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·茉夏对「主宰」敌人造成的最终伤害提高 [Arg5]％。\n·所有唤醒体「打击」基础伤害提高 [Arg3]％。\n·触发死亡抵抗后茉夏获得 [Arg4] 点狂气。"
  },
  AwakerTalent_122481_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·茉夏对「主宰」敌人造成的最终伤害提高 [Arg5]％。\n·所有唤醒体「打击」基础伤害提高 [Arg3]％。\n·触发死亡抵抗后茉夏获得 [Arg4] 点狂气。"
  },
  AwakerTalent_122481_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·茉夏对「主宰」敌人造成的最终伤害提高 [Arg5]％。\n·所有唤醒体「打击」基础伤害提高 [Arg3]％。\n·触发死亡抵抗后茉夏获得 [Arg4] 点狂气。"
  },
  AwakerTalent_122481_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·茉夏对「主宰」敌人造成的最终伤害提高 [Arg5]％。\n·所有唤醒体「打击」基础伤害提高 [Arg3]％。\n·触发死亡抵抗后茉夏获得 [Arg4] 点狂气。"
  },
  AwakerTalent_122481_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·茉夏对「主宰」敌人造成的最终伤害提高 [Arg5]％。\n·所有唤醒体「打击」基础伤害提高 [Arg3]％。\n·触发死亡抵抗后茉夏获得 [Arg4] 点狂气。"
  },
  AwakerTalent_122481_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·茉夏对「主宰」敌人造成的最终伤害提高 [Arg5]％。\n·所有唤醒体「打击」基础伤害提高 [Arg3]％。\n·触发死亡抵抗后茉夏获得 [Arg4] 点狂气。"
  },
  AwakerTalent_122481_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_122481_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_122481_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_122481_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_122481_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_122481_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_122481_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_122481_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_122481_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_122481_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_122524_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_122524_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_122524_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_122524_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_122524_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_122524_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_122524_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_122524_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_122524_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_122524_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_122524_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_122524_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_122524_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_122524_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_122524_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_122524_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_122524_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_122524_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_122524_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_122524_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_122524_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_122524_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_122524_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_122524_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_122607_TalentDesc_1 = {
    Text = "·每打出 2 张「打击」茉夏进行追击，随机造成 1 次 30% 茉夏攻击力且视为「打击」的伤害，每回合最多生效 4 次。"
  },
  AwakerTalent_122607_TalentName_1 = {
    Text = "戏剧性邂逅"
  },
  AwakerTalent_125362_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体触发中毒效果提高 [Arg3]％ 。\n·每层「痴醉」额外使「人型」敌人造成的伤害降低  1％，移除时额外对「人型」敌人造成 1％ 最大生命纯粹伤害。"
  },
  AwakerTalent_125362_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体触发中毒效果提高 [Arg3]％ 。\n·每层「痴醉」额外使「人型」敌人造成的伤害降低  1％，移除时额外对「人型」敌人造成 1％ 最大生命纯粹伤害。"
  },
  AwakerTalent_125362_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体触发中毒效果提高 [Arg3]％ 。\n·每层「痴醉」额外使「人型」敌人造成的伤害降低  1％，移除时额外对「人型」敌人造成 1％ 最大生命纯粹伤害。"
  },
  AwakerTalent_125362_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体触发中毒效果提高 [Arg3]％ 。\n·每层「痴醉」额外使「人型」敌人造成的伤害降低  1％，移除时额外对「人型」敌人造成 1％ 最大生命纯粹伤害。"
  },
  AwakerTalent_125362_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体触发中毒效果提高 [Arg3]％ 。\n·每层「痴醉」额外使「人型」敌人造成的伤害降低  1％，移除时额外对「人型」敌人造成 1％ 最大生命纯粹伤害。"
  },
  AwakerTalent_125362_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体触发中毒效果提高 [Arg3]％ 。\n·每层「痴醉」额外使「人型」敌人造成的伤害降低  1％，移除时额外对「人型」敌人造成 1％ 最大生命纯粹伤害。"
  },
  AwakerTalent_125362_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体触发中毒效果提高 [Arg3]％ 。\n·每层「痴醉」额外使「人型」敌人造成的伤害降低  1％，移除时额外对「人型」敌人造成 1％ 最大生命纯粹伤害。"
  },
  AwakerTalent_125362_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体触发中毒效果提高 [Arg3]％ 。\n·每层「痴醉」额外使「人型」敌人造成的伤害降低  1％，移除时额外对「人型」敌人造成 1％ 最大生命纯粹伤害。"
  },
  AwakerTalent_125362_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体触发中毒效果提高 [Arg3]％ 。\n·每层「痴醉」额外使「人型」敌人造成的伤害降低  1％，移除时额外对「人型」敌人造成 1％ 最大生命纯粹伤害。"
  },
  AwakerTalent_125362_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体触发中毒效果提高 [Arg3]％ 。\n·每层「痴醉」额外使「人型」敌人造成的伤害降低  1％，移除时额外对「人型」敌人造成 1％ 最大生命纯粹伤害。"
  },
  AwakerTalent_125362_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_125362_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_125362_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_125362_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_125362_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_125362_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_125362_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_125362_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_125362_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_125362_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_125363_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_125363_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_125363_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_125363_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_125363_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_125363_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_125363_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_125363_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_125363_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_125363_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_125363_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_125363_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_125363_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_125363_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_125363_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_125363_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_125363_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_125363_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_125363_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_125363_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_125363_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_125363_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_125363_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_125363_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_127223_TalentDesc_1 = {
    Text = "·阿拉克涅在队伍中时，将替换「超维」界域为「奇点·超维」界域。\n·维度穿梭：每回合首次打出指令卡后触发该效果，将其临时原始复制置入超维空间并为其和临时复制赋予 25 层「奇点信标」，超维回合无法发动该效果。\n·奇点信标：每拥有 1 层使该卡牌造成的伤害、固定力量和触腕伤害提高、固定中毒、固定反击最终效果提高 2%，固定护盾、固定生命回复、力量降低的最终效果提高 1%，打出后移除。拥有奇点信标的卡牌无法触发「维度穿梭」。\n·超维空间：超维空间达到上限时回合结束改为发动超维空间：不再获得额外回合，弃掉非保留手牌并触发虚无效果、将超维空间所有卡牌置入手中，将当前算力设置为 5 点。发动超维空间后，本回合视为超维回合。\n·「奇点湮灭」：取出超维空间最左侧的卡牌。3 回合冷却。\n·探索开始后队伍伤害强效 +50%，并获得 15 层「奇点棱镜」。\n·「奇点棱镜」：所有指令卡视为拥有等量奇点信标的加成。\n·超维精通：队伍每有 1 点界域精通，使「奇点棱镜」和「维度穿梭」施加的「奇点信标」层数提高 0.05％。\n·至纯超维：如果队伍仅由超维或混沌唤醒体组成，超维精通效果和界域提供的伤害强效翻倍。"
  },
  AwakerTalent_127223_TalentName_1 = {
    Text = "命定之丝"
  },
  AwakerTalent_130395_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_130395_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_130395_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_130395_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_130395_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_130395_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_130395_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_130395_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_130395_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_130395_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_130395_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130395_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130395_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130395_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130395_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130395_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130395_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130395_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130395_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130395_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130396_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130396_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130396_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130396_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130396_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130396_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130396_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130396_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130396_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130396_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130396_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130396_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130396_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130396_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130396_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130396_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130396_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130396_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130396_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130396_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130396_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130396_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130396_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130396_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130397_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130397_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130397_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130397_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130397_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130397_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130397_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130397_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130397_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130397_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130397_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130397_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130397_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130397_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130397_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130397_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130397_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130397_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130397_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130397_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130397_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130397_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130397_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130397_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130398_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「沙耶之歌」选择的唤醒体获得 [Arg3] 层「繁育庆典」，并使下次钥令生效 2 次。\n·沙耶对「血肉」敌人造成的「侵蚀」额外提高 [Arg4]%。"
  },
  AwakerTalent_130398_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「沙耶之歌」选择的唤醒体获得 [Arg3] 层「繁育庆典」，并使下次钥令生效 2 次。\n·沙耶对「血肉」敌人造成的「侵蚀」额外提高 [Arg4]%。"
  },
  AwakerTalent_130398_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「沙耶之歌」选择的唤醒体获得 [Arg3] 层「繁育庆典」，并使下次钥令生效 2 次。\n·沙耶对「血肉」敌人造成的「侵蚀」额外提高 [Arg4]%。"
  },
  AwakerTalent_130398_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「沙耶之歌」选择的唤醒体获得 [Arg3] 层「繁育庆典」，并使下次钥令生效 2 次。\n·沙耶对「血肉」敌人造成的「侵蚀」额外提高 [Arg4]%。"
  },
  AwakerTalent_130398_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「沙耶之歌」选择的唤醒体获得 [Arg3] 层「繁育庆典」，并使下次钥令生效 2 次。\n·沙耶对「血肉」敌人造成的「侵蚀」额外提高 [Arg4]%。"
  },
  AwakerTalent_130398_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「沙耶之歌」选择的唤醒体获得 [Arg3] 层「繁育庆典」，并使下次钥令生效 2 次。\n·沙耶对「血肉」敌人造成的「侵蚀」额外提高 [Arg4]%。"
  },
  AwakerTalent_130398_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「沙耶之歌」选择的唤醒体获得 [Arg3] 层「繁育庆典」，并使下次钥令生效 2 次。\n·沙耶对「血肉」敌人造成的「侵蚀」额外提高 [Arg4]%。"
  },
  AwakerTalent_130398_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「沙耶之歌」选择的唤醒体获得 [Arg3] 层「繁育庆典」，并使下次钥令生效 2 次。\n·沙耶对「血肉」敌人造成的「侵蚀」额外提高 [Arg4]%。"
  },
  AwakerTalent_130398_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「沙耶之歌」选择的唤醒体获得 [Arg3] 层「繁育庆典」，并使下次钥令生效 2 次。\n·沙耶对「血肉」敌人造成的「侵蚀」额外提高 [Arg4]%。"
  },
  AwakerTalent_130398_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「沙耶之歌」选择的唤醒体获得 [Arg3] 层「繁育庆典」，并使下次钥令生效 2 次。\n·沙耶对「血肉」敌人造成的「侵蚀」额外提高 [Arg4]%。"
  },
  AwakerTalent_130398_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130398_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130398_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130398_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130398_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130398_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130398_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130398_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130398_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130398_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130399_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130399_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130399_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130399_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130399_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130399_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130399_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130399_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130399_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130399_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130399_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130399_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130399_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130399_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130399_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130399_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130399_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130399_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130399_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130399_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130399_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130399_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130399_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130399_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130400_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「无边荒影」造成力量降低效果、获得的力量倍率提高  [Arg3]%，每次生效使下次「染罪枪锋」额外享受 [Arg4]% 力量加成，上限 1200%。"
  },
  AwakerTalent_130400_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「无边荒影」造成力量降低效果、获得的力量倍率提高  [Arg3]%，每次生效使下次「染罪枪锋」额外享受 [Arg4]% 力量加成，上限 1200%。"
  },
  AwakerTalent_130400_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「无边荒影」造成力量降低效果、获得的力量倍率提高  [Arg3]%，每次生效使下次「染罪枪锋」额外享受 [Arg4]% 力量加成，上限 1200%。"
  },
  AwakerTalent_130400_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「无边荒影」造成力量降低效果、获得的力量倍率提高  [Arg3]%，每次生效使下次「染罪枪锋」额外享受 [Arg4]% 力量加成，上限 1200%。"
  },
  AwakerTalent_130400_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「无边荒影」造成力量降低效果、获得的力量倍率提高  [Arg3]%，每次生效使下次「染罪枪锋」额外享受 [Arg4]% 力量加成，上限 1200%。"
  },
  AwakerTalent_130400_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「无边荒影」造成力量降低效果、获得的力量倍率提高  [Arg3]%，每次生效使下次「染罪枪锋」额外享受 [Arg4]% 力量加成，上限 1200%。"
  },
  AwakerTalent_130400_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「无边荒影」造成力量降低效果、获得的力量倍率提高  [Arg3]%，每次生效使下次「染罪枪锋」额外享受 [Arg4]% 力量加成，上限 1200%。"
  },
  AwakerTalent_130400_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「无边荒影」造成力量降低效果、获得的力量倍率提高  [Arg3]%，每次生效使下次「染罪枪锋」额外享受 [Arg4]% 力量加成，上限 1200%。"
  },
  AwakerTalent_130400_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「无边荒影」造成力量降低效果、获得的力量倍率提高  [Arg3]%，每次生效使下次「染罪枪锋」额外享受 [Arg4]% 力量加成，上限 1200%。"
  },
  AwakerTalent_130400_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「无边荒影」造成力量降低效果、获得的力量倍率提高  [Arg3]%，每次生效使下次「染罪枪锋」额外享受 [Arg4]% 力量加成，上限 1200%。"
  },
  AwakerTalent_130400_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130400_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130400_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130400_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130400_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130400_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130400_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130400_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130400_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130400_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130918_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130918_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130918_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130918_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130918_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130918_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130918_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130918_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130918_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130918_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130918_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130918_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_130918_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130918_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130918_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130918_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130918_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130918_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130918_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130918_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130918_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130918_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130918_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130918_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_130919_TalentDesc_1 = {
    Text = "·该角色在队伍中时，将替换「深海」界域为「晦瞑·深海」界域。\n·基础触腕伤害变更为队伍最大生命的 5%。\n·探索开始后队伍伤害强效+50%，如果队伍仅由深海或混沌唤醒体组成，该效果获得的伤害强效翻倍，但战斗开始不再获得额外触腕。\n·不再拥有「触腕集结」效果。\n·触腕姿态变更为「晦瞑·触腕姿态」。\n·「晦瞑·静海」：获得 25% 最大生命的护盾，回合结束后触腕不再攻击，3 回合冷却。\n·「晦瞑·怒涛」：使本回合触腕伤害变成 125%，造成主动伤害后使 1 条触腕攻击，但回合结束后失去 1 条触腕，3 回合冷却。\n·界域精通变更为「晦瞑·深海精通」，每点界域精通使「晦瞑·静海」的护盾提高 0.025% 最大生命，使「晦瞑·怒涛」的触腕伤害额外提高 0.025%。\n·如果队伍仅由深海或混沌唤醒体组成，「晦瞑·界域精通」效果翻倍。"
  },
  AwakerTalent_130919_TalentName_1 = {
    Text = "永黯之地"
  },
  AwakerTalent_130920_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「涡！流！弹！」固定伤害提高 [Arg3]％。\n·莫丝释放狂气爆发前移除目标「加固」与「临时加固」效果，若成功移除，本次狂气爆发暴击伤害 + [Arg4]％。"
  },
  AwakerTalent_130920_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「涡！流！弹！」固定伤害提高 [Arg3]％。\n·莫丝释放狂气爆发前移除目标「加固」与「临时加固」效果，若成功移除，本次狂气爆发暴击伤害 + [Arg4]％。"
  },
  AwakerTalent_130920_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「涡！流！弹！」固定伤害提高 [Arg3]％。\n·莫丝释放狂气爆发前移除目标「加固」与「临时加固」效果，若成功移除，本次狂气爆发暴击伤害 + [Arg4]％。"
  },
  AwakerTalent_130920_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「涡！流！弹！」固定伤害提高 [Arg3]％。\n·莫丝释放狂气爆发前移除目标「加固」与「临时加固」效果，若成功移除，本次狂气爆发暴击伤害 + [Arg4]％。"
  },
  AwakerTalent_130920_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「涡！流！弹！」固定伤害提高 [Arg3]％。\n·莫丝释放狂气爆发前移除目标「加固」与「临时加固」效果，若成功移除，本次狂气爆发暴击伤害 + [Arg4]％。"
  },
  AwakerTalent_130920_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「涡！流！弹！」固定伤害提高 [Arg3]％。\n·莫丝释放狂气爆发前移除目标「加固」与「临时加固」效果，若成功移除，本次狂气爆发暴击伤害 + [Arg4]％。"
  },
  AwakerTalent_130920_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「涡！流！弹！」固定伤害提高 [Arg3]％。\n·莫丝释放狂气爆发前移除目标「加固」与「临时加固」效果，若成功移除，本次狂气爆发暴击伤害 + [Arg4]％。"
  },
  AwakerTalent_130920_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「涡！流！弹！」固定伤害提高 [Arg3]％。\n·莫丝释放狂气爆发前移除目标「加固」与「临时加固」效果，若成功移除，本次狂气爆发暴击伤害 + [Arg4]％。"
  },
  AwakerTalent_130920_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「涡！流！弹！」固定伤害提高 [Arg3]％。\n·莫丝释放狂气爆发前移除目标「加固」与「临时加固」效果，若成功移除，本次狂气爆发暴击伤害 + [Arg4]％。"
  },
  AwakerTalent_130920_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「涡！流！弹！」固定伤害提高 [Arg3]％。\n·莫丝释放狂气爆发前移除目标「加固」与「临时加固」效果，若成功移除，本次狂气爆发暴击伤害 + [Arg4]％。"
  },
  AwakerTalent_130920_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130920_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130920_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130920_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130920_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130920_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130920_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130920_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130920_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_130920_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_131854_TalentDesc_1 = {
    Text = "·沙耶在队伍中时，将替换「血肉」界域为「繁育·血肉」界域。\n·胚胎融合：每回合获得的胚胎融合提高为 50~100，随损失生命提高，但胚胎融合上限由 100 提高为 200，达到上限时将「繁育·胚胎」置入手中。\n·繁育胚胎：打出时不再获得暴击率，吞噬也不再获得护盾和临时力量。每名唤醒体每回合首次消耗「繁育·胚胎」时，获得 40 层「繁育庆典」：每拥有 1 层该唤醒体本回合下次狂气爆发造成的伤害、固定护盾、固定生命回复、固定力量、力量降低、触腕伤害提高、固定中毒、固定反击的最终效果提高 1％。\n·猩红熔炉：回合开始的自动积攒量变更为 10% 已损失生命，至多积攒量变更为 50% 最大生命。战斗结束时不再积攒，使用时有 3 回合冷却。\n·猩红侵蚀：使用猩红熔炉后对所有敌人造成目标最大生命 1% 的侵蚀，消耗的猩红熔炉越多侵蚀效果就越强，至多提高 100%。对「空壳」敌人造成 5 倍侵蚀效果。\n·探索开始后，最大生命提高 10％，队伍伤害强效 +50%，每回合开始时所有唤醒体获得 20 层「繁育庆典」。如果队伍仅由血肉或混沌唤醒体组成，该效果获得的伤害强效翻倍。\n·界域精通变为「繁育·血肉精通」，每点界域精通使「繁育·血肉」获得的「繁育庆典」提高 0.05%。 \n·如果队伍仅由血肉或混沌唤醒体组成，「繁育·血肉精通」效果翻倍。"
  },
  AwakerTalent_131854_TalentName_1 = {
    Text = "繁育净土"
  },
  AwakerTalent_132356_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132356_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132356_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132356_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132356_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132356_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132356_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132356_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132356_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132356_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132356_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132356_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132356_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132356_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132356_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132356_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132356_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132356_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132356_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132356_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132356_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132356_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132356_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132356_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132422_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132422_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132422_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132422_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132422_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132422_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132422_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132422_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132422_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132422_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132422_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132422_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132422_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132422_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132422_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132422_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132422_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132422_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132422_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132422_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132422_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132422_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132422_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132422_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132423_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132423_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132423_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132423_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132423_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132423_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132423_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132423_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132423_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132423_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132423_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132423_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132423_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132423_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132423_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132423_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132423_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132423_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132423_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132423_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132423_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132423_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132423_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132423_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132424_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132424_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132424_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132424_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132424_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132424_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132424_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132424_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132424_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132424_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132424_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132424_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_132424_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132424_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132424_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132424_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132424_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132424_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132424_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132424_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132424_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132424_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132424_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_132424_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_139506_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139506_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139506_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139506_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139506_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139506_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139506_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139506_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139506_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139506_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139507_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139507_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139507_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139507_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139507_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139507_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139507_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139507_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139507_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139507_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139508_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139508_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139508_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139508_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139508_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139508_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139508_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139508_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139508_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139508_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139509_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139509_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139509_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139509_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139509_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139509_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139509_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139509_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139509_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139509_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139510_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139510_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139510_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139510_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139510_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139510_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139510_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139510_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139510_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139510_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139511_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139511_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139511_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139511_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139511_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139511_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139511_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139511_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139511_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139511_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139512_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139512_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139512_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139512_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139512_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139512_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139512_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139512_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139512_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139512_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139513_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139513_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139513_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139513_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139513_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139513_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139513_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139513_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139513_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139513_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139514_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139514_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139514_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139514_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139514_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139514_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139514_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139514_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139514_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139514_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139515_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139515_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139515_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139515_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139515_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139515_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139515_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139515_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139515_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139515_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139517_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139517_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139517_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139517_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139517_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139517_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139517_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139517_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139517_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139517_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139518_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139518_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139518_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139518_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139518_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139518_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139518_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139518_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139518_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139518_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139519_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139519_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139519_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139519_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139519_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139519_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139519_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139519_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139519_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139519_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139520_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139520_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139520_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139520_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139520_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139520_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139520_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139520_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139520_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139520_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139521_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139521_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139521_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139521_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139521_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139521_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139521_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139521_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139521_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139521_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139522_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139522_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139522_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139522_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139522_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139522_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139522_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139522_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139522_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139522_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139523_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139523_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139523_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139523_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139523_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139523_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139523_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139523_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139523_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139523_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139524_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139524_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139524_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139524_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139524_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139524_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139524_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139524_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139524_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139524_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139525_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139525_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139525_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139525_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139525_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139525_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139525_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139525_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139525_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139525_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139526_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139526_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139526_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139526_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139526_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139526_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139526_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139526_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139526_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139526_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139527_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139527_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139527_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139527_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139527_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139527_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139527_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139527_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139527_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139527_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139528_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139528_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139528_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139528_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139528_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139528_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139528_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139528_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139528_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139528_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139529_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139529_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139529_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139529_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139529_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139529_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139529_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139529_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139529_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139529_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139530_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139530_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139530_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139530_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139530_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139530_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139530_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139530_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139530_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139530_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139531_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139531_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139531_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139531_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139531_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139531_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139531_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139531_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139531_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139531_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139532_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139532_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139532_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139532_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139532_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139532_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139532_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139532_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139532_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139532_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139533_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139533_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139533_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139533_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139533_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139533_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139533_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139533_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139533_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139533_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139535_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139535_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139535_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139535_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139535_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139535_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139535_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139535_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139535_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139535_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139536_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139536_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139536_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139536_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139536_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139536_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139536_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139536_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139536_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139536_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139537_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139537_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139537_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139537_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139537_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139537_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139537_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139537_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139537_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139537_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139538_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139538_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139538_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139538_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139538_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139538_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139538_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139538_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139538_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139538_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139539_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139539_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139539_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139539_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139539_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139539_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139539_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139539_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139539_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139539_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139540_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139540_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139540_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139540_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139540_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139540_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139540_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139540_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139540_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139540_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139541_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139541_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139541_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139541_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139541_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139541_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139541_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139541_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139541_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139541_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139542_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139542_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139542_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139542_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139542_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139542_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139542_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139542_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139542_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139542_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139543_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139543_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139543_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139543_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139543_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139543_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139543_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139543_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139543_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139543_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139544_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139544_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139544_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139544_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139544_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139544_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139544_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139544_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139544_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139544_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139545_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139545_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139545_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139545_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139545_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139545_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139545_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139545_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139545_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139545_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139546_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139546_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139546_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139546_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139546_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139546_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139546_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139546_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139546_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139546_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139547_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139547_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139547_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139547_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139547_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139547_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139547_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139547_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139547_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139547_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139548_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139548_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139548_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139548_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139548_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139548_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139548_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139548_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139548_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139548_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139549_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139549_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139549_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139549_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139549_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139549_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139549_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139549_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139549_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139549_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139550_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139550_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139550_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139550_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139550_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139550_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139550_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139550_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139550_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139550_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139551_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139551_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139551_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139551_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139551_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139551_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139551_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139551_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139551_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139551_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139552_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139552_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139552_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139552_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139552_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139552_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139552_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139552_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139552_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139552_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139553_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139553_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139553_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139553_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139553_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139553_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139553_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139553_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139553_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139553_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139555_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139555_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139555_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139555_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139555_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139555_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139555_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139555_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139555_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139555_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139556_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139556_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139556_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139556_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139556_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139556_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139556_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139556_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139556_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139556_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139557_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139557_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139557_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139557_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139557_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139557_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139557_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139557_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139557_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139557_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139558_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139558_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139558_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139558_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139558_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139558_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139558_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139558_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139558_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139558_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139559_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139559_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139559_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139559_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139559_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139559_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139559_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139559_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139559_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139559_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139560_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139560_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139560_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139560_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139560_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139560_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139560_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139560_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139560_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139560_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139561_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139561_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139561_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139561_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139561_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139561_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139561_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139561_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139561_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139561_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139562_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139562_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139562_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139562_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139562_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139562_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139562_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139562_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139562_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139562_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139563_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139563_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139563_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139563_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139563_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139563_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139563_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139563_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139563_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139563_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139564_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139564_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139564_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139564_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139564_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139564_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139564_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139564_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139564_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139564_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139565_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139565_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139565_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139565_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139565_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139565_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139565_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139565_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139565_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139565_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139566_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139566_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139566_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139566_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139566_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139566_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139566_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139566_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139566_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139566_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139567_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139567_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139567_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139567_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139567_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139567_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139567_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139567_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139567_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139567_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139568_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139568_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139568_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139568_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139568_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139568_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139568_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139568_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139568_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139568_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139569_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139569_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139569_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139569_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139569_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139569_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139569_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139569_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139569_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139569_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139570_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139570_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139570_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139570_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139570_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139570_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139570_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139570_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139570_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139570_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139571_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139571_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139571_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139571_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139571_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139571_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139571_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139571_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139571_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139571_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139572_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139572_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139572_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139572_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139572_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139572_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139572_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139572_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139572_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139572_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139573_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139573_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139573_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139573_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139573_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139573_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139573_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139573_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139573_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139573_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139574_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139574_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139574_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139574_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139574_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139574_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139574_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139574_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139574_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139574_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_139575_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139575_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139575_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139575_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139575_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139575_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_139575_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_139575_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_139575_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_139575_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_141303_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「庞托斯」对「欢愉眷属」敌人造成的固定伤害提高 [Arg3]％。\n·「无休猎宴」每消耗 10 点狂气就获得 [Arg4]％ 攻击力的触腕伤害，「纵魇掠袭」造成伤害时还会临时降低目标 [Arg5]％ 防御力的力量。"
  },
  AwakerTalent_141303_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「庞托斯」对「欢愉眷属」敌人造成的固定伤害提高 [Arg3]％。\n·「无休猎宴」每消耗 10 点狂气就获得 [Arg4]％ 攻击力的触腕伤害，「纵魇掠袭」造成伤害时还会临时降低目标 [Arg5]％ 防御力的力量。"
  },
  AwakerTalent_141303_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「庞托斯」对「欢愉眷属」敌人造成的固定伤害提高 [Arg3]％。\n·「无休猎宴」每消耗 10 点狂气就获得 [Arg4]％ 攻击力的触腕伤害，「纵魇掠袭」造成伤害时还会临时降低目标 [Arg5]％ 防御力的力量。"
  },
  AwakerTalent_141303_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「庞托斯」对「欢愉眷属」敌人造成的固定伤害提高 [Arg3]％。\n·「无休猎宴」每消耗 10 点狂气就获得 [Arg4]％ 攻击力的触腕伤害，「纵魇掠袭」造成伤害时还会临时降低目标 [Arg5]％ 防御力的力量。"
  },
  AwakerTalent_141303_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「庞托斯」对「欢愉眷属」敌人造成的固定伤害提高 [Arg3]％。\n·「无休猎宴」每消耗 10 点狂气就获得 [Arg4]％ 攻击力的触腕伤害，「纵魇掠袭」造成伤害时还会临时降低目标 [Arg5]％ 防御力的力量。"
  },
  AwakerTalent_141303_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「庞托斯」对「欢愉眷属」敌人造成的固定伤害提高 [Arg3]％。\n·「无休猎宴」每消耗 10 点狂气就获得 [Arg4]％ 攻击力的触腕伤害，「纵魇掠袭」造成伤害时还会临时降低目标 [Arg5]％ 防御力的力量。"
  },
  AwakerTalent_141303_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「庞托斯」对「欢愉眷属」敌人造成的固定伤害提高 [Arg3]％。\n·「无休猎宴」每消耗 10 点狂气就获得 [Arg4]％ 攻击力的触腕伤害，「纵魇掠袭」造成伤害时还会临时降低目标 [Arg5]％ 防御力的力量。"
  },
  AwakerTalent_141303_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「庞托斯」对「欢愉眷属」敌人造成的固定伤害提高 [Arg3]％。\n·「无休猎宴」每消耗 10 点狂气就获得 [Arg4]％ 攻击力的触腕伤害，「纵魇掠袭」造成伤害时还会临时降低目标 [Arg5]％ 防御力的力量。"
  },
  AwakerTalent_141303_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「庞托斯」对「欢愉眷属」敌人造成的固定伤害提高 [Arg3]％。\n·「无休猎宴」每消耗 10 点狂气就获得 [Arg4]％ 攻击力的触腕伤害，「纵魇掠袭」造成伤害时还会临时降低目标 [Arg5]％ 防御力的力量。"
  },
  AwakerTalent_141303_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「庞托斯」对「欢愉眷属」敌人造成的固定伤害提高 [Arg3]％。\n·「无休猎宴」每消耗 10 点狂气就获得 [Arg4]％ 攻击力的触腕伤害，「纵魇掠袭」造成伤害时还会临时降低目标 [Arg5]％ 防御力的力量。"
  },
  AwakerTalent_141303_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_141303_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_141303_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_141303_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_141303_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_141303_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_141303_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_141303_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_141303_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_141303_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_141304_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_141304_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_141304_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_141304_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_141304_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_141304_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_141304_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_141304_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_141304_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_141304_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_141304_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_141304_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_141304_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_141304_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_141304_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_141304_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_141304_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_141304_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_141304_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_141304_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_141304_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_141304_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_141304_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_141304_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_141305_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_141305_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_141305_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_141305_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_141305_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_141305_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_141305_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_141305_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_141305_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_141305_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_143615_TalentDesc_1 = {
    Text = "·该角色在队伍中时，将替换「深海」界域为「晦瞑·深海」界域。\n·基础触腕伤害变更为队伍最大生命的 5%。\n·探索开始后队伍伤害强效+50%，如果队伍仅由深海或混沌唤醒体组成，该效果获得的伤害强效翻倍，但战斗开始不再获得额外触腕。\n·不再拥有「触腕集结」效果。\n·触腕姿态变更为「晦瞑·触腕姿态」。\n·「晦瞑·静海」：获得 25% 最大生命的护盾，回合结束后触腕不再攻击，3 回合冷却。\n·「晦瞑·怒涛」：使本回合触腕伤害变成 125%，造成主动伤害后使 1 条触腕攻击，但回合结束后失去 1 条触腕，3 回合冷却。\n·界域精通变更为「晦瞑·深海精通」，每点界域精通使「晦瞑·静海」的护盾提高 0.025% 最大生命，使「晦瞑·怒涛」的触腕伤害额外提高 0.025%。\n·如果队伍仅由深海或混沌唤醒体组成，「晦瞑·界域精通」效果翻倍。"
  },
  AwakerTalent_143615_TalentName_1 = {
    Text = "永黯之地"
  },
  AwakerTalent_145379_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_145379_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_145379_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_145379_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_145379_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_145379_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_145379_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_145379_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_145379_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_145379_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_145380_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_145380_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_145380_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_145380_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_145380_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_145380_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_145380_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_145380_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_145380_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_145380_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_145380_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_145380_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_145380_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_145380_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_145380_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_145380_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_145380_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_145380_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_145380_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_145380_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_145380_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_145380_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_145380_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_145380_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_145381_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「断界之剑」额外享受 [Arg3]％ 力量加成，击杀敌人后获得 [Arg4] 黑印，享受自身黑印掉落加成，每场战斗最多生效 1 次。"
  },
  AwakerTalent_145381_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「断界之剑」额外享受 [Arg3]％ 力量加成，击杀敌人后获得 [Arg4] 黑印，享受自身黑印掉落加成，每场战斗最多生效 1 次。"
  },
  AwakerTalent_145381_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「断界之剑」额外享受 [Arg3]％ 力量加成，击杀敌人后获得 [Arg4] 黑印，享受自身黑印掉落加成，每场战斗最多生效 1 次。"
  },
  AwakerTalent_145381_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「断界之剑」额外享受 [Arg3]％ 力量加成，击杀敌人后获得 [Arg4] 黑印，享受自身黑印掉落加成，每场战斗最多生效 1 次。"
  },
  AwakerTalent_145381_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「断界之剑」额外享受 [Arg3]％ 力量加成，击杀敌人后获得 [Arg4] 黑印，享受自身黑印掉落加成，每场战斗最多生效 1 次。"
  },
  AwakerTalent_145381_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「断界之剑」额外享受 [Arg3]％ 力量加成，击杀敌人后获得 [Arg4] 黑印，享受自身黑印掉落加成，每场战斗最多生效 1 次。"
  },
  AwakerTalent_145381_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「断界之剑」额外享受 [Arg3]％ 力量加成，击杀敌人后获得 [Arg4] 黑印，享受自身黑印掉落加成，每场战斗最多生效 1 次。"
  },
  AwakerTalent_145381_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「断界之剑」额外享受 [Arg3]％ 力量加成，击杀敌人后获得 [Arg4] 黑印，享受自身黑印掉落加成，每场战斗最多生效 1 次。"
  },
  AwakerTalent_145381_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「断界之剑」额外享受 [Arg3]％ 力量加成，击杀敌人后获得 [Arg4] 黑印，享受自身黑印掉落加成，每场战斗最多生效 1 次。"
  },
  AwakerTalent_145381_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「断界之剑」额外享受 [Arg3]％ 力量加成，击杀敌人后获得 [Arg4] 黑印，享受自身黑印掉落加成，每场战斗最多生效 1 次。"
  },
  AwakerTalent_145381_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_145381_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_145381_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_145381_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_145381_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_145381_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_145381_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_145381_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_145381_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_145381_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_145718_TalentDesc_1 = {
    Text = "·卡拉布在队伍中时，将替换「血肉」界域为「繁育·血肉」界域。\n·胚胎融合：每回合获得的胚胎融合提高为 50~100，随损失生命提高，但胚胎融合上限由 100 提高为 200，达到上限时将「繁育·胚胎」置入手中。\n·繁育胚胎：打出时不再获得暴击率，吞噬也不再获得护盾和临时力量。每名唤醒体每回合首次消耗「繁育·胚胎」时，获得 40 层「繁育庆典」：每拥有 1 层该唤醒体本回合下次狂气爆发造成的伤害、固定护盾、固定生命回复、固定力量、力量降低、触腕伤害提高、固定中毒、固定反击的最终效果提高 1％。\n·猩红熔炉：回合开始的自动积攒量变更为 10% 已损失生命，至多积攒量变更为 50% 最大生命。战斗结束时不再积攒，使用时有 3 回合冷却。\n·猩红侵蚀：使用猩红熔炉后对所有敌人造成目标最大生命 1% 的侵蚀，消耗的猩红熔炉越多侵蚀效果就越强，至多提高 100%。对「空壳」敌人造成 5 倍侵蚀效果。\n·探索开始后，最大生命提高 10％，队伍伤害强效 +50%，每回合开始时所有唤醒体获得 20 层「繁育庆典」。如果队伍仅由血肉或混沌唤醒体组成，该效果获得的伤害强效翻倍。\n·界域精通变为「繁育·血肉精通」，每点界域精通使「繁育·血肉」获得的「繁育庆典」提高 0.05%。 \n·如果队伍仅由血肉或混沌唤醒体组成，「繁育·血肉精通」效果翻倍。"
  },
  AwakerTalent_145718_TalentName_1 = {
    Text = "繁育净土"
  },
  AwakerTalent_146937_TalentDesc_1 = {
    Text = "·蚀灭·萝坦在队伍中时，替换「混沌」界域为「原初·混沌」界域。\n·原初灌注：基础银钥能量提高为 2000 点，队伍伤害强效 +50%，所有唤醒体的攻击和防御提高 10%。如果队伍仅由混沌唤醒体组成，该效果获得的伤害强效翻倍。战斗开始时，获得 2000 点银钥能量。\n·万钥同源：所有唤醒体的银钥充能等级变为队伍平均值。且不再根据算力消耗获得银钥能量，而是每名唤醒体每回合首张指令卡获得「该唤醒体银钥充能×3+100」的银钥能量。\n·未分之境：不再触发其他界域的至纯界域、精通效果翻倍、强效翻倍效果。\n·原初回响：灵知觉醒获得预备 1，每回合首次打出时自动释放携带钥令。\n·记忆碎片：钥令被替换为「原初·双生复演」和 「原初·三相天启」，本身携带的钥令无法释放。\n·原初 · 双生复演：从持有钥令中发现 3 种钥令，选择 1 个钥令使其生效 2 次。\n·原初 · 三相天启：从持有钥令中发现 3 组钥令，每组由 3 种不同钥令组成，选择一组使其中钥令依次生效 1 次。\n·原初·双生复演和原初·三相天启中的钥令会包含八种「原初记忆」。\n·原初·双生复演和原初·三相天启仅视为释放 1 次钥令，在多次生效时仅对首个生效的钥令有效。\n·界域精通变为「原初·混沌精通」，每点界域精通使钥令强度提高 0.05%。\n·每点钥令强度提高钥令造成的固定中毒、固定反击、固定力量、固定触腕伤害、固定旧日余烬 2%、提高固定护盾、固定生命回复、力量降低、暴击率、暴击伤害、伤害强效、界域精通、狂气、胚胎融合、银钥能量 1%。\n·如果队伍仅由混沌唤醒体组成，「原初·混沌精通」效果翻倍。"
  },
  AwakerTalent_146937_TalentName_1 = {
    Text = "原初吐息"
  },
  AwakerTalent_147414_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_147414_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_147414_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_147414_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_147414_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_147414_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_147414_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_147414_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_147414_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_147414_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_147414_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_147414_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_147414_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_147414_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_147414_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_147414_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_147414_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_147414_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_147414_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_147414_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_147415_TalentDesc_1 = {
    Text = "·汀克特唤醒体自身、命轮、密契每提供 1% 黑印掉落属性，就使「星彩极光」额外获得 0.3% 临时暴击率。"
  },
  AwakerTalent_147415_TalentName_1 = {
    Text = "行星旅者"
  },
  AwakerTalent_147416_TalentDesc_1 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_147416_TalentDesc_2 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_147416_TalentDesc_3 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_147416_TalentDesc_4 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_147416_TalentDesc_5 = {
    Text = "该唤醒体提升 [Arg1] 个等级的属性。\n   ·体质提高 [Talent_Attr_Lv_physique] \n   ·攻击提高 [Talent_Attr_Lv_atk] \n   ·防御提高 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_147416_TalentName_1 = {
    Text = "内在灵格"
  },
  AwakerTalent_147416_TalentName_2 = {
    Text = "内在灵格"
  },
  AwakerTalent_147416_TalentName_3 = {
    Text = "内在灵格"
  },
  AwakerTalent_147416_TalentName_4 = {
    Text = "内在灵格"
  },
  AwakerTalent_147416_TalentName_5 = {
    Text = "内在灵格"
  },
  AwakerTalent_147417_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_147417_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_147417_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_147417_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_147417_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_147417_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_147417_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_147417_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_147417_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_147417_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_147417_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_147417_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_147417_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_147417_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_147417_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_147417_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_147417_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_147417_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_147417_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_147417_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_147417_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_147417_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_147417_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_147417_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44844_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44844_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44844_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44844_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44844_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44844_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44844_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44844_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44844_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44844_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44844_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44844_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44844_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44844_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44844_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44844_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44844_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44844_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44844_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44844_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44844_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44844_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44844_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44844_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44845_TalentDesc_1 = {
    Text = "·莉莉自身、装备的命轮与密契每提供 1% 死亡抵抗，「黑沼禁域」与「基础防御」的基础护盾就提高 0.25%，首领战中忍耐的积攒量和上限提高 0.25%。\n·莉莉在队伍中时，失去 1 点生命时获得 1 层忍耐，忍耐堆叠上限等于最大生命。"
  },
  AwakerTalent_44845_TalentName_1 = {
    Text = "翻涌的黑色"
  },
  AwakerTalent_44846_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44846_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44846_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44846_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44846_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44846_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44846_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44846_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44846_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44846_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44846_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44846_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44846_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44846_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44846_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44846_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44846_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44846_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44846_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44846_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44846_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44846_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44846_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44846_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44847_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44847_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44847_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44847_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44847_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44847_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44847_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44847_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44847_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44847_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44847_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44847_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44847_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44847_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44847_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44847_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44847_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44847_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44847_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44847_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44847_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44847_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44847_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44847_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44848_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44848_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44848_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44848_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44848_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44848_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44848_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44848_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44848_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44848_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44848_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44848_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44848_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44848_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44848_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44848_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44848_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44848_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44848_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44848_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44848_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44848_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44848_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44848_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44849_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44849_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44849_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44849_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44849_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44849_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44849_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44849_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44849_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44849_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44849_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44849_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44849_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44849_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44849_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44849_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44849_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44849_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44849_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44849_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44849_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44849_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44849_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44849_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44850_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44850_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44850_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44850_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44850_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44850_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44850_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44850_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44850_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44850_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44850_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44850_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44850_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44850_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44850_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44850_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44850_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44850_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44850_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44850_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44850_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44850_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44850_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44850_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44851_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44851_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44851_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44851_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44851_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44851_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44851_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44851_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44851_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44851_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44851_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44851_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44851_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44851_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44851_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44851_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44851_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44851_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44851_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44851_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44851_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44851_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44851_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44851_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44852_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44852_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44852_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44852_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44852_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44852_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44852_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44852_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44852_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44852_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44852_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44852_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44852_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44852_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44852_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44852_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44852_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44852_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44852_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44852_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44852_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44852_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44852_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44852_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44853_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44853_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44853_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44853_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44853_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44853_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44853_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44853_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44853_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44853_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44853_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44853_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44853_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44853_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44853_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44853_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44853_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44853_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44853_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44853_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44853_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44853_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44853_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44853_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44854_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44854_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44854_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44854_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44854_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44854_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44854_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44854_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44854_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44854_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44854_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44854_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44854_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44854_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44854_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44854_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44854_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44854_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44854_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44854_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44854_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44854_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44854_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44854_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44855_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44855_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44855_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44855_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44855_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44855_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44855_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44855_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44855_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44855_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44855_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44855_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44855_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44855_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44855_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44855_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44855_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44855_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44855_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44855_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44855_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44855_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44855_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44855_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44856_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44856_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44856_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44856_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44856_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44856_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44856_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44856_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44856_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44856_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44856_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44856_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44856_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44856_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44856_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44856_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44856_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44856_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44856_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44856_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44856_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44856_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44856_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44856_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44857_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44857_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44857_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44857_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44857_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44857_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44857_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44857_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44857_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44857_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44857_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44857_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44857_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44857_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44857_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44857_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44857_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44857_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44857_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44857_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44857_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44857_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44857_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44857_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44858_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44858_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44858_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44858_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44858_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44858_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44858_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44858_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44858_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44858_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44858_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44858_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44858_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44858_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44858_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44858_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44858_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44858_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44858_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44858_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44858_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44858_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44858_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44858_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44859_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44859_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44859_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44859_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44859_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44859_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44859_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44859_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44859_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44859_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44859_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44859_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44859_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44859_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44859_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44859_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44859_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44859_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44859_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44859_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44859_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44859_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44859_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44859_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44860_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44860_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44860_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44860_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44860_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44860_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44860_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44860_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44860_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44860_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44860_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44860_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44860_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44860_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44860_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44860_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44860_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44860_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44860_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44860_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44860_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44860_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44860_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44860_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44861_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44861_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44861_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44861_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44861_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44861_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44861_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44861_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44861_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44861_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44861_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44861_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44861_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44861_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44861_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44861_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44861_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44861_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44861_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44861_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44861_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44861_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44861_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44861_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44862_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44862_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44862_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44862_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44862_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44862_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44862_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44862_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44862_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44862_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44862_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44862_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44862_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44862_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44862_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44862_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44862_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44862_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44862_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44862_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44862_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44862_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44862_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44862_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44863_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44863_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44863_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44863_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44863_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44863_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44863_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44863_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44863_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44863_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44863_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44863_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44863_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44863_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44863_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44863_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44863_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44863_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44863_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44863_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44863_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44863_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44863_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44863_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44865_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44865_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44865_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44865_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44865_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44865_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44865_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44865_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44865_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44865_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44865_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44865_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44865_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44865_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44865_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44865_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44865_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44865_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44865_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44865_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44865_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44865_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44865_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44865_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44866_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44866_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44866_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44866_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44866_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44866_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44866_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44866_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44866_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44866_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44866_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44866_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44866_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44866_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44866_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44866_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44866_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44866_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44866_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44866_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44866_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44866_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44866_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44866_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44867_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44867_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44867_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44867_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44867_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44867_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44867_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44867_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44867_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44867_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44867_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44867_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44867_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44867_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44867_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44867_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44867_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44867_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44867_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44867_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44867_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44867_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44867_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44867_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44868_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44868_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44868_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44868_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44868_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44868_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44868_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44868_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44868_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44868_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44868_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44868_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44868_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44868_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44868_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44868_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44868_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44868_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44868_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44868_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44868_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44868_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44868_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44868_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44869_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44869_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44869_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44869_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44869_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44869_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44869_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44869_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44869_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44869_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44869_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44869_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44869_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44869_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44869_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44869_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44869_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44869_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44869_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44869_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44869_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44869_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44869_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44869_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44870_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44870_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44870_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44870_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44870_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44870_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44870_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44870_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44870_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44870_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44870_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44870_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44870_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44870_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44870_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44870_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44870_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44870_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44870_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44870_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44870_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44870_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44870_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44870_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44871_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44871_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44871_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44871_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44871_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44871_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44871_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44871_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44871_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44871_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44871_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44871_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44871_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44871_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44871_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44871_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44871_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44871_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44871_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44871_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44871_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44871_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44871_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44871_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44873_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44873_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44873_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44873_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44873_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44873_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44873_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44873_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44873_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44873_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44873_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44873_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44873_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44873_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44873_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44873_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44873_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44873_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44873_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44873_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44873_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44873_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44873_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44873_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44874_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44874_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44874_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44874_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44874_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44874_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44874_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44874_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44874_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44874_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44874_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44874_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44874_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44874_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44874_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44874_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44874_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44874_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44874_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44874_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44874_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44874_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44874_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44874_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44875_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44875_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44875_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44875_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44875_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44875_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44875_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44875_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44875_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44875_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44875_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44875_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44875_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44875_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44875_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44875_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44875_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44875_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44875_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44875_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44875_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44875_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44875_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44875_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44876_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44876_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44876_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44876_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44876_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44876_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44876_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44876_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44876_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44876_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44876_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44876_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44876_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44876_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44876_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44876_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44876_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44876_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44876_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44876_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44876_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44876_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44876_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44876_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44877_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44877_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44877_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44877_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44877_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44877_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44877_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44877_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44877_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44877_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44877_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44877_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44877_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44877_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44877_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44877_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44877_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44877_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44877_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44877_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44877_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44877_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44877_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44877_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44878_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44878_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44878_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44878_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44878_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44878_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44878_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44878_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44878_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44878_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44878_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44878_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44878_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44878_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44878_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44878_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44878_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44878_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44878_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44878_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44878_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44878_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44878_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44878_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44879_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44879_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44879_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44879_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44879_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44879_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44879_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44879_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44879_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44879_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44879_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44879_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44879_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44879_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44879_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44879_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44879_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44879_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44879_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44879_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44879_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44879_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44879_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44879_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44880_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44880_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44880_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44880_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44880_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44880_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44880_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44880_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44880_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44880_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44880_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44880_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44880_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44880_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44880_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44880_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44880_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44880_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44880_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44880_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44880_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44880_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44880_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44880_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44881_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44881_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44881_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44881_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44881_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44881_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44881_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44881_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44881_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44881_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44881_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44881_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44881_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44881_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44881_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44881_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44881_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44881_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44881_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44881_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44881_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44881_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44881_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44881_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44882_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44882_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44882_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44882_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44882_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44882_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44882_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44882_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44882_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44882_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44882_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44882_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44882_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44882_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44882_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44882_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44882_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44882_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44882_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44882_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44882_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44882_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44882_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44882_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44883_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44883_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44883_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44883_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44883_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44883_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44883_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44883_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44883_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44883_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44883_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44883_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44883_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44883_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44883_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44883_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44883_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44883_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44883_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44883_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44883_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44883_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44883_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44883_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44884_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44884_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44884_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44884_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44884_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44884_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44884_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44884_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44884_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44884_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44884_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44884_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44884_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44884_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44884_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44884_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44884_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44884_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44884_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44884_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44884_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44884_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44884_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44884_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44885_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44885_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44885_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44885_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44885_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44885_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44885_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44885_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44885_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44885_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44885_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44885_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44885_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44885_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44885_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44885_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44885_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44885_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44885_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44885_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44885_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44885_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44885_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44885_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44886_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44886_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44886_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44886_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44886_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44886_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44886_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44886_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44886_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44886_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44886_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44886_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44886_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44886_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44886_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44886_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44886_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44886_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44886_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44886_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44886_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44886_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44886_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44886_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44887_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44887_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44887_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44887_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44887_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44887_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44887_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44887_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44887_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44887_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44887_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44887_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44887_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44887_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44887_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44887_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44887_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44887_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44887_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44887_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44887_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44887_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44887_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44887_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44888_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44888_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44888_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44888_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44888_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44888_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44888_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44888_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44888_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44888_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44888_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44888_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_44888_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44888_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44888_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44888_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44888_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44888_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44888_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44888_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44888_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44888_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44888_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_44888_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_46162_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_46162_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_46162_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_46162_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_46162_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_46162_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_46162_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_46162_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_46162_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_46162_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_46162_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_46162_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_46162_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_46162_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_46162_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_46162_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_46162_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_46162_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_46162_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_46162_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_46162_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_46162_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_46162_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_46162_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_46445_TalentDesc_1 = {
    Text = "·萨尔瓦多提供的熔炉回复效果会享受生命回复提高的加成。"
  },
  AwakerTalent_46445_TalentName_1 = {
    Text = "灵魂牧者"
  },
  AwakerTalent_46446_TalentDesc_1 = {
    Text = "·拉蒙娜额外获得 2.5 点银钥充能属性。每个同调率等级额外使拉蒙娜获得 0.5 点银钥充能属性。 \n·每拥有 1 点银钥充能等级属性，就使「女王之剑」基础伤害提高 1 %，打出后获得 0.75 临时界域精通。"
  },
  AwakerTalent_46446_TalentName_1 = {
    Text = "心与银的共振"
  },
  AwakerTalent_46487_TalentDesc_1 = {
    Text = "·环行·拉蒙娜额外获得 2.5 点银钥充能属性。每个同调率等级额外使环行·拉蒙娜获得 0.5 点银钥充能属性。 \n·每拥有 1 点银钥充能等级属性，就使「基础打击」的回环效果使环行·拉蒙娜获得 0.2% 暴击率，「基础防御」的回环效果使环行·拉蒙娜获得 0.2 狂气。"
  },
  AwakerTalent_46487_TalentName_1 = {
    Text = "心与银的共振"
  },
  AwakerTalent_49872_TalentDesc_1 = {
    Text = "·诺缔拉每拥有 1 点界域精通属性，「整装待发」造成的反击就提高 0.25%。"
  },
  AwakerTalent_49872_TalentName_1 = {Text = "检修"},
  AwakerTalent_49873_TalentDesc_1 = {
    Text = "·宁菲亚每拥有 1% 伤害强效属性，「丧钟遥鸣」与「自我的葬仪」造成的基础中毒效果就提高 0.5%。"
  },
  AwakerTalent_49873_TalentName_1 = {Text = "浸染"},
  AwakerTalent_51744_TalentDesc_1 = {
    Text = "·战斗开始时，将 1 张「执妄」置入手中。\n·弥利亚姆的「基础打击」享受 100% 触腕伤害加成。\n·弥利亚姆唤醒体自身、命轮、密契每提供 1% 暴击伤害，就使狂气爆发的力量、触腕伤害、狂气、施加和触发中毒效果提高 0.2%。"
  },
  AwakerTalent_51744_TalentName_1 = {
    Text = "不灭虔诚"
  },
  AwakerTalent_52071_TalentDesc_1 = {
    Text = "·图鲁自身、装备的命轮与密契每提供 1 点狂气回充等级，「基础打击」就受到 5% 触腕伤害和力量加成，「深渊号令」受到 15% 触腕伤害和力量加成。"
  },
  AwakerTalent_52071_TalentName_1 = {
    Text = "神王权能"
  },
  AwakerTalent_52086_TalentDesc_1 = {
    Text = "·珊自身、装备的命轮与密契每提供 1% 死亡抵抗，就使「基础打击」和「基础防御」获得的狂气提高 0.03 点，「失落的艺术」额外享受 0.15% 暴击率与暴击伤害加成。"
  },
  AwakerTalent_52086_TalentName_1 = {
    Text = "死亡启迪"
  },
  AwakerTalent_54047_TalentDesc_1 = {
    Text = "·朵尔每拥有 1 点狂气回充等级属性，就使「外域手术」与「等价交换」回复生命效果提高 0.5%。"
  },
  AwakerTalent_54047_TalentName_1 = {
    Text = "灵知解构"
  },
  AwakerTalent_54072_TalentDesc_1 = {
    Text = "·奥吉尔每拥有 1% 黑印掉落属性，「七艺，传承美德」获得的临时力量就提高 3%。"
  },
  AwakerTalent_54072_TalentName_1 = {
    Text = "无形炼化"
  },
  AwakerTalent_54073_TalentDesc_1 = {
    Text = "·艾尔瓦每拥有 1% 死亡抵抗属性造成的基础伤害提高 0.5%。"
  },
  AwakerTalent_54073_TalentName_1 = {
    Text = "动态视野"
  },
  AwakerTalent_54119_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54119_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54119_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54119_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54119_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54119_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54119_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54119_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54119_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54119_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54119_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54119_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54119_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54119_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54119_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54119_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54119_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54119_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54119_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54119_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54119_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54119_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54119_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54119_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54120_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54120_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54120_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54120_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54120_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54120_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54120_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54120_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54120_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54120_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54120_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54120_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_54120_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54120_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54120_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54120_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54120_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54120_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54120_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54120_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54120_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54120_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54120_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54120_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_54158_TalentDesc_1 = {
    Text = "·索蕾尔自身、装备的命轮与密契每有 1% 暴击率，就使「基础防御」获得的狂气提高 0.2。"
  },
  AwakerTalent_54158_TalentName_1 = {
    Text = "浮华之守"
  },
  AwakerTalent_55109_TalentDesc_1 = {
    Text = "·詹金唤醒体自身、命轮、密契每提供 1% 暴击率，就使「基础打击」与「布朗出动」基础伤害提高 2%。"
  },
  AwakerTalent_55109_TalentName_1 = {
    Text = "同仇敌忾"
  },
  AwakerTalent_55176_TalentDesc_1 = {
    Text = "·艾瑞卡唤醒体自身、命轮、密契每提供 1  点银钥充能等级属性，「电磁爆破」就使艾瑞卡获得 0.5% 临时暴击率与暴击伤害。"
  },
  AwakerTalent_55176_TalentName_1 = {
    Text = "外接能源"
  },
  AwakerTalent_55202_TalentDesc_1 = {
    Text = "·回合开始时，获得 1 层梦引。\n·每消耗 1 层梦引，使本场战斗中「迷途之守」和「死梦之都」获得的反击提高攻击力的 5%。\n·旺达唤醒体自身、命轮、密契每提供 1% 伤害强效属性，「死梦之都」获得的反击就提高 0.75%。"
  },
  AwakerTalent_55202_TalentName_1 = {Text = "启示"},
  AwakerTalent_55367_TalentDesc_1 = {
    Text = "·卡茜亚唤醒体自身、命轮、密契每提供 1 点界域精通属性，「魔术嘉年华」就使卡茜亚所有基础伤害提高 0.2%。"
  },
  AwakerTalent_55367_TalentName_1 = {
    Text = "魔术大师"
  },
  AwakerTalent_55507_TalentDesc_1 = {
    Text = "·汀克特唤醒体自身、命轮、密契每提供 1% 黑印掉落属性，就使「星彩极光」额外获得 0.15% 临时暴击率。"
  },
  AwakerTalent_55507_TalentName_1 = {
    Text = "行星旅者"
  },
  AwakerTalent_55837_TalentDesc_1 = {
    Text = "·奥尔拉的「基础打击」与「基础防御」也视为一种诗篇。诗篇跃迁时会切换到不同的情绪，情绪能直接影响此诗篇的效果。处于不同的情绪会带来不同的队伍持续效果。\n·奥尔拉每有 1% 死亡抵抗，就使该效果加成提高初始值的 0.1%。"
  },
  AwakerTalent_55837_TalentName_1 = {
    Text = "落笔生情"
  },
  AwakerTalent_56174_TalentDesc_1 = {
    Text = "·法洛思每拥有 1% 伤害强效属性，「遗失的久远之城」造成的护盾就提高 0.4%。"
  },
  AwakerTalent_56174_TalentName_1 = {
    Text = "归乡执迷"
  },
  AwakerTalent_56175_TalentDesc_1 = {
    Text = "·凯刻斯每拥有 1% 黑印掉落属性，「基础打击」就享受 1% 反击加成。"
  },
  AwakerTalent_56175_TalentName_1 = {
    Text = "叛逆尖刺"
  },
  AwakerTalent_56223_TalentDesc_1 = {
    Text = "·希莱斯特打出指令卡后激发 1 条触腕攻击敌人，希莱斯特自身、命轮、密契每有 1 点界域精通就使本次激发造成 0.5% 触腕伤害。"
  },
  AwakerTalent_56223_TalentName_1 = {
    Text = "远航号角"
  },
  AwakerTalent_57336_TalentDesc_1 = {
    Text = "·萨尔瓦多每拥有 1% 黑印掉落属性，就使猩红熔炉上限提高 0.15% 最大生命。"
  },
  AwakerTalent_57336_TalentName_1 = {
    Text = "伊始之处"
  },
  AwakerTalent_57408_TalentDesc_1 = {
    Text = "·阿格里帕自身、装备的命轮与密契每提供 1% 黑印掉落属性，就使「苍白的庇佑」的基础护盾提高 0.5%，基础中毒提高 1%。"
  },
  AwakerTalent_57408_TalentName_1 = {Text = "契印"},
  AwakerTalent_57419_TalentDesc_1 = {
    Text = "·菲茵特每拥有 1% 死亡抵抗属性，就使「星之摇篮」和「无边星彩」获得的反击提高 0.2%，「星之摇篮」的死亡抵抗上限 +2% 。"
  },
  AwakerTalent_57419_TalentName_1 = {
    Text = "次生襁褓"
  },
  AwakerTalent_57567_TalentDesc_1 = {
    Text = "·希洛每拥有 1% 伤害强效属性，「绝境求生」就使本回合内希洛造成的伤害提高 0.3%。"
  },
  AwakerTalent_57567_TalentName_1 = {
    Text = "痛苦刻痕"
  },
  AwakerTalent_58448_TalentDesc_1 = {
    Text = "·莱克击杀敌人时获得 5 黑印，莱克每有 1% 黑印掉落就使获得量提高 1%，每场探索最多生效 5 次。\n·通过战斗获取 50/125/250 黑印后，造物上限+1，战斗结束时选择一个<C05_zaowu:「混沌的遗赠」>加入造物列表。"
  },
  AwakerTalent_58448_TalentName_1 = {
    Text = "赢家通吃"
  },
  AwakerTalent_70306_TalentDesc_1 = {
    Text = "·在首领战中，回合开始时及「熔毁·朵尔」释放狂气爆发后，获得 1 层「终末」。「终末」至多拥有 10 层，达到 10 层时将 1 张「虚无终结」置入手中。"
  },
  AwakerTalent_70306_TalentName_1 = {
    Text = "湮灭之路"
  },
  AwakerTalent_74099_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每条触腕攻击时都会使临时触腕伤害提高图鲁攻击力的 [Arg3]％，每回合至多生效 [Arg4] 次。\n·当队伍中存在其它 1/2/3 名「利莫里亚」唤醒体时，所有敌人受到的触腕伤害提高 10％/25％/50％。"
  },
  AwakerTalent_74099_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每条触腕攻击时都会使临时触腕伤害提高图鲁攻击力的 [Arg3]％，每回合至多生效 [Arg4] 次。\n·当队伍中存在其它 1/2/3 名「利莫里亚」唤醒体时，所有敌人受到的触腕伤害提高 10％/25％/50％。"
  },
  AwakerTalent_74099_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每条触腕攻击时都会使临时触腕伤害提高图鲁攻击力的 [Arg3]％，每回合至多生效 [Arg4] 次。\n·当队伍中存在其它 1/2/3 名「利莫里亚」唤醒体时，所有敌人受到的触腕伤害提高 10％/25％/50％。"
  },
  AwakerTalent_74099_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每条触腕攻击时都会使临时触腕伤害提高图鲁攻击力的 [Arg3]％，每回合至多生效 [Arg4] 次。\n·当队伍中存在其它 1/2/3 名「利莫里亚」唤醒体时，所有敌人受到的触腕伤害提高 10％/25％/50％。"
  },
  AwakerTalent_74099_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每条触腕攻击时都会使临时触腕伤害提高图鲁攻击力的 [Arg3]％，每回合至多生效 [Arg4] 次。\n·当队伍中存在其它 1/2/3 名「利莫里亚」唤醒体时，所有敌人受到的触腕伤害提高 10％/25％/50％。"
  },
  AwakerTalent_74099_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每条触腕攻击时都会使临时触腕伤害提高图鲁攻击力的 [Arg3]％，每回合至多生效 [Arg4] 次。\n·当队伍中存在其它 1/2/3 名「利莫里亚」唤醒体时，所有敌人受到的触腕伤害提高 10％/25％/50％。"
  },
  AwakerTalent_74099_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每条触腕攻击时都会使临时触腕伤害提高图鲁攻击力的 [Arg3]％，每回合至多生效 [Arg4] 次。\n·当队伍中存在其它 1/2/3 名「利莫里亚」唤醒体时，所有敌人受到的触腕伤害提高 10％/25％/50％。"
  },
  AwakerTalent_74099_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每条触腕攻击时都会使临时触腕伤害提高图鲁攻击力的 [Arg3]％，每回合至多生效 [Arg4] 次。\n·当队伍中存在其它 1/2/3 名「利莫里亚」唤醒体时，所有敌人受到的触腕伤害提高 10％/25％/50％。"
  },
  AwakerTalent_74099_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每条触腕攻击时都会使临时触腕伤害提高图鲁攻击力的 [Arg3]％，每回合至多生效 [Arg4] 次。\n·当队伍中存在其它 1/2/3 名「利莫里亚」唤醒体时，所有敌人受到的触腕伤害提高 10％/25％/50％。"
  },
  AwakerTalent_74099_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每条触腕攻击时都会使临时触腕伤害提高图鲁攻击力的 [Arg3]％，每回合至多生效 [Arg4] 次。\n·当队伍中存在其它 1/2/3 名「利莫里亚」唤醒体时，所有敌人受到的触腕伤害提高 10％/25％/50％。"
  },
  AwakerTalent_74099_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74099_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74099_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74099_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74099_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74099_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74099_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74099_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74099_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74099_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74100_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「菲茵特」力量降低效果提高 [Arg4] %。打出「菲茵特」的指令卡后，临时偷取「人型」敌人 [Arg3]％ 菲茵特攻击力的力量，每回合最多生效 3 次。"
  },
  AwakerTalent_74100_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「菲茵特」力量降低效果提高 [Arg4] %。打出「菲茵特」的指令卡后，临时偷取「人型」敌人 [Arg3]％ 菲茵特攻击力的力量，每回合最多生效 3 次。"
  },
  AwakerTalent_74100_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「菲茵特」力量降低效果提高 [Arg4] %。打出「菲茵特」的指令卡后，临时偷取「人型」敌人 [Arg3]％ 菲茵特攻击力的力量，每回合最多生效 3 次。"
  },
  AwakerTalent_74100_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「菲茵特」力量降低效果提高 [Arg4] %。打出「菲茵特」的指令卡后，临时偷取「人型」敌人 [Arg3]％ 菲茵特攻击力的力量，每回合最多生效 3 次。"
  },
  AwakerTalent_74100_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「菲茵特」力量降低效果提高 [Arg4] %。打出「菲茵特」的指令卡后，临时偷取「人型」敌人 [Arg3]％ 菲茵特攻击力的力量，每回合最多生效 3 次。"
  },
  AwakerTalent_74100_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「菲茵特」力量降低效果提高 [Arg4] %。打出「菲茵特」的指令卡后，临时偷取「人型」敌人 [Arg3]％ 菲茵特攻击力的力量，每回合最多生效 3 次。"
  },
  AwakerTalent_74100_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「菲茵特」力量降低效果提高 [Arg4] %。打出「菲茵特」的指令卡后，临时偷取「人型」敌人 [Arg3]％ 菲茵特攻击力的力量，每回合最多生效 3 次。"
  },
  AwakerTalent_74100_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「菲茵特」力量降低效果提高 [Arg4] %。打出「菲茵特」的指令卡后，临时偷取「人型」敌人 [Arg3]％ 菲茵特攻击力的力量，每回合最多生效 3 次。"
  },
  AwakerTalent_74100_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「菲茵特」力量降低效果提高 [Arg4] %。打出「菲茵特」的指令卡后，临时偷取「人型」敌人 [Arg3]％ 菲茵特攻击力的力量，每回合最多生效 3 次。"
  },
  AwakerTalent_74100_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「菲茵特」力量降低效果提高 [Arg4] %。打出「菲茵特」的指令卡后，临时偷取「人型」敌人 [Arg3]％ 菲茵特攻击力的力量，每回合最多生效 3 次。"
  },
  AwakerTalent_74100_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74100_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74100_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74100_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74100_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74100_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74100_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74100_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74100_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74100_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74101_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莱克自身获得的黑印提高 [Arg4]％，暴击率提高 [Arg3]％。若通过战斗至少获取了 400 黑印，战斗开始时将 1 个「混沌的遗赠」升级。"
  },
  AwakerTalent_74101_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莱克自身获得的黑印提高 [Arg4]％，暴击率提高 [Arg3]％。若通过战斗至少获取了 400 黑印，战斗开始时将 1 个「混沌的遗赠」升级。"
  },
  AwakerTalent_74101_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莱克自身获得的黑印提高 [Arg4]％，暴击率提高 [Arg3]％。若通过战斗至少获取了 400 黑印，战斗开始时将 1 个「混沌的遗赠」升级。"
  },
  AwakerTalent_74101_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莱克自身获得的黑印提高 [Arg4]％，暴击率提高 [Arg3]％。若通过战斗至少获取了 400 黑印，战斗开始时将 1 个「混沌的遗赠」升级。"
  },
  AwakerTalent_74101_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莱克自身获得的黑印提高 [Arg4]％，暴击率提高 [Arg3]％。若通过战斗至少获取了 400 黑印，战斗开始时将 1 个「混沌的遗赠」升级。"
  },
  AwakerTalent_74101_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莱克自身获得的黑印提高 [Arg4]％，暴击率提高 [Arg3]％。若通过战斗至少获取了 400 黑印，战斗开始时将 1 个「混沌的遗赠」升级。"
  },
  AwakerTalent_74101_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莱克自身获得的黑印提高 [Arg4]％，暴击率提高 [Arg3]％。若通过战斗至少获取了 400 黑印，战斗开始时将 1 个「混沌的遗赠」升级。"
  },
  AwakerTalent_74101_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莱克自身获得的黑印提高 [Arg4]％，暴击率提高 [Arg3]％。若通过战斗至少获取了 400 黑印，战斗开始时将 1 个「混沌的遗赠」升级。"
  },
  AwakerTalent_74101_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莱克自身获得的黑印提高 [Arg4]％，暴击率提高 [Arg3]％。若通过战斗至少获取了 400 黑印，战斗开始时将 1 个「混沌的遗赠」升级。"
  },
  AwakerTalent_74101_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莱克自身获得的黑印提高 [Arg4]％，暴击率提高 [Arg3]％。若通过战斗至少获取了 400 黑印，战斗开始时将 1 个「混沌的遗赠」升级。"
  },
  AwakerTalent_74101_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74101_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74101_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74101_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74101_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74101_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74101_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74101_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74101_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74101_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74102_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「缚身锁链」造成的基础伤害提高 [Arg4]％，额外享受 [Arg3]％ 力量加成。"
  },
  AwakerTalent_74102_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「缚身锁链」造成的基础伤害提高 [Arg4]％，额外享受 [Arg3]％ 力量加成。"
  },
  AwakerTalent_74102_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「缚身锁链」造成的基础伤害提高 [Arg4]％，额外享受 [Arg3]％ 力量加成。"
  },
  AwakerTalent_74102_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「缚身锁链」造成的基础伤害提高 [Arg4]％，额外享受 [Arg3]％ 力量加成。"
  },
  AwakerTalent_74102_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「缚身锁链」造成的基础伤害提高 [Arg4]％，额外享受 [Arg3]％ 力量加成。"
  },
  AwakerTalent_74102_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「缚身锁链」造成的基础伤害提高 [Arg4]％，额外享受 [Arg3]％ 力量加成。"
  },
  AwakerTalent_74102_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「缚身锁链」造成的基础伤害提高 [Arg4]％，额外享受 [Arg3]％ 力量加成。"
  },
  AwakerTalent_74102_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「缚身锁链」造成的基础伤害提高 [Arg4]％，额外享受 [Arg3]％ 力量加成。"
  },
  AwakerTalent_74102_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「缚身锁链」造成的基础伤害提高 [Arg4]％，额外享受 [Arg3]％ 力量加成。"
  },
  AwakerTalent_74102_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「缚身锁链」造成的基础伤害提高 [Arg4]％，额外享受 [Arg3]％ 力量加成。"
  },
  AwakerTalent_74102_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74102_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74102_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74102_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74102_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74102_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74102_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74102_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74102_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74102_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74103_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出首张「苍白回旋」胚胎融合+ [Arg3]，触发吞噬后使手牌中的 1 张「苍白回旋」算力消耗降低 1。"
  },
  AwakerTalent_74103_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出首张「苍白回旋」胚胎融合+ [Arg3]，触发吞噬后使手牌中的 1 张「苍白回旋」算力消耗降低 1。"
  },
  AwakerTalent_74103_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出首张「苍白回旋」胚胎融合+ [Arg3]，触发吞噬后使手牌中的 1 张「苍白回旋」算力消耗降低 1。"
  },
  AwakerTalent_74103_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出首张「苍白回旋」胚胎融合+ [Arg3]，触发吞噬后使手牌中的 1 张「苍白回旋」算力消耗降低 1。"
  },
  AwakerTalent_74103_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出首张「苍白回旋」胚胎融合+ [Arg3]，触发吞噬后使手牌中的 1 张「苍白回旋」算力消耗降低 1。"
  },
  AwakerTalent_74103_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出首张「苍白回旋」胚胎融合+ [Arg3]，触发吞噬后使手牌中的 1 张「苍白回旋」算力消耗降低 1。"
  },
  AwakerTalent_74103_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出首张「苍白回旋」胚胎融合+ [Arg3]，触发吞噬后使手牌中的 1 张「苍白回旋」算力消耗降低 1。"
  },
  AwakerTalent_74103_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出首张「苍白回旋」胚胎融合+ [Arg3]，触发吞噬后使手牌中的 1 张「苍白回旋」算力消耗降低 1。"
  },
  AwakerTalent_74103_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出首张「苍白回旋」胚胎融合+ [Arg3]，触发吞噬后使手牌中的 1 张「苍白回旋」算力消耗降低 1。"
  },
  AwakerTalent_74103_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出首张「苍白回旋」胚胎融合+ [Arg3]，触发吞噬后使手牌中的 1 张「苍白回旋」算力消耗降低 1。"
  },
  AwakerTalent_74103_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74103_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74103_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74103_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74103_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74103_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74103_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74103_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74103_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74103_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74104_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，获得艾瑞卡攻击力 [Arg3]％ 的力量和艾瑞卡防御力 [Arg4]％ 的戒备。"
  },
  AwakerTalent_74104_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，获得艾瑞卡攻击力 [Arg3]％ 的力量和艾瑞卡防御力 [Arg4]％ 的戒备。"
  },
  AwakerTalent_74104_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，获得艾瑞卡攻击力 [Arg3]％ 的力量和艾瑞卡防御力 [Arg4]％ 的戒备。"
  },
  AwakerTalent_74104_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，获得艾瑞卡攻击力 [Arg3]％ 的力量和艾瑞卡防御力 [Arg4]％ 的戒备。"
  },
  AwakerTalent_74104_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，获得艾瑞卡攻击力 [Arg3]％ 的力量和艾瑞卡防御力 [Arg4]％ 的戒备。"
  },
  AwakerTalent_74104_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，获得艾瑞卡攻击力 [Arg3]％ 的力量和艾瑞卡防御力 [Arg4]％ 的戒备。"
  },
  AwakerTalent_74104_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，获得艾瑞卡攻击力 [Arg3]％ 的力量和艾瑞卡防御力 [Arg4]％ 的戒备。"
  },
  AwakerTalent_74104_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，获得艾瑞卡攻击力 [Arg3]％ 的力量和艾瑞卡防御力 [Arg4]％ 的戒备。"
  },
  AwakerTalent_74104_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，获得艾瑞卡攻击力 [Arg3]％ 的力量和艾瑞卡防御力 [Arg4]％ 的戒备。"
  },
  AwakerTalent_74104_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，获得艾瑞卡攻击力 [Arg3]％ 的力量和艾瑞卡防御力 [Arg4]％ 的戒备。"
  },
  AwakerTalent_74104_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74104_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74104_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74104_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74104_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74104_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74104_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74104_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74104_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74104_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74105_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「喧嚣海洋」每消耗 1 张「腺体分裂」，奥瑞塔本场战斗后续造成的伤害提高  [Arg3]％ 攻击力。首领战中若「喧嚣海洋」至少消耗了 20 张「腺体分裂」，「腺体分裂」打出和被消耗时造成的伤害次数 +1。每回合打出的前 [Arg4] 张「腺体分裂」不会添加「算力调和」。"
  },
  AwakerTalent_74105_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「喧嚣海洋」每消耗 1 张「腺体分裂」，奥瑞塔本场战斗后续造成的伤害提高  [Arg3]％ 攻击力。首领战中若「喧嚣海洋」至少消耗了 20 张「腺体分裂」，「腺体分裂」打出和被消耗时造成的伤害次数 +1。每回合打出的前 [Arg4] 张「腺体分裂」不会添加「算力调和」。"
  },
  AwakerTalent_74105_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「喧嚣海洋」每消耗 1 张「腺体分裂」，奥瑞塔本场战斗后续造成的伤害提高  [Arg3]％ 攻击力。首领战中若「喧嚣海洋」至少消耗了 20 张「腺体分裂」，「腺体分裂」打出和被消耗时造成的伤害次数 +1。每回合打出的前 [Arg4] 张「腺体分裂」不会添加「算力调和」。"
  },
  AwakerTalent_74105_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「喧嚣海洋」每消耗 1 张「腺体分裂」，奥瑞塔本场战斗后续造成的伤害提高  [Arg3]％ 攻击力。首领战中若「喧嚣海洋」至少消耗了 20 张「腺体分裂」，「腺体分裂」打出和被消耗时造成的伤害次数 +1。每回合打出的前 [Arg4] 张「腺体分裂」不会添加「算力调和」。"
  },
  AwakerTalent_74105_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「喧嚣海洋」每消耗 1 张「腺体分裂」，奥瑞塔本场战斗后续造成的伤害提高  [Arg3]％ 攻击力。首领战中若「喧嚣海洋」至少消耗了 20 张「腺体分裂」，「腺体分裂」打出和被消耗时造成的伤害次数 +1。每回合打出的前 [Arg4] 张「腺体分裂」不会添加「算力调和」。"
  },
  AwakerTalent_74105_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「喧嚣海洋」每消耗 1 张「腺体分裂」，奥瑞塔本场战斗后续造成的伤害提高  [Arg3]％ 攻击力。首领战中若「喧嚣海洋」至少消耗了 20 张「腺体分裂」，「腺体分裂」打出和被消耗时造成的伤害次数 +1。每回合打出的前 [Arg4] 张「腺体分裂」不会添加「算力调和」。"
  },
  AwakerTalent_74105_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「喧嚣海洋」每消耗 1 张「腺体分裂」，奥瑞塔本场战斗后续造成的伤害提高  [Arg3]％ 攻击力。首领战中若「喧嚣海洋」至少消耗了 20 张「腺体分裂」，「腺体分裂」打出和被消耗时造成的伤害次数 +1。每回合打出的前 [Arg4] 张「腺体分裂」不会添加「算力调和」。"
  },
  AwakerTalent_74105_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「喧嚣海洋」每消耗 1 张「腺体分裂」，奥瑞塔本场战斗后续造成的伤害提高  [Arg3]％ 攻击力。首领战中若「喧嚣海洋」至少消耗了 20 张「腺体分裂」，「腺体分裂」打出和被消耗时造成的伤害次数 +1。每回合打出的前 [Arg4] 张「腺体分裂」不会添加「算力调和」。"
  },
  AwakerTalent_74105_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「喧嚣海洋」每消耗 1 张「腺体分裂」，奥瑞塔本场战斗后续造成的伤害提高  [Arg3]％ 攻击力。首领战中若「喧嚣海洋」至少消耗了 20 张「腺体分裂」，「腺体分裂」打出和被消耗时造成的伤害次数 +1。每回合打出的前 [Arg4] 张「腺体分裂」不会添加「算力调和」。"
  },
  AwakerTalent_74105_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「喧嚣海洋」每消耗 1 张「腺体分裂」，奥瑞塔本场战斗后续造成的伤害提高  [Arg3]％ 攻击力。首领战中若「喧嚣海洋」至少消耗了 20 张「腺体分裂」，「腺体分裂」打出和被消耗时造成的伤害次数 +1。每回合打出的前 [Arg4] 张「腺体分裂」不会添加「算力调和」。"
  },
  AwakerTalent_74105_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74105_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74105_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74105_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74105_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74105_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74105_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74105_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74105_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74105_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74106_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体造成的触腕伤害提高 [Arg3]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体造成的触腕伤害额外提高 6%/15%/30%。"
  },
  AwakerTalent_74106_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体造成的触腕伤害提高 [Arg3]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体造成的触腕伤害额外提高 6%/15%/30%。"
  },
  AwakerTalent_74106_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体造成的触腕伤害提高 [Arg3]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体造成的触腕伤害额外提高 6%/15%/30%。"
  },
  AwakerTalent_74106_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体造成的触腕伤害提高 [Arg3]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体造成的触腕伤害额外提高 6%/15%/30%。"
  },
  AwakerTalent_74106_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体造成的触腕伤害提高 [Arg3]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体造成的触腕伤害额外提高 6%/15%/30%。"
  },
  AwakerTalent_74106_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体造成的触腕伤害提高 [Arg3]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体造成的触腕伤害额外提高 6%/15%/30%。"
  },
  AwakerTalent_74106_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体造成的触腕伤害提高 [Arg3]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体造成的触腕伤害额外提高 6%/15%/30%。"
  },
  AwakerTalent_74106_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体造成的触腕伤害提高 [Arg3]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体造成的触腕伤害额外提高 6%/15%/30%。"
  },
  AwakerTalent_74106_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体造成的触腕伤害提高 [Arg3]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体造成的触腕伤害额外提高 6%/15%/30%。"
  },
  AwakerTalent_74106_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体造成的触腕伤害提高 [Arg3]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体造成的触腕伤害额外提高 6%/15%/30%。"
  },
  AwakerTalent_74106_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74106_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74106_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74106_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74106_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74106_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74106_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74106_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74106_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74106_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74107_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·宁菲亚的触发中毒效果提高 [Arg3]%，所有唤醒体造成的中毒提高 10%。"
  },
  AwakerTalent_74107_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·宁菲亚的触发中毒效果提高 [Arg3]%，所有唤醒体造成的中毒提高 10%。"
  },
  AwakerTalent_74107_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·宁菲亚的触发中毒效果提高 [Arg3]%，所有唤醒体造成的中毒提高 10%。"
  },
  AwakerTalent_74107_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·宁菲亚的触发中毒效果提高 [Arg3]%，所有唤醒体造成的中毒提高 10%。"
  },
  AwakerTalent_74107_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·宁菲亚的触发中毒效果提高 [Arg3]%，所有唤醒体造成的中毒提高 10%。"
  },
  AwakerTalent_74107_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·宁菲亚的触发中毒效果提高 [Arg3]%，所有唤醒体造成的中毒提高 10%。"
  },
  AwakerTalent_74107_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·宁菲亚的触发中毒效果提高 [Arg3]%，所有唤醒体造成的中毒提高 10%。"
  },
  AwakerTalent_74107_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·宁菲亚的触发中毒效果提高 [Arg3]%，所有唤醒体造成的中毒提高 10%。"
  },
  AwakerTalent_74107_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·宁菲亚的触发中毒效果提高 [Arg3]%，所有唤醒体造成的中毒提高 10%。"
  },
  AwakerTalent_74107_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·宁菲亚的触发中毒效果提高 [Arg3]%，所有唤醒体造成的中毒提高 10%。"
  },
  AwakerTalent_74107_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74107_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74107_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74107_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74107_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74107_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74107_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74107_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74107_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74107_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74108_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·奥吉尔造成的护盾提高 [Arg3]％，造成的力量提高 [Arg4]％。每次释放狂气爆发后本场战斗中奥吉尔造成的护盾额外提高防御力的 1％。"
  },
  AwakerTalent_74108_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·奥吉尔造成的护盾提高 [Arg3]％，造成的力量提高 [Arg4]％。每次释放狂气爆发后本场战斗中奥吉尔造成的护盾额外提高防御力的 1％。"
  },
  AwakerTalent_74108_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·奥吉尔造成的护盾提高 [Arg3]％，造成的力量提高 [Arg4]％。每次释放狂气爆发后本场战斗中奥吉尔造成的护盾额外提高防御力的 1％。"
  },
  AwakerTalent_74108_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·奥吉尔造成的护盾提高 [Arg3]％，造成的力量提高 [Arg4]％。每次释放狂气爆发后本场战斗中奥吉尔造成的护盾额外提高防御力的 1％。"
  },
  AwakerTalent_74108_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·奥吉尔造成的护盾提高 [Arg3]％，造成的力量提高 [Arg4]％。每次释放狂气爆发后本场战斗中奥吉尔造成的护盾额外提高防御力的 1％。"
  },
  AwakerTalent_74108_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·奥吉尔造成的护盾提高 [Arg3]％，造成的力量提高 [Arg4]％。每次释放狂气爆发后本场战斗中奥吉尔造成的护盾额外提高防御力的 1％。"
  },
  AwakerTalent_74108_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·奥吉尔造成的护盾提高 [Arg3]％，造成的力量提高 [Arg4]％。每次释放狂气爆发后本场战斗中奥吉尔造成的护盾额外提高防御力的 1％。"
  },
  AwakerTalent_74108_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·奥吉尔造成的护盾提高 [Arg3]％，造成的力量提高 [Arg4]％。每次释放狂气爆发后本场战斗中奥吉尔造成的护盾额外提高防御力的 1％。"
  },
  AwakerTalent_74108_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·奥吉尔造成的护盾提高 [Arg3]％，造成的力量提高 [Arg4]％。每次释放狂气爆发后本场战斗中奥吉尔造成的护盾额外提高防御力的 1％。"
  },
  AwakerTalent_74108_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·奥吉尔造成的护盾提高 [Arg3]％，造成的力量提高 [Arg4]％。每次释放狂气爆发后本场战斗中奥吉尔造成的护盾额外提高防御力的 1％。"
  },
  AwakerTalent_74108_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74108_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74108_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74108_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74108_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74108_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74108_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74108_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74108_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74108_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74109_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 10 张「布朗出动」不会添加「算力调和」。\n·詹金造成的伤害提高攻击力的 [Arg3]％。"
  },
  AwakerTalent_74109_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 10 张「布朗出动」不会添加「算力调和」。\n·詹金造成的伤害提高攻击力的 [Arg3]％。"
  },
  AwakerTalent_74109_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 10 张「布朗出动」不会添加「算力调和」。\n·詹金造成的伤害提高攻击力的 [Arg3]％。"
  },
  AwakerTalent_74109_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 10 张「布朗出动」不会添加「算力调和」。\n·詹金造成的伤害提高攻击力的 [Arg3]％。"
  },
  AwakerTalent_74109_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 10 张「布朗出动」不会添加「算力调和」。\n·詹金造成的伤害提高攻击力的 [Arg3]％。"
  },
  AwakerTalent_74109_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 10 张「布朗出动」不会添加「算力调和」。\n·詹金造成的伤害提高攻击力的 [Arg3]％。"
  },
  AwakerTalent_74109_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 10 张「布朗出动」不会添加「算力调和」。\n·詹金造成的伤害提高攻击力的 [Arg3]％。"
  },
  AwakerTalent_74109_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 10 张「布朗出动」不会添加「算力调和」。\n·詹金造成的伤害提高攻击力的 [Arg3]％。"
  },
  AwakerTalent_74109_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 10 张「布朗出动」不会添加「算力调和」。\n·詹金造成的伤害提高攻击力的 [Arg3]％。"
  },
  AwakerTalent_74109_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 10 张「布朗出动」不会添加「算力调和」。\n·詹金造成的伤害提高攻击力的 [Arg3]％。"
  },
  AwakerTalent_74109_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74109_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74109_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74109_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74109_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74109_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74109_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74109_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74109_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74109_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74110_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「灵感」后获得攻击力[Arg3]% 的临时力量，并触发 1 次「蓄势乐音」，每回合最多生效 5 次。"
  },
  AwakerTalent_74110_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「灵感」后获得攻击力[Arg3]% 的临时力量，并触发 1 次「蓄势乐音」，每回合最多生效 5 次。"
  },
  AwakerTalent_74110_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「灵感」后获得攻击力[Arg3]% 的临时力量，并触发 1 次「蓄势乐音」，每回合最多生效 5 次。"
  },
  AwakerTalent_74110_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「灵感」后获得攻击力[Arg3]% 的临时力量，并触发 1 次「蓄势乐音」，每回合最多生效 5 次。"
  },
  AwakerTalent_74110_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「灵感」后获得攻击力[Arg3]% 的临时力量，并触发 1 次「蓄势乐音」，每回合最多生效 5 次。"
  },
  AwakerTalent_74110_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「灵感」后获得攻击力[Arg3]% 的临时力量，并触发 1 次「蓄势乐音」，每回合最多生效 5 次。"
  },
  AwakerTalent_74110_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「灵感」后获得攻击力[Arg3]% 的临时力量，并触发 1 次「蓄势乐音」，每回合最多生效 5 次。"
  },
  AwakerTalent_74110_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「灵感」后获得攻击力[Arg3]% 的临时力量，并触发 1 次「蓄势乐音」，每回合最多生效 5 次。"
  },
  AwakerTalent_74110_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「灵感」后获得攻击力[Arg3]% 的临时力量，并触发 1 次「蓄势乐音」，每回合最多生效 5 次。"
  },
  AwakerTalent_74110_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「灵感」后获得攻击力[Arg3]% 的临时力量，并触发 1 次「蓄势乐音」，每回合最多生效 5 次。"
  },
  AwakerTalent_74110_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74110_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74110_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74110_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74110_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74110_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74110_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74110_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74110_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74110_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74111_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，若存在「野兽」敌人，卡茜亚本场战斗造成的力量提高 [Arg3]％。「统统消失」每回合首次释放后，触发洗入抽牌堆卡牌的余波效果。"
  },
  AwakerTalent_74111_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，若存在「野兽」敌人，卡茜亚本场战斗造成的力量提高 [Arg3]％。「统统消失」每回合首次释放后，触发洗入抽牌堆卡牌的余波效果。"
  },
  AwakerTalent_74111_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，若存在「野兽」敌人，卡茜亚本场战斗造成的力量提高 [Arg3]％。「统统消失」每回合首次释放后，触发洗入抽牌堆卡牌的余波效果。"
  },
  AwakerTalent_74111_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，若存在「野兽」敌人，卡茜亚本场战斗造成的力量提高 [Arg3]％。「统统消失」每回合首次释放后，触发洗入抽牌堆卡牌的余波效果。"
  },
  AwakerTalent_74111_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，若存在「野兽」敌人，卡茜亚本场战斗造成的力量提高 [Arg3]％。「统统消失」每回合首次释放后，触发洗入抽牌堆卡牌的余波效果。"
  },
  AwakerTalent_74111_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，若存在「野兽」敌人，卡茜亚本场战斗造成的力量提高 [Arg3]％。「统统消失」每回合首次释放后，触发洗入抽牌堆卡牌的余波效果。"
  },
  AwakerTalent_74111_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，若存在「野兽」敌人，卡茜亚本场战斗造成的力量提高 [Arg3]％。「统统消失」每回合首次释放后，触发洗入抽牌堆卡牌的余波效果。"
  },
  AwakerTalent_74111_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，若存在「野兽」敌人，卡茜亚本场战斗造成的力量提高 [Arg3]％。「统统消失」每回合首次释放后，触发洗入抽牌堆卡牌的余波效果。"
  },
  AwakerTalent_74111_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，若存在「野兽」敌人，卡茜亚本场战斗造成的力量提高 [Arg3]％。「统统消失」每回合首次释放后，触发洗入抽牌堆卡牌的余波效果。"
  },
  AwakerTalent_74111_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，若存在「野兽」敌人，卡茜亚本场战斗造成的力量提高 [Arg3]％。「统统消失」每回合首次释放后，触发洗入抽牌堆卡牌的余波效果。"
  },
  AwakerTalent_74111_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74111_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74111_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74111_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74111_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74111_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74111_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74111_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74111_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74111_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74112_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·珊造成护盾时，获得等同于护盾值 [Arg3]％ 的触腕伤害。珊释放狂气爆发时，额外享受 [Arg4]％ 触腕伤害加成。"
  },
  AwakerTalent_74112_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·珊造成护盾时，获得等同于护盾值 [Arg3]％ 的触腕伤害。珊释放狂气爆发时，额外享受 [Arg4]％ 触腕伤害加成。"
  },
  AwakerTalent_74112_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·珊造成护盾时，获得等同于护盾值 [Arg3]％ 的触腕伤害。珊释放狂气爆发时，额外享受 [Arg4]％ 触腕伤害加成。"
  },
  AwakerTalent_74112_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·珊造成护盾时，获得等同于护盾值 [Arg3]％ 的触腕伤害。珊释放狂气爆发时，额外享受 [Arg4]％ 触腕伤害加成。"
  },
  AwakerTalent_74112_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·珊造成护盾时，获得等同于护盾值 [Arg3]％ 的触腕伤害。珊释放狂气爆发时，额外享受 [Arg4]％ 触腕伤害加成。"
  },
  AwakerTalent_74112_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·珊造成护盾时，获得等同于护盾值 [Arg3]％ 的触腕伤害。珊释放狂气爆发时，额外享受 [Arg4]％ 触腕伤害加成。"
  },
  AwakerTalent_74112_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·珊造成护盾时，获得等同于护盾值 [Arg3]％ 的触腕伤害。珊释放狂气爆发时，额外享受 [Arg4]％ 触腕伤害加成。"
  },
  AwakerTalent_74112_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·珊造成护盾时，获得等同于护盾值 [Arg3]％ 的触腕伤害。珊释放狂气爆发时，额外享受 [Arg4]％ 触腕伤害加成。"
  },
  AwakerTalent_74112_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·珊造成护盾时，获得等同于护盾值 [Arg3]％ 的触腕伤害。珊释放狂气爆发时，额外享受 [Arg4]％ 触腕伤害加成。"
  },
  AwakerTalent_74112_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·珊造成护盾时，获得等同于护盾值 [Arg3]％ 的触腕伤害。珊释放狂气爆发时，额外享受 [Arg4]％ 触腕伤害加成。"
  },
  AwakerTalent_74112_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74112_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74112_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74112_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74112_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74112_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74112_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74112_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74112_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74112_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74113_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「狂气使役之鞭」获得保留和预备。意图造成伤害的敌人承受潘狄娅的主动伤害提高 [Arg3]%，目标每额外攻击 1 次提高 5%，至多额外提高 20％。"
  },
  AwakerTalent_74113_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「狂气使役之鞭」获得保留和预备。意图造成伤害的敌人承受潘狄娅的主动伤害提高 [Arg3]%，目标每额外攻击 1 次提高 5%，至多额外提高 20％。"
  },
  AwakerTalent_74113_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「狂气使役之鞭」获得保留和预备。意图造成伤害的敌人承受潘狄娅的主动伤害提高 [Arg3]%，目标每额外攻击 1 次提高 5%，至多额外提高 20％。"
  },
  AwakerTalent_74113_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「狂气使役之鞭」获得保留和预备。意图造成伤害的敌人承受潘狄娅的主动伤害提高 [Arg3]%，目标每额外攻击 1 次提高 5%，至多额外提高 20％。"
  },
  AwakerTalent_74113_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「狂气使役之鞭」获得保留和预备。意图造成伤害的敌人承受潘狄娅的主动伤害提高 [Arg3]%，目标每额外攻击 1 次提高 5%，至多额外提高 20％。"
  },
  AwakerTalent_74113_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「狂气使役之鞭」获得保留和预备。意图造成伤害的敌人承受潘狄娅的主动伤害提高 [Arg3]%，目标每额外攻击 1 次提高 5%，至多额外提高 20％。"
  },
  AwakerTalent_74113_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「狂气使役之鞭」获得保留和预备。意图造成伤害的敌人承受潘狄娅的主动伤害提高 [Arg3]%，目标每额外攻击 1 次提高 5%，至多额外提高 20％。"
  },
  AwakerTalent_74113_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「狂气使役之鞭」获得保留和预备。意图造成伤害的敌人承受潘狄娅的主动伤害提高 [Arg3]%，目标每额外攻击 1 次提高 5%，至多额外提高 20％。"
  },
  AwakerTalent_74113_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「狂气使役之鞭」获得保留和预备。意图造成伤害的敌人承受潘狄娅的主动伤害提高 [Arg3]%，目标每额外攻击 1 次提高 5%，至多额外提高 20％。"
  },
  AwakerTalent_74113_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「狂气使役之鞭」获得保留和预备。意图造成伤害的敌人承受潘狄娅的主动伤害提高 [Arg3]%，目标每额外攻击 1 次提高 5%，至多额外提高 20％。"
  },
  AwakerTalent_74113_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74113_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74113_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74113_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74113_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74113_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74113_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74113_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74113_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74113_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74114_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·艾继丝每回合打出首张指令卡后，获得 [Arg3]％ 艾继丝银钥充能的银钥能量。"
  },
  AwakerTalent_74114_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·艾继丝每回合打出首张指令卡后，获得 [Arg3]％ 艾继丝银钥充能的银钥能量。"
  },
  AwakerTalent_74114_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·艾继丝每回合打出首张指令卡后，获得 [Arg3]％ 艾继丝银钥充能的银钥能量。"
  },
  AwakerTalent_74114_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·艾继丝每回合打出首张指令卡后，获得 [Arg3]％ 艾继丝银钥充能的银钥能量。"
  },
  AwakerTalent_74114_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·艾继丝每回合打出首张指令卡后，获得 [Arg3]％ 艾继丝银钥充能的银钥能量。"
  },
  AwakerTalent_74114_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·艾继丝每回合打出首张指令卡后，获得 [Arg3]％ 艾继丝银钥充能的银钥能量。"
  },
  AwakerTalent_74114_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·艾继丝每回合打出首张指令卡后，获得 [Arg3]％ 艾继丝银钥充能的银钥能量。"
  },
  AwakerTalent_74114_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·艾继丝每回合打出首张指令卡后，获得 [Arg3]％ 艾继丝银钥充能的银钥能量。"
  },
  AwakerTalent_74114_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·艾继丝每回合打出首张指令卡后，获得 [Arg3]％ 艾继丝银钥充能的银钥能量。"
  },
  AwakerTalent_74114_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·艾继丝每回合打出首张指令卡后，获得 [Arg3]％ 艾继丝银钥充能的银钥能量。"
  },
  AwakerTalent_74114_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74114_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74114_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74114_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74114_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74114_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74114_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74114_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74114_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74114_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74115_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 [Arg3] 张「尖啸吧，血」不会添加「算力调和」。尤乌哈希造成的基础伤害提高 [Arg4]％，生命低于 25％ 时效果翻倍。"
  },
  AwakerTalent_74115_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 [Arg3] 张「尖啸吧，血」不会添加「算力调和」。尤乌哈希造成的基础伤害提高 [Arg4]％，生命低于 25％ 时效果翻倍。"
  },
  AwakerTalent_74115_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 [Arg3] 张「尖啸吧，血」不会添加「算力调和」。尤乌哈希造成的基础伤害提高 [Arg4]％，生命低于 25％ 时效果翻倍。"
  },
  AwakerTalent_74115_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 [Arg3] 张「尖啸吧，血」不会添加「算力调和」。尤乌哈希造成的基础伤害提高 [Arg4]％，生命低于 25％ 时效果翻倍。"
  },
  AwakerTalent_74115_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 [Arg3] 张「尖啸吧，血」不会添加「算力调和」。尤乌哈希造成的基础伤害提高 [Arg4]％，生命低于 25％ 时效果翻倍。"
  },
  AwakerTalent_74115_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 [Arg3] 张「尖啸吧，血」不会添加「算力调和」。尤乌哈希造成的基础伤害提高 [Arg4]％，生命低于 25％ 时效果翻倍。"
  },
  AwakerTalent_74115_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 [Arg3] 张「尖啸吧，血」不会添加「算力调和」。尤乌哈希造成的基础伤害提高 [Arg4]％，生命低于 25％ 时效果翻倍。"
  },
  AwakerTalent_74115_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 [Arg3] 张「尖啸吧，血」不会添加「算力调和」。尤乌哈希造成的基础伤害提高 [Arg4]％，生命低于 25％ 时效果翻倍。"
  },
  AwakerTalent_74115_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 [Arg3] 张「尖啸吧，血」不会添加「算力调和」。尤乌哈希造成的基础伤害提高 [Arg4]％，生命低于 25％ 时效果翻倍。"
  },
  AwakerTalent_74115_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每回合打出的前 [Arg3] 张「尖啸吧，血」不会添加「算力调和」。尤乌哈希造成的基础伤害提高 [Arg4]％，生命低于 25％ 时效果翻倍。"
  },
  AwakerTalent_74115_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74115_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74115_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74115_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74115_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74115_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74115_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74115_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74115_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74115_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74116_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·泰旖丝「吞噬」胚胎时，获得 [Arg3]％ 银钥充能的银钥能量，吞噬「圣洁之子」效果翻倍。"
  },
  AwakerTalent_74116_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·泰旖丝「吞噬」胚胎时，获得 [Arg3]％ 银钥充能的银钥能量，吞噬「圣洁之子」效果翻倍。"
  },
  AwakerTalent_74116_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·泰旖丝「吞噬」胚胎时，获得 [Arg3]％ 银钥充能的银钥能量，吞噬「圣洁之子」效果翻倍。"
  },
  AwakerTalent_74116_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·泰旖丝「吞噬」胚胎时，获得 [Arg3]％ 银钥充能的银钥能量，吞噬「圣洁之子」效果翻倍。"
  },
  AwakerTalent_74116_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·泰旖丝「吞噬」胚胎时，获得 [Arg3]％ 银钥充能的银钥能量，吞噬「圣洁之子」效果翻倍。"
  },
  AwakerTalent_74116_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·泰旖丝「吞噬」胚胎时，获得 [Arg3]％ 银钥充能的银钥能量，吞噬「圣洁之子」效果翻倍。"
  },
  AwakerTalent_74116_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·泰旖丝「吞噬」胚胎时，获得 [Arg3]％ 银钥充能的银钥能量，吞噬「圣洁之子」效果翻倍。"
  },
  AwakerTalent_74116_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·泰旖丝「吞噬」胚胎时，获得 [Arg3]％ 银钥充能的银钥能量，吞噬「圣洁之子」效果翻倍。"
  },
  AwakerTalent_74116_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·泰旖丝「吞噬」胚胎时，获得 [Arg3]％ 银钥充能的银钥能量，吞噬「圣洁之子」效果翻倍。"
  },
  AwakerTalent_74116_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·泰旖丝「吞噬」胚胎时，获得 [Arg3]％ 银钥充能的银钥能量，吞噬「圣洁之子」效果翻倍。"
  },
  AwakerTalent_74116_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74116_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74116_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74116_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74116_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74116_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74116_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74116_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74116_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74116_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74117_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·释放「湮灭」后温柯尔获得 [Arg3] 点狂气，3 回合冷却。"
  },
  AwakerTalent_74117_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·释放「湮灭」后温柯尔获得 [Arg3] 点狂气，3 回合冷却。"
  },
  AwakerTalent_74117_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·释放「湮灭」后温柯尔获得 [Arg3] 点狂气，3 回合冷却。"
  },
  AwakerTalent_74117_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·释放「湮灭」后温柯尔获得 [Arg3] 点狂气，3 回合冷却。"
  },
  AwakerTalent_74117_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·释放「湮灭」后温柯尔获得 [Arg3] 点狂气，3 回合冷却。"
  },
  AwakerTalent_74117_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·释放「湮灭」后温柯尔获得 [Arg3] 点狂气，3 回合冷却。"
  },
  AwakerTalent_74117_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·释放「湮灭」后温柯尔获得 [Arg3] 点狂气，3 回合冷却。"
  },
  AwakerTalent_74117_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·释放「湮灭」后温柯尔获得 [Arg3] 点狂气，3 回合冷却。"
  },
  AwakerTalent_74117_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·释放「湮灭」后温柯尔获得 [Arg3] 点狂气，3 回合冷却。"
  },
  AwakerTalent_74117_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·释放「湮灭」后温柯尔获得 [Arg3] 点狂气，3 回合冷却。"
  },
  AwakerTalent_74117_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74117_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74117_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74117_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74117_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74117_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74117_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74117_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74117_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74117_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74118_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·戈利亚造成的基础伤害提高 [Arg3]％，「巨刃之威」使戈利亚造成的最终伤害临时提高 [Arg4]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体力量获取效果额外提高 6%/15%/30%。"
  },
  AwakerTalent_74118_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·戈利亚造成的基础伤害提高 [Arg3]％，「巨刃之威」使戈利亚造成的最终伤害临时提高 [Arg4]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体力量获取效果额外提高 6%/15%/30%。"
  },
  AwakerTalent_74118_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·戈利亚造成的基础伤害提高 [Arg3]％，「巨刃之威」使戈利亚造成的最终伤害临时提高 [Arg4]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体力量获取效果额外提高 6%/15%/30%。"
  },
  AwakerTalent_74118_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·戈利亚造成的基础伤害提高 [Arg3]％，「巨刃之威」使戈利亚造成的最终伤害临时提高 [Arg4]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体力量获取效果额外提高 6%/15%/30%。"
  },
  AwakerTalent_74118_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·戈利亚造成的基础伤害提高 [Arg3]％，「巨刃之威」使戈利亚造成的最终伤害临时提高 [Arg4]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体力量获取效果额外提高 6%/15%/30%。"
  },
  AwakerTalent_74118_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·戈利亚造成的基础伤害提高 [Arg3]％，「巨刃之威」使戈利亚造成的最终伤害临时提高 [Arg4]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体力量获取效果额外提高 6%/15%/30%。"
  },
  AwakerTalent_74118_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·戈利亚造成的基础伤害提高 [Arg3]％，「巨刃之威」使戈利亚造成的最终伤害临时提高 [Arg4]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体力量获取效果额外提高 6%/15%/30%。"
  },
  AwakerTalent_74118_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·戈利亚造成的基础伤害提高 [Arg3]％，「巨刃之威」使戈利亚造成的最终伤害临时提高 [Arg4]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体力量获取效果额外提高 6%/15%/30%。"
  },
  AwakerTalent_74118_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·戈利亚造成的基础伤害提高 [Arg3]％，「巨刃之威」使戈利亚造成的最终伤害临时提高 [Arg4]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体力量获取效果额外提高 6%/15%/30%。"
  },
  AwakerTalent_74118_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·戈利亚造成的基础伤害提高 [Arg3]％，「巨刃之威」使戈利亚造成的最终伤害临时提高 [Arg4]％。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，所有唤醒体力量获取效果额外提高 6%/15%/30%。"
  },
  AwakerTalent_74118_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74118_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74118_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74118_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74118_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74118_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74118_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74118_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74118_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74118_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74119_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·塔薇打出原本所属为队伍其他唤醒体的卡牌时，对应唤醒体本回合造成的最终伤害、护盾、生命回复提高 [Arg3]％，无法叠加。"
  },
  AwakerTalent_74119_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·塔薇打出原本所属为队伍其他唤醒体的卡牌时，对应唤醒体本回合造成的最终伤害、护盾、生命回复提高 [Arg3]％，无法叠加。"
  },
  AwakerTalent_74119_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·塔薇打出原本所属为队伍其他唤醒体的卡牌时，对应唤醒体本回合造成的最终伤害、护盾、生命回复提高 [Arg3]％，无法叠加。"
  },
  AwakerTalent_74119_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·塔薇打出原本所属为队伍其他唤醒体的卡牌时，对应唤醒体本回合造成的最终伤害、护盾、生命回复提高 [Arg3]％，无法叠加。"
  },
  AwakerTalent_74119_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·塔薇打出原本所属为队伍其他唤醒体的卡牌时，对应唤醒体本回合造成的最终伤害、护盾、生命回复提高 [Arg3]％，无法叠加。"
  },
  AwakerTalent_74119_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·塔薇打出原本所属为队伍其他唤醒体的卡牌时，对应唤醒体本回合造成的最终伤害、护盾、生命回复提高 [Arg3]％，无法叠加。"
  },
  AwakerTalent_74119_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·塔薇打出原本所属为队伍其他唤醒体的卡牌时，对应唤醒体本回合造成的最终伤害、护盾、生命回复提高 [Arg3]％，无法叠加。"
  },
  AwakerTalent_74119_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·塔薇打出原本所属为队伍其他唤醒体的卡牌时，对应唤醒体本回合造成的最终伤害、护盾、生命回复提高 [Arg3]％，无法叠加。"
  },
  AwakerTalent_74119_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·塔薇打出原本所属为队伍其他唤醒体的卡牌时，对应唤醒体本回合造成的最终伤害、护盾、生命回复提高 [Arg3]％，无法叠加。"
  },
  AwakerTalent_74119_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·塔薇打出原本所属为队伍其他唤醒体的卡牌时，对应唤醒体本回合造成的最终伤害、护盾、生命回复提高 [Arg3]％，无法叠加。"
  },
  AwakerTalent_74119_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74119_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74119_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74119_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74119_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74119_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74119_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74119_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74119_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74119_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74120_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·萝坦的指令卡造成的基础伤害提高 [Arg3]%。萝坦每造成 1 次伤害，本回合萝坦造成的最终伤害提高 5%，至多提高 [Arg4]％。"
  },
  AwakerTalent_74120_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·萝坦的指令卡造成的基础伤害提高 [Arg3]%。萝坦每造成 1 次伤害，本回合萝坦造成的最终伤害提高 5%，至多提高 [Arg4]％。"
  },
  AwakerTalent_74120_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·萝坦的指令卡造成的基础伤害提高 [Arg3]%。萝坦每造成 1 次伤害，本回合萝坦造成的最终伤害提高 5%，至多提高 [Arg4]％。"
  },
  AwakerTalent_74120_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·萝坦的指令卡造成的基础伤害提高 [Arg3]%。萝坦每造成 1 次伤害，本回合萝坦造成的最终伤害提高 5%，至多提高 [Arg4]％。"
  },
  AwakerTalent_74120_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·萝坦的指令卡造成的基础伤害提高 [Arg3]%。萝坦每造成 1 次伤害，本回合萝坦造成的最终伤害提高 5%，至多提高 [Arg4]％。"
  },
  AwakerTalent_74120_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·萝坦的指令卡造成的基础伤害提高 [Arg3]%。萝坦每造成 1 次伤害，本回合萝坦造成的最终伤害提高 5%，至多提高 [Arg4]％。"
  },
  AwakerTalent_74120_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·萝坦的指令卡造成的基础伤害提高 [Arg3]%。萝坦每造成 1 次伤害，本回合萝坦造成的最终伤害提高 5%，至多提高 [Arg4]％。"
  },
  AwakerTalent_74120_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·萝坦的指令卡造成的基础伤害提高 [Arg3]%。萝坦每造成 1 次伤害，本回合萝坦造成的最终伤害提高 5%，至多提高 [Arg4]％。"
  },
  AwakerTalent_74120_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·萝坦的指令卡造成的基础伤害提高 [Arg3]%。萝坦每造成 1 次伤害，本回合萝坦造成的最终伤害提高 5%，至多提高 [Arg4]％。"
  },
  AwakerTalent_74120_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·萝坦的指令卡造成的基础伤害提高 [Arg3]%。萝坦每造成 1 次伤害，本回合萝坦造成的最终伤害提高 5%，至多提高 [Arg4]％。"
  },
  AwakerTalent_74120_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74120_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74120_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74120_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74120_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74120_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74120_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74120_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74120_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74120_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74121_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量降低效果提高 [Arg3]％。"
  },
  AwakerTalent_74121_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量降低效果提高 [Arg3]％。"
  },
  AwakerTalent_74121_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量降低效果提高 [Arg3]％。"
  },
  AwakerTalent_74121_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量降低效果提高 [Arg3]％。"
  },
  AwakerTalent_74121_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量降低效果提高 [Arg3]％。"
  },
  AwakerTalent_74121_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量降低效果提高 [Arg3]％。"
  },
  AwakerTalent_74121_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量降低效果提高 [Arg3]％。"
  },
  AwakerTalent_74121_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量降低效果提高 [Arg3]％。"
  },
  AwakerTalent_74121_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量降低效果提高 [Arg3]％。"
  },
  AwakerTalent_74121_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量降低效果提高 [Arg3]％。"
  },
  AwakerTalent_74121_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74121_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74121_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74121_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74121_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74121_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74121_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74121_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74121_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74121_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74122_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「绵音渐响」后使所有「人型」敌人造成的伤害临时降低 [Arg4]％，无法叠加。「安魂曲」获得 [Arg3] 点狂气，每驱散 1 个负面状态额外获得 1 次。"
  },
  AwakerTalent_74122_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「绵音渐响」后使所有「人型」敌人造成的伤害临时降低 [Arg4]％，无法叠加。「安魂曲」获得 [Arg3] 点狂气，每驱散 1 个负面状态额外获得 1 次。"
  },
  AwakerTalent_74122_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「绵音渐响」后使所有「人型」敌人造成的伤害临时降低 [Arg4]％，无法叠加。「安魂曲」获得 [Arg3] 点狂气，每驱散 1 个负面状态额外获得 1 次。"
  },
  AwakerTalent_74122_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「绵音渐响」后使所有「人型」敌人造成的伤害临时降低 [Arg4]％，无法叠加。「安魂曲」获得 [Arg3] 点狂气，每驱散 1 个负面状态额外获得 1 次。"
  },
  AwakerTalent_74122_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「绵音渐响」后使所有「人型」敌人造成的伤害临时降低 [Arg4]％，无法叠加。「安魂曲」获得 [Arg3] 点狂气，每驱散 1 个负面状态额外获得 1 次。"
  },
  AwakerTalent_74122_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「绵音渐响」后使所有「人型」敌人造成的伤害临时降低 [Arg4]％，无法叠加。「安魂曲」获得 [Arg3] 点狂气，每驱散 1 个负面状态额外获得 1 次。"
  },
  AwakerTalent_74122_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「绵音渐响」后使所有「人型」敌人造成的伤害临时降低 [Arg4]％，无法叠加。「安魂曲」获得 [Arg3] 点狂气，每驱散 1 个负面状态额外获得 1 次。"
  },
  AwakerTalent_74122_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「绵音渐响」后使所有「人型」敌人造成的伤害临时降低 [Arg4]％，无法叠加。「安魂曲」获得 [Arg3] 点狂气，每驱散 1 个负面状态额外获得 1 次。"
  },
  AwakerTalent_74122_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「绵音渐响」后使所有「人型」敌人造成的伤害临时降低 [Arg4]％，无法叠加。「安魂曲」获得 [Arg3] 点狂气，每驱散 1 个负面状态额外获得 1 次。"
  },
  AwakerTalent_74122_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「绵音渐响」后使所有「人型」敌人造成的伤害临时降低 [Arg4]％，无法叠加。「安魂曲」获得 [Arg3] 点狂气，每驱散 1 个负面状态额外获得 1 次。"
  },
  AwakerTalent_74122_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74122_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74122_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74122_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74122_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74122_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74122_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74122_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74122_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74122_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74123_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「打击」和「心眼利刃」造成的基础伤害提高本回合自身获得护盾量的 [Arg3]％。艾尔瓦对「血肉」界域敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74123_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「打击」和「心眼利刃」造成的基础伤害提高本回合自身获得护盾量的 [Arg3]％。艾尔瓦对「血肉」界域敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74123_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「打击」和「心眼利刃」造成的基础伤害提高本回合自身获得护盾量的 [Arg3]％。艾尔瓦对「血肉」界域敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74123_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「打击」和「心眼利刃」造成的基础伤害提高本回合自身获得护盾量的 [Arg3]％。艾尔瓦对「血肉」界域敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74123_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「打击」和「心眼利刃」造成的基础伤害提高本回合自身获得护盾量的 [Arg3]％。艾尔瓦对「血肉」界域敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74123_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「打击」和「心眼利刃」造成的基础伤害提高本回合自身获得护盾量的 [Arg3]％。艾尔瓦对「血肉」界域敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74123_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「打击」和「心眼利刃」造成的基础伤害提高本回合自身获得护盾量的 [Arg3]％。艾尔瓦对「血肉」界域敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74123_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「打击」和「心眼利刃」造成的基础伤害提高本回合自身获得护盾量的 [Arg3]％。艾尔瓦对「血肉」界域敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74123_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「打击」和「心眼利刃」造成的基础伤害提高本回合自身获得护盾量的 [Arg3]％。艾尔瓦对「血肉」界域敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74123_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「打击」和「心眼利刃」造成的基础伤害提高本回合自身获得护盾量的 [Arg3]％。艾尔瓦对「血肉」界域敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74123_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74123_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74123_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74123_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74123_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74123_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74123_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74123_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74123_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74123_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74124_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·朵尔造成的狂气、狂气爆发造成的治疗效果提高 [Arg3]％，队伍中每有 1 名其它「混沌」界域唤醒体该效果额外提高 [Arg4]％。"
  },
  AwakerTalent_74124_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·朵尔造成的狂气、狂气爆发造成的治疗效果提高 [Arg3]％，队伍中每有 1 名其它「混沌」界域唤醒体该效果额外提高 [Arg4]％。"
  },
  AwakerTalent_74124_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·朵尔造成的狂气、狂气爆发造成的治疗效果提高 [Arg3]％，队伍中每有 1 名其它「混沌」界域唤醒体该效果额外提高 [Arg4]％。"
  },
  AwakerTalent_74124_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·朵尔造成的狂气、狂气爆发造成的治疗效果提高 [Arg3]％，队伍中每有 1 名其它「混沌」界域唤醒体该效果额外提高 [Arg4]％。"
  },
  AwakerTalent_74124_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·朵尔造成的狂气、狂气爆发造成的治疗效果提高 [Arg3]％，队伍中每有 1 名其它「混沌」界域唤醒体该效果额外提高 [Arg4]％。"
  },
  AwakerTalent_74124_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·朵尔造成的狂气、狂气爆发造成的治疗效果提高 [Arg3]％，队伍中每有 1 名其它「混沌」界域唤醒体该效果额外提高 [Arg4]％。"
  },
  AwakerTalent_74124_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·朵尔造成的狂气、狂气爆发造成的治疗效果提高 [Arg3]％，队伍中每有 1 名其它「混沌」界域唤醒体该效果额外提高 [Arg4]％。"
  },
  AwakerTalent_74124_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·朵尔造成的狂气、狂气爆发造成的治疗效果提高 [Arg3]％，队伍中每有 1 名其它「混沌」界域唤醒体该效果额外提高 [Arg4]％。"
  },
  AwakerTalent_74124_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·朵尔造成的狂气、狂气爆发造成的治疗效果提高 [Arg3]％，队伍中每有 1 名其它「混沌」界域唤醒体该效果额外提高 [Arg4]％。"
  },
  AwakerTalent_74124_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·朵尔造成的狂气、狂气爆发造成的治疗效果提高 [Arg3]％，队伍中每有 1 名其它「混沌」界域唤醒体该效果额外提高 [Arg4]％。"
  },
  AwakerTalent_74124_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74124_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74124_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74124_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74124_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74124_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74124_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74124_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74124_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74124_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74125_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希莱斯特造成的触腕伤害提高 [Arg3]％，每回合打出首张指令卡后额外触发 4 次天赋「远航号角」。"
  },
  AwakerTalent_74125_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希莱斯特造成的触腕伤害提高 [Arg3]％，每回合打出首张指令卡后额外触发 4 次天赋「远航号角」。"
  },
  AwakerTalent_74125_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希莱斯特造成的触腕伤害提高 [Arg3]％，每回合打出首张指令卡后额外触发 4 次天赋「远航号角」。"
  },
  AwakerTalent_74125_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希莱斯特造成的触腕伤害提高 [Arg3]％，每回合打出首张指令卡后额外触发 4 次天赋「远航号角」。"
  },
  AwakerTalent_74125_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希莱斯特造成的触腕伤害提高 [Arg3]％，每回合打出首张指令卡后额外触发 4 次天赋「远航号角」。"
  },
  AwakerTalent_74125_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希莱斯特造成的触腕伤害提高 [Arg3]％，每回合打出首张指令卡后额外触发 4 次天赋「远航号角」。"
  },
  AwakerTalent_74125_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希莱斯特造成的触腕伤害提高 [Arg3]％，每回合打出首张指令卡后额外触发 4 次天赋「远航号角」。"
  },
  AwakerTalent_74125_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希莱斯特造成的触腕伤害提高 [Arg3]％，每回合打出首张指令卡后额外触发 4 次天赋「远航号角」。"
  },
  AwakerTalent_74125_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希莱斯特造成的触腕伤害提高 [Arg3]％，每回合打出首张指令卡后额外触发 4 次天赋「远航号角」。"
  },
  AwakerTalent_74125_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希莱斯特造成的触腕伤害提高 [Arg3]％，每回合打出首张指令卡后额外触发 4 次天赋「远航号角」。"
  },
  AwakerTalent_74125_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74125_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74125_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74125_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74125_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74125_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74125_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74125_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74125_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74125_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74126_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·雷娅的力量获取效果提高 [Arg4]％，打出雷娅的「指令卡」后，获得 [Arg3]％ 雷娅攻击力的力量，该效果随当前已损生命至多提高 200％，每回合最多生效 3 次。"
  },
  AwakerTalent_74126_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·雷娅的力量获取效果提高 [Arg4]％，打出雷娅的「指令卡」后，获得 [Arg3]％ 雷娅攻击力的力量，该效果随当前已损生命至多提高 200％，每回合最多生效 3 次。"
  },
  AwakerTalent_74126_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·雷娅的力量获取效果提高 [Arg4]％，打出雷娅的「指令卡」后，获得 [Arg3]％ 雷娅攻击力的力量，该效果随当前已损生命至多提高 200％，每回合最多生效 3 次。"
  },
  AwakerTalent_74126_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·雷娅的力量获取效果提高 [Arg4]％，打出雷娅的「指令卡」后，获得 [Arg3]％ 雷娅攻击力的力量，该效果随当前已损生命至多提高 200％，每回合最多生效 3 次。"
  },
  AwakerTalent_74126_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·雷娅的力量获取效果提高 [Arg4]％，打出雷娅的「指令卡」后，获得 [Arg3]％ 雷娅攻击力的力量，该效果随当前已损生命至多提高 200％，每回合最多生效 3 次。"
  },
  AwakerTalent_74126_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·雷娅的力量获取效果提高 [Arg4]％，打出雷娅的「指令卡」后，获得 [Arg3]％ 雷娅攻击力的力量，该效果随当前已损生命至多提高 200％，每回合最多生效 3 次。"
  },
  AwakerTalent_74126_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·雷娅的力量获取效果提高 [Arg4]％，打出雷娅的「指令卡」后，获得 [Arg3]％ 雷娅攻击力的力量，该效果随当前已损生命至多提高 200％，每回合最多生效 3 次。"
  },
  AwakerTalent_74126_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·雷娅的力量获取效果提高 [Arg4]％，打出雷娅的「指令卡」后，获得 [Arg3]％ 雷娅攻击力的力量，该效果随当前已损生命至多提高 200％，每回合最多生效 3 次。"
  },
  AwakerTalent_74126_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·雷娅的力量获取效果提高 [Arg4]％，打出雷娅的「指令卡」后，获得 [Arg3]％ 雷娅攻击力的力量，该效果随当前已损生命至多提高 200％，每回合最多生效 3 次。"
  },
  AwakerTalent_74126_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·雷娅的力量获取效果提高 [Arg4]％，打出雷娅的「指令卡」后，获得 [Arg3]％ 雷娅攻击力的力量，该效果随当前已损生命至多提高 200％，每回合最多生效 3 次。"
  },
  AwakerTalent_74126_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74126_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74126_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74126_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74126_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74126_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74126_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74126_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74126_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74126_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74127_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·手中每有 1 张「奇妙料理」，造成的生命回复和护盾效果提高 [Arg4]％，最多叠加 3 层。每打出 1 次「奇妙料理」，珈伦本场战斗造成的中毒提高 [Arg3]％，最大叠加 20 层。"
  },
  AwakerTalent_74127_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·手中每有 1 张「奇妙料理」，造成的生命回复和护盾效果提高 [Arg4]％，最多叠加 3 层。每打出 1 次「奇妙料理」，珈伦本场战斗造成的中毒提高 [Arg3]％，最大叠加 20 层。"
  },
  AwakerTalent_74127_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·手中每有 1 张「奇妙料理」，造成的生命回复和护盾效果提高 [Arg4]％，最多叠加 3 层。每打出 1 次「奇妙料理」，珈伦本场战斗造成的中毒提高 [Arg3]％，最大叠加 20 层。"
  },
  AwakerTalent_74127_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·手中每有 1 张「奇妙料理」，造成的生命回复和护盾效果提高 [Arg4]％，最多叠加 3 层。每打出 1 次「奇妙料理」，珈伦本场战斗造成的中毒提高 [Arg3]％，最大叠加 20 层。"
  },
  AwakerTalent_74127_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·手中每有 1 张「奇妙料理」，造成的生命回复和护盾效果提高 [Arg4]％，最多叠加 3 层。每打出 1 次「奇妙料理」，珈伦本场战斗造成的中毒提高 [Arg3]％，最大叠加 20 层。"
  },
  AwakerTalent_74127_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·手中每有 1 张「奇妙料理」，造成的生命回复和护盾效果提高 [Arg4]％，最多叠加 3 层。每打出 1 次「奇妙料理」，珈伦本场战斗造成的中毒提高 [Arg3]％，最大叠加 20 层。"
  },
  AwakerTalent_74127_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·手中每有 1 张「奇妙料理」，造成的生命回复和护盾效果提高 [Arg4]％，最多叠加 3 层。每打出 1 次「奇妙料理」，珈伦本场战斗造成的中毒提高 [Arg3]％，最大叠加 20 层。"
  },
  AwakerTalent_74127_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·手中每有 1 张「奇妙料理」，造成的生命回复和护盾效果提高 [Arg4]％，最多叠加 3 层。每打出 1 次「奇妙料理」，珈伦本场战斗造成的中毒提高 [Arg3]％，最大叠加 20 层。"
  },
  AwakerTalent_74127_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·手中每有 1 张「奇妙料理」，造成的生命回复和护盾效果提高 [Arg4]％，最多叠加 3 层。每打出 1 次「奇妙料理」，珈伦本场战斗造成的中毒提高 [Arg3]％，最大叠加 20 层。"
  },
  AwakerTalent_74127_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·手中每有 1 张「奇妙料理」，造成的生命回复和护盾效果提高 [Arg4]％，最多叠加 3 层。每打出 1 次「奇妙料理」，珈伦本场战斗造成的中毒提高 [Arg3]％，最大叠加 20 层。"
  },
  AwakerTalent_74127_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74127_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74127_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74127_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74127_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74127_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74127_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74127_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74127_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74127_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74128_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「24」造成的基础伤害提高 [Arg3]％，对「雕塑家协会」敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74128_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「24」造成的基础伤害提高 [Arg3]％，对「雕塑家协会」敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74128_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「24」造成的基础伤害提高 [Arg3]％，对「雕塑家协会」敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74128_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「24」造成的基础伤害提高 [Arg3]％，对「雕塑家协会」敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74128_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「24」造成的基础伤害提高 [Arg3]％，对「雕塑家协会」敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74128_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「24」造成的基础伤害提高 [Arg3]％，对「雕塑家协会」敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74128_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「24」造成的基础伤害提高 [Arg3]％，对「雕塑家协会」敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74128_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「24」造成的基础伤害提高 [Arg3]％，对「雕塑家协会」敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74128_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「24」造成的基础伤害提高 [Arg3]％，对「雕塑家协会」敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74128_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「24」造成的基础伤害提高 [Arg3]％，对「雕塑家协会」敌人造成的最终伤害提高 [Arg4]％。"
  },
  AwakerTalent_74128_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74128_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74128_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74128_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74128_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74128_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74128_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74128_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74128_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74128_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74129_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莉莉的「打击」最终伤害提高 [Arg3]％，首领战提高量翻倍。受到「超维」敌人攻击后，获得 [Arg4]％ 本次攻击损失生命的延迟回复效果。「报偿打击」随「忍耐」的伤害提高效果享受 [Arg5]% 伤害强效加成。"
  },
  AwakerTalent_74129_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莉莉的「打击」最终伤害提高 [Arg3]％，首领战提高量翻倍。受到「超维」敌人攻击后，获得 [Arg4]％ 本次攻击损失生命的延迟回复效果。「报偿打击」随「忍耐」的伤害提高效果享受 [Arg5]% 伤害强效加成。"
  },
  AwakerTalent_74129_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莉莉的「打击」最终伤害提高 [Arg3]％，首领战提高量翻倍。受到「超维」敌人攻击后，获得 [Arg4]％ 本次攻击损失生命的延迟回复效果。「报偿打击」随「忍耐」的伤害提高效果享受 [Arg5]% 伤害强效加成。"
  },
  AwakerTalent_74129_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莉莉的「打击」最终伤害提高 [Arg3]％，首领战提高量翻倍。受到「超维」敌人攻击后，获得 [Arg4]％ 本次攻击损失生命的延迟回复效果。「报偿打击」随「忍耐」的伤害提高效果享受 [Arg5]% 伤害强效加成。"
  },
  AwakerTalent_74129_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莉莉的「打击」最终伤害提高 [Arg3]％，首领战提高量翻倍。受到「超维」敌人攻击后，获得 [Arg4]％ 本次攻击损失生命的延迟回复效果。「报偿打击」随「忍耐」的伤害提高效果享受 [Arg5]% 伤害强效加成。"
  },
  AwakerTalent_74129_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莉莉的「打击」最终伤害提高 [Arg3]％，首领战提高量翻倍。受到「超维」敌人攻击后，获得 [Arg4]％ 本次攻击损失生命的延迟回复效果。「报偿打击」随「忍耐」的伤害提高效果享受 [Arg5]% 伤害强效加成。"
  },
  AwakerTalent_74129_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莉莉的「打击」最终伤害提高 [Arg3]％，首领战提高量翻倍。受到「超维」敌人攻击后，获得 [Arg4]％ 本次攻击损失生命的延迟回复效果。「报偿打击」随「忍耐」的伤害提高效果享受 [Arg5]% 伤害强效加成。"
  },
  AwakerTalent_74129_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莉莉的「打击」最终伤害提高 [Arg3]％，首领战提高量翻倍。受到「超维」敌人攻击后，获得 [Arg4]％ 本次攻击损失生命的延迟回复效果。「报偿打击」随「忍耐」的伤害提高效果享受 [Arg5]% 伤害强效加成。"
  },
  AwakerTalent_74129_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莉莉的「打击」最终伤害提高 [Arg3]％，首领战提高量翻倍。受到「超维」敌人攻击后，获得 [Arg4]％ 本次攻击损失生命的延迟回复效果。「报偿打击」随「忍耐」的伤害提高效果享受 [Arg5]% 伤害强效加成。"
  },
  AwakerTalent_74129_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·莉莉的「打击」最终伤害提高 [Arg3]％，首领战提高量翻倍。受到「超维」敌人攻击后，获得 [Arg4]％ 本次攻击损失生命的延迟回复效果。「报偿打击」随「忍耐」的伤害提高效果享受 [Arg5]% 伤害强效加成。"
  },
  AwakerTalent_74129_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74129_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74129_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74129_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74129_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74129_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74129_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74129_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74129_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74129_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74130_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·索蕾尔「吞噬」后获得攻击力 [Arg3]％ 的临时力量，每回合最多触发 5 次。"
  },
  AwakerTalent_74130_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·索蕾尔「吞噬」后获得攻击力 [Arg3]％ 的临时力量，每回合最多触发 5 次。"
  },
  AwakerTalent_74130_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·索蕾尔「吞噬」后获得攻击力 [Arg3]％ 的临时力量，每回合最多触发 5 次。"
  },
  AwakerTalent_74130_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·索蕾尔「吞噬」后获得攻击力 [Arg3]％ 的临时力量，每回合最多触发 5 次。"
  },
  AwakerTalent_74130_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·索蕾尔「吞噬」后获得攻击力 [Arg3]％ 的临时力量，每回合最多触发 5 次。"
  },
  AwakerTalent_74130_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·索蕾尔「吞噬」后获得攻击力 [Arg3]％ 的临时力量，每回合最多触发 5 次。"
  },
  AwakerTalent_74130_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·索蕾尔「吞噬」后获得攻击力 [Arg3]％ 的临时力量，每回合最多触发 5 次。"
  },
  AwakerTalent_74130_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·索蕾尔「吞噬」后获得攻击力 [Arg3]％ 的临时力量，每回合最多触发 5 次。"
  },
  AwakerTalent_74130_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·索蕾尔「吞噬」后获得攻击力 [Arg3]％ 的临时力量，每回合最多触发 5 次。"
  },
  AwakerTalent_74130_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·索蕾尔「吞噬」后获得攻击力 [Arg3]％ 的临时力量，每回合最多触发 5 次。"
  },
  AwakerTalent_74130_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74130_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74130_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74130_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74130_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74130_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74130_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74130_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74130_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74130_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74131_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·在「灰烬遗迹」选择「感应」后，使最大生命提高原始最大生命的 [Arg3]％。"
  },
  AwakerTalent_74131_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·在「灰烬遗迹」选择「感应」后，使最大生命提高原始最大生命的 [Arg3]％。"
  },
  AwakerTalent_74131_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·在「灰烬遗迹」选择「感应」后，使最大生命提高原始最大生命的 [Arg3]％。"
  },
  AwakerTalent_74131_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·在「灰烬遗迹」选择「感应」后，使最大生命提高原始最大生命的 [Arg3]％。"
  },
  AwakerTalent_74131_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·在「灰烬遗迹」选择「感应」后，使最大生命提高原始最大生命的 [Arg3]％。"
  },
  AwakerTalent_74131_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·在「灰烬遗迹」选择「感应」后，使最大生命提高原始最大生命的 [Arg3]％。"
  },
  AwakerTalent_74131_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·在「灰烬遗迹」选择「感应」后，使最大生命提高原始最大生命的 [Arg3]％。"
  },
  AwakerTalent_74131_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·在「灰烬遗迹」选择「感应」后，使最大生命提高原始最大生命的 [Arg3]％。"
  },
  AwakerTalent_74131_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·在「灰烬遗迹」选择「感应」后，使最大生命提高原始最大生命的 [Arg3]％。"
  },
  AwakerTalent_74131_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·在「灰烬遗迹」选择「感应」后，使最大生命提高原始最大生命的 [Arg3]％。"
  },
  AwakerTalent_74131_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74131_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74131_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74131_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74131_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74131_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74131_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74131_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74131_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74131_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74132_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·法洛思造成的中毒提高 [Arg3]％。「遗失的久远之城」回合结束时号令所有触腕攻击 1 次，但这些攻击只造成 [Arg4]% 的伤害。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，伤害强效 +20%/50%/100％。"
  },
  AwakerTalent_74132_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·法洛思造成的中毒提高 [Arg3]％。「遗失的久远之城」回合结束时号令所有触腕攻击 1 次，但这些攻击只造成 [Arg4]% 的伤害。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，伤害强效 +20%/50%/100％。"
  },
  AwakerTalent_74132_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·法洛思造成的中毒提高 [Arg3]％。「遗失的久远之城」回合结束时号令所有触腕攻击 1 次，但这些攻击只造成 [Arg4]% 的伤害。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，伤害强效 +20%/50%/100％。"
  },
  AwakerTalent_74132_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·法洛思造成的中毒提高 [Arg3]％。「遗失的久远之城」回合结束时号令所有触腕攻击 1 次，但这些攻击只造成 [Arg4]% 的伤害。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，伤害强效 +20%/50%/100％。"
  },
  AwakerTalent_74132_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·法洛思造成的中毒提高 [Arg3]％。「遗失的久远之城」回合结束时号令所有触腕攻击 1 次，但这些攻击只造成 [Arg4]% 的伤害。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，伤害强效 +20%/50%/100％。"
  },
  AwakerTalent_74132_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·法洛思造成的中毒提高 [Arg3]％。「遗失的久远之城」回合结束时号令所有触腕攻击 1 次，但这些攻击只造成 [Arg4]% 的伤害。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，伤害强效 +20%/50%/100％。"
  },
  AwakerTalent_74132_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·法洛思造成的中毒提高 [Arg3]％。「遗失的久远之城」回合结束时号令所有触腕攻击 1 次，但这些攻击只造成 [Arg4]% 的伤害。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，伤害强效 +20%/50%/100％。"
  },
  AwakerTalent_74132_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·法洛思造成的中毒提高 [Arg3]％。「遗失的久远之城」回合结束时号令所有触腕攻击 1 次，但这些攻击只造成 [Arg4]% 的伤害。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，伤害强效 +20%/50%/100％。"
  },
  AwakerTalent_74132_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·法洛思造成的中毒提高 [Arg3]％。「遗失的久远之城」回合结束时号令所有触腕攻击 1 次，但这些攻击只造成 [Arg4]% 的伤害。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，伤害强效 +20%/50%/100％。"
  },
  AwakerTalent_74132_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·法洛思造成的中毒提高 [Arg3]％。「遗失的久远之城」回合结束时号令所有触腕攻击 1 次，但这些攻击只造成 [Arg4]% 的伤害。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，伤害强效 +20%/50%/100％。"
  },
  AwakerTalent_74132_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74132_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74132_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74132_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74132_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74132_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74132_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74132_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74132_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74132_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74133_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74133_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74133_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74133_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74133_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74133_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74133_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74133_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74133_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74133_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74133_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74133_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74133_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74133_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74133_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74133_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74133_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74133_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74133_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74133_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74134_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希洛对「雪原」敌人造成的最终伤害提高 [Arg3]％。若本回合希洛消耗过「胚胎」，其本回合下次造成伤害时暴击伤害+ [Arg4]％。"
  },
  AwakerTalent_74134_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希洛对「雪原」敌人造成的最终伤害提高 [Arg3]％。若本回合希洛消耗过「胚胎」，其本回合下次造成伤害时暴击伤害+ [Arg4]％。"
  },
  AwakerTalent_74134_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希洛对「雪原」敌人造成的最终伤害提高 [Arg3]％。若本回合希洛消耗过「胚胎」，其本回合下次造成伤害时暴击伤害+ [Arg4]％。"
  },
  AwakerTalent_74134_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希洛对「雪原」敌人造成的最终伤害提高 [Arg3]％。若本回合希洛消耗过「胚胎」，其本回合下次造成伤害时暴击伤害+ [Arg4]％。"
  },
  AwakerTalent_74134_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希洛对「雪原」敌人造成的最终伤害提高 [Arg3]％。若本回合希洛消耗过「胚胎」，其本回合下次造成伤害时暴击伤害+ [Arg4]％。"
  },
  AwakerTalent_74134_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希洛对「雪原」敌人造成的最终伤害提高 [Arg3]％。若本回合希洛消耗过「胚胎」，其本回合下次造成伤害时暴击伤害+ [Arg4]％。"
  },
  AwakerTalent_74134_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希洛对「雪原」敌人造成的最终伤害提高 [Arg3]％。若本回合希洛消耗过「胚胎」，其本回合下次造成伤害时暴击伤害+ [Arg4]％。"
  },
  AwakerTalent_74134_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希洛对「雪原」敌人造成的最终伤害提高 [Arg3]％。若本回合希洛消耗过「胚胎」，其本回合下次造成伤害时暴击伤害+ [Arg4]％。"
  },
  AwakerTalent_74134_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希洛对「雪原」敌人造成的最终伤害提高 [Arg3]％。若本回合希洛消耗过「胚胎」，其本回合下次造成伤害时暴击伤害+ [Arg4]％。"
  },
  AwakerTalent_74134_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·希洛对「雪原」敌人造成的最终伤害提高 [Arg3]％。若本回合希洛消耗过「胚胎」，其本回合下次造成伤害时暴击伤害+ [Arg4]％。"
  },
  AwakerTalent_74134_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74134_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74134_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74134_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74134_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74134_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74134_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74134_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74134_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74134_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74135_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·首领战开始时，获得等同于奥尔拉死亡抵抗属性 [Arg3]% 的死亡抵抗。每次触发死亡抵抗后，直到回合结束时「纷华篇章」的对应效果提高 [Arg4]%。"
  },
  AwakerTalent_74135_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·首领战开始时，获得等同于奥尔拉死亡抵抗属性 [Arg3]% 的死亡抵抗。每次触发死亡抵抗后，直到回合结束时「纷华篇章」的对应效果提高 [Arg4]%。"
  },
  AwakerTalent_74135_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·首领战开始时，获得等同于奥尔拉死亡抵抗属性 [Arg3]% 的死亡抵抗。每次触发死亡抵抗后，直到回合结束时「纷华篇章」的对应效果提高 [Arg4]%。"
  },
  AwakerTalent_74135_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·首领战开始时，获得等同于奥尔拉死亡抵抗属性 [Arg3]% 的死亡抵抗。每次触发死亡抵抗后，直到回合结束时「纷华篇章」的对应效果提高 [Arg4]%。"
  },
  AwakerTalent_74135_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·首领战开始时，获得等同于奥尔拉死亡抵抗属性 [Arg3]% 的死亡抵抗。每次触发死亡抵抗后，直到回合结束时「纷华篇章」的对应效果提高 [Arg4]%。"
  },
  AwakerTalent_74135_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·首领战开始时，获得等同于奥尔拉死亡抵抗属性 [Arg3]% 的死亡抵抗。每次触发死亡抵抗后，直到回合结束时「纷华篇章」的对应效果提高 [Arg4]%。"
  },
  AwakerTalent_74135_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·首领战开始时，获得等同于奥尔拉死亡抵抗属性 [Arg3]% 的死亡抵抗。每次触发死亡抵抗后，直到回合结束时「纷华篇章」的对应效果提高 [Arg4]%。"
  },
  AwakerTalent_74135_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·首领战开始时，获得等同于奥尔拉死亡抵抗属性 [Arg3]% 的死亡抵抗。每次触发死亡抵抗后，直到回合结束时「纷华篇章」的对应效果提高 [Arg4]%。"
  },
  AwakerTalent_74135_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·首领战开始时，获得等同于奥尔拉死亡抵抗属性 [Arg3]% 的死亡抵抗。每次触发死亡抵抗后，直到回合结束时「纷华篇章」的对应效果提高 [Arg4]%。"
  },
  AwakerTalent_74135_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·首领战开始时，获得等同于奥尔拉死亡抵抗属性 [Arg3]% 的死亡抵抗。每次触发死亡抵抗后，直到回合结束时「纷华篇章」的对应效果提高 [Arg4]%。"
  },
  AwakerTalent_74135_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74135_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74135_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74135_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74135_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74135_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74135_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74135_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74135_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74135_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74136_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，将 1 张附加「消耗」的「腐化绿炎」置入手中，并使「绿炎」及其相关衍生卡的基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74136_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，将 1 张附加「消耗」的「腐化绿炎」置入手中，并使「绿炎」及其相关衍生卡的基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74136_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，将 1 张附加「消耗」的「腐化绿炎」置入手中，并使「绿炎」及其相关衍生卡的基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74136_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，将 1 张附加「消耗」的「腐化绿炎」置入手中，并使「绿炎」及其相关衍生卡的基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74136_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，将 1 张附加「消耗」的「腐化绿炎」置入手中，并使「绿炎」及其相关衍生卡的基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74136_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，将 1 张附加「消耗」的「腐化绿炎」置入手中，并使「绿炎」及其相关衍生卡的基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74136_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，将 1 张附加「消耗」的「腐化绿炎」置入手中，并使「绿炎」及其相关衍生卡的基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74136_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，将 1 张附加「消耗」的「腐化绿炎」置入手中，并使「绿炎」及其相关衍生卡的基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74136_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，将 1 张附加「消耗」的「腐化绿炎」置入手中，并使「绿炎」及其相关衍生卡的基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74136_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，将 1 张附加「消耗」的「腐化绿炎」置入手中，并使「绿炎」及其相关衍生卡的基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74136_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74136_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74136_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74136_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74136_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74136_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74136_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74136_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74136_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74136_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74137_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「灰烬遗迹」刷新时，出现折扣的概率提高 [Arg3]％，折扣比例提高 [Arg4]％。\n·「断颈一击」基础伤害提高 [Arg5] %，与击杀带来的基础伤害提高独立计算。"
  },
  AwakerTalent_74137_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「灰烬遗迹」刷新时，出现折扣的概率提高 [Arg3]％，折扣比例提高 [Arg4]％。\n·「断颈一击」基础伤害提高 [Arg5] %，与击杀带来的基础伤害提高独立计算。"
  },
  AwakerTalent_74137_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「灰烬遗迹」刷新时，出现折扣的概率提高 [Arg3]％，折扣比例提高 [Arg4]％。\n·「断颈一击」基础伤害提高 [Arg5] %，与击杀带来的基础伤害提高独立计算。"
  },
  AwakerTalent_74137_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「灰烬遗迹」刷新时，出现折扣的概率提高 [Arg3]％，折扣比例提高 [Arg4]％。\n·「断颈一击」基础伤害提高 [Arg5] %，与击杀带来的基础伤害提高独立计算。"
  },
  AwakerTalent_74137_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「灰烬遗迹」刷新时，出现折扣的概率提高 [Arg3]％，折扣比例提高 [Arg4]％。\n·「断颈一击」基础伤害提高 [Arg5] %，与击杀带来的基础伤害提高独立计算。"
  },
  AwakerTalent_74137_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「灰烬遗迹」刷新时，出现折扣的概率提高 [Arg3]％，折扣比例提高 [Arg4]％。\n·「断颈一击」基础伤害提高 [Arg5] %，与击杀带来的基础伤害提高独立计算。"
  },
  AwakerTalent_74137_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「灰烬遗迹」刷新时，出现折扣的概率提高 [Arg3]％，折扣比例提高 [Arg4]％。\n·「断颈一击」基础伤害提高 [Arg5] %，与击杀带来的基础伤害提高独立计算。"
  },
  AwakerTalent_74137_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「灰烬遗迹」刷新时，出现折扣的概率提高 [Arg3]％，折扣比例提高 [Arg4]％。\n·「断颈一击」基础伤害提高 [Arg5] %，与击杀带来的基础伤害提高独立计算。"
  },
  AwakerTalent_74137_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「灰烬遗迹」刷新时，出现折扣的概率提高 [Arg3]％，折扣比例提高 [Arg4]％。\n·「断颈一击」基础伤害提高 [Arg5] %，与击杀带来的基础伤害提高独立计算。"
  },
  AwakerTalent_74137_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「灰烬遗迹」刷新时，出现折扣的概率提高 [Arg3]％，折扣比例提高 [Arg4]％。\n·「断颈一击」基础伤害提高 [Arg5] %，与击杀带来的基础伤害提高独立计算。"
  },
  AwakerTalent_74137_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74137_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74137_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74137_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74137_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74137_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74137_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74137_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74137_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74137_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74138_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·凯刻斯每回合打出首张指令卡回复 [Arg3]% 自身体质的生命。「承自异端之血」的触腕攻击和反击效果额外造成 [Arg4]％ 伤害。"
  },
  AwakerTalent_74138_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·凯刻斯每回合打出首张指令卡回复 [Arg3]% 自身体质的生命。「承自异端之血」的触腕攻击和反击效果额外造成 [Arg4]％ 伤害。"
  },
  AwakerTalent_74138_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·凯刻斯每回合打出首张指令卡回复 [Arg3]% 自身体质的生命。「承自异端之血」的触腕攻击和反击效果额外造成 [Arg4]％ 伤害。"
  },
  AwakerTalent_74138_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·凯刻斯每回合打出首张指令卡回复 [Arg3]% 自身体质的生命。「承自异端之血」的触腕攻击和反击效果额外造成 [Arg4]％ 伤害。"
  },
  AwakerTalent_74138_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·凯刻斯每回合打出首张指令卡回复 [Arg3]% 自身体质的生命。「承自异端之血」的触腕攻击和反击效果额外造成 [Arg4]％ 伤害。"
  },
  AwakerTalent_74138_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·凯刻斯每回合打出首张指令卡回复 [Arg3]% 自身体质的生命。「承自异端之血」的触腕攻击和反击效果额外造成 [Arg4]％ 伤害。"
  },
  AwakerTalent_74138_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·凯刻斯每回合打出首张指令卡回复 [Arg3]% 自身体质的生命。「承自异端之血」的触腕攻击和反击效果额外造成 [Arg4]％ 伤害。"
  },
  AwakerTalent_74138_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·凯刻斯每回合打出首张指令卡回复 [Arg3]% 自身体质的生命。「承自异端之血」的触腕攻击和反击效果额外造成 [Arg4]％ 伤害。"
  },
  AwakerTalent_74138_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·凯刻斯每回合打出首张指令卡回复 [Arg3]% 自身体质的生命。「承自异端之血」的触腕攻击和反击效果额外造成 [Arg4]％ 伤害。"
  },
  AwakerTalent_74138_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·凯刻斯每回合打出首张指令卡回复 [Arg3]% 自身体质的生命。「承自异端之血」的触腕攻击和反击效果额外造成 [Arg4]％ 伤害。"
  },
  AwakerTalent_74138_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74138_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74138_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74138_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74138_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74138_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74138_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74138_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74138_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74138_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74139_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诺缔拉造成的反击提高 [Arg3]％，「整装待发」释放前获得等同于 [Arg4]％ 永久反击的临时反击。"
  },
  AwakerTalent_74139_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诺缔拉造成的反击提高 [Arg3]％，「整装待发」释放前获得等同于 [Arg4]％ 永久反击的临时反击。"
  },
  AwakerTalent_74139_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诺缔拉造成的反击提高 [Arg3]％，「整装待发」释放前获得等同于 [Arg4]％ 永久反击的临时反击。"
  },
  AwakerTalent_74139_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诺缔拉造成的反击提高 [Arg3]％，「整装待发」释放前获得等同于 [Arg4]％ 永久反击的临时反击。"
  },
  AwakerTalent_74139_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诺缔拉造成的反击提高 [Arg3]％，「整装待发」释放前获得等同于 [Arg4]％ 永久反击的临时反击。"
  },
  AwakerTalent_74139_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诺缔拉造成的反击提高 [Arg3]％，「整装待发」释放前获得等同于 [Arg4]％ 永久反击的临时反击。"
  },
  AwakerTalent_74139_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诺缔拉造成的反击提高 [Arg3]％，「整装待发」释放前获得等同于 [Arg4]％ 永久反击的临时反击。"
  },
  AwakerTalent_74139_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诺缔拉造成的反击提高 [Arg3]％，「整装待发」释放前获得等同于 [Arg4]％ 永久反击的临时反击。"
  },
  AwakerTalent_74139_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诺缔拉造成的反击提高 [Arg3]％，「整装待发」释放前获得等同于 [Arg4]％ 永久反击的临时反击。"
  },
  AwakerTalent_74139_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诺缔拉造成的反击提高 [Arg3]％，「整装待发」释放前获得等同于 [Arg4]％ 永久反击的临时反击。"
  },
  AwakerTalent_74139_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74139_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74139_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74139_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74139_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74139_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74139_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74139_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74139_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74139_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74140_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每当获得献祭时，还会获得等同于 [Arg3]％ 献祭量的触腕伤害。"
  },
  AwakerTalent_74140_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每当获得献祭时，还会获得等同于 [Arg3]％ 献祭量的触腕伤害。"
  },
  AwakerTalent_74140_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每当获得献祭时，还会获得等同于 [Arg3]％ 献祭量的触腕伤害。"
  },
  AwakerTalent_74140_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每当获得献祭时，还会获得等同于 [Arg3]％ 献祭量的触腕伤害。"
  },
  AwakerTalent_74140_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每当获得献祭时，还会获得等同于 [Arg3]％ 献祭量的触腕伤害。"
  },
  AwakerTalent_74140_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每当获得献祭时，还会获得等同于 [Arg3]％ 献祭量的触腕伤害。"
  },
  AwakerTalent_74140_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每当获得献祭时，还会获得等同于 [Arg3]％ 献祭量的触腕伤害。"
  },
  AwakerTalent_74140_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每当获得献祭时，还会获得等同于 [Arg3]％ 献祭量的触腕伤害。"
  },
  AwakerTalent_74140_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每当获得献祭时，还会获得等同于 [Arg3]％ 献祭量的触腕伤害。"
  },
  AwakerTalent_74140_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·每当获得献祭时，还会获得等同于 [Arg3]％ 献祭量的触腕伤害。"
  },
  AwakerTalent_74140_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74140_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74140_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74140_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74140_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74140_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74140_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74140_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74140_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74140_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74141_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·探索开始后，使所有唤醒体造成的中毒、反击、基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74141_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·探索开始后，使所有唤醒体造成的中毒、反击、基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74141_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·探索开始后，使所有唤醒体造成的中毒、反击、基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74141_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·探索开始后，使所有唤醒体造成的中毒、反击、基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74141_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·探索开始后，使所有唤醒体造成的中毒、反击、基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74141_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·探索开始后，使所有唤醒体造成的中毒、反击、基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74141_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·探索开始后，使所有唤醒体造成的中毒、反击、基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74141_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·探索开始后，使所有唤醒体造成的中毒、反击、基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74141_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·探索开始后，使所有唤醒体造成的中毒、反击、基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74141_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·探索开始后，使所有唤醒体造成的中毒、反击、基础伤害提高 [Arg3]％。"
  },
  AwakerTalent_74141_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74141_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74141_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74141_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74141_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74141_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74141_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74141_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74141_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74141_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74201_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·环行·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得环行·拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74201_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·环行·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得环行·拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74201_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·环行·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得环行·拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74201_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·环行·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得环行·拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74201_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·环行·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得环行·拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74201_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·环行·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得环行·拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74201_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·环行·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得环行·拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74201_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·环行·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得环行·拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74201_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·环行·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得环行·拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74201_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·环行·拉蒙娜的银钥充能提高 [Arg3]％，战斗开始时获得环行·拉蒙娜银钥充能 [Arg4]％ 的银钥能量。"
  },
  AwakerTalent_74201_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74201_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74201_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74201_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74201_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74201_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74201_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74201_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74201_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_74201_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78617_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78617_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78617_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78617_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78617_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78617_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78617_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78617_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78617_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78617_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78617_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78617_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78617_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78617_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78617_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78617_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78617_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78617_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78617_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78617_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78618_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「苦痛救赎」施加的基础伤害效果提高波吕克斯攻击力的 [Arg3]％。\n·每叠加 50 层「罪印」将 1 张「圣心」置入手中。\n· 「罪印」达到 100 层后，「圣心」因第 3 次打出消耗后抽 1 张自身「技能卡」。\n·造成伤害时，「罪印」对「提灯教会」敌人的效果翻倍。"
  },
  AwakerTalent_78618_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「苦痛救赎」施加的基础伤害效果提高波吕克斯攻击力的 [Arg3]％。\n·每叠加 50 层「罪印」将 1 张「圣心」置入手中。\n· 「罪印」达到 100 层后，「圣心」因第 3 次打出消耗后抽 1 张自身「技能卡」。\n·造成伤害时，「罪印」对「提灯教会」敌人的效果翻倍。"
  },
  AwakerTalent_78618_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「苦痛救赎」施加的基础伤害效果提高波吕克斯攻击力的 [Arg3]％。\n·每叠加 50 层「罪印」将 1 张「圣心」置入手中。\n· 「罪印」达到 100 层后，「圣心」因第 3 次打出消耗后抽 1 张自身「技能卡」。\n·造成伤害时，「罪印」对「提灯教会」敌人的效果翻倍。"
  },
  AwakerTalent_78618_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「苦痛救赎」施加的基础伤害效果提高波吕克斯攻击力的 [Arg3]％。\n·每叠加 50 层「罪印」将 1 张「圣心」置入手中。\n· 「罪印」达到 100 层后，「圣心」因第 3 次打出消耗后抽 1 张自身「技能卡」。\n·造成伤害时，「罪印」对「提灯教会」敌人的效果翻倍。"
  },
  AwakerTalent_78618_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「苦痛救赎」施加的基础伤害效果提高波吕克斯攻击力的 [Arg3]％。\n·每叠加 50 层「罪印」将 1 张「圣心」置入手中。\n· 「罪印」达到 100 层后，「圣心」因第 3 次打出消耗后抽 1 张自身「技能卡」。\n·造成伤害时，「罪印」对「提灯教会」敌人的效果翻倍。"
  },
  AwakerTalent_78618_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「苦痛救赎」施加的基础伤害效果提高波吕克斯攻击力的 [Arg3]％。\n·每叠加 50 层「罪印」将 1 张「圣心」置入手中。\n· 「罪印」达到 100 层后，「圣心」因第 3 次打出消耗后抽 1 张自身「技能卡」。\n·造成伤害时，「罪印」对「提灯教会」敌人的效果翻倍。"
  },
  AwakerTalent_78618_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「苦痛救赎」施加的基础伤害效果提高波吕克斯攻击力的 [Arg3]％。\n·每叠加 50 层「罪印」将 1 张「圣心」置入手中。\n· 「罪印」达到 100 层后，「圣心」因第 3 次打出消耗后抽 1 张自身「技能卡」。\n·造成伤害时，「罪印」对「提灯教会」敌人的效果翻倍。"
  },
  AwakerTalent_78618_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「苦痛救赎」施加的基础伤害效果提高波吕克斯攻击力的 [Arg3]％。\n·每叠加 50 层「罪印」将 1 张「圣心」置入手中。\n· 「罪印」达到 100 层后，「圣心」因第 3 次打出消耗后抽 1 张自身「技能卡」。\n·造成伤害时，「罪印」对「提灯教会」敌人的效果翻倍。"
  },
  AwakerTalent_78618_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「苦痛救赎」施加的基础伤害效果提高波吕克斯攻击力的 [Arg3]％。\n·每叠加 50 层「罪印」将 1 张「圣心」置入手中。\n· 「罪印」达到 100 层后，「圣心」因第 3 次打出消耗后抽 1 张自身「技能卡」。\n·造成伤害时，「罪印」对「提灯教会」敌人的效果翻倍。"
  },
  AwakerTalent_78618_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「苦痛救赎」施加的基础伤害效果提高波吕克斯攻击力的 [Arg3]％。\n·每叠加 50 层「罪印」将 1 张「圣心」置入手中。\n· 「罪印」达到 100 层后，「圣心」因第 3 次打出消耗后抽 1 张自身「技能卡」。\n·造成伤害时，「罪印」对「提灯教会」敌人的效果翻倍。"
  },
  AwakerTalent_78618_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78618_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78618_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78618_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78618_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78618_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78618_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78618_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78618_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78618_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78619_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78619_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78619_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78619_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78619_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78619_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78619_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78619_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78619_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78619_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78619_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78619_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78619_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78619_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78619_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78619_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78619_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78619_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78619_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78619_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78619_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78619_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78619_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78619_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78620_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，使所有敌人承受的触腕伤害提高 [Arg3]％，对「深海」敌人效果翻倍。「惩戒雷霆」对「深海」敌人造成的主动伤害提高 [Arg4]％。"
  },
  AwakerTalent_78620_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，使所有敌人承受的触腕伤害提高 [Arg3]％，对「深海」敌人效果翻倍。「惩戒雷霆」对「深海」敌人造成的主动伤害提高 [Arg4]％。"
  },
  AwakerTalent_78620_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，使所有敌人承受的触腕伤害提高 [Arg3]％，对「深海」敌人效果翻倍。「惩戒雷霆」对「深海」敌人造成的主动伤害提高 [Arg4]％。"
  },
  AwakerTalent_78620_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，使所有敌人承受的触腕伤害提高 [Arg3]％，对「深海」敌人效果翻倍。「惩戒雷霆」对「深海」敌人造成的主动伤害提高 [Arg4]％。"
  },
  AwakerTalent_78620_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，使所有敌人承受的触腕伤害提高 [Arg3]％，对「深海」敌人效果翻倍。「惩戒雷霆」对「深海」敌人造成的主动伤害提高 [Arg4]％。"
  },
  AwakerTalent_78620_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，使所有敌人承受的触腕伤害提高 [Arg3]％，对「深海」敌人效果翻倍。「惩戒雷霆」对「深海」敌人造成的主动伤害提高 [Arg4]％。"
  },
  AwakerTalent_78620_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，使所有敌人承受的触腕伤害提高 [Arg3]％，对「深海」敌人效果翻倍。「惩戒雷霆」对「深海」敌人造成的主动伤害提高 [Arg4]％。"
  },
  AwakerTalent_78620_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，使所有敌人承受的触腕伤害提高 [Arg3]％，对「深海」敌人效果翻倍。「惩戒雷霆」对「深海」敌人造成的主动伤害提高 [Arg4]％。"
  },
  AwakerTalent_78620_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，使所有敌人承受的触腕伤害提高 [Arg3]％，对「深海」敌人效果翻倍。「惩戒雷霆」对「深海」敌人造成的主动伤害提高 [Arg4]％。"
  },
  AwakerTalent_78620_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·战斗开始时，使所有敌人承受的触腕伤害提高 [Arg3]％，对「深海」敌人效果翻倍。「惩戒雷霆」对「深海」敌人造成的主动伤害提高 [Arg4]％。"
  },
  AwakerTalent_78620_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78620_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78620_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78620_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78620_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78620_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78620_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78620_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78620_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78620_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78622_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「活焰」的增益效果提高 [Arg3]％，回合开始后和弃牌阶段前，清除所有手牌的「燃烧」，每层使凯蒂古拉获得 1 层「爆炎」。"
  },
  AwakerTalent_78622_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「活焰」的增益效果提高 [Arg3]％，回合开始后和弃牌阶段前，清除所有手牌的「燃烧」，每层使凯蒂古拉获得 1 层「爆炎」。"
  },
  AwakerTalent_78622_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「活焰」的增益效果提高 [Arg3]％，回合开始后和弃牌阶段前，清除所有手牌的「燃烧」，每层使凯蒂古拉获得 1 层「爆炎」。"
  },
  AwakerTalent_78622_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「活焰」的增益效果提高 [Arg3]％，回合开始后和弃牌阶段前，清除所有手牌的「燃烧」，每层使凯蒂古拉获得 1 层「爆炎」。"
  },
  AwakerTalent_78622_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「活焰」的增益效果提高 [Arg3]％，回合开始后和弃牌阶段前，清除所有手牌的「燃烧」，每层使凯蒂古拉获得 1 层「爆炎」。"
  },
  AwakerTalent_78622_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「活焰」的增益效果提高 [Arg3]％，回合开始后和弃牌阶段前，清除所有手牌的「燃烧」，每层使凯蒂古拉获得 1 层「爆炎」。"
  },
  AwakerTalent_78622_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「活焰」的增益效果提高 [Arg3]％，回合开始后和弃牌阶段前，清除所有手牌的「燃烧」，每层使凯蒂古拉获得 1 层「爆炎」。"
  },
  AwakerTalent_78622_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「活焰」的增益效果提高 [Arg3]％，回合开始后和弃牌阶段前，清除所有手牌的「燃烧」，每层使凯蒂古拉获得 1 层「爆炎」。"
  },
  AwakerTalent_78622_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「活焰」的增益效果提高 [Arg3]％，回合开始后和弃牌阶段前，清除所有手牌的「燃烧」，每层使凯蒂古拉获得 1 层「爆炎」。"
  },
  AwakerTalent_78622_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「活焰」的增益效果提高 [Arg3]％，回合开始后和弃牌阶段前，清除所有手牌的「燃烧」，每层使凯蒂古拉获得 1 层「爆炎」。"
  },
  AwakerTalent_78622_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78622_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78622_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78622_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78622_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78622_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78622_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78622_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78622_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78622_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78623_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·卡拉布狂气爆发的暴击率和暴击伤害提高 [Arg3]%。「饱餐」提供的生命上限提高 [Arg5]%。在「冰域」地形中，「粉雪魔咒」算力消耗-1，伤害次数 +1，并且伤害与虚弱效果对所有敌人都生效。"
  },
  AwakerTalent_78623_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·卡拉布狂气爆发的暴击率和暴击伤害提高 [Arg3]%。「饱餐」提供的生命上限提高 [Arg5]%。在「冰域」地形中，「粉雪魔咒」算力消耗-1，伤害次数 +1，并且伤害与虚弱效果对所有敌人都生效。"
  },
  AwakerTalent_78623_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·卡拉布狂气爆发的暴击率和暴击伤害提高 [Arg3]%。「饱餐」提供的生命上限提高 [Arg5]%。在「冰域」地形中，「粉雪魔咒」算力消耗-1，伤害次数 +1，并且伤害与虚弱效果对所有敌人都生效。"
  },
  AwakerTalent_78623_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·卡拉布狂气爆发的暴击率和暴击伤害提高 [Arg3]%。「饱餐」提供的生命上限提高 [Arg5]%。在「冰域」地形中，「粉雪魔咒」算力消耗-1，伤害次数 +1，并且伤害与虚弱效果对所有敌人都生效。"
  },
  AwakerTalent_78623_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·卡拉布狂气爆发的暴击率和暴击伤害提高 [Arg3]%。「饱餐」提供的生命上限提高 [Arg5]%。在「冰域」地形中，「粉雪魔咒」算力消耗-1，伤害次数 +1，并且伤害与虚弱效果对所有敌人都生效。"
  },
  AwakerTalent_78623_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·卡拉布狂气爆发的暴击率和暴击伤害提高 [Arg3]%。「饱餐」提供的生命上限提高 [Arg5]%。在「冰域」地形中，「粉雪魔咒」算力消耗-1，伤害次数 +1，并且伤害与虚弱效果对所有敌人都生效。"
  },
  AwakerTalent_78623_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·卡拉布狂气爆发的暴击率和暴击伤害提高 [Arg3]%。「饱餐」提供的生命上限提高 [Arg5]%。在「冰域」地形中，「粉雪魔咒」算力消耗-1，伤害次数 +1，并且伤害与虚弱效果对所有敌人都生效。"
  },
  AwakerTalent_78623_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·卡拉布狂气爆发的暴击率和暴击伤害提高 [Arg3]%。「饱餐」提供的生命上限提高 [Arg5]%。在「冰域」地形中，「粉雪魔咒」算力消耗-1，伤害次数 +1，并且伤害与虚弱效果对所有敌人都生效。"
  },
  AwakerTalent_78623_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·卡拉布狂气爆发的暴击率和暴击伤害提高 [Arg3]%。「饱餐」提供的生命上限提高 [Arg5]%。在「冰域」地形中，「粉雪魔咒」算力消耗-1，伤害次数 +1，并且伤害与虚弱效果对所有敌人都生效。"
  },
  AwakerTalent_78623_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·卡拉布狂气爆发的暴击率和暴击伤害提高 [Arg3]%。「饱餐」提供的生命上限提高 [Arg5]%。在「冰域」地形中，「粉雪魔咒」算力消耗-1，伤害次数 +1，并且伤害与虚弱效果对所有敌人都生效。"
  },
  AwakerTalent_78623_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78623_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78623_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78623_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78623_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78623_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78623_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78623_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78623_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78623_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78624_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「黑羽」不会添加「算力调和」，「圣羽洗罪」施加的侵蚀提高卡斯托尔攻击力的 [Arg3]％。\n·卡斯托尔对「提灯教会」敌人施加的侵蚀提高 [Arg4]％。"
  },
  AwakerTalent_78624_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「黑羽」不会添加「算力调和」，「圣羽洗罪」施加的侵蚀提高卡斯托尔攻击力的 [Arg3]％。\n·卡斯托尔对「提灯教会」敌人施加的侵蚀提高 [Arg4]％。"
  },
  AwakerTalent_78624_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「黑羽」不会添加「算力调和」，「圣羽洗罪」施加的侵蚀提高卡斯托尔攻击力的 [Arg3]％。\n·卡斯托尔对「提灯教会」敌人施加的侵蚀提高 [Arg4]％。"
  },
  AwakerTalent_78624_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「黑羽」不会添加「算力调和」，「圣羽洗罪」施加的侵蚀提高卡斯托尔攻击力的 [Arg3]％。\n·卡斯托尔对「提灯教会」敌人施加的侵蚀提高 [Arg4]％。"
  },
  AwakerTalent_78624_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「黑羽」不会添加「算力调和」，「圣羽洗罪」施加的侵蚀提高卡斯托尔攻击力的 [Arg3]％。\n·卡斯托尔对「提灯教会」敌人施加的侵蚀提高 [Arg4]％。"
  },
  AwakerTalent_78624_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「黑羽」不会添加「算力调和」，「圣羽洗罪」施加的侵蚀提高卡斯托尔攻击力的 [Arg3]％。\n·卡斯托尔对「提灯教会」敌人施加的侵蚀提高 [Arg4]％。"
  },
  AwakerTalent_78624_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「黑羽」不会添加「算力调和」，「圣羽洗罪」施加的侵蚀提高卡斯托尔攻击力的 [Arg3]％。\n·卡斯托尔对「提灯教会」敌人施加的侵蚀提高 [Arg4]％。"
  },
  AwakerTalent_78624_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「黑羽」不会添加「算力调和」，「圣羽洗罪」施加的侵蚀提高卡斯托尔攻击力的 [Arg3]％。\n·卡斯托尔对「提灯教会」敌人施加的侵蚀提高 [Arg4]％。"
  },
  AwakerTalent_78624_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「黑羽」不会添加「算力调和」，「圣羽洗罪」施加的侵蚀提高卡斯托尔攻击力的 [Arg3]％。\n·卡斯托尔对「提灯教会」敌人施加的侵蚀提高 [Arg4]％。"
  },
  AwakerTalent_78624_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·打出「黑羽」不会添加「算力调和」，「圣羽洗罪」施加的侵蚀提高卡斯托尔攻击力的 [Arg3]％。\n·卡斯托尔对「提灯教会」敌人施加的侵蚀提高 [Arg4]％。"
  },
  AwakerTalent_78624_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78624_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78624_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78624_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78624_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78624_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78624_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78624_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78624_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78624_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78625_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「真实，亦是幻想」额外使其他唤醒体本回合狂气爆发造成的最终伤害提高 [Arg3]％，使用后皮克曼的基础狂气降低 5 点。"
  },
  AwakerTalent_78625_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「真实，亦是幻想」额外使其他唤醒体本回合狂气爆发造成的最终伤害提高 [Arg3]％，使用后皮克曼的基础狂气降低 5 点。"
  },
  AwakerTalent_78625_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「真实，亦是幻想」额外使其他唤醒体本回合狂气爆发造成的最终伤害提高 [Arg3]％，使用后皮克曼的基础狂气降低 5 点。"
  },
  AwakerTalent_78625_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「真实，亦是幻想」额外使其他唤醒体本回合狂气爆发造成的最终伤害提高 [Arg3]％，使用后皮克曼的基础狂气降低 5 点。"
  },
  AwakerTalent_78625_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「真实，亦是幻想」额外使其他唤醒体本回合狂气爆发造成的最终伤害提高 [Arg3]％，使用后皮克曼的基础狂气降低 5 点。"
  },
  AwakerTalent_78625_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「真实，亦是幻想」额外使其他唤醒体本回合狂气爆发造成的最终伤害提高 [Arg3]％，使用后皮克曼的基础狂气降低 5 点。"
  },
  AwakerTalent_78625_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「真实，亦是幻想」额外使其他唤醒体本回合狂气爆发造成的最终伤害提高 [Arg3]％，使用后皮克曼的基础狂气降低 5 点。"
  },
  AwakerTalent_78625_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「真实，亦是幻想」额外使其他唤醒体本回合狂气爆发造成的最终伤害提高 [Arg3]％，使用后皮克曼的基础狂气降低 5 点。"
  },
  AwakerTalent_78625_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「真实，亦是幻想」额外使其他唤醒体本回合狂气爆发造成的最终伤害提高 [Arg3]％，使用后皮克曼的基础狂气降低 5 点。"
  },
  AwakerTalent_78625_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·「真实，亦是幻想」额外使其他唤醒体本回合狂气爆发造成的最终伤害提高 [Arg3]％，使用后皮克曼的基础狂气降低 5 点。"
  },
  AwakerTalent_78625_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78625_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78625_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78625_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78625_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78625_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78625_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78625_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78625_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78625_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78627_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78627_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78627_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78627_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78627_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78627_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78627_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78627_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78627_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78627_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78627_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78627_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78627_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78627_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78627_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78627_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78627_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78627_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78627_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78627_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78627_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78627_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78627_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78627_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78630_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78630_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78630_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78630_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78630_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78630_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78630_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78630_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78630_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78630_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78630_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78630_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78630_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78630_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78630_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78630_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78630_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78630_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78630_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78630_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78631_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78631_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78631_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78631_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78631_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78631_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78631_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78631_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78631_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78631_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78631_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78631_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78631_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78631_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78631_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78631_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78631_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78631_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78631_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78631_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78631_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78631_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78631_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78631_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78632_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78632_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78632_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78632_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78632_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78632_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78632_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78632_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78632_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78632_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78632_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78632_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78632_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78632_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78632_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78632_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78632_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78632_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78632_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78632_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78632_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78632_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78632_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78632_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78633_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78633_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78633_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78633_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78633_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78633_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78633_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78633_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78633_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78633_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78633_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78633_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78633_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78633_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78633_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78633_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78633_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78633_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78633_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78633_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78633_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78633_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78633_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78633_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78634_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78634_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78634_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78634_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78634_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78634_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78634_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78634_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78634_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78634_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78634_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78634_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78634_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78634_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78634_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78634_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78634_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78634_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78634_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78634_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78634_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78634_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78634_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78634_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78635_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78635_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78635_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78635_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78635_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78635_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78635_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78635_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78635_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78635_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78635_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78635_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78635_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78635_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78635_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78635_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78635_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78635_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78635_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78635_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78635_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78635_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78635_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78635_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78636_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78636_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78636_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78636_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78636_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78636_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78636_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78636_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78636_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78636_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78636_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78636_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78636_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78636_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78636_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78636_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78636_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78636_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78636_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78636_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78637_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78637_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78637_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78637_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78637_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78637_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78637_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78637_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78637_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78637_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78637_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78637_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78637_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78637_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78637_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78637_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78637_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78637_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78637_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78637_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78637_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78637_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78637_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78637_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78639_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78639_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78639_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78639_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78639_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78639_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78639_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78639_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78639_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78639_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78639_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78639_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78639_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78639_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78639_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78639_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78639_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78639_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78639_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78639_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78640_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78640_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78640_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78640_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78640_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78640_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78640_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78640_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78640_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78640_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78640_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78640_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78640_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78640_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78640_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78640_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78640_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78640_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78640_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78640_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78640_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78640_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78640_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78640_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78642_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·阿拉克涅造成的「命运裁断」提高 [Arg3]％，对异变体敌人造成的「命运裁断」翻倍。"
  },
  AwakerTalent_78642_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·阿拉克涅造成的「命运裁断」提高 [Arg3]％，对异变体敌人造成的「命运裁断」翻倍。"
  },
  AwakerTalent_78642_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·阿拉克涅造成的「命运裁断」提高 [Arg3]％，对异变体敌人造成的「命运裁断」翻倍。"
  },
  AwakerTalent_78642_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·阿拉克涅造成的「命运裁断」提高 [Arg3]％，对异变体敌人造成的「命运裁断」翻倍。"
  },
  AwakerTalent_78642_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·阿拉克涅造成的「命运裁断」提高 [Arg3]％，对异变体敌人造成的「命运裁断」翻倍。"
  },
  AwakerTalent_78642_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·阿拉克涅造成的「命运裁断」提高 [Arg3]％，对异变体敌人造成的「命运裁断」翻倍。"
  },
  AwakerTalent_78642_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·阿拉克涅造成的「命运裁断」提高 [Arg3]％，对异变体敌人造成的「命运裁断」翻倍。"
  },
  AwakerTalent_78642_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·阿拉克涅造成的「命运裁断」提高 [Arg3]％，对异变体敌人造成的「命运裁断」翻倍。"
  },
  AwakerTalent_78642_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·阿拉克涅造成的「命运裁断」提高 [Arg3]％，对异变体敌人造成的「命运裁断」翻倍。"
  },
  AwakerTalent_78642_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·阿拉克涅造成的「命运裁断」提高 [Arg3]％，对异变体敌人造成的「命运裁断」翻倍。"
  },
  AwakerTalent_78642_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78642_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78642_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78642_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78642_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78642_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78642_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78642_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78642_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78642_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78643_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78643_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78643_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78643_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78643_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78643_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78643_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78643_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78643_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78643_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78643_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78643_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78643_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78643_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78643_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78643_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78643_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78643_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78643_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78643_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78643_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78643_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78643_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78643_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78644_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78644_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78644_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78644_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78644_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78644_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78644_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78644_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78644_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78644_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78644_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78644_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78644_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78644_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78644_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78644_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78644_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78644_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78644_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78644_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78644_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78644_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78644_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78644_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78645_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体获得的力量提高 [Arg3]％。\n·克莱门汀对「虫族」敌人造成伤害时，对目标施加 [Arg4]％ 伤害的出血效果。克莱门汀每回合首次造成护盾或回复生命时，使「虫族」敌人临时失去防御力 [Arg5]％ 的力量。"
  },
  AwakerTalent_78645_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体获得的力量提高 [Arg3]％。\n·克莱门汀对「虫族」敌人造成伤害时，对目标施加 [Arg4]％ 伤害的出血效果。克莱门汀每回合首次造成护盾或回复生命时，使「虫族」敌人临时失去防御力 [Arg5]％ 的力量。"
  },
  AwakerTalent_78645_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体获得的力量提高 [Arg3]％。\n·克莱门汀对「虫族」敌人造成伤害时，对目标施加 [Arg4]％ 伤害的出血效果。克莱门汀每回合首次造成护盾或回复生命时，使「虫族」敌人临时失去防御力 [Arg5]％ 的力量。"
  },
  AwakerTalent_78645_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体获得的力量提高 [Arg3]％。\n·克莱门汀对「虫族」敌人造成伤害时，对目标施加 [Arg4]％ 伤害的出血效果。克莱门汀每回合首次造成护盾或回复生命时，使「虫族」敌人临时失去防御力 [Arg5]％ 的力量。"
  },
  AwakerTalent_78645_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体获得的力量提高 [Arg3]％。\n·克莱门汀对「虫族」敌人造成伤害时，对目标施加 [Arg4]％ 伤害的出血效果。克莱门汀每回合首次造成护盾或回复生命时，使「虫族」敌人临时失去防御力 [Arg5]％ 的力量。"
  },
  AwakerTalent_78645_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体获得的力量提高 [Arg3]％。\n·克莱门汀对「虫族」敌人造成伤害时，对目标施加 [Arg4]％ 伤害的出血效果。克莱门汀每回合首次造成护盾或回复生命时，使「虫族」敌人临时失去防御力 [Arg5]％ 的力量。"
  },
  AwakerTalent_78645_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体获得的力量提高 [Arg3]％。\n·克莱门汀对「虫族」敌人造成伤害时，对目标施加 [Arg4]％ 伤害的出血效果。克莱门汀每回合首次造成护盾或回复生命时，使「虫族」敌人临时失去防御力 [Arg5]％ 的力量。"
  },
  AwakerTalent_78645_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体获得的力量提高 [Arg3]％。\n·克莱门汀对「虫族」敌人造成伤害时，对目标施加 [Arg4]％ 伤害的出血效果。克莱门汀每回合首次造成护盾或回复生命时，使「虫族」敌人临时失去防御力 [Arg5]％ 的力量。"
  },
  AwakerTalent_78645_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体获得的力量提高 [Arg3]％。\n·克莱门汀对「虫族」敌人造成伤害时，对目标施加 [Arg4]％ 伤害的出血效果。克莱门汀每回合首次造成护盾或回复生命时，使「虫族」敌人临时失去防御力 [Arg5]％ 的力量。"
  },
  AwakerTalent_78645_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体获得的力量提高 [Arg3]％。\n·克莱门汀对「虫族」敌人造成伤害时，对目标施加 [Arg4]％ 伤害的出血效果。克莱门汀每回合首次造成护盾或回复生命时，使「虫族」敌人临时失去防御力 [Arg5]％ 的力量。"
  },
  AwakerTalent_78645_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78645_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78645_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78645_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78645_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78645_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78645_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78645_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78645_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78645_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78646_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78646_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78646_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78646_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78646_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78646_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78646_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78646_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78646_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78646_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_78646_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78646_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78646_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78646_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78646_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78646_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78646_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78646_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78646_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78646_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78647_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78647_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78647_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78647_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78647_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78647_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78647_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78647_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78647_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78647_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78647_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78647_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78647_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78647_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78647_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78647_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78647_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78647_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78647_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78647_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78647_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78647_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78647_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78647_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78749_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78749_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78749_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78749_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78749_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78749_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78749_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78749_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78749_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78749_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78749_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78749_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78749_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78749_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78749_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78749_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78749_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78749_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78749_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78749_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78749_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78749_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78749_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78749_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78911_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诞妄·墨菲造成的伤害附加 [Arg3]％「献祭」，「命契」对「降生仪式」的提高效果翻倍。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，生命上限提高 6%/15%/30％。「利莫里亚」唤醒体释放狂气爆发后获得诞妄·墨菲 50%/125%/250% 防御力的护盾，该效果每回合至多生效 1 次且不受护盾提高效果影响。"
  },
  AwakerTalent_78911_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诞妄·墨菲造成的伤害附加 [Arg3]％「献祭」，「命契」对「降生仪式」的提高效果翻倍。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，生命上限提高 6%/15%/30％。「利莫里亚」唤醒体释放狂气爆发后获得诞妄·墨菲 50%/125%/250% 防御力的护盾，该效果每回合至多生效 1 次且不受护盾提高效果影响。"
  },
  AwakerTalent_78911_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诞妄·墨菲造成的伤害附加 [Arg3]％「献祭」，「命契」对「降生仪式」的提高效果翻倍。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，生命上限提高 6%/15%/30％。「利莫里亚」唤醒体释放狂气爆发后获得诞妄·墨菲 50%/125%/250% 防御力的护盾，该效果每回合至多生效 1 次且不受护盾提高效果影响。"
  },
  AwakerTalent_78911_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诞妄·墨菲造成的伤害附加 [Arg3]％「献祭」，「命契」对「降生仪式」的提高效果翻倍。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，生命上限提高 6%/15%/30％。「利莫里亚」唤醒体释放狂气爆发后获得诞妄·墨菲 50%/125%/250% 防御力的护盾，该效果每回合至多生效 1 次且不受护盾提高效果影响。"
  },
  AwakerTalent_78911_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诞妄·墨菲造成的伤害附加 [Arg3]％「献祭」，「命契」对「降生仪式」的提高效果翻倍。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，生命上限提高 6%/15%/30％。「利莫里亚」唤醒体释放狂气爆发后获得诞妄·墨菲 50%/125%/250% 防御力的护盾，该效果每回合至多生效 1 次且不受护盾提高效果影响。"
  },
  AwakerTalent_78911_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诞妄·墨菲造成的伤害附加 [Arg3]％「献祭」，「命契」对「降生仪式」的提高效果翻倍。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，生命上限提高 6%/15%/30％。「利莫里亚」唤醒体释放狂气爆发后获得诞妄·墨菲 50%/125%/250% 防御力的护盾，该效果每回合至多生效 1 次且不受护盾提高效果影响。"
  },
  AwakerTalent_78911_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诞妄·墨菲造成的伤害附加 [Arg3]％「献祭」，「命契」对「降生仪式」的提高效果翻倍。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，生命上限提高 6%/15%/30％。「利莫里亚」唤醒体释放狂气爆发后获得诞妄·墨菲 50%/125%/250% 防御力的护盾，该效果每回合至多生效 1 次且不受护盾提高效果影响。"
  },
  AwakerTalent_78911_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诞妄·墨菲造成的伤害附加 [Arg3]％「献祭」，「命契」对「降生仪式」的提高效果翻倍。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，生命上限提高 6%/15%/30％。「利莫里亚」唤醒体释放狂气爆发后获得诞妄·墨菲 50%/125%/250% 防御力的护盾，该效果每回合至多生效 1 次且不受护盾提高效果影响。"
  },
  AwakerTalent_78911_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诞妄·墨菲造成的伤害附加 [Arg3]％「献祭」，「命契」对「降生仪式」的提高效果翻倍。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，生命上限提高 6%/15%/30％。「利莫里亚」唤醒体释放狂气爆发后获得诞妄·墨菲 50%/125%/250% 防御力的护盾，该效果每回合至多生效 1 次且不受护盾提高效果影响。"
  },
  AwakerTalent_78911_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·诞妄·墨菲造成的伤害附加 [Arg3]％「献祭」，「命契」对「降生仪式」的提高效果翻倍。\n·当队伍中存在 1/2/3 名其它「利莫里亚」唤醒体时，生命上限提高 6%/15%/30％。「利莫里亚」唤醒体释放狂气爆发后获得诞妄·墨菲 50%/125%/250% 防御力的护盾，该效果每回合至多生效 1 次且不受护盾提高效果影响。"
  },
  AwakerTalent_78911_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78911_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78911_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78911_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78911_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78911_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78911_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78911_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78911_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78911_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_78912_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78912_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78912_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78912_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78912_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78912_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78912_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78912_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78912_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78912_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78912_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78912_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78912_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78912_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78912_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78912_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78912_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78912_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78912_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78912_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78912_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78912_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78912_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78912_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78916_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78916_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78916_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78916_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78916_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78916_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78916_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78916_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78916_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78916_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78916_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78916_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_78916_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78916_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78916_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78916_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78916_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78916_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78916_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78916_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78916_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78916_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78916_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_78916_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_79211_TalentDesc_1 = {
    Text = "·克莱门汀的指令卡造成伤害后获得 1 层「共感」。\n·克莱门汀唤醒体自身、命轮、密契每提供 1 点银钥充能属性，暴击率和暴击伤害提高 0.35％ 。\n·超维回合开始后，移除所有敌人的「精神创伤」与「恐惧固着」。每移除所有敌人 1 层「精神创伤」就获得 50 点银钥能量，每移除所有敌人 1 层「恐惧固着」就使其他唤醒体获得 2 点狂气。"
  },
  AwakerTalent_79211_TalentName_1 = {
    Text = "巢群感应"
  },
  AwakerTalent_79788_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_79788_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_79788_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_79788_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_79788_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_79788_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_79788_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_79788_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_79788_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_79788_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。"
  },
  AwakerTalent_79788_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_79788_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_79788_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_79788_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_79788_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_79788_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_79788_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_79788_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_79788_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_79788_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_83778_TalentDesc_1 = {
    Text = "·克珀珊特自身、装备的命轮与密契每提供 1% 死亡抵抗，基础伤害提高 0.2%，护盾提高 0.05%。"
  },
  AwakerTalent_83778_TalentName_1 = {Text = "余火"},
  AwakerTalent_84132_TalentDesc_1 = {
    Text = "·奥瑞塔每有 1 点狂气回充等级，战斗开始时获得奥瑞塔攻击力 2% 的触腕伤害，每有 1% 暴击率，战斗开始时获得奥瑞塔攻击力 1% 的触腕伤害。"
  },
  AwakerTalent_84132_TalentName_1 = {
    Text = "快乐精灵"
  },
  AwakerTalent_89775_TalentDesc_1 = {
    Text = "·每回合首次打出「黑羽」时对所有敌人施加自身攻击力840％的「侵蚀」并获得 10 点狂气。\n·卡斯托尔每有 1% 伤害强效就使施加的基础「侵蚀」提高 1%。\n·战斗结束后，本次探索中卡斯托尔施加的「侵蚀」永久提高 20％。\n·首领战施加的「侵蚀」翻倍。\n·卡斯托尔施加「侵蚀」后本回合自身伤害提高 5% 施加量。\n·卡斯托尔造成的伤害不会移除「侵蚀」。"
  },
  AwakerTalent_89775_TalentName_1 = {
    Text = "圣羽洗罪"
  },
  AwakerTalent_95804_TalentDesc_1 = {
    Text = "·杜勒赛因击杀敌人或使用狂气爆发对首领造成伤害后，获得 1 具「残骸」。\n·至多积攒 3 具「残骸」。\n·「残骸」会继承至下场战斗。"
  },
  AwakerTalent_95804_TalentName_1 = {
    Text = "遗骨灵柩"
  },
  AwakerTalent_95805_TalentDesc_1 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_95805_TalentDesc_10 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_95805_TalentDesc_11 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_95805_TalentDesc_12 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_95805_TalentDesc_2 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_95805_TalentDesc_3 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_95805_TalentDesc_4 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_95805_TalentDesc_5 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_95805_TalentDesc_6 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_95805_TalentDesc_7 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_95805_TalentDesc_8 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_95805_TalentDesc_9 = {
    Text = "探索开始后，获得 [Arg1] 点狂气。"
  },
  AwakerTalent_95805_TalentName_1 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_95805_TalentName_10 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_95805_TalentName_11 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_95805_TalentName_12 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_95805_TalentName_2 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_95805_TalentName_3 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_95805_TalentName_4 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_95805_TalentName_5 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_95805_TalentName_6 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_95805_TalentName_7 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_95805_TalentName_8 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_95805_TalentName_9 = {
    Text = "疯狂预兆"
  },
  AwakerTalent_95806_TalentDesc_1 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量获取效果提高 [Arg3]％。\n·杜勒赛因击杀「亡灵」时获得 [Arg4] 点狂气。"
  },
  AwakerTalent_95806_TalentDesc_10 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量获取效果提高 [Arg3]％。\n·杜勒赛因击杀「亡灵」时获得 [Arg4] 点狂气。"
  },
  AwakerTalent_95806_TalentDesc_2 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量获取效果提高 [Arg3]％。\n·杜勒赛因击杀「亡灵」时获得 [Arg4] 点狂气。"
  },
  AwakerTalent_95806_TalentDesc_3 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量获取效果提高 [Arg3]％。\n·杜勒赛因击杀「亡灵」时获得 [Arg4] 点狂气。"
  },
  AwakerTalent_95806_TalentDesc_4 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量获取效果提高 [Arg3]％。\n·杜勒赛因击杀「亡灵」时获得 [Arg4] 点狂气。"
  },
  AwakerTalent_95806_TalentDesc_5 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量获取效果提高 [Arg3]％。\n·杜勒赛因击杀「亡灵」时获得 [Arg4] 点狂气。"
  },
  AwakerTalent_95806_TalentDesc_6 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量获取效果提高 [Arg3]％。\n·杜勒赛因击杀「亡灵」时获得 [Arg4] 点狂气。"
  },
  AwakerTalent_95806_TalentDesc_7 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量获取效果提高 [Arg3]％。\n·杜勒赛因击杀「亡灵」时获得 [Arg4] 点狂气。"
  },
  AwakerTalent_95806_TalentDesc_8 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量获取效果提高 [Arg3]％。\n·杜勒赛因击杀「亡灵」时获得 [Arg4] 点狂气。"
  },
  AwakerTalent_95806_TalentDesc_9 = {
    Text = "·该天赋仅在「星辰篇」关卡中生效。\n·该唤醒体的体质、攻击、防御提高 [Arg1] %，并使该唤醒体首次打出灵知觉醒后获得 [Arg2] 点银钥能量。\n·所有唤醒体力量获取效果提高 [Arg3]％。\n·杜勒赛因击杀「亡灵」时获得 [Arg4] 点狂气。"
  },
  AwakerTalent_95806_TalentName_1 = {
    Text = "灵塑适性"
  },
  AwakerTalent_95806_TalentName_10 = {
    Text = "灵塑适性"
  },
  AwakerTalent_95806_TalentName_2 = {
    Text = "灵塑适性"
  },
  AwakerTalent_95806_TalentName_3 = {
    Text = "灵塑适性"
  },
  AwakerTalent_95806_TalentName_4 = {
    Text = "灵塑适性"
  },
  AwakerTalent_95806_TalentName_5 = {
    Text = "灵塑适性"
  },
  AwakerTalent_95806_TalentName_6 = {
    Text = "灵塑适性"
  },
  AwakerTalent_95806_TalentName_7 = {
    Text = "灵塑适性"
  },
  AwakerTalent_95806_TalentName_8 = {
    Text = "灵塑适性"
  },
  AwakerTalent_95806_TalentName_9 = {
    Text = "灵塑适性"
  },
  AwakerTalent_97268_TalentDesc_1 = {
    Text = "·杜勒赛因获得「残骸」后，将 1 张「永夜欢宴」置入手中。"
  },
  AwakerTalent_97268_TalentName_1 = {
    Text = "腐宴恩典"
  },
  AwakerTalent_98451_TalentDesc_1 = {
    Text = "·回合开始时，随机为手中 1 张凯蒂古拉的指令卡赋予 1 层「活焰」。\n·凯蒂古拉每消耗 1 层「活焰」获得 1 层「爆炎」。\n·当「爆炎」达到 10 层时，获得 2 点算力，将所有「千兆耀斑」升级为「亿兆耀斑」。"
  },
  AwakerTalent_98451_TalentName_1 = {
    Text = "爆燃之主"
  },
  AwakerTalent_98714_TalentDesc_1 = {
    Text = "·潘狄娅自身装备、命轮、密契每拥有 1％暴击率，造成的永久反击提高 0.2％。"
  },
  AwakerTalent_98714_TalentName_1 = {
    Text = "惩罚时间"
  },
  AwakerTalent_99107_TalentDesc_1 = {
    Text = "·皮克曼触发「发现」效果或使用「蚀骨色彩」后，获得 1 层「创意」。"
  },
  AwakerTalent_99107_TalentName_1 = {
    Text = "绘者之眼"
  }
})
return Text_AwakerTalent
