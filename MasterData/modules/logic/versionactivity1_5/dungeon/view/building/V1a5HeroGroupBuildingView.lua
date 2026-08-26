-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/building/V1a5HeroGroupBuildingView.lua

module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5HeroGroupBuildingView", package.seeall)

local V1a5HeroGroupBuildingView = class("V1a5HeroGroupBuildingView", BaseView)

function V1a5HeroGroupBuildingView:onInitView()
	self._gototem = gohelper.findChild(self.viewGO, "#go_totem")
end

function V1a5HeroGroupBuildingView:addEvents()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.SwitchReplay, self.switchReplay, self)
end

function V1a5HeroGroupBuildingView:removeEvents()
	return
end

V1a5HeroGroupBuildingView.PrefabPath = "ui/viewres/herogroup/herogroupviewtotem.prefab"

function V1a5HeroGroupBuildingView:onOpen()
	local fightParam = FightModel.instance:getFightParam()
	local chapterId = fightParam.chapterId
	local isV1a5Dungeon = false

	if chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.Story1 or chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.Story2 or chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.Story3 or chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.Story4 or chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.ElementFight then
		if not DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId) then
			return
		end

		isV1a5Dungeon = true
	end

	if not isV1a5Dungeon then
		return
	end

	self.loader = PrefabInstantiate.Create(self._gototem)

	self.loader:startLoad(V1a5HeroGroupBuildingView.PrefabPath, self.onLoadFinish, self)
	VersionActivity1_5DungeonRpc.instance:sendGet140InfosRequest(self.onReceiveMsg, self)
end

function V1a5HeroGroupBuildingView:onLoadFinish()
	self.loadFinishDone = true
	self.go = self.loader:getInstGO()
	self.goPointContainer = gohelper.findChild(self.go, "#go_totem/totem/point_container/")
	self.pointItemList = self:getUserDataTb_()

	table.insert(self.pointItemList, self:createPointItem(gohelper.findChild(self.go, "#go_totem/totem/point_container/#go_pointitem1")))
	table.insert(self.pointItemList, self:createPointItem(gohelper.findChild(self.go, "#go_totem/totem/point_container/#go_pointitem2")))
	table.insert(self.pointItemList, self:createPointItem(gohelper.findChild(self.go, "#go_totem/totem/point_container/#go_pointitem3")))

	self._singleBg = gohelper.findChildSingleImage(self.go, "#go_totem/totem/bg")
	self._btnclick = gohelper.findChildClickWithDefaultAudio(self.go, "#go_totem/#btn_click")

	self._btnclick:AddClickListener(self._btnClickOnClick, self)
	self:refreshPoint()
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, self.onUpdateSelectBuild, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

function V1a5HeroGroupBuildingView:createPointItem(pointGo)
	local pointItem = self:getUserDataTb_()

	pointItem.image = pointGo:GetComponent(gohelper.Type_Image)
	pointItem.effectGo1 = gohelper.findChild(pointGo, "#effect_green")
	pointItem.effectGo2 = gohelper.findChild(pointGo, "#effect_yellow")

	return pointItem
end

function V1a5HeroGroupBuildingView:onReceiveMsg()
	self.receiveMsgDone = true

	self:refreshPoint()
end

function V1a5HeroGroupBuildingView:refreshPoint()
	if not self.receiveMsgDone then
		return
	end

	if not self.loadFinishDone then
		return
	end

	gohelper.setActive(self._gototem, true)
	gohelper.setActive(self.goPointContainer, not self.isReplay)

	if not self.isReplay then
		for i = 1, VersionActivity1_5DungeonEnum.BuildCount do
			local type = VersionActivity1_5BuildModel.instance:getSelectType(i)

			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(self.pointItemList[i].image, VersionActivity1_5DungeonEnum.BuildType2SmallImage[type])
		end
	end
end

function V1a5HeroGroupBuildingView:switchReplay(isReplay)
	self.isReplay = isReplay

	self:refreshPoint()
end

function V1a5HeroGroupBuildingView:_btnClickOnClick()
	if self.isReplay then
		return
	end

	for _, pointItem in ipairs(self.pointItemList) do
		gohelper.setActive(pointItem.effectGo1, false)
		gohelper.setActive(pointItem.effectGo2, false)
	end

	self.preSelectTypeList = tabletool.copy(VersionActivity1_5BuildModel.instance:getSelectTypeList())

	ViewMgr.instance:openView(ViewName.V1a5BuildingSkillView)
end

function V1a5HeroGroupBuildingView:playPointChangeAnim()
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if not self.preSelectTypeList then
		return
	end

	local currentSelectTypeList = VersionActivity1_5BuildModel.instance:getSelectTypeList()

	for groupIndex, type in ipairs(currentSelectTypeList) do
		if type ~= self.preSelectTypeList[groupIndex] then
			local pointItem = self.pointItemList[groupIndex]

			if type == VersionActivity1_5DungeonEnum.BuildType.First then
				gohelper.setActive(pointItem.effectGo1, true)
			else
				gohelper.setActive(pointItem.effectGo2, true)
			end
		end
	end

	self.preSelectTypeList = nil
end

function V1a5HeroGroupBuildingView:onCloseViewFinish()
	self:playPointChangeAnim()
end

function V1a5HeroGroupBuildingView:onUpdateSelectBuild()
	self:refreshPoint()
	self:playPointChangeAnim()
end

function V1a5HeroGroupBuildingView:onDestroyView()
	if self._btnclick then
		self._btnclick:RemoveClickListener()
	end

	if self._singleBg then
		self._singleBg:UnLoadImage()
	end

	if self.loader then
		self.loader:dispose()
	end
end

return V1a5HeroGroupBuildingView
