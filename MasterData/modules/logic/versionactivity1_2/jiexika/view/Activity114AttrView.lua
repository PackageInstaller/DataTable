-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114AttrView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114AttrView", package.seeall)

local Activity114AttrView = class("Activity114AttrView", BaseView)

function Activity114AttrView:ctor(path)
	self._path = path
end

function Activity114AttrView:onInitView()
	self.go = gohelper.findChild(self.viewGO, self._path)
	self._goattrdetail = gohelper.findChild(self.go, "#go_attrdetail")
	self._goempty = gohelper.findChild(self.go, "#go_attrdetail/#go_empty")
	self._scroll = gohelper.findChildScrollRect(self.go, "#go_attrdetail/#scroll")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._btnCloseTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tips/#btn_closeTips")
	self._gofeaturecontent = gohelper.findChild(self.viewGO, "#go_tips/bg/#scroll_feature/Viewport/content")
	self._gofeatureitem = gohelper.findChild(self.viewGO, "#go_tips/bg/#scroll_feature/Viewport/content/#go_featureitem")
	self._radar = gohelper.findChild(self.viewGO, "#go_eduSelect/teachAttr/radarChart"):GetComponent(typeof(RadarChart))
	self._btnspecialattrtips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_attr/#go_attrdetail/specialattrtitle/#btn_specialattrtips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114AttrView:addEvents()
	self._btnCloseTips:AddClickListener(self.closeTips, self)
	self._btnspecialattrtips:AddClickListener(self.showFeaturesTips, self)
	self.viewContainer:registerCallback(Activity114Event.EduSelectAttrChange, self.onAttrSelectChange, self)
	Activity114Controller.instance:registerCallback(Activity114Event.OnAttrUpdate, self.updateAttr, self)
	Activity114Controller.instance:registerCallback(Activity114Event.ShowFeaturesTips, self.showFeaturesTips, self)
	Activity114Controller.instance:registerCallback(Activity114Event.OnNewFeature, self.updateFeature, self)
end

function Activity114AttrView:removeEvents()
	self._btnCloseTips:RemoveClickListener()
	self._btnspecialattrtips:RemoveClickListener()
	self.viewContainer:unregisterCallback(Activity114Event.EduSelectAttrChange, self.onAttrSelectChange, self)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnAttrUpdate, self.updateAttr, self)
	Activity114Controller.instance:unregisterCallback(Activity114Event.ShowFeaturesTips, self.showFeaturesTips, self)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnNewFeature, self.updateFeature, self)
end

function Activity114AttrView:_editableInitView()
	self.attrTb = {}

	for i = 1, Activity114Enum.Attr.End - 1 do
		local attrCom = self:getUserDataTb_()
		local attrName = Activity114Config.instance:getAttrName(Activity114Model.instance.id, i)
		local attrId = Activity114Config.instance:getAttrCo(Activity114Model.instance.id, i).attribute

		attrCom.bg = gohelper.findChild(self.go, "#go_attrdetail/attr/#go_attr" .. i .. "/bg")
		attrCom.imageIcon = gohelper.findChildImage(self.go, "#go_attrdetail/attr/#go_attr" .. i .. "/image_icon")
		attrCom.txtValue = gohelper.findChildTextMesh(self.go, "#go_attrdetail/attr/#go_attr" .. i .. "/#txt_attr/#txt_value")
		attrCom.goAddValue = gohelper.findChild(self.go, "#go_attrdetail/attr/#go_attr" .. i .. "/#txt_attr/#txt_value/#go_addvalue")
		attrCom.txtAddValue = gohelper.findChildTextMesh(self.go, "#go_attrdetail/attr/#go_attr" .. i .. "/#txt_attr/#txt_value/#go_addvalue/#txt_addvalue")
		attrCom.gouplevel = gohelper.findChild(self.go, "#go_attrdetail/attr/#go_attr" .. i .. "/#txt_attr/#txt_value/#go_uplevel")
		attrCom.txtLv = gohelper.findChildTextMesh(self.go, "#go_attrdetail/attr/#go_attr" .. i .. "/#txt_attr/#txt_lv")
		attrCom.glowAnim = gohelper.findChildComponent(self.go, "#go_attrdetail/attr/#go_attr" .. i, typeof(UnityEngine.Animator))
		gohelper.findChildTextMesh(self.go, "#go_attrdetail/attr/#go_attr" .. i .. "/#txt_attr").text = attrName

		UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(attrCom.imageIcon, "icons_" .. attrId)
		gohelper.setActive(attrCom.bg, i % 2 == 0)

		attrCom.txtAddValue.text = ""

		gohelper.setActive(attrCom.goAddValue, false)
		gohelper.setActive(attrCom.gouplevel, false)

		self.attrTb[i] = attrCom
	end

	self._status = 0

	gohelper.setActive(gohelper.findChild(self.viewGO, "#go_attrdetail/#scroll/item"), false)

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_attr/#go_attrdetail/#scroll"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_attr/#go_attrdetail/#scroll/item"
	scrollParam.cellClass = Activity114FeaturesItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 276
	scrollParam.cellHeight = 48
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 20.73
	scrollParam.startSpace = 0
	scrollParam.frameUpdateMs = 100
	self._scrollView = LuaListScrollView.New(Activity114FeaturesModel.instance, scrollParam)

	self:addChildView(self._scrollView)
	self:updateFeature()
	self:closeTips()
end

function Activity114AttrView:updateFeature()
	gohelper.setActive(self._goempty, #Activity114FeaturesModel.instance:getList() == 0)
end

function Activity114AttrView:closeTips()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_close)
	gohelper.setActive(self._gotips, false)
end

function Activity114AttrView:onOpen()
	self:updateAttr()
end

function Activity114AttrView:showFeaturesTips()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	gohelper.setActive(self._gotips, true)
	gohelper.CreateObjList(self, self.setFeatureItem, Activity114FeaturesModel.instance:getList(), self._gofeaturecontent, self._gofeatureitem)
end

function Activity114AttrView:setFeatureItem(obj, data)
	local icon = gohelper.findChildImage(obj, "title/#icon_feature")
	local name = gohelper.findChildTextMesh(obj, "title/#txt_name")
	local desc = gohelper.findChildTextMesh(obj, "#txt_des")
	local goinherit = gohelper.findChild(obj, "title/#go_inherit")

	name.text = data.features
	desc.text = data.desc

	gohelper.setActive(goinherit, data.inheritable == 1)
	UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(icon, data.inheritable == 1 and "img_shuxing1" or "img_shuxing2")
end

function Activity114AttrView:onAttrSelectChange()
	local select = Activity114Model.instance.eduSelectAttr

	for i = 1, Activity114Enum.Attr.End - 1 do
		local comp = self.attrTb[i]

		if select == i then
			local eduEventCo = Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, select)

			if eduEventCo then
				if not eduEventCo.successVerify[select] then
					local addAttr = 0

					if Activity114Model.instance.attrAddPermillage[select] then
						addAttr = Mathf.Round(addAttr * (1 + Activity114Model.instance.attrAddPermillage[select]))
					end

					if not Activity114Model.instance.attrDict[i] then
						local nowAttr = 0
						local maxAttr = Activity114Config.instance:getAttrMaxValue(Activity114Model.instance.id, i)

						addAttr = math.min(addAttr, maxAttr - nowAttr)
						comp.txtAddValue.text = "+" .. addAttr

						local nowLv = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, i, nowAttr)
						local addLv = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, i, nowAttr + addAttr)

						gohelper.setActive(comp.gouplevel, nowLv ~= addLv)
					end
				end
			end
		else
			gohelper.setActive(comp.gouplevel, false)

			comp.txtAddValue.text = ""
		end

		gohelper.setActive(comp.goAddValue, not string.nilorempty(comp.txtAddValue.text))
	end
end

function Activity114AttrView:updateAttr()
	if Activity114Model.instance.attrChangeDict then
		for i = 1, Activity114Enum.Attr.End - 1 do
			if Activity114Model.instance.attrChangeDict[i] then
				self.attrTb[i].glowAnim:Play(UIAnimationName.Open, 0, 0)
			end
		end

		Activity114Model.instance.attrChangeDict = nil
	end

	local rates = {}

	for i = 1, Activity114Enum.Attr.End - 1 do
		if not Activity114Model.instance.attrDict[i] then
			local value = 0

			self.attrTb[i].txtValue.text = value
			self.attrTb[i].txtLv.text = "Lv." .. Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, i, value)
			rates[i] = Activity114Model.instance.attrDict[i] / Activity114Config.instance:getAttrMaxValue(Activity114Model.instance.id, i)
		end
	end

	local eduSelectAttr = Activity114Model.instance.eduSelectAttr

	if eduSelectAttr then
		local eduEventCo = Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, eduSelectAttr)

		if eduEventCo then
			if not eduEventCo.successVerify[eduSelectAttr] then
				local addAttr = 0

				if Activity114Model.instance.attrAddPermillage[eduSelectAttr] then
					addAttr = Mathf.Round(addAttr * (1 + Activity114Model.instance.attrAddPermillage[eduSelectAttr]))
				end

				if not Activity114Model.instance.attrDict[eduSelectAttr] then
					local nowAttr = 0
					local comp = self.attrTb[eduSelectAttr]
					local nowLv = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, eduSelectAttr, nowAttr)
					local addLv = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, eduSelectAttr, nowAttr + addAttr)

					gohelper.setActive(comp.gouplevel, nowLv ~= addLv)
				end
			end
		end
	end

	self._radar:setRate(rates[1], rates[5], rates[4], rates[3], rates[2])
end

return Activity114AttrView
