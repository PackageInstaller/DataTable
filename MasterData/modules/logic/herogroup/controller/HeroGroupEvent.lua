-- chunkname: @modules/logic/herogroup/controller/HeroGroupEvent.lua

module("modules.logic.herogroup.controller.HeroGroupEvent", package.seeall)

local HeroGroupEvent = _M

HeroGroupEvent.OnGetHeroGroupList = 1
HeroGroupEvent.OnModifyHeroGroup = 2
HeroGroupEvent.OnThirdPosOpen = 3
HeroGroupEvent.OnFourthPosOpen = 4
HeroGroupEvent.OnFirstPosHasEquip = 5
HeroGroupEvent.ShowGuideDragEffect = 6
HeroGroupEvent.HardModeShowRuleDesc = 7
HeroGroupEvent.HardModeHideRuleDesc = 8
HeroGroupEvent.HideAllGroupHeroItemEffect = 9
HeroGroupEvent.OnCreateHeroItemDone = 10
HeroGroupEvent.OnClickHeroGroupItem = 11
HeroGroupEvent.OnClickHeroEditItem = 12
HeroGroupEvent.OnClickEquipItem = 13
HeroGroupEvent.OnUpdateRecommendLevel = 14
HeroGroupEvent.OnHeroEditItemSelectChange = 15
HeroGroupEvent.SelectHeroGroup = 22
HeroGroupEvent.ChangeEquip = 25
HeroGroupEvent.OnClickEnemyItem = 31
HeroGroupEvent.OnClickRecommendCharacter = 32
HeroGroupEvent.OnHeroGroupExit = 41
HeroGroupEvent.setHeroGroupEquipEffect = 42
HeroGroupEvent.PlayHeroGroupExitEffect = 43
HeroGroupEvent.PlayHeroGroupHeroEffect = 44
HeroGroupEvent.CloseHeroGroupHeroSelectEffect = 45
HeroGroupEvent.PlayCloseHeroGroupAnimation = 46
HeroGroupEvent.SwitchReplay = 47
HeroGroupEvent.HeroMoveForward = 50
HeroGroupEvent.OnHasRecord = 51
HeroGroupEvent.OnEnteryEquipType = 52
HeroGroupEvent.OnEnteryNormalType = 53
HeroGroupEvent.OnUseRecommendGroup = 54
HeroGroupEvent.ShowEnemyInfoViewByGuide = 55
HeroGroupEvent.OpenHeroGroupFinishWithEpisodeId = 56
HeroGroupEvent.OpenHeroGroupFinishWithChapterId = 57
HeroGroupEvent.OpenHeroGroupFinishWithEpisodeType = 58
HeroGroupEvent.OnUseRecommendGroupFinish = 60
HeroGroupEvent.OnCloseEquipTeamShowView = 61
HeroGroupEvent.OnCompareEquip = 62
HeroGroupEvent.OnSnapshotSaveSucc = 71
HeroGroupEvent.SwitchBalance = 81
HeroGroupEvent.OnModifyGroupSelectIndex = 82
HeroGroupEvent.OnModifyGroupName = 83
HeroGroupEvent.BeforeEnterFight = 84
HeroGroupEvent.OnUseRecommendGroupAfterEnterEpisode = 85
HeroGroupEvent.OnReadPreset = 86

return HeroGroupEvent
