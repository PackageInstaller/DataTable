-- chunkname: @modules/logic/rouge/view/RougeFactionIllustrationView.lua

module("modules.logic.rouge.view.RougeFactionIllustrationView", package.seeall)

local RougeFactionIllustrationView = class("RougeFactionIllustrationView", BaseView)

function RougeFactionIllustrationView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "Middle/#scroll_view")
	self._goContent = gohelper.findChild(self.viewGO, "Middle/#scroll_view/Viewport/#go_Content")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFactionIllustrationView:addEvents()
	return
end

function RougeFactionIllustrationView:removeEvents()
	return
end

function RougeFactionIllustrationView:_editableInitView()
	return
end

function RougeFactionIllustrationView:onUpdateParam()
	return
end

function RougeFactionIllustrationView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open)

	local list = RougeOutsideModel.instance:getSeasonStyleInfoList()
	local path = self.viewContainer:getSetting().otherRes[1]

	for i, v in ipairs(list) do
		local itemGo = self:getResInst(path, self._goContent)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, RougeFactionIllustrationItem)

		item:onUpdateMO(v)
	end
end

function RougeFactionIllustrationView:onClose()
	if RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Faction) > 0 then
		local season = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(season, RougeEnum.FavoriteType.Faction, 0)
	end
end

function RougeFactionIllustrationView:onDestroyView()
	return
end

return RougeFactionIllustrationView
