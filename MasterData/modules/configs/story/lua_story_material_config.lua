-- chunkname: @modules/configs/story/lua_story_material_config.lua

return {
	[1001] = {
		name = "画面光晕(调色)",
		props = {
			_LightColor = {
				type = 1,
				value = {
					1,
					1,
					1,
					1
				}
			},
			_Control = {
				type = 2,
				value = {
					1,
					0,
					0,
					0
				}
			},
			_Refine = {
				type = 2,
				value = {
					1,
					0,
					0,
					50
				}
			}
		}
	},
	[1002] = {
		name = "氛围图轻微(BloomFactor)",
		props = {
			_QuickBloomG2 = {
				value = 0.2,
				type = 0
			},
			_QuickBloomG = {
				value = 0.2,
				type = 0
			},
			_BloomFactor = {
				value = 1,
				type = 0
			},
			_Blend = {
				value = 0.03,
				type = 0
			}
		}
	},
	[1003] = {
		name = "white out(BloomFactor)",
		props = {
			_QuickBloomG2 = {
				value = 1,
				type = 0
			},
			_QuickBloomG = {
				value = 1,
				type = 0
			},
			_Refine = {
				type = 2,
				value = {
					1,
					3.5,
					0,
					50
				}
			},
			_Blend = {
				value = 1,
				type = 0
			},
			_BloomFactor = {
				value = 1,
				type = 0
			}
		}
	},
	[1004] = {
		name = "关闭",
		props = {
			_Blend = {
				value = 0,
				type = 0
			},
			_BloomFactor = {
				value = 0,
				type = 0
			}
		}
	},
	[1005] = {
		name = "白底光溢出(BloomFactor)_副本",
		props = {
			_QuickBloomG2 = {
				value = 0.5,
				type = 0
			},
			_QuickBloomG = {
				value = 0.4,
				type = 0
			},
			_BloomFactor = {
				value = 1,
				type = 0
			},
			_Blend = {
				value = 0.3,
				type = 0
			}
		}
	},
	[1006] = {
		name = "crt滤镜（液晶）",
		props = {
			_MaskScale = {
				value = 1,
				type = 0
			},
			_BloomStrength = {
				value = 1,
				type = 0
			},
			_ChromaOffset = {
				value = 2,
				type = 0
			}
		}
	}
}
