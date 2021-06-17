usingnamespace @import("raylib");

const Game = struct {
    const fps : u8 = 60;
    const width : u16 = 800;
    const height : u16 = 600;
    const min_spd: f32 = 200;
    const max_spd: f32 = 800;

    const Ball = struct {
        x: f32,
        y: f32,
        hspeed: f32,
        vspeed: f32,
        size: f32 = 8.0,

        fn create () Ball {
            return Ball {
                .x = Game.width/2,
                .y = Game.height/2,
                .hspeed = -Game.min_spd,
                .vspeed = 000.0
            };
        }

        fn update (self:*Ball) void {
            self.x += GetFrameTime() * self.hspeed;
            self.y += GetFrameTime() * self.vspeed;
        }

        fn draw (self:Ball) void {
            DrawCircle(
                @floatToInt(i16, self.x),
                @floatToInt(i16, self.y),
                self.size,
                WHITE
            );
        }
    };

    pub fn app () void {
        InitWindow(Game.width, Game.height, "Pong Game");
        SetTargetFPS(Game.fps);

        var ball = Ball.create();
        var application = Game {
            .ball = &ball
        };

        while(!WindowShouldClose()){
            application.update();
            application.draw();
        }

        CloseWindow(); 
    }

    fn update(self:Game) void {
        self.ball.update();
    }
    
    fn draw(self:Game) void {
        BeginDrawing();

        ClearBackground(BLACK);
        self.ball.draw();

        EndDrawing();
    }

    ball : *Ball,
};

pub fn main() anyerror!void {
    Game.app();
}
