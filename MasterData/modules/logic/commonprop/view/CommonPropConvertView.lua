-- chunkname: @modules/logic/commonprop/view/CommonPropConvertView.lua

module("modules.logic.commonprop.view.CommonPropConvertView", package.seeall)

local CommonPropConvertView = class("CommonPropConvertView", BaseView)

if BootNativeUtil.isWindows() then
	module_views.CommonPropConvertView.destroy = 1
end

function CommonPropConvertView:onInitView()
	self._bgClick = gohelper.getClick(self.viewGO)
	self._goeff = gohelper.findChild(self.viewGO, "#go_eff")
	self._goItemLeftRoot = gohelper.findChild(self.viewGO, "titlebg/go_item1")
	self._goItemRightRoot = gohelper.findChild(self.viewGO, "titlebg/go_item2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonPropConvertView:addEvents()
	self._bgClick:AddClickListener(self._onClickBG, self)
end

function CommonPropConvertView:removeEvents()
	self._bgClick:RemoveClickListener()
end

function CommonPropConvertView:_editableInitView()
	self._titleAni = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	local parentGO = gohelper.findChild(self.viewGO, "#go_video")

	self._videoPlayer = VideoPlayerMgr.instance:createGoAndVideoPlayer(parentGO)

	local prefabPath = self.viewContainer._viewSetting.otherRes[1]

	self._goItemLeft = self:getResInst(prefabPath, self._goItemLeftRoot)
	self._itemLeft = MonoHelper.addNoUpdateLuaComOnceToGo(self._goItemLeft, CommonPropListItem)
	self._goItemRight = self:getResInst(prefabPath, self._goItemRightRoot)
	self._itemRight = MonoHelper.addNoUpdateLuaComOnceToGo(self._goItemRight, CommonPropListItem)
end

function CommonPropConvertView:_onClickBG()
	if self._cantClose then
		return
	end

	self:closeThis()
end

function CommonPropConvertView:_checkParam()
	if not self.viewParam or not self.viewParam.convertMaterial then
		return
	end

	self._convertMaterialMo = self.viewParam.convertMaterial

	local itemConfig = ItemConfig.instance:getItemConfig(self._convertMaterialMo.materilType, self._convertMaterialMo.materilId)

	if not itemConfig then
		return
	end

	local afterConvertMo = {}
	local convertParam = string.splitToNumber(itemConfig.effect, "#")

	afterConvertMo.materilType = convertParam[1]
	afterConvertMo.materilId = convertParam[2]
	afterConvertMo.quantity = math.abs(convertParam[3] * self._convertMaterialMo.quantity)
	self._afterConvertMaterialMo = afterConvertMo
end

function CommonPropConvertView:onOpen()
	self:_checkParam()
	self._titleAni:Play()

	CommonPropListItem.hasOpen = false

	self:_setConvertItems()
	NavigateMgr.instance:addEscape(ViewName.CommonPropConvertView, self._onClickBG, self)

	self._cantClose = true
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, nil, nil, nil, nil, EaseType.Linear)

	TaskDispatcher.runDelay(self._setCanClose, self, 0.8)

	if self:checkHadHighRareProp(self._convertMaterialMo) or self:checkHadHighRareProp(self._afterConvertMaterialMo) then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	end

	self._videoPlayer:play("commonprop", true, nil, nil)
end

function CommonPropConvertView:checkHadHighRareProp(item)
	if tonumber(item.materilType) == MaterialEnum.MaterialType.PlayerCloth then
		return true
	end

	local config = ItemModel.instance:getItemConfig(tonumber(item.materilType), tonumber(item.materilId))

	if not config or not config.rare then
		logWarn(string.format("type : %s, id : %s; getConfig error", item.materilType, item.materilId))
	elseif config.rare >= CommonPropListModel.HighRare then
		return true
	end
end

function CommonPropConvertView:_setCanClose()
	self._cantClose = false
end

function CommonPropConvertView:onClose()
	if BootNativeUtil.isWindows() then
		self._videoPlayer:stop()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false

	if self._videoPlayer and not BootNativeUtil.isIOS() then
		self._videoPlayer:stop()
	end
end

function CommonPropConvertView:onClickModalMask()
	self:closeThis()
end

function CommonPropConvertView:_setConvertItems()
	self._itemLeft._index = 1

	self._itemLeft:onUpdateMO(self._convertMaterialMo)

	self._itemRight._index = 1

	self._itemRight:onUpdateMO(self._afterConvertMaterialMo)
end

function CommonPropConvertView:onDestroyView()
	if BootNativeUtil.isWindows() then
		self._videoPlayer = nil
		self._displauUGUI = nil
	end

	if self._videoPlayer then
		self._videoPlayer = nil
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	TaskDispatcher.cancelTask(self._setCanClose, self)
end

return CommonPropConvertView
