-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameItem_Prop.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameItem_Prop", package.seeall)

local V3a4_Chg_GameItem_Prop = class("V3a4_Chg_GameItem_Prop", V3a4_Chg_GameItem_ObjBase)

function V3a4_Chg_GameItem_Prop:onInitView()
	self._txtNum = gohelper.findChildText(self.viewGO, "Image_NumBG/#txt_Num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_GameItem_Prop:addEvents()
	return
end

function V3a4_Chg_GameItem_Prop:removeEvents()
	return
end

function V3a4_Chg_GameItem_Prop:ctor(...)
	V3a4_Chg_GameItem_Prop.super.ctor(self, ...)
end

function V3a4_Chg_GameItem_Prop:_editableInitView()
	self._Image_Prop = gohelper.findChildImage(self.viewGO, "Image_Prop")
	self._Image_PropTrans = self._Image_Prop.transform
	self._Image_PropGo = self._Image_Prop.gameObject
	self._Image_Group = gohelper.findChild(self.viewGO, "Image_Group")
	self._Image_GroupTrans = self._Image_Group.transform
	self._Image_NumBG = gohelper.findChild(self.viewGO, "Image_NumBG")
	self._animation = self.viewGO:GetComponent(gohelper.Type_Animation)

	V3a4_Chg_GameItem_Prop.super._editableInitView(self)
end

function V3a4_Chg_GameItem_Prop:setNum(num)
	gohelper.setActive(self._Image_NumBG, num ~= 0)

	self._txtNum.text = num
end

local kScale = 0.9
local kInvokedHex = "#A69292"
local kWhiteHex = "#FFFFFF"

function V3a4_Chg_GameItem_Prop:setInvoked(bInvoked)
	self:setScale((bInvoked or nil) and (kScale or 1), self._Image_PropTrans)
	UIColorHelper.set(self._Image_Prop, (bInvoked or nil) and (kInvokedHex or kWhiteHex))
	self:_playIdleAnim(bInvoked)

	if bInvoked then
		AudioMgr.instance:trigger(AudioEnum3_4.Chg.play_ui_bulaochun_cheng_connect_end)
	end
end

function V3a4_Chg_GameItem_Prop:playIdleAnim(cb, cbObj)
	self:_playIdleAnim()

	if cb then
		cb(cbObj)
	end
end

function V3a4_Chg_GameItem_Prop:_playIdleAnim(bStop)
	local animClip = self._animation.clip
	local clipName = animClip.name

	if bStop then
		self._animation:Stop(clipName)
		self._animation:Play(clipName)
		self._animation:Sample()
		self._animation:Stop(clipName)
	else
		self._animation:Play(clipName)
	end
end

return V3a4_Chg_GameItem_Prop
