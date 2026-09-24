return {
	_rule_ = {
		none = {
			shadow_weather = {
				path = "shadow_weather",
				list = {},
				component = {}
			},
			weather_close_btn = {
				path = "weather_close_btn",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			},
			weather_info = {
				path = "weather_info",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			weather_name = {
				path = "weather_info/weather_name",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			weather_content = {
				path = "weather_info/weather_content",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			}
		},
		call_node_list = {
			["strike_weather/weather_info"] = "_control.weather_info",
			["strike_weather/weather_close_btn"] = "_control.weather_close_btn",
			["strike_weather/weather_info/weather_content"] = "_control.weather_content",
			["strike_weather/shadow_weather"] = "_control.shadow_weather",
			["strike_weather/weather_info/weather_name"] = "_control.weather_name"
		},
		click = {
			weather_close_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}
