-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionDialog.lua

module("logic.extensions.story.core.logic.sections.SectionDialog", package.seeall)

local M = class("SectionDialog", StorySectionBase)

function M.CreateSectionItemStruct()
	local st = {}

	st.hasNextTips = false
	st.roleName = nil
	st.headResId = nil
	st.headPtrUID = nil
	st.headAssetUID = nil
	st.head3DGo = nil
	st.content = nil
	st.dialogType = nil
	st.headType = nil
	st.roleUid = nil

	return st
end

M.maxPrintCount = 99999999

function M.SetHead3D(ptrUID, proxyInst, assetUID, binder)
	M.DisposeHead3D()

	M.binder = binder
	M.ptrUID = ptrUID
	M.proxyInst = proxyInst
	M.assetUID = assetUID

	M.binder:AddProxyPtr(ptrUID, proxyInst, StoryPtrTag.ModelInstance, nil, nil)
end

function M.DisposeHead3D()
	if M.proxyInst then
		goutil.destroy(M.proxyInst.proxyTarget)
	end

	if M.binder then
		M.binder:RemovePtr(M.ptrUID)
	end

	M.binder = nil
	M.ptrUID = nil
	M.proxyInst = nil
	M.assetUID = nil
end

function M:_OnInitCtor()
	self.m_dialogData = nil
	self.contentCount = M.maxPrintCount
	self.m_head3DUID = nil
	self.m_head3DAssetUID = nil
	self.m_head3DProxy = nil
	self.m_hideDialogUI = false
end

function M:OnStoryEnterInternal()
	self.m_dialogData = M.CreateSectionItemStruct()
	self.contentCount = M.maxPrintCount
end

function M:OnStoryExitInternal()
	if self.m_hideDialogUI then
		StoryDispatcher:dispatchEvent(StoryNotifyName.UIDialogVisibleSwitch, false)
	end

	self:ReleaseData()
end

function M:OnStoryDestroyInternal()
	M.DisposeHead3D()
end

function M:ReleaseData()
	self:DisposeHead3DProxy()

	self.m_dialogData = nil
	self.m_head3DUID = nil
	self.m_head3DAssetUID = nil
	self.m_head3DProxy = nil
	self.m_hideDialogUI = false
end

function M:OnSectionEnableInternal()
	self:InitParams()

	if self.m_dialogData then
		local historyData = StoryModel.instance:getHistoryByIndex(self.parent.parent.shotId)

		historyData = historyData or {}

		if self.m_dialogData.roleName == "{username}" then
			local nameTxt = string.gsub(self.m_dialogData.roleName, "{username}", PlayerModel.instance:getNickName())

			historyData.name = nameTxt
		else
			historyData.name = self.m_dialogData.roleName
		end

		historyData.index = self.parent.parent.shotId
		historyData.type = self.m_dialogData.dialogType

		local isExtra = self.m_dialogData.dialogType == StoryConstDef.EStoryDialogUIStyleType.Extra

		if not isExtra then
			local isFilm = self.m_dialogData.dialogType == StoryConstDef.EStoryDialogUIStyleType.Film

			if isFilm then
				historyData.content = self.m_dialogData.copyContent
			else
				historyData.content = self.m_dialogData.content
			end

			historyData.isNarration = self.m_dialogData.dialogType == StoryConstDef.EStoryDialogUIStyleType.Narrator

			if not string.nilorempty(historyData.content) then
				StoryModel.instance:addHistory(historyData)
			end
		end
	end

	StoryDispatcher:dispatchEvent(StoryNotifyName.UIDialogEnter, self.m_dialogData)
end

function M:OnSectionDisableInternal()
	self:DisposeHead3DProxy()
	StoryDispatcher:dispatchEvent(StoryNotifyName.UIDialogExit, self.m_dialogData)
end

function M:OnStoryEvaluateInternal(time)
	local progress = self:GetProgress(time)

	StoryDispatcher:dispatchEvent(StoryNotifyName.UIDialogPrint, progress, self.contentCount, self.m_dialogData.dialogType)
end

function M:DisposeHead3DProxy()
	self.m_head3DProxy = nil
end

