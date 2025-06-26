-- chunkname: @IQIGame\\UI\\VirtualPhoto\\VirtualPhotoUIModule.lua

VirtualPhotoUIModule = {}

function VirtualPhotoUIModule.OpenCamera(onSuccess)
	IQIGame.Onigao.Game.GameEntry.Photo:OpenCamera(function(success, webCamTexture, camNum, permission)
		if success then
			UIModule.Open(Constant.UIControllerName.VirtualPhotoCameraUI, Constant.UILayer.UI, {
				webCamTexture = webCamTexture,
				onShoot = function(texture)
					onSuccess(texture)
				end
			})
		elseif permission == Constant.GalleryPermission.Denied then
			NoticeModule.ShowNotice(21064047)
		elseif camNum == 0 then
			NoticeModule.ShowNotice(21064048)
		else
			NoticeModule.ShowNoticeByType(1, "Get camera device failed，camNum: " .. camNum .. " permission：" .. tostring(permission))
		end
	end)
end

function VirtualPhotoUIModule.OpenGallery(onSuccess)
	IQIGame.Onigao.Game.GameEntry.Photo:GetImageFromGallery(function(texture, path, permission)
		if texture ~= nil then
			onSuccess(texture)
		elseif permission == Constant.GalleryPermission.Denied then
			NoticeModule.ShowNotice(21064051)
		end
	end)
end
