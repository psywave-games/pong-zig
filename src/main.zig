usingnamespace @import("raylib");

const Game = struct {
    const fps : u8 = 60;
    const width : u16 = 800;
    const height : u16 = 600;
    ball : Ball,

    const Ball = struct {
        x: i16,
        y: i16,
        hspeed: i16,
        vspeed: i16,
        size: f16 = 8.0,

        fn create () Ball {
            return Ball {
                .x = Game.width/2,
                .y = Game.height/2,
                .hspeed = 0.0,
                .vspeed = 0.0
            };
        }

        fn update (self:Ball) void {

        }

        fn draw (self:Ball) void {
            DrawCircle(self.x, self.y, self.size, WHITE);
        }
    };

    pub fn app () void {
        InitWindow(Game.width, Game.height, "Pong Game");
        SetTargetFPS(Game.fps);
        
        var application = Game {
            .ball = Ball.create()
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
};

pub fn main() anyerror!void {
    Game.app();
}
