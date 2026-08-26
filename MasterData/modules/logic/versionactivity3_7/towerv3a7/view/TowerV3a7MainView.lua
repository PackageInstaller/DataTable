-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/view/TowerV3a7MainView.lua

module("modules.logic.versionactivity3_7.towerv3a7.view.TowerV3a7MainView", package.seeall)

local TowerV3a7MainView = class("TowerV3a7MainView", BaseView)

function TowerV3a7MainView:onInitView()
	self._go1 = gohelper.findChild(self.viewGO, "Floor/#go_1")
	self._go2 = gohelper.findChild(self.viewGO, "Floor/#go_2")
	self._go3 = gohelper.findChild(self.viewGO, "Floor/#go_3")
	self._go4 = gohelper.findChild(self.viewGO, "Floor/#go_4")
	self._go5 = gohelper.findChild(self.viewGO, "Floor/#go_5")
	self._go6 = gohelper.findChild(self.viewGO, "Floor/#go_6")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Right/#txt_Title")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._txtTarget = gohelper.findChildText(self.viewGO, "Right/Title/#txt_Target")
	self._btnReview = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Review")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerV3a7MainView:addEvents()
	self._btnReview:AddClickListener(self._btnReviewOnClick, self)
end

function TowerV3a7MainView:removeEvents()
	self._btnReview:RemoveClickListener()
end

function TowerV3a7MainView:_btnReviewOnClick()
	TowerV3a7Controller.instance:openTowerV3a7MapViewFromMain(self._config)
end

function TowerV3a7MainView:_editableInitView()
	self._goList = self:getUserDataTb_()
	self._clickList = self:getUserDataTb_()

	for i = 1, 6 do
		local config = lua_tower_v3a7_map.configList[i]
		local showBtn = config ~= nil
		local go = self["_go" .. i]

		gohelper.setActive(go, showBtn)

		if showBtn then
			local click = SLFramework.UGUI.UIClickListener.Get(go)

			click:AddClickListener(self._onClickHandler, self, i)

			self._goList[i] = go
			self._clickList[i] = click
		end
	end
end

function TowerV3a7MainView:_onClickHandler(index)
	self:_setSelected(index)
	AudioMgr.instance:trigger(TowerV3a7Enum.Audio.Audio2)
end

function TowerV3a7MainView:_setSelected(index)
	for i, v in ipairs(self._goList) do
		local goUnSelected = gohelper.findChild(v, "go_UnSelected")
		local goSelected = gohelper.findChild(v, "go_Selected")
		local show = i == index

		gohelper.setActive(goSelected, show)
		gohelper.setActive(goUnSelected, not show)

		if show then
			self:_showTowerInfo(index)
		end
	end
end

function TowerV3a7MainView:_showTowerInfo(index)
	local config = lua_tower_v3a7_map.configList[index]

	self._txtTitle.text = config.title
	self._txtDescr.text = config.desc2
	self._txtTarget.text = config.desc3
	self._config = config
end

function TowerV3a7MainView:onUpdateParam()
	return
end

function TowerV3a7MainView:onOpen()
	self:_setSelected(1)
	AudioMgr.instance:trigger(TowerV3a7Enum.Audio.Audio1)
end

function TowerV3a7MainView:onClose()
	return
end

function TowerV3a7MainView:onDestroyView()
	for k, click in pairs(self._clickList) do
		click:RemoveClickListener()
	end
end

return TowerV3a7MainView
