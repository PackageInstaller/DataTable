-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/photopicker/PhotoPicker.lua

module("logic.common.photopicker.PhotoPicker", package.seeall)

local PhotoPicker = {}
local clazz = "com.baitian.unity.ImagePickerWrap"
local KEY_PICK_IMAGE = "key_pick_image"
local KEY_SAVE_IMAGE = "key_save_image"
local KEY_DEL_IMAGE = "key_del_image"
local KEY_GET_ALBUM_IMAGE = "key_get_album_image"

function PhotoPicker.pickImage(aspectX, aspectY, outputX, outputY, crop)
	local param = {}

	param.aspectX = aspectX
	param.aspectY = aspectY
	param.outputX = outputX
	param.outputY = outputY
	param.crop = crop

	NativeBridge.instance:invoke(clazz, "pickImage", param)
end

function PhotoPicker.captureImage(aspectX, aspectY, outputX, outputY, crop)
	local param = {}

	param.aspectX = aspectX
	param.aspectY = aspectY
	param.outputX = outputX
	param.outputY = outputY
	param.crop = crop

	NativeBridge.instance:invoke(clazz, "captureImage", param)
end

function PhotoPicker.registerPickImageListener(callFunc)
	NativeBridge.instance:registerListener(KEY_PICK_IMAGE, function(result)
		callFunc(result.filePath, result.statusCode)
	end)
end

function PhotoPicker.unregisterPickImageListener()
	NativeBridge.instance:unregisterListener(KEY_PICK_IMAGE)
end

function PhotoPicker.saveImageToAlbum(imageName, albumName, imagePath)
	local param = {}

	param.imageName = imageName
	param.albumName = albumName
	param.imagePath = imagePath

	NativeBridge.instance:invoke("com.baitian.unity.ImagePickerWrap", "saveImageToAlbum", param)
end

function PhotoPicker.registerSaveImageListener(callFunc)
	NativeBridge.instance:registerListener(KEY_SAVE_IMAGE, function(result)
		callFunc(result.statusCode)
	end)
end

function PhotoPicker.unregisterSaveImageListener()
	NativeBridge.instance:unregisterListener(KEY_SAVE_IMAGE)
end

function PhotoPicker.delImageFromAlbum(imageName, albumName)
	local param = {}

	param.imageName = imageName
	param.albumName = albumName

	NativeBridge.instance:invoke("com.baitian.unity.ImagePickerWrap", "delImageFromAlbum", param)
end

function PhotoPicker.registerDelImageListener(callFunc)
	NativeBridge.instance:registerListener(KEY_DEL_IMAGE, function(result)
		callFunc(result.statusCode)
	end)
end

function PhotoPicker.unregisterDelImageListener()
	NativeBridge.instance:unregisterListener(KEY_DEL_IMAGE)
end

function PhotoPicker.getImageFromAlubm(albumName)
	local param = {}

	param.albumName = albumName

	NativeBridge.instance:invoke("com.baitian.unity.ImagePickerWrap", "getImageFromAlbum", param)
end

function PhotoPicker.registerGetImageListener(callFunc)
	NativeBridge.instance:registerListener(KEY_GET_ALBUM_IMAGE, function(result)
		callFunc(result.statusCode, result.filePath, result.photoName)
	end)
end

function PhotoPicker.unregisterGetImageListener()
	NativeBridge.instance:unregisterListener(KEY_GET_ALBUM_IMAGE)
end

return PhotoPicker
