-- chunkname: @IQIGame\\Util\\LuaUtility.lua

LuaUtility = {}

function LuaUtility.SetGameObjectShow(gameObject, show)
	LuaCodeInterface.SetGameObjectShow(gameObject, show)
end

function LuaUtility.SetTransGameObjectShow(transform, show)
	LuaCodeInterface.SetTransGameObjectShow(transform, show)
end

function LuaUtility.SetGameObjectName(gameObject, name)
	LuaCodeInterface.SetGameObjectName(gameObject, name)
end

function LuaUtility.SetTransGameObjectName(transform, name)
	if transform ~= nil then
		local gameObject = transform.gameObject

		LuaUtility.SetGameObjectName(gameObject, name)
	end
end

function LuaUtility.GetChildCount(transform)
	return transform.childCount
end

function LuaUtility.GetChild(transform, index)
	return transform:GetChild(index)
end

function LuaUtility.GameObjectIsNullOrEmpty(gameObject)
	if not gameObject then
		return true
	end

	return LuaCodeInterface.GameObjectIsNullOrEmpty(gameObject)
end

function LuaUtility.SetRotationWithTransform(transform, x, y, z)
	LuaCodeInterface.SetRotationWithTransform(transform, x, y, z)
end

function LuaUtility.SetRigidbodyConstraints_PosYAndRotate(rigidbody)
	LuaCodeInterface.SetRigidbodyConstraints_PosYAndRotate(rigidbody)
end

function LuaUtility.SetGameObjectSiblingIndex(gameObject, index)
	LuaCodeInterface.SetGameObjectSiblingIndex(gameObject, index)
end

function LuaUtility.GetGameObjectSiblingIndex(gameObject)
	return LuaCodeInterface.GetGameObjectSiblingIndex(gameObject)
end

function LuaUtility.GetGameObjectInstanceID(gameObject)
	return gameObject:GetInstanceID()
end

function LuaUtility.AddComponent(gameObject, component)
	return gameObject:AddComponent(component)
end

function LuaUtility.GetComponent(gameObject, component)
	return gameObject:GetComponent(component)
end

function LuaUtility.GameObjectGetOrAddComponent(gameObject, type)
	if not UIUtil.IsNil(gameObject) and type ~= nil then
		return LuaCodeInterface.GameObjectGetOrAddComponent(gameObject, type)
	else
		logError("LuaUtility.GameObjectGetOrAddComponent:  gameObject or type is nil.")

		return nil
	end
end

function LuaUtility.GetComponentsInChildren(gameObject, type)
	return LuaCodeInterface.GetComponentsInChildren(gameObject, type)
end

function LuaUtility.CheckFollowerComponent(gameObject, followTrans, offset)
	local follower

	follower = LuaUtility.GetComponent(gameObject, typeof(TransformFollower))
	follower = follower or LuaUtility.AddComponent(gameObject, typeof(TransformFollower))

	follower:Init(gameObject.transform, followTrans, offset)
end

function LuaUtility.SetText(gameObject, text)
	UGUIUtil.SetText(gameObject, text)
end

function LuaUtility.SetEmptyText(gameObject)
	LuaCodeInterface.SetTextEmpty(gameObject)
end

function LuaUtility.SetImageNativeSizeWithGameObject(gameObject)
	LuaCodeInterface.SetImageNativeSizeWithGameObject(gameObject)
end

function LuaUtility.LoadImage(owner, path, imageComponent, onSuccess, onFail, userData, hideBeforeLoaded)
	return AssetUtil.LoadImage(owner, path, imageComponent, onSuccess, onFail, userData, hideBeforeLoaded)
end

function LuaUtility.SetTextFontSize(gameObject, size)
	LuaCodeInterface.SetTextFontSize(gameObject, size)
end

function LuaUtility.SetImageFillAmount(gameObject, num)
	LuaCodeInterface.SetImageFillAmount(gameObject, num)
end

function LuaUtility.SetImageColorWithGameObject(gameObject, r, g, b, alpha)
	LuaCodeInterface.SetImageColorWithGameObject(gameObject, r, g, b, alpha)
end

function LuaUtility.SetImageRectTransformPivot(rectTransform, image)
	local rectWidth = rectTransform.sizeDelta.x
	local rectHeight = rectTransform.sizeDelta.y
	local offsetX = rectWidth - image.sprite.pivot.x
	local offsetY = rectHeight - image.sprite.pivot.y
	local pivotX = 1 - offsetX / rectWidth
	local pivotY = 1 - offsetY / rectHeight

	rectTransform.pivot = Vector2.New(pivotX, pivotY)
