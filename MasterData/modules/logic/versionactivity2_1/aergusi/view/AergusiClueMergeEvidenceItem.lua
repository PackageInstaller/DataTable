-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiClueMergeEvidenceItem.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueMergeEvidenceItem", package.seeall)

local AergusiClueMergeEvidenceItem = class("AergusiClueMergeEvidenceItem", LuaCompBase)

function AergusiClueMergeEvidenceItem:init(go, index)
	self.go = go
	self._index = index
	self._goselect = gohelper.findChild(go, "select")
	self._simageclue = gohelper.findChildSingleImage(go, "select/simage_clue")
	self._txtcluename = gohelper.findChildText(go, "select/name")
	self._goempty = gohelper.findChild(go, "empty")
	self._goselectframe = gohelper.findChild(go, "empty/selectframe")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "clickarea")

	self:_addEvents()
	gohelper.setActive(self._goempty, true)
	self:refreshItem()
end

function AergusiClueMergeEvidenceItem:refreshItem()
	local state = AergusiModel.instance:getMergeClueState().pos[self._index]

	gohelper.setActive(self._goselectframe, state and state.selected)
	gohelper.setActive(self._goselect, state and state.clueId > 0)

	if state and state.clueId > 0 then
		local clueConfig = AergusiConfig.instance:getClueConfig(state.clueId)

		self._simageclue:LoadImage(ResUrl.getV2a1AergusiSingleBg(clueConfig.clueIcon))

		self._txtcluename.text = clueConfig.clueName
	else
		self._txtcluename.text = ""

		self._simageclue:UnLoadImage()
	end
end

function AergusiClueMergeEvidenceItem:_addEvents()
	self._btnclick:AddClickListener(self._btnClueOnClick, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeItem, self.refreshItem, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeSelect, self.refreshItem, self)
end

function AergusiClueMergeEvidenceItem:_removeEvents()
	self._btnclick:RemoveClickListener()
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeItem, self.refreshItem, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeSelect, self.refreshItem, self)
end

function AergusiClueMergeEvidenceItem:_btnClueOnClick()
	local selected = AergusiModel.instance:getClueMergePosSelectState(self._index)

	if not selected then
		AergusiModel.instance:setClueMergePosSelect(self._index, true)
	else
		AergusiModel.instance:setClueMergePosClueId(self._index, 0)
		self:refreshItem()
	end

	AergusiController.instance:dispatchEvent(AergusiEvent.OnClickClueMergeItem)
end

function AergusiClueMergeEvidenceItem:destroy()
	self._simageclue:UnLoadImage()
	self:_removeEvents()
end

return AergusiClueMergeEvidenceItem
