__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_AwakerTalent = readonly({
  AwakerTalent_117311_TalentDesc_1 = {
    Text = "· 폴룩스가 턴마다 처음으로 사용하는 명령 카드의 피해량이 공격력 200%만큼 증가하고, 방어막 획득량이 방어력 50%만큼 증가하며, 10 광기를 획득합니다. \n· 전투 종료 후, 해당 탐사 동안 폴룩스의 기본 피해 및 「고통 구원」의 피해량 증가 효과가 20% 증가하며, 보스전에서는 「고통 구원」의 피해량 증가 효과가 2배로 적용됩니다."
  },
  AwakerTalent_117311_TalentName_1 = {
    Text = "고통 구원"
  },
  AwakerTalent_120347_TalentDesc_1 = {
    Text = "·해당 캐릭터가 팀에 있을 때, 「심해」 계역을 「회명·심해」 계역으로 교체합니다.\n·기본 촉수 피해가 팀 최대 HP의 5%로 변경됩니다.\n·탐색 시작 후 팀 피해 증폭 +50%, 팀이 심해 또는 카오스 깨어남체로만 구성된 경우 해당 효과로 얻는 피해 증폭이 2배가 되지만, 전투 시작 시 추가 촉수를 더 이상 획득하지 않습니다.\n·「촉수 집결」 효과를 더 이상 보유하지 않습니다.\n·촉수 자세가 「회명·촉수 자세」로 변경됩니다.\n·「회명·정해」: 최대 HP의 25% 방어막를 획득하고, 턴 종료 후 촉수가 더 이상 공격하지 않으며, 3턴 쿨다운.\n·「회명·노도」: 이번 턴 촉수 피해를 125%로 만들고, 능동 피해를 가한 후 촉수 1개가 공격하지만, 턴 종료 후 촉수 1개를 잃으며, 3턴 쿨다운.\n·계역 숙련이 「회명·심해 숙련」으로 변경되며, 계역 숙련 1포인트마다 「회명·정해」의 방어막가 최대 HP의 0.025% 증가하고, 「회명·노도」의 촉수 피해가 추가로 0.025% 증가합니다.\n·팀이 심해 또는 카오스 깨어남체로만 구성된 경우, 「회명·계역 숙련」 효과가 2배가 됩니다."
  },
  AwakerTalent_120347_TalentName_1 = {
    Text = "영원한 어둠의 땅"
  },
  AwakerTalent_122481_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·무셰트가 「지배자」 적에게 주는 최종 피해가 [Arg5]% 증가합니다. \n· 모든 깨어남체의 「타격」 기본 피해가 [Arg3]% 증가합니다. \n· 죽음 저항이 발동할 때마다 무셰트가 [Arg4] 광기를 획득합니다."
  },
  AwakerTalent_122481_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·무셰트가 「지배자」 적에게 주는 최종 피해가 [Arg5]% 증가합니다. \n· 모든 깨어남체의 「타격」 기본 피해가 [Arg3]% 증가합니다. \n· 죽음 저항이 발동할 때마다 무셰트가 [Arg4] 광기를 획득합니다."
  },
  AwakerTalent_122481_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·무셰트가 「지배자」 적에게 주는 최종 피해가 [Arg5]% 증가합니다. \n· 모든 깨어남체의 「타격」 기본 피해가 [Arg3]% 증가합니다. \n· 죽음 저항이 발동할 때마다 무셰트가 [Arg4] 광기를 획득합니다."
  },
  AwakerTalent_122481_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·무셰트가 「지배자」 적에게 주는 최종 피해가 [Arg5]% 증가합니다. \n· 모든 깨어남체의 「타격」 기본 피해가 [Arg3]% 증가합니다. \n· 죽음 저항이 발동할 때마다 무셰트가 [Arg4] 광기를 획득합니다."
  },
  AwakerTalent_122481_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·무셰트가 「지배자」 적에게 주는 최종 피해가 [Arg5]% 증가합니다. \n· 모든 깨어남체의 「타격」 기본 피해가 [Arg3]% 증가합니다. \n· 죽음 저항이 발동할 때마다 무셰트가 [Arg4] 광기를 획득합니다."
  },
  AwakerTalent_122481_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·무셰트가 「지배자」 적에게 주는 최종 피해가 [Arg5]% 증가합니다. \n· 모든 깨어남체의 「타격」 기본 피해가 [Arg3]% 증가합니다. \n· 죽음 저항이 발동할 때마다 무셰트가 [Arg4] 광기를 획득합니다."
  },
  AwakerTalent_122481_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·무셰트가 「지배자」 적에게 주는 최종 피해가 [Arg5]% 증가합니다. \n· 모든 깨어남체의 「타격」 기본 피해가 [Arg3]% 증가합니다. \n· 죽음 저항이 발동할 때마다 무셰트가 [Arg4] 광기를 획득합니다."
  },
  AwakerTalent_122481_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·무셰트가 「지배자」 적에게 주는 최종 피해가 [Arg5]% 증가합니다. \n· 모든 깨어남체의 「타격」 기본 피해가 [Arg3]% 증가합니다. \n· 죽음 저항이 발동할 때마다 무셰트가 [Arg4] 광기를 획득합니다."
  },
  AwakerTalent_122481_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·무셰트가 「지배자」 적에게 주는 최종 피해가 [Arg5]% 증가합니다. \n· 모든 깨어남체의 「타격」 기본 피해가 [Arg3]% 증가합니다. \n· 죽음 저항이 발동할 때마다 무셰트가 [Arg4] 광기를 획득합니다."
  },
  AwakerTalent_122481_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·무셰트가 「지배자」 적에게 주는 최종 피해가 [Arg5]% 증가합니다. \n· 모든 깨어남체의 「타격」 기본 피해가 [Arg3]% 증가합니다. \n· 죽음 저항이 발동할 때마다 무셰트가 [Arg4] 광기를 획득합니다."
  },
  AwakerTalent_122481_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_122481_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_122481_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_122481_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_122481_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_122481_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_122481_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_122481_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_122481_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_122481_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_122524_TalentDesc_1 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_122524_TalentDesc_10 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_122524_TalentDesc_11 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_122524_TalentDesc_12 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_122524_TalentDesc_2 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_122524_TalentDesc_3 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_122524_TalentDesc_4 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_122524_TalentDesc_5 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_122524_TalentDesc_6 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_122524_TalentDesc_7 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_122524_TalentDesc_8 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_122524_TalentDesc_9 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_122524_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_122524_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_122524_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_122524_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_122524_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_122524_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_122524_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_122524_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_122524_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_122524_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_122524_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_122524_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_122607_TalentDesc_1 = {
    Text = "「타격」을 2장 사용할 때마다 「무셰트」가 추격을 발동하여, 무작위 적에게 무셰트 공격력 30%의 피해를 입히고, 이를 「타격」 피해로 취급합니다. 턴마다 4회까지 발동합니다."
  },
  AwakerTalent_122607_TalentName_1 = {
    Text = "극적인 만남"
  },
  AwakerTalent_125362_TalentDesc_1 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·모든 각성체의 중독 효과 발동이 [Arg3]% 증가합니다.\n·「도취」 1스택마다 추가로 「인형」 적이 가하는 피해를 1% 감소시키며, 제거 시 추가로 「인형」 적에게 최대 HP의 1% 순수 피해를 가합니다."
  },
  AwakerTalent_125362_TalentDesc_10 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·모든 각성체의 중독 효과 발동이 [Arg3]% 증가합니다.\n·「도취」 1스택마다 추가로 「인형」 적이 가하는 피해를 1% 감소시키며, 제거 시 추가로 「인형」 적에게 최대 HP의 1% 순수 피해를 가합니다."
  },
  AwakerTalent_125362_TalentDesc_2 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·모든 각성체의 중독 효과 발동이 [Arg3]% 증가합니다.\n·「도취」 1스택마다 추가로 「인형」 적이 가하는 피해를 1% 감소시키며, 제거 시 추가로 「인형」 적에게 최대 HP의 1% 순수 피해를 가합니다."
  },
  AwakerTalent_125362_TalentDesc_3 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·모든 각성체의 중독 효과 발동이 [Arg3]% 증가합니다.\n·「도취」 1스택마다 추가로 「인형」 적이 가하는 피해를 1% 감소시키며, 제거 시 추가로 「인형」 적에게 최대 HP의 1% 순수 피해를 가합니다."
  },
  AwakerTalent_125362_TalentDesc_4 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·모든 각성체의 중독 효과 발동이 [Arg3]% 증가합니다.\n·「도취」 1스택마다 추가로 「인형」 적이 가하는 피해를 1% 감소시키며, 제거 시 추가로 「인형」 적에게 최대 HP의 1% 순수 피해를 가합니다."
  },
  AwakerTalent_125362_TalentDesc_5 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·모든 각성체의 중독 효과 발동이 [Arg3]% 증가합니다.\n·「도취」 1스택마다 추가로 「인형」 적이 가하는 피해를 1% 감소시키며, 제거 시 추가로 「인형」 적에게 최대 HP의 1% 순수 피해를 가합니다."
  },
  AwakerTalent_125362_TalentDesc_6 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·모든 각성체의 중독 효과 발동이 [Arg3]% 증가합니다.\n·「도취」 1스택마다 추가로 「인형」 적이 가하는 피해를 1% 감소시키며, 제거 시 추가로 「인형」 적에게 최대 HP의 1% 순수 피해를 가합니다."
  },
  AwakerTalent_125362_TalentDesc_7 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·모든 각성체의 중독 효과 발동이 [Arg3]% 증가합니다.\n·「도취」 1스택마다 추가로 「인형」 적이 가하는 피해를 1% 감소시키며, 제거 시 추가로 「인형」 적에게 최대 HP의 1% 순수 피해를 가합니다."
  },
  AwakerTalent_125362_TalentDesc_8 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·모든 각성체의 중독 효과 발동이 [Arg3]% 증가합니다.\n·「도취」 1스택마다 추가로 「인형」 적이 가하는 피해를 1% 감소시키며, 제거 시 추가로 「인형」 적에게 최대 HP의 1% 순수 피해를 가합니다."
  },
  AwakerTalent_125362_TalentDesc_9 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·모든 각성체의 중독 효과 발동이 [Arg3]% 증가합니다.\n·「도취」 1스택마다 추가로 「인형」 적이 가하는 피해를 1% 감소시키며, 제거 시 추가로 「인형」 적에게 최대 HP의 1% 순수 피해를 가합니다."
  },
  AwakerTalent_125362_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_125362_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_125362_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_125362_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_125362_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_125362_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_125362_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_125362_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_125362_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_125362_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_125363_TalentDesc_1 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_125363_TalentDesc_10 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_125363_TalentDesc_11 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_125363_TalentDesc_12 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_125363_TalentDesc_2 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_125363_TalentDesc_3 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_125363_TalentDesc_4 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_125363_TalentDesc_5 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_125363_TalentDesc_6 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_125363_TalentDesc_7 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_125363_TalentDesc_8 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_125363_TalentDesc_9 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_125363_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_125363_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_125363_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_125363_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_125363_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_125363_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_125363_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_125363_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_125363_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_125363_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_125363_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_125363_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_127223_TalentDesc_1 = {
    Text = "·아라크네가 팀에 있을 때, 「초차원」 영역을 「특이점·초차원」 영역으로 교체합니다.\n·차원 이동: 매 턴 첫 번째 명령 카드 사용 후 해당 효과가 발동되며, 임시 원본 복제를 초차원 공간에 배치하고 해당 카드와 임시 복제에 25스택의 「특이점 비콘」을 부여합니다. 초차원 턴에는 해당 효과를 발동할 수 없습니다.\n·특이점 비콘: 1스택 보유 시마다 해당 카드가 가하는 피해, 고정 힘과 촉수 피해 증가, 고정 중독, 고정 반격의 최종 효과가 2% 증가하고, 고정 방어막, 고정 HP 회복, 힘 감소의 최종 효과가 1% 증가하며, 사용 후 제거됩니다. 특이점 비콘을 보유한 카드는 「차원 이동」을 발동할 수 없습니다.\n·초차원 공간: 초차원 공간이 상한에 도달하면 턴 종료 시 초차원 공간을 발동하는 것으로 변경됩니다: 추가 턴을 더 이상 획득하지 않으며, 보존되지 않은 손패를 버리고 허무 효과를 발동하며, 초차원 공간의 모든 카드를 손패에 넣고 현재 행동력을 5포인트로 설정합니다. 초차원 공간 발동 후, 해당 턴은 초차원 턴으로 간주됩니다.\n·「특이점 소멸」: 초차원 공간의 가장 왼쪽 카드를 꺼냅니다. 3턴 쿨다운.\n·탐색 시작 후 팀 피해 증폭 +50%, 「특이점 프리즘」 15스택을 획득합니다.\n·「특이점 프리즘」: 모든 명령 카드가 동일한 수의 특이점 비콘 보너스를 보유한 것으로 간주됩니다.\n·초차원 숙련: 팀의 영역 숙련 1포인트마다 「특이점 프리즘」과 「차원 이동」이 부여하는 「특이점 비콘」 스택 수가 0.05% 증가합니다.\n·순수 초차원: 팀이 초차원 또는 혼돈 각성체로만 구성된 경우, 초차원 숙련 효과와 영역이 제공하는 피해 증폭이 2배가 됩니다."
  },
  AwakerTalent_127223_TalentName_1 = {
    Text = "운명의 실타래"
  },
  AwakerTalent_130395_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_130395_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_130395_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_130395_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_130395_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_130395_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_130395_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_130395_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_130395_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_130395_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_130395_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130395_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130395_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130395_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130395_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130395_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130395_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130395_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130395_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130395_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130396_TalentDesc_1 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130396_TalentDesc_10 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130396_TalentDesc_11 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130396_TalentDesc_12 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130396_TalentDesc_2 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130396_TalentDesc_3 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130396_TalentDesc_4 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130396_TalentDesc_5 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130396_TalentDesc_6 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130396_TalentDesc_7 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130396_TalentDesc_8 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130396_TalentDesc_9 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130396_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130396_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130396_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130396_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130396_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130396_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130396_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130396_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130396_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130396_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130396_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130396_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130397_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_130397_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_130397_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_130397_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_130397_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_130397_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_130397_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_130397_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_130397_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_130397_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_130397_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_130397_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_130397_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130397_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130397_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130397_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130397_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130397_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130397_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130397_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130397_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130397_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130397_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130397_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130398_TalentDesc_1 = {
    Text = "·이 특성은 「별의 시대」 단계에서만 적용됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·「사야의 노래」로 선택한 깨어남체가 [Arg3]층 「번식 축전」을 획득하고, 다음 키오더가 2회 발동됩니다.\n·사야가 「혈육」 적에게 가하는 「침식」이 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_130398_TalentDesc_10 = {
    Text = "·이 특성은 「별의 시대」 단계에서만 적용됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·「사야의 노래」로 선택한 깨어남체가 [Arg3]층 「번식 축전」을 획득하고, 다음 키오더가 2회 발동됩니다.\n·사야가 「혈육」 적에게 가하는 「침식」이 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_130398_TalentDesc_2 = {
    Text = "·이 특성은 「별의 시대」 단계에서만 적용됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·「사야의 노래」로 선택한 깨어남체가 [Arg3]층 「번식 축전」을 획득하고, 다음 키오더가 2회 발동됩니다.\n·사야가 「혈육」 적에게 가하는 「침식」이 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_130398_TalentDesc_3 = {
    Text = "·이 특성은 「별의 시대」 단계에서만 적용됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·「사야의 노래」로 선택한 깨어남체가 [Arg3]층 「번식 축전」을 획득하고, 다음 키오더가 2회 발동됩니다.\n·사야가 「혈육」 적에게 가하는 「침식」이 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_130398_TalentDesc_4 = {
    Text = "·이 특성은 「별의 시대」 단계에서만 적용됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·「사야의 노래」로 선택한 깨어남체가 [Arg3]층 「번식 축전」을 획득하고, 다음 키오더가 2회 발동됩니다.\n·사야가 「혈육」 적에게 가하는 「침식」이 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_130398_TalentDesc_5 = {
    Text = "·이 특성은 「별의 시대」 단계에서만 적용됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·「사야의 노래」로 선택한 깨어남체가 [Arg3]층 「번식 축전」을 획득하고, 다음 키오더가 2회 발동됩니다.\n·사야가 「혈육」 적에게 가하는 「침식」이 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_130398_TalentDesc_6 = {
    Text = "·이 특성은 「별의 시대」 단계에서만 적용됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·「사야의 노래」로 선택한 깨어남체가 [Arg3]층 「번식 축전」을 획득하고, 다음 키오더가 2회 발동됩니다.\n·사야가 「혈육」 적에게 가하는 「침식」이 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_130398_TalentDesc_7 = {
    Text = "·이 특성은 「별의 시대」 단계에서만 적용됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·「사야의 노래」로 선택한 깨어남체가 [Arg3]층 「번식 축전」을 획득하고, 다음 키오더가 2회 발동됩니다.\n·사야가 「혈육」 적에게 가하는 「침식」이 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_130398_TalentDesc_8 = {
    Text = "·이 특성은 「별의 시대」 단계에서만 적용됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·「사야의 노래」로 선택한 깨어남체가 [Arg3]층 「번식 축전」을 획득하고, 다음 키오더가 2회 발동됩니다.\n·사야가 「혈육」 적에게 가하는 「침식」이 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_130398_TalentDesc_9 = {
    Text = "·이 특성은 「별의 시대」 단계에서만 적용됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·「사야의 노래」로 선택한 깨어남체가 [Arg3]층 「번식 축전」을 획득하고, 다음 키오더가 2회 발동됩니다.\n·사야가 「혈육」 적에게 가하는 「침식」이 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_130398_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130398_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130398_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130398_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130398_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130398_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130398_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130398_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130398_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130398_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130399_TalentDesc_1 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130399_TalentDesc_10 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130399_TalentDesc_11 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130399_TalentDesc_12 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130399_TalentDesc_2 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130399_TalentDesc_3 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130399_TalentDesc_4 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130399_TalentDesc_5 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130399_TalentDesc_6 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130399_TalentDesc_7 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130399_TalentDesc_8 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130399_TalentDesc_9 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130399_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130399_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130399_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130399_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130399_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130399_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130399_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130399_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130399_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130399_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130399_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130399_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130400_TalentDesc_1 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「무변황영」이 가하는 힘 감소 효과와 획득하는 힘 배율이 [Arg3]% 증가하며, 발동할 때마다 다음 「염죄창봉」이 추가로 [Arg4]%의 힘 보너스를 받으며, 상한은 1200%입니다."
  },
  AwakerTalent_130400_TalentDesc_10 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「무변황영」이 가하는 힘 감소 효과와 획득하는 힘 배율이 [Arg3]% 증가하며, 발동할 때마다 다음 「염죄창봉」이 추가로 [Arg4]%의 힘 보너스를 받으며, 상한은 1200%입니다."
  },
  AwakerTalent_130400_TalentDesc_2 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「무변황영」이 가하는 힘 감소 효과와 획득하는 힘 배율이 [Arg3]% 증가하며, 발동할 때마다 다음 「염죄창봉」이 추가로 [Arg4]%의 힘 보너스를 받으며, 상한은 1200%입니다."
  },
  AwakerTalent_130400_TalentDesc_3 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「무변황영」이 가하는 힘 감소 효과와 획득하는 힘 배율이 [Arg3]% 증가하며, 발동할 때마다 다음 「염죄창봉」이 추가로 [Arg4]%의 힘 보너스를 받으며, 상한은 1200%입니다."
  },
  AwakerTalent_130400_TalentDesc_4 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「무변황영」이 가하는 힘 감소 효과와 획득하는 힘 배율이 [Arg3]% 증가하며, 발동할 때마다 다음 「염죄창봉」이 추가로 [Arg4]%의 힘 보너스를 받으며, 상한은 1200%입니다."
  },
  AwakerTalent_130400_TalentDesc_5 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「무변황영」이 가하는 힘 감소 효과와 획득하는 힘 배율이 [Arg3]% 증가하며, 발동할 때마다 다음 「염죄창봉」이 추가로 [Arg4]%의 힘 보너스를 받으며, 상한은 1200%입니다."
  },
  AwakerTalent_130400_TalentDesc_6 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「무변황영」이 가하는 힘 감소 효과와 획득하는 힘 배율이 [Arg3]% 증가하며, 발동할 때마다 다음 「염죄창봉」이 추가로 [Arg4]%의 힘 보너스를 받으며, 상한은 1200%입니다."
  },
  AwakerTalent_130400_TalentDesc_7 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「무변황영」이 가하는 힘 감소 효과와 획득하는 힘 배율이 [Arg3]% 증가하며, 발동할 때마다 다음 「염죄창봉」이 추가로 [Arg4]%의 힘 보너스를 받으며, 상한은 1200%입니다."
  },
  AwakerTalent_130400_TalentDesc_8 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「무변황영」이 가하는 힘 감소 효과와 획득하는 힘 배율이 [Arg3]% 증가하며, 발동할 때마다 다음 「염죄창봉」이 추가로 [Arg4]%의 힘 보너스를 받으며, 상한은 1200%입니다."
  },
  AwakerTalent_130400_TalentDesc_9 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「무변황영」이 가하는 힘 감소 효과와 획득하는 힘 배율이 [Arg3]% 증가하며, 발동할 때마다 다음 「염죄창봉」이 추가로 [Arg4]%의 힘 보너스를 받으며, 상한은 1200%입니다."
  },
  AwakerTalent_130400_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130400_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130400_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130400_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130400_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130400_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130400_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130400_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130400_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130400_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130918_TalentDesc_1 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130918_TalentDesc_10 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130918_TalentDesc_11 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130918_TalentDesc_12 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130918_TalentDesc_2 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130918_TalentDesc_3 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130918_TalentDesc_4 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130918_TalentDesc_5 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130918_TalentDesc_6 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130918_TalentDesc_7 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130918_TalentDesc_8 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130918_TalentDesc_9 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_130918_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130918_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130918_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130918_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130918_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130918_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130918_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130918_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130918_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130918_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130918_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130918_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_130919_TalentDesc_1 = {
    Text = "·해당 캐릭터가 팀에 있을 때, 「심해」 계역을 「회명·심해」 계역으로 교체합니다.\n·기본 촉수 피해가 팀 최대 HP의 5%로 변경됩니다.\n·탐색 시작 후 팀 피해 증폭 +50%, 팀이 심해 또는 카오스 깨어남체로만 구성된 경우 해당 효과로 얻는 피해 증폭이 2배가 되지만, 전투 시작 시 추가 촉수를 더 이상 획득하지 않습니다.\n·「촉수 집결」 효과를 더 이상 보유하지 않습니다.\n·촉수 자세가 「회명·촉수 자세」로 변경됩니다.\n·「회명·정해」: 최대 HP의 25% 방어막를 획득하고, 턴 종료 후 촉수가 더 이상 공격하지 않으며, 3턴 쿨다운.\n·「회명·노도」: 이번 턴 촉수 피해를 125%로 만들고, 능동 피해를 가한 후 촉수 1개가 공격하지만, 턴 종료 후 촉수 1개를 잃으며, 3턴 쿨다운.\n·계역 숙련이 「회명·심해 숙련」으로 변경되며, 계역 숙련 1포인트마다 「회명·정해」의 방어막가 최대 HP의 0.025% 증가하고, 「회명·노도」의 촉수 피해가 추가로 0.025% 증가합니다.\n·팀이 심해 또는 카오스 깨어남체로만 구성된 경우, 「회명·계역 숙련」 효과가 2배가 됩니다."
  },
  AwakerTalent_130919_TalentName_1 = {
    Text = "영원한 어둠의 땅"
  },
  AwakerTalent_130920_TalentDesc_1 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「소용돌이! 발사!」 고정 피해가 [Arg3]% 증가합니다.\n·모스가 광기 폭발을 발동하기 전에 대상의 「보강」과 「임시 보강」 효과를 제거하며, 제거에 성공하면 이번 광기 폭발의 치명타 피해 +[Arg4]%."
  },
  AwakerTalent_130920_TalentDesc_10 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「소용돌이! 발사!」 고정 피해가 [Arg3]% 증가합니다.\n·모스가 광기 폭발을 발동하기 전에 대상의 「보강」과 「임시 보강」 효과를 제거하며, 제거에 성공하면 이번 광기 폭발의 치명타 피해 +[Arg4]%."
  },
  AwakerTalent_130920_TalentDesc_2 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「소용돌이! 발사!」 고정 피해가 [Arg3]% 증가합니다.\n·모스가 광기 폭발을 발동하기 전에 대상의 「보강」과 「임시 보강」 효과를 제거하며, 제거에 성공하면 이번 광기 폭발의 치명타 피해 +[Arg4]%."
  },
  AwakerTalent_130920_TalentDesc_3 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「소용돌이! 발사!」 고정 피해가 [Arg3]% 증가합니다.\n·모스가 광기 폭발을 발동하기 전에 대상의 「보강」과 「임시 보강」 효과를 제거하며, 제거에 성공하면 이번 광기 폭발의 치명타 피해 +[Arg4]%."
  },
  AwakerTalent_130920_TalentDesc_4 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「소용돌이! 발사!」 고정 피해가 [Arg3]% 증가합니다.\n·모스가 광기 폭발을 발동하기 전에 대상의 「보강」과 「임시 보강」 효과를 제거하며, 제거에 성공하면 이번 광기 폭발의 치명타 피해 +[Arg4]%."
  },
  AwakerTalent_130920_TalentDesc_5 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「소용돌이! 발사!」 고정 피해가 [Arg3]% 증가합니다.\n·모스가 광기 폭발을 발동하기 전에 대상의 「보강」과 「임시 보강」 효과를 제거하며, 제거에 성공하면 이번 광기 폭발의 치명타 피해 +[Arg4]%."
  },
  AwakerTalent_130920_TalentDesc_6 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「소용돌이! 발사!」 고정 피해가 [Arg3]% 증가합니다.\n·모스가 광기 폭발을 발동하기 전에 대상의 「보강」과 「임시 보강」 효과를 제거하며, 제거에 성공하면 이번 광기 폭발의 치명타 피해 +[Arg4]%."
  },
  AwakerTalent_130920_TalentDesc_7 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「소용돌이! 발사!」 고정 피해가 [Arg3]% 증가합니다.\n·모스가 광기 폭발을 발동하기 전에 대상의 「보강」과 「임시 보강」 효과를 제거하며, 제거에 성공하면 이번 광기 폭발의 치명타 피해 +[Arg4]%."
  },
  AwakerTalent_130920_TalentDesc_8 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「소용돌이! 발사!」 고정 피해가 [Arg3]% 증가합니다.\n·모스가 광기 폭발을 발동하기 전에 대상의 「보강」과 「임시 보강」 효과를 제거하며, 제거에 성공하면 이번 광기 폭발의 치명타 피해 +[Arg4]%."
  },
  AwakerTalent_130920_TalentDesc_9 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「소용돌이! 발사!」 고정 피해가 [Arg3]% 증가합니다.\n·모스가 광기 폭발을 발동하기 전에 대상의 「보강」과 「임시 보강」 효과를 제거하며, 제거에 성공하면 이번 광기 폭발의 치명타 피해 +[Arg4]%."
  },
  AwakerTalent_130920_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130920_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130920_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130920_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130920_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130920_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130920_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130920_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130920_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_130920_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_131854_TalentDesc_1 = {
    Text = "· 사야가 파티에 있을 때, 혈육 영역이 「번식·혈육」 영역으로 교체된다.\n· 배아 융합: 매 턴 획득하는 배아 융합이 잃은 HP에 비례하여 50~100으로 증가하며, 배아 융합 상한이 100에서 200으로 증가한다. 상한에 도달하면 「번식·배아」를 손에 넣는다.\n· 번식·배아: 사용 시 더 이상 치명타율을 획득하지 않으며, 포식 시에도 더 이상 방어막과 임시 힘을 획득하지 않는다. 각 깨어남체가 매 턴 처음으로 「번식·배아」를 소모할 때, 40스택의 「번식 축전」을 획득한다.\n※ 「번식 축전」: 1스택당 해당 깨어남체의 이번 턴 다음 광기 폭발이 입히는 피해, 잠금 방어막, 잠금 HP 회복, 잠금 힘, 힘 감소, 촉수 피해 증가, 잠금 중독, 잠금 반격의 최종 효과가 1% 증가한다.\n· 핏빛 용광로: 턴 시작 시 자동 축적량이 잃은 HP의 10%로 변경되며, 최대 축적량이 최대 HP의 50%로 변경된다. 전투 종료 시 더 이상 축적되지 않으며, 사용 시 재사용 대기 시간 3턴이 존재한다.\n· 핏빛 침식: 핏빛 용광로 사용 후 모든 적에게 대상 최대 HP의 1%에 해당하는 침식 피해를 입힌다. 소모한 핏빛 용광로가 많을수록 침식 효과가 강해지며, 최대 100%까지 증가한다. 「빈 껍질」 적에게는 5배의 침식 피해를 입힌다.\n· 탐험 시작 후, 최대 HP가 10% 증가하고, 파티 피해 증폭 효과가 50% 증가하며, 매 턴 시작 시 모든 깨어남체가 20스택의 「번식 축전」을 획득한다. 파티가 혈육 또는 혼돈 깨어남체로만 구성된 경우, 이 효과로 획득하는 피해 증폭 효과가 2배로 증가한다.\n· 영역 숙련이 「번식·혈육 숙련」으로 변경되며, 영역 숙련 1pt당 「번식·혈육」이 획득하는 「번식 축전」이 0.05% 증가한다.\n· 파티가 혈육 또는 혼돈 깨어남체로만 구성된 경우, 「번식·혈육 숙련」 효과가 2배로 증가한다."
  },
  AwakerTalent_131854_TalentName_1 = {
    Text = "번식 정토"
  },
  AwakerTalent_132356_TalentDesc_1 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132356_TalentDesc_10 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132356_TalentDesc_11 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132356_TalentDesc_12 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132356_TalentDesc_2 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132356_TalentDesc_3 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132356_TalentDesc_4 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132356_TalentDesc_5 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132356_TalentDesc_6 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132356_TalentDesc_7 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132356_TalentDesc_8 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132356_TalentDesc_9 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132356_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132356_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132356_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132356_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132356_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132356_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132356_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132356_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132356_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132356_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132356_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132356_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132422_TalentDesc_1 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132422_TalentDesc_10 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132422_TalentDesc_11 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132422_TalentDesc_12 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132422_TalentDesc_2 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132422_TalentDesc_3 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132422_TalentDesc_4 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132422_TalentDesc_5 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132422_TalentDesc_6 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132422_TalentDesc_7 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132422_TalentDesc_8 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132422_TalentDesc_9 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132422_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132422_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132422_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132422_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132422_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132422_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132422_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132422_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132422_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132422_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132422_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132422_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132423_TalentDesc_1 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132423_TalentDesc_10 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132423_TalentDesc_11 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132423_TalentDesc_12 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132423_TalentDesc_2 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132423_TalentDesc_3 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132423_TalentDesc_4 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132423_TalentDesc_5 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132423_TalentDesc_6 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132423_TalentDesc_7 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132423_TalentDesc_8 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132423_TalentDesc_9 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132423_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132423_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132423_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132423_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132423_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132423_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132423_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132423_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132423_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132423_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132423_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132423_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132424_TalentDesc_1 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132424_TalentDesc_10 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132424_TalentDesc_11 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132424_TalentDesc_12 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132424_TalentDesc_2 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132424_TalentDesc_3 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132424_TalentDesc_4 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132424_TalentDesc_5 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132424_TalentDesc_6 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132424_TalentDesc_7 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132424_TalentDesc_8 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132424_TalentDesc_9 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_132424_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132424_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132424_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132424_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132424_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132424_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132424_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132424_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132424_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132424_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132424_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_132424_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_139506_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139506_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139506_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139506_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139506_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139506_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139506_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139506_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139506_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139506_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139507_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139507_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139507_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139507_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139507_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139507_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139507_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139507_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139507_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139507_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139508_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139508_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139508_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139508_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139508_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139508_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139508_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139508_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139508_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139508_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139509_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139509_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139509_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139509_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139509_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139509_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139509_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139509_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139509_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139509_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139510_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139510_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139510_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139510_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139510_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139510_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139510_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139510_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139510_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139510_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139511_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139511_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139511_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139511_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139511_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139511_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139511_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139511_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139511_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139511_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139512_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139512_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139512_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139512_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139512_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139512_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139512_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139512_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139512_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139512_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139513_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139513_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139513_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139513_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139513_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139513_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139513_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139513_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139513_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139513_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139514_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139514_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139514_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139514_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139514_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139514_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139514_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139514_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139514_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139514_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139515_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139515_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139515_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139515_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139515_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139515_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139515_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139515_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139515_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139515_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139517_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139517_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139517_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139517_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139517_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139517_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139517_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139517_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139517_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139517_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139518_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139518_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139518_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139518_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139518_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139518_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139518_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139518_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139518_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139518_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139519_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139519_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139519_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139519_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139519_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139519_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139519_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139519_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139519_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139519_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139520_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139520_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139520_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139520_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139520_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139520_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139520_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139520_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139520_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139520_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139521_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139521_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139521_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139521_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139521_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139521_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139521_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139521_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139521_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139521_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139522_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139522_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139522_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139522_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139522_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139522_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139522_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139522_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139522_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139522_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139523_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139523_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139523_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139523_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139523_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139523_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139523_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139523_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139523_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139523_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139524_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139524_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139524_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139524_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139524_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139524_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139524_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139524_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139524_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139524_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139525_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139525_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139525_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139525_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139525_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139525_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139525_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139525_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139525_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139525_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139526_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139526_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139526_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139526_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139526_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139526_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139526_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139526_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139526_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139526_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139527_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139527_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139527_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139527_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139527_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139527_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139527_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139527_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139527_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139527_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139528_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139528_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139528_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139528_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139528_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139528_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139528_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139528_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139528_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139528_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139529_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139529_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139529_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139529_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139529_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139529_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139529_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139529_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139529_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139529_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139530_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139530_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139530_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139530_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139530_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139530_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139530_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139530_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139530_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139530_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139531_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139531_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139531_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139531_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139531_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139531_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139531_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139531_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139531_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139531_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139532_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139532_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139532_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139532_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139532_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139532_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139532_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139532_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139532_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139532_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139533_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139533_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139533_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139533_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139533_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139533_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139533_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139533_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139533_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139533_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139535_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139535_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139535_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139535_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139535_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139535_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139535_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139535_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139535_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139535_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139536_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139536_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139536_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139536_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139536_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139536_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139536_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139536_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139536_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139536_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139537_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139537_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139537_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139537_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139537_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139537_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139537_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139537_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139537_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139537_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139538_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139538_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139538_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139538_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139538_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139538_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139538_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139538_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139538_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139538_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139539_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139539_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139539_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139539_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139539_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139539_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139539_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139539_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139539_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139539_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139540_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139540_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139540_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139540_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139540_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139540_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139540_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139540_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139540_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139540_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139541_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139541_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139541_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139541_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139541_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139541_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139541_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139541_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139541_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139541_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139542_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139542_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139542_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139542_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139542_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139542_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139542_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139542_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139542_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139542_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139543_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139543_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139543_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139543_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139543_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139543_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139543_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139543_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139543_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139543_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139544_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139544_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139544_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139544_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139544_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139544_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139544_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139544_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139544_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139544_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139545_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139545_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139545_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139545_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139545_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139545_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139545_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139545_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139545_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139545_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139546_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139546_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139546_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139546_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139546_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139546_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139546_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139546_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139546_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139546_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139547_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139547_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139547_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139547_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139547_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139547_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139547_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139547_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139547_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139547_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139548_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139548_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139548_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139548_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139548_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139548_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139548_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139548_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139548_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139548_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139549_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139549_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139549_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139549_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139549_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139549_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139549_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139549_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139549_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139549_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139550_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139550_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139550_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139550_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139550_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139550_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139550_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139550_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139550_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139550_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139551_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139551_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139551_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139551_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139551_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139551_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139551_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139551_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139551_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139551_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139552_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139552_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139552_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139552_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139552_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139552_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139552_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139552_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139552_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139552_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139553_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139553_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139553_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139553_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139553_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139553_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139553_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139553_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139553_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139553_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139555_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139555_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139555_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139555_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139555_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139555_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139555_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139555_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139555_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139555_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139556_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139556_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139556_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139556_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139556_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139556_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139556_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139556_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139556_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139556_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139557_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139557_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139557_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139557_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139557_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139557_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139557_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139557_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139557_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139557_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139558_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139558_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139558_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139558_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139558_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139558_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139558_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139558_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139558_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139558_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139559_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139559_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139559_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139559_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139559_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139559_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139559_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139559_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139559_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139559_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139560_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139560_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139560_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139560_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139560_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139560_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139560_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139560_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139560_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139560_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139561_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139561_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139561_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139561_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139561_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139561_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139561_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139561_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139561_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139561_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139562_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139562_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139562_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139562_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139562_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139562_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139562_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139562_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139562_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139562_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139563_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139563_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139563_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139563_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139563_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139563_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139563_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139563_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139563_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139563_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139564_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139564_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139564_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139564_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139564_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139564_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139564_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139564_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139564_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139564_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139565_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139565_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139565_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139565_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139565_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139565_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139565_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139565_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139565_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139565_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139566_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139566_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139566_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139566_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139566_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139566_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139566_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139566_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139566_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139566_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139567_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139567_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139567_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139567_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139567_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139567_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139567_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139567_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139567_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139567_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139568_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139568_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139568_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139568_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139568_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139568_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139568_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139568_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139568_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139568_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139569_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139569_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139569_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139569_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139569_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139569_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139569_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139569_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139569_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139569_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139570_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139570_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139570_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139570_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139570_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139570_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139570_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139570_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139570_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139570_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139571_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139571_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139571_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139571_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139571_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139571_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139571_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139571_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139571_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139571_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139572_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139572_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139572_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139572_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139572_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139572_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139572_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139572_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139572_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139572_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139573_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139573_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139573_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139573_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139573_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139573_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139573_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139573_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139573_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139573_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139574_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139574_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139574_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139574_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139574_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139574_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139574_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139574_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139574_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139574_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_139575_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139575_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139575_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139575_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139575_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_139575_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_139575_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_139575_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_139575_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_139575_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_141303_TalentDesc_1 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 효과가 있습니다. \n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점의 은열쇠 에너지를 획득합니다. \n·「폰토스」가 「환락의 권속」 적에게 가하는 잠금 피해가 [Arg3]% 증가합니다. \n·「끝없는 사냥」은 광기 10점을 소모할 때마다 [Arg4]% 공격력의 촉수 피해를 획득하고, 「요마 습격」은 피해를 줄 때 대상의 방어 [Arg5]%만큼의 힘을 임시로 감소시킵니다."
  },
  AwakerTalent_141303_TalentDesc_10 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 효과가 있습니다. \n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점의 은열쇠 에너지를 획득합니다. \n·「폰토스」가 「환락의 권속」 적에게 가하는 잠금 피해가 [Arg3]% 증가합니다. \n·「끝없는 사냥」은 광기 10점을 소모할 때마다 [Arg4]% 공격력의 촉수 피해를 획득하고, 「요마 습격」은 피해를 줄 때 대상의 방어 [Arg5]%만큼의 힘을 임시로 감소시킵니다."
  },
  AwakerTalent_141303_TalentDesc_2 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 효과가 있습니다. \n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점의 은열쇠 에너지를 획득합니다. \n·「폰토스」가 「환락의 권속」 적에게 가하는 잠금 피해가 [Arg3]% 증가합니다. \n·「끝없는 사냥」은 광기 10점을 소모할 때마다 [Arg4]% 공격력의 촉수 피해를 획득하고, 「요마 습격」은 피해를 줄 때 대상의 방어 [Arg5]%만큼의 힘을 임시로 감소시킵니다."
  },
  AwakerTalent_141303_TalentDesc_3 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 효과가 있습니다. \n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점의 은열쇠 에너지를 획득합니다. \n·「폰토스」가 「환락의 권속」 적에게 가하는 잠금 피해가 [Arg3]% 증가합니다. \n·「끝없는 사냥」은 광기 10점을 소모할 때마다 [Arg4]% 공격력의 촉수 피해를 획득하고, 「요마 습격」은 피해를 줄 때 대상의 방어 [Arg5]%만큼의 힘을 임시로 감소시킵니다."
  },
  AwakerTalent_141303_TalentDesc_4 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 효과가 있습니다. \n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점의 은열쇠 에너지를 획득합니다. \n·「폰토스」가 「환락의 권속」 적에게 가하는 잠금 피해가 [Arg3]% 증가합니다. \n·「끝없는 사냥」은 광기 10점을 소모할 때마다 [Arg4]% 공격력의 촉수 피해를 획득하고, 「요마 습격」은 피해를 줄 때 대상의 방어 [Arg5]%만큼의 힘을 임시로 감소시킵니다."
  },
  AwakerTalent_141303_TalentDesc_5 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 효과가 있습니다. \n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점의 은열쇠 에너지를 획득합니다. \n·「폰토스」가 「환락의 권속」 적에게 가하는 잠금 피해가 [Arg3]% 증가합니다. \n·「끝없는 사냥」은 광기 10점을 소모할 때마다 [Arg4]% 공격력의 촉수 피해를 획득하고, 「요마 습격」은 피해를 줄 때 대상의 방어 [Arg5]%만큼의 힘을 임시로 감소시킵니다."
  },
  AwakerTalent_141303_TalentDesc_6 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 효과가 있습니다. \n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점의 은열쇠 에너지를 획득합니다. \n·「폰토스」가 「환락의 권속」 적에게 가하는 잠금 피해가 [Arg3]% 증가합니다. \n·「끝없는 사냥」은 광기 10점을 소모할 때마다 [Arg4]% 공격력의 촉수 피해를 획득하고, 「요마 습격」은 피해를 줄 때 대상의 방어 [Arg5]%만큼의 힘을 임시로 감소시킵니다."
  },
  AwakerTalent_141303_TalentDesc_7 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 효과가 있습니다. \n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점의 은열쇠 에너지를 획득합니다. \n·「폰토스」가 「환락의 권속」 적에게 가하는 잠금 피해가 [Arg3]% 증가합니다. \n·「끝없는 사냥」은 광기 10점을 소모할 때마다 [Arg4]% 공격력의 촉수 피해를 획득하고, 「요마 습격」은 피해를 줄 때 대상의 방어 [Arg5]%만큼의 힘을 임시로 감소시킵니다."
  },
  AwakerTalent_141303_TalentDesc_8 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 효과가 있습니다. \n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점의 은열쇠 에너지를 획득합니다. \n·「폰토스」가 「환락의 권속」 적에게 가하는 잠금 피해가 [Arg3]% 증가합니다. \n·「끝없는 사냥」은 광기 10점을 소모할 때마다 [Arg4]% 공격력의 촉수 피해를 획득하고, 「요마 습격」은 피해를 줄 때 대상의 방어 [Arg5]%만큼의 힘을 임시로 감소시킵니다."
  },
  AwakerTalent_141303_TalentDesc_9 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 효과가 있습니다. \n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점의 은열쇠 에너지를 획득합니다. \n·「폰토스」가 「환락의 권속」 적에게 가하는 잠금 피해가 [Arg3]% 증가합니다. \n·「끝없는 사냥」은 광기 10점을 소모할 때마다 [Arg4]% 공격력의 촉수 피해를 획득하고, 「요마 습격」은 피해를 줄 때 대상의 방어 [Arg5]%만큼의 힘을 임시로 감소시킵니다."
  },
  AwakerTalent_141303_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_141303_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_141303_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_141303_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_141303_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_141303_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_141303_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_141303_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_141303_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_141303_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_141304_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_141304_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_141304_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_141304_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_141304_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_141304_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_141304_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_141304_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_141304_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_141304_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_141304_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_141304_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_141304_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_141304_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_141304_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_141304_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_141304_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_141304_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_141304_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_141304_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_141304_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_141304_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_141304_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_141304_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_141305_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_141305_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_141305_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_141305_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_141305_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_141305_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_141305_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_141305_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_141305_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_141305_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_143615_TalentDesc_1 = {
    Text = "·해당 캐릭터가 팀에 있을 때, 「심해」 계역을 「회명·심해」 계역으로 교체합니다.\n·기본 촉수 피해가 팀 최대 HP의 5%로 변경됩니다.\n·탐색 시작 후 팀 피해 증폭 +50%, 팀이 심해 또는 카오스 깨어남체로만 구성된 경우 해당 효과로 얻는 피해 증폭이 2배가 되지만, 전투 시작 시 추가 촉수를 더 이상 획득하지 않습니다.\n·「촉수 집결」 효과를 더 이상 보유하지 않습니다.\n·촉수 자세가 「회명·촉수 자세」로 변경됩니다.\n·「회명·정해」: 최대 HP의 25% 방어막를 획득하고, 턴 종료 후 촉수가 더 이상 공격하지 않으며, 3턴 쿨다운.\n·「회명·노도」: 이번 턴 촉수 피해를 125%로 만들고, 능동 피해를 가한 후 촉수 1개가 공격하지만, 턴 종료 후 촉수 1개를 잃으며, 3턴 쿨다운.\n·계역 숙련이 「회명·심해 숙련」으로 변경되며, 계역 숙련 1포인트마다 「회명·정해」의 방어막가 최대 HP의 0.025% 증가하고, 「회명·노도」의 촉수 피해가 추가로 0.025% 증가합니다.\n·팀이 심해 또는 카오스 깨어남체로만 구성된 경우, 「회명·계역 숙련」 효과가 2배가 됩니다."
  },
  AwakerTalent_143615_TalentName_1 = {
    Text = "영원한 어둠의 땅"
  },
  AwakerTalent_145379_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_145379_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_145379_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_145379_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_145379_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_145379_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_145379_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_145379_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_145379_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_145379_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_145380_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_145380_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_145380_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_145380_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_145380_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_145380_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_145380_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_145380_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_145380_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_145380_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_145380_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_145380_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_145380_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_145380_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_145380_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_145380_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_145380_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_145380_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_145380_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_145380_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_145380_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_145380_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_145380_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_145380_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_145381_TalentDesc_1 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「경계를 베는 검」은 추가로 [Arg3]% 힘 보너스를 받으며, 적 처치 후 [Arg4] 검은 인장을 획득하고, 자신의 검은 인장 드롭율 보너스를 받으며, 전투당 최대 1회 발동됩니다."
  },
  AwakerTalent_145381_TalentDesc_10 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「경계를 베는 검」은 추가로 [Arg3]% 힘 보너스를 받으며, 적 처치 후 [Arg4] 검은 인장을 획득하고, 자신의 검은 인장 드롭율 보너스를 받으며, 전투당 최대 1회 발동됩니다."
  },
  AwakerTalent_145381_TalentDesc_2 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「경계를 베는 검」은 추가로 [Arg3]% 힘 보너스를 받으며, 적 처치 후 [Arg4] 검은 인장을 획득하고, 자신의 검은 인장 드롭율 보너스를 받으며, 전투당 최대 1회 발동됩니다."
  },
  AwakerTalent_145381_TalentDesc_3 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「경계를 베는 검」은 추가로 [Arg3]% 힘 보너스를 받으며, 적 처치 후 [Arg4] 검은 인장을 획득하고, 자신의 검은 인장 드롭율 보너스를 받으며, 전투당 최대 1회 발동됩니다."
  },
  AwakerTalent_145381_TalentDesc_4 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「경계를 베는 검」은 추가로 [Arg3]% 힘 보너스를 받으며, 적 처치 후 [Arg4] 검은 인장을 획득하고, 자신의 검은 인장 드롭율 보너스를 받으며, 전투당 최대 1회 발동됩니다."
  },
  AwakerTalent_145381_TalentDesc_5 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「경계를 베는 검」은 추가로 [Arg3]% 힘 보너스를 받으며, 적 처치 후 [Arg4] 검은 인장을 획득하고, 자신의 검은 인장 드롭율 보너스를 받으며, 전투당 최대 1회 발동됩니다."
  },
  AwakerTalent_145381_TalentDesc_6 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「경계를 베는 검」은 추가로 [Arg3]% 힘 보너스를 받으며, 적 처치 후 [Arg4] 검은 인장을 획득하고, 자신의 검은 인장 드롭율 보너스를 받으며, 전투당 최대 1회 발동됩니다."
  },
  AwakerTalent_145381_TalentDesc_7 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「경계를 베는 검」은 추가로 [Arg3]% 힘 보너스를 받으며, 적 처치 후 [Arg4] 검은 인장을 획득하고, 자신의 검은 인장 드롭율 보너스를 받으며, 전투당 최대 1회 발동됩니다."
  },
  AwakerTalent_145381_TalentDesc_8 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「경계를 베는 검」은 추가로 [Arg3]% 힘 보너스를 받으며, 적 처치 후 [Arg4] 검은 인장을 획득하고, 자신의 검은 인장 드롭율 보너스를 받으며, 전투당 최대 1회 발동됩니다."
  },
  AwakerTalent_145381_TalentDesc_9 = {
    Text = "·해당 특성은 「별의 시대」 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「경계를 베는 검」은 추가로 [Arg3]% 힘 보너스를 받으며, 적 처치 후 [Arg4] 검은 인장을 획득하고, 자신의 검은 인장 드롭율 보너스를 받으며, 전투당 최대 1회 발동됩니다."
  },
  AwakerTalent_145381_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_145381_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_145381_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_145381_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_145381_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_145381_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_145381_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_145381_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_145381_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_145381_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_145718_TalentDesc_1 = {
    Text = "·카라브가 팀에 있을 때, 「혈육」 경계역을 「번식·혈육」 경계역으로 대체합니다.\n·배아 융합：매 회전마다 획득하는 배아 융합이 50~100으로 증가하며, 잃은 생명에 따라 높아지지만 배아 융합 상한이 100에서 200으로 증가하고, 상한에 도달하면 「번식·배아」를 손에 넣습니다.\n·번식 배아：사용 시 더 이상 치명타율을 획득하지 않으며, 흡수 시에도 더 이상 보호막과 임시 힘을 획득하지 않습니다. 각 깨어남체가 매 회전 처음으로 「번식·배아」를 소모할 때, 40층의 「번식 축제」를 획득합니다：1층을 보유할 때마다 해당 깨어남체의 이번 회전 다음 광기 폭발이 가하는 피해, 잠금 보호막, 잠금 생명 회복, 잠금 힘, 힘 감소, 촉완 피해 증가, 잠금 중독, 잠금 반격의 최종 효과가 1% 증가합니다.\n·진홍 용광로：회전 시작 시 자동 축적량이 이미 잃은 생명의 10%로 변경되며, 최대 축적량이 최대 생명의 50%로 변경됩니다. 전투 종료 시 더 이상 축적되지 않으며, 사용 시 3회전 쿨다운이 있습니다.\n·진홍 침식：진홍 용광로 사용 후 모든 적에게 대상 최대 생명의 1% 침식을 가하며, 소모한 진홍 용광로가 많을수록 침식 효과가 강해지고 최대 100% 증가합니다. 「빈 껍데기」 적에게는 5배의 침식 효과를 가합니다.\n·탐색 시작 후, 최대 생명이 10% 증가하고, 팀 피해 강화 +50%가 적용되며, 매 회전 시작 시 모든 깨어남체가 20층의 「번식 축제」를 획득합니다. 팀이 혈육 또는 혼돈 깨어남체로만 구성된 경우, 해당 효과로 획득하는 피해 강화가 두 배가 됩니다.\n·경계역 숙련이 「번식·혈육 숙련」으로 변경되며, 경계역 숙련 1포인트마다 「번식·혈육」에서 획득하는 「번식 축제」가 0.05% 증가합니다. \n·팀이 혈육 또는 혼돈 깨어남체로만 구성된 경우, 「번식·혈육 숙련」 효과가 두 배가 됩니다."
  },
  AwakerTalent_145718_TalentName_1 = {
    Text = "번식 정토"
  },
  AwakerTalent_146937_TalentDesc_1 = {
    Text = "·침식·로탄이 팀에 있을 때, 「혼돈」 영역을 「원초·혼돈」 영역으로 교체합니다.\n·원초 주입: 기본 은열쇠 에너지가 2000포인트로 증가하고, 팀 피해 증폭 +50%, 모든 각성체의 공격과 방어가 10% 증가합니다. 팀이 혼돈 각성체로만 구성된 경우, 해당 효과로 얻은 피해 증폭이 2배가 됩니다. 전투 시작 시, 은열쇠 에너지 2000포인트를 획득합니다.\n·만열의 근원: 모든 각성체의 은열쇠 충전 레벨이 팀 평균값으로 변경됩니다. 또한 행동력 소비에 따른 은열쇠 에너지를 더 이상 획득하지 않으며, 대신 각 각성체가 매 턴 첫 번째 명령 카드 사용 시 「해당 각성체 은열쇠 충전×3+100」의 은열쇠 에너지를 획득합니다.\n·나뉘지 않은 경계: 다른 영역의 순수 초차원 영역, 숙련 효과 2배, 증폭 2배 효과를 더 이상 발동하지 않습니다.\n·원초의 메아리: 영지 각성 시 예비 1을 획득하며, 매 턴 첫 번째 사용 시 보유한 은열쇠를 자동으로 발동합니다.\n·기억의 파편: 은열쇠가 「원초·쌍생의 재현」과 「원초·삼상의 계시」로 교체되며, 본래 보유한 은열쇠는 발동할 수 없습니다.\n·원초 · 쌍생의 재현: 보유한 은열쇠 중에서 3종류의 은열쇠를 발견하고, 1개의 은열쇠를 선택하여 2회 발동합니다.\n·원초 · 삼상의 계시: 보유한 은열쇠 중에서 3그룹의 은열쇠를 발견하며, 각 그룹은 3종류의 서로 다른 은열쇠로 구성됩니다. 한 그룹을 선택하여 그 안의 은열쇠를 순서대로 각 1회 발동합니다.\n·원초·쌍생의 재현과 원초·삼상의 계시에 포함된 은열쇠는 여덟 종류의 「원초의 기억」을 포함합니다.\n·원초·쌍생의 재현과 원초·삼상의 계시는 은열쇠 1회 발동으로만 간주되며, 여러 번 발동될 때 첫 번째로 발동되는 은열쇠에만 적용됩니다.\n·영역 숙련이 「원초·혼돈 숙련도」로 변경되며, 영역 숙련 1포인트마다 은열쇠 강도가 0.05% 증가합니다.\n·은열쇠 강도 1포인트마다 은열쇠가 가하는 고정 중독, 고정 반격, 고정 힘, 고정 촉수 피해, 고정 옛날 잔재를 2% 증가시키고, 고정 방어막, 고정 HP 회복, 힘 감소, 치명타율, 치명타 피해, 피해 증폭, 영역 숙련, 광기, 배아 융합, 은열쇠 에너지를 1% 증가시킵니다.\n·팀이 혼돈 각성체로만 구성된 경우, 「원초·혼돈 숙련도」 효과가 2배가 됩니다."
  },
  AwakerTalent_146937_TalentName_1 = {
    Text = "원초의 숨결"
  },
  AwakerTalent_147414_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_147414_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_147414_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_147414_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_147414_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_147414_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_147414_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_147414_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_147414_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_147414_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_147414_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_147414_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_147414_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_147414_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_147414_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_147414_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_147414_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_147414_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_147414_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_147414_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_147415_TalentDesc_1 = {
    Text = "· 틴커트 자신, 장착한 명륜 및 비밀 계약의 검은 인장 드롭율 1%마다, 「별빛의 오로라」가 부여하는 임시 크리티컬 확률이 0.3% 증가합니다."
  },
  AwakerTalent_147415_TalentName_1 = {
    Text = "행성 여행자"
  },
  AwakerTalent_147416_TalentDesc_1 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_147416_TalentDesc_2 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_147416_TalentDesc_3 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_147416_TalentDesc_4 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_147416_TalentDesc_5 = {
    Text = "해당 깨어남체의 속성이 [Arg1] 등급만큼 상승합니다.\n   ·체질 증가 [Talent_Attr_Lv_physique] \n   ·공격 증가 [Talent_Attr_Lv_atk] \n   ·방어 증가 [Talent_Attr_Lv_def]"
  },
  AwakerTalent_147416_TalentName_1 = {
    Text = "내재 영격"
  },
  AwakerTalent_147416_TalentName_2 = {
    Text = "내재 영격"
  },
  AwakerTalent_147416_TalentName_3 = {
    Text = "내재 영격"
  },
  AwakerTalent_147416_TalentName_4 = {
    Text = "내재 영격"
  },
  AwakerTalent_147416_TalentName_5 = {
    Text = "내재 영격"
  },
  AwakerTalent_147417_TalentDesc_1 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_147417_TalentDesc_10 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_147417_TalentDesc_11 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_147417_TalentDesc_12 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_147417_TalentDesc_2 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_147417_TalentDesc_3 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_147417_TalentDesc_4 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_147417_TalentDesc_5 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_147417_TalentDesc_6 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_147417_TalentDesc_7 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_147417_TalentDesc_8 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_147417_TalentDesc_9 = {
    Text = "탐색 시작 후, [Arg1] 광기를 획득합니다."
  },
  AwakerTalent_147417_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_147417_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_147417_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_147417_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_147417_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_147417_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_147417_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_147417_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_147417_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_147417_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_147417_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_147417_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44844_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44844_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44844_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44844_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44844_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44844_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44844_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44844_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44844_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44844_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44844_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44844_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44844_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44844_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44844_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44844_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44844_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44844_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44844_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44844_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44844_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44844_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44844_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44844_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44845_TalentDesc_1 = {
    Text = "· 릴리 자신, 장착한 명륜 및 비밀 계약의 죽음 저항 1%마다,「금지된 검은 늪」과「방어」로 생성하는 기본 방어막이 0.25% 증가하며, 보스 전투 시 인내의 축적량과 최대치가 0.25% 증가합니다.\n· 팀에 릴리가 있을 때, HP 1을 잃을 때마다 인내 1 스택을 축적합니다. 인내의 최대 스택은 최대 HP와 동일합니다."
  },
  AwakerTalent_44845_TalentName_1 = {
    Text = "넘실타래거리는 검은빛"
  },
  AwakerTalent_44846_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44846_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44846_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44846_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44846_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44846_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44846_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44846_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44846_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44846_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44846_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44846_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44846_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44846_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44846_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44846_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44846_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44846_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44846_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44846_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44846_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44846_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44846_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44846_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44847_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44847_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44847_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44847_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44847_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44847_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44847_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44847_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44847_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44847_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44847_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44847_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44847_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44847_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44847_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44847_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44847_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44847_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44847_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44847_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44847_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44847_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44847_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44847_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44848_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44848_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44848_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44848_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44848_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44848_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44848_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44848_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44848_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44848_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44848_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44848_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44848_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44848_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44848_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44848_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44848_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44848_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44848_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44848_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44848_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44848_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44848_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44848_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44849_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44849_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44849_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44849_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44849_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44849_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44849_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44849_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44849_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44849_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44849_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44849_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44849_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44849_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44849_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44849_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44849_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44849_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44849_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44849_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44849_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44849_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44849_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44849_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44850_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44850_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44850_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44850_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44850_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44850_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44850_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44850_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44850_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44850_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44850_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44850_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44850_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44850_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44850_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44850_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44850_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44850_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44850_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44850_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44850_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44850_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44850_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44850_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44851_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44851_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44851_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44851_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44851_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44851_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44851_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44851_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44851_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44851_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44851_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44851_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44851_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44851_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44851_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44851_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44851_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44851_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44851_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44851_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44851_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44851_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44851_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44851_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44852_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44852_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44852_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44852_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44852_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44852_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44852_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44852_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44852_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44852_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44852_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44852_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44852_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44852_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44852_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44852_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44852_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44852_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44852_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44852_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44852_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44852_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44852_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44852_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44853_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44853_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44853_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44853_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44853_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44853_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44853_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44853_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44853_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44853_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44853_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44853_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44853_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44853_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44853_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44853_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44853_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44853_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44853_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44853_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44853_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44853_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44853_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44853_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44854_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44854_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44854_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44854_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44854_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44854_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44854_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44854_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44854_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44854_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44854_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44854_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44854_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44854_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44854_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44854_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44854_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44854_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44854_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44854_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44854_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44854_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44854_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44854_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44855_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44855_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44855_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44855_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44855_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44855_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44855_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44855_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44855_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44855_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44855_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44855_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44855_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44855_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44855_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44855_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44855_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44855_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44855_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44855_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44855_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44855_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44855_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44855_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44856_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44856_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44856_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44856_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44856_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44856_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44856_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44856_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44856_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44856_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44856_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44856_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44856_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44856_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44856_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44856_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44856_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44856_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44856_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44856_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44856_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44856_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44856_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44856_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44857_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44857_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44857_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44857_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44857_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44857_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44857_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44857_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44857_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44857_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44857_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44857_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44857_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44857_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44857_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44857_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44857_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44857_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44857_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44857_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44857_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44857_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44857_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44857_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44858_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44858_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44858_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44858_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44858_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44858_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44858_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44858_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44858_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44858_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44858_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44858_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44858_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44858_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44858_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44858_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44858_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44858_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44858_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44858_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44858_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44858_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44858_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44858_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44859_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44859_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44859_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44859_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44859_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44859_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44859_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44859_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44859_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44859_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44859_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44859_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44859_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44859_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44859_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44859_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44859_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44859_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44859_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44859_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44859_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44859_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44859_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44859_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44860_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44860_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44860_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44860_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44860_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44860_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44860_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44860_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44860_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44860_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44860_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44860_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44860_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44860_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44860_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44860_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44860_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44860_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44860_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44860_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44860_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44860_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44860_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44860_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44861_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44861_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44861_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44861_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44861_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44861_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44861_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44861_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44861_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44861_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44861_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44861_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44861_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44861_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44861_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44861_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44861_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44861_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44861_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44861_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44861_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44861_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44861_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44861_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44862_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44862_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44862_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44862_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44862_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44862_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44862_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44862_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44862_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44862_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44862_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44862_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44862_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44862_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44862_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44862_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44862_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44862_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44862_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44862_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44862_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44862_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44862_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44862_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44863_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44863_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44863_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44863_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44863_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44863_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44863_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44863_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44863_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44863_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44863_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44863_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44863_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44863_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44863_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44863_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44863_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44863_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44863_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44863_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44863_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44863_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44863_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44863_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44865_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44865_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44865_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44865_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44865_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44865_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44865_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44865_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44865_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44865_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44865_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44865_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44865_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44865_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44865_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44865_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44865_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44865_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44865_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44865_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44865_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44865_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44865_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44865_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44866_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44866_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44866_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44866_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44866_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44866_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44866_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44866_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44866_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44866_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44866_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44866_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44866_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44866_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44866_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44866_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44866_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44866_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44866_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44866_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44866_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44866_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44866_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44866_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44867_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44867_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44867_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44867_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44867_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44867_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44867_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44867_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44867_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44867_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44867_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44867_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44867_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44867_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44867_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44867_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44867_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44867_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44867_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44867_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44867_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44867_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44867_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44867_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44868_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44868_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44868_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44868_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44868_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44868_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44868_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44868_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44868_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44868_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44868_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44868_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44868_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44868_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44868_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44868_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44868_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44868_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44868_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44868_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44868_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44868_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44868_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44868_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44869_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44869_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44869_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44869_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44869_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44869_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44869_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44869_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44869_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44869_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44869_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44869_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44869_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44869_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44869_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44869_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44869_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44869_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44869_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44869_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44869_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44869_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44869_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44869_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44870_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44870_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44870_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44870_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44870_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44870_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44870_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44870_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44870_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44870_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44870_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44870_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44870_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44870_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44870_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44870_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44870_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44870_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44870_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44870_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44870_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44870_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44870_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44870_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44871_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44871_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44871_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44871_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44871_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44871_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44871_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44871_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44871_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44871_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44871_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44871_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44871_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44871_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44871_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44871_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44871_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44871_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44871_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44871_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44871_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44871_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44871_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44871_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44873_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44873_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44873_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44873_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44873_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44873_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44873_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44873_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44873_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44873_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44873_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44873_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44873_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44873_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44873_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44873_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44873_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44873_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44873_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44873_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44873_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44873_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44873_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44873_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44874_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44874_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44874_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44874_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44874_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44874_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44874_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44874_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44874_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44874_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44874_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44874_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44874_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44874_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44874_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44874_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44874_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44874_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44874_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44874_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44874_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44874_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44874_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44874_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44875_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44875_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44875_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44875_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44875_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44875_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44875_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44875_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44875_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44875_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44875_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44875_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44875_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44875_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44875_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44875_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44875_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44875_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44875_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44875_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44875_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44875_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44875_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44875_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44876_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44876_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44876_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44876_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44876_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44876_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44876_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44876_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44876_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44876_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44876_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44876_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44876_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44876_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44876_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44876_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44876_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44876_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44876_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44876_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44876_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44876_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44876_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44876_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44877_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44877_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44877_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44877_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44877_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44877_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44877_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44877_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44877_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44877_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44877_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44877_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44877_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44877_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44877_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44877_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44877_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44877_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44877_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44877_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44877_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44877_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44877_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44877_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44878_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44878_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44878_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44878_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44878_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44878_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44878_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44878_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44878_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44878_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44878_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44878_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44878_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44878_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44878_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44878_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44878_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44878_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44878_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44878_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44878_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44878_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44878_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44878_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44879_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44879_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44879_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44879_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44879_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44879_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44879_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44879_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44879_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44879_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44879_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44879_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44879_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44879_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44879_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44879_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44879_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44879_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44879_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44879_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44879_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44879_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44879_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44879_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44880_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44880_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44880_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44880_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44880_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44880_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44880_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44880_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44880_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44880_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44880_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44880_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44880_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44880_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44880_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44880_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44880_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44880_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44880_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44880_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44880_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44880_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44880_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44880_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44881_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44881_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44881_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44881_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44881_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44881_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44881_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44881_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44881_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44881_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44881_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44881_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44881_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44881_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44881_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44881_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44881_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44881_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44881_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44881_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44881_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44881_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44881_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44881_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44882_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44882_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44882_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44882_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44882_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44882_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44882_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44882_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44882_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44882_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44882_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44882_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44882_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44882_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44882_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44882_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44882_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44882_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44882_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44882_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44882_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44882_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44882_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44882_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44883_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44883_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44883_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44883_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44883_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44883_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44883_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44883_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44883_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44883_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44883_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44883_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44883_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44883_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44883_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44883_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44883_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44883_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44883_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44883_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44883_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44883_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44883_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44883_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44884_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44884_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44884_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44884_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44884_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44884_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44884_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44884_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44884_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44884_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44884_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44884_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44884_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44884_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44884_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44884_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44884_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44884_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44884_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44884_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44884_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44884_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44884_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44884_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44885_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44885_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44885_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44885_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44885_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44885_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44885_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44885_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44885_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44885_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44885_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44885_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44885_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44885_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44885_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44885_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44885_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44885_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44885_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44885_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44885_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44885_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44885_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44885_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44886_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44886_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44886_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44886_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44886_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44886_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44886_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44886_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44886_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44886_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44886_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44886_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44886_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44886_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44886_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44886_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44886_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44886_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44886_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44886_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44886_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44886_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44886_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44886_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44887_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44887_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44887_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44887_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44887_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44887_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44887_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44887_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44887_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44887_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44887_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44887_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44887_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44887_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44887_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44887_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44887_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44887_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44887_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44887_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44887_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44887_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44887_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44887_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44888_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44888_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44888_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44888_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44888_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44888_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44888_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44888_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44888_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44888_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44888_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44888_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_44888_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44888_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44888_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44888_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44888_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44888_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44888_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44888_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44888_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44888_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44888_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_44888_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_46162_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_46162_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_46162_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_46162_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_46162_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_46162_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_46162_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_46162_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_46162_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_46162_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_46162_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_46162_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_46162_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_46162_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_46162_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_46162_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_46162_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_46162_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_46162_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_46162_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_46162_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_46162_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_46162_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_46162_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_46445_TalentDesc_1 = {
    Text = "· 살바도르의 핏빛 용광로 충전 효과는 HP 회복량 증가 효과에 따라 증가합니다."
  },
  AwakerTalent_46445_TalentName_1 = {
    Text = "영혼의 목자"
  },
  AwakerTalent_46446_TalentDesc_1 = {
    Text = "· 라모나는 은열쇠 충전 속성을 추가로 2.5 획득한다. 동조율 레벨 1마다 라모나는 은열쇠 충전 속성을 추가로 0.5 획득한다.\n· 은열쇠 충전 레벨 속성 1마다 「여왕의 검」의 기본 피해가 1% 증가하고, 사용 후 임시 영역 숙련을 0.75만큼 획득한다."
  },
  AwakerTalent_46446_TalentName_1 = {
    Text = "심장과 은의 공명"
  },
  AwakerTalent_46487_TalentDesc_1 = {
    Text = "· 회귀·라모나의 은열쇠 충전이 2.5 증가합니다. 라모나의 동조율 레벨 1마다 은열쇠 충전이 0.5 증가합니다.\n·은열쇠 충전 1마다, 「타격」의 회귀 효과로 회귀·라모나가 0.2%의 크리티컬 확률을 얻고, 「방어」의 회귀 효과로 회귀·라모나가 0.2 광기를 획득합니다."
  },
  AwakerTalent_46487_TalentName_1 = {
    Text = "심장과 은의 공명"
  },
  AwakerTalent_49872_TalentDesc_1 = {
    Text = "·노틸라의 영역 숙련 1마다, 「출전 준비 완료」로 획득하는 반격이 0.25% 증가합니다."
  },
  AwakerTalent_49872_TalentName_1 = {Text = "점검"},
  AwakerTalent_49873_TalentDesc_1 = {
    Text = "· 님피아의 피해 증폭 1%마다, 「장례의 종소리」와 「자아의 장례식」이 부여하는 기본 중독 효과가 0.5% 증가합니다."
  },
  AwakerTalent_49873_TalentName_1 = {
    Text = "침식과 감염"
  },
  AwakerTalent_51744_TalentDesc_1 = {
    Text = "· 전투 시작 시,「집착」 1장을 손패에 추가합니다.\n· 미리암의「기본 타격」에는 100% 촉수 피해 계수가 적용됩니다.\n· 미리암 자신, 장착한 명륜 및 비밀 계약의 크리티컬 피해 1%마다, 광기 폭발이 생성하는 힘, 촉수 피해, 광기, 중독 부여량과 발동 비율이 0.2% 상승합니다."
  },
  AwakerTalent_51744_TalentName_1 = {
    Text = "불멸의 신앙"
  },
  AwakerTalent_52071_TalentDesc_1 = {
    Text = "· 툴루 자신에게 장착한 명륜 및 비밀계약의 광기 충전 레벨 1pt마다, 「타격」에 촉수 피해와 힘 보너스가 5% 추가되며, 「심연의 호령」에는 촉수 피해와 힘 보너스가 15% 추가된다."
  },
  AwakerTalent_52071_TalentName_1 = {
    Text = "신왕의 권능"
  },
  AwakerTalent_52086_TalentDesc_1 = {
    Text = "· 산 자신, 장착한 명륜과 비밀 계약의 죽음 저항 1%마다, 「타격」과「방어」로 획득하는 광기가 0.03 상승하고,「잊혀진 예술」에 추가로 0.15% 크리티컬 확률과 크리티컬 피해 보너스가 적용됩니다."
  },
  AwakerTalent_52086_TalentName_1 = {
    Text = "죽음의 영감"
  },
  AwakerTalent_54047_TalentDesc_1 = {
    Text = "· 돌이 보유하고 있는 광기 충전 레벨 1pt마다, 「외계 수술」과 「등가 교환」의 HP 회복 효과가 0.5% 상승한다."
  },
  AwakerTalent_54047_TalentName_1 = {
    Text = "영지 해체"
  },
  AwakerTalent_54072_TalentDesc_1 = {
    Text = "· 오지에가 검은 인장 드롭률을 1% 보유할 때마다, 「칠예, 전승된 미덕」으로 획득하는 임시 힘이 3% 증가한다."
  },
  AwakerTalent_54072_TalentName_1 = {
    Text = "무형의 정련"
  },
  AwakerTalent_54073_TalentDesc_1 = {
    Text = "· 엘바의 죽음 저항 1%마다 기본 피해가 0.5% 증가합니다."
  },
  AwakerTalent_54073_TalentName_1 = {
    Text = "유연한 시야"
  },
  AwakerTalent_54119_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54119_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54119_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54119_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54119_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54119_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54119_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54119_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54119_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54119_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54119_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54119_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54119_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54119_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54119_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54119_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54119_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54119_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54119_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54119_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54119_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54119_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54119_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54119_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54120_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54120_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54120_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54120_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54120_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54120_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54120_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54120_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54120_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54120_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54120_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54120_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_54120_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54120_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54120_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54120_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54120_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54120_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54120_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54120_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54120_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54120_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54120_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54120_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_54158_TalentDesc_1 = {
    Text = "· 소렐 자신, 장착한 명륜 및 비밀 계약의 크리티컬 확률 1%마다,「방어」로 획득하는 광기가 0.2 증가합니다."
  },
  AwakerTalent_54158_TalentName_1 = {
    Text = "화려함의 수호자"
  },
  AwakerTalent_55109_TalentDesc_1 = {
    Text = "· 젠킨 자신, 장착한 명륜 및 비밀 계약의 크리티컬 확률 1%마다, 「타격」과 「브라운 출동!」의 기본 피해가 2% 증가합니다."
  },
  AwakerTalent_55109_TalentName_1 = {
    Text = "공동의 적"
  },
  AwakerTalent_55176_TalentDesc_1 = {
    Text = "·에리카 깨어남체 자신, 운명 바퀴, 비밀 계약이 각각 1 점의 은열쇠 충전 등급 특성을 제공할 때마다, 「전자기 폭발」이 에리카에게 0.5% 임시 크리티컬 확률과 크리티컬 피해를 제공합니다."
  },
  AwakerTalent_55176_TalentName_1 = {
    Text = "외부 동력원"
  },
  AwakerTalent_55202_TalentDesc_1 = {
    Text = "· 턴 시작 시, 꿈의 유혹 1스택을 획득합니다.\n· 꿈의 유혹 1스택을 소모할 때마다, 해당 전투에서「방황의 수호자」와 「꿈속 죽음의 도시」로 획득하는 반격이 공격력의 5%만큼 증가합니다.\n·완다 자신, 장착한 명륜 및 비밀 계약의 피해 증폭 1%마다, 「꿈속 죽음의 도시」로 획득하는 반격이 0.75％ 상승합니다."
  },
  AwakerTalent_55202_TalentName_1 = {Text = "계시"},
  AwakerTalent_55367_TalentDesc_1 = {
    Text = "· 카시아 자신, 장착한 명륜 및 비밀 계약의 영역 숙련 1마다, 「마술 카니발」사용 시 카시아의 모든 기본 피해를 0.2% 증가시킵니다."
  },
  AwakerTalent_55367_TalentName_1 = {
    Text = "대마술사"
  },
  AwakerTalent_55507_TalentDesc_1 = {
    Text = "· 틴커트 자신, 장착한 명륜 및 비밀 계약의 검은 인장 드롭률 1%마다「별빛의 오로라」가 추가로 0.15%의 임시 크리티컬 확률을 얻습니다."
  },
  AwakerTalent_55507_TalentName_1 = {
    Text = "행성의 여행자"
  },
  AwakerTalent_55837_TalentDesc_1 = {
    Text = "· 오를라의「타격」과「방어」는 각각 한 종류의 시편으로 취급됩니다. 시편의 워프 효과가 발동하면 다른 감정으로 전환되며, 감정은 각 시편의 효과에 직접적인 영향을 미칩니다. 서로 다른 감정은 각각 다른 팀 지속 효과를 발휘합니다. \n· 오를라의 죽음 저항 1%마다, 해당 효과 보너스가 초기 값의 0.1%만큼 증가합니다."
  },
  AwakerTalent_55837_TalentName_1 = {
    Text = "낙필생정"
  },
  AwakerTalent_56174_TalentDesc_1 = {
    Text = "· 파로스의 피해 증폭 1%마다 「잃어버린 고대의 도시」로 생성하는 방어막이 0.4% 증가합니다."
  },
  AwakerTalent_56174_TalentName_1 = {
    Text = "귀향 집착"
  },
  AwakerTalent_56175_TalentDesc_1 = {
    Text = "· 카이커스의 검은 인장 드롭율 1%마다,「타격」에 1% 반격 계수가 적용됩니다."
  },
  AwakerTalent_56175_TalentName_1 = {
    Text = "반항의 가시"
  },
  AwakerTalent_56223_TalentDesc_1 = {
    Text = "· 셀레스트가 명령 카드를 사용한 후 촉수 1개로 적을 공격하며, 셀레스트 자신, 장착한 명륜 및 비밀 계약의 영역 숙련 1마다 해당 공격의 촉수 피해가 0.5% 증가합니다."
  },
  AwakerTalent_56223_TalentName_1 = {
    Text = "항해의 호각"
  },
  AwakerTalent_57336_TalentDesc_1 = {
    Text = "· 살바도르의 검은 인장 드롭율 1%마다, 핏빛 용광로의 최대치가 0.15% 증가합니다."
  },
  AwakerTalent_57336_TalentName_1 = {
    Text = "생명의 기원"
  },
  AwakerTalent_57408_TalentDesc_1 = {
    Text = "· 아그리파 자신, 장착한 명륜 및 비밀 계약의 검은 인장 드롭율 1%마다, 「창백한 보호」가 생성하는 기본 방어막이 0.5% 증가하고, 기본 중독이 1% 증가합니다."
  },
  AwakerTalent_57408_TalentName_1 = {
    Text = "계약의 인장"
  },
  AwakerTalent_57419_TalentDesc_1 = {
    Text = "· 파인트의 죽음 저항 1%마다, 「별의 요람」과 「무한한 별빛」으로 획득하는 반격이 0.2% 증가하며, 「별의 요람」의 죽음 저항 상한이 2% 증가합니다."
  },
  AwakerTalent_57419_TalentName_1 = {
    Text = "두 번째 포대기"
  },
  AwakerTalent_57567_TalentDesc_1 = {
    Text = "· 히로의 피해 증폭 1%마다, 「절망 속의 생존」사용 시 해당 턴 동안 히로이 입히는 피해를 0.3% 증가시킵니다."
  },
  AwakerTalent_57567_TalentName_1 = {
    Text = "고통 각인"
  },
  AwakerTalent_58448_TalentDesc_1 = {
    Text = "· 라이커가 적을 처치할 시 검은 인장 5개를 획득합니다. 라이커의 검은 인장 드롭율 1%마다 획득량이 1% 증가하며, 매 탐색마다 최대 5회 발동합니다.\n· 전투를 통해 검은 인장을 50/125/250개 획득하면, 유물 수량 제한이 1 증가하고, 전투 종료 시 <C05_zaowu:「혼돈의 유산」>을 선택하여 유물 목록에 추가할 수 있습니다."
  },
  AwakerTalent_58448_TalentName_1 = {
    Text = "승자독식"
  },
  AwakerTalent_70306_TalentDesc_1 = {
    Text = "· 보스 전투에서, 턴 시작 시 및「융해·돌」이 광기 폭발을 발동한 후,「종말」 1스택을 획득합니다.「종말」은 최대 10스택까지 보유할 수 있으며, 10스택에 도달하면「허무의 종언」 1장을 손패에 추가합니다."
  },
  AwakerTalent_70306_TalentName_1 = {
    Text = "소멸의 길"
  },
  AwakerTalent_74099_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 촉수가 공격할 때마다 임시 촉수 피해가 툴루 공격력의 [Arg3]％만큼 증가하며, 턴마다 [Arg4]회까지 적용됩니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 적이 받는 촉수 피해가 10％/25％/50％ 증가합니다."
  },
  AwakerTalent_74099_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 촉수가 공격할 때마다 임시 촉수 피해가 툴루 공격력의 [Arg3]％만큼 증가하며, 턴마다 [Arg4]회까지 적용됩니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 적이 받는 촉수 피해가 10％/25％/50％ 증가합니다."
  },
  AwakerTalent_74099_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 촉수가 공격할 때마다 임시 촉수 피해가 툴루 공격력의 [Arg3]％만큼 증가하며, 턴마다 [Arg4]회까지 적용됩니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 적이 받는 촉수 피해가 10％/25％/50％ 증가합니다."
  },
  AwakerTalent_74099_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 촉수가 공격할 때마다 임시 촉수 피해가 툴루 공격력의 [Arg3]％만큼 증가하며, 턴마다 [Arg4]회까지 적용됩니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 적이 받는 촉수 피해가 10％/25％/50％ 증가합니다."
  },
  AwakerTalent_74099_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 촉수가 공격할 때마다 임시 촉수 피해가 툴루 공격력의 [Arg3]％만큼 증가하며, 턴마다 [Arg4]회까지 적용됩니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 적이 받는 촉수 피해가 10％/25％/50％ 증가합니다."
  },
  AwakerTalent_74099_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 촉수가 공격할 때마다 임시 촉수 피해가 툴루 공격력의 [Arg3]％만큼 증가하며, 턴마다 [Arg4]회까지 적용됩니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 적이 받는 촉수 피해가 10％/25％/50％ 증가합니다."
  },
  AwakerTalent_74099_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 촉수가 공격할 때마다 임시 촉수 피해가 툴루 공격력의 [Arg3]％만큼 증가하며, 턴마다 [Arg4]회까지 적용됩니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 적이 받는 촉수 피해가 10％/25％/50％ 증가합니다."
  },
  AwakerTalent_74099_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 촉수가 공격할 때마다 임시 촉수 피해가 툴루 공격력의 [Arg3]％만큼 증가하며, 턴마다 [Arg4]회까지 적용됩니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 적이 받는 촉수 피해가 10％/25％/50％ 증가합니다."
  },
  AwakerTalent_74099_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 촉수가 공격할 때마다 임시 촉수 피해가 툴루 공격력의 [Arg3]％만큼 증가하며, 턴마다 [Arg4]회까지 적용됩니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 적이 받는 촉수 피해가 10％/25％/50％ 증가합니다."
  },
  AwakerTalent_74099_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 촉수가 공격할 때마다 임시 촉수 피해가 툴루 공격력의 [Arg3]％만큼 증가하며, 턴마다 [Arg4]회까지 적용됩니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 적이 받는 촉수 피해가 10％/25％/50％ 증가합니다."
  },
  AwakerTalent_74099_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74099_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74099_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74099_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74099_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74099_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74099_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74099_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74099_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74099_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74100_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「파인트」의 힘 감소 효과가 [Arg4]% 강화됩니다. 「파인트」의 명령 카드를 사용하면 일시적으로 「인간형」 적의 파인트 공격력 [Arg3]%만큼의 힘을 탈취합니다. 이 효과는 턴마다 최대 3회까지 발동합니다."
  },
  AwakerTalent_74100_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「파인트」의 힘 감소 효과가 [Arg4]% 강화됩니다. 「파인트」의 명령 카드를 사용하면 일시적으로 「인간형」 적의 파인트 공격력 [Arg3]%만큼의 힘을 탈취합니다. 이 효과는 턴마다 최대 3회까지 발동합니다."
  },
  AwakerTalent_74100_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「파인트」의 힘 감소 효과가 [Arg4]% 강화됩니다. 「파인트」의 명령 카드를 사용하면 일시적으로 「인간형」 적의 파인트 공격력 [Arg3]%만큼의 힘을 탈취합니다. 이 효과는 턴마다 최대 3회까지 발동합니다."
  },
  AwakerTalent_74100_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「파인트」의 힘 감소 효과가 [Arg4]% 강화됩니다. 「파인트」의 명령 카드를 사용하면 일시적으로 「인간형」 적의 파인트 공격력 [Arg3]%만큼의 힘을 탈취합니다. 이 효과는 턴마다 최대 3회까지 발동합니다."
  },
  AwakerTalent_74100_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「파인트」의 힘 감소 효과가 [Arg4]% 강화됩니다. 「파인트」의 명령 카드를 사용하면 일시적으로 「인간형」 적의 파인트 공격력 [Arg3]%만큼의 힘을 탈취합니다. 이 효과는 턴마다 최대 3회까지 발동합니다."
  },
  AwakerTalent_74100_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「파인트」의 힘 감소 효과가 [Arg4]% 강화됩니다. 「파인트」의 명령 카드를 사용하면 일시적으로 「인간형」 적의 파인트 공격력 [Arg3]%만큼의 힘을 탈취합니다. 이 효과는 턴마다 최대 3회까지 발동합니다."
  },
  AwakerTalent_74100_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「파인트」의 힘 감소 효과가 [Arg4]% 강화됩니다. 「파인트」의 명령 카드를 사용하면 일시적으로 「인간형」 적의 파인트 공격력 [Arg3]%만큼의 힘을 탈취합니다. 이 효과는 턴마다 최대 3회까지 발동합니다."
  },
  AwakerTalent_74100_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「파인트」의 힘 감소 효과가 [Arg4]% 강화됩니다. 「파인트」의 명령 카드를 사용하면 일시적으로 「인간형」 적의 파인트 공격력 [Arg3]%만큼의 힘을 탈취합니다. 이 효과는 턴마다 최대 3회까지 발동합니다."
  },
  AwakerTalent_74100_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「파인트」의 힘 감소 효과가 [Arg4]% 강화됩니다. 「파인트」의 명령 카드를 사용하면 일시적으로 「인간형」 적의 파인트 공격력 [Arg3]%만큼의 힘을 탈취합니다. 이 효과는 턴마다 최대 3회까지 발동합니다."
  },
  AwakerTalent_74100_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「파인트」의 힘 감소 효과가 [Arg4]% 강화됩니다. 「파인트」의 명령 카드를 사용하면 일시적으로 「인간형」 적의 파인트 공격력 [Arg3]%만큼의 힘을 탈취합니다. 이 효과는 턴마다 최대 3회까지 발동합니다."
  },
  AwakerTalent_74100_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74100_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74100_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74100_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74100_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74100_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74100_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74100_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74100_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74100_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74101_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 라이커의 검은 인장 드롭율이 [Arg4]%, 치명타 확률이 [Arg3]% 증가합니다. 전투를 통해 400개 이상의 검은 인장을 획득한 경우, 전투 시작 시 「혼돈의 유산」 1개를 업그레이드합니다."
  },
  AwakerTalent_74101_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 라이커의 검은 인장 드롭율이 [Arg4]%, 치명타 확률이 [Arg3]% 증가합니다. 전투를 통해 400개 이상의 검은 인장을 획득한 경우, 전투 시작 시 「혼돈의 유산」 1개를 업그레이드합니다."
  },
  AwakerTalent_74101_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 라이커의 검은 인장 드롭율이 [Arg4]%, 치명타 확률이 [Arg3]% 증가합니다. 전투를 통해 400개 이상의 검은 인장을 획득한 경우, 전투 시작 시 「혼돈의 유산」 1개를 업그레이드합니다."
  },
  AwakerTalent_74101_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 라이커의 검은 인장 드롭율이 [Arg4]%, 치명타 확률이 [Arg3]% 증가합니다. 전투를 통해 400개 이상의 검은 인장을 획득한 경우, 전투 시작 시 「혼돈의 유산」 1개를 업그레이드합니다."
  },
  AwakerTalent_74101_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 라이커의 검은 인장 드롭율이 [Arg4]%, 치명타 확률이 [Arg3]% 증가합니다. 전투를 통해 400개 이상의 검은 인장을 획득한 경우, 전투 시작 시 「혼돈의 유산」 1개를 업그레이드합니다."
  },
  AwakerTalent_74101_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 라이커의 검은 인장 드롭율이 [Arg4]%, 치명타 확률이 [Arg3]% 증가합니다. 전투를 통해 400개 이상의 검은 인장을 획득한 경우, 전투 시작 시 「혼돈의 유산」 1개를 업그레이드합니다."
  },
  AwakerTalent_74101_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 라이커의 검은 인장 드롭율이 [Arg4]%, 치명타 확률이 [Arg3]% 증가합니다. 전투를 통해 400개 이상의 검은 인장을 획득한 경우, 전투 시작 시 「혼돈의 유산」 1개를 업그레이드합니다."
  },
  AwakerTalent_74101_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 라이커의 검은 인장 드롭율이 [Arg4]%, 치명타 확률이 [Arg3]% 증가합니다. 전투를 통해 400개 이상의 검은 인장을 획득한 경우, 전투 시작 시 「혼돈의 유산」 1개를 업그레이드합니다."
  },
  AwakerTalent_74101_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 라이커의 검은 인장 드롭율이 [Arg4]%, 치명타 확률이 [Arg3]% 증가합니다. 전투를 통해 400개 이상의 검은 인장을 획득한 경우, 전투 시작 시 「혼돈의 유산」 1개를 업그레이드합니다."
  },
  AwakerTalent_74101_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 라이커의 검은 인장 드롭율이 [Arg4]%, 치명타 확률이 [Arg3]% 증가합니다. 전투를 통해 400개 이상의 검은 인장을 획득한 경우, 전투 시작 시 「혼돈의 유산」 1개를 업그레이드합니다."
  },
  AwakerTalent_74101_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74101_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74101_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74101_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74101_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74101_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74101_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74101_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74101_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74101_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74102_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「구속의 사슬」이 입히는 기본 피해가 [Arg4]% 증가하며, 추가로 [Arg3]% 힘 계수가 적용됩니다."
  },
  AwakerTalent_74102_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「구속의 사슬」이 입히는 기본 피해가 [Arg4]% 증가하며, 추가로 [Arg3]% 힘 계수가 적용됩니다."
  },
  AwakerTalent_74102_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「구속의 사슬」이 입히는 기본 피해가 [Arg4]% 증가하며, 추가로 [Arg3]% 힘 계수가 적용됩니다."
  },
  AwakerTalent_74102_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「구속의 사슬」이 입히는 기본 피해가 [Arg4]% 증가하며, 추가로 [Arg3]% 힘 계수가 적용됩니다."
  },
  AwakerTalent_74102_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「구속의 사슬」이 입히는 기본 피해가 [Arg4]% 증가하며, 추가로 [Arg3]% 힘 계수가 적용됩니다."
  },
  AwakerTalent_74102_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「구속의 사슬」이 입히는 기본 피해가 [Arg4]% 증가하며, 추가로 [Arg3]% 힘 계수가 적용됩니다."
  },
  AwakerTalent_74102_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「구속의 사슬」이 입히는 기본 피해가 [Arg4]% 증가하며, 추가로 [Arg3]% 힘 계수가 적용됩니다."
  },
  AwakerTalent_74102_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「구속의 사슬」이 입히는 기본 피해가 [Arg4]% 증가하며, 추가로 [Arg3]% 힘 계수가 적용됩니다."
  },
  AwakerTalent_74102_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「구속의 사슬」이 입히는 기본 피해가 [Arg4]% 증가하며, 추가로 [Arg3]% 힘 계수가 적용됩니다."
  },
  AwakerTalent_74102_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「구속의 사슬」이 입히는 기본 피해가 [Arg4]% 증가하며, 추가로 [Arg3]% 힘 계수가 적용됩니다."
  },
  AwakerTalent_74102_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74102_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74102_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74102_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74102_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74102_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74102_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74102_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74102_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74102_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74103_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 「창백한 선회」을 처음 사용할 때 배아 융합+ [Arg3], 포식이 발동된 후 손패의 「창백한 선회」 1장의 산출력 소비가 1 감소합니다."
  },
  AwakerTalent_74103_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 「창백한 선회」을 처음 사용할 때 배아 융합+ [Arg3], 포식이 발동된 후 손패의 「창백한 선회」 1장의 산출력 소비가 1 감소합니다."
  },
  AwakerTalent_74103_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 「창백한 선회」을 처음 사용할 때 배아 융합+ [Arg3], 포식이 발동된 후 손패의 「창백한 선회」 1장의 산출력 소비가 1 감소합니다."
  },
  AwakerTalent_74103_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 「창백한 선회」을 처음 사용할 때 배아 융합+ [Arg3], 포식이 발동된 후 손패의 「창백한 선회」 1장의 산출력 소비가 1 감소합니다."
  },
  AwakerTalent_74103_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 「창백한 선회」을 처음 사용할 때 배아 융합+ [Arg3], 포식이 발동된 후 손패의 「창백한 선회」 1장의 산출력 소비가 1 감소합니다."
  },
  AwakerTalent_74103_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 「창백한 선회」을 처음 사용할 때 배아 융합+ [Arg3], 포식이 발동된 후 손패의 「창백한 선회」 1장의 산출력 소비가 1 감소합니다."
  },
  AwakerTalent_74103_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 「창백한 선회」을 처음 사용할 때 배아 융합+ [Arg3], 포식이 발동된 후 손패의 「창백한 선회」 1장의 산출력 소비가 1 감소합니다."
  },
  AwakerTalent_74103_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 「창백한 선회」을 처음 사용할 때 배아 융합+ [Arg3], 포식이 발동된 후 손패의 「창백한 선회」 1장의 산출력 소비가 1 감소합니다."
  },
  AwakerTalent_74103_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 「창백한 선회」을 처음 사용할 때 배아 융합+ [Arg3], 포식이 발동된 후 손패의 「창백한 선회」 1장의 산출력 소비가 1 감소합니다."
  },
  AwakerTalent_74103_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 「창백한 선회」을 처음 사용할 때 배아 융합+ [Arg3], 포식이 발동된 후 손패의 「창백한 선회」 1장의 산출력 소비가 1 감소합니다."
  },
  AwakerTalent_74103_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74103_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74103_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74103_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74103_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74103_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74103_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74103_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74103_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74103_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74104_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 에리카의 공격력 [Arg3]%의 힘과 에리카의 방어력 [Arg4]%의 경계를 얻습니다."
  },
  AwakerTalent_74104_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 에리카의 공격력 [Arg3]%의 힘과 에리카의 방어력 [Arg4]%의 경계를 얻습니다."
  },
  AwakerTalent_74104_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 에리카의 공격력 [Arg3]%의 힘과 에리카의 방어력 [Arg4]%의 경계를 얻습니다."
  },
  AwakerTalent_74104_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 에리카의 공격력 [Arg3]%의 힘과 에리카의 방어력 [Arg4]%의 경계를 얻습니다."
  },
  AwakerTalent_74104_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 에리카의 공격력 [Arg3]%의 힘과 에리카의 방어력 [Arg4]%의 경계를 얻습니다."
  },
  AwakerTalent_74104_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 에리카의 공격력 [Arg3]%의 힘과 에리카의 방어력 [Arg4]%의 경계를 얻습니다."
  },
  AwakerTalent_74104_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 에리카의 공격력 [Arg3]%의 힘과 에리카의 방어력 [Arg4]%의 경계를 얻습니다."
  },
  AwakerTalent_74104_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 에리카의 공격력 [Arg3]%의 힘과 에리카의 방어력 [Arg4]%의 경계를 얻습니다."
  },
  AwakerTalent_74104_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 에리카의 공격력 [Arg3]%의 힘과 에리카의 방어력 [Arg4]%의 경계를 얻습니다."
  },
  AwakerTalent_74104_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 에리카의 공격력 [Arg3]%의 힘과 에리카의 방어력 [Arg4]%의 경계를 얻습니다."
  },
  AwakerTalent_74104_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74104_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74104_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74104_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74104_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74104_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74104_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74104_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74104_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74104_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74105_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「소란스러운 바다」로 「선체 분열」을 1장 소모할 때마다 오레타가 해당 전투에서 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다. 보스 전투에서 「소란스러운 바다」로 「선체 분열」을 20장 이상 소모했다면, 「선체 분열」을 사용 및 소모할 때 가하는 피해 횟수가 1회 증가합니다. 매 턴 사용하는 처음 [Arg4]장의 「선체 분열」은 「연산력 조화」를 추가하지 않습니다."
  },
  AwakerTalent_74105_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「소란스러운 바다」로 「선체 분열」을 1장 소모할 때마다 오레타가 해당 전투에서 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다. 보스 전투에서 「소란스러운 바다」로 「선체 분열」을 20장 이상 소모했다면, 「선체 분열」을 사용 및 소모할 때 가하는 피해 횟수가 1회 증가합니다. 매 턴 사용하는 처음 [Arg4]장의 「선체 분열」은 「연산력 조화」를 추가하지 않습니다."
  },
  AwakerTalent_74105_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「소란스러운 바다」로 「선체 분열」을 1장 소모할 때마다 오레타가 해당 전투에서 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다. 보스 전투에서 「소란스러운 바다」로 「선체 분열」을 20장 이상 소모했다면, 「선체 분열」을 사용 및 소모할 때 가하는 피해 횟수가 1회 증가합니다. 매 턴 사용하는 처음 [Arg4]장의 「선체 분열」은 「연산력 조화」를 추가하지 않습니다."
  },
  AwakerTalent_74105_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「소란스러운 바다」로 「선체 분열」을 1장 소모할 때마다 오레타가 해당 전투에서 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다. 보스 전투에서 「소란스러운 바다」로 「선체 분열」을 20장 이상 소모했다면, 「선체 분열」을 사용 및 소모할 때 가하는 피해 횟수가 1회 증가합니다. 매 턴 사용하는 처음 [Arg4]장의 「선체 분열」은 「연산력 조화」를 추가하지 않습니다."
  },
  AwakerTalent_74105_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「소란스러운 바다」로 「선체 분열」을 1장 소모할 때마다 오레타가 해당 전투에서 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다. 보스 전투에서 「소란스러운 바다」로 「선체 분열」을 20장 이상 소모했다면, 「선체 분열」을 사용 및 소모할 때 가하는 피해 횟수가 1회 증가합니다. 매 턴 사용하는 처음 [Arg4]장의 「선체 분열」은 「연산력 조화」를 추가하지 않습니다."
  },
  AwakerTalent_74105_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「소란스러운 바다」로 「선체 분열」을 1장 소모할 때마다 오레타가 해당 전투에서 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다. 보스 전투에서 「소란스러운 바다」로 「선체 분열」을 20장 이상 소모했다면, 「선체 분열」을 사용 및 소모할 때 가하는 피해 횟수가 1회 증가합니다. 매 턴 사용하는 처음 [Arg4]장의 「선체 분열」은 「연산력 조화」를 추가하지 않습니다."
  },
  AwakerTalent_74105_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「소란스러운 바다」로 「선체 분열」을 1장 소모할 때마다 오레타가 해당 전투에서 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다. 보스 전투에서 「소란스러운 바다」로 「선체 분열」을 20장 이상 소모했다면, 「선체 분열」을 사용 및 소모할 때 가하는 피해 횟수가 1회 증가합니다. 매 턴 사용하는 처음 [Arg4]장의 「선체 분열」은 「연산력 조화」를 추가하지 않습니다."
  },
  AwakerTalent_74105_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「소란스러운 바다」로 「선체 분열」을 1장 소모할 때마다 오레타가 해당 전투에서 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다. 보스 전투에서 「소란스러운 바다」로 「선체 분열」을 20장 이상 소모했다면, 「선체 분열」을 사용 및 소모할 때 가하는 피해 횟수가 1회 증가합니다. 매 턴 사용하는 처음 [Arg4]장의 「선체 분열」은 「연산력 조화」를 추가하지 않습니다."
  },
  AwakerTalent_74105_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「소란스러운 바다」로 「선체 분열」을 1장 소모할 때마다 오레타가 해당 전투에서 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다. 보스 전투에서 「소란스러운 바다」로 「선체 분열」을 20장 이상 소모했다면, 「선체 분열」을 사용 및 소모할 때 가하는 피해 횟수가 1회 증가합니다. 매 턴 사용하는 처음 [Arg4]장의 「선체 분열」은 「연산력 조화」를 추가하지 않습니다."
  },
  AwakerTalent_74105_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「소란스러운 바다」로 「선체 분열」을 1장 소모할 때마다 오레타가 해당 전투에서 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다. 보스 전투에서 「소란스러운 바다」로 「선체 분열」을 20장 이상 소모했다면, 「선체 분열」을 사용 및 소모할 때 가하는 피해 횟수가 1회 증가합니다. 매 턴 사용하는 처음 [Arg4]장의 「선체 분열」은 「연산력 조화」를 추가하지 않습니다."
  },
  AwakerTalent_74105_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74105_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74105_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74105_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74105_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74105_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74105_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74105_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74105_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74105_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74106_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 촉수 피해가 [Arg3]% 증가합니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체가 입히는 촉수 피해가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74106_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 촉수 피해가 [Arg3]% 증가합니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체가 입히는 촉수 피해가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74106_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 촉수 피해가 [Arg3]% 증가합니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체가 입히는 촉수 피해가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74106_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 촉수 피해가 [Arg3]% 증가합니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체가 입히는 촉수 피해가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74106_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 촉수 피해가 [Arg3]% 증가합니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체가 입히는 촉수 피해가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74106_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 촉수 피해가 [Arg3]% 증가합니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체가 입히는 촉수 피해가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74106_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 촉수 피해가 [Arg3]% 증가합니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체가 입히는 촉수 피해가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74106_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 촉수 피해가 [Arg3]% 증가합니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체가 입히는 촉수 피해가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74106_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 촉수 피해가 [Arg3]% 증가합니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체가 입히는 촉수 피해가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74106_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 촉수 피해가 [Arg3]% 증가합니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체가 입히는 촉수 피해가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74106_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74106_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74106_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74106_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74106_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74106_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74106_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74106_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74106_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74106_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74107_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 님피아의 중독 발동 효과가 [Arg3]% 증가하며, 모든 깨어남체가 중독 부여량이 10% 증가합니다."
  },
  AwakerTalent_74107_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 님피아의 중독 발동 효과가 [Arg3]% 증가하며, 모든 깨어남체가 중독 부여량이 10% 증가합니다."
  },
  AwakerTalent_74107_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 님피아의 중독 발동 효과가 [Arg3]% 증가하며, 모든 깨어남체가 중독 부여량이 10% 증가합니다."
  },
  AwakerTalent_74107_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 님피아의 중독 발동 효과가 [Arg3]% 증가하며, 모든 깨어남체가 중독 부여량이 10% 증가합니다."
  },
  AwakerTalent_74107_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 님피아의 중독 발동 효과가 [Arg3]% 증가하며, 모든 깨어남체가 중독 부여량이 10% 증가합니다."
  },
  AwakerTalent_74107_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 님피아의 중독 발동 효과가 [Arg3]% 증가하며, 모든 깨어남체가 중독 부여량이 10% 증가합니다."
  },
  AwakerTalent_74107_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 님피아의 중독 발동 효과가 [Arg3]% 증가하며, 모든 깨어남체가 중독 부여량이 10% 증가합니다."
  },
  AwakerTalent_74107_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 님피아의 중독 발동 효과가 [Arg3]% 증가하며, 모든 깨어남체가 중독 부여량이 10% 증가합니다."
  },
  AwakerTalent_74107_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 님피아의 중독 발동 효과가 [Arg3]% 증가하며, 모든 깨어남체가 중독 부여량이 10% 증가합니다."
  },
  AwakerTalent_74107_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 님피아의 중독 발동 효과가 [Arg3]% 증가하며, 모든 깨어남체가 중독 부여량이 10% 증가합니다."
  },
  AwakerTalent_74107_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74107_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74107_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74107_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74107_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74107_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74107_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74107_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74107_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74107_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74108_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 오지에가 생성하는 방어막이 [Arg3]% 증가하며, 생성하는 힘이 [Arg4]% 증가합니다. 광기 폭발을 발동할 때마다 해당 전투에서 오지에가 생성하는 방어막이 방어력의 1%만큼 추가 증가합니다."
  },
  AwakerTalent_74108_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 오지에가 생성하는 방어막이 [Arg3]% 증가하며, 생성하는 힘이 [Arg4]% 증가합니다. 광기 폭발을 발동할 때마다 해당 전투에서 오지에가 생성하는 방어막이 방어력의 1%만큼 추가 증가합니다."
  },
  AwakerTalent_74108_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 오지에가 생성하는 방어막이 [Arg3]% 증가하며, 생성하는 힘이 [Arg4]% 증가합니다. 광기 폭발을 발동할 때마다 해당 전투에서 오지에가 생성하는 방어막이 방어력의 1%만큼 추가 증가합니다."
  },
  AwakerTalent_74108_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 오지에가 생성하는 방어막이 [Arg3]% 증가하며, 생성하는 힘이 [Arg4]% 증가합니다. 광기 폭발을 발동할 때마다 해당 전투에서 오지에가 생성하는 방어막이 방어력의 1%만큼 추가 증가합니다."
  },
  AwakerTalent_74108_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 오지에가 생성하는 방어막이 [Arg3]% 증가하며, 생성하는 힘이 [Arg4]% 증가합니다. 광기 폭발을 발동할 때마다 해당 전투에서 오지에가 생성하는 방어막이 방어력의 1%만큼 추가 증가합니다."
  },
  AwakerTalent_74108_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 오지에가 생성하는 방어막이 [Arg3]% 증가하며, 생성하는 힘이 [Arg4]% 증가합니다. 광기 폭발을 발동할 때마다 해당 전투에서 오지에가 생성하는 방어막이 방어력의 1%만큼 추가 증가합니다."
  },
  AwakerTalent_74108_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 오지에가 생성하는 방어막이 [Arg3]% 증가하며, 생성하는 힘이 [Arg4]% 증가합니다. 광기 폭발을 발동할 때마다 해당 전투에서 오지에가 생성하는 방어막이 방어력의 1%만큼 추가 증가합니다."
  },
  AwakerTalent_74108_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 오지에가 생성하는 방어막이 [Arg3]% 증가하며, 생성하는 힘이 [Arg4]% 증가합니다. 광기 폭발을 발동할 때마다 해당 전투에서 오지에가 생성하는 방어막이 방어력의 1%만큼 추가 증가합니다."
  },
  AwakerTalent_74108_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 오지에가 생성하는 방어막이 [Arg3]% 증가하며, 생성하는 힘이 [Arg4]% 증가합니다. 광기 폭발을 발동할 때마다 해당 전투에서 오지에가 생성하는 방어막이 방어력의 1%만큼 추가 증가합니다."
  },
  AwakerTalent_74108_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 오지에가 생성하는 방어막이 [Arg3]% 증가하며, 생성하는 힘이 [Arg4]% 증가합니다. 광기 폭발을 발동할 때마다 해당 전투에서 오지에가 생성하는 방어막이 방어력의 1%만큼 추가 증가합니다."
  },
  AwakerTalent_74108_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74108_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74108_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74108_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74108_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74108_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74108_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74108_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74108_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74108_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74109_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 10장까지 「브라운 출동!」은 「행동력 조화」를 추가하지 않습니다.\n· 젠킨이 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다."
  },
  AwakerTalent_74109_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 10장까지 「브라운 출동!」은 「행동력 조화」를 추가하지 않습니다.\n· 젠킨이 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다."
  },
  AwakerTalent_74109_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 10장까지 「브라운 출동!」은 「행동력 조화」를 추가하지 않습니다.\n· 젠킨이 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다."
  },
  AwakerTalent_74109_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 10장까지 「브라운 출동!」은 「행동력 조화」를 추가하지 않습니다.\n· 젠킨이 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다."
  },
  AwakerTalent_74109_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 10장까지 「브라운 출동!」은 「행동력 조화」를 추가하지 않습니다.\n· 젠킨이 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다."
  },
  AwakerTalent_74109_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 10장까지 「브라운 출동!」은 「행동력 조화」를 추가하지 않습니다.\n· 젠킨이 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다."
  },
  AwakerTalent_74109_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 10장까지 「브라운 출동!」은 「행동력 조화」를 추가하지 않습니다.\n· 젠킨이 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다."
  },
  AwakerTalent_74109_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 10장까지 「브라운 출동!」은 「행동력 조화」를 추가하지 않습니다.\n· 젠킨이 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다."
  },
  AwakerTalent_74109_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 10장까지 「브라운 출동!」은 「행동력 조화」를 추가하지 않습니다.\n· 젠킨이 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다."
  },
  AwakerTalent_74109_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 10장까지 「브라운 출동!」은 「행동력 조화」를 추가하지 않습니다.\n· 젠킨이 가하는 피해가 공격력의 [Arg3]%만큼 증가합니다."
  },
  AwakerTalent_74109_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74109_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74109_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74109_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74109_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74109_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74109_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74109_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74109_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74109_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74110_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「영감」 사용 시 공격력 [Arg3]%의 임시 힘을 획득하고, 「축적된 음률」을 1회 발동합니다. 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74110_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「영감」 사용 시 공격력 [Arg3]%의 임시 힘을 획득하고, 「축적된 음률」을 1회 발동합니다. 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74110_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「영감」 사용 시 공격력 [Arg3]%의 임시 힘을 획득하고, 「축적된 음률」을 1회 발동합니다. 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74110_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「영감」 사용 시 공격력 [Arg3]%의 임시 힘을 획득하고, 「축적된 음률」을 1회 발동합니다. 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74110_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「영감」 사용 시 공격력 [Arg3]%의 임시 힘을 획득하고, 「축적된 음률」을 1회 발동합니다. 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74110_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「영감」 사용 시 공격력 [Arg3]%의 임시 힘을 획득하고, 「축적된 음률」을 1회 발동합니다. 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74110_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「영감」 사용 시 공격력 [Arg3]%의 임시 힘을 획득하고, 「축적된 음률」을 1회 발동합니다. 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74110_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「영감」 사용 시 공격력 [Arg3]%의 임시 힘을 획득하고, 「축적된 음률」을 1회 발동합니다. 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74110_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「영감」 사용 시 공격력 [Arg3]%의 임시 힘을 획득하고, 「축적된 음률」을 1회 발동합니다. 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74110_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「영감」 사용 시 공격력 [Arg3]%의 임시 힘을 획득하고, 「축적된 음률」을 1회 발동합니다. 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74110_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74110_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74110_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74110_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74110_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74110_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74110_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74110_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74110_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74110_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74111_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·전투 시작 시, 「야수」 적이 존재할 경우, 카시아의 힘 획득량이 해당 전투 동안 [Arg3]％ 증가합니다. 턴마다 처음 사용하는 「사라지는 마술!」이 덱으로 섞어 넣은 카드의 여파 효과를 발동합니다."
  },
  AwakerTalent_74111_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·전투 시작 시, 「야수」 적이 존재할 경우, 카시아의 힘 획득량이 해당 전투 동안 [Arg3]％ 증가합니다. 턴마다 처음 사용하는 「사라지는 마술!」이 덱으로 섞어 넣은 카드의 여파 효과를 발동합니다."
  },
  AwakerTalent_74111_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·전투 시작 시, 「야수」 적이 존재할 경우, 카시아의 힘 획득량이 해당 전투 동안 [Arg3]％ 증가합니다. 턴마다 처음 사용하는 「사라지는 마술!」이 덱으로 섞어 넣은 카드의 여파 효과를 발동합니다."
  },
  AwakerTalent_74111_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·전투 시작 시, 「야수」 적이 존재할 경우, 카시아의 힘 획득량이 해당 전투 동안 [Arg3]％ 증가합니다. 턴마다 처음 사용하는 「사라지는 마술!」이 덱으로 섞어 넣은 카드의 여파 효과를 발동합니다."
  },
  AwakerTalent_74111_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·전투 시작 시, 「야수」 적이 존재할 경우, 카시아의 힘 획득량이 해당 전투 동안 [Arg3]％ 증가합니다. 턴마다 처음 사용하는 「사라지는 마술!」이 덱으로 섞어 넣은 카드의 여파 효과를 발동합니다."
  },
  AwakerTalent_74111_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·전투 시작 시, 「야수」 적이 존재할 경우, 카시아의 힘 획득량이 해당 전투 동안 [Arg3]％ 증가합니다. 턴마다 처음 사용하는 「사라지는 마술!」이 덱으로 섞어 넣은 카드의 여파 효과를 발동합니다."
  },
  AwakerTalent_74111_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·전투 시작 시, 「야수」 적이 존재할 경우, 카시아의 힘 획득량이 해당 전투 동안 [Arg3]％ 증가합니다. 턴마다 처음 사용하는 「사라지는 마술!」이 덱으로 섞어 넣은 카드의 여파 효과를 발동합니다."
  },
  AwakerTalent_74111_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·전투 시작 시, 「야수」 적이 존재할 경우, 카시아의 힘 획득량이 해당 전투 동안 [Arg3]％ 증가합니다. 턴마다 처음 사용하는 「사라지는 마술!」이 덱으로 섞어 넣은 카드의 여파 효과를 발동합니다."
  },
  AwakerTalent_74111_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·전투 시작 시, 「야수」 적이 존재할 경우, 카시아의 힘 획득량이 해당 전투 동안 [Arg3]％ 증가합니다. 턴마다 처음 사용하는 「사라지는 마술!」이 덱으로 섞어 넣은 카드의 여파 효과를 발동합니다."
  },
  AwakerTalent_74111_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·전투 시작 시, 「야수」 적이 존재할 경우, 카시아의 힘 획득량이 해당 전투 동안 [Arg3]％ 증가합니다. 턴마다 처음 사용하는 「사라지는 마술!」이 덱으로 섞어 넣은 카드의 여파 효과를 발동합니다."
  },
  AwakerTalent_74111_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74111_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74111_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74111_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74111_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74111_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74111_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74111_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74111_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74111_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74112_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·산이 방어막을 생성할 때, 방어막 값의 [Arg3]%만큼 촉수 피해가 증가합니다. 산이 광기 폭발을 사용할 때, 추가로 [Arg4]% 촉수 피해 보너스를 받습니다."
  },
  AwakerTalent_74112_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·산이 방어막을 생성할 때, 방어막 값의 [Arg3]%만큼 촉수 피해가 증가합니다. 산이 광기 폭발을 사용할 때, 추가로 [Arg4]% 촉수 피해 보너스를 받습니다."
  },
  AwakerTalent_74112_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·산이 방어막을 생성할 때, 방어막 값의 [Arg3]%만큼 촉수 피해가 증가합니다. 산이 광기 폭발을 사용할 때, 추가로 [Arg4]% 촉수 피해 보너스를 받습니다."
  },
  AwakerTalent_74112_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·산이 방어막을 생성할 때, 방어막 값의 [Arg3]%만큼 촉수 피해가 증가합니다. 산이 광기 폭발을 사용할 때, 추가로 [Arg4]% 촉수 피해 보너스를 받습니다."
  },
  AwakerTalent_74112_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·산이 방어막을 생성할 때, 방어막 값의 [Arg3]%만큼 촉수 피해가 증가합니다. 산이 광기 폭발을 사용할 때, 추가로 [Arg4]% 촉수 피해 보너스를 받습니다."
  },
  AwakerTalent_74112_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·산이 방어막을 생성할 때, 방어막 값의 [Arg3]%만큼 촉수 피해가 증가합니다. 산이 광기 폭발을 사용할 때, 추가로 [Arg4]% 촉수 피해 보너스를 받습니다."
  },
  AwakerTalent_74112_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·산이 방어막을 생성할 때, 방어막 값의 [Arg3]%만큼 촉수 피해가 증가합니다. 산이 광기 폭발을 사용할 때, 추가로 [Arg4]% 촉수 피해 보너스를 받습니다."
  },
  AwakerTalent_74112_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·산이 방어막을 생성할 때, 방어막 값의 [Arg3]%만큼 촉수 피해가 증가합니다. 산이 광기 폭발을 사용할 때, 추가로 [Arg4]% 촉수 피해 보너스를 받습니다."
  },
  AwakerTalent_74112_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·산이 방어막을 생성할 때, 방어막 값의 [Arg3]%만큼 촉수 피해가 증가합니다. 산이 광기 폭발을 사용할 때, 추가로 [Arg4]% 촉수 피해 보너스를 받습니다."
  },
  AwakerTalent_74112_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·산이 방어막을 생성할 때, 방어막 값의 [Arg3]%만큼 촉수 피해가 증가합니다. 산이 광기 폭발을 사용할 때, 추가로 [Arg4]% 촉수 피해 보너스를 받습니다."
  },
  AwakerTalent_74112_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74112_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74112_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74112_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74112_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74112_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74112_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74112_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74112_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74112_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74113_TalentDesc_1 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「광기의 속박」이 보존과 예비를 획득합니다. 피해를 가하려는 적이 받는 판디아의 능동 피해가 [Arg3]% 증가하며, 대상이 추가 공격 1회마다 5% 증가하고, 최대 추가 20% 증가합니다."
  },
  AwakerTalent_74113_TalentDesc_10 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「광기의 속박」이 보존과 예비를 획득합니다. 피해를 가하려는 적이 받는 판디아의 능동 피해가 [Arg3]% 증가하며, 대상이 추가 공격 1회마다 5% 증가하고, 최대 추가 20% 증가합니다."
  },
  AwakerTalent_74113_TalentDesc_2 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「광기의 속박」이 보존과 예비를 획득합니다. 피해를 가하려는 적이 받는 판디아의 능동 피해가 [Arg3]% 증가하며, 대상이 추가 공격 1회마다 5% 증가하고, 최대 추가 20% 증가합니다."
  },
  AwakerTalent_74113_TalentDesc_3 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「광기의 속박」이 보존과 예비를 획득합니다. 피해를 가하려는 적이 받는 판디아의 능동 피해가 [Arg3]% 증가하며, 대상이 추가 공격 1회마다 5% 증가하고, 최대 추가 20% 증가합니다."
  },
  AwakerTalent_74113_TalentDesc_4 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「광기의 속박」이 보존과 예비를 획득합니다. 피해를 가하려는 적이 받는 판디아의 능동 피해가 [Arg3]% 증가하며, 대상이 추가 공격 1회마다 5% 증가하고, 최대 추가 20% 증가합니다."
  },
  AwakerTalent_74113_TalentDesc_5 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「광기의 속박」이 보존과 예비를 획득합니다. 피해를 가하려는 적이 받는 판디아의 능동 피해가 [Arg3]% 증가하며, 대상이 추가 공격 1회마다 5% 증가하고, 최대 추가 20% 증가합니다."
  },
  AwakerTalent_74113_TalentDesc_6 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「광기의 속박」이 보존과 예비를 획득합니다. 피해를 가하려는 적이 받는 판디아의 능동 피해가 [Arg3]% 증가하며, 대상이 추가 공격 1회마다 5% 증가하고, 최대 추가 20% 증가합니다."
  },
  AwakerTalent_74113_TalentDesc_7 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「광기의 속박」이 보존과 예비를 획득합니다. 피해를 가하려는 적이 받는 판디아의 능동 피해가 [Arg3]% 증가하며, 대상이 추가 공격 1회마다 5% 증가하고, 최대 추가 20% 증가합니다."
  },
  AwakerTalent_74113_TalentDesc_8 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「광기의 속박」이 보존과 예비를 획득합니다. 피해를 가하려는 적이 받는 판디아의 능동 피해가 [Arg3]% 증가하며, 대상이 추가 공격 1회마다 5% 증가하고, 최대 추가 20% 증가합니다."
  },
  AwakerTalent_74113_TalentDesc_9 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·「광기의 속박」이 보존과 예비를 획득합니다. 피해를 가하려는 적이 받는 판디아의 능동 피해가 [Arg3]% 증가하며, 대상이 추가 공격 1회마다 5% 증가하고, 최대 추가 20% 증가합니다."
  },
  AwakerTalent_74113_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74113_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74113_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74113_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74113_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74113_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74113_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74113_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74113_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74113_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74114_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 아이기스가 매 턴 처음 명령 카드를 사용할 때, 아이기스 은열쇠 충전 [Arg3]%만큼의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74114_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 아이기스가 매 턴 처음 명령 카드를 사용할 때, 아이기스 은열쇠 충전 [Arg3]%만큼의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74114_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 아이기스가 매 턴 처음 명령 카드를 사용할 때, 아이기스 은열쇠 충전 [Arg3]%만큼의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74114_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 아이기스가 매 턴 처음 명령 카드를 사용할 때, 아이기스 은열쇠 충전 [Arg3]%만큼의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74114_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 아이기스가 매 턴 처음 명령 카드를 사용할 때, 아이기스 은열쇠 충전 [Arg3]%만큼의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74114_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 아이기스가 매 턴 처음 명령 카드를 사용할 때, 아이기스 은열쇠 충전 [Arg3]%만큼의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74114_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 아이기스가 매 턴 처음 명령 카드를 사용할 때, 아이기스 은열쇠 충전 [Arg3]%만큼의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74114_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 아이기스가 매 턴 처음 명령 카드를 사용할 때, 아이기스 은열쇠 충전 [Arg3]%만큼의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74114_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 아이기스가 매 턴 처음 명령 카드를 사용할 때, 아이기스 은열쇠 충전 [Arg3]%만큼의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74114_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 아이기스가 매 턴 처음 명령 카드를 사용할 때, 아이기스 은열쇠 충전 [Arg3]%만큼의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74114_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74114_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74114_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74114_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74114_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74114_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74114_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74114_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74114_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74114_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74115_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 처음 [Arg3]번 사용하는 「피여, 소리질러라!」가 「산술 조화」 스택을 추가하지 않습니다. 유우하시의 기본 피해가 [Arg4]％ 증가하며, HP이 25％ 미만일 때 효과가 두 배로 증가합니다."
  },
  AwakerTalent_74115_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 처음 [Arg3]번 사용하는 「피여, 소리질러라!」가 「산술 조화」 스택을 추가하지 않습니다. 유우하시의 기본 피해가 [Arg4]％ 증가하며, HP이 25％ 미만일 때 효과가 두 배로 증가합니다."
  },
  AwakerTalent_74115_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 처음 [Arg3]번 사용하는 「피여, 소리질러라!」가 「산술 조화」 스택을 추가하지 않습니다. 유우하시의 기본 피해가 [Arg4]％ 증가하며, HP이 25％ 미만일 때 효과가 두 배로 증가합니다."
  },
  AwakerTalent_74115_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 처음 [Arg3]번 사용하는 「피여, 소리질러라!」가 「산술 조화」 스택을 추가하지 않습니다. 유우하시의 기본 피해가 [Arg4]％ 증가하며, HP이 25％ 미만일 때 효과가 두 배로 증가합니다."
  },
  AwakerTalent_74115_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 처음 [Arg3]번 사용하는 「피여, 소리질러라!」가 「산술 조화」 스택을 추가하지 않습니다. 유우하시의 기본 피해가 [Arg4]％ 증가하며, HP이 25％ 미만일 때 효과가 두 배로 증가합니다."
  },
  AwakerTalent_74115_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 처음 [Arg3]번 사용하는 「피여, 소리질러라!」가 「산술 조화」 스택을 추가하지 않습니다. 유우하시의 기본 피해가 [Arg4]％ 증가하며, HP이 25％ 미만일 때 효과가 두 배로 증가합니다."
  },
  AwakerTalent_74115_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 처음 [Arg3]번 사용하는 「피여, 소리질러라!」가 「산술 조화」 스택을 추가하지 않습니다. 유우하시의 기본 피해가 [Arg4]％ 증가하며, HP이 25％ 미만일 때 효과가 두 배로 증가합니다."
  },
  AwakerTalent_74115_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 처음 [Arg3]번 사용하는 「피여, 소리질러라!」가 「산술 조화」 스택을 추가하지 않습니다. 유우하시의 기본 피해가 [Arg4]％ 증가하며, HP이 25％ 미만일 때 효과가 두 배로 증가합니다."
  },
  AwakerTalent_74115_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 처음 [Arg3]번 사용하는 「피여, 소리질러라!」가 「산술 조화」 스택을 추가하지 않습니다. 유우하시의 기본 피해가 [Arg4]％ 증가하며, HP이 25％ 미만일 때 효과가 두 배로 증가합니다."
  },
  AwakerTalent_74115_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 매 턴 처음 [Arg3]번 사용하는 「피여, 소리질러라!」가 「산술 조화」 스택을 추가하지 않습니다. 유우하시의 기본 피해가 [Arg4]％ 증가하며, HP이 25％ 미만일 때 효과가 두 배로 증가합니다."
  },
  AwakerTalent_74115_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74115_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74115_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74115_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74115_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74115_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74115_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74115_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74115_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74115_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74116_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 타이스의 「포식」으로 배아를 소모할 때, 은열쇠 충전 [Arg3]%의 은열쇠 에너지를 획득합니다. 「성결의 자식」을 소모했을 경우엔 효과가 2배가 됩니다."
  },
  AwakerTalent_74116_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 타이스의 「포식」으로 배아를 소모할 때, 은열쇠 충전 [Arg3]%의 은열쇠 에너지를 획득합니다. 「성결의 자식」을 소모했을 경우엔 효과가 2배가 됩니다."
  },
  AwakerTalent_74116_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 타이스의 「포식」으로 배아를 소모할 때, 은열쇠 충전 [Arg3]%의 은열쇠 에너지를 획득합니다. 「성결의 자식」을 소모했을 경우엔 효과가 2배가 됩니다."
  },
  AwakerTalent_74116_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 타이스의 「포식」으로 배아를 소모할 때, 은열쇠 충전 [Arg3]%의 은열쇠 에너지를 획득합니다. 「성결의 자식」을 소모했을 경우엔 효과가 2배가 됩니다."
  },
  AwakerTalent_74116_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 타이스의 「포식」으로 배아를 소모할 때, 은열쇠 충전 [Arg3]%의 은열쇠 에너지를 획득합니다. 「성결의 자식」을 소모했을 경우엔 효과가 2배가 됩니다."
  },
  AwakerTalent_74116_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 타이스의 「포식」으로 배아를 소모할 때, 은열쇠 충전 [Arg3]%의 은열쇠 에너지를 획득합니다. 「성결의 자식」을 소모했을 경우엔 효과가 2배가 됩니다."
  },
  AwakerTalent_74116_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 타이스의 「포식」으로 배아를 소모할 때, 은열쇠 충전 [Arg3]%의 은열쇠 에너지를 획득합니다. 「성결의 자식」을 소모했을 경우엔 효과가 2배가 됩니다."
  },
  AwakerTalent_74116_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 타이스의 「포식」으로 배아를 소모할 때, 은열쇠 충전 [Arg3]%의 은열쇠 에너지를 획득합니다. 「성결의 자식」을 소모했을 경우엔 효과가 2배가 됩니다."
  },
  AwakerTalent_74116_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 타이스의 「포식」으로 배아를 소모할 때, 은열쇠 충전 [Arg3]%의 은열쇠 에너지를 획득합니다. 「성결의 자식」을 소모했을 경우엔 효과가 2배가 됩니다."
  },
  AwakerTalent_74116_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 타이스의 「포식」으로 배아를 소모할 때, 은열쇠 충전 [Arg3]%의 은열쇠 에너지를 획득합니다. 「성결의 자식」을 소모했을 경우엔 효과가 2배가 됩니다."
  },
  AwakerTalent_74116_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74116_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74116_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74116_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74116_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74116_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74116_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74116_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74116_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74116_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74117_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「소멸」발동 후 윙클이 [Arg3] 광기를 획득합니다. 3턴의 쿨타임을 가집니다."
  },
  AwakerTalent_74117_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「소멸」발동 후 윙클이 [Arg3] 광기를 획득합니다. 3턴의 쿨타임을 가집니다."
  },
  AwakerTalent_74117_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「소멸」발동 후 윙클이 [Arg3] 광기를 획득합니다. 3턴의 쿨타임을 가집니다."
  },
  AwakerTalent_74117_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「소멸」발동 후 윙클이 [Arg3] 광기를 획득합니다. 3턴의 쿨타임을 가집니다."
  },
  AwakerTalent_74117_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「소멸」발동 후 윙클이 [Arg3] 광기를 획득합니다. 3턴의 쿨타임을 가집니다."
  },
  AwakerTalent_74117_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「소멸」발동 후 윙클이 [Arg3] 광기를 획득합니다. 3턴의 쿨타임을 가집니다."
  },
  AwakerTalent_74117_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「소멸」발동 후 윙클이 [Arg3] 광기를 획득합니다. 3턴의 쿨타임을 가집니다."
  },
  AwakerTalent_74117_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「소멸」발동 후 윙클이 [Arg3] 광기를 획득합니다. 3턴의 쿨타임을 가집니다."
  },
  AwakerTalent_74117_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「소멸」발동 후 윙클이 [Arg3] 광기를 획득합니다. 3턴의 쿨타임을 가집니다."
  },
  AwakerTalent_74117_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「소멸」발동 후 윙클이 [Arg3] 광기를 획득합니다. 3턴의 쿨타임을 가집니다."
  },
  AwakerTalent_74117_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74117_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74117_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74117_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74117_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74117_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74117_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74117_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74117_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74117_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74118_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·골리아가 입히는 기본 피해가 [Arg3]% 증가하며, 「거대한 검의 위엄」이 골리아가 입히는 최종 피해를 일시적으로 [Arg4]% 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체의 힘 증가 효과가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74118_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·골리아가 입히는 기본 피해가 [Arg3]% 증가하며, 「거대한 검의 위엄」이 골리아가 입히는 최종 피해를 일시적으로 [Arg4]% 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체의 힘 증가 효과가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74118_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·골리아가 입히는 기본 피해가 [Arg3]% 증가하며, 「거대한 검의 위엄」이 골리아가 입히는 최종 피해를 일시적으로 [Arg4]% 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체의 힘 증가 효과가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74118_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·골리아가 입히는 기본 피해가 [Arg3]% 증가하며, 「거대한 검의 위엄」이 골리아가 입히는 최종 피해를 일시적으로 [Arg4]% 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체의 힘 증가 효과가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74118_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·골리아가 입히는 기본 피해가 [Arg3]% 증가하며, 「거대한 검의 위엄」이 골리아가 입히는 최종 피해를 일시적으로 [Arg4]% 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체의 힘 증가 효과가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74118_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·골리아가 입히는 기본 피해가 [Arg3]% 증가하며, 「거대한 검의 위엄」이 골리아가 입히는 최종 피해를 일시적으로 [Arg4]% 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체의 힘 증가 효과가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74118_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·골리아가 입히는 기본 피해가 [Arg3]% 증가하며, 「거대한 검의 위엄」이 골리아가 입히는 최종 피해를 일시적으로 [Arg4]% 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체의 힘 증가 효과가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74118_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·골리아가 입히는 기본 피해가 [Arg3]% 증가하며, 「거대한 검의 위엄」이 골리아가 입히는 최종 피해를 일시적으로 [Arg4]% 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체의 힘 증가 효과가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74118_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·골리아가 입히는 기본 피해가 [Arg3]% 증가하며, 「거대한 검의 위엄」이 골리아가 입히는 최종 피해를 일시적으로 [Arg4]% 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체의 힘 증가 효과가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74118_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·골리아가 입히는 기본 피해가 [Arg3]% 증가하며, 「거대한 검의 위엄」이 골리아가 입히는 최종 피해를 일시적으로 [Arg4]% 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 경우, 모든 깨어남체의 힘 증가 효과가 추가로 6%/15%/30% 증가합니다."
  },
  AwakerTalent_74118_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74118_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74118_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74118_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74118_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74118_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74118_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74118_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74118_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74118_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74119_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 타비가 본래 소속이 다른 깨어남체의 카드를 사용하면, 이번 턴 동안 해당 깨어남체의 최종 피해, 방어막 획득량, HP 회복량이 [Arg3]％ 증가합니다. 해당 효과는 중첩되지 않습니다."
  },
  AwakerTalent_74119_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 타비가 본래 소속이 다른 깨어남체의 카드를 사용하면, 이번 턴 동안 해당 깨어남체의 최종 피해, 방어막 획득량, HP 회복량이 [Arg3]％ 증가합니다. 해당 효과는 중첩되지 않습니다."
  },
  AwakerTalent_74119_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 타비가 본래 소속이 다른 깨어남체의 카드를 사용하면, 이번 턴 동안 해당 깨어남체의 최종 피해, 방어막 획득량, HP 회복량이 [Arg3]％ 증가합니다. 해당 효과는 중첩되지 않습니다."
  },
  AwakerTalent_74119_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 타비가 본래 소속이 다른 깨어남체의 카드를 사용하면, 이번 턴 동안 해당 깨어남체의 최종 피해, 방어막 획득량, HP 회복량이 [Arg3]％ 증가합니다. 해당 효과는 중첩되지 않습니다."
  },
  AwakerTalent_74119_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 타비가 본래 소속이 다른 깨어남체의 카드를 사용하면, 이번 턴 동안 해당 깨어남체의 최종 피해, 방어막 획득량, HP 회복량이 [Arg3]％ 증가합니다. 해당 효과는 중첩되지 않습니다."
  },
  AwakerTalent_74119_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 타비가 본래 소속이 다른 깨어남체의 카드를 사용하면, 이번 턴 동안 해당 깨어남체의 최종 피해, 방어막 획득량, HP 회복량이 [Arg3]％ 증가합니다. 해당 효과는 중첩되지 않습니다."
  },
  AwakerTalent_74119_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 타비가 본래 소속이 다른 깨어남체의 카드를 사용하면, 이번 턴 동안 해당 깨어남체의 최종 피해, 방어막 획득량, HP 회복량이 [Arg3]％ 증가합니다. 해당 효과는 중첩되지 않습니다."
  },
  AwakerTalent_74119_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 타비가 본래 소속이 다른 깨어남체의 카드를 사용하면, 이번 턴 동안 해당 깨어남체의 최종 피해, 방어막 획득량, HP 회복량이 [Arg3]％ 증가합니다. 해당 효과는 중첩되지 않습니다."
  },
  AwakerTalent_74119_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 타비가 본래 소속이 다른 깨어남체의 카드를 사용하면, 이번 턴 동안 해당 깨어남체의 최종 피해, 방어막 획득량, HP 회복량이 [Arg3]％ 증가합니다. 해당 효과는 중첩되지 않습니다."
  },
  AwakerTalent_74119_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 타비가 본래 소속이 다른 깨어남체의 카드를 사용하면, 이번 턴 동안 해당 깨어남체의 최종 피해, 방어막 획득량, HP 회복량이 [Arg3]％ 증가합니다. 해당 효과는 중첩되지 않습니다."
  },
  AwakerTalent_74119_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74119_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74119_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74119_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74119_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74119_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74119_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74119_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74119_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74119_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74120_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 로탄의 명령 카드로 인한 기본 피해가 [Arg3]% 증가합니다. 로탄이 피해를 1회 가할 때마다, 해당 턴 로탄이 가하는 최종 피해가 5% 증가하며, 최대 [Arg4]%까지 증가합니다."
  },
  AwakerTalent_74120_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 로탄의 명령 카드로 인한 기본 피해가 [Arg3]% 증가합니다. 로탄이 피해를 1회 가할 때마다, 해당 턴 로탄이 가하는 최종 피해가 5% 증가하며, 최대 [Arg4]%까지 증가합니다."
  },
  AwakerTalent_74120_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 로탄의 명령 카드로 인한 기본 피해가 [Arg3]% 증가합니다. 로탄이 피해를 1회 가할 때마다, 해당 턴 로탄이 가하는 최종 피해가 5% 증가하며, 최대 [Arg4]%까지 증가합니다."
  },
  AwakerTalent_74120_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 로탄의 명령 카드로 인한 기본 피해가 [Arg3]% 증가합니다. 로탄이 피해를 1회 가할 때마다, 해당 턴 로탄이 가하는 최종 피해가 5% 증가하며, 최대 [Arg4]%까지 증가합니다."
  },
  AwakerTalent_74120_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 로탄의 명령 카드로 인한 기본 피해가 [Arg3]% 증가합니다. 로탄이 피해를 1회 가할 때마다, 해당 턴 로탄이 가하는 최종 피해가 5% 증가하며, 최대 [Arg4]%까지 증가합니다."
  },
  AwakerTalent_74120_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 로탄의 명령 카드로 인한 기본 피해가 [Arg3]% 증가합니다. 로탄이 피해를 1회 가할 때마다, 해당 턴 로탄이 가하는 최종 피해가 5% 증가하며, 최대 [Arg4]%까지 증가합니다."
  },
  AwakerTalent_74120_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 로탄의 명령 카드로 인한 기본 피해가 [Arg3]% 증가합니다. 로탄이 피해를 1회 가할 때마다, 해당 턴 로탄이 가하는 최종 피해가 5% 증가하며, 최대 [Arg4]%까지 증가합니다."
  },
  AwakerTalent_74120_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 로탄의 명령 카드로 인한 기본 피해가 [Arg3]% 증가합니다. 로탄이 피해를 1회 가할 때마다, 해당 턴 로탄이 가하는 최종 피해가 5% 증가하며, 최대 [Arg4]%까지 증가합니다."
  },
  AwakerTalent_74120_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 로탄의 명령 카드로 인한 기본 피해가 [Arg3]% 증가합니다. 로탄이 피해를 1회 가할 때마다, 해당 턴 로탄이 가하는 최종 피해가 5% 증가하며, 최대 [Arg4]%까지 증가합니다."
  },
  AwakerTalent_74120_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 로탄의 명령 카드로 인한 기본 피해가 [Arg3]% 증가합니다. 로탄이 피해를 1회 가할 때마다, 해당 턴 로탄이 가하는 최종 피해가 5% 증가하며, 최대 [Arg4]%까지 증가합니다."
  },
  AwakerTalent_74120_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74120_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74120_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74120_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74120_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74120_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74120_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74120_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74120_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74120_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74121_TalentDesc_1 = {
    Text = "· 이 특성은 「별의 시대」 스테이지에서만 발동한다.\n\n· 해당 깨어남체의 체질, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]의 열쇠 에너지를 획득한다.\n\n· 모든 깨어남체의 힘 감소 효과가 [Arg3]% 증가한다."
  },
  AwakerTalent_74121_TalentDesc_10 = {
    Text = "· 이 특성은 「별의 시대」 스테이지에서만 발동한다.\n\n· 해당 깨어남체의 체질, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]의 열쇠 에너지를 획득한다.\n\n· 모든 깨어남체의 힘 감소 효과가 [Arg3]% 증가한다."
  },
  AwakerTalent_74121_TalentDesc_2 = {
    Text = "· 이 특성은 「별의 시대」 스테이지에서만 발동한다.\n\n· 해당 깨어남체의 체질, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]의 열쇠 에너지를 획득한다.\n\n· 모든 깨어남체의 힘 감소 효과가 [Arg3]% 증가한다."
  },
  AwakerTalent_74121_TalentDesc_3 = {
    Text = "· 이 특성은 「별의 시대」 스테이지에서만 발동한다.\n\n· 해당 깨어남체의 체질, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]의 열쇠 에너지를 획득한다.\n\n· 모든 깨어남체의 힘 감소 효과가 [Arg3]% 증가한다."
  },
  AwakerTalent_74121_TalentDesc_4 = {
    Text = "· 이 특성은 「별의 시대」 스테이지에서만 발동한다.\n\n· 해당 깨어남체의 체질, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]의 열쇠 에너지를 획득한다.\n\n· 모든 깨어남체의 힘 감소 효과가 [Arg3]% 증가한다."
  },
  AwakerTalent_74121_TalentDesc_5 = {
    Text = "· 이 특성은 「별의 시대」 스테이지에서만 발동한다.\n\n· 해당 깨어남체의 체질, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]의 열쇠 에너지를 획득한다.\n\n· 모든 깨어남체의 힘 감소 효과가 [Arg3]% 증가한다."
  },
  AwakerTalent_74121_TalentDesc_6 = {
    Text = "· 이 특성은 「별의 시대」 스테이지에서만 발동한다.\n\n· 해당 깨어남체의 체질, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]의 열쇠 에너지를 획득한다.\n\n· 모든 깨어남체의 힘 감소 효과가 [Arg3]% 증가한다."
  },
  AwakerTalent_74121_TalentDesc_7 = {
    Text = "· 이 특성은 「별의 시대」 스테이지에서만 발동한다.\n\n· 해당 깨어남체의 체질, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]의 열쇠 에너지를 획득한다.\n\n· 모든 깨어남체의 힘 감소 효과가 [Arg3]% 증가한다."
  },
  AwakerTalent_74121_TalentDesc_8 = {
    Text = "· 이 특성은 「별의 시대」 스테이지에서만 발동한다.\n\n· 해당 깨어남체의 체질, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]의 열쇠 에너지를 획득한다.\n\n· 모든 깨어남체의 힘 감소 효과가 [Arg3]% 증가한다."
  },
  AwakerTalent_74121_TalentDesc_9 = {
    Text = "· 이 특성은 「별의 시대」 스테이지에서만 발동한다.\n\n· 해당 깨어남체의 체질, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2]의 열쇠 에너지를 획득한다.\n\n· 모든 깨어남체의 힘 감소 효과가 [Arg3]% 증가한다."
  },
  AwakerTalent_74121_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74121_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74121_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74121_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74121_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74121_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74121_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74121_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74121_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74121_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74122_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「서서히 퍼지는 선율」 사용 시 모든 「인간형」 적이 입히는 피해가 일시적으로 [Arg4]% 감소하며, 해당 효과는 중첩되지 않습니다. 「진혼곡」이 [Arg3] 광기를 획득하며, 부정적 상태를 1개 해제할 때마다 추가로 1회 획득합니다."
  },
  AwakerTalent_74122_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「서서히 퍼지는 선율」 사용 시 모든 「인간형」 적이 입히는 피해가 일시적으로 [Arg4]% 감소하며, 해당 효과는 중첩되지 않습니다. 「진혼곡」이 [Arg3] 광기를 획득하며, 부정적 상태를 1개 해제할 때마다 추가로 1회 획득합니다."
  },
  AwakerTalent_74122_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「서서히 퍼지는 선율」 사용 시 모든 「인간형」 적이 입히는 피해가 일시적으로 [Arg4]% 감소하며, 해당 효과는 중첩되지 않습니다. 「진혼곡」이 [Arg3] 광기를 획득하며, 부정적 상태를 1개 해제할 때마다 추가로 1회 획득합니다."
  },
  AwakerTalent_74122_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「서서히 퍼지는 선율」 사용 시 모든 「인간형」 적이 입히는 피해가 일시적으로 [Arg4]% 감소하며, 해당 효과는 중첩되지 않습니다. 「진혼곡」이 [Arg3] 광기를 획득하며, 부정적 상태를 1개 해제할 때마다 추가로 1회 획득합니다."
  },
  AwakerTalent_74122_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「서서히 퍼지는 선율」 사용 시 모든 「인간형」 적이 입히는 피해가 일시적으로 [Arg4]% 감소하며, 해당 효과는 중첩되지 않습니다. 「진혼곡」이 [Arg3] 광기를 획득하며, 부정적 상태를 1개 해제할 때마다 추가로 1회 획득합니다."
  },
  AwakerTalent_74122_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「서서히 퍼지는 선율」 사용 시 모든 「인간형」 적이 입히는 피해가 일시적으로 [Arg4]% 감소하며, 해당 효과는 중첩되지 않습니다. 「진혼곡」이 [Arg3] 광기를 획득하며, 부정적 상태를 1개 해제할 때마다 추가로 1회 획득합니다."
  },
  AwakerTalent_74122_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「서서히 퍼지는 선율」 사용 시 모든 「인간형」 적이 입히는 피해가 일시적으로 [Arg4]% 감소하며, 해당 효과는 중첩되지 않습니다. 「진혼곡」이 [Arg3] 광기를 획득하며, 부정적 상태를 1개 해제할 때마다 추가로 1회 획득합니다."
  },
  AwakerTalent_74122_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「서서히 퍼지는 선율」 사용 시 모든 「인간형」 적이 입히는 피해가 일시적으로 [Arg4]% 감소하며, 해당 효과는 중첩되지 않습니다. 「진혼곡」이 [Arg3] 광기를 획득하며, 부정적 상태를 1개 해제할 때마다 추가로 1회 획득합니다."
  },
  AwakerTalent_74122_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「서서히 퍼지는 선율」 사용 시 모든 「인간형」 적이 입히는 피해가 일시적으로 [Arg4]% 감소하며, 해당 효과는 중첩되지 않습니다. 「진혼곡」이 [Arg3] 광기를 획득하며, 부정적 상태를 1개 해제할 때마다 추가로 1회 획득합니다."
  },
  AwakerTalent_74122_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「서서히 퍼지는 선율」 사용 시 모든 「인간형」 적이 입히는 피해가 일시적으로 [Arg4]% 감소하며, 해당 효과는 중첩되지 않습니다. 「진혼곡」이 [Arg3] 광기를 획득하며, 부정적 상태를 1개 해제할 때마다 추가로 1회 획득합니다."
  },
  AwakerTalent_74122_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74122_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74122_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74122_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74122_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74122_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74122_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74122_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74122_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74122_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74123_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「타격」과「심안의 칼날」이 주는 기본 피해가 이번 턴 동안 획득한 방어막 양의 [Arg3]%만큼 증가합니다. 엘바가 「혈육」영역의 적에게 주는 최종 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74123_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「타격」과「심안의 칼날」이 주는 기본 피해가 이번 턴 동안 획득한 방어막 양의 [Arg3]%만큼 증가합니다. 엘바가 「혈육」영역의 적에게 주는 최종 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74123_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「타격」과「심안의 칼날」이 주는 기본 피해가 이번 턴 동안 획득한 방어막 양의 [Arg3]%만큼 증가합니다. 엘바가 「혈육」영역의 적에게 주는 최종 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74123_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「타격」과「심안의 칼날」이 주는 기본 피해가 이번 턴 동안 획득한 방어막 양의 [Arg3]%만큼 증가합니다. 엘바가 「혈육」영역의 적에게 주는 최종 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74123_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「타격」과「심안의 칼날」이 주는 기본 피해가 이번 턴 동안 획득한 방어막 양의 [Arg3]%만큼 증가합니다. 엘바가 「혈육」영역의 적에게 주는 최종 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74123_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「타격」과「심안의 칼날」이 주는 기본 피해가 이번 턴 동안 획득한 방어막 양의 [Arg3]%만큼 증가합니다. 엘바가 「혈육」영역의 적에게 주는 최종 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74123_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「타격」과「심안의 칼날」이 주는 기본 피해가 이번 턴 동안 획득한 방어막 양의 [Arg3]%만큼 증가합니다. 엘바가 「혈육」영역의 적에게 주는 최종 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74123_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「타격」과「심안의 칼날」이 주는 기본 피해가 이번 턴 동안 획득한 방어막 양의 [Arg3]%만큼 증가합니다. 엘바가 「혈육」영역의 적에게 주는 최종 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74123_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「타격」과「심안의 칼날」이 주는 기본 피해가 이번 턴 동안 획득한 방어막 양의 [Arg3]%만큼 증가합니다. 엘바가 「혈육」영역의 적에게 주는 최종 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74123_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「타격」과「심안의 칼날」이 주는 기본 피해가 이번 턴 동안 획득한 방어막 양의 [Arg3]%만큼 증가합니다. 엘바가 「혈육」영역의 적에게 주는 최종 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74123_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74123_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74123_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74123_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74123_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74123_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74123_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74123_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74123_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74123_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74124_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 돌이 생성하는 광기와 광기 폭발로 인한 치료 효과가 [Arg3]% 증가하며, 팀에 다른 혼돈 영역 깨어남체가 1명 있을 때마다 이 효과가 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_74124_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 돌이 생성하는 광기와 광기 폭발로 인한 치료 효과가 [Arg3]% 증가하며, 팀에 다른 혼돈 영역 깨어남체가 1명 있을 때마다 이 효과가 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_74124_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 돌이 생성하는 광기와 광기 폭발로 인한 치료 효과가 [Arg3]% 증가하며, 팀에 다른 혼돈 영역 깨어남체가 1명 있을 때마다 이 효과가 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_74124_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 돌이 생성하는 광기와 광기 폭발로 인한 치료 효과가 [Arg3]% 증가하며, 팀에 다른 혼돈 영역 깨어남체가 1명 있을 때마다 이 효과가 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_74124_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 돌이 생성하는 광기와 광기 폭발로 인한 치료 효과가 [Arg3]% 증가하며, 팀에 다른 혼돈 영역 깨어남체가 1명 있을 때마다 이 효과가 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_74124_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 돌이 생성하는 광기와 광기 폭발로 인한 치료 효과가 [Arg3]% 증가하며, 팀에 다른 혼돈 영역 깨어남체가 1명 있을 때마다 이 효과가 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_74124_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 돌이 생성하는 광기와 광기 폭발로 인한 치료 효과가 [Arg3]% 증가하며, 팀에 다른 혼돈 영역 깨어남체가 1명 있을 때마다 이 효과가 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_74124_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 돌이 생성하는 광기와 광기 폭발로 인한 치료 효과가 [Arg3]% 증가하며, 팀에 다른 혼돈 영역 깨어남체가 1명 있을 때마다 이 효과가 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_74124_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 돌이 생성하는 광기와 광기 폭발로 인한 치료 효과가 [Arg3]% 증가하며, 팀에 다른 혼돈 영역 깨어남체가 1명 있을 때마다 이 효과가 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_74124_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 돌이 생성하는 광기와 광기 폭발로 인한 치료 효과가 [Arg3]% 증가하며, 팀에 다른 혼돈 영역 깨어남체가 1명 있을 때마다 이 효과가 추가로 [Arg4]% 증가합니다."
  },
  AwakerTalent_74124_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74124_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74124_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74124_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74124_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74124_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74124_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74124_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74124_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74124_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74125_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 셀레스트가 입히는 촉수 피해가 [Arg3]% 증가하며 턴마다 처음으로 셀레스트의 명령 카드를 사용한 후 추가로 특성 「항해의 호각」이 4회 발동합니다."
  },
  AwakerTalent_74125_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 셀레스트가 입히는 촉수 피해가 [Arg3]% 증가하며 턴마다 처음으로 셀레스트의 명령 카드를 사용한 후 추가로 특성 「항해의 호각」이 4회 발동합니다."
  },
  AwakerTalent_74125_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 셀레스트가 입히는 촉수 피해가 [Arg3]% 증가하며 턴마다 처음으로 셀레스트의 명령 카드를 사용한 후 추가로 특성 「항해의 호각」이 4회 발동합니다."
  },
  AwakerTalent_74125_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 셀레스트가 입히는 촉수 피해가 [Arg3]% 증가하며 턴마다 처음으로 셀레스트의 명령 카드를 사용한 후 추가로 특성 「항해의 호각」이 4회 발동합니다."
  },
  AwakerTalent_74125_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 셀레스트가 입히는 촉수 피해가 [Arg3]% 증가하며 턴마다 처음으로 셀레스트의 명령 카드를 사용한 후 추가로 특성 「항해의 호각」이 4회 발동합니다."
  },
  AwakerTalent_74125_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 셀레스트가 입히는 촉수 피해가 [Arg3]% 증가하며 턴마다 처음으로 셀레스트의 명령 카드를 사용한 후 추가로 특성 「항해의 호각」이 4회 발동합니다."
  },
  AwakerTalent_74125_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 셀레스트가 입히는 촉수 피해가 [Arg3]% 증가하며 턴마다 처음으로 셀레스트의 명령 카드를 사용한 후 추가로 특성 「항해의 호각」이 4회 발동합니다."
  },
  AwakerTalent_74125_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 셀레스트가 입히는 촉수 피해가 [Arg3]% 증가하며 턴마다 처음으로 셀레스트의 명령 카드를 사용한 후 추가로 특성 「항해의 호각」이 4회 발동합니다."
  },
  AwakerTalent_74125_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 셀레스트가 입히는 촉수 피해가 [Arg3]% 증가하며 턴마다 처음으로 셀레스트의 명령 카드를 사용한 후 추가로 특성 「항해의 호각」이 4회 발동합니다."
  },
  AwakerTalent_74125_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 셀레스트가 입히는 촉수 피해가 [Arg3]% 증가하며 턴마다 처음으로 셀레스트의 명령 카드를 사용한 후 추가로 특성 「항해의 호각」이 4회 발동합니다."
  },
  AwakerTalent_74125_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74125_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74125_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74125_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74125_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74125_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74125_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74125_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74125_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74125_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74126_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 레아의 힘 획득 효과가 [Arg4]% 증가하며, 레아의 명령 카드를 사용하면 레아 공격력의 [Arg3]%에 해당하는 힘을 얻습니다. 이 효과는 현재 잃은 HP 비율에 따라 최대 200%까지 강화되며, 매 턴 최대 3회 발동합니다."
  },
  AwakerTalent_74126_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 레아의 힘 획득 효과가 [Arg4]% 증가하며, 레아의 명령 카드를 사용하면 레아 공격력의 [Arg3]%에 해당하는 힘을 얻습니다. 이 효과는 현재 잃은 HP 비율에 따라 최대 200%까지 강화되며, 매 턴 최대 3회 발동합니다."
  },
  AwakerTalent_74126_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 레아의 힘 획득 효과가 [Arg4]% 증가하며, 레아의 명령 카드를 사용하면 레아 공격력의 [Arg3]%에 해당하는 힘을 얻습니다. 이 효과는 현재 잃은 HP 비율에 따라 최대 200%까지 강화되며, 매 턴 최대 3회 발동합니다."
  },
  AwakerTalent_74126_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 레아의 힘 획득 효과가 [Arg4]% 증가하며, 레아의 명령 카드를 사용하면 레아 공격력의 [Arg3]%에 해당하는 힘을 얻습니다. 이 효과는 현재 잃은 HP 비율에 따라 최대 200%까지 강화되며, 매 턴 최대 3회 발동합니다."
  },
  AwakerTalent_74126_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 레아의 힘 획득 효과가 [Arg4]% 증가하며, 레아의 명령 카드를 사용하면 레아 공격력의 [Arg3]%에 해당하는 힘을 얻습니다. 이 효과는 현재 잃은 HP 비율에 따라 최대 200%까지 강화되며, 매 턴 최대 3회 발동합니다."
  },
  AwakerTalent_74126_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 레아의 힘 획득 효과가 [Arg4]% 증가하며, 레아의 명령 카드를 사용하면 레아 공격력의 [Arg3]%에 해당하는 힘을 얻습니다. 이 효과는 현재 잃은 HP 비율에 따라 최대 200%까지 강화되며, 매 턴 최대 3회 발동합니다."
  },
  AwakerTalent_74126_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 레아의 힘 획득 효과가 [Arg4]% 증가하며, 레아의 명령 카드를 사용하면 레아 공격력의 [Arg3]%에 해당하는 힘을 얻습니다. 이 효과는 현재 잃은 HP 비율에 따라 최대 200%까지 강화되며, 매 턴 최대 3회 발동합니다."
  },
  AwakerTalent_74126_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 레아의 힘 획득 효과가 [Arg4]% 증가하며, 레아의 명령 카드를 사용하면 레아 공격력의 [Arg3]%에 해당하는 힘을 얻습니다. 이 효과는 현재 잃은 HP 비율에 따라 최대 200%까지 강화되며, 매 턴 최대 3회 발동합니다."
  },
  AwakerTalent_74126_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 레아의 힘 획득 효과가 [Arg4]% 증가하며, 레아의 명령 카드를 사용하면 레아 공격력의 [Arg3]%에 해당하는 힘을 얻습니다. 이 효과는 현재 잃은 HP 비율에 따라 최대 200%까지 강화되며, 매 턴 최대 3회 발동합니다."
  },
  AwakerTalent_74126_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 처음으로 영지 깨어남을 발동했을 때 은열쇠 에너지를 [Arg2] 획득합니다.\n· 레아의 힘 획득 효과가 [Arg4]% 증가하며, 레아의 명령 카드를 사용하면 레아 공격력의 [Arg3]%에 해당하는 힘을 얻습니다. 이 효과는 현재 잃은 HP 비율에 따라 최대 200%까지 강화되며, 매 턴 최대 3회 발동합니다."
  },
  AwakerTalent_74126_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74126_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74126_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74126_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74126_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74126_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74126_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74126_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74126_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74126_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74127_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·손패에 있는  「기묘한 요리」 1장마다 HP 회복량과 방어막 효과가 [Arg4]% 증가하며, 최대 3장까지 중첩됩니다. 「기묘한 요리」를 사용할 때마다 카렌의 중독 부여량이 이번 전투 동안 [Arg3]% 증가하며, 최대 20스택까지 중첩됩니다."
  },
  AwakerTalent_74127_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·손패에 있는  「기묘한 요리」 1장마다 HP 회복량과 방어막 효과가 [Arg4]% 증가하며, 최대 3장까지 중첩됩니다. 「기묘한 요리」를 사용할 때마다 카렌의 중독 부여량이 이번 전투 동안 [Arg3]% 증가하며, 최대 20스택까지 중첩됩니다."
  },
  AwakerTalent_74127_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·손패에 있는  「기묘한 요리」 1장마다 HP 회복량과 방어막 효과가 [Arg4]% 증가하며, 최대 3장까지 중첩됩니다. 「기묘한 요리」를 사용할 때마다 카렌의 중독 부여량이 이번 전투 동안 [Arg3]% 증가하며, 최대 20스택까지 중첩됩니다."
  },
  AwakerTalent_74127_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·손패에 있는  「기묘한 요리」 1장마다 HP 회복량과 방어막 효과가 [Arg4]% 증가하며, 최대 3장까지 중첩됩니다. 「기묘한 요리」를 사용할 때마다 카렌의 중독 부여량이 이번 전투 동안 [Arg3]% 증가하며, 최대 20스택까지 중첩됩니다."
  },
  AwakerTalent_74127_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·손패에 있는  「기묘한 요리」 1장마다 HP 회복량과 방어막 효과가 [Arg4]% 증가하며, 최대 3장까지 중첩됩니다. 「기묘한 요리」를 사용할 때마다 카렌의 중독 부여량이 이번 전투 동안 [Arg3]% 증가하며, 최대 20스택까지 중첩됩니다."
  },
  AwakerTalent_74127_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·손패에 있는  「기묘한 요리」 1장마다 HP 회복량과 방어막 효과가 [Arg4]% 증가하며, 최대 3장까지 중첩됩니다. 「기묘한 요리」를 사용할 때마다 카렌의 중독 부여량이 이번 전투 동안 [Arg3]% 증가하며, 최대 20스택까지 중첩됩니다."
  },
  AwakerTalent_74127_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·손패에 있는  「기묘한 요리」 1장마다 HP 회복량과 방어막 효과가 [Arg4]% 증가하며, 최대 3장까지 중첩됩니다. 「기묘한 요리」를 사용할 때마다 카렌의 중독 부여량이 이번 전투 동안 [Arg3]% 증가하며, 최대 20스택까지 중첩됩니다."
  },
  AwakerTalent_74127_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·손패에 있는  「기묘한 요리」 1장마다 HP 회복량과 방어막 효과가 [Arg4]% 증가하며, 최대 3장까지 중첩됩니다. 「기묘한 요리」를 사용할 때마다 카렌의 중독 부여량이 이번 전투 동안 [Arg3]% 증가하며, 최대 20스택까지 중첩됩니다."
  },
  AwakerTalent_74127_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·손패에 있는  「기묘한 요리」 1장마다 HP 회복량과 방어막 효과가 [Arg4]% 증가하며, 최대 3장까지 중첩됩니다. 「기묘한 요리」를 사용할 때마다 카렌의 중독 부여량이 이번 전투 동안 [Arg3]% 증가하며, 최대 20스택까지 중첩됩니다."
  },
  AwakerTalent_74127_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·손패에 있는  「기묘한 요리」 1장마다 HP 회복량과 방어막 효과가 [Arg4]% 증가하며, 최대 3장까지 중첩됩니다. 「기묘한 요리」를 사용할 때마다 카렌의 중독 부여량이 이번 전투 동안 [Arg3]% 증가하며, 최대 20스택까지 중첩됩니다."
  },
  AwakerTalent_74127_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74127_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74127_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74127_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74127_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74127_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74127_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74127_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74127_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74127_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74128_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「24」의 기본 피해가 [Arg3]％ 증가하며, 「조각가 협회」의 적에게 가하는 최종 피해가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_74128_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「24」의 기본 피해가 [Arg3]％ 증가하며, 「조각가 협회」의 적에게 가하는 최종 피해가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_74128_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「24」의 기본 피해가 [Arg3]％ 증가하며, 「조각가 협회」의 적에게 가하는 최종 피해가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_74128_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「24」의 기본 피해가 [Arg3]％ 증가하며, 「조각가 협회」의 적에게 가하는 최종 피해가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_74128_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「24」의 기본 피해가 [Arg3]％ 증가하며, 「조각가 협회」의 적에게 가하는 최종 피해가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_74128_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「24」의 기본 피해가 [Arg3]％ 증가하며, 「조각가 협회」의 적에게 가하는 최종 피해가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_74128_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「24」의 기본 피해가 [Arg3]％ 증가하며, 「조각가 협회」의 적에게 가하는 최종 피해가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_74128_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「24」의 기본 피해가 [Arg3]％ 증가하며, 「조각가 협회」의 적에게 가하는 최종 피해가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_74128_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「24」의 기본 피해가 [Arg3]％ 증가하며, 「조각가 협회」의 적에게 가하는 최종 피해가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_74128_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「24」의 기본 피해가 [Arg3]％ 증가하며, 「조각가 협회」의 적에게 가하는 최종 피해가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_74128_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74128_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74128_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74128_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74128_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74128_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74128_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74128_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74128_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74128_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74129_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 릴리의 「타격」 최종 피해가 [Arg3]% 증가하며, 보스 전투에서는 증가량이 2배로 상승합니다. 「초차원」 적의 공격을 받은 후, 해당 공격으로 잃은 HP의 [Arg4]%만큼의 지연 회복을 획득합니다. 「보상 타격」의 「인내」에 따른 피해 증가 효과에 [Arg5]% 피해 강화 보너스가 적용됩니다."
  },
  AwakerTalent_74129_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 릴리의 「타격」 최종 피해가 [Arg3]% 증가하며, 보스 전투에서는 증가량이 2배로 상승합니다. 「초차원」 적의 공격을 받은 후, 해당 공격으로 잃은 HP의 [Arg4]%만큼의 지연 회복을 획득합니다. 「보상 타격」의 「인내」에 따른 피해 증가 효과에 [Arg5]% 피해 강화 보너스가 적용됩니다."
  },
  AwakerTalent_74129_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 릴리의 「타격」 최종 피해가 [Arg3]% 증가하며, 보스 전투에서는 증가량이 2배로 상승합니다. 「초차원」 적의 공격을 받은 후, 해당 공격으로 잃은 HP의 [Arg4]%만큼의 지연 회복을 획득합니다. 「보상 타격」의 「인내」에 따른 피해 증가 효과에 [Arg5]% 피해 강화 보너스가 적용됩니다."
  },
  AwakerTalent_74129_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 릴리의 「타격」 최종 피해가 [Arg3]% 증가하며, 보스 전투에서는 증가량이 2배로 상승합니다. 「초차원」 적의 공격을 받은 후, 해당 공격으로 잃은 HP의 [Arg4]%만큼의 지연 회복을 획득합니다. 「보상 타격」의 「인내」에 따른 피해 증가 효과에 [Arg5]% 피해 강화 보너스가 적용됩니다."
  },
  AwakerTalent_74129_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 릴리의 「타격」 최종 피해가 [Arg3]% 증가하며, 보스 전투에서는 증가량이 2배로 상승합니다. 「초차원」 적의 공격을 받은 후, 해당 공격으로 잃은 HP의 [Arg4]%만큼의 지연 회복을 획득합니다. 「보상 타격」의 「인내」에 따른 피해 증가 효과에 [Arg5]% 피해 강화 보너스가 적용됩니다."
  },
  AwakerTalent_74129_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 릴리의 「타격」 최종 피해가 [Arg3]% 증가하며, 보스 전투에서는 증가량이 2배로 상승합니다. 「초차원」 적의 공격을 받은 후, 해당 공격으로 잃은 HP의 [Arg4]%만큼의 지연 회복을 획득합니다. 「보상 타격」의 「인내」에 따른 피해 증가 효과에 [Arg5]% 피해 강화 보너스가 적용됩니다."
  },
  AwakerTalent_74129_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 릴리의 「타격」 최종 피해가 [Arg3]% 증가하며, 보스 전투에서는 증가량이 2배로 상승합니다. 「초차원」 적의 공격을 받은 후, 해당 공격으로 잃은 HP의 [Arg4]%만큼의 지연 회복을 획득합니다. 「보상 타격」의 「인내」에 따른 피해 증가 효과에 [Arg5]% 피해 강화 보너스가 적용됩니다."
  },
  AwakerTalent_74129_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 릴리의 「타격」 최종 피해가 [Arg3]% 증가하며, 보스 전투에서는 증가량이 2배로 상승합니다. 「초차원」 적의 공격을 받은 후, 해당 공격으로 잃은 HP의 [Arg4]%만큼의 지연 회복을 획득합니다. 「보상 타격」의 「인내」에 따른 피해 증가 효과에 [Arg5]% 피해 강화 보너스가 적용됩니다."
  },
  AwakerTalent_74129_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 릴리의 「타격」 최종 피해가 [Arg3]% 증가하며, 보스 전투에서는 증가량이 2배로 상승합니다. 「초차원」 적의 공격을 받은 후, 해당 공격으로 잃은 HP의 [Arg4]%만큼의 지연 회복을 획득합니다. 「보상 타격」의 「인내」에 따른 피해 증가 효과에 [Arg5]% 피해 강화 보너스가 적용됩니다."
  },
  AwakerTalent_74129_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 릴리의 「타격」 최종 피해가 [Arg3]% 증가하며, 보스 전투에서는 증가량이 2배로 상승합니다. 「초차원」 적의 공격을 받은 후, 해당 공격으로 잃은 HP의 [Arg4]%만큼의 지연 회복을 획득합니다. 「보상 타격」의 「인내」에 따른 피해 증가 효과에 [Arg5]% 피해 강화 보너스가 적용됩니다."
  },
  AwakerTalent_74129_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74129_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74129_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74129_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74129_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74129_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74129_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74129_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74129_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74129_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74130_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 소렐이 「포식」 후 공격력 [Arg3]％의 임시 힘을 획득하며, 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74130_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 소렐이 「포식」 후 공격력 [Arg3]％의 임시 힘을 획득하며, 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74130_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 소렐이 「포식」 후 공격력 [Arg3]％의 임시 힘을 획득하며, 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74130_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 소렐이 「포식」 후 공격력 [Arg3]％의 임시 힘을 획득하며, 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74130_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 소렐이 「포식」 후 공격력 [Arg3]％의 임시 힘을 획득하며, 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74130_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 소렐이 「포식」 후 공격력 [Arg3]％의 임시 힘을 획득하며, 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74130_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 소렐이 「포식」 후 공격력 [Arg3]％의 임시 힘을 획득하며, 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74130_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 소렐이 「포식」 후 공격력 [Arg3]％의 임시 힘을 획득하며, 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74130_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 소렐이 「포식」 후 공격력 [Arg3]％의 임시 힘을 획득하며, 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74130_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 소렐이 「포식」 후 공격력 [Arg3]％의 임시 힘을 획득하며, 턴마다 5회까지 발동합니다."
  },
  AwakerTalent_74130_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74130_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74130_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74130_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74130_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74130_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74130_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74130_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74130_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74130_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74131_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」에서 「감지」를 선택한 후, 최대 HP가 원래 최대 HP의 [Arg3]％만큼 증가합니다."
  },
  AwakerTalent_74131_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」에서 「감지」를 선택한 후, 최대 HP가 원래 최대 HP의 [Arg3]％만큼 증가합니다."
  },
  AwakerTalent_74131_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」에서 「감지」를 선택한 후, 최대 HP가 원래 최대 HP의 [Arg3]％만큼 증가합니다."
  },
  AwakerTalent_74131_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」에서 「감지」를 선택한 후, 최대 HP가 원래 최대 HP의 [Arg3]％만큼 증가합니다."
  },
  AwakerTalent_74131_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」에서 「감지」를 선택한 후, 최대 HP가 원래 최대 HP의 [Arg3]％만큼 증가합니다."
  },
  AwakerTalent_74131_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」에서 「감지」를 선택한 후, 최대 HP가 원래 최대 HP의 [Arg3]％만큼 증가합니다."
  },
  AwakerTalent_74131_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」에서 「감지」를 선택한 후, 최대 HP가 원래 최대 HP의 [Arg3]％만큼 증가합니다."
  },
  AwakerTalent_74131_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」에서 「감지」를 선택한 후, 최대 HP가 원래 최대 HP의 [Arg3]％만큼 증가합니다."
  },
  AwakerTalent_74131_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」에서 「감지」를 선택한 후, 최대 HP가 원래 최대 HP의 [Arg3]％만큼 증가합니다."
  },
  AwakerTalent_74131_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」에서 「감지」를 선택한 후, 최대 HP가 원래 최대 HP의 [Arg3]％만큼 증가합니다."
  },
  AwakerTalent_74131_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74131_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74131_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74131_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74131_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74131_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74131_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74131_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74131_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74131_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74132_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 팔로스가 부여하는 중독 수치가 [Arg3]% 증가합니다. 「잃어버린 고대의 도시」 턴 종료 시 모든 촉수가 1회 공격하며, 해당 공격은 [Arg4]%의 피해만을 가합니다. \n· 팀에 다른「레무리아」깨어남체가 1/2/3명 존재할 경우, 피해 증폭이 +20%/50%/100% 증가합니다."
  },
  AwakerTalent_74132_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 팔로스가 부여하는 중독 수치가 [Arg3]% 증가합니다. 「잃어버린 고대의 도시」 턴 종료 시 모든 촉수가 1회 공격하며, 해당 공격은 [Arg4]%의 피해만을 가합니다. \n· 팀에 다른「레무리아」깨어남체가 1/2/3명 존재할 경우, 피해 증폭이 +20%/50%/100% 증가합니다."
  },
  AwakerTalent_74132_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 팔로스가 부여하는 중독 수치가 [Arg3]% 증가합니다. 「잃어버린 고대의 도시」 턴 종료 시 모든 촉수가 1회 공격하며, 해당 공격은 [Arg4]%의 피해만을 가합니다. \n· 팀에 다른「레무리아」깨어남체가 1/2/3명 존재할 경우, 피해 증폭이 +20%/50%/100% 증가합니다."
  },
  AwakerTalent_74132_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 팔로스가 부여하는 중독 수치가 [Arg3]% 증가합니다. 「잃어버린 고대의 도시」 턴 종료 시 모든 촉수가 1회 공격하며, 해당 공격은 [Arg4]%의 피해만을 가합니다. \n· 팀에 다른「레무리아」깨어남체가 1/2/3명 존재할 경우, 피해 증폭이 +20%/50%/100% 증가합니다."
  },
  AwakerTalent_74132_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 팔로스가 부여하는 중독 수치가 [Arg3]% 증가합니다. 「잃어버린 고대의 도시」 턴 종료 시 모든 촉수가 1회 공격하며, 해당 공격은 [Arg4]%의 피해만을 가합니다. \n· 팀에 다른「레무리아」깨어남체가 1/2/3명 존재할 경우, 피해 증폭이 +20%/50%/100% 증가합니다."
  },
  AwakerTalent_74132_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 팔로스가 부여하는 중독 수치가 [Arg3]% 증가합니다. 「잃어버린 고대의 도시」 턴 종료 시 모든 촉수가 1회 공격하며, 해당 공격은 [Arg4]%의 피해만을 가합니다. \n· 팀에 다른「레무리아」깨어남체가 1/2/3명 존재할 경우, 피해 증폭이 +20%/50%/100% 증가합니다."
  },
  AwakerTalent_74132_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 팔로스가 부여하는 중독 수치가 [Arg3]% 증가합니다. 「잃어버린 고대의 도시」 턴 종료 시 모든 촉수가 1회 공격하며, 해당 공격은 [Arg4]%의 피해만을 가합니다. \n· 팀에 다른「레무리아」깨어남체가 1/2/3명 존재할 경우, 피해 증폭이 +20%/50%/100% 증가합니다."
  },
  AwakerTalent_74132_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 팔로스가 부여하는 중독 수치가 [Arg3]% 증가합니다. 「잃어버린 고대의 도시」 턴 종료 시 모든 촉수가 1회 공격하며, 해당 공격은 [Arg4]%의 피해만을 가합니다. \n· 팀에 다른「레무리아」깨어남체가 1/2/3명 존재할 경우, 피해 증폭이 +20%/50%/100% 증가합니다."
  },
  AwakerTalent_74132_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 팔로스가 부여하는 중독 수치가 [Arg3]% 증가합니다. 「잃어버린 고대의 도시」 턴 종료 시 모든 촉수가 1회 공격하며, 해당 공격은 [Arg4]%의 피해만을 가합니다. \n· 팀에 다른「레무리아」깨어남체가 1/2/3명 존재할 경우, 피해 증폭이 +20%/50%/100% 증가합니다."
  },
  AwakerTalent_74132_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 팔로스가 부여하는 중독 수치가 [Arg3]% 증가합니다. 「잃어버린 고대의 도시」 턴 종료 시 모든 촉수가 1회 공격하며, 해당 공격은 [Arg4]%의 피해만을 가합니다. \n· 팀에 다른「레무리아」깨어남체가 1/2/3명 존재할 경우, 피해 증폭이 +20%/50%/100% 증가합니다."
  },
  AwakerTalent_74132_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74132_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74132_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74132_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74132_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74132_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74132_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74132_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74132_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74132_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74133_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 라모나의 은열쇠 충전 [Arg4]%에 해당하는 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74133_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 라모나의 은열쇠 충전 [Arg4]%에 해당하는 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74133_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 라모나의 은열쇠 충전 [Arg4]%에 해당하는 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74133_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 라모나의 은열쇠 충전 [Arg4]%에 해당하는 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74133_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 라모나의 은열쇠 충전 [Arg4]%에 해당하는 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74133_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 라모나의 은열쇠 충전 [Arg4]%에 해당하는 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74133_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 라모나의 은열쇠 충전 [Arg4]%에 해당하는 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74133_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 라모나의 은열쇠 충전 [Arg4]%에 해당하는 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74133_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 라모나의 은열쇠 충전 [Arg4]%에 해당하는 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74133_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 라모나의 은열쇠 충전 [Arg4]%에 해당하는 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74133_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74133_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74133_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74133_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74133_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74133_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74133_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74133_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74133_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74133_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74134_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 히로가 「설원」 적에게 주는 최종 피해가 [Arg3]％ 증가합니다. 히로가 「배아」를 소모할 경우, 이번 턴 다음으로 주는 피해의 크리티컬 피해가 [Arg4]％ 상승합니다."
  },
  AwakerTalent_74134_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 히로가 「설원」 적에게 주는 최종 피해가 [Arg3]％ 증가합니다. 히로가 「배아」를 소모할 경우, 이번 턴 다음으로 주는 피해의 크리티컬 피해가 [Arg4]％ 상승합니다."
  },
  AwakerTalent_74134_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 히로가 「설원」 적에게 주는 최종 피해가 [Arg3]％ 증가합니다. 히로가 「배아」를 소모할 경우, 이번 턴 다음으로 주는 피해의 크리티컬 피해가 [Arg4]％ 상승합니다."
  },
  AwakerTalent_74134_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 히로가 「설원」 적에게 주는 최종 피해가 [Arg3]％ 증가합니다. 히로가 「배아」를 소모할 경우, 이번 턴 다음으로 주는 피해의 크리티컬 피해가 [Arg4]％ 상승합니다."
  },
  AwakerTalent_74134_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 히로가 「설원」 적에게 주는 최종 피해가 [Arg3]％ 증가합니다. 히로가 「배아」를 소모할 경우, 이번 턴 다음으로 주는 피해의 크리티컬 피해가 [Arg4]％ 상승합니다."
  },
  AwakerTalent_74134_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 히로가 「설원」 적에게 주는 최종 피해가 [Arg3]％ 증가합니다. 히로가 「배아」를 소모할 경우, 이번 턴 다음으로 주는 피해의 크리티컬 피해가 [Arg4]％ 상승합니다."
  },
  AwakerTalent_74134_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 히로가 「설원」 적에게 주는 최종 피해가 [Arg3]％ 증가합니다. 히로가 「배아」를 소모할 경우, 이번 턴 다음으로 주는 피해의 크리티컬 피해가 [Arg4]％ 상승합니다."
  },
  AwakerTalent_74134_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 히로가 「설원」 적에게 주는 최종 피해가 [Arg3]％ 증가합니다. 히로가 「배아」를 소모할 경우, 이번 턴 다음으로 주는 피해의 크리티컬 피해가 [Arg4]％ 상승합니다."
  },
  AwakerTalent_74134_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 히로가 「설원」 적에게 주는 최종 피해가 [Arg3]％ 증가합니다. 히로가 「배아」를 소모할 경우, 이번 턴 다음으로 주는 피해의 크리티컬 피해가 [Arg4]％ 상승합니다."
  },
  AwakerTalent_74134_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 히로가 「설원」 적에게 주는 최종 피해가 [Arg3]％ 증가합니다. 히로가 「배아」를 소모할 경우, 이번 턴 다음으로 주는 피해의 크리티컬 피해가 [Arg4]％ 상승합니다."
  },
  AwakerTalent_74134_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74134_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74134_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74134_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74134_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74134_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74134_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74134_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74134_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74134_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74135_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·보스 전투 시작 시, 오를라의 죽음 저항 속성 [Arg3]%만큼 죽음 저항이 증가합니다. 죽음 저항이 발동될 때마다, 턴 종료 시까지 「화려한 장편」의 대응 효과가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74135_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·보스 전투 시작 시, 오를라의 죽음 저항 속성 [Arg3]%만큼 죽음 저항이 증가합니다. 죽음 저항이 발동될 때마다, 턴 종료 시까지 「화려한 장편」의 대응 효과가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74135_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·보스 전투 시작 시, 오를라의 죽음 저항 속성 [Arg3]%만큼 죽음 저항이 증가합니다. 죽음 저항이 발동될 때마다, 턴 종료 시까지 「화려한 장편」의 대응 효과가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74135_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·보스 전투 시작 시, 오를라의 죽음 저항 속성 [Arg3]%만큼 죽음 저항이 증가합니다. 죽음 저항이 발동될 때마다, 턴 종료 시까지 「화려한 장편」의 대응 효과가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74135_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·보스 전투 시작 시, 오를라의 죽음 저항 속성 [Arg3]%만큼 죽음 저항이 증가합니다. 죽음 저항이 발동될 때마다, 턴 종료 시까지 「화려한 장편」의 대응 효과가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74135_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·보스 전투 시작 시, 오를라의 죽음 저항 속성 [Arg3]%만큼 죽음 저항이 증가합니다. 죽음 저항이 발동될 때마다, 턴 종료 시까지 「화려한 장편」의 대응 효과가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74135_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·보스 전투 시작 시, 오를라의 죽음 저항 속성 [Arg3]%만큼 죽음 저항이 증가합니다. 죽음 저항이 발동될 때마다, 턴 종료 시까지 「화려한 장편」의 대응 효과가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74135_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·보스 전투 시작 시, 오를라의 죽음 저항 속성 [Arg3]%만큼 죽음 저항이 증가합니다. 죽음 저항이 발동될 때마다, 턴 종료 시까지 「화려한 장편」의 대응 효과가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74135_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·보스 전투 시작 시, 오를라의 죽음 저항 속성 [Arg3]%만큼 죽음 저항이 증가합니다. 죽음 저항이 발동될 때마다, 턴 종료 시까지 「화려한 장편」의 대응 효과가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74135_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·보스 전투 시작 시, 오를라의 죽음 저항 속성 [Arg3]%만큼 죽음 저항이 증가합니다. 죽음 저항이 발동될 때마다, 턴 종료 시까지 「화려한 장편」의 대응 효과가 [Arg4]% 증가합니다."
  },
  AwakerTalent_74135_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74135_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74135_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74135_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74135_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74135_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74135_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74135_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74135_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74135_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74136_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 「소모」가 추가된 「부패 녹염」 1장을 손패에 넣으며, 「녹염」 및 관련 파생 카드의 기본 데미지가 [Arg3]% 증가합니다."
  },
  AwakerTalent_74136_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 「소모」가 추가된 「부패 녹염」 1장을 손패에 넣으며, 「녹염」 및 관련 파생 카드의 기본 데미지가 [Arg3]% 증가합니다."
  },
  AwakerTalent_74136_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 「소모」가 추가된 「부패 녹염」 1장을 손패에 넣으며, 「녹염」 및 관련 파생 카드의 기본 데미지가 [Arg3]% 증가합니다."
  },
  AwakerTalent_74136_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 「소모」가 추가된 「부패 녹염」 1장을 손패에 넣으며, 「녹염」 및 관련 파생 카드의 기본 데미지가 [Arg3]% 증가합니다."
  },
  AwakerTalent_74136_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 「소모」가 추가된 「부패 녹염」 1장을 손패에 넣으며, 「녹염」 및 관련 파생 카드의 기본 데미지가 [Arg3]% 증가합니다."
  },
  AwakerTalent_74136_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 「소모」가 추가된 「부패 녹염」 1장을 손패에 넣으며, 「녹염」 및 관련 파생 카드의 기본 데미지가 [Arg3]% 증가합니다."
  },
  AwakerTalent_74136_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 「소모」가 추가된 「부패 녹염」 1장을 손패에 넣으며, 「녹염」 및 관련 파생 카드의 기본 데미지가 [Arg3]% 증가합니다."
  },
  AwakerTalent_74136_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 「소모」가 추가된 「부패 녹염」 1장을 손패에 넣으며, 「녹염」 및 관련 파생 카드의 기본 데미지가 [Arg3]% 증가합니다."
  },
  AwakerTalent_74136_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 「소모」가 추가된 「부패 녹염」 1장을 손패에 넣으며, 「녹염」 및 관련 파생 카드의 기본 데미지가 [Arg3]% 증가합니다."
  },
  AwakerTalent_74136_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 전투 시작 시, 「소모」가 추가된 「부패 녹염」 1장을 손패에 넣으며, 「녹염」 및 관련 파생 카드의 기본 데미지가 [Arg3]% 증가합니다."
  },
  AwakerTalent_74136_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74136_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74136_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74136_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74136_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74136_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74136_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74136_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74136_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74136_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74137_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」 상품 갱신 시, 할인 등장 확률이 [Arg3]% 증가하고, 할인 비율이 [Arg4]% 증가합니다.\n· 「단경일격」 기본 피해가 [Arg5]% 증가하며, 처치로 인한 기본 피해 증가와 별도로 계산됩니다."
  },
  AwakerTalent_74137_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」 상품 갱신 시, 할인 등장 확률이 [Arg3]% 증가하고, 할인 비율이 [Arg4]% 증가합니다.\n· 「단경일격」 기본 피해가 [Arg5]% 증가하며, 처치로 인한 기본 피해 증가와 별도로 계산됩니다."
  },
  AwakerTalent_74137_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」 상품 갱신 시, 할인 등장 확률이 [Arg3]% 증가하고, 할인 비율이 [Arg4]% 증가합니다.\n· 「단경일격」 기본 피해가 [Arg5]% 증가하며, 처치로 인한 기본 피해 증가와 별도로 계산됩니다."
  },
  AwakerTalent_74137_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」 상품 갱신 시, 할인 등장 확률이 [Arg3]% 증가하고, 할인 비율이 [Arg4]% 증가합니다.\n· 「단경일격」 기본 피해가 [Arg5]% 증가하며, 처치로 인한 기본 피해 증가와 별도로 계산됩니다."
  },
  AwakerTalent_74137_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」 상품 갱신 시, 할인 등장 확률이 [Arg3]% 증가하고, 할인 비율이 [Arg4]% 증가합니다.\n· 「단경일격」 기본 피해가 [Arg5]% 증가하며, 처치로 인한 기본 피해 증가와 별도로 계산됩니다."
  },
  AwakerTalent_74137_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」 상품 갱신 시, 할인 등장 확률이 [Arg3]% 증가하고, 할인 비율이 [Arg4]% 증가합니다.\n· 「단경일격」 기본 피해가 [Arg5]% 증가하며, 처치로 인한 기본 피해 증가와 별도로 계산됩니다."
  },
  AwakerTalent_74137_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」 상품 갱신 시, 할인 등장 확률이 [Arg3]% 증가하고, 할인 비율이 [Arg4]% 증가합니다.\n· 「단경일격」 기본 피해가 [Arg5]% 증가하며, 처치로 인한 기본 피해 증가와 별도로 계산됩니다."
  },
  AwakerTalent_74137_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」 상품 갱신 시, 할인 등장 확률이 [Arg3]% 증가하고, 할인 비율이 [Arg4]% 증가합니다.\n· 「단경일격」 기본 피해가 [Arg5]% 증가하며, 처치로 인한 기본 피해 증가와 별도로 계산됩니다."
  },
  AwakerTalent_74137_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」 상품 갱신 시, 할인 등장 확률이 [Arg3]% 증가하고, 할인 비율이 [Arg4]% 증가합니다.\n· 「단경일격」 기본 피해가 [Arg5]% 증가하며, 처치로 인한 기본 피해 증가와 별도로 계산됩니다."
  },
  AwakerTalent_74137_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「재의 유적」 상품 갱신 시, 할인 등장 확률이 [Arg3]% 증가하고, 할인 비율이 [Arg4]% 증가합니다.\n· 「단경일격」 기본 피해가 [Arg5]% 증가하며, 처치로 인한 기본 피해 증가와 별도로 계산됩니다."
  },
  AwakerTalent_74137_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74137_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74137_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74137_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74137_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74137_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74137_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74137_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74137_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74137_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74138_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 턴마다 카이커스의 명령 카드를 처음 사용할 때 카이커스의 체력 [Arg3]%만큼 HP를 회복합니다. 「이단의 혈통」의 촉수 공격 및 반격 효과는 추가로 [Arg4]%의 피해를 입힙니다."
  },
  AwakerTalent_74138_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 턴마다 카이커스의 명령 카드를 처음 사용할 때 카이커스의 체력 [Arg3]%만큼 HP를 회복합니다. 「이단의 혈통」의 촉수 공격 및 반격 효과는 추가로 [Arg4]%의 피해를 입힙니다."
  },
  AwakerTalent_74138_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 턴마다 카이커스의 명령 카드를 처음 사용할 때 카이커스의 체력 [Arg3]%만큼 HP를 회복합니다. 「이단의 혈통」의 촉수 공격 및 반격 효과는 추가로 [Arg4]%의 피해를 입힙니다."
  },
  AwakerTalent_74138_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 턴마다 카이커스의 명령 카드를 처음 사용할 때 카이커스의 체력 [Arg3]%만큼 HP를 회복합니다. 「이단의 혈통」의 촉수 공격 및 반격 효과는 추가로 [Arg4]%의 피해를 입힙니다."
  },
  AwakerTalent_74138_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 턴마다 카이커스의 명령 카드를 처음 사용할 때 카이커스의 체력 [Arg3]%만큼 HP를 회복합니다. 「이단의 혈통」의 촉수 공격 및 반격 효과는 추가로 [Arg4]%의 피해를 입힙니다."
  },
  AwakerTalent_74138_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 턴마다 카이커스의 명령 카드를 처음 사용할 때 카이커스의 체력 [Arg3]%만큼 HP를 회복합니다. 「이단의 혈통」의 촉수 공격 및 반격 효과는 추가로 [Arg4]%의 피해를 입힙니다."
  },
  AwakerTalent_74138_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 턴마다 카이커스의 명령 카드를 처음 사용할 때 카이커스의 체력 [Arg3]%만큼 HP를 회복합니다. 「이단의 혈통」의 촉수 공격 및 반격 효과는 추가로 [Arg4]%의 피해를 입힙니다."
  },
  AwakerTalent_74138_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 턴마다 카이커스의 명령 카드를 처음 사용할 때 카이커스의 체력 [Arg3]%만큼 HP를 회복합니다. 「이단의 혈통」의 촉수 공격 및 반격 효과는 추가로 [Arg4]%의 피해를 입힙니다."
  },
  AwakerTalent_74138_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 턴마다 카이커스의 명령 카드를 처음 사용할 때 카이커스의 체력 [Arg3]%만큼 HP를 회복합니다. 「이단의 혈통」의 촉수 공격 및 반격 효과는 추가로 [Arg4]%의 피해를 입힙니다."
  },
  AwakerTalent_74138_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 턴마다 카이커스의 명령 카드를 처음 사용할 때 카이커스의 체력 [Arg3]%만큼 HP를 회복합니다. 「이단의 혈통」의 촉수 공격 및 반격 효과는 추가로 [Arg4]%의 피해를 입힙니다."
  },
  AwakerTalent_74138_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74138_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74138_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74138_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74138_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74138_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74138_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74138_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74138_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74138_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74139_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 노틸라의 반격 획득량이 [Arg3]％ 증가하며, 「출전 준비 완료」를 발동하기 전 영구 반격의 [Arg4]％만큼 임시 반격을 획득합니다."
  },
  AwakerTalent_74139_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 노틸라의 반격 획득량이 [Arg3]％ 증가하며, 「출전 준비 완료」를 발동하기 전 영구 반격의 [Arg4]％만큼 임시 반격을 획득합니다."
  },
  AwakerTalent_74139_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 노틸라의 반격 획득량이 [Arg3]％ 증가하며, 「출전 준비 완료」를 발동하기 전 영구 반격의 [Arg4]％만큼 임시 반격을 획득합니다."
  },
  AwakerTalent_74139_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 노틸라의 반격 획득량이 [Arg3]％ 증가하며, 「출전 준비 완료」를 발동하기 전 영구 반격의 [Arg4]％만큼 임시 반격을 획득합니다."
  },
  AwakerTalent_74139_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 노틸라의 반격 획득량이 [Arg3]％ 증가하며, 「출전 준비 완료」를 발동하기 전 영구 반격의 [Arg4]％만큼 임시 반격을 획득합니다."
  },
  AwakerTalent_74139_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 노틸라의 반격 획득량이 [Arg3]％ 증가하며, 「출전 준비 완료」를 발동하기 전 영구 반격의 [Arg4]％만큼 임시 반격을 획득합니다."
  },
  AwakerTalent_74139_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 노틸라의 반격 획득량이 [Arg3]％ 증가하며, 「출전 준비 완료」를 발동하기 전 영구 반격의 [Arg4]％만큼 임시 반격을 획득합니다."
  },
  AwakerTalent_74139_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 노틸라의 반격 획득량이 [Arg3]％ 증가하며, 「출전 준비 완료」를 발동하기 전 영구 반격의 [Arg4]％만큼 임시 반격을 획득합니다."
  },
  AwakerTalent_74139_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 노틸라의 반격 획득량이 [Arg3]％ 증가하며, 「출전 준비 완료」를 발동하기 전 영구 반격의 [Arg4]％만큼 임시 반격을 획득합니다."
  },
  AwakerTalent_74139_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 노틸라의 반격 획득량이 [Arg3]％ 증가하며, 「출전 준비 완료」를 발동하기 전 영구 반격의 [Arg4]％만큼 임시 반격을 획득합니다."
  },
  AwakerTalent_74139_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74139_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74139_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74139_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74139_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74139_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74139_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74139_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74139_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74139_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74140_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 희생을 획득할 때마다 희생 수치의 [Arg3]%만큼 촉수 피해가 상승합니다."
  },
  AwakerTalent_74140_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 희생을 획득할 때마다 희생 수치의 [Arg3]%만큼 촉수 피해가 상승합니다."
  },
  AwakerTalent_74140_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 희생을 획득할 때마다 희생 수치의 [Arg3]%만큼 촉수 피해가 상승합니다."
  },
  AwakerTalent_74140_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 희생을 획득할 때마다 희생 수치의 [Arg3]%만큼 촉수 피해가 상승합니다."
  },
  AwakerTalent_74140_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 희생을 획득할 때마다 희생 수치의 [Arg3]%만큼 촉수 피해가 상승합니다."
  },
  AwakerTalent_74140_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 희생을 획득할 때마다 희생 수치의 [Arg3]%만큼 촉수 피해가 상승합니다."
  },
  AwakerTalent_74140_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 희생을 획득할 때마다 희생 수치의 [Arg3]%만큼 촉수 피해가 상승합니다."
  },
  AwakerTalent_74140_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 희생을 획득할 때마다 희생 수치의 [Arg3]%만큼 촉수 피해가 상승합니다."
  },
  AwakerTalent_74140_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 희생을 획득할 때마다 희생 수치의 [Arg3]%만큼 촉수 피해가 상승합니다."
  },
  AwakerTalent_74140_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 희생을 획득할 때마다 희생 수치의 [Arg3]%만큼 촉수 피해가 상승합니다."
  },
  AwakerTalent_74140_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74140_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74140_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74140_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74140_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74140_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74140_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74140_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74140_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74140_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74141_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 탐색 시작 후, 모든 깨어남체가 가하는 중독, 반격, 기본 피해가 [Arg3]％ 증가합니다."
  },
  AwakerTalent_74141_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 탐색 시작 후, 모든 깨어남체가 가하는 중독, 반격, 기본 피해가 [Arg3]％ 증가합니다."
  },
  AwakerTalent_74141_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 탐색 시작 후, 모든 깨어남체가 가하는 중독, 반격, 기본 피해가 [Arg3]％ 증가합니다."
  },
  AwakerTalent_74141_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 탐색 시작 후, 모든 깨어남체가 가하는 중독, 반격, 기본 피해가 [Arg3]％ 증가합니다."
  },
  AwakerTalent_74141_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 탐색 시작 후, 모든 깨어남체가 가하는 중독, 반격, 기본 피해가 [Arg3]％ 증가합니다."
  },
  AwakerTalent_74141_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 탐색 시작 후, 모든 깨어남체가 가하는 중독, 반격, 기본 피해가 [Arg3]％ 증가합니다."
  },
  AwakerTalent_74141_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 탐색 시작 후, 모든 깨어남체가 가하는 중독, 반격, 기본 피해가 [Arg3]％ 증가합니다."
  },
  AwakerTalent_74141_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 탐색 시작 후, 모든 깨어남체가 가하는 중독, 반격, 기본 피해가 [Arg3]％ 증가합니다."
  },
  AwakerTalent_74141_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 탐색 시작 후, 모든 깨어남체가 가하는 중독, 반격, 기본 피해가 [Arg3]％ 증가합니다."
  },
  AwakerTalent_74141_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 탐색 시작 후, 모든 깨어남체가 가하는 중독, 반격, 기본 피해가 [Arg3]％ 증가합니다."
  },
  AwakerTalent_74141_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74141_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74141_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74141_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74141_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74141_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74141_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74141_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74141_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74141_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74201_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 회귀·라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 회귀·라모나의 은열쇠 충전 [Arg4]%의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74201_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 회귀·라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 회귀·라모나의 은열쇠 충전 [Arg4]%의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74201_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 회귀·라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 회귀·라모나의 은열쇠 충전 [Arg4]%의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74201_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 회귀·라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 회귀·라모나의 은열쇠 충전 [Arg4]%의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74201_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 회귀·라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 회귀·라모나의 은열쇠 충전 [Arg4]%의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74201_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 회귀·라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 회귀·라모나의 은열쇠 충전 [Arg4]%의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74201_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 회귀·라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 회귀·라모나의 은열쇠 충전 [Arg4]%의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74201_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 회귀·라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 회귀·라모나의 은열쇠 충전 [Arg4]%의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74201_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 회귀·라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 회귀·라모나의 은열쇠 충전 [Arg4]%의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74201_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 회귀·라모나의 은열쇠 충전이 [Arg3]% 증가하며, 전투 시작 시 회귀·라모나의 은열쇠 충전 [Arg4]%의 은열쇠 에너지를 획득합니다."
  },
  AwakerTalent_74201_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74201_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74201_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74201_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74201_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74201_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74201_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74201_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74201_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_74201_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78617_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78617_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78617_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78617_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78617_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78617_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78617_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78617_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78617_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78617_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78617_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78617_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78617_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78617_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78617_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78617_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78617_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78617_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78617_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78617_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78618_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「고통 구원」이 부여하는 기본 피해 증가 효과가 폴룩스 공격력의 [Arg3]%만큼 증가합니다. \n· 「죄의 낙인」이 50스택 누적될 때마다 「성심」 1장을 손패에 추가합니다. \n· 「죄의 낙인」이 100스택에 도달한 후, 「성심」이 3번째로 사용되오 소모될 때마다 자신의 「스킬 카드」중 1장을 뽑습니다. \n· 피해를 입힐 때 「죄의 낙인」의 효과가 「등불 교회」의 적에게 두 배로 적용됩니다."
  },
  AwakerTalent_78618_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「고통 구원」이 부여하는 기본 피해 증가 효과가 폴룩스 공격력의 [Arg3]%만큼 증가합니다. \n· 「죄의 낙인」이 50스택 누적될 때마다 「성심」 1장을 손패에 추가합니다. \n· 「죄의 낙인」이 100스택에 도달한 후, 「성심」이 3번째로 사용되오 소모될 때마다 자신의 「스킬 카드」중 1장을 뽑습니다. \n· 피해를 입힐 때 「죄의 낙인」의 효과가 「등불 교회」의 적에게 두 배로 적용됩니다."
  },
  AwakerTalent_78618_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「고통 구원」이 부여하는 기본 피해 증가 효과가 폴룩스 공격력의 [Arg3]%만큼 증가합니다. \n· 「죄의 낙인」이 50스택 누적될 때마다 「성심」 1장을 손패에 추가합니다. \n· 「죄의 낙인」이 100스택에 도달한 후, 「성심」이 3번째로 사용되오 소모될 때마다 자신의 「스킬 카드」중 1장을 뽑습니다. \n· 피해를 입힐 때 「죄의 낙인」의 효과가 「등불 교회」의 적에게 두 배로 적용됩니다."
  },
  AwakerTalent_78618_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「고통 구원」이 부여하는 기본 피해 증가 효과가 폴룩스 공격력의 [Arg3]%만큼 증가합니다. \n· 「죄의 낙인」이 50스택 누적될 때마다 「성심」 1장을 손패에 추가합니다. \n· 「죄의 낙인」이 100스택에 도달한 후, 「성심」이 3번째로 사용되오 소모될 때마다 자신의 「스킬 카드」중 1장을 뽑습니다. \n· 피해를 입힐 때 「죄의 낙인」의 효과가 「등불 교회」의 적에게 두 배로 적용됩니다."
  },
  AwakerTalent_78618_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「고통 구원」이 부여하는 기본 피해 증가 효과가 폴룩스 공격력의 [Arg3]%만큼 증가합니다. \n· 「죄의 낙인」이 50스택 누적될 때마다 「성심」 1장을 손패에 추가합니다. \n· 「죄의 낙인」이 100스택에 도달한 후, 「성심」이 3번째로 사용되오 소모될 때마다 자신의 「스킬 카드」중 1장을 뽑습니다. \n· 피해를 입힐 때 「죄의 낙인」의 효과가 「등불 교회」의 적에게 두 배로 적용됩니다."
  },
  AwakerTalent_78618_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「고통 구원」이 부여하는 기본 피해 증가 효과가 폴룩스 공격력의 [Arg3]%만큼 증가합니다. \n· 「죄의 낙인」이 50스택 누적될 때마다 「성심」 1장을 손패에 추가합니다. \n· 「죄의 낙인」이 100스택에 도달한 후, 「성심」이 3번째로 사용되오 소모될 때마다 자신의 「스킬 카드」중 1장을 뽑습니다. \n· 피해를 입힐 때 「죄의 낙인」의 효과가 「등불 교회」의 적에게 두 배로 적용됩니다."
  },
  AwakerTalent_78618_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「고통 구원」이 부여하는 기본 피해 증가 효과가 폴룩스 공격력의 [Arg3]%만큼 증가합니다. \n· 「죄의 낙인」이 50스택 누적될 때마다 「성심」 1장을 손패에 추가합니다. \n· 「죄의 낙인」이 100스택에 도달한 후, 「성심」이 3번째로 사용되오 소모될 때마다 자신의 「스킬 카드」중 1장을 뽑습니다. \n· 피해를 입힐 때 「죄의 낙인」의 효과가 「등불 교회」의 적에게 두 배로 적용됩니다."
  },
  AwakerTalent_78618_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「고통 구원」이 부여하는 기본 피해 증가 효과가 폴룩스 공격력의 [Arg3]%만큼 증가합니다. \n· 「죄의 낙인」이 50스택 누적될 때마다 「성심」 1장을 손패에 추가합니다. \n· 「죄의 낙인」이 100스택에 도달한 후, 「성심」이 3번째로 사용되오 소모될 때마다 자신의 「스킬 카드」중 1장을 뽑습니다. \n· 피해를 입힐 때 「죄의 낙인」의 효과가 「등불 교회」의 적에게 두 배로 적용됩니다."
  },
  AwakerTalent_78618_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「고통 구원」이 부여하는 기본 피해 증가 효과가 폴룩스 공격력의 [Arg3]%만큼 증가합니다. \n· 「죄의 낙인」이 50스택 누적될 때마다 「성심」 1장을 손패에 추가합니다. \n· 「죄의 낙인」이 100스택에 도달한 후, 「성심」이 3번째로 사용되오 소모될 때마다 자신의 「스킬 카드」중 1장을 뽑습니다. \n· 피해를 입힐 때 「죄의 낙인」의 효과가 「등불 교회」의 적에게 두 배로 적용됩니다."
  },
  AwakerTalent_78618_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n·「고통 구원」이 부여하는 기본 피해 증가 효과가 폴룩스 공격력의 [Arg3]%만큼 증가합니다. \n· 「죄의 낙인」이 50스택 누적될 때마다 「성심」 1장을 손패에 추가합니다. \n· 「죄의 낙인」이 100스택에 도달한 후, 「성심」이 3번째로 사용되오 소모될 때마다 자신의 「스킬 카드」중 1장을 뽑습니다. \n· 피해를 입힐 때 「죄의 낙인」의 효과가 「등불 교회」의 적에게 두 배로 적용됩니다."
  },
  AwakerTalent_78618_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78618_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78618_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78618_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78618_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78618_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78618_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78618_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78618_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78618_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78619_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_78619_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_78619_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_78619_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_78619_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_78619_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_78619_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_78619_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_78619_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_78619_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_78619_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_78619_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1]pt 획득한다."
  },
  AwakerTalent_78619_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78619_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78619_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78619_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78619_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78619_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78619_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78619_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78619_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78619_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78619_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78619_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78620_TalentDesc_1 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·전투 시작 시, 모든 적이 받는 촉수 피해가 [Arg3]% 증가하며, 「심해」 적에게는 효과가 2배가 됩니다. 「징벌의 천둥」이 「심해」 적에게 가하는 능동 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_78620_TalentDesc_10 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·전투 시작 시, 모든 적이 받는 촉수 피해가 [Arg3]% 증가하며, 「심해」 적에게는 효과가 2배가 됩니다. 「징벌의 천둥」이 「심해」 적에게 가하는 능동 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_78620_TalentDesc_2 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·전투 시작 시, 모든 적이 받는 촉수 피해가 [Arg3]% 증가하며, 「심해」 적에게는 효과가 2배가 됩니다. 「징벌의 천둥」이 「심해」 적에게 가하는 능동 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_78620_TalentDesc_3 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·전투 시작 시, 모든 적이 받는 촉수 피해가 [Arg3]% 증가하며, 「심해」 적에게는 효과가 2배가 됩니다. 「징벌의 천둥」이 「심해」 적에게 가하는 능동 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_78620_TalentDesc_4 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·전투 시작 시, 모든 적이 받는 촉수 피해가 [Arg3]% 증가하며, 「심해」 적에게는 효과가 2배가 됩니다. 「징벌의 천둥」이 「심해」 적에게 가하는 능동 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_78620_TalentDesc_5 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·전투 시작 시, 모든 적이 받는 촉수 피해가 [Arg3]% 증가하며, 「심해」 적에게는 효과가 2배가 됩니다. 「징벌의 천둥」이 「심해」 적에게 가하는 능동 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_78620_TalentDesc_6 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·전투 시작 시, 모든 적이 받는 촉수 피해가 [Arg3]% 증가하며, 「심해」 적에게는 효과가 2배가 됩니다. 「징벌의 천둥」이 「심해」 적에게 가하는 능동 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_78620_TalentDesc_7 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·전투 시작 시, 모든 적이 받는 촉수 피해가 [Arg3]% 증가하며, 「심해」 적에게는 효과가 2배가 됩니다. 「징벌의 천둥」이 「심해」 적에게 가하는 능동 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_78620_TalentDesc_8 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·전투 시작 시, 모든 적이 받는 촉수 피해가 [Arg3]% 증가하며, 「심해」 적에게는 효과가 2배가 됩니다. 「징벌의 천둥」이 「심해」 적에게 가하는 능동 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_78620_TalentDesc_9 = {
    Text = "·해당 특성은 「성진편」 스테이지에서만 적용됩니다.\n·해당 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]포인트의 은열쇠 에너지를 획득합니다.\n·전투 시작 시, 모든 적이 받는 촉수 피해가 [Arg3]% 증가하며, 「심해」 적에게는 효과가 2배가 됩니다. 「징벌의 천둥」이 「심해」 적에게 가하는 능동 피해가 [Arg4]% 증가합니다."
  },
  AwakerTalent_78620_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78620_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78620_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78620_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78620_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78620_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78620_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78620_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78620_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78620_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78622_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「활염」의 효과가 [Arg3]% 증가하며, 턴 시작 후 및 턴 종료 후에, 손패에 있는 모든 카드의 「연소」를 제거하고, 제거한 연소 스택마다 카티구라가 「폭염」을 1스택 획득합니다."
  },
  AwakerTalent_78622_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「활염」의 효과가 [Arg3]% 증가하며, 턴 시작 후 및 턴 종료 후에, 손패에 있는 모든 카드의 「연소」를 제거하고, 제거한 연소 스택마다 카티구라가 「폭염」을 1스택 획득합니다."
  },
  AwakerTalent_78622_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「활염」의 효과가 [Arg3]% 증가하며, 턴 시작 후 및 턴 종료 후에, 손패에 있는 모든 카드의 「연소」를 제거하고, 제거한 연소 스택마다 카티구라가 「폭염」을 1스택 획득합니다."
  },
  AwakerTalent_78622_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「활염」의 효과가 [Arg3]% 증가하며, 턴 시작 후 및 턴 종료 후에, 손패에 있는 모든 카드의 「연소」를 제거하고, 제거한 연소 스택마다 카티구라가 「폭염」을 1스택 획득합니다."
  },
  AwakerTalent_78622_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「활염」의 효과가 [Arg3]% 증가하며, 턴 시작 후 및 턴 종료 후에, 손패에 있는 모든 카드의 「연소」를 제거하고, 제거한 연소 스택마다 카티구라가 「폭염」을 1스택 획득합니다."
  },
  AwakerTalent_78622_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「활염」의 효과가 [Arg3]% 증가하며, 턴 시작 후 및 턴 종료 후에, 손패에 있는 모든 카드의 「연소」를 제거하고, 제거한 연소 스택마다 카티구라가 「폭염」을 1스택 획득합니다."
  },
  AwakerTalent_78622_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「활염」의 효과가 [Arg3]% 증가하며, 턴 시작 후 및 턴 종료 후에, 손패에 있는 모든 카드의 「연소」를 제거하고, 제거한 연소 스택마다 카티구라가 「폭염」을 1스택 획득합니다."
  },
  AwakerTalent_78622_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「활염」의 효과가 [Arg3]% 증가하며, 턴 시작 후 및 턴 종료 후에, 손패에 있는 모든 카드의 「연소」를 제거하고, 제거한 연소 스택마다 카티구라가 「폭염」을 1스택 획득합니다."
  },
  AwakerTalent_78622_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「활염」의 효과가 [Arg3]% 증가하며, 턴 시작 후 및 턴 종료 후에, 손패에 있는 모든 카드의 「연소」를 제거하고, 제거한 연소 스택마다 카티구라가 「폭염」을 1스택 획득합니다."
  },
  AwakerTalent_78622_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 「활염」의 효과가 [Arg3]% 증가하며, 턴 시작 후 및 턴 종료 후에, 손패에 있는 모든 카드의 「연소」를 제거하고, 제거한 연소 스택마다 카티구라가 「폭염」을 1스택 획득합니다."
  },
  AwakerTalent_78622_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78622_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78622_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78622_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78622_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78622_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78622_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78622_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78622_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78622_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78623_TalentDesc_1 = {
    Text = "·이 특성은 「성진편」 관문에서만 효과가 적용됩니다.\n·이 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 이 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·카라부 광기 폭발의 치명타율과 치명타 피해가 [Arg3]% 증가합니다. 「과식」이 제공하는 HP 상한이 [Arg5]% 증가합니다. 「빙역」 지형에서 「흩날리는 눈의 저주」의 행동력 소비가 -1, 피해 횟수가 +1 증가하며, 피해와 허약 효과가 모든 적에게 적용됩니다."
  },
  AwakerTalent_78623_TalentDesc_10 = {
    Text = "·이 특성은 「성진편」 관문에서만 효과가 적용됩니다.\n·이 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 이 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·카라부 광기 폭발의 치명타율과 치명타 피해가 [Arg3]% 증가합니다. 「과식」이 제공하는 HP 상한이 [Arg5]% 증가합니다. 「빙역」 지형에서 「흩날리는 눈의 저주」의 행동력 소비가 -1, 피해 횟수가 +1 증가하며, 피해와 허약 효과가 모든 적에게 적용됩니다."
  },
  AwakerTalent_78623_TalentDesc_2 = {
    Text = "·이 특성은 「성진편」 관문에서만 효과가 적용됩니다.\n·이 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 이 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·카라부 광기 폭발의 치명타율과 치명타 피해가 [Arg3]% 증가합니다. 「과식」이 제공하는 HP 상한이 [Arg5]% 증가합니다. 「빙역」 지형에서 「흩날리는 눈의 저주」의 행동력 소비가 -1, 피해 횟수가 +1 증가하며, 피해와 허약 효과가 모든 적에게 적용됩니다."
  },
  AwakerTalent_78623_TalentDesc_3 = {
    Text = "·이 특성은 「성진편」 관문에서만 효과가 적용됩니다.\n·이 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 이 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·카라부 광기 폭발의 치명타율과 치명타 피해가 [Arg3]% 증가합니다. 「과식」이 제공하는 HP 상한이 [Arg5]% 증가합니다. 「빙역」 지형에서 「흩날리는 눈의 저주」의 행동력 소비가 -1, 피해 횟수가 +1 증가하며, 피해와 허약 효과가 모든 적에게 적용됩니다."
  },
  AwakerTalent_78623_TalentDesc_4 = {
    Text = "·이 특성은 「성진편」 관문에서만 효과가 적용됩니다.\n·이 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 이 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·카라부 광기 폭발의 치명타율과 치명타 피해가 [Arg3]% 증가합니다. 「과식」이 제공하는 HP 상한이 [Arg5]% 증가합니다. 「빙역」 지형에서 「흩날리는 눈의 저주」의 행동력 소비가 -1, 피해 횟수가 +1 증가하며, 피해와 허약 효과가 모든 적에게 적용됩니다."
  },
  AwakerTalent_78623_TalentDesc_5 = {
    Text = "·이 특성은 「성진편」 관문에서만 효과가 적용됩니다.\n·이 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 이 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·카라부 광기 폭발의 치명타율과 치명타 피해가 [Arg3]% 증가합니다. 「과식」이 제공하는 HP 상한이 [Arg5]% 증가합니다. 「빙역」 지형에서 「흩날리는 눈의 저주」의 행동력 소비가 -1, 피해 횟수가 +1 증가하며, 피해와 허약 효과가 모든 적에게 적용됩니다."
  },
  AwakerTalent_78623_TalentDesc_6 = {
    Text = "·이 특성은 「성진편」 관문에서만 효과가 적용됩니다.\n·이 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 이 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·카라부 광기 폭발의 치명타율과 치명타 피해가 [Arg3]% 증가합니다. 「과식」이 제공하는 HP 상한이 [Arg5]% 증가합니다. 「빙역」 지형에서 「흩날리는 눈의 저주」의 행동력 소비가 -1, 피해 횟수가 +1 증가하며, 피해와 허약 효과가 모든 적에게 적용됩니다."
  },
  AwakerTalent_78623_TalentDesc_7 = {
    Text = "·이 특성은 「성진편」 관문에서만 효과가 적용됩니다.\n·이 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 이 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·카라부 광기 폭발의 치명타율과 치명타 피해가 [Arg3]% 증가합니다. 「과식」이 제공하는 HP 상한이 [Arg5]% 증가합니다. 「빙역」 지형에서 「흩날리는 눈의 저주」의 행동력 소비가 -1, 피해 횟수가 +1 증가하며, 피해와 허약 효과가 모든 적에게 적용됩니다."
  },
  AwakerTalent_78623_TalentDesc_8 = {
    Text = "·이 특성은 「성진편」 관문에서만 효과가 적용됩니다.\n·이 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 이 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·카라부 광기 폭발의 치명타율과 치명타 피해가 [Arg3]% 증가합니다. 「과식」이 제공하는 HP 상한이 [Arg5]% 증가합니다. 「빙역」 지형에서 「흩날리는 눈의 저주」의 행동력 소비가 -1, 피해 횟수가 +1 증가하며, 피해와 허약 효과가 모든 적에게 적용됩니다."
  },
  AwakerTalent_78623_TalentDesc_9 = {
    Text = "·이 특성은 「성진편」 관문에서만 효과가 적용됩니다.\n·이 각성체의 체력, 공격, 방어가 [Arg1]% 증가하며, 이 각성체가 처음으로 영지 각성을 사용한 후 [Arg2]점의 은열쇠 에너지를 획득합니다.\n·카라부 광기 폭발의 치명타율과 치명타 피해가 [Arg3]% 증가합니다. 「과식」이 제공하는 HP 상한이 [Arg5]% 증가합니다. 「빙역」 지형에서 「흩날리는 눈의 저주」의 행동력 소비가 -1, 피해 횟수가 +1 증가하며, 피해와 허약 효과가 모든 적에게 적용됩니다."
  },
  AwakerTalent_78623_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78623_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78623_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78623_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78623_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78623_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78623_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78623_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78623_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78623_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78624_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「검은 깃털」 이 「산술 조화」 스택을 증가시키지 않습니다. 「정화의 깃털」이 부여하는 침식 수치가 카스토르의 공격력 [Arg3]%만큼 증가합니다. \n· 카스토르가 「등불 교회」 적에게 부여하는 침식 수치가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_78624_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「검은 깃털」 이 「산술 조화」 스택을 증가시키지 않습니다. 「정화의 깃털」이 부여하는 침식 수치가 카스토르의 공격력 [Arg3]%만큼 증가합니다. \n· 카스토르가 「등불 교회」 적에게 부여하는 침식 수치가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_78624_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「검은 깃털」 이 「산술 조화」 스택을 증가시키지 않습니다. 「정화의 깃털」이 부여하는 침식 수치가 카스토르의 공격력 [Arg3]%만큼 증가합니다. \n· 카스토르가 「등불 교회」 적에게 부여하는 침식 수치가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_78624_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「검은 깃털」 이 「산술 조화」 스택을 증가시키지 않습니다. 「정화의 깃털」이 부여하는 침식 수치가 카스토르의 공격력 [Arg3]%만큼 증가합니다. \n· 카스토르가 「등불 교회」 적에게 부여하는 침식 수치가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_78624_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「검은 깃털」 이 「산술 조화」 스택을 증가시키지 않습니다. 「정화의 깃털」이 부여하는 침식 수치가 카스토르의 공격력 [Arg3]%만큼 증가합니다. \n· 카스토르가 「등불 교회」 적에게 부여하는 침식 수치가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_78624_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「검은 깃털」 이 「산술 조화」 스택을 증가시키지 않습니다. 「정화의 깃털」이 부여하는 침식 수치가 카스토르의 공격력 [Arg3]%만큼 증가합니다. \n· 카스토르가 「등불 교회」 적에게 부여하는 침식 수치가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_78624_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「검은 깃털」 이 「산술 조화」 스택을 증가시키지 않습니다. 「정화의 깃털」이 부여하는 침식 수치가 카스토르의 공격력 [Arg3]%만큼 증가합니다. \n· 카스토르가 「등불 교회」 적에게 부여하는 침식 수치가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_78624_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「검은 깃털」 이 「산술 조화」 스택을 증가시키지 않습니다. 「정화의 깃털」이 부여하는 침식 수치가 카스토르의 공격력 [Arg3]%만큼 증가합니다. \n· 카스토르가 「등불 교회」 적에게 부여하는 침식 수치가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_78624_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「검은 깃털」 이 「산술 조화」 스택을 증가시키지 않습니다. 「정화의 깃털」이 부여하는 침식 수치가 카스토르의 공격력 [Arg3]%만큼 증가합니다. \n· 카스토르가 「등불 교회」 적에게 부여하는 침식 수치가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_78624_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「검은 깃털」 이 「산술 조화」 스택을 증가시키지 않습니다. 「정화의 깃털」이 부여하는 침식 수치가 카스토르의 공격력 [Arg3]%만큼 증가합니다. \n· 카스토르가 「등불 교회」 적에게 부여하는 침식 수치가 [Arg4]％ 증가합니다."
  },
  AwakerTalent_78624_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78624_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78624_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78624_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78624_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78624_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78624_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78624_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78624_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78624_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78625_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「진실타래, 그것은 환상」이 해당 턴 동안 다른 깨어남체의 광기 폭발 최종 피해를 추가로 [Arg3]% 증가시키며, 사용 후 픽맨의 기본 광기가 5 포인트 감소합니다."
  },
  AwakerTalent_78625_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「진실타래, 그것은 환상」이 해당 턴 동안 다른 깨어남체의 광기 폭발 최종 피해를 추가로 [Arg3]% 증가시키며, 사용 후 픽맨의 기본 광기가 5 포인트 감소합니다."
  },
  AwakerTalent_78625_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「진실타래, 그것은 환상」이 해당 턴 동안 다른 깨어남체의 광기 폭발 최종 피해를 추가로 [Arg3]% 증가시키며, 사용 후 픽맨의 기본 광기가 5 포인트 감소합니다."
  },
  AwakerTalent_78625_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「진실타래, 그것은 환상」이 해당 턴 동안 다른 깨어남체의 광기 폭발 최종 피해를 추가로 [Arg3]% 증가시키며, 사용 후 픽맨의 기본 광기가 5 포인트 감소합니다."
  },
  AwakerTalent_78625_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「진실타래, 그것은 환상」이 해당 턴 동안 다른 깨어남체의 광기 폭발 최종 피해를 추가로 [Arg3]% 증가시키며, 사용 후 픽맨의 기본 광기가 5 포인트 감소합니다."
  },
  AwakerTalent_78625_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「진실타래, 그것은 환상」이 해당 턴 동안 다른 깨어남체의 광기 폭발 최종 피해를 추가로 [Arg3]% 증가시키며, 사용 후 픽맨의 기본 광기가 5 포인트 감소합니다."
  },
  AwakerTalent_78625_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「진실타래, 그것은 환상」이 해당 턴 동안 다른 깨어남체의 광기 폭발 최종 피해를 추가로 [Arg3]% 증가시키며, 사용 후 픽맨의 기본 광기가 5 포인트 감소합니다."
  },
  AwakerTalent_78625_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「진실타래, 그것은 환상」이 해당 턴 동안 다른 깨어남체의 광기 폭발 최종 피해를 추가로 [Arg3]% 증가시키며, 사용 후 픽맨의 기본 광기가 5 포인트 감소합니다."
  },
  AwakerTalent_78625_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「진실타래, 그것은 환상」이 해당 턴 동안 다른 깨어남체의 광기 폭발 최종 피해를 추가로 [Arg3]% 증가시키며, 사용 후 픽맨의 기본 광기가 5 포인트 감소합니다."
  },
  AwakerTalent_78625_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다.\n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 「진실타래, 그것은 환상」이 해당 턴 동안 다른 깨어남체의 광기 폭발 최종 피해를 추가로 [Arg3]% 증가시키며, 사용 후 픽맨의 기본 광기가 5 포인트 감소합니다."
  },
  AwakerTalent_78625_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78625_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78625_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78625_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78625_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78625_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78625_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78625_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78625_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78625_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78627_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78627_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78627_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78627_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78627_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78627_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78627_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78627_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78627_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78627_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78627_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78627_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78627_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78627_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78627_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78627_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78627_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78627_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78627_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78627_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78627_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78627_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78627_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78627_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78630_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78630_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78630_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78630_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78630_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78630_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78630_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78630_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78630_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78630_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78630_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78630_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78630_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78630_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78630_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78630_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78630_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78630_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78630_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78630_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78631_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78631_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78631_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78631_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78631_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78631_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78631_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78631_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78631_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78631_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78631_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78631_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78631_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78631_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78631_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78631_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78631_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78631_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78631_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78631_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78631_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78631_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78631_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78631_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78632_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78632_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78632_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78632_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78632_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78632_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78632_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78632_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78632_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78632_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78632_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78632_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78632_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78632_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78632_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78632_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78632_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78632_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78632_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78632_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78632_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78632_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78632_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78632_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78633_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78633_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78633_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78633_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78633_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78633_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78633_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78633_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78633_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78633_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78633_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78633_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78633_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78633_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78633_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78633_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78633_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78633_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78633_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78633_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78633_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78633_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78633_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78633_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78634_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78634_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78634_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78634_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78634_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78634_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78634_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78634_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78634_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78634_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78634_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78634_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78634_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78634_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78634_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78634_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78634_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78634_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78634_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78634_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78634_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78634_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78634_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78634_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78635_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78635_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78635_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78635_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78635_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78635_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78635_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78635_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78635_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78635_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78635_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78635_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78635_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78635_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78635_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78635_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78635_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78635_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78635_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78635_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78635_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78635_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78635_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78635_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78636_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78636_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78636_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78636_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78636_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78636_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78636_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78636_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78636_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78636_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78636_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78636_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78636_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78636_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78636_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78636_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78636_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78636_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78636_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78636_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78637_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78637_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78637_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78637_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78637_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78637_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78637_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78637_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78637_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78637_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78637_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78637_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78637_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78637_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78637_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78637_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78637_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78637_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78637_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78637_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78637_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78637_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78637_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78637_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78639_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78639_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78639_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78639_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78639_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78639_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78639_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78639_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78639_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78639_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78639_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78639_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78639_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78639_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78639_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78639_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78639_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78639_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78639_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78639_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78640_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78640_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78640_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78640_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78640_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78640_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78640_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78640_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78640_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78640_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78640_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78640_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78640_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78640_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78640_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78640_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78640_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78640_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78640_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78640_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78640_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78640_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78640_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78640_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78642_TalentDesc_1 = {
    Text = "·해당 특성은 \"별의 시대\" 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점 은열쇠 에너지를 획득합니다.\n·아라크네가 발생시키는 \"운명의 판결\"이 [Arg3] % 증가하며, 뮤탄트 적에게 가하는 \"운명의 판결\"이 두 배가 됩니다."
  },
  AwakerTalent_78642_TalentDesc_10 = {
    Text = "·해당 특성은 \"별의 시대\" 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점 은열쇠 에너지를 획득합니다.\n·아라크네가 발생시키는 \"운명의 판결\"이 [Arg3] % 증가하며, 뮤탄트 적에게 가하는 \"운명의 판결\"이 두 배가 됩니다."
  },
  AwakerTalent_78642_TalentDesc_2 = {
    Text = "·해당 특성은 \"별의 시대\" 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점 은열쇠 에너지를 획득합니다.\n·아라크네가 발생시키는 \"운명의 판결\"이 [Arg3] % 증가하며, 뮤탄트 적에게 가하는 \"운명의 판결\"이 두 배가 됩니다."
  },
  AwakerTalent_78642_TalentDesc_3 = {
    Text = "·해당 특성은 \"별의 시대\" 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점 은열쇠 에너지를 획득합니다.\n·아라크네가 발생시키는 \"운명의 판결\"이 [Arg3] % 증가하며, 뮤탄트 적에게 가하는 \"운명의 판결\"이 두 배가 됩니다."
  },
  AwakerTalent_78642_TalentDesc_4 = {
    Text = "·해당 특성은 \"별의 시대\" 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점 은열쇠 에너지를 획득합니다.\n·아라크네가 발생시키는 \"운명의 판결\"이 [Arg3] % 증가하며, 뮤탄트 적에게 가하는 \"운명의 판결\"이 두 배가 됩니다."
  },
  AwakerTalent_78642_TalentDesc_5 = {
    Text = "·해당 특성은 \"별의 시대\" 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점 은열쇠 에너지를 획득합니다.\n·아라크네가 발생시키는 \"운명의 판결\"이 [Arg3] % 증가하며, 뮤탄트 적에게 가하는 \"운명의 판결\"이 두 배가 됩니다."
  },
  AwakerTalent_78642_TalentDesc_6 = {
    Text = "·해당 특성은 \"별의 시대\" 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점 은열쇠 에너지를 획득합니다.\n·아라크네가 발생시키는 \"운명의 판결\"이 [Arg3] % 증가하며, 뮤탄트 적에게 가하는 \"운명의 판결\"이 두 배가 됩니다."
  },
  AwakerTalent_78642_TalentDesc_7 = {
    Text = "·해당 특성은 \"별의 시대\" 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점 은열쇠 에너지를 획득합니다.\n·아라크네가 발생시키는 \"운명의 판결\"이 [Arg3] % 증가하며, 뮤탄트 적에게 가하는 \"운명의 판결\"이 두 배가 됩니다."
  },
  AwakerTalent_78642_TalentDesc_8 = {
    Text = "·해당 특성은 \"별의 시대\" 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점 은열쇠 에너지를 획득합니다.\n·아라크네가 발생시키는 \"운명의 판결\"이 [Arg3] % 증가하며, 뮤탄트 적에게 가하는 \"운명의 판결\"이 두 배가 됩니다."
  },
  AwakerTalent_78642_TalentDesc_9 = {
    Text = "·해당 특성은 \"별의 시대\" 단계에서만 발동됩니다.\n·해당 깨어남체의 체력, 공격, 방어가 [Arg1] % 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 [Arg2] 점 은열쇠 에너지를 획득합니다.\n·아라크네가 발생시키는 \"운명의 판결\"이 [Arg3] % 증가하며, 뮤탄트 적에게 가하는 \"운명의 판결\"이 두 배가 됩니다."
  },
  AwakerTalent_78642_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78642_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78642_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78642_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78642_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78642_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78642_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78642_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78642_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78642_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78643_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78643_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78643_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78643_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78643_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78643_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78643_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78643_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78643_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78643_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78643_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78643_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78643_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78643_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78643_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78643_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78643_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78643_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78643_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78643_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78643_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78643_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78643_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78643_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78644_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78644_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78644_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78644_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78644_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78644_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78644_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78644_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78644_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78644_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78644_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78644_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78644_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78644_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78644_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78644_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78644_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78644_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78644_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78644_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78644_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78644_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78644_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78644_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78645_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘 획득량이 [Arg3]% 증가합니다.\n· 클레멘타인이 「곤충」 적에게 피해를 가할 때, 대상에게 피해량 [Arg4]%만큼 출혈을 부여합니다. 클레멘타인이 매 턴 처음으로 방어막을 생성하거나 HP를 회복할 때, 「곤충」 적은 일시적으로 클레멘타인 방어력 [Arg5]%의 힘을 잃습니다."
  },
  AwakerTalent_78645_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘 획득량이 [Arg3]% 증가합니다.\n· 클레멘타인이 「곤충」 적에게 피해를 가할 때, 대상에게 피해량 [Arg4]%만큼 출혈을 부여합니다. 클레멘타인이 매 턴 처음으로 방어막을 생성하거나 HP를 회복할 때, 「곤충」 적은 일시적으로 클레멘타인 방어력 [Arg5]%의 힘을 잃습니다."
  },
  AwakerTalent_78645_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘 획득량이 [Arg3]% 증가합니다.\n· 클레멘타인이 「곤충」 적에게 피해를 가할 때, 대상에게 피해량 [Arg4]%만큼 출혈을 부여합니다. 클레멘타인이 매 턴 처음으로 방어막을 생성하거나 HP를 회복할 때, 「곤충」 적은 일시적으로 클레멘타인 방어력 [Arg5]%의 힘을 잃습니다."
  },
  AwakerTalent_78645_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘 획득량이 [Arg3]% 증가합니다.\n· 클레멘타인이 「곤충」 적에게 피해를 가할 때, 대상에게 피해량 [Arg4]%만큼 출혈을 부여합니다. 클레멘타인이 매 턴 처음으로 방어막을 생성하거나 HP를 회복할 때, 「곤충」 적은 일시적으로 클레멘타인 방어력 [Arg5]%의 힘을 잃습니다."
  },
  AwakerTalent_78645_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘 획득량이 [Arg3]% 증가합니다.\n· 클레멘타인이 「곤충」 적에게 피해를 가할 때, 대상에게 피해량 [Arg4]%만큼 출혈을 부여합니다. 클레멘타인이 매 턴 처음으로 방어막을 생성하거나 HP를 회복할 때, 「곤충」 적은 일시적으로 클레멘타인 방어력 [Arg5]%의 힘을 잃습니다."
  },
  AwakerTalent_78645_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘 획득량이 [Arg3]% 증가합니다.\n· 클레멘타인이 「곤충」 적에게 피해를 가할 때, 대상에게 피해량 [Arg4]%만큼 출혈을 부여합니다. 클레멘타인이 매 턴 처음으로 방어막을 생성하거나 HP를 회복할 때, 「곤충」 적은 일시적으로 클레멘타인 방어력 [Arg5]%의 힘을 잃습니다."
  },
  AwakerTalent_78645_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘 획득량이 [Arg3]% 증가합니다.\n· 클레멘타인이 「곤충」 적에게 피해를 가할 때, 대상에게 피해량 [Arg4]%만큼 출혈을 부여합니다. 클레멘타인이 매 턴 처음으로 방어막을 생성하거나 HP를 회복할 때, 「곤충」 적은 일시적으로 클레멘타인 방어력 [Arg5]%의 힘을 잃습니다."
  },
  AwakerTalent_78645_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘 획득량이 [Arg3]% 증가합니다.\n· 클레멘타인이 「곤충」 적에게 피해를 가할 때, 대상에게 피해량 [Arg4]%만큼 출혈을 부여합니다. 클레멘타인이 매 턴 처음으로 방어막을 생성하거나 HP를 회복할 때, 「곤충」 적은 일시적으로 클레멘타인 방어력 [Arg5]%의 힘을 잃습니다."
  },
  AwakerTalent_78645_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘 획득량이 [Arg3]% 증가합니다.\n· 클레멘타인이 「곤충」 적에게 피해를 가할 때, 대상에게 피해량 [Arg4]%만큼 출혈을 부여합니다. 클레멘타인이 매 턴 처음으로 방어막을 생성하거나 HP를 회복할 때, 「곤충」 적은 일시적으로 클레멘타인 방어력 [Arg5]%의 힘을 잃습니다."
  },
  AwakerTalent_78645_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘 획득량이 [Arg3]% 증가합니다.\n· 클레멘타인이 「곤충」 적에게 피해를 가할 때, 대상에게 피해량 [Arg4]%만큼 출혈을 부여합니다. 클레멘타인이 매 턴 처음으로 방어막을 생성하거나 HP를 회복할 때, 「곤충」 적은 일시적으로 클레멘타인 방어력 [Arg5]%의 힘을 잃습니다."
  },
  AwakerTalent_78645_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78645_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78645_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78645_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78645_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78645_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78645_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78645_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78645_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78645_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78646_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78646_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78646_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78646_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78646_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78646_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78646_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78646_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78646_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78646_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_78646_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78646_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78646_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78646_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78646_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78646_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78646_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78646_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78646_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78646_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78647_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78647_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78647_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78647_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78647_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78647_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78647_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78647_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78647_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78647_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78647_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78647_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78647_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78647_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78647_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78647_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78647_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78647_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78647_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78647_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78647_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78647_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78647_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78647_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78749_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78749_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78749_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78749_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78749_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78749_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78749_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78749_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78749_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78749_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78749_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78749_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78749_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78749_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78749_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78749_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78749_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78749_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78749_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78749_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78749_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78749_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78749_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78749_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78911_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 탄망·머피가 피해를 입힐 때 피해량의 [Arg3]%만큼 「희생」을 부여하며, 「운명의 계약」의 「강생 의식」 스택 증가량을 두 배로 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 때, 최대 HP가 6%/15%/30% 증가합니다. 「레무리아」 깨어남체가 광기 폭발을 사용한 후 탄망·머피 방어력 50%/125%/250%의 방어막을 획득하며, 이 효과는 턴마다 1번만 발동하고 방어막 증가 효과에 영향을 받지 않습니다."
  },
  AwakerTalent_78911_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 탄망·머피가 피해를 입힐 때 피해량의 [Arg3]%만큼 「희생」을 부여하며, 「운명의 계약」의 「강생 의식」 스택 증가량을 두 배로 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 때, 최대 HP가 6%/15%/30% 증가합니다. 「레무리아」 깨어남체가 광기 폭발을 사용한 후 탄망·머피 방어력 50%/125%/250%의 방어막을 획득하며, 이 효과는 턴마다 1번만 발동하고 방어막 증가 효과에 영향을 받지 않습니다."
  },
  AwakerTalent_78911_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 탄망·머피가 피해를 입힐 때 피해량의 [Arg3]%만큼 「희생」을 부여하며, 「운명의 계약」의 「강생 의식」 스택 증가량을 두 배로 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 때, 최대 HP가 6%/15%/30% 증가합니다. 「레무리아」 깨어남체가 광기 폭발을 사용한 후 탄망·머피 방어력 50%/125%/250%의 방어막을 획득하며, 이 효과는 턴마다 1번만 발동하고 방어막 증가 효과에 영향을 받지 않습니다."
  },
  AwakerTalent_78911_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 탄망·머피가 피해를 입힐 때 피해량의 [Arg3]%만큼 「희생」을 부여하며, 「운명의 계약」의 「강생 의식」 스택 증가량을 두 배로 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 때, 최대 HP가 6%/15%/30% 증가합니다. 「레무리아」 깨어남체가 광기 폭발을 사용한 후 탄망·머피 방어력 50%/125%/250%의 방어막을 획득하며, 이 효과는 턴마다 1번만 발동하고 방어막 증가 효과에 영향을 받지 않습니다."
  },
  AwakerTalent_78911_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 탄망·머피가 피해를 입힐 때 피해량의 [Arg3]%만큼 「희생」을 부여하며, 「운명의 계약」의 「강생 의식」 스택 증가량을 두 배로 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 때, 최대 HP가 6%/15%/30% 증가합니다. 「레무리아」 깨어남체가 광기 폭발을 사용한 후 탄망·머피 방어력 50%/125%/250%의 방어막을 획득하며, 이 효과는 턴마다 1번만 발동하고 방어막 증가 효과에 영향을 받지 않습니다."
  },
  AwakerTalent_78911_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 탄망·머피가 피해를 입힐 때 피해량의 [Arg3]%만큼 「희생」을 부여하며, 「운명의 계약」의 「강생 의식」 스택 증가량을 두 배로 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 때, 최대 HP가 6%/15%/30% 증가합니다. 「레무리아」 깨어남체가 광기 폭발을 사용한 후 탄망·머피 방어력 50%/125%/250%의 방어막을 획득하며, 이 효과는 턴마다 1번만 발동하고 방어막 증가 효과에 영향을 받지 않습니다."
  },
  AwakerTalent_78911_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 탄망·머피가 피해를 입힐 때 피해량의 [Arg3]%만큼 「희생」을 부여하며, 「운명의 계약」의 「강생 의식」 스택 증가량을 두 배로 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 때, 최대 HP가 6%/15%/30% 증가합니다. 「레무리아」 깨어남체가 광기 폭발을 사용한 후 탄망·머피 방어력 50%/125%/250%의 방어막을 획득하며, 이 효과는 턴마다 1번만 발동하고 방어막 증가 효과에 영향을 받지 않습니다."
  },
  AwakerTalent_78911_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 탄망·머피가 피해를 입힐 때 피해량의 [Arg3]%만큼 「희생」을 부여하며, 「운명의 계약」의 「강생 의식」 스택 증가량을 두 배로 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 때, 최대 HP가 6%/15%/30% 증가합니다. 「레무리아」 깨어남체가 광기 폭발을 사용한 후 탄망·머피 방어력 50%/125%/250%의 방어막을 획득하며, 이 효과는 턴마다 1번만 발동하고 방어막 증가 효과에 영향을 받지 않습니다."
  },
  AwakerTalent_78911_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 탄망·머피가 피해를 입힐 때 피해량의 [Arg3]%만큼 「희생」을 부여하며, 「운명의 계약」의 「강생 의식」 스택 증가량을 두 배로 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 때, 최대 HP가 6%/15%/30% 증가합니다. 「레무리아」 깨어남체가 광기 폭발을 사용한 후 탄망·머피 방어력 50%/125%/250%의 방어막을 획득하며, 이 효과는 턴마다 1번만 발동하고 방어막 증가 효과에 영향을 받지 않습니다."
  },
  AwakerTalent_78911_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다. \n· 탄망·머피가 피해를 입힐 때 피해량의 [Arg3]%만큼 「희생」을 부여하며, 「운명의 계약」의 「강생 의식」 스택 증가량을 두 배로 증가시킵니다. \n· 팀에 다른 「레무리아」 깨어남체가 1/2/3명 존재할 때, 최대 HP가 6%/15%/30% 증가합니다. 「레무리아」 깨어남체가 광기 폭발을 사용한 후 탄망·머피 방어력 50%/125%/250%의 방어막을 획득하며, 이 효과는 턴마다 1번만 발동하고 방어막 증가 효과에 영향을 받지 않습니다."
  },
  AwakerTalent_78911_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78911_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78911_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78911_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78911_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78911_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78911_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78911_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78911_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78911_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_78912_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78912_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78912_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78912_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78912_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78912_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78912_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78912_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78912_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78912_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78912_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78912_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78912_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78912_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78912_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78912_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78912_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78912_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78912_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78912_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78912_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78912_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78912_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78912_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78916_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78916_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78916_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78916_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78916_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78916_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78916_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78916_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78916_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78916_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78916_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78916_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_78916_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78916_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78916_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78916_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78916_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78916_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78916_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78916_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78916_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78916_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78916_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_78916_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_79211_TalentDesc_1 = {
    Text = "· 클레멘타인의 명령 카드가 피해를 주면「공감」 1스택을 획득합니다.\n· 클레멘타인 자신, 장착된 명륜 및 비밀 계약의 은열쇠 충전 1마다 크리티컬 확률과 크리티컬 피해가 0.35% 상승합니다.\n·초차원 턴 시작 시, 모든 적의「정신적 외상」과「두려움 고착」을 제거합니다. 모든 적의「정신적 외상」이 1 제거될 때마다 은열쇠 에너지 50을 획득하고, 모든 적의 「두려움 고착」이 1 제거될 때마다 다른 깨어남체가 2 광기를 획득합니다."
  },
  AwakerTalent_79211_TalentName_1 = {
    Text = "군체 감응"
  },
  AwakerTalent_79788_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_79788_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_79788_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_79788_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_79788_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_79788_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_79788_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_79788_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_79788_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_79788_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다."
  },
  AwakerTalent_79788_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_79788_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_79788_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_79788_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_79788_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_79788_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_79788_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_79788_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_79788_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_79788_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_83778_TalentDesc_1 = {
    Text = "· 코퍼산트 자신, 장착된 운명 바퀴 및 비밀 계약의 죽음 저항 1%마다, 기본 피해가 0.2% 증가하고, 생성하는 방어막이 0.05% 증가합니다."
  },
  AwakerTalent_83778_TalentName_1 = {
    Text = "남은 불씨"
  },
  AwakerTalent_84132_TalentDesc_1 = {
    Text = "· 오레타의 광기 충전 레벨 1pt마다 전투 시작 시 오레타 공격력의 2% 만큼의 촉수 피해를 획득하고, 치명타 확률 1%마다 전투 시작 시 오레타 공격력의 1% 만큼의 촉수 피해를 획득한다."
  },
  AwakerTalent_84132_TalentName_1 = {
    Text = "즐거운 정령"
  },
  AwakerTalent_89775_TalentDesc_1 = {
    Text = "· 매 턴 처음으로 「검은 깃털」을 사용할 시 모든 적에게 카스토르 공격력 840%의 「침식」을 부여하고 10 광기를 획득합니다.\n· 카스토르는 1% 피해 증폭마다 부여하는 기본 「침식」이 1% 증가합니다.\n· 전투 종료 시, 이번 탐색에서 카스토르가 부여하는 「침식」이 영구적으로 20% 증가합니다.\n· 보스 전투에서는 「침식」을 2배로 부여합니다.\n· 카스토르가 「침식」을 부여한 후, 해당 턴 동안 카스토르가 가하는 피해가 부여량의 5%만큼 증가합니다.\n· 카스토르가 가하는 피해는 「침식」을 제거하지 않습니다."
  },
  AwakerTalent_89775_TalentName_1 = {
    Text = "정화하는 깃털"
  },
  AwakerTalent_95804_TalentDesc_1 = {
    Text = "· 도어세인이 적을 처치하거나, 광기 폭발을 사용하여 보스에게 피해를 주면 「유해」 1스택을 획득합니다.\n· 최대 3스택의 「유해」를 축적할 수 있습니다.\n· 「유해」 스택은 다음 전투로 이어집니다."
  },
  AwakerTalent_95804_TalentName_1 = {
    Text = "유해의 관"
  },
  AwakerTalent_95805_TalentDesc_1 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_95805_TalentDesc_10 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_95805_TalentDesc_11 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_95805_TalentDesc_12 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_95805_TalentDesc_2 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_95805_TalentDesc_3 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_95805_TalentDesc_4 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_95805_TalentDesc_5 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_95805_TalentDesc_6 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_95805_TalentDesc_7 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_95805_TalentDesc_8 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_95805_TalentDesc_9 = {
    Text = "탐색 시작 후, 광기를 [Arg1] 획득합니다."
  },
  AwakerTalent_95805_TalentName_1 = {
    Text = "광기의 징조"
  },
  AwakerTalent_95805_TalentName_10 = {
    Text = "광기의 징조"
  },
  AwakerTalent_95805_TalentName_11 = {
    Text = "광기의 징조"
  },
  AwakerTalent_95805_TalentName_12 = {
    Text = "광기의 징조"
  },
  AwakerTalent_95805_TalentName_2 = {
    Text = "광기의 징조"
  },
  AwakerTalent_95805_TalentName_3 = {
    Text = "광기의 징조"
  },
  AwakerTalent_95805_TalentName_4 = {
    Text = "광기의 징조"
  },
  AwakerTalent_95805_TalentName_5 = {
    Text = "광기의 징조"
  },
  AwakerTalent_95805_TalentName_6 = {
    Text = "광기의 징조"
  },
  AwakerTalent_95805_TalentName_7 = {
    Text = "광기의 징조"
  },
  AwakerTalent_95805_TalentName_8 = {
    Text = "광기의 징조"
  },
  AwakerTalent_95805_TalentName_9 = {
    Text = "광기의 징조"
  },
  AwakerTalent_95806_TalentDesc_1 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘이 [Arg3]% 증가합니다.\n· 도어세인이 「망령」을 처치할 시 광기를 [Arg4] 획득합니다."
  },
  AwakerTalent_95806_TalentDesc_10 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘이 [Arg3]% 증가합니다.\n· 도어세인이 「망령」을 처치할 시 광기를 [Arg4] 획득합니다."
  },
  AwakerTalent_95806_TalentDesc_2 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘이 [Arg3]% 증가합니다.\n· 도어세인이 「망령」을 처치할 시 광기를 [Arg4] 획득합니다."
  },
  AwakerTalent_95806_TalentDesc_3 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘이 [Arg3]% 증가합니다.\n· 도어세인이 「망령」을 처치할 시 광기를 [Arg4] 획득합니다."
  },
  AwakerTalent_95806_TalentDesc_4 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘이 [Arg3]% 증가합니다.\n· 도어세인이 「망령」을 처치할 시 광기를 [Arg4] 획득합니다."
  },
  AwakerTalent_95806_TalentDesc_5 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘이 [Arg3]% 증가합니다.\n· 도어세인이 「망령」을 처치할 시 광기를 [Arg4] 획득합니다."
  },
  AwakerTalent_95806_TalentDesc_6 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘이 [Arg3]% 증가합니다.\n· 도어세인이 「망령」을 처치할 시 광기를 [Arg4] 획득합니다."
  },
  AwakerTalent_95806_TalentDesc_7 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘이 [Arg3]% 증가합니다.\n· 도어세인이 「망령」을 처치할 시 광기를 [Arg4] 획득합니다."
  },
  AwakerTalent_95806_TalentDesc_8 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘이 [Arg3]% 증가합니다.\n· 도어세인이 「망령」을 처치할 시 광기를 [Arg4] 획득합니다."
  },
  AwakerTalent_95806_TalentDesc_9 = {
    Text = "· 이 특성은 「성신편」 스테이지에서만 효과를 발휘합니다. \n· 해당 깨어남체의 체력, 공격, 방어가 [Arg1]% 증가하며, 해당 깨어남체가 처음으로 영지 깨어남을 사용한 후 은열쇠 에너지를 [Arg2] 획득합니다.\n· 모든 깨어남체의 힘이 [Arg3]% 증가합니다.\n· 도어세인이 「망령」을 처치할 시 광기를 [Arg4] 획득합니다."
  },
  AwakerTalent_95806_TalentName_1 = {
    Text = "영혼 단련"
  },
  AwakerTalent_95806_TalentName_10 = {
    Text = "영혼 단련"
  },
  AwakerTalent_95806_TalentName_2 = {
    Text = "영혼 단련"
  },
  AwakerTalent_95806_TalentName_3 = {
    Text = "영혼 단련"
  },
  AwakerTalent_95806_TalentName_4 = {
    Text = "영혼 단련"
  },
  AwakerTalent_95806_TalentName_5 = {
    Text = "영혼 단련"
  },
  AwakerTalent_95806_TalentName_6 = {
    Text = "영혼 단련"
  },
  AwakerTalent_95806_TalentName_7 = {
    Text = "영혼 단련"
  },
  AwakerTalent_95806_TalentName_8 = {
    Text = "영혼 단련"
  },
  AwakerTalent_95806_TalentName_9 = {
    Text = "영혼 단련"
  },
  AwakerTalent_97268_TalentDesc_1 = {
    Text = "도어세인이 「유해」를 획득하면 「영원한 밤의 향연」 1장을 손패에 추가합니다."
  },
  AwakerTalent_97268_TalentName_1 = {
    Text = "부패한 연회의 은총"
  },
  AwakerTalent_98451_TalentDesc_1 = {
    Text = "· 턴 시작 시, 손패에 있는 카티구라의 명령 카드 무작위 1장에 「활염」 1스택을 부여합니다. \n· 카티구라는 「활염」 1스택을 소모할 때마다 「폭염」 1스택을 획득합니다.\n· 「폭염」이 10스택에 도달하면 산출력을 2 획득하고, 모든 「페타 플레어」을 「엑사 플레어」로 강화합니다."
  },
  AwakerTalent_98451_TalentName_1 = {
    Text = "불꽃의 주인"
  },
  AwakerTalent_98714_TalentDesc_1 = {
    Text = "판디아 자신, 장착된 장비, 명륜 및 비밀 계약의 크리티컬 확률 1%마다, 판디아가 생성하는 영구 반격이 0.2% 상승합니다."
  },
  AwakerTalent_98714_TalentName_1 = {
    Text = "처벌 시간"
  },
  AwakerTalent_99107_TalentDesc_1 = {
    Text = "픽맨이 「발견」 효과를 발동하거나 「침식하는 색채」를 사용하면, 「창의」를 1스택 획득합니다."
  },
  AwakerTalent_99107_TalentName_1 = {
    Text = "화가의 눈"
  }
})
return Text_AwakerTalent