end

function LuaUtility.SetCanvasGroupShowWithGameObject(gameObject, show)
	LuaCodeInterface.SetCanvasGroupShowWithGameObject(gameObject, show)
end

function LuaUtility.SetTextColor(gameObject, r, g, b, a)
	LuaCodeInterface.SetTextColor(gameObject, r, g, b, a)
end

function LuaUtility.GetUIObjectAngle(own, target)
	return LuaCodeInterface.GetTwoUIObjectAngle(own, target)
end

function LuaUtility.LimitUIPosToScreen(rootUI, limitUI, offset_X, offset_Y)
	offset_X = offset_X and offset_X or 0
	offset_Y = offset_Y and offset_Y or 0

	local _, limitUIRootPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rootUI, StoryModule.uiCamera:WorldToScreenPoint(limitUI.transform.position), StoryModule.uiCamera, nil)
	local rootUISizeDelta = rootUI.sizeDelta
	local limitUISizeDelta = limitUI.sizeDelta
	local limitUiAnchorPos = limitUI.anchoredPosition
	local rootUILen_X = rootUISizeDelta.x / 2
	local rootUILen_Y = rootUISizeDelta.y / 2
	local limitUILen_X = limitUISizeDelta.x / 2
	local limitUILen_Y = limitUISizeDelta.y / 2

	if limitUIRootPos.x < 0 then
		if rootUILen_X < math.abs(limitUIRootPos.x - limitUILen_X) then
			limitUI.anchoredPosition = Vector2.New(limitUILen_X - rootUILen_X - math.abs(limitUIRootPos.x - limitUiAnchorPos.x) + offset_X, limitUI.anchoredPosition.y)
		end
	elseif rootUILen_X < limitUIRootPos.x + limitUILen_X then
		limitUI.anchoredPosition = Vector2.New(rootUILen_X - limitUILen_X - math.abs(limitUIRootPos.x - limitUiAnchorPos.x) - offset_X, limitUI.anchoredPosition.y)
	end

	if limitUIRootPos.y < 0 then
		if rootUILen_Y < math.abs(limitUIRootPos.y - limitUILen_Y) then
			limitUI.anchoredPosition = Vector2.New(limitUI.anchoredPosition.x, limitUILen_Y - rootUILen_Y - math.abs(limitUIRootPos.y - limitUiAnchorPos.y) + offset_Y)
		end
	elseif rootUILen_Y < limitUIRootPos.y + limitUILen_Y then
		limitUI.anchoredPosition = Vector2.New(limitUI.anchoredPosition.x, rootUILen_Y - limitUILen_Y - math.abs(limitUIRootPos.y - limitUiAnchorPos.y) - offset_Y)
	end
end

function LuaUtility.SetImageMaterial(gameObject, material)
	LuaCodeInterface.SetImageMaterial(gameObject, material)
end

function LuaUtility.ScreenToWorldPos(camera, screenPos, offsetZ)
	return UGUIUtil.ScreenToWorldPosition(camera, screenPos, offsetZ)
end

function LuaUtility.WorldToScreenPos(uiCamera, worldPos)
	return LuaCodeInterface.WorldToScreenPosition(uiCamera, worldPos)
end

function LuaUtility.SetEulerAnglesWithGameObject(gameObject, x, y, z)
	LuaCodeInterface.SetEulerAnglesWithGameObject(gameObject, x, y, z)
end

function LuaUtility.SetTransformWithGameObject(gameObject, position)
	LuaCodeInterface.SetTransformWithGameObject(gameObject, position)
end

function LuaUtility.SetSizeDeltaWithRectTransform(rect, width, height)
	LuaCodeInterface.SetSizeDeltaWithRectTransform(rect, width, height)
end

function LuaUtility.SetSizeDeltaXWithGameObject(gameObject, x)
	LuaCodeInterface.SetSizeDeltaXWithGameObject(gameObject, x)
end

function LuaUtility.SetSizeDeltaYWithGameObject(gameObject, y)
	LuaCodeInterface.SetSizeDeltaYWithGameObject(gameObject, y)
end

function LuaUtility.SetAnchoredPositionWithRectTransform(rect, x, y)
	LuaCodeInterface.SetAnchoredPositionWithRectTransform(rect, x, y)
end

function LuaUtility.SetAnchoredPosition3DWithRectTransform(rect, posX, posY, posZ)
	LuaCodeInterface.SetAnchoredPosition3DWithRectTransform(rect, posX, posY, posZ)
end

function LuaUtility.SetPositionWithTransform(transform, posX, posY, posZ)
	LuaCodeInterface.SetPositionWithTransform(transform, posX, posY, posZ)
end

function LuaUtility.SetPositionWithGameObject(gameObject, posX, posY, posZ)
	LuaCodeInterface.SetPositionWithGameObject(gameObject, posX, posY, posZ)
end

function LuaUtility.SetScaleWithTransform(transform, scaleX, scaleY, scaleZ)
	LuaCodeInterface.SetScaleWithTransform(transform, scaleX, scaleY, scaleZ)
end

function LuaUtility.ScreenPointToWorldPointInRectangle(rectTransform, pointerEventData)
	UGUIUtil.ScreenPointToWorldPointInRectangle(rectTransform, pointerEventData)
end

function LuaUtility.ScreenPointToLocalPointInRectangle(rectTransform, screenPoint, UICamera)
	return UGUIUtil.ScreenPointToLocalPointInRectangle(rectTransform, screenPoint, UICamera)
end

function LuaUtility.SetLocalPositionWithGameObject(gameObject, x, y, z)
	LuaCodeInterface.SetLocalPositionWithGameObject(gameObject, x, y, z)
end

function LuaUtility.GetPositionWithGameObject(gameObject)
	return LuaCodeInterface.GetPositionWithGameObject(gameObject)
end

function LuaUtility.GetLocalPositionWithGameObject(gameObject)
	return LuaCodeInterface.GetLocalPositionWithGameObject(gameObject, 0, 0, 0)
end

function LuaUtility.SetToTargetUICenter(mWorldPos, targetRect)
	local screenPos = GameEntry.UICamera:WorldToScreenPoint(mWorldPos)
	local isRect, resultPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(targetRect, screenPos, GameEntry.UICamera, nil)

	if not isRect then
		return
	end

	LuaUtility.SetAnchoredPositionWithRectTransform(targetRect, -resultPos.x, -resultPos.y)
end

function LuaUtility.SetRendererSortingOrder(gameObject, order)
	local renderers = gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	for i = 0, renderers.Length - 1 do
		renderers[i].sortingOrder = order
	end
end

function LuaUtility.StrIsNullOrEmpty(str)
	if str == nil or str == "" then
		return true
	end

	return false
end

function LuaUtility.StrIsStartWith(str, startStr)
	local start_string = string.sub(str, 1, string.len(startStr))

	if start_string == startStr then
		return true
	else
		return false
	end
end

function LuaUtility.ActionParamToVector3(actionParam)
	local posArray = string.split(actionParam, ",")

	return Vector3.New(tonumber(posArray[1]), tonumber(posArray[2]), tonumber(posArray[3]))
end

function LuaUtility.ActionParamToItemDataTable(ActionParam)
	local arr = UIUtil.GetConfigArr(ActionParam)
	local itemDataTable = {}

	for i = 1, getCfgTableLength(arr) do
		local cfg = CfgItemTable[arr[i][1]]

		if cfg.IsHide ~= 1 then
			itemDataTable[i] = ItemData.CreateByCIDAndNumber(arr[i][1], arr[i][2])
		end
	end

	return itemDataTable
end

function LuaUtility.PlayDoTweenWithGameObject(gameObject)
	LuaCodeInterface.PlayDoTweenWithGameObject(gameObject)
end

function LuaUtility.RewindDoTweenWithGameObject(gameObject)
	LuaCodeInterface.RewindDoTweenWithGameObject(gameObject)
end

function LuaUtility.GetDoTweenMaxTime(gameObject)
	return LuaCodeInterface.GetDoTweenMaxTime(gameObject)
end

function LuaUtility.SetCinemachineBlend(style, time)
	LuaCodeInterface.SetCinemachineBlend(style, time)
end

function LuaUtility.SetCinemachineFOV(virtualCamera, fov)
	LuaCodeInterface.SetCinemachineFOV(virtualCamera, fov)
end

function LuaUtility.GetCinemachineFOV(virtualCamera)
	return LuaCodeInterface.GetCinemachineFOV(virtualCamera)
end

function LuaUtility.Log(logType, content)
	if logType then
		log(content)
	end
end

function LuaUtility.LogColor(logType, content, color)
	if logType then
		logColorInfo(content, color)
	end
