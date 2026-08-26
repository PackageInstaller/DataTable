-- chunkname: @modules/logic/share/view/ShareEditorView.lua

module("modules.logic.share.view.ShareEditorView", package.seeall)

local ShareEditorView = class("ShareEditorView", BaseView)

function ShareEditorView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorawImage = gohelper.findChild(self.viewGO, "container/frame/#go_rawImage")
	self._gocontent = gohelper.findChild(self.viewGO, "container/frame/#go_content")
	self._goplatformitem = gohelper.findChild(self.viewGO, "container/frame/#go_platformitem")
	self._togglehideview = gohelper.findChildToggle(self.viewGO, "container/frame/#toggle_hideview")
	self._simagelogo = gohelper.findChildSingleImage(self.viewGO, "#simage_logo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShareEditorView:addEvents()
	return
end

function ShareEditorView:removeEvents()
	return
end

function ShareEditorView:_editableInitView()
	self._viewOpen = false

	gohelper.setActive(self._togglehideview.gameObject, false)

	local list = SDKMgr.instance:getChannelId() == SDKMgr.ChannelId.QQMobile and {
		"fenxiang_qq",
		"fenxiang_kongjian"
	} or SDKMgr.instance:getChannelId() == SDKMgr.ChannelId.Douyin and {
		"fenxiang_douyin"
	} or {
		"fenxiang_weixin",
		"fenxiang_pengyouqvan",
		"fenxiang_weibo",
		"fenxiang_qq",
		"fenxiang_kongjian",
		"fenxiang_douyin",
		"fenxiang_xiaohongshu",
		"fenxiang_xiazai"
	}

	self._listenerList = self:getUserDataTb_()

	for i, name in ipairs(list) do
		local go = gohelper.clone(self._goplatformitem, self._gocontent, name)

		gohelper.setActive(go, true)

		local img = go:GetComponent(gohelper.Type_Image)

		UISpriteSetMgr.instance:setShareSprite(img, name)

		local clickListener = SLFramework.UGUI.UIClickListener.Get(go)

		clickListener:AddClickListener(self._onClick, self, name)
		table.insert(self._listenerList, clickListener)
	end
end

function ShareEditorView:_onClick(name)
	if not self._canClick then
		return
	end

	if string.nilorempty(self._msg) then
		logError("图片地址为空")

		return
	end

	logNormal(self._msg)

	if name == "fenxiang_weixin" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.WechatFriend, SDKMgr.ShareContentType.Image, self._msg)
	elseif name == "fenxiang_pengyouqvan" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.WechatMoment, SDKMgr.ShareContentType.Image, self._msg)
	elseif name == "fenxiang_weibo" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.SinaWeibo, SDKMgr.ShareContentType.Image, self._msg)
	elseif name == "fenxiang_douyin" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.TikTok, SDKMgr.ShareContentType.Image, self._msg)
	elseif name == "fenxiang_xiaohongshu" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.XiaoHongShu, SDKMgr.ShareContentType.Image, self._msg)
	elseif name == "fenxiang_qq" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.QQ, SDKMgr.ShareContentType.Image, self._msg)
	elseif name == "fenxiang_kongjian" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.QQZone, SDKMgr.ShareContentType.Image, self._msg)
	elseif name == "fenxiang_xiazai" then
		SDKMgr.instance:saveImage(self._msg)
	end
end

function ShareEditorView:onOpen()
	self._viewOpen = true
	self._canClick = false
	self._texture = self.viewParam
	self._image = gohelper.onceAddComponent(self._gorawImage, gohelper.Type_RawImage)
	self._image.texture = self._texture

	self._simagelogo:LoadImage(ResUrl.getLoginBgLangIcon("bg_logo"), self._logoLoaded, self)
	TaskDispatcher.runDelay(self._overTime, self, 1)
end

function ShareEditorView:_overTime()
	self._canClick = true
end

function ShareEditorView:_logoLoaded()
	if not self._viewOpen then
		return
	end

	local logoImage = self._simagelogo.gameObject:GetComponent(typeof(UnityEngine.UI.Image))
	local logoTexture = logoImage.sprite.texture
	local rect = self:_getRect(self._texture, self._simagelogo.gameObject)

	self._co = coroutine.start(self._addLogo, self, self._texture, logoTexture, rect)
end

function ShareEditorView:_onCoroutineDone()
	self._msg = self:_saveImage(self._texture)
	self._image.texture = self._texture
	self._canClick = true
end

function ShareEditorView:_getRect(texture, logoGO)
	local camera = gohelper.find("UICamera"):GetComponent(typeof(UnityEngine.Camera))
	local logoRectTransform = logoGO:GetComponent(typeof(UnityEngine.RectTransform))
	local logoCorners = System.Array.CreateInstance(typeof(Vector3), 4)

	logoRectTransform:GetWorldCorners(logoCorners)

	local logoPositions = System.Array.CreateInstance(typeof(Vector2), 4)

	for i = 0, 3 do
		logoPositions[i] = UnityEngine.RectTransformUtility.WorldToScreenPoint(camera, logoCorners[i])
	end

	local size = logoPositions[2] - logoPositions[0]
	local position = Vector2(texture.width - size.x, texture.height - size.y)

	return UnityEngine.Rect.New(position, size)
end

function ShareEditorView:_addLogo(texture, logoTexture, rect)
	WaitForEndOfFrame()

	local rt = UnityEngine.RenderTexture.GetTemporary(texture.width, texture.height, 0, UnityEngine.RenderTextureFormat.Default)
	local original = UnityEngine.RenderTexture.active

	UnityEngine.RenderTexture.active = rt

	UnityEngine.GL.PushMatrix()
	UnityEngine.GL.LoadPixelMatrix(0, texture.width, texture.height, 0)
	UnityEngine.Graphics.Blit(texture, rt)
	UnityEngine.Graphics.DrawTexture(rect, logoTexture)
	texture:ReadPixels(UnityEngine.Rect.New(0, 0, texture.width, texture.height), 0, 0)
	texture:Apply()
	UnityEngine.GL.PopMatrix()

	UnityEngine.RenderTexture.active = original

	UnityEngine.RenderTexture.ReleaseTemporary(rt)
	self:_onCoroutineDone()
end

function ShareEditorView:_saveImage(texture)
	local bytes = UnityEngine.ImageConversion.EncodeToPNG(texture)
	local directory = System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "screenshot")
	local now = System.DateTime.Now
	local fileName = string.format("screenshot_%s%s%s_%s%s%s%s.png", now.Year, now.Month, now.Day, now.Hour, now.Minute, now.Second, now.Millisecond)
	local path = System.IO.Path.Combine(directory, fileName)

	SLFramework.FileHelper.WriteAllBytesToPath(path, bytes)

	return path
end

function ShareEditorView:onClose()
	self._viewOpen = false

	UnityEngine.Object.Destroy(self._texture)
end

function ShareEditorView:onDestroyView()
	if self._co then
		coroutine.stop(self._co)
	end

	TaskDispatcher.cancelTask(self._overTime, self)

	for i, v in ipairs(self._listenerList) do
		v:RemoveClickListener()
	end

	self._simagelogo:UnLoadImage()
end

return ShareEditorView