function M:InitParams()
	M.DisposeHead3D()

	self.m_head3DUID = nil
	self.m_hideDialogUI = self.config:GetArgValueBoolean(StoryArgKeyConst.DialogHideUI)
	self.m_dialogData.changeBgAlpha = self.config:GetArgValueBoolean(StoryArgKeyConst.ChangeBgAlpha)
	self.m_dialogData.hasNextTips = self.parent.parent:IsEnd() == false
	self.m_dialogData.dialogType = self.config:GetArgValueEnum(StoryArgKeyConst.DialogType)

	local tempName = self.config:GetArgValue(StoryArgKeyConst.RoleName) or ""

	if StoryController.instance:isPlayerName(tempName) then
		tempName = StoryController.instance:parsePlayerName(tempName, self.m_dialogData.dialogType)
	elseif self.m_dialogData.dialogType == StoryConstDef.EStoryDialogUIStyleType.Film and not string.nilorempty(tempName) then
		tempName = string.format("<color=#%s>%s</color>", "5eb4d3", tempName)
	end

	self.m_dialogData.roleName = tempName
	self.m_dialogData.roleUid = self.config:GetArgValue(StoryArgKeyConst.DialogSpeakRole)
	self.m_dialogData.headType = self.config:GetArgValueEnum(StoryArgKeyConst.DialogHeadType)

	if self.m_dialogData.headType == StoryConstDef.EStoryDialogHeadStyleType.CommuRT or self.m_dialogData.headType == StoryConstDef.EStoryDialogHeadStyleType.ModelRT then
		local headPtr = self.config:GetArg(StoryArgKeyConst.Dialog3DHead)

		if headPtr then
			self.m_head3DUID = tostring(headPtr.GUID)
			self.m_head3DAssetUID = self.config:GetArgValue(StoryArgKeyConst.Dialog3DHead)
		end

		local modelAsset = self.parent.binder:GetBindObject(self.m_head3DAssetUID)

		if modelAsset then
			local headGo = StoryGameObjectPool.Get(self.m_head3DAssetUID, modelAsset)

			self.m_head3DProxy = StoryEngine.StoryGameObjectInstProxy.CreateProxyInstAndSetParent(headGo)
			self.m_head3DProxy.gameObject.name = self.m_head3DUID

			M.SetHead3D(self.m_head3DUID, self.m_head3DProxy, self.m_head3DAssetUID, self.parent.binder)

			self.m_dialogData.head3DGo = self.m_head3DProxy.gameObject
			self.m_dialogData.headPtrUID = self.m_head3DUID
			self.m_dialogData.headAssetUID = self.m_head3DAssetUID

			print("dialog head3d", self.m_head3DAssetUID, self.m_dialogData.head3DGo.transform.localPosition)
		else
			print("not exit dialog head3d=================", self.m_dialogData.headType, self.m_head3DAssetUID)
		end
	elseif self.m_dialogData.headType == StoryConstDef.EStoryDialogHeadStyleType.Normal then
		self.m_dialogData.headResId = self.config:GetArgValue(StoryArgKeyConst.DialogHeadResId)
	end

	self.m_dialogData.alignType = self.config:GetArgValueEnum(StoryArgKeyConst.DialogAlignType)
	self.m_dialogData.fontSize = self.config:GetArgValueNumber(StoryArgKeyConst.DialogFontSize)
	self.m_dialogData.storyBlackType = self.config:GetArgValueEnum(StoryArgKeyConst.DialogBlackType)

	local dialogType = self.m_dialogData.dialogType

	if dialogType == StoryConstDef.EStoryDialogUIStyleType.Intro then
		self.m_dialogData.content = StoryUtils.parseStoryText(self.config:GetArgValue(StoryArgKeyConst.RoleInfoName))
		self.m_dialogData.content2 = StoryUtils.parseStoryText(self.config:GetArgValue(StoryArgKeyConst.RoleInfoDesc))
	elseif dialogType == StoryConstDef.EStoryDialogUIStyleType.Extra then
		self.m_dialogData.content = StoryUtils.parseStoryText(self.config:GetArgValue(StoryArgKeyConst.Complex_ExtraInfo1))
		self.m_dialogData.content2 = StoryUtils.parseStoryText(self.config:GetArgValue(StoryArgKeyConst.Complex_ExtraInfo2))
		self.m_dialogData.content3 = StoryUtils.parseStoryText(self.config:GetArgValue(StoryArgKeyConst.Complex_ExtraInfo3))
		self.m_dialogData.content4 = StoryUtils.parseStoryText(self.config:GetArgValue(StoryArgKeyConst.Complex_ExtraInfo4))
	elseif dialogType == StoryConstDef.EStoryDialogUIStyleType.Film then
		local content = self.config:GetArgValue(StoryArgKeyConst.DialogContentDefault) or ""
		local name = self.m_dialogData.roleName or ""

		if string.nilorempty(name) and string.nilorempty(content) then
			self.m_dialogData.content = ""
			self.m_dialogData.copyContent = ""
		else
			content = StoryUtils.parseStoryText(content)
			self.m_dialogData.copyContent = content

			if string.nilorempty(name) then
				self.m_dialogData.content = content
			else
				self.m_dialogData.content = name .. "：" .. content
			end
		end
	else
		local content = self.config:GetArgValue(StoryArgKeyConst.DialogContentDefault)

		self.m_dialogData.content = StoryUtils.parseStoryText(content)
	end

	if not string.nilorempty(self.m_dialogData.content) then
		self.contentCount = string.utf8len(self.m_dialogData.content)
	else
		self.contentCount = 0
	end

	self.m_dialogData.maxPrintCount = self.contentCount
end

return M