end

function LuaUtility.LogWarning(logType, content)
	if logType then
		warning(content)
	end
end

function LuaUtility.LogError(logType, content)
	if logType then
		logError(content)
	end
end

function LuaUtility.LogErrorFormat(logType, content, ...)
	if logType then
		logError(string.format(content, ...))
	end
end

function LuaUtility.StartNewBGMGroup(bgmCid)
	SoundPackagePlayer.ClearAfterStopAllSound()

	return LuaUtility.PlayBGMWithID(bgmCid)
end

function LuaUtility.ReplaceBGM(bgmSerialID, bgmCid)
	if bgmSerialID == 0 then
		logError("当你看到这段话，那么BGM播放已经出问题了，请联系程序")

		bgmSerialID = LuaUtility.PlayBGMWithID(bgmCid)

		return
	end

	local package = SoundPackageData.New(bgmCid, nil)

	log("【切换】BGM ID = " .. bgmCid)
	SoundPackagePlayer.Replace(bgmSerialID, package)
end

function LuaUtility.PlayBGMWithID(bgmCid)
	local package = SoundPackageData.New(bgmCid, nil)

	log("【播放】BGM ID = " .. bgmCid)

	return SoundPackagePlayer.Add(package)
end

function LuaUtility.RemoveBGM(bgmSerialID)
	SoundPackagePlayer.Remove(bgmSerialID)
end

function LuaUtility.PlaySoundWithID(soundID)
	if not soundID then
		LuaUtility.LogError(Constant.LogType.Normal, "播放音乐失败，音乐id为空 ")

		return 0
	end

	if soundID == 0 then
		return 0
	end

	local cfgSound = CfgUtil.GetSoundCfgDataWithID(soundID)

	if not cfgSound then
		LuaUtility.LogError(Constant.LogType.Normal, "播放音乐失败，没有找到音乐ID = " .. soundID)

		return 0
	end

	if cfgSound.GroupName == "BGM" then
		LuaUtility.LogError(Constant.LogType.Normal, "播放音乐失败ID = " .. soundID .. " 背景音乐请用 PlayBGMWithID 方法")

		return 0
	end

	if LuaUtility.StrIsNullOrEmpty(cfgSound.GroupName) then
		LuaUtility.LogError(Constant.LogType.Normal, "播放音乐失败，检查 Sound 配置表是否有配置GroupName。音乐ID = " .. soundID)

		return 0
	end

	return GameEntry.Sound:PlaySound(soundID, cfgSound.GroupName)
end

function LuaUtility.StopSoundWithSerialId(serialId)
	return GameEntry.Sound:StopSound(serialId)
end

function LuaUtility.PauseSoundWithId(serialId)
	GameEntry.Sound:PauseSound(serialId)
end

function LuaUtility.ResumeSoundWithID(serialId)
	GameEntry.Sound:ResumeSound(serialId)
end

function LuaUtility.GetSoundAssetPath(path)
	return string.format("Assets/06_Sounds/%s", path)
end

function LuaUtility.LoadAsset(owner, path, onSuccess, onFail, userData)
	AssetUtil.LoadAsset(owner, path, onSuccess, onFail, userData)
end

function LuaUtility.UnLoadAsset(owner)
	AssetUtil.UnloadAsset(owner)
end

function LuaUtility.ResourceLoadImage(gameObject, path)
	LuaCodeInterface.ResourceLoadImage(gameObject, path)
end

function LuaUtility.SetBehaviorGlobalVariables(name, value)
	LuaCodeInterface.SetBehaviorGlobalVariables(name, value)
end

function LuaUtility.GetBehaviorGlobalFloatVariables(name)
	return LuaCodeInterface.GetBehaviorGlobalFloatVariables(name)
end

function LuaUtility.SetStateController(gameObject, dataName, stateName)
	LuaCodeInterface.SetStateController(gameObject, dataName, stateName)
end

function LuaUtility.GetMainUIIsBottom()
	return LuaCodeInterface.GetMainUIIsBottom()
end

function LuaUtility.GetDialogText(content)
	return string.format(content, PlayerModule.GetName())
end

function LuaUtility.ResetTextBackGround(textBackgroundSourceObj)
	local proName = "_DisplayAlpha"
	local background = textBackgroundSourceObj:GetComponent(typeof(BordlessFramework.UI.TextBackground))
	local mat = background.material

	if mat then
		mat:SetFloat(proName, 1)
	end
end
