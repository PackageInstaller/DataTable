-- chunkname: @modules/logic/survival/view/shelter/SurvivalMonsterEventSelectBuffItem.lua

module("modules.logic.survival.view.shelter.SurvivalMonsterEventSelectBuffItem", package.seeall)

local SurvivalMonsterEventSelectBuffItem = class("SurvivalMonsterEventSelectBuffItem", ListScrollCellExtend)

function SurvivalMonsterEventSelectBuffItem:onInitView()
	self._txtdec = gohelper.findChildText(self.viewGO, "#txt_dec")
	self._scrolltag = gohelper.findChildScrollRect(self.viewGO, "#scroll_tag")
	self._gotagitem = gohelper.findChild(self.viewGO, "#scroll_tag/viewport/content/#go_tagitem")
	self._imageType = gohelper.findChildImage(self.viewGO, "#scroll_tag/viewport/content/#go_tagitem/#image_Type")
	self._txtType = gohelper.findChildText(self.viewGO, "#scroll_tag/viewport/content/#go_tagitem/#txt_Type")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#scroll_tag/viewport/content/#go_tagitem/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalMonsterEventSelectBuffItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function SurvivalMonsterEventSelectBuffItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function SurvivalMonsterEventSelectBuffItem:_btnclickOnClick()
	return
end

function SurvivalMonsterEventSelectBuffItem:_editableInitView()
	gohelper.setActive(self._gotagitem, false)

	self._gounfinish = gohelper.findChild(self.viewGO, "go_unfinish")
	self._gofinished = gohelper.findChild(self.viewGO, "go_finished")
	self._ani = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function SurvivalMonsterEventSelectBuffItem:_editableAddEvents()
	return
end

function SurvivalMonsterEventSelectBuffItem:_editableRemoveEvents()
	return
end

function SurvivalMonsterEventSelectBuffItem:initItem(id)
	self._co = SurvivalConfig.instance:getShelterIntrudeSchemeConfig(id)

	if self._co == nil then
		logError("SurvivalMonsterEventBuffItem:initItem id is nil" .. id)
	end

	if self._co then
		self._txtdec.text = self._co.desc or ""
	end

	self:_initTagItem()
end

function SurvivalMonsterEventSelectBuffItem:updateItem()
	if self._co then
		local repress = SurvivalShelterMonsterModel.instance:calBuffIsRepress(self._co.id or nil)

		gohelper.setActive(self._gofinished, repress)

		if self._lastState == nil or self._lastState ~= repress then
			self:playAni(repress and "finished" or "open")
		end

		self._lastState = repress
	end
end

function SurvivalMonsterEventSelectBuffItem:_initTagItem()
	if self._tagItems == nil then
		self._tagItems = self:getUserDataTb_()

		if self._co then
			local tags = SurvivalConfig.instance:getMonsterBuffConfigTag(self._co.id or nil)

			for i = 1, #tags do
				local tag = tags[i]

				if tag then
					local config = lua_survival_tag.configDict[tag]
					local tagGo = gohelper.cloneInPlace(self._gotagitem, tag)

					if config then
						local image = gohelper.findChildImage(tagGo, "#image_Type")
						local color = SurvivalConst.ShelterTagColor[config.tagType]

						if color then
							image.color = GameUtil.parseColor(color)
						end

						local txt = gohelper.findChildText(tagGo, "#txt_Type")
						local button = gohelper.findButtonWithAudio(tagGo, "#btn_click")

						txt.text = config.name
					end

					gohelper.setActive(tagGo, true)
					table.insert(self._tagItems, tagGo)
				end
			end
		end
	end
end

function SurvivalMonsterEventSelectBuffItem:playAni(name)
	if name then
		self._ani:Play(name, 0, 0)
	end
end

function SurvivalMonsterEventSelectBuffItem:onDestroyView()
	return
end

return SurvivalMonsterEventSelectBuffItem
