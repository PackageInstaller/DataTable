-- chunkname: @modules/logic/seasonver/act166/view/Season166HeroGroupTargetView.lua

module("modules.logic.seasonver.act166.view.Season166HeroGroupTargetView", package.seeall)

local Season166HeroGroupTargetView = class("Season166HeroGroupTargetView", BaseView)

function Season166HeroGroupTargetView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gotargetScoreContent = gohelper.findChild(self.viewGO, "bg/targetScore/#go_targetScoreContent")
	self._gotargetItem = gohelper.findChild(self.viewGO, "bg/targetScore/#go_targetScoreContent/#go_targetItem")
	self._gotargetContent = gohelper.findChild(self.viewGO, "bg/#go_targetContent")
	self._godescItem = gohelper.findChild(self.viewGO, "bg/#go_targetContent/#go_descItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166HeroGroupTargetView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season166HeroGroupTargetView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Season166HeroGroupTargetView:_btncloseOnClick()
	self:closeThis()
end

function Season166HeroGroupTargetView:_editableInitView()
	return
end

function Season166HeroGroupTargetView:onUpdateParam()
	return
end

function Season166HeroGroupTargetView:onOpen()
	self.actId = self.viewParam.actId
	self.baseId = self.viewParam.baseId

	self:createScoreItem()
	self:createTargetDescItem()
end

function Season166HeroGroupTargetView:createScoreItem()
	local scoreConfigList = {}

	for level = 1, 3 do
		local scoreCo = Season166Config.instance:getSeasonScoreCo(self.actId, level)

		table.insert(scoreConfigList, scoreCo)
	end

	gohelper.CreateObjList(self, self.scoreItemShow, scoreConfigList, self._gotargetScoreContent, self._gotargetItem)
end

function Season166HeroGroupTargetView:scoreItemShow(obj, data, index)
	local txtTarget = gohelper.findChildText(obj, "txt_target")
	local goStarIcon = gohelper.findChild(obj, "go_star/go_starIcon")

	gohelper.setActive(goStarIcon, false)

	txtTarget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season166_targetscore"), {
		data.needScore
	})

	local starNum = data.star

	for i = 1, starNum do
		local starIcon = gohelper.cloneInPlace(goStarIcon)

		gohelper.setActive(starIcon, true)
	end
end

function Season166HeroGroupTargetView:createTargetDescItem()
	local targetList = Season166Config.instance:getSeasonBaseTargetCos(self.actId, self.baseId)

	gohelper.CreateObjList(self, self.targetDescItemShow, targetList, self._gotargetContent, self._godescItem)
end

function Season166HeroGroupTargetView:targetDescItemShow(obj, data, index)
	local txtDesc = gohelper.findChildText(obj, "txt_desc")

	txtDesc.text = data.targetDesc
end

function Season166HeroGroupTargetView:onClose()
	Season166HeroGroupController.instance:dispatchEvent(Season166Event.CloseHeroGroupTargetView)
end

function Season166HeroGroupTargetView:onDestroyView()
	return
end

return Season166HeroGroupTargetView
