__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MapNodeType = readonly({
  MapNodeType_116420_Desc = {
    Text = "은열쇠가 당신을 이곳으로 인도했습니다. 이곳에 존재하는 것과 공명하세요."
  },
  MapNodeType_116420_Name = {
    Text = "랜덤 노드"
  },
  MapNodeType_116421_Desc = {
    Text = "은열쇠가 당신을 이곳으로 인도했습니다. 이곳에 존재하는 것과 공명하세요."
  },
  MapNodeType_116421_Name = {
    Text = "랜덤 전투"
  },
  MapNodeType_116422_Desc = {
    Text = "은열쇠가 당신을 이곳으로 인도했습니다. 이곳에 존재하는 것과 공명하세요."
  },
  MapNodeType_116422_Name = {
    Text = "랜덤 이벤트"
  },
  MapNodeType_121329_Desc = {
    Text = "은열쇠가 당신을 이곳으로 인도했습니다. 이곳에 존재하는 것과 공명하세요."
  },
  MapNodeType_121329_Name = {
    Text = "머피의 환영"
  },
  MapNodeType_128222_Name = {
    Text = "명령 노드"
  },
  MapNodeType_130326_Desc = {
    Text = "은열쇠가 당신을 이곳으로 인도했습니다. 이곳에 존재하는 것과 공명하세요."
  },
  MapNodeType_130326_Name = {
    Text = "운명의 극장"
  },
  MapNodeType_149067_Desc = {
    Text = "은열쇠가 당신을 이곳으로 인도했습니다. 이곳에 존재하는 것과 공명하세요."
  },
  MapNodeType_149067_Name = {
    Text = "하늘 위 신기루"
  },
  MapNodeType_18391_Desc = {
    Text = "위험인지 기회인지는, 당신의 결정에 달려 있습니다."
  },
  MapNodeType_18391_Name = {Text = "이벤트"},
  MapNodeType_18392_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_18392_Name = {
    Text = "기괴한 농포"
  },
  MapNodeType_18393_Desc = {
    Text = "정신적 안개에는 형체가 없지만, 단단해서 어떤 물체도 통과할 수 없습니다."
  },
  MapNodeType_18393_Name = {Text = "허무"},
  MapNodeType_18394_Desc = {
    Text = "위험인지 기회인지는, 당신의 결정에 달려 있습니다."
  },
  MapNodeType_18394_Name = {Text = "이벤트"},
  MapNodeType_18395_Desc = {
    Text = "하나의 만남, 하나의 위기, 혹은 하나의 추억"
  },
  MapNodeType_18395_Name = {Text = "스토리"},
  MapNodeType_18396_Desc = {
    Text = "마지막이자, 가장 강한 적입니다. 해당 적을 쓰러뜨리면 조사를 완료할 수 있습니다."
  },
  MapNodeType_18396_Name = {Text = "최종전"},
  MapNodeType_18397_Desc = {
    Text = "융식 흔적의 알 수 없는 존재가, 당신이 가진 검은 인장을 강력한 힘과 교환하기를 갈망합니다."
  },
  MapNodeType_18397_Name = {
    Text = "정제 융식 흔적"
  },
  MapNodeType_18398_Desc = {
    Text = "미사그 대학의 지원을 받아 HP를 회복할 수 있습니다."
  },
  MapNodeType_18398_Name = {
    Text = "연락 지점"
  },
  MapNodeType_18399_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_18399_Name = {Text = "꿀 와인"},
  MapNodeType_18400_Desc = {
    Text = "어두운 웅덩이는 그 깊이를 헤아릴 수 없으며, 알 수 없는 것들로 가득 차 있습니다. 발동 후 랜덤 보상을 획득할 수 있습니다."
  },
  MapNodeType_18400_Name = {
    Text = "어두운 웅덩이"
  },
  MapNodeType_18401_Desc = {
    Text = "위험인지 기회인지는, 당신의 결정에 달려 있습니다."
  },
  MapNodeType_18401_Name = {Text = "이벤트"},
  MapNodeType_18402_Desc = {
    Text = "플레이어의 시작 위치. 이 노드가 보여서는 안 됩니다. 보이면 버그가 있는 것입니다!"
  },
  MapNodeType_18402_Name = {Text = "시작점"},
  MapNodeType_18403_Desc = {
    Text = "빛과 그림자의 공연"
  },
  MapNodeType_18403_Name = {
    Text = "빛과 그림자의 공연"
  },
  MapNodeType_18404_Desc = {
    Text = "환몽의 공간에서 사용되는 화폐인 검은 인장을 획득합니다."
  },
  MapNodeType_18404_Name = {
    Text = "검은 인장"
  },
  MapNodeType_18405_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_18405_Name = {
    Text = "미완성 조각상"
  },
  MapNodeType_18406_Desc = {
    Text = "비밀 통로의 출구는 이미 무너져 있어, 다시 입구로 돌아갈 수 없습니다."
  },
  MapNodeType_18406_Name = {
    Text = "비밀 통로 출구"
  },
  MapNodeType_18407_Desc = {
    Text = "유물을 획득합니다."
  },
  MapNodeType_18407_Name = {Text = "유물"},
  MapNodeType_18408_Desc = {
    Text = "들어가면 되돌아올 수 없는 불안정한 통로입니다."
  },
  MapNodeType_18408_Name = {
    Text = "비밀 통로 입구"
  },
  MapNodeType_18409_Desc = {
    Text = "테스트 수정구슬"
  },
  MapNodeType_18409_Name = {
    Text = "테스트 수정구슬"
  },
  MapNodeType_18410_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_18410_Name = {
    Text = "대행의 의식"
  },
  MapNodeType_18411_Desc = {
    Text = "일부 강한 적들과의 전투는 더 어렵습니다."
  },
  MapNodeType_18411_Name = {Text = "엘리트"},
  MapNodeType_18412_Desc = {
    Text = "융식 흔적의 알 수 없는 존재가, 당신이 가진 검은 인장을 강력한 힘과 교환하기를 갈망합니다."
  },
  MapNodeType_18412_Name = {
    Text = "정제 융식 흔적"
  },
  MapNodeType_18413_Desc = {
    Text = "미사그 대학의 지원을 받아 HP를 회복하거나, 깨어남체 한 명을 깨어남시킬 수 있습니다."
  },
  MapNodeType_18413_Name = {
    Text = "연락 지점"
  },
  MapNodeType_18414_Desc = {
    Text = "융식 흔적의 알 수 없는 존재가, 당신이 가진 검은 인장을 강력한 힘과 교환하기를 갈망합니다."
  },
  MapNodeType_18414_Name = {
    Text = "각인 융식 흔적"
  },
  MapNodeType_18415_Desc = {
    Text = "비밀 보상"
  },
  MapNodeType_18415_Name = {
    Text = "비밀 보상"
  },
  MapNodeType_18416_Desc = {
    Text = "융식 흔적의 알 수 없는 존재가, 당신이 가진 검은 인장을 강력한 힘과 교환하기를 갈망합니다."
  },
  MapNodeType_18416_Name = {
    Text = "유물 융식 흔적"
  },
  MapNodeType_18417_Desc = {
    Text = "검은 터널은 미지로 통하며, 들어가면 터널의 반대편으로 보내집니다."
  },
  MapNodeType_18417_Name = {Text = "터널"},
  MapNodeType_18419_Desc = {
    Text = "테스트 시간 제한 붕괴 바닥"
  },
  MapNodeType_18419_Name = {
    Text = "시간 제한 붕괴 바닥"
  },
  MapNodeType_18420_Desc = {
    Text = "테스트 비밀 통로"
  },
  MapNodeType_18420_Name = {
    Text = "테스트 비밀 통로"
  },
  MapNodeType_18421_Desc = {
    Text = "진한 안개를 몰아낼 수 있는 고대의 조명 장치입니다."
  },
  MapNodeType_18421_Name = {Text = "조명등"},
  MapNodeType_18422_Desc = {
    Text = "침묵 속에 서 있는 견고한 문살. 열기 위해서는 녹슨 열쇠가 필요합니다."
  },
  MapNodeType_18422_Name = {Text = "녹슨 문"},
  MapNodeType_18423_Desc = {
    Text = "융식 흔적의 알 수 없는 존재가, 당신이 가진 검은 인장을 강력한 힘과 교환하기를 갈망합니다."
  },
  MapNodeType_18423_Name = {
    Text = "융식 흔적"
  },
  MapNodeType_18424_Desc = {
    Text = "불안정한 바닥"
  },
  MapNodeType_18424_Name = {
    Text = "불안정한 바닥"
  },
  MapNodeType_18425_Desc = {
    Text = "인내심을 가지고 자신의 문을 찾고 있는 녹슨 열쇠입니다."
  },
  MapNodeType_18425_Name = {
    Text = "녹슨 열쇠"
  },
  MapNodeType_18426_Desc = {
    Text = "프로필 변경"
  },
  MapNodeType_18426_Name = {
    Text = "프로필 변경"
  },
  MapNodeType_18427_Desc = {
    Text = "왜곡된 환상이 당신의 앞길을 막습니다. 만약 제거한다면, 미지의 증상에 감염될 수 있습니다."
  },
  MapNodeType_18427_Name = {Text = "환상"},
  MapNodeType_18428_Desc = {
    Text = "떠다니는 은심을 추출하세요."
  },
  MapNodeType_18428_Name = {Text = "은심"},
  MapNodeType_18429_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_18429_Name = {
    Text = "선의의 선물"
  },
  MapNodeType_18430_Desc = {
    Text = "테스트용 특수 상점 노드입니다. 이 메시지를 보고 있다면 공식 스테이지에 있지 않은 상태입니다."
  },
  MapNodeType_18430_Name = {
    Text = "특수 상점"
  },
  MapNodeType_18431_Desc = {
    Text = "뜻밖의 조우에서는 전투가 벌어질 때도 있습니다."
  },
  MapNodeType_18431_Name = {Text = "전투"},
  MapNodeType_18432_Desc = {
    Text = "위험한 융식 지대입니다. 함부로 발을 들이지 마세요."
  },
  MapNodeType_18432_Name = {
    Text = "사악한 늪"
  },
  MapNodeType_24876_Desc = {
    Text = "일부 강한 적들과의 전투는 더 어렵습니다."
  },
  MapNodeType_24876_Name = {Text = "엘리트"},
  MapNodeType_35056_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_35056_Name = {
    Text = "프로듀서의 딜레마"
  },
  MapNodeType_35889_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_35889_Name = {
    Text = "순백의 돛"
  },
  MapNodeType_37987_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_37987_Name = {
    Text = "비밀 대행 명령"
  },
  MapNodeType_38711_Desc = {
    Text = "융식 흔적의 알 수 없는 존재가, 당신이 가진 검은 인장을 강력한 힘과 교환하기를 갈망합니다."
  },
  MapNodeType_38711_Name = {
    Text = "샤리치 시장"
  },
  MapNodeType_44838_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_44838_Name = {Text = "욕망"},
  MapNodeType_44839_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_44839_Name = {Text = "구원"},
  MapNodeType_44840_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_44840_Name = {Text = "참회"},
  MapNodeType_46149_Desc = {
    Text = "융식 흔적의 알 수 없는 존재가, 당신이 가진 검은 인장을 강력한 힘과 교환하기를 갈망합니다."
  },
  MapNodeType_46149_Name = {
    Text = "융식 흔적"
  },
  MapNodeType_47473_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_47473_Name = {Text = "자각몽"},
  MapNodeType_47474_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_47474_Name = {
    Text = "주체 융합"
  },
  MapNodeType_47475_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_47475_Name = {
    Text = "최면의 뱀"
  },
  MapNodeType_48144_Desc = {
    Text = "위험인지 기회인지는, 당신의 결정에 달려 있습니다."
  },
  MapNodeType_48144_Name = {
    Text = "자아 지각"
  },
  MapNodeType_49058_Desc = {
    Text = "검붉은 웅덩이 속에 무엇인가 숨어 있는 것 같습니다."
  },
  MapNodeType_49058_Name = {
    Text = "피의 웅덩이"
  },
  MapNodeType_49100_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_49100_Name = {
    Text = "잉태의 어머니"
  },
  MapNodeType_52484_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_52484_Name = {Text = "재난"},
  MapNodeType_52485_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_52485_Name = {Text = "재난"},
  MapNodeType_52486_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_52486_Name = {Text = "재난"},
  MapNodeType_52487_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_52487_Name = {
    Text = "마지막 제물"
  },
  MapNodeType_55797_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_55797_Name = {
    Text = "봄의 선물"
  },
  MapNodeType_55798_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_55798_Name = {
    Text = "뮤즈의 은총"
  },
  MapNodeType_57740_Desc = {
    Text = "이 지역은 시야를 가릴 장애물도 없이, 완벽하게 심사회의 감시에 노출되어 있습니다."
  },
  MapNodeType_57740_Name = {
    Text = "감시 지점"
  },
  MapNodeType_57741_Desc = {
    Text = "심사회의 경비는 그리 철저하지 않습니다. 빠져나갈 틈새를 발견할 수 있을 지도요?"
  },
  MapNodeType_57741_Name = {Text = "구금소"},
  MapNodeType_57742_Desc = {
    Text = "유리에트의 부하들은 끝이 없어 보입니다. 또 다른 심사회의 요원들이 당신의 앞길을 가로막습니다."
  },
  MapNodeType_57742_Name = {
    Text = "심사회 요원"
  },
  MapNodeType_59662_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_59662_Name = {Text = "입학식"},
  MapNodeType_65469_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_65469_Name = {
    Text = "안전한 철수 지점"
  },
  MapNodeType_74221_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_74221_Name = {
    Text = "희미하게 남은 의식"
  },
  MapNodeType_76256_Desc = {
    Text = "리모리아의 가라앉은 유적입니다. 그 뒤에 숨은 존재는 당신이 가진 검은 인장과 신비한 힘을 교환하려 합니다."
  },
  MapNodeType_76256_Name = {
    Text = "재의 유적"
  },
  MapNodeType_76417_Desc = {
    Text = "창백한 뼛조각이, 검은 융식액에 반 정도 잠겨 있습니다."
  },
  MapNodeType_76417_Name = {
    Text = "빛바랜 유골"
  },
  MapNodeType_80599_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_80599_Name = {
    Text = "생명의 변신"
  },
  MapNodeType_90661_Desc = {
    Text = "은열쇠가 당신을 이곳으로 이끌었습니다. 이곳에 있는 것과 공명하세요."
  },
  MapNodeType_90661_Name = {
    Text = "궁극의 맛"
  }
})
return Text_MapNodeType
