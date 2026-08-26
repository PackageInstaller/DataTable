-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionGetView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionGetView", package.seeall)

local V1a6_CachotCollectionGetView = class("V1a6_CachotCollectionGetView", BaseView)

function V1a6_CachotCollectionGetView:onInitView()
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#simage_levelbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/Content/#go_lineitem/#go_collectionitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._golineitem = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/Content/#go_lineitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotCollectionGetView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V1a6_CachotCollectionGetView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function V1a6_CachotCollectionGetView:_btncloseOnClick()
	self:closeThis()
end

function V1a6_CachotCollectionGetView:_editableInitView()
	self._goScrollContent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/Content")
end

function V1a6_CachotCollectionGetView:onUpdateParam()
	return
end

function V1a6_CachotCollectionGetView:onOpen()
	local rougeRpcMsg = self.viewParam
	local collectionIdList = rougeRpcMsg and rougeRpcMsg.getColletions
	local lineMOList = self:buildLineMOList(collectionIdList)

	self:refreshPerLineCollectionList(lineMOList)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_collection_get)
end

local maxCollectionCountOneLine = 3

function V1a6_CachotCollectionGetView:buildLineMOList(collectionIdList)
	local lineMOList = {}

	if collectionIdList then
		local count = 0
		local lineMO = {}

		for _, collectionId in ipairs(collectionIdList) do
			if count >= maxCollectionCountOneLine then
				table.insert(lineMOList, lineMO)

				lineMO = {}
				count = 0
			end

			table.insert(lineMO, collectionId)

			count = count + 1
		end

		if lineMO and #lineMO > 0 then
			table.insert(lineMOList, lineMO)
		end
	end

	return lineMOList
end

function V1a6_CachotCollectionGetView:refreshPerLineCollectionList(lineCollectionMOList)
	gohelper.CreateObjList(self, self._onShowPerLineCollectionItem, lineCollectionMOList, self._goScrollContent, self._golineitem)
end

function V1a6_CachotCollectionGetView:_onShowPerLineCollectionItem(obj, lineCollectionMO, index)
	self:refreshGetCollectionList(lineCollectionMO, obj, self._gocollectionitem)
end

function V1a6_CachotCollectionGetView:refreshGetCollectionList(collectionMOList, parentObj, modelObj)
	gohelper.CreateObjList(self, self._onShowGetCollectionItem, collectionMOList, parentObj, modelObj)
end

function V1a6_CachotCollectionGetView:_onShowGetCollectionItem(obj, collectionCfgId, index)
	local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(collectionCfgId)

	if collectionCfg then
		local simageIcon = gohelper.findChildSingleImage(obj, "collection/#simage_collection")
		local txtName = gohelper.findChildText(obj, "collection/#txt_name")
		local goLayout = gohelper.findChild(obj, "layout")
		local goSkillDescItem = gohelper.findChild(obj, "layout/#go_descitem")

		simageIcon.curImageUrl = nil

		simageIcon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. collectionCfg.icon))

		txtName.text = collectionCfg.name

		V1a6_CachotCollectionHelper.refreshSkillDescWithoutEffectDesc(collectionCfg, goLayout, goSkillDescItem)
	end
end

function V1a6_CachotCollectionGetView:onClose()
	V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.GetCollecttions)
end

function V1a6_CachotCollectionGetView:onDestroyView()
	return
end

return V1a6_CachotCollectionGetView
