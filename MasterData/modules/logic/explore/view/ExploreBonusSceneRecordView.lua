-- chunkname: @modules/logic/explore/view/ExploreBonusSceneRecordView.lua

module("modules.logic.explore.view.ExploreBonusSceneRecordView", package.seeall)

local ExploreBonusSceneRecordView = class("ExploreBonusSceneRecordView", BaseView)

function ExploreBonusSceneRecordView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._item = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content/#go_chatitem")
	self._itemContent = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
end

function ExploreBonusSceneRecordView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function ExploreBonusSceneRecordView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function ExploreBonusSceneRecordView:onOpen()
	local chapterId = self.viewParam.chapterId
	local chapterBonusSceneDict = ExploreSimpleModel.instance:getChapterMo(chapterId).bonusScene
	local id, options = next(chapterBonusSceneDict)
	local cfgs = ExploreConfig.instance:getDialogueConfig(id)
	local showDatas = {}
	local icon

	for index, select in ipairs(options) do
		local co = cfgs[index]

		if co then
			local data = {
				desc = co.desc
			}

			if not string.nilorempty(co.bonusButton) then
				data.options = string.split(co.bonusButton, "|")
				data.index = select
			end

			table.insert(showDatas, data)

			if not string.nilorempty(co.picture) then
				icon = co.picture
			end
		end
	end

	if not string.nilorempty(icon) then
		self._simageicon:LoadImage(ResUrl.getExploreBg("file/" .. icon))
	end

	gohelper.CreateObjList(self, self.onCreateItem, showDatas, self._itemContent, self._item)
end

function ExploreBonusSceneRecordView:onCreateItem(obj, data, index)
	local info = gohelper.findChildTextMesh(obj, "info")
	local bg = gohelper.findChild(obj, "bg")

	gohelper.setActive(info, data.desc)
	gohelper.setActive(bg, data.options)

	if data.desc then
		info.text = data.desc
	end

	if data.options then
		for i = 1, 3 do
			local txt1 = gohelper.findChildTextMesh(bg, "txt" .. i)
			local play = gohelper.findChild(bg, "txt" .. i .. "/play")

			if data.options[i] then
				txt1.text = data.options[i]

				gohelper.setActive(play, data.index == i)
				SLFramework.UGUI.GuiHelper.SetColor(txt1, data.index == i and "#445D42" or "#3D3939")
			else
				gohelper.setActive(txt1, false)
			end
		end
	end
end

function ExploreBonusSceneRecordView:onClickModalMask()
	self:closeThis()
end

function ExploreBonusSceneRecordView:onClose()
	self._simageicon:UnLoadImage()
end

return ExploreBonusSceneRecordView
