__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_GuideConfig = readonly({
  GuideConfig_10_Content_1 = {
    Text = "앞쪽에 <RedQuality:은색 육익의 거상>이 서 있으며, 눈부신 빛을 발산하고 있습니다."
  },
  GuideConfig_11_Content_1 = {
    Text = "우리는 그분을 정면으로 맞설 수도 있습니다… 또는 이곳에 떠도는 적을 해치운 후 지점을 찾을 수도 있죠. 이제 결정을 내릴 때입니다, 수호자 님."
  },
  GuideConfig_12_Content_1 = {
    Text = "명령 카드를 누른 채 위로 드래그하면 명령을 내릴 수 있습니다."
  },
  GuideConfig_13_Content_1 = {
    Text = "적군이 치명적인 피해를 입힐 공격을 준비하고 있습니다. 방어 명령을 내리세요, 수호자 님!"
  },
  GuideConfig_14_Content_1 = {
    Text = "여왕의 검을 반복적으로 시전하면 공격이 더욱 거세집니다. 이 스킬로 적을 처치해 보시겠습니까?"
  },
  GuideConfig_15_Content_1 = {
    Text = "공격 명령을 수행하면 광기를 획득할 수 있으며, 광기가 가득 차면 강력한 광기 폭발을 발동할 수 있습니다."
  },
  GuideConfig_1_Content_1 = {
    Text = "수호자 님, 이제 계속 나아가 탐험할 수 있습니다."
  },
  GuideConfig_2_Content_1 = {
    Text = "미사그와의 연락 지점으로, 은열쇠 공명을 통해 HP를 회복할 수 있습니다. 이게 저희가 필요로 하는 거죠."
  },
  GuideConfig_34_Content_1 = {
    Text = "현재 전투 튜토리얼 단계이며, 아직 사용 가능한 명령 카드가 존재합니다. 튜토리얼 완료 후에는 자유롭게 플레이할 수 있습니다."
  },
  GuideConfig_35_Content_1 = {
    Text = "현재 전투 튜토리얼 단계이며, 아직 사용 가능한 명령 카드가 존재합니다. 튜토리얼 완료 후에는 자유롭게 플레이할 수 있습니다."
  },
  GuideConfig_36_Content_1 = {
    Text = "현재 전투 튜토리얼 단계이며, 아직 사용 가능한 명령 카드가 존재합니다. 튜토리얼 완료 후에는 자유롭게 플레이할 수 있습니다."
  },
  GuideConfig_37_Content_1 = {
    Text = "현재 전투 튜토리얼 단계이며, 아직 사용 가능한 명령 카드가 존재합니다. 튜토리얼 완료 후에는 자유롭게 플레이할 수 있습니다."
  },
  GuideConfig_38_Content_1 = {
    Text = "현재 전투 튜토리얼 단계이며, 아직 사용 가능한 광기 폭발이 존재합니다. 튜토리얼 완료 후에는 자유롭게 플레이할 수 있습니다."
  },
  GuideConfig_39_Content_1 = {
    Text = "현재 전투 튜토리얼 단계이며, 아직 사용 가능한 광기 폭발이 존재합니다. 튜토리얼 완료 후에는 자유롭게 플레이할 수 있습니다."
  },
  GuideConfig_3_Content_1 = {
    Text = "빨리 <RedQuality:폭주하는 고래의 도약>을 물리쳐 보세요. 다시는 그런 비극을 보고 싶지 않아요."
  },
  GuideConfig_40_Content_1 = {
    Text = "현재 전투 튜토리얼 단계이며, 아직 사용 가능한 광기 폭발이 존재합니다. 튜토리얼 완료 후에는 자유롭게 플레이할 수 있습니다."
  },
  GuideConfig_41_Content_1 = {
    Text = "현재 전투 튜토리얼 단계이며, 아직 사용 가능한 광기 폭발이 존재합니다. 튜토리얼 완료 후에는 자유롭게 플레이할 수 있습니다."
  },
  GuideConfig_42_Content_1 = {
    Text = "현재 전투 튜토리얼 단계이며, 아직 사용 가능한 열쇠 지령이 존재합니다. 튜토리얼 완료 후에는 자유롭게 플레이할 수 있습니다."
  },
  GuideConfig_47_Content_1 = {
    Text = "혼돈 영역은 은열쇠와 강렬한 공명을 일으켜, 매 턴 은열쇠 에너지를 250 포인트 획득하여 열쇠 명령을 더 빠르게 발동할 수 있습니다. 파티에 다른 영역의 깨어남체가 없을 경우, 관문 진입 시 백은 유물 하나를 추가로 획득합니다. 유물의 도움을 활용하여 적을 물리치세요."
  },
  GuideConfig_47_TipsTitle_1 = {
    Text = "혼돈 영역"
  },
  GuideConfig_49_Content_1 = {
    Text = "심해 영역은 전투 시작 시 촉수 1개를 생성하며, 촉수는 매 턴 종료 시 전열의 적을 공격합니다. 심해 깨어남체들은 촉수에 다양한 증폭을 제공할 수 있으며, 촉수 아이콘 하단의 수치를 통해 현재 촉수 피해량을 확인할 수 있습니다."
  },
  GuideConfig_49_TipsTitle_1 = {
    Text = "심해 영역"
  },
  GuideConfig_4_Content_1 = {
    Text = "검은 인장은 비경의 <Yellow:융흔>에 바쳐 다양한 <Yellow:유물>을 얻을 수 있으며, 이는 전투에 큰 도움이 됩니다."
  },
  GuideConfig_55_Content_1 = {
    Text = "혈육 영역은 매 턴마다 배아 융합과 진홍 용광로를 축적하며, 생명력이 낮을수록 축적 효율이 높아집니다. 배아 융합도가 한도에 도달하면 배아 카드가 생성되어 패에 추가됩니다. 배아는 직접 사용하여 해당 깨어남체에게 광기와 임시 치명타율을 부여할 수 있으며, 혈육 영역 깨어남체의 광기 폭발을 통해 흡수되어 추가 효과를 발동할 수도 있습니다."
  },
  GuideConfig_55_TipsTitle_1 = {
    Text = "혈육 차원"
  },
  GuideConfig_57_Content_1 = {
    Text = "「진홍 용광로」를 사용하여 생명력을 회복하고 적의 공격에 대응하세요!"
  },
  GuideConfig_58_Content_1 = {
    Text = "혈육 영역 깨어남체가 광기 폭발을 발동할 때, 패에 있는 배아를 흡수하여 광기 폭발 효과를 강화할 수 있습니다. 만고의 눈를 발동하여 흡수를 발동하세요!"
  },
  GuideConfig_5_Content_1 = {
    Text = "<Yellow:융흔>을 발견했으니 모아둔 검은 인장을 투입해 보세요."
  },
  GuideConfig_60_Content_1 = {
    Text = "초차원 영역에서는 매 턴 사용한 첫 번째 지령 카드의 임시 복제본이 초차원 공간에 들어갑니다. 초차원 공간이 한도에 도달하면 새로운 턴에 진입할 수 있습니다. 새로운 턴에서는 카드를 뽑지 않고 초차원 공간의 카드가 패에 추가됩니다."
  },
  GuideConfig_60_TipsTitle_1 = {
    Text = "초차원 영역"
  },
  GuideConfig_6_Content_1 = {
    Text = "이것이 <Yellow:유물>입니다. 유물은 비경에서 탄생한 물건으로, 곧 그 힘을 느끼게 될 거예요. 안타깝게도 유물이 비경을 떠나면 사라져 버립니다."
  },
  GuideConfig_7_Content_1 = {
    Text = "앞쪽에 긴급한 <Yellow:이벤트>가 있는 것 같아요. 가보세요. 예상치 못한 강화를 획득할 수 있을지도 모르니까요… 하지만 때때로 대가가 따르기도 하죠."
  },
  GuideConfig_8_Content_1 = {
    Text = "앞쪽에 적이 있는 것 같습니다."
  },
  GuideConfig_9_Content_1 = {
    Text = "이 길은 일방통행입니다. 지하 로비로 이어지죠. 자, 우리의 사명을 완수하러 가볼까요?"
  }
})
return Text_GuideConfig
