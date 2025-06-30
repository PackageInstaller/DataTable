
local MovieComponent = BaseClass("MovieComponent", Component)
local base = Component
local this = MovieComponent;
local path = "UI/Prefabs/Common/MovieTool.prefab";
function this.Awake(self)
    base.Awake(self)
    ResourcesManager:GetInstance():LoadAsync(path, typeof(CS.UnityEngine.GameObject), function(v)
        local gameObject =  CS.UnityEngine.GameObject.Instantiate(v)
        CS.UnityEngine.GameObject.DontDestroyOnLoad(gameObject)
        self.gameObject = gameObject
        local transform  = self.gameObject.transform
        self.movieTool = transform:GetComponent("MovieTool")
     end)
end
function this.MoviePlay(self)
    self.movieTool:PlayMovie("025_YuZaoQian1.mp4",function ()
        print("adfewtrdddddadf...dfqertqwetadfa!~~~~~~~~++++++++++++++++++++++++++++++++++++++++++")
    end)
end
function this.Dispose(self)
    base.Dispose(self);
end
return this;