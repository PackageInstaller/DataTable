-- chunkname: @modules/logic/rouge/view/RougeFavoriteView.lua

module("modules.logic.rouge.view.RougeFavoriteView", package.seeall)

local RougeFavoriteView = class("RougeFavoriteView", BaseView)

function RougeFavoriteView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._gorole4 = gohelper.findChild(self.viewGO, "#go_role4")
	self._gorole3 = gohelper.findChild(self.viewGO, "#go_role3")
	self._goluoleilai = gohelper.findChild(self.viewGO, "#go_luoleilai")
	self._gorole2 = gohelper.findChild(self.viewGO, "#go_role2")
	self._gorole1 = gohelper.findChild(self.viewGO, "#go_role1")
	self._gohailuo = gohelper.findChild(self.viewGO, "#go_hailuo")
	self._btnstory = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_story")
	self._gonewstory = gohelper.findChild(self.viewGO, "Left/#btn_story/#go_new_story")
	self._btnillustration = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_illustration")
	self._gonewillustration = gohelper.findChild(self.viewGO, "Left/#btn_illustration/#go_new_illustration")
	self._btnfaction = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_faction")
	self._gonewfaction = gohelper.findChild(self.viewGO, "Left/#btn_faction/#go_new_faction")
	self._btnresult = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_result")
	self._btncollection = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_collection")
	self._gonewcollection = gohelper.findChild(self.viewGO, "Left/#btn_collection/#go_new_collection")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFavoriteView:addEvents()
	self._btnstory:AddClickListener(self._btnstoryOnClick, self)
	self._btnillustration:AddClickListener(self._btnillustrationOnClick, self)
	self._btnfaction:AddClickListener(self._btnfactionOnClick, self)
	self._btnresult:AddClickListener(self._btnresultOnClick, self)
	self._btncollection:AddClickListener(self._btncollectionOnClick, self)
end

function RougeFavoriteView:removeEvents()
	self._btnstory:RemoveClickListener()
	self._btnillustration:RemoveClickListener()
	self._btnfaction:RemoveClickListener()
	self._btnresult:RemoveClickListener()
	self._btncollection:RemoveClickListener()
end

function RougeFavoriteView:_btnresultOnClick()
	RougeController.instance:openRougeResultReportView()
end

function RougeFavoriteView:_btncollectionOnClick()
	RougeController.instance:openRougeFavoriteCollectionView()
end

function RougeFavoriteView:_btnfactionOnClick()
	RougeController.instance:openRougeFactionIllustrationView()
end

function RougeFavoriteView:_btnillustrationOnClick()
	RougeController.instance:openRougeIllustrationListView()
end

function RougeFavoriteView:_btnstoryOnClick()
	RougeController.instance:openRougeReviewView()
end

function RougeFavoriteView:_editableInitView()
	self:_updateNewFlag()
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateFavoriteReddot, self._updateNewFlag, self)
end

function RougeFavoriteView:_updateNewFlag()
	gohelper.setActive(self._gonewstory, RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Story) > 0)
	gohelper.setActive(self._gonewillustration, RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Illustration) > 0)
	gohelper.setActive(self._gonewfaction, RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Faction) > 0)
	gohelper.setActive(self._gonewcollection, RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Collection) > 0)
end

function RougeFavoriteView:showEnding()
	local endingIds = RougeConfig1.instance:getConstValueByID(RougeEnum.Const.FavoriteEndingShow)
	local list = string.splitToNumber(endingIds, "#")
	local gameRecord = RougeOutsideModel.instance:getRougeGameRecord()

	gohelper.setActive(self._gohailuo, gameRecord.passEndIdMap[list[1]] ~= nil)
	gohelper.setActive(self._goluoleilai, gameRecord.passEndIdMap[list[2]] ~= nil)
end

function RougeFavoriteView:randomRoleShow()
	local roleIndex = math.random(1, 5)
	local go = self["_gorole" .. roleIndex]

	if go then
		gohelper.setActive(go, true)
	end
end

function RougeFavoriteView:onUpdateParam()
	return
end

function RougeFavoriteView:onOpen()
	self:randomRoleShow()
	self:showEnding()
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio1)
end

function RougeFavoriteView:onClose()
	return
end

function RougeFavoriteView:onDestroyView()
	return
end

return RougeFavoriteView
