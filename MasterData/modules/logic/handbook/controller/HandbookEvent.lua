-- chunkname: @modules/logic/handbook/controller/HandbookEvent.lua

module("modules.logic.handbook.controller.HandbookEvent", package.seeall)

local HandbookEvent = _M

HandbookEvent.OnReadInfoChanged = 1001
HandbookEvent.EnterHandbookSkin = 4000
HandbookEvent.OnClickSkinSuitFloorItem = 4001
HandbookEvent.SkinBookSlideToPre = 4002
HandbookEvent.SkinBookSlideToNext = 4003
HandbookEvent.SwitchSkinSuitFloorDone = 4004
HandbookEvent.SkinBookSlide = 4005
HandbookEvent.SkinBookSlideEnd = 4006
HandbookEvent.SkinBookSliding = 4007
HandbookEvent.SkinBookSlideBegin = 4008
HandbookEvent.SkinBookSlideByClick = 4009
HandbookEvent.SkinBookDropListOpen = 4010
HandbookEvent.SkinPointChanged = 50001
HandbookEvent.OnClickTarotSkinSuit = 50002
HandbookEvent.OnExitTarotSkinSuit = 50003
HandbookEvent.OnClickFestivalSkinSuit = 50004
HandbookEvent.OnExitFestivalSkinSuit = 50005
HandbookEvent.OnExitToSuitGroup = 50006
HandbookEvent.OnClickFestivalSkinCard = 50007
HandbookEvent.MarkHandbookSkinSuitRedDot = 6001

return HandbookEvent
