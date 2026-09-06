-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/PhotoPicker.lua

module("logiccommon.common.sdk.PhotoPicker", package.seeall)

local PhotoPicker = {}
local gameVersionCode = 0
local clazz = "com.baitian.unity.ImagePickerWrap"
local KEY_PICK_IMAGE = "key_pick_image"
local KEY_SAVE_IMAGE = "key_save_image"
local KEY_DEL_IMAGE = "key_del_image"
local KEY_GET_ALBUM_IMAGE = "key_get_album_image"
local KEY_PICK_VIDEO = "key_pick_video"
local KEY_SAVE_VIDEO = "key_save_video"
local KEY_DEL_VIDEO = "key_del_video"

function PhotoPicker.pickImage(aspectX, aspectY, outputX, outputY, crop)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	local param = {}

	param.aspectX = aspectX
	param.aspectY = aspectY
	param.outputX = outputX
	param.outputY = outputY
	param.crop = crop

	NativeBridge.instance:invoke(clazz, "pickImage", param)
end

function PhotoPicker.captureImage(aspectX, aspectY, outputX, outputY, crop)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	local param = {}

	param.aspectX = aspectX
	param.aspectY = aspectY
	param.outputX = outputX
	param.outputY = outputY
	param.crop = crop

	NativeBridge.instance:invoke(clazz, "captureImage", param)
end

function PhotoPicker.registerPickImageListener(callFunc)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:registerListener(KEY_PICK_IMAGE, function(result)
		callFunc(result.filePath, result.statusCode)
	end)
end

function PhotoPicker.unregisterPickImageListener()
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:unregisterListener(KEY_PICK_IMAGE)
end

function PhotoPicker.saveImageToAlbum(imageName, albumName, imagePath)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	local param = {}

	param.imageName = imageName
	param.albumName = albumName
	param.imagePath = imagePath

	NativeBridge.instance:invoke("com.baitian.unity.ImagePickerWrap", "saveImageToAlbum", param)
end

function PhotoPicker.registerSaveImageListener(callFunc)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:registerListener(KEY_SAVE_IMAGE, function(result)
		callFunc(result.statusCode)
	end)
end

function PhotoPicker.unregisterSaveImageListener()
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:unregisterListener(KEY_SAVE_IMAGE)
end

function PhotoPicker.delImageFromAlbum(imageName, albumName)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	local param = {}

	param.imageName = imageName
	param.albumName = albumName

	NativeBridge.instance:invoke("com.baitian.unity.ImagePickerWrap", "delImageFromAlbum", param)
end

function PhotoPicker.registerDelImageListener(callFunc)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:registerListener(KEY_DEL_IMAGE, function(result)
		callFunc(result.statusCode)
	end)
end

function PhotoPicker.unregisterDelImageListener()
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:unregisterListener(KEY_DEL_IMAGE)
end

function PhotoPicker.getImageFromAlubm(albumName)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	local param = {}

	param.albumName = albumName

	NativeBridge.instance:invoke("com.baitian.unity.ImagePickerWrap", "getImageFromAlbum", param)
end

function PhotoPicker.registerGetImageListener(callFunc)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:registerListener(KEY_GET_ALBUM_IMAGE, function(result)
		callFunc(result.statusCode, result.filePath, result.photoName)
	end)
end

function PhotoPicker.unregisterGetImageListener()
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:unregisterListener(KEY_GET_ALBUM_IMAGE)
end

function PhotoPicker.pickVideo()
	if not PhotoPicker.isCanPhoto() then
		return
	end

	local param = {}

	NativeBridge.instance:invoke(clazz, "pickVideo", param)
end

function PhotoPicker.registerPickVideoListener(callFunc)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:registerListener(KEY_PICK_VIDEO, function(result)
		callFunc(result.statusCode, result.filePath)
	end)
end

function PhotoPicker.unregisterPickVideoListener()
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:unregisterListener(KEY_PICK_VIDEO)
end

function PhotoPicker.saveVideoToAlbum(videoName, albumName, videoPath)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	local param = {}

	param.videoName = videoName
	param.albumName = albumName
	param.videoPath = videoPath

	NativeBridge.instance:invoke("com.baitian.unity.ImagePickerWrap", "saveVideoToAlbum", param)
end

function PhotoPicker.registerSaveVideoListener(callFunc)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:registerListener(KEY_SAVE_VIDEO, function(result)
		callFunc(result.statusCode)
	end)
end

function PhotoPicker.unregisterSaveImageListener()
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:unregisterListener(KEY_SAVE_VIDEO)
end

function PhotoPicker.delVideoFromAlbum(imageName, albumName)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	local param = {}

	param.videoName = videoName
	param.albumName = albumName

	NativeBridge.instance:invoke("com.baitian.unity.ImagePickerWrap", "delVideoFromAlbum", param)
end

function PhotoPicker.registerDelVideoListener(callFunc)
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:registerListener(KEY_DEL_VIDEO, function(result)
		callFunc(result.statusCode)
	end)
end

function PhotoPicker.unregisterDelVideoListener()
	if not PhotoPicker.isCanPhoto() then
		return
	end

	NativeBridge.instance:unregisterListener(KEY_DEL_VIDEO)
end

function PhotoPicker.isCanPhoto()
	if gameVersionCode <= 0 then
		gameVersionCode = SDKManager.getGameVersionCode()
	end

	if Framework.OSDef.RunOS == Framework.OSDef.Android then
		return gameVersionCode >= 870
	elseif Framework.OSDef.RunOS == Framework.OSDef.IOS then
		return false
	end

	return false
end

return PhotoPicker
