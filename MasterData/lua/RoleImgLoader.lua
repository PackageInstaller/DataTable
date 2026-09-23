

--加载立绘
function LoadImg(_imgGo, _modelId, _type, _callBack)
	if(_modelId == nil or _imgGo == nil) then
		LogError("_imgGo is nil")
		return
	end
	
	modelId = _modelId;
	loadType = _type;
	imgGo = _imgGo;
	callBack = _callBack;
	
	local pos, scale, imgName = RoleTool.GetImgPosScale(modelId, loadType);
	
	if(imgName) then
		ResUtil.ImgCharacter:Load(_imgGo, imgName, OnLoaded);	
	else
		Log("imgName is nil")
	end	
end

function OnLoaded(img)
	local pos, scale, imgName = RoleTool.GetImgPosScale(modelId, loadType)
	if(pos) then
		ResUtil.ImgCharacter:SetPos(imgGo, pos)
		ResUtil.ImgCharacter:SetScale(imgGo, scale)
	else
		Log("imgName is nil")
	end	
	
	if(callBack) then
		callBack(img);
	end
	
	CSAPI.RemoveGO(gameObject);
end 
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  

end
----#End#----