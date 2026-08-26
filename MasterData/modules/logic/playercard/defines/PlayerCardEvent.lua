-- chunkname: @modules/logic/playercard/defines/PlayerCardEvent.lua

module("modules.logic.playercard.defines.PlayerCardEvent", package.seeall)

local PlayerCardEvent = _M

PlayerCardEvent.UpdateCardInfo = 1001
PlayerCardEvent.ShowListBtn = 1002
PlayerCardEvent.SwitchHero = 1003
PlayerCardEvent.RefreshSwitchView = 1004
PlayerCardEvent.SwitchHeroSkin = 1005
PlayerCardEvent.SwitchHeroL2d = 1006
PlayerCardEvent.ShowTheme = 1007
PlayerCardEvent.SwitchTheme = 1008
PlayerCardEvent.RefreshMainHeroSkin = 1009
PlayerCardEvent.CloseLayout = 1010
PlayerCardEvent.SelectNumChange = 1011
PlayerCardEvent.SelectCritter = 1012
PlayerCardEvent.OnCloseHeroView = 1013
PlayerCardEvent.OnCloseProgressView = 1014
PlayerCardEvent.OnCloseBaseInfoView = 1015
PlayerCardEvent.OnCloseCritterView = 1016
PlayerCardEvent.RefreshProgressView = 1017
PlayerCardEvent.RefreshBaseInfoView = 1018
PlayerCardEvent.OnCloseBottomView = 1019
PlayerCardEvent.ChangeSkin = 1020
PlayerCardEvent.ModifyEquipBadge = 1021
PlayerCardEvent.CutEquipType = 1022
PlayerCardEvent.OnCancelShowEnterAnimSettingNewReddot = 1031

return PlayerCardEvent
