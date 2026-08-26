-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinMapView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinMapView", package.seeall)

local AssassinMapView = class("AssassinMapView", BaseViewExtended)

function AssassinMapView:onInitView()
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_task", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._gotaskreddot = gohelper.findChild(self.viewGO, "root/#btn_task/#go_taskreddot")
	self._btndevelop = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_develop", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._btnlibrary = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_library", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._golibraryreddot = gohelper.findChild(self.viewGO, "root/#btn_library/#go_libraryreddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinMapView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btndevelop:AddClickListener(self._btndevelopOnClick, self)
	self._btnlibrary:AddClickListener(self._btnlibraryOnClick, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UpdateLibraryReddot, self.initLibraryRedDot, self)
end

function AssassinMapView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btndevelop:RemoveClickListener()
	self._btnlibrary:RemoveClickListener()
end

function AssassinMapView:_btntaskOnClick()
	AssassinController.instance:openAssassinTaskView()
end

function AssassinMapView:_btndevelopOnClick()
	AssassinController.instance:openAssassinHeroView()
end

function AssassinMapView:_btnlibraryOnClick()
	AssassinController.instance:openAssassinLibraryView()
end

function AssassinMapView:_editableInitView()
	self:initHomeEntrance()
	self:initMapEntrances()
	self:initLibraryRedDot()
	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.AssassinOutsideTask)
end

function AssassinMapView:initHomeEntrance()
	local goHomeEntrance = gohelper.findChild(self.viewGO, "root/#go_home")

	self:openSubView(AssassinBuildingMapEntrance, goHomeEntrance, self.viewGO)
end

function AssassinMapView:initMapEntrances()
	local mapIdList = AssassinConfig.instance:getMapIdList()

	for _, mapId in ipairs(mapIdList) do
		local goMapEntrance = gohelper.findChild(self.viewGO, "root/#go_maps/#go_pos" .. mapId)

		if gohelper.isNil(goMapEntrance) then
			logError(string.format("AssassinMapView:initMapEntrances error, go not enough mapId：%s", mapId))
		else
			self:openSubView(AssassinQuestMapEntrance, goMapEntrance, self.viewGO, mapId)
		end
	end
end

function AssassinMapView:initLibraryRedDot()
	self._libraryRedDot = RedDotController.instance:addNotEventRedDot(self._golibraryreddot, self._libraryRedDotCheckFunc, self, AssassinEnum.LibraryReddotStyle)

	self._libraryRedDot:refreshRedDot()
end

function AssassinMapView:_libraryRedDotCheckFunc()
	return AssassinLibraryModel.instance:isAnyLibraryNewUnlock()
end

function AssassinMapView:onOpen()
	return
end

function AssassinMapView:onClose()
	return
end

function AssassinMapView:onDestroyView()
	return
end

return AssassinMapView
